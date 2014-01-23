/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.dbutils.QueryLoader;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.ApplicationDefinition;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.MenuItem;
import org.rti.zcore.Patient;
import org.rti.zcore.Site;
import org.rti.zcore.SortedProperties;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dao.OutcomeDAO;
import org.rti.zcore.dao.PatientDAO;
import org.rti.zcore.dao.PatientStatusDAO;
import org.rti.zcore.dynasite.utils.DynasiteUtils;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.rules.impl.OutcomeImpl;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.FileUtils;
import org.rti.zcore.utils.PatientRecordUtils;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.XmlUtils;
import org.rti.zcore.utils.sort.DisplayOrderComparator;
import org.rti.zcore.utils.struts.StrutsUtils;

/**
 * Created by IntelliJ IDEA.
 * User: ckelley
 * Date: May 16, 2005
 * Time: 4:55:49 PM
 * To change this template use File | Settings | File Templates.
 */
public final class DeleteEncounterAction extends BaseAction {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(DeleteEncounterAction.class);

	/**
	 * Special handling for form id 170 - user info form.
	 */
	protected ActionForward doExecute(ActionMapping mapping,
			ActionForm actionForm,
			HttpServletRequest request,
			HttpServletResponse response)
	throws Exception {

		HttpSession session = request.getSession();
		Site site = SessionUtil.getInstance(session).getClientSettings().getSite();
		Principal user = request.getUserPrincipal();
		String username = user.getName();
		Connection conn = null;

		Long encounterId = null;
        String userrecord = null;
		Long patientId = null;
		Long formId = null;
		String formName = null;
		Integer deps = null;
		String forwardString = null;	// Pass forward if you want to override the forward.
		if (request.getParameter("formId") != null) {
			formId = Long.valueOf(request.getParameter("formId"));
			formName = DynaSiteObjects.getFormIdClassNameMap().get(formId);
        }
        //formId = (Long) DynaSiteObjects.getFormNameMap().get(formName);
		if (request.getParameter("encounterId") != null) {
			//if (formName.equals("UserInfo")) {
        	//	userrecord = String.valueOf(request.getParameter("encounterId"));
        	//} else {
                encounterId = Long.valueOf(request.getParameter("encounterId"));
        	//}
		}
		if (request.getParameter("patientId") != null) {
			patientId = Long.valueOf(request.getParameter("patientId"));
		}

		if (request.getParameter("deps") != null) {
			deps = Integer.valueOf(request.getParameter("deps"));
		}
		if (request.getParameter("forward") != null) {
			forwardString = String.valueOf(request.getParameter("forward"));
		}

		Form form = (Form) DynaSiteObjects.getForms().get(Long.valueOf(formId));

		try {
			conn = DatabaseUtils.getZEPRSConnection(Constants.DATABASE_ADMIN_USERNAME);
			//if ((encounterId != null && formId != null) || formId == 170) {
			if (encounterId != null) {
				EncounterData encounter = null;
				try {
					//if (formName.equals("UserInfo")) {
					//	PatientRecordUtils.deleteUser(conn, userrecord);
					//} else {
					// If this is a MenuItem, save the MenuItem list to xml and refresh DynasiteObjects
					formName = form.getClassname();
					if (!formName.equals("MenuItem")){
						try {
							encounter = (EncounterData) EncountersDAO.getOneById(conn, encounterId);
						} catch (ObjectNotFoundException e) {
							// it's ok - may be an admin record.
						}
						String eventUuid = null;
						if (encounter != null) {
							if (patientId == null) {
								patientId = encounter.getPatientId();
							} else {
								if (encounter.getPatientId() == null) {
									// this is an admin form - probably a relationship.
									encounter.setPatientId(patientId);
								}
							}

							//Long eventId = encounter.getEventId();
							eventUuid = encounter.getEventUuid();
							formId = encounter.getFormId();
							// this could be an admin record, which is will not have patientId or pregnancyId
							if (patientId != null) {
								//PatientStatusReport psr = PatientStatusDAO.getOne(conn, patientId);
								Patient patient = PatientDAO.getOne(conn, patientId);
								//Long currentFlowEncounterId = patient.getCurrentFlowEncounterId();
								String currentFlowEncounterUuid = patient.getCurrentFlowEncounterUuid();
								if (formId.longValue() == 1) {
									String message = "You may not delete the patient registration record. " +
									"Delete the whole patient record instead by clicking the \"Delete Patient\" link\n" +
									"on the Demographics page.";
									request.setAttribute("exception", message);
									return mapping.findForward("error");
								}
								List outcomes = OutcomeDAO.getAllforEncounter(conn, encounterId);

								if (outcomes.size() > 0) {
									if (deps != null && deps.intValue() == 1) {
										for (int i = 0; i < outcomes.size(); i++) {
											OutcomeImpl outcome = (OutcomeImpl) outcomes.get(i);
											OutcomeDAO.deleteOne(conn, outcome.getId());
										}
									} else {
										String url = "/" + Constants.APP_NAME + "/admin/deleteEncounter.do;jsessionid=" + session.getId() +
										"?encounterId=" + encounterId + "&formId=" + formName + "&deps=1";
										String message = "<p>This record has system-generated problems.  " +
										"Are you sure you want to delete it?.</p>" +
										"<p><a href=\"" + url + "\">Delete</a></p>";
										request.setAttribute("exception", message);
										return mapping.findForward("error");
									}
								}

								// Test to see if you are deleting the most recent encounter.
								//if (encounterId.longValue() == currentFlowEncounterId.longValue()) {
								if (encounter.getUuid().equals(currentFlowEncounterUuid)) {
									// Find the previous encounter
									EncounterData encounterData = EncountersDAO.getPreviousEncounter(conn, patientId, eventUuid, encounterId);
									Long prevEncId = encounterData.getId();
									if (prevEncId != null) {
										// re-assign values in patient status
										Long currentFlowId = encounterData.getFlowId();
										Map queries = QueryLoader.instance().load("/" + Constants.SQL_PATIENT_PROPERTIES);
										String sqlUpdateStatus = (String) queries.get("SQL_MODIFY_STATUS");
										EncounterData vo = new EncounterData();    // dummy EncounterData is OK.
										vo.setUuid(encounterData.getUuid());
										PatientStatusDAO.updatePatientStatus(conn, vo, currentFlowId, prevEncId, username, site.getId(), patientId, sqlUpdateStatus);
									} else {
										String message = "Unable to delete this record - please contact the system administrator. ";
										request.setAttribute("exception", message);
										return mapping.findForward("error");
									}
								}
							}
						}

						EncounterData vo = new EncounterData();    // dummy EncounterData is OK.
						vo.setPatientId(patientId);
						//vo.setEventId(eventId);
						vo.setEventUuid(eventUuid);
						
						// DAR-specific code for stock and regimen-related forms - deletes only its associated table record
						if (formId == 128 || formId == 129 || formId == 130 || formId == 131 || formId == 181 ) {
					        deleteFromSingleTable(site, username, conn, encounterId, formId, encounter);
						} else {
							try {
								PatientRecordUtils.deleteEncounter(conn, formId, encounterId, username, site, vo, null);
							} catch (Exception e) {
								request.setAttribute("exception", e);
								return mapping.findForward("error");
							}	
						}
						
					} else {
						// If this is a MenuItem, save the MenuItem list to xml and refresh DynasiteObjects
						ArrayList<MenuItem> menuItemList = DynaSiteObjects.getMenuItemList();
						int index = 0;
						for (MenuItem menuItem : menuItemList) {
							if (encounterId.intValue() == menuItem.getId().intValue()) {
								index = menuItemList.indexOf(menuItem);
								//EncounterData encounterMenuItem = (EncounterData) EncountersDAO.getOne(conn, encounterId, "SQL_RETRIEVE_ONE_ADMIN" + formId, MenuItem.class);
								//MenuItem menuItem = (MenuItem) encounterMenuItem;
								String templateKey = menuItem.getTemplateKey();

								//ignore property files for spacer deletion
								if (templateKey != null) {
									Boolean dev = DynaSiteObjects.getDev();
									String pathName = null;
									String deployPathname = null;

									if (dev == true) {
										pathName = Constants.DEV_RESOURCES_PATH;
										deployPathname = Constants.DYNASITE_RESOURCES_PATH;
									} else {
										pathName = Constants.DYNASITE_RESOURCES_PATH;
									}

									SortedProperties properties = null;
									ApplicationDefinition applicationDefinition = DynaSiteObjects.getApplicationDefinition();
									ArrayList<String> localeList = applicationDefinition.getLocalList();;
									//loop through all property fields and delete this property
									if (applicationDefinition != null){
										localeList = applicationDefinition.getLocalList();
										properties = new SortedProperties();
										for (String locale : localeList) {
											try {
												properties.load(new FileInputStream(pathName + Constants.MENU_ITEM_FILENAME + "_" + locale + ".properties"));
												properties.remove(templateKey);
												properties.store(new FileOutputStream(pathName + Constants.MENU_ITEM_FILENAME + "_" + locale + ".properties"), "Deletion by admin");
												properties.clear();
											} catch (Exception e) {
											}
										}
										properties.clear();
										String defaultLocale = applicationDefinition.getDefaultLocale();
										if (defaultLocale != null) {
											try {
												properties.load(new FileInputStream(pathName + Constants.MENU_ITEM_FILENAME + "_" + defaultLocale + ".properties"));
												properties.remove(templateKey);
												properties.store(new FileOutputStream(pathName + Constants.MENU_ITEM_FILENAME + "_" + defaultLocale + ".properties"), "Deletion by admin");
												properties.clear();
											} catch (FileNotFoundException e) {
												// not created yet.
											}
										}
										properties.clear();
										properties.load(new FileInputStream(pathName + Constants.MENU_ITEM_FILENAME + ".properties"));
										properties.remove(templateKey);
										properties.store(new FileOutputStream(pathName + Constants.MENU_ITEM_FILENAME + ".properties"), "Deletion by admin");
										properties.clear();
									}

									//Properties properties = new Properties();
									String selectedLocale = (String) request.getAttribute("defaultLocale");

									boolean isDefaultLocale = false;
									try {
										properties.load(new FileInputStream(pathName + Constants.MENU_ITEM_FILENAME + "_" + selectedLocale + ".properties"));
										//isDefaultLocale = true;
									} catch (FileNotFoundException e) {
										try {
											properties.load(new FileInputStream(pathName + Constants.MENU_ITEM_FILENAME + ".properties"));
										} catch (FileNotFoundException e1) {
											e.printStackTrace();
										}
									}
									properties.remove(templateKey);
									properties.store(new FileOutputStream(pathName + Constants.MENU_ITEM_FILENAME + (isDefaultLocale?  "_" + selectedLocale : "") + ".properties"), "New Entry");

									// copy to tomcat as well if in dev mode
									if (dev) {
										for (String locale : localeList) {
											try {
												FileUtils.copyQuick(pathName + Constants.MENU_ITEM_FILENAME +  "_" + locale + ".properties",
														deployPathname + Constants.MENU_ITEM_FILENAME + "_" + locale +  ".properties");
											} catch (Exception e) {
											}
											try {
												FileUtils.copyQuick(pathName + Constants.MENU_ITEM_FILENAME + ".properties",
														deployPathname + Constants.MENU_ITEM_FILENAME + ".properties");
											}catch (Exception e){
												e.printStackTrace();
											}
										}
									}
								}
							}
						}
						menuItemList.remove(index);
						DisplayOrderComparator doc = new DisplayOrderComparator();
						Collections.sort(menuItemList, doc);
						DynasiteUtils.refreshMenuItemList();
					}
					//}

					// part of reload prevention scheme:
					resetToken(request);
					StrutsUtils.removeFormBean(mapping, request);
					// return mapping.findForward("patientHome");
					ActionForward forwardForm = null;
					if (forwardString != null) {
						forwardForm = new ActionForward(forwardString);
						forwardForm.setRedirect(true);
					} else {
						forwardForm = StrutsUtils.getActionForward("deleteEncounter", patientId, form);
					}
					return forwardForm;
				} catch (ServletException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (ObjectNotFoundException e) {
					// already deleted or missing - simply send back to home.
					return mapping.findForward("home");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("exception", e);
			return mapping.findForward("error");
		} finally {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		}
		return mapping.findForward("success");
	}

	
	/**
	 * DAR-specific code for stock and regimen-related forms - deletes only its associated table record
	 * Saves xml backup in Constants.ARCHIVE_PATH + siteAbbrev + "/deletions/" + "enc" 
	 * @param site
	 * @param username
	 * @param conn
	 * @param encounterId
	 * @param formId
	 * @param encounter
	 * @throws SQLException
	 * @throws IOException
	 * @throws Exception
	 */
	public void deleteFromSingleTable(Site site, String username, Connection conn, Long encounterId, Long formId, EncounterData encounter) throws SQLException, IOException, Exception {
		Timestamp dateDeleted = new Timestamp(System.currentTimeMillis());
		String siteAbbrev = site.getAbbreviation();
		if (encounter != null) {
		    String fileName = org.rti.zcore.Constants.ARCHIVE_PATH + siteAbbrev + "/deletions/" + "enc" + encounter.getId() + ".xml";
		    XmlUtils.save(encounter, fileName);
		}
		Form encounterForm = (Form) DynaSiteObjects.getForms().get(formId);
		String tableName = encounterForm.getName().toLowerCase();

		String result = null;
		Statement stmt = null;
		ArrayList values = null;
		String sql = null;
		int results = 0;
		conn.setAutoCommit(false);
		sql = "START TRANSACTION;";
		// Don't do this in Derby - not necessary
		if (Constants.DATABASE_TYPE.equals("mysql")) {
			DatabaseUtils.create(conn, sql);
		}
		stmt = conn.createStatement();
		try {
			sql = "DELETE FROM " + tableName.toLowerCase() + "\n" +
					"WHERE " + tableName.toLowerCase() + ".id = ? ";
			values = new ArrayList();
			values.add(encounterId);
			results = DatabaseUtils.update(conn, sql, values.toArray());
			if (results >0) {
				result = "Encounter deleted.";
			}
			conn.commit();
		} catch (Exception e) {
			//   stmt.execute("ROLLBACK;");
			log.error(e);
			if (Constants.DATABASE_TYPE.equals("mysql")) {
				sql = "ROLLBACK";
				DatabaseUtils.create(conn, sql);
			} else {
				conn.rollback();
			}
			throw new SQLException("Error deleting this record.", e.getMessage());
		} finally {
			conn.setAutoCommit(true);
		}
	}

}

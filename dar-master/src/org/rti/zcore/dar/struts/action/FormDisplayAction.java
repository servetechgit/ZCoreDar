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

import java.io.IOException;
import java.security.Principal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.validator.DynaValidatorForm;
import org.rti.zcore.BaseEncounter;
import org.rti.zcore.Constants;
import org.rti.zcore.DropdownItem;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.FormField;
import org.rti.zcore.PageItem;
import org.rti.zcore.Patient;
import org.rti.zcore.Site;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dao.PatientBridgeTableDAO;
import org.rti.zcore.dao.RelationshipDAO;
import org.rti.zcore.dar.DarSessionSubject;
import org.rti.zcore.dar.gen.PatientItem;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.RegimenUtils;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.struts.action.generic.BasePatientAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.FormUtils;
import org.rti.zcore.utils.PatientRecordUtils;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.WidgetUtils;
import org.rti.zcore.utils.struts.i18n.ReloadablePropertyMessageResources;

/**
 * Action which locates the requested Form and passes it to the JSP for rendering.
 */

public final class FormDisplayAction extends BasePatientAction {

    /**
     * Commons Logging instance.
     */

    private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

    protected ActionForward doExecute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        /*if (SystemStateManager.getCurrentState() != SystemStateManager.STATUS_NORMAL) {
            return mapping.findForward(LOCKED_FORWARD);
        }*/

        HttpSession session = request.getSession();
        Principal user = request.getUserPrincipal();
        Locale locale = getLocale(request);
        Locale sessionLocale = (Locale) request.getAttribute("sessionLocale");
        String sessionLocaleString = null;
        if ((sessionLocale.getLanguage() != null) && ((sessionLocale.getCountry()!= null) && (!sessionLocale.getCountry().equals("")))) {
        	sessionLocaleString = sessionLocale.getLanguage() + "_" + sessionLocale.getCountry();
        }
        else if (sessionLocale.getLanguage() != null) {
        	sessionLocaleString = sessionLocale.getLanguage();
        }
        String username = user.getName();
        Connection conn = null;
        Form encounterForm;
        BaseEncounter encounter = null;
        Map encMap = null;
        try {
            conn = DatabaseUtils.getZEPRSConnection(username);

            String formName = null;
            String encounterIdString = "";

            if (mapping.getParameter() != null && !mapping.getParameter().equals("")) {
            	formName = mapping.getParameter();
                if (request.getAttribute("encounterId") != null) {
                    encounterIdString = request.getAttribute("encounterId").toString();
                }
            } else {
            	formName = request.getAttribute("id").toString();
            }

            // Sometimes encounterId is sent in url
            if (request.getParameter("encounterId") != null) {
                encounterIdString = request.getParameter("encounterId").toString();
            }

            DarSessionSubject sessionPatient = null;
            Long patientId = null;
            //Long eventId = null;
            String eventUuid = null;

            if (request.getParameter("next") != null) {
                String next = request.getParameter("next");
                request.setAttribute("next", next);
            }

            String fixName = StringManipulation.fixClassname(formName);
            Long formId = (Long) DynaSiteObjects.getFormNameMap().get(fixName);
            encounterForm = ((Form) DynaSiteObjects.getForms().get(new Long(formId)));

            String siteId = "";
            try {
                siteId = SessionUtil.getInstance(session).getClientSettings().getSiteId().toString();
            } catch (SessionUtil.AttributeNotFoundException e) {
                // it's ok - we're in admin mode.
            }

            if (! formName.equals("PatientRegistration") && ! formName.equals("PerpetratorDemographics") && encounterForm.getFormTypeId() != 5) {
                try {
                    sessionPatient = (DarSessionSubject) SessionUtil.getInstance(session).getSessionPatient();
                    patientId = sessionPatient.getId();
                    //eventId = sessionPatient.getCurrentEventId();
                    eventUuid = sessionPatient.getCurrentEventUuid();
                } catch (SessionUtil.AttributeNotFoundException e) {
                    log.error("Unable to get SessionSubject for " + formName);
                }
            } else {
                if (request.getParameter("patientId") != null) {
                    patientId = Long.valueOf(request.getParameter("patientId"));
                    try {
                        sessionPatient = (DarSessionSubject) SessionUtil.getInstance(session).getSessionPatient();
                    } catch (SessionUtil.AttributeNotFoundException e) {
                        log.error("Unable to get TimsSessionSubject");
                    }
                    //eventId = sessionPatient.getCurrentEventId();
                    eventUuid = sessionPatient.getCurrentEventUuid();
                }
            }

            HashMap visiblePageItems = new HashMap();
            if (request.getParameter("id") != null) {
                encounterIdString = request.getParameter("id");
            }
            boolean drugList = false;

            String newform = "";
            if (request.getAttribute("newform") != null) {
                newform = (String) request.getAttribute("newform");
            }



            // Editing a form?
            if (!encounterIdString.equals("")) {
                Long encounterId = new Long(encounterIdString);
                String className = Constants.getDynasiteFormsPackage() + "." + StringManipulation.fixClassname(encounterForm.getName());
                Class clazz = null;
                try {
                    clazz = Class.forName(className);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }

                if (encounterForm.getFormTypeId() == 6) {	// patient bridge table form
                	encounter = PatientBridgeTableDAO.getEncounter(conn, encounterForm, formId, encounterId, clazz);
                	Long encSiteId = encounter.getSiteId();
                	if (encSiteId != null) {
                		Site site = (Site) DynaSiteObjects.getClinicMap().get(encSiteId);
                		if (site != null) {
                			encounter.setSiteName(site.getName());
                		}
                	}
                } else {
                	try {
                        encounter = populateEncounterI18n(request, sessionLocale, sessionLocaleString, conn, encounterForm, formId, encounterId, clazz);
                        encMap = PatientRecordUtils.getEncounterMap(encounterForm, encounter, "fieldId");
                        encounter.setEncounterMap(encMap);
                    } catch (ObjectNotFoundException e) {
                        String errorMessage = "<p>An error has occurred. The system was unable to retrieve the requested record. " +
                                "Please press the \"Back\" button and try another link.</p>" +
                                "<p>This error has been logged by the system.</p>";
                        String logMessage = errorMessage +
                                "\n * Code is from FormDisplayAction." +
                                "\n * Debug: encounterId: " + encounterId + ", class: " + clazz + "Error: " + e;
                        log.error(logMessage);
                        log.error(e);
                        request.setAttribute("exception", errorMessage);
                        return mapping.findForward("error");
                    }

                    DynaValidatorForm dynaForm = (DynaValidatorForm) form;
                    // used to store values used in multiselect tag
                    HashMap multiValues = new HashMap();

                    // Section Map is used to reveal hidden fields that have values
                    // Should reveal all values in case user needs to enter data for one of the hidden fields
                    Map formSection = (Map) DynaSiteObjects.getFormSections().get(encounterForm.getId());
                    Map formDependencies = (Map) DynaSiteObjects.getFormDependencies().get(encounterForm.getId());
                    Map collapsingSections = (Map) DynaSiteObjects.getCollapsingSections().get(encounterForm.getId());
                    Map collapsingDependencies = (Map) DynaSiteObjects.getCollapsingDependencies().get(encounterForm.getId());
                    // Loop through the pageItems and use the encounterMap to identify the pageItems that have values
                    // If it has a value, use the sectionMap to make that section visible.
                    Long section = null;
                    Long collapsingTableId = null;
                    // Set newPageItems = new TreeSet(new DisplayOrderComparator());
                    for (Iterator iterator = encounterForm.getPageItems().iterator(); iterator.hasNext();) {
                        PageItem pageItem = (PageItem) iterator.next();
                        // createPageItem(pageItem);
                        String value = null;
                        Long collapsingSectionId = null;
                        if (pageItem.getForm_field().isEnabled() == true) {
                            // Find which section the field is in
                            try {
                                section = (Long) formDependencies.get(pageItem.getForm_field().getId());
                            } catch (Exception e) {
                                // it's ok
                            }
                            // Is it in a collapsingSection?
                            try {
                                collapsingSectionId = (Long) collapsingDependencies.get(pageItem.getForm_field().getId());
                                if (collapsingSectionId != null) {
                                    ArrayList collapsingSection = (ArrayList) collapsingSections.get(collapsingSectionId);
                                    //the table that is dependent upon the collapsing table if the second item in the list.
                                    collapsingTableId = (Long) collapsingSection.get(1);
                                }
                                // collapsingTableId = (Long) formDependencies.get(collapsingSection);
                            } catch (Exception e) {
                                // it's ok
                            }

                            String fieldName = null;
                            FormField formField = pageItem.getForm_field();
                            /*Long currentId = formField.getId();
                            if (formField.getImportId() != null) {
                            	currentId = formField.getImportId();
                        	}
                            if (formField.getImportId() != null) {
                                fieldName = "field" + currentId;
                        	} else {*/
                                //fieldName = StringManipulation.firstCharToLowerCase(formField.getStarSchemaName());
                                fieldName = formField.getIdentifier();
                        	//}
                            value = (String) encMap.get(fieldName);
                            // value = BeanUtils.getProperty(encounter, "field" + pageItem.getForm_field().getId());
                            // Do not need to set property  if it's null
                            if (value != null) {
                                if (!pageItem.getForm_field().getType().equals("Display")) {
                                    dynaForm.set(fieldName, value);
                                }
                                // Use the sectionMap to make that section visible if necessary.
                                if ((!pageItem.isVisible()) & (section != null)) {
                                    // pageItem.setVisible(true);
                                    visiblePageItems.put("pageItem" + pageItem.getId(), "visible");
                                }
                                // Use the sectionMap to make that collapsingSection visible if necessary.
                                if (collapsingTableId != null) {
                                    visiblePageItems.put("pageItem" + collapsingTableId, "visible");
                                }

                                // also set its sister fields in the section to true
                                // loop through the formSection, matching the masterId
                                List deps = (List) formSection.get(section);
                                if (deps != null) {
                                    for (int i = 0; i < deps.size(); i++) {
                                        Long depId = (Long) deps.get(i);
                                        PageItem depPageItem = (PageItem) DynaSiteObjects.getPageItems().get(depId);
                                        // depPageItem.setVisible(true);
                                        visiblePageItems.put("pageItem" + pageItem.getId(), "visible");
                                    }
                                }

                            }

                            // Make all hidden fields visible
                            if (!pageItem.isVisible()) {
                                // pageItem.setVisible(true);
                                visiblePageItems.put("pageItem" + pageItem.getId(), "visible");
                            }

                            if (pageItem.getInputType().equals("druglist")) {
                                drugList = true;
                            }

                            if (pageItem.getInputType().equals("multiselect_enum")) {
                                List masterList = new ArrayList();
                                //multiValues.put(currentId, masterList);
                                multiValues.put(fieldName, masterList);
                            }

                            // populate the multiHelper array
                            // each field in which the multiselect widget stores data has the multiselect widget field id in the
                            // visibleDependencies1 property

                            if (pageItem.getInputType().equals("multiselect_item")) {
                                List itemList = null;
                                String visDeps1 = pageItem.getVisibleDependencies1();
                                if (visDeps1 != null) {
                                    try {
                                        itemList = (List) multiValues.get(new Long(visDeps1));
                                    } catch (NullPointerException e) {
                                        e.printStackTrace();  // multiselect_enum not exist, or out of order.
                                    }
                                } else {
                                    String error = "multiselect widget setup error - select the widget id for this field's visible deps1.";
                                    log.error(error);
                                    request.setAttribute("exception", error);
                                    return mapping.findForward("error");
                                }

                                value = BeanUtils.getProperty(encounter, fieldName);
                                if (value != null) {
                                    //multifields.append(value+ ",");
                                    itemList.add(value);
                                    //multiValues.put(pageItem.getVisibleDependencies1(), itemList);
                                }
                            }
                        }
                    }
                    request.setAttribute("multiValues", multiValues);
                }

                request.setAttribute(SUBJECT_KEY, encounter);

                Date dateVisit = encounter.getDateVisit();
                request.setAttribute("dateVisit", dateVisit);
                // used for remote widgets
                request.setAttribute("className", className);
                // loading of body onload DWRUtil.useLoadingMessage()
                request.setAttribute("dwr", 1);
            } else {
                if (sessionPatient != null && sessionPatient.getDead() != null && sessionPatient.getDead().equals(Boolean.TRUE)) {
                	String forwardString = null;
                	if (sessionPatient != null) {
    					//Long flowId = sessionPatient.getCurrentFlowId();
    					Long flowId = encounterForm.getFlowId();
    					if (flowId.intValue() == 2) {
    						forwardString = "/PatientItem/list.do";
    					} else {
            				forwardString = "/patientTask.do?flowId=" + flowId.toString();
    					}
    				} else {
        				forwardString = "/home.do";
    				}
                	ActionForward forwardForm = null;
                	forwardForm = new ActionForward(forwardString);
            		forwardForm.setRedirect(true);
            		return forwardForm;
                }
            }

            if (visiblePageItems.size() > 0) {
                request.setAttribute("visiblePageItems", visiblePageItems);
            }

            request.setAttribute("encounterForm", encounterForm);

            List drugs = DynaSiteObjects.getDrugs();
            request.setAttribute("drugs", drugs);

            List sites = DynaSiteObjects.getClinics();
            request.setAttribute("sites", sites);

            String patientSiteId = SessionUtil.getInstance(session).getClientSettings().getSiteId().toString();
            Site site = (Site) DynaSiteObjects.getClinicMap().get(new Long(patientSiteId));
            Integer siteTypeId = site.getSiteTypeId();
            String siteAlphaId = site.getSiteAlphaId().substring(0, 2);
            String clinicId = site.getSiteAlphaId().substring(2, 3);
            request.setAttribute("siteAlphaId", siteAlphaId);
            request.setAttribute("clinicId", clinicId);
            request.setAttribute("siteTypeId", siteTypeId);
            request.setAttribute("patientSiteId", patientSiteId);

            if ((encounterIdString.equals(""))) {
                // See if this form has 1 MaxSubmissions
                int maxSubmissions = encounterForm.getMaxSubmissions();
                Boolean startNewEvent = encounterForm.getStartNewEvent();
                if (maxSubmissions == 1) {
                	if (startNewEvent != null && startNewEvent == true) {
                		// start a new Event
                	} else {
                		EncounterData encounterOneOnly = null;
                        try {
                        	encounterOneOnly = (EncounterData) EncountersDAO.getId(conn, patientId, eventUuid, new Long(formId));
                            Long encounterId = encounterOneOnly.getId();
                            ActionForward forwardForm = null;
                            forwardForm = new ActionForward("/viewEncounter.do?patientId=" + patientId + "&id=" + encounterId);
                            forwardForm.setRedirect(true);
                            return forwardForm;
                            // send to the record view of this form.
                        } catch (ObjectNotFoundException e1) {
                            // it's ok - form not submitted yet.
                        }
                	}
                }

                // patient registration needs sex to be pre-filled to female
                if (encounterForm.getId().intValue() == 1) {
                    DynaValidatorForm dynaForm = (DynaValidatorForm) form;
                    dynaForm.set("sex", "1");
                }
            }

            List yearList = DateUtils.getYearList();
            request.setAttribute("yearList", yearList);

            // Process the dynamic dropdown lists.
            HashMap listMap = new HashMap();
            Form inlineForm = null;
            for (Iterator iterator = encounterForm.getPageItems().iterator(); iterator.hasNext();) {
                PageItem pageItem = (PageItem) iterator.next();
                FormField formField = pageItem.getForm_field();
                String identifier = formField.getIdentifier();

                if (pageItem.getInputType().equals("dropdown") || pageItem.getInputType().equals("dropdown-add-one") || pageItem.getInputType().equals("dropdown_site")) {
                	List list = WidgetUtils.getList(conn, pageItem.getDropdownTable(), pageItem.getDropdownColumn(), pageItem.getDropdownConstraint(), pageItem.getDropdownOrderByClause(), DropdownItem.class, pageItem.getFkIdentifier());
                	// Process PatientItem later.
                	if (!formName.equals("PatientItem")) {
                		listMap.put(pageItem.getId(), list);
                	}
                	if (pageItem.getInputType().equals("dropdown-add-one")) {
                		String classNameString = StringManipulation.fixClassname(pageItem.getDropdownTable());
                        Long inlineFormId = (Long) DynaSiteObjects.getFormNameMap().get(classNameString);
                        inlineForm = ((Form) DynaSiteObjects.getForms().get(new Long(inlineFormId)));
                        // Create a list of fieldnames for inline forms.
                        ArrayList<String> inlineFields = new ArrayList<String>();
                        for (Iterator iterator2 = inlineForm.getPageItems().iterator(); iterator2.hasNext();) {
                        	PageItem pageItem2 = (PageItem) iterator2.next();
                            if (pageItem2.getForm_field().isEnabled() == true && !pageItem2.getForm_field().getType().equals("Display")) {
                            	inlineFields.add(pageItem2.getForm_field().getIdentifier());
                            }
                        }
                        request.setAttribute("inlineForm_"+identifier, inlineForm);
                        request.setAttribute("inlineFields_"+identifier, inlineFields);
                        // loading of body onload DWRUtil.useLoadingMessage()
                        request.setAttribute("dwr", 1);
                	}
                }
            }
            // For DAR/ART care form 132
            if (formName.equals("PatientItem")) {
            	// Fetch the patient's regimen.
                Long regimenId = sessionPatient.getRegimenId();
                String regimenName = sessionPatient.getRegimenName();
                List<PatientItem> items = RegimenUtils.getAllItemsForRegimen(conn, regimenId);
                // now construct a list of items for the dropdown.
                // We'll replace the one that was just created.
                HashMap<Long,StockReport> balanceMap = null;
                if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
					balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
                }
                List list = new ArrayList();
                for (PatientItem regimenItem_bridge : items) {
					Long itemId = regimenItem_bridge.getItem_id();
					DropdownItem item = null;
					try {
						item = RegimenUtils.getItemForRegimen(conn, itemId);
						//StockControl tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId, Integer.valueOf(siteId));
						if (balanceMap != null) {
							StockReport stockReport = balanceMap.get(itemId);
							Integer balance = 0;
							if (stockReport != null) {
								balance = stockReport.getBalanceBF();
							}
							if (balance <= 0) {
								/*String value = item.getDropdownValue();
								item.setDropdownValue(value + " ** Out of Stock ** Bal: " + balance);*/
							} else {
								String value = item.getDropdownValue();
								item.setDropdownValue(value + " Bal: " + balance);
								list.add(item);
							}
						}
					} catch (Exception e) {
						log.debug("Unable to fetch item for regimen: "  + regimenName + " regimenId: " + regimenId + " itemId: " + itemId);
					}
                }
                if (sessionPatient.getChild() != null && sessionPatient.getChild() == true) {
                    List<DropdownItem> paedsItems = RegimenUtils.getPaediatricSingleDrugItems(conn);
                    for (DropdownItem dropdownItem : paedsItems) {
    					StockReport stockReport = balanceMap.get(Long.valueOf(dropdownItem.getDropdownId()));
    					Integer balance = 0;
    					if (stockReport != null) {
    						balance = stockReport.getBalanceBF();
    					}
    					if (balance <= 0) {
    					} else {
    						String value = dropdownItem.getDropdownValue();
    						dropdownItem.setDropdownValue(value + " Bal: " + balance);
    						list.add(dropdownItem);
    					}
    				}
                }
                List<DropdownItem> otherItems = RegimenUtils.getOtherDropdownItems(conn);
                for (DropdownItem dropdownItem : otherItems) {
					StockReport stockReport = balanceMap.get(Long.valueOf(dropdownItem.getDropdownId()));
					Integer balance = 0;
					if (stockReport != null) {
						balance = stockReport.getBalanceBF();
					}
					if (balance <= 0) {
					} else {
						String value = dropdownItem.getDropdownValue();
						dropdownItem.setDropdownValue(value + " Bal: " + balance);
						list.add(dropdownItem);
					}
				}
                //list.addAll(otherItems);
                if (list.size() > 0) {
                	listMap.put(Long.valueOf(4376), list);
                }
            }
            request.setAttribute("listMap", listMap);

            if (encounterForm.getRecordsPerEncounter() != null && encounterForm.getRecordsPerEncounter() > 0) {
            	if (encounterForm.getResizedForPatientBridge()== null) {
            		FormUtils.createBridgeTablePageItems(encounterForm);
            	}
            }

            if (sessionPatient != null && sessionPatient.getPatientType() == 2) {
            	List<Patient> clientList = RelationshipDAO.getRelationshipToUuid2(conn, sessionPatient);
            	request.setAttribute("relationshipList", clientList);
            }

            // Keep this block at the end - it sets sessionPatient to null in certain circumstances.
            // Set the tasklist for particular circumstances. First check if the form requires a patient or if "id" is in the reqiest.
            if ((encounterForm.isRequirePatient() || ((request.getParameter("id") != null)))) {
                // we don't need the tasklist if we're just editing a form or it's in unassigned flow
                Long unassigned = new Long("100");
                if (request.getParameter("id") == null) {
                    if (!encounterForm.getFlow().getId().equals(unassigned)) {
                         // moved code for form 66 below.
                    }
                }
                Boolean status = Boolean.valueOf(true);
                /*if (eventUuid == null) {
                    return mapping.findForward("home");
                }*/
                List activeProblems = PatientRecordUtils.assembleProblemTaskList(conn, patientId, eventUuid, status, sessionPatient);
                request.setAttribute("activeProblems", activeProblems);
                // now get inactive problems
                status = Boolean.valueOf(false);
                List inactiveProblems = PatientRecordUtils.assembleProblemTaskList(conn, patientId, eventUuid, status, sessionPatient);
                request.setAttribute("inactiveProblems", inactiveProblems);
                // Display task list if editing form 1.
            } else if ((encounterForm.getId().intValue() == 1) & (patientId != null)) {
                Boolean status = Boolean.valueOf(true);
                List activeProblems = PatientRecordUtils.assembleProblemTaskList(conn, patientId, eventUuid, status, sessionPatient);
                request.setAttribute("activeProblems", activeProblems);
                // now get inactive problems
                status = Boolean.valueOf(false);
                List inactiveProblems = PatientRecordUtils.assembleProblemTaskList(conn, patientId, eventUuid, status, sessionPatient);
                request.setAttribute("inactiveProblems", inactiveProblems);
            } else if ((formName.equals("PerpetratorDemographics")) & (patientId != null)) {
            	Boolean status = Boolean.valueOf(true);
            	List activeProblems = PatientRecordUtils.assembleProblemTaskList(conn, patientId, eventUuid, status, sessionPatient);
            	request.setAttribute("activeProblems", activeProblems);
            	// now get inactive problems
            	status = Boolean.valueOf(false);
            	List inactiveProblems = PatientRecordUtils.assembleProblemTaskList(conn, patientId, eventUuid, status, sessionPatient);
            	request.setAttribute("inactiveProblems", inactiveProblems);
                // otherwise reset sessionPatient
            } else {
                SessionUtil.getInstance(session).setSessionPatient(null);
            }

        } catch (ServletException e) {
            log.error(e);
        } finally {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        }

        encounterForm = null;

        return mapping.findForward("success");

    }

	/**
	 * gets encounter and adds locale-specific messages.
	 * @param request
	 * @param sessionLocale
	 * @param sessionLocaleString
	 * @param conn
	 * @param encounterForm
	 * @param formId
	 * @param encounterId
	 * @param clazz
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	public static BaseEncounter populateEncounterI18n(HttpServletRequest request, Locale sessionLocale,
			String sessionLocaleString, Connection conn, Form encounterForm, Long formId, Long encounterId, Class clazz)
			throws IOException, ServletException, SQLException, ObjectNotFoundException {
		BaseEncounter encounter;
		String messageKey = encounterForm.getClassname()+"Messages";
		ReloadablePropertyMessageResources messages = (ReloadablePropertyMessageResources) request.getAttribute(messageKey);
		encounter = (BaseEncounter) EncountersDAO.getOneById(conn, encounterId, new Long(formId), clazz);
		encounter.setSessionLocale(sessionLocaleString);
		HashMap messageResourcesMap = messages.getMessages();
		HashMap localeMap = messages.getLocales();
		if (localeMap.get(sessionLocale.toString()) == null) {
			messages.loadLocale(sessionLocale.toString());
		}
		if (messageResourcesMap != null) {
			encounter.setMessageResourcesMap(messageResourcesMap);
		}
		return encounter;
	}

	/**
     * Provides a list of values for extended Lab tests (forms 101-104)
     * @param extendedLab
     * @param delimiter
     * @return String
     */
    public static String getEncounterValues(EncounterData extendedLab, String delimiter) {
        StringBuffer sb = new StringBuffer();
        Set extLabSet = extendedLab.getEncounterMap().entrySet();
        for (Iterator iterator = extLabSet.iterator(); iterator.hasNext();) {
            Map.Entry entry = (Map.Entry) iterator.next();
            String key = (String) entry.getKey();
            String value = (String) entry.getValue();
            if (!key.equals("labtest_idR")) {
                int index = key.length();
                sb.append(key.substring(0, index - 1));
                sb.append(":");
                sb.append(value);
                if (delimiter.equals("br")) {
                    sb.append("<br/>");
                } else {
                    sb.append("; ");
                }

            }
        }
        return sb.toString();
    }
}

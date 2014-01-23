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

import java.security.Principal;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.Task;
import org.rti.zcore.dar.dao.PatientSearchDAO;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.SessionUtil;


/**
 * Sets up the home page after user logs in.
 */

public final class HomeAction extends BaseAction {

    /**
     * Commons Logging instance.
     */
    private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

    /**
     * Build the ZEPRS home page, incorporating the search interface/results
     * if it's a report-only user, send to reports
     * otherwise, send to permissions page.
     *
     * @param mapping  The ActionMapping used to select this instance
     * @param form     The optional ActionForm bean for this request (if any)
     * @param request  The HTTP request we are processing
     * @param response The HTTP response we are creating
     * @return Action to forward to
     * @throws Exception if an input/output error or servlet exception occurs
     */
    protected ActionForward doExecute(ActionMapping mapping,
                                      ActionForm form,
                                      HttpServletRequest request,
                                      HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        Principal user = request.getUserPrincipal();
        String username = user.getName();
        Integer maxRows = 0;
		Integer offset = 0;
		Integer prevRows = 0;
		Integer nextRows = 0;
        Connection conn = null;
        try {
            conn = DatabaseUtils.getZEPRSConnection(username);
            if (request.isUserInRole("VIEW_INDIVIDUAL_PATIENT_RECORDS") || request.isUserInRole("CREATE_NEW_PATIENTS_AND_SEARCH"))
            {
                String searchStringRequest = request.getParameter("search_string");
                String firstSurname = request.getParameter("first_surname");  // used in a-z search
                String labour = request.getParameter("labour");  // used in a-z search
                String searchType = "keyword";
                String searchString = "";
                if (searchStringRequest == null) {
                	searchString = "";
                } else {
                	searchString = searchStringRequest.trim().toLowerCase();
                }
                if (firstSurname != null && !firstSurname.equals("")) {
                    searchType = "firstSurname";
                    searchString = firstSurname;
                    request.setAttribute("firstSurname", firstSurname);
                }
                request.setAttribute("searchString", searchString);
                String patientSiteId = SessionUtil.getInstance(session).getClientSettings().getSiteId().toString();
                request.setAttribute("patientSiteId", patientSiteId);

                String site = request.getParameter("site");
                request.setAttribute("site", site);
                if (site != null) {
                    if (site.equals("")) {
                        site = patientSiteId;
                    }
                }
                if (request.getParameter("maxRows") != null) {
    				maxRows = Integer.decode(request.getParameter("maxRows"));
    			} else if (request.getAttribute("maxRows") != null) {
    				maxRows = Integer.decode(request.getAttribute("maxRows").toString());
    			} else {
    				maxRows = 20;
    			}
    			if (request.getParameter("offset") != null) {
    				offset = Integer.decode(request.getParameter("offset"));
    			} else if (request.getAttribute("offset") != null) {
    				offset = Integer.decode(request.getAttribute("offset").toString());
    			}
    			if (request.getParameter("prevRows") != null) {
    				prevRows = Integer.decode(request.getParameter("prevRows"));
    				offset = prevRows;
    			} else if (request.getAttribute("prevRows") != null) {
    				prevRows = Integer.decode(request.getAttribute("prevRows").toString());
    				offset = prevRows;
    			}
    			if (request.getParameter("nextRows") != null) {
    				nextRows = Integer.decode(request.getParameter("nextRows"));
    			} else if (request.getAttribute("nextRows") != null) {
    				nextRows = Integer.decode(request.getAttribute("nextRows").toString());
    			}
                if (site == null) {
                    site = patientSiteId;
                }
                List results = null;
                results = PatientSearchDAO.getResults(conn, site, searchString, offset, maxRows, searchType, 0, username);
                request.setAttribute("results", results);

                request.setAttribute("maxRows", maxRows);
    			nextRows = offset + maxRows;
    			if (results.size() < maxRows) {
    				if (offset == 0) {
    					request.setAttribute("noNavigationWidget", "1");
    				}
    			} else {
    				request.setAttribute("offset", nextRows);
    			}

    			if (offset-maxRows >=0) {
    				prevRows = offset-maxRows;
    				request.setAttribute("prevRows", prevRows);
    			}
    			request.setAttribute("nextRows", nextRows);
                SessionUtil.getInstance(session).setSessionPatient(null);

                List sites = null;
                sites = DynaSiteObjects.getClinics();//
                request.setAttribute("sites", sites);

                if (SessionUtil.getInstance(request.getSession()).isClientConfigured()) {
                    String sitename = SessionUtil.getInstance(session).getClientSettings().getSite().getName();
                    request.setAttribute("sitename", sitename);
                } else {
                    request.setAttribute("sitename", "Configure PC: ");
                }
                String fullname = null;
                try {
                    fullname = SessionUtil.getInstance(session).getFullname();
                } catch (SessionUtil.AttributeNotFoundException e) {
                    // ok
                }
                //List activeProblems = PatientRecordUtils.assembleProblemTaskList(conn);
                //List<Task> stockAlertList = PatientRecordUtils.getStockAlerts();
                List<Task> stockAlertList = null;
                if (DynaSiteObjects.getStatusMap().get("stockAlertList") != null) {
                	stockAlertList = (List<Task>) DynaSiteObjects.getStatusMap().get("stockAlertList");
            	}
                request.setAttribute("activeProblems", stockAlertList);
                request.setAttribute("fullname", fullname);
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                    conn = null;
                }
                return mapping.findForward("success");
            } else if (request.isUserInRole("VIEW_SELECTED_REPORTS_AND_VIEW_STATISTICAL_SUMMARIES")) {
            	if (conn != null && !conn.isClosed()) {
                    conn.close();
                    conn = null;
                }
                return mapping.findForward("reports");
            } else if (request.isUserInRole("CREATE_MEDICAL_STAFF_IDS_AND_PASSWORDS_FOR_MEDICAL_STAFF")) {
            	if (conn != null && !conn.isClosed()) {
            		conn.close();
            		conn = null;
            	}

            	// Create user accounts
            	ActionForward fwd = mapping.findForward("admin/records/list") ;
            	String path = fwd.getPath();
            	path += "?formId=";
            	path += "170";
            	return new ActionForward(path);
            }
        } catch (ServletException e) {
            log.error(e);
            request.setAttribute("exception", "There is an error generating the Search Results for the Home page. Please stand by - the system may be undergoing maintenance.");
            return mapping.findForward("error");
        } finally {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                conn = null;
            }

        }

        return mapping.findForward("noPermissions");
    }


}

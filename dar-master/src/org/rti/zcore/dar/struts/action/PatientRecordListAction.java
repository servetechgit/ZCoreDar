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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.util.MessageResources;
import org.rti.zcore.BaseEncounter;
import org.rti.zcore.Constants;
import org.rti.zcore.DropdownItem;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.FormField;
import org.rti.zcore.PageItem;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.gen.PatientCondition;
import org.rti.zcore.dar.utils.HealthCalcUtils;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.struts.action.generic.BasePatientAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.PatientRecordUtils;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.WidgetUtils;
import org.rti.zcore.utils.struts.i18n.ReloadablePropertyMessageResources;

/**
 * Action which locates the requested Form and passes it to the JSP for rendering.
 */

public final class PatientRecordListAction extends BasePatientAction {

    /**
     * Commons Logging instance.
     */

    private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

    protected ActionForward doExecute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        /*if (SystemStateManager.getCurrentState() != SystemStateManager.STATUS_NORMAL) {
            return mapping.findForward(LOCKED_FORWARD);
        }*/

        HttpSession session = request.getSession();
        Locale sessionLocale = (Locale) request.getAttribute("sessionLocale");
        String sessionLocaleString = null;
        if ((sessionLocale.getLanguage() != null) && ((sessionLocale.getCountry()!= null) && (!sessionLocale.getCountry().equals("")))) {
        	sessionLocaleString = sessionLocale.getLanguage() + "_" + sessionLocale.getCountry();
        }
        else if (sessionLocale.getLanguage() != null) {
        	sessionLocaleString = sessionLocale.getLanguage();
        }
        Principal user = request.getUserPrincipal();
        String username = user.getName();
        Connection conn = null;
        BaseEncounter encounter = null;
        Map encMap = null;
        Long formId = null;
        SessionSubject sessionPatient = null;
        Long patientId = null;
        //Long eventId = null;
        String eventUuid = null;
        Form encounterForm = null;
        String formName = null;
        if (mapping.getParameter() != null && !mapping.getParameter().equals("")) {
        	formName = mapping.getParameter().trim();
        	formId = (Long) DynaSiteObjects.getFormNameMap().get(formName);
        } else {
        	if (request.getParameter("formId") != null) {
				formId = Long.decode(request.getParameter("formId"));
			} else if (request.getAttribute("formId") != null) {
				formId = Long.decode(request.getAttribute("formId").toString());
			}
            //formId = request.getAttribute("id").toString();
        }

        if (request.getParameter("patientId") != null) {
        	patientId = Long.decode(request.getParameter("patientId"));
        } else if (request.getAttribute("patientId") != null) {
        	patientId = Long.decode(request.getAttribute("patientId").toString());
        }

        try {
            sessionPatient = (SessionSubject) SessionUtil.getInstance(session).getSessionPatient();
            //eventId = sessionPatient.getCurrentEventId();
            eventUuid = sessionPatient.getCurrentEventUuid();
        } catch (SessionUtil.AttributeNotFoundException e) {
            log.error("Unable to get TimsSessionSubject");
        }

        if (patientId == null) {
        	try {
                patientId = sessionPatient.getId();
            } catch (Exception e) {
                log.error("Unable to get TimsSessionSubject field");
            }
        }

        // sometimes the user can click link to create a new event and then click elsewhere.
        if (eventUuid == null) {
        	String forwardString = "/listEvents.do?patientId=" + patientId;
        	ActionForward forwardForm = new ActionForward(forwardString);
    		forwardForm.setRedirect(true);
    		return forwardForm;
        }

        encounterForm = ((Form) DynaSiteObjects.getForms().get(formId));
        try {
            conn = DatabaseUtils.getZEPRSConnection(username);

            // populate the records for this class
            List chartItems = new ArrayList();
            String classname = StringManipulation.fixClassname(encounterForm.getName());
            Class clazz = Class.forName(Constants.getDynasiteFormsPackage() + "." + classname);
            try {
            	ArrayList moreItems = (ArrayList) EncountersDAO.getAllOrderBy(conn, patientId, eventUuid, "SQL_RETRIEVE_UUID" + formId, clazz, "date_visit DESC");
            	chartItems.addAll(moreItems);
            } catch (IOException e) {
            	request.setAttribute("exception", e);
            	return mapping.findForward("error");
            } catch (ServletException e) {
            	request.setAttribute("exception", e);
            	return mapping.findForward("error");
            } catch (SQLException e) {
            	request.setAttribute("exception", e);
            	return mapping.findForward("error");
            }

            // DAR-specific:
            if (formName.equals("PatientCondition")) {
            	String bmiCalc = Constants.getProperties("bmi.calculate", Constants.getAPP_PROPERTIES());
            	if (bmiCalc != null && bmiCalc.equals("true")) {
                	for (int i = 0; i < chartItems.size(); i++) {
                		PatientCondition pc = (PatientCondition) chartItems.get(i);
                		Float weight = pc.getWeight();
                		Float height = pc.getHeight();
                		if ((weight != null) && ((height != null) && (height != 0))) {
                    		Float bmi = HealthCalcUtils.bmiCalc(weight, height);
                    		pc.setBmi_calculated(bmi);
                		}
                	}
            	}
            }

         // Attach a map of encounter values that has enumerations already resolved.
            MessageResources messageResources = getResources(request, encounterForm.getClassname()+"Messages");
            String messageKey = encounterForm.getClassname()+"Messages";
            ReloadablePropertyMessageResources messages = (ReloadablePropertyMessageResources) request.getAttribute(messageKey);
            //ZcorePropertyMessageResources sMessages = (ZcorePropertyMessageResources) messages;
            HashMap messageResourcesMap = messages.getMessages();
            HashMap localeMap = messages.getLocales();
            if (localeMap.get(sessionLocale.toString()) == null) {
            	messages.loadLocale(sessionLocale.toString());
            }

            // Attach a map of encounter values that has enumerations already resolved.
            Form encForm = (Form) DynaSiteObjects.getForms().get(encounterForm.getId());
            for (int i = 0; i < chartItems.size(); i++) {
                encounter = (EncounterData) chartItems.get(i);
                encMap = PatientRecordUtils.getEncounterMap(encForm, encounter, "fieldId");
                encounter.setEncounterMap(encMap);
                if (messageResourcesMap != null) {
                	encounter.setMessageResourcesMap(messageResourcesMap);
                }
            }
            if (chartItems.size() > 0) {
                request.setAttribute("chartItems", chartItems);
                request.setAttribute("formId", encounterForm.getId());
                // loading of body onload DWRUtil.useLoadingMessage()
                request.setAttribute("dwr", 1);
            }

            // Process the dynamic dropdown lists.
            HashMap listMap = new HashMap();
            Form inlineForm = null;
            for (Iterator iterator = encounterForm.getPageItems().iterator(); iterator.hasNext();) {
                PageItem pageItem = (PageItem) iterator.next();
                FormField formField = pageItem.getForm_field();
                String identifier = formField.getIdentifier();

                if (pageItem.getInputType().equals("dropdown") || pageItem.getInputType().equals("dropdown-add-one") || pageItem.getInputType().equals("dropdown_site")) {
                	List list = WidgetUtils.getList(conn, pageItem.getDropdownTable(), pageItem.getDropdownColumn(), pageItem.getDropdownConstraint(), pageItem.getDropdownOrderByClause(), DropdownItem.class, pageItem.getFkIdentifier());
                	listMap.put(pageItem.getId(), list);
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
            request.setAttribute("listMap", listMap);
            request.setAttribute("encounterForm", encounterForm);


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
}

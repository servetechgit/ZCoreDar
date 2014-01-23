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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.impl.BaseSessionSubject;
import org.rti.zcore.struts.action.generic.BasePatientAction;
import org.rti.zcore.utils.SessionUtil;

/**
 * Loads the patient onto the session
 */

public final class PatientHomeAction extends BasePatientAction {
    /**
     * Commons Logging instance.
     */
    private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());


    /**
     * Negotiate whether the user has a current pregnancy or needs to view history.
     * <p/>
     * Process the specified HTTP request, and create the corresponding HTTP
     * response (or forward to another web component that will create it).
     * Return an <code>ActionForward</code> instance describing where and how
     * control should be forwarded, or <code>null</code> if the response has
     * already been completed.
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

    	Long patientId = null;
    	Long eventId = null;
    	Long flowId = null;
    	BaseSessionSubject sessionPatient = null;
    	HttpSession session = request.getSession();

        try {
			sessionPatient = SessionUtil.getInstance(session).getSessionPatient();
		} catch (SessionUtil.AttributeNotFoundException e1) {
			//log.debug("No session - SessionUtil.AttributeNotFoundException" + e1);
			return mapping.findForward("home");
		}
		patientId = sessionPatient.getId();
		eventId = sessionPatient.getCurrentEventId();
        String forward;
        String params = null;

        forward = "PatientItem/new";

        // if user is data clerk, send to home page.
        if (request.isUserInRole("CREATE_NEW_PATIENTS_AND_SEARCH")) {
            request.setAttribute("patientId", patientId);
            ActionForward forwardForm = null;
            String forwardString = "/demographics.do?patientId=" + patientId;
            forwardForm = new ActionForward(forwardString);
            return forwardForm;
        } else {
            request.setAttribute("patientId", patientId);
            ActionForward forwardForm = null;
            String forwardString = null;
            if (params != null) {
                forwardString = "/" + forward + ".do?patientId=" + patientId + "&" + params;
            } else {
                forwardString = "/" + forward + ".do?patientId=" + patientId;
            }
            forwardForm = new ActionForward(forwardString);
            forwardForm.setRedirect(true);
            return forwardForm;
        }
    }
}

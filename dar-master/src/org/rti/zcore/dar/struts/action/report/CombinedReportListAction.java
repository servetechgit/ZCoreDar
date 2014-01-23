/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action.report;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.ClientSettings;
import org.rti.zcore.Site;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.SessionUtil;

/**
 * This is used to generate the combined reports in a single Excel file for KEMSA.
 * @author ckelley
 * @date   Mar 10, 2009
 */
public final class CombinedReportListAction extends BaseAction {

	/**
	 * Commons Logging instance.
	 */
	private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

	/**
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
		Principal user = request.getUserPrincipal();
		String username = user.getName();
		HttpSession session = request.getSession();
		SessionUtil zeprs_session = null;
		Site site = null;
		String siteAbbrev = null;
		try {
			zeprs_session = (SessionUtil) session.getAttribute("zeprs_session");
		} catch (Exception e) {
			// unit testing - it's ok...
		}
		try {
			ClientSettings clientSettings = zeprs_session.getClientSettings();
			site = clientSettings.getSite();
			siteAbbrev = site.getAbbreviation();
		} catch (SessionUtil.AttributeNotFoundException e) {
			log.error(e);
		} catch (NullPointerException e) {
			// it's ok - unit testing
			siteAbbrev = "test";
		}
		//String path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep;
		String path = null;
		if (request.getParameter("path") != null) {
			path = request.getParameter("path");
		}
		String message = "Reports are saved at ";
		request.setAttribute("message", message);
		request.setAttribute("path", path);
		return mapping.findForward("success");
	}
}
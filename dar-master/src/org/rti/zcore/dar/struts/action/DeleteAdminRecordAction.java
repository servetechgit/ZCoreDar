/*
 *    Copyright 2010 Research Triangle Institute
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
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Site;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.PatientRecordUtils;
import org.rti.zcore.utils.SessionUtil;

/**
 * User: ckelley
 * Date: April 1 2010
 * Time: 10:39 PM
 */
public final class DeleteAdminRecordAction extends BaseAction {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(DeleteAdminRecordAction.class);

	/**
	 * Deletes all admin records except user_info.
	 * This assumes that an admin record has a null patient_id
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @deprecated - use zcore version instead.
	 */
	protected ActionForward doExecute(ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response)
	throws Exception {

		HttpSession session = request.getSession();
		Site site = SessionUtil.getInstance(session).getClientSettings().getSite();
		String siteAbbrev = site.getAbbreviation();
		Principal user = request.getUserPrincipal();
		String username = user.getName();
		Connection conn = null;
		ResultSet rs;

		StringBuffer sbuf = new StringBuffer();
		try {
			// using the super special root connection for this one mate!
			// conn = DatabaseUtils.getSpecialRootConnection(username);
			// use zeprs conn for derby
			conn = DatabaseUtils.getZEPRSConnection(username);
			try {
				rs = EncountersDAO.getAllEncounters(conn);
				String message = "";
				StringBuffer sbufLog = new StringBuffer();
				while (rs.next()) {
					Long encounterId = rs.getLong("id");
					Long formId = rs.getLong("form_id");
					String formName = DynaSiteObjects.getFormIdClassNameMap().get(formId);
					Long patientId = rs.getLong("patient_id");
					EncounterData vo = new EncounterData();    // dummy EncounterData is OK.
					if ((patientId == 0) && ((!formName.equals("UserInfo")) && (!formName.equals("ArtRegimen")) && (!formName.equals("Item")) && (!formName.equals("ItemGroup")) && (!formName.equals("RegimenGroup")) && (!formName.equals("Regimen")) && (!formName.equals("RegimenItem_bridge")) )) {
						try {
							PatientRecordUtils.deleteEncounter(conn, formId, encounterId, username, site, vo, null);
						} catch (Exception e) {
							request.setAttribute("exception", e);
							return mapping.findForward("error");
						}
					}
				}
				message = sbufLog.toString();
				request.setAttribute("message", message);
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("error");
			} finally {
				//

			}

		} finally {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		}
		return mapping.findForward("home");
	}

}

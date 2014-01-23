/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dynasite.dao.BackupDAO;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.SessionUtil;

public class UpdateBalanceAction extends BaseAction {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(UpdateBalanceAction.class);

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
	protected ActionForward doExecute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)

	throws Exception {
		Connection conn = DatabaseUtils.getAdminConnection();
		int siteId = 0;
		Date beginDate = null;
		Date endDate = null;
		/*if (request.getParameter("itemId") != null) {
			itemId = Long.valueOf(request.getParameter("itemId"));
		}
		if (request.getParameter("siteId") != null) {
			siteId = Integer.valueOf(request.getParameter("siteId"));
		}
		if (request.getParameter("beginDate") != null) {
			beginDate = Date.valueOf(String.valueOf(request.getParameter("beginDate")));
		}
		if (request.getParameter("endDate") != null) {
			endDate = Date.valueOf(String.valueOf(request.getParameter("endDate")));
		}*/

		beginDate =  java.sql.Date.valueOf("2006-01-01");
		endDate = DateUtils.getNow();

		// backup the database
        HttpSession session = request.getSession();

        SessionUtil zeprs_session = null;
        try {
    		zeprs_session = (SessionUtil) session.getAttribute("zeprs_session");
    	} catch (Exception e) {
    		// unit testing - it's ok...
    	}
		ClientSettings clientSettings = zeprs_session.getClientSettings();
		Site site = clientSettings.getSite();
		String siteAbbrev = site.getAbbreviation();
        BackupDAO.backupZipDatabase(conn, siteAbbrev);

		siteId = site.getId().intValue();
		String sql = "select distinct ITEM_ID AS item_id from stock_control group by ITEM_ID";
		ArrayList values = new ArrayList();
		List<StockControl> items = DatabaseUtils.getList(StockControl.class, sql, values);
		StringBuffer sbuf = new StringBuffer();

		HashMap<Long, List<StockControl>> stockMap = InventoryDAO.getPatientStockMap(conn, siteId, beginDate, endDate);

		if (items.size() > 0) {
			for (StockControl stockControl : items) {
				Long itemId = stockControl.getItem_id();
				sbuf.append(itemId);
				sbuf.append("<br>");
				List<StockControl> patientStockChanges = stockMap.get(itemId);
				if (patientStockChanges == null) {
					patientStockChanges = new ArrayList<StockControl>();
				}
				List<StockControl> stockChanges = InventoryDAO.getStockEncounterChanges(conn, itemId, siteId, beginDate, endDate, null, patientStockChanges);
				if (stockChanges.size() > 0) {
			        StockReport stockReport = InventoryDAO.generateStockSummary(conn, itemId, beginDate, stockChanges, true);
				}
			}
		}

		String message = "Stock balanaces updated for items: " + sbuf.toString();
		request.setAttribute("message", message);

        //int size = stockChanges.size();
        /*stockChanges.add(size,stockControlAdditions);
        stockChanges.add(size+1,stockControlDeletions);
        stockChanges.add(size+2,stockControlIssued);*/

        /*request.setAttribute("stockReport", stockReport);
        // request.setAttribute("stockControlIssuedTotal", stockControlIssuedTotal);
        request.setAttribute("stockChanges", stockChanges);
        request.setAttribute("beginDate", beginDate);
        request.setAttribute("endDate", endDate);
        Class itemClazz = Class.forName("org.rti.zcore.dar.gen.Item");
		Item stockItem = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN131", itemClazz);
		String detailName = stockItem.getName();
		request.setAttribute("detailName", detailName);*/
		return mapping.findForward("success");
	}
}

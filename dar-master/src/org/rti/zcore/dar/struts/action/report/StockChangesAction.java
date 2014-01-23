/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action.report;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;

public class StockChangesAction extends BaseAction {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(StockChangesAction.class);

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
		Long itemId = null;
		int siteId = 0;
		Date beginDate = null;
		Date endDate = null;
		String code = null;
		if (request.getParameter("code") != null) {
			code = request.getParameter("code");
		}
		if (request.getParameter("itemId") != null && !request.getParameter("itemId").equals("")) {
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
		}
		beginDate = Date.valueOf("1900-01-01");
		endDate = DateUtils.getNow();

		boolean redirectError = false;
		if (itemId == null) {
			if (code != null) {
				// Create a map with Item id, name
	    		ArrayList<Item> items = (ArrayList<Item>) EncountersDAO.getAll(conn, Long.valueOf(131), "SQL_RETRIEVE_ALL_ADMIN_PAGER131", Item.class);
	    		for (Item item : items) {
	    			String itemCode = item.getCode();
	    			if (code.equals(itemCode)) {
	    				itemId = item.getId();
	    			}
				}
	    		if (itemId == null) {
	    			redirectError = true;
	    		}
			} else {
				redirectError = true;
			}
		}
		if (redirectError) {
			request.setAttribute("exception", "Unable to find itemID for this item. ItemId: " + itemId + "; code: " + code);
			return mapping.findForward("error");
		}
		List<StockControl> stockChanges = InventoryDAO.getStockEncounterChanges(conn, itemId, siteId, beginDate, endDate, null, null);
        StockReport stockReport = InventoryDAO.generateStockSummary(conn, itemId, beginDate, stockChanges, false);
        //int size = stockChanges.size();
        /*stockChanges.add(size,stockControlAdditions);
        stockChanges.add(size+1,stockControlDeletions);
        stockChanges.add(size+2,stockControlIssued);*/

        request.setAttribute("stockReport", stockReport);
        // request.setAttribute("stockControlIssuedTotal", stockControlIssuedTotal);
        request.setAttribute("stockChanges", stockChanges);
        // request.setAttribute("beginDate", beginDate);
        request.setAttribute("endDate", endDate);
        Class itemClazz = Class.forName("org.rti.zcore.dar.gen.Item");
		Item stockItem = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN131", itemClazz);
		String detailName = stockItem.getName();
		request.setAttribute("detailName", detailName);
		return mapping.findForward("success");
	}

}

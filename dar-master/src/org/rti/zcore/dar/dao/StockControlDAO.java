/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.Task;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.sort.DateVisitOrderComparator;

public class StockControlDAO {

	/**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(StockControlDAO.class);

    /**
     * Loops thorough all items and checks if the expiry date is in the next 3 months.
     * Adds them to a HashMap in DynaSiteObjects.
     * @param conn
     * @param id
     * @return
     * @throws SQLException
     * @throws ServletException
     * @throws ObjectNotFoundException
     * @throws IOException
     */
    public static void setExpiredStockItems(Connection conn) throws SQLException, ServletException, ObjectNotFoundException, IOException {

    	/*List<StockControl> expiredStockItems = null;
    	if (DynaSiteObjects.getStatusMap().get("expiredStockItems") != null) {
    		expiredStockItems = (List<StockControl>) DynaSiteObjects.getStatusMap().get("expiredStockItems");
    	} else {
    		expiredStockItems = new ArrayList<StockControl>();
    	}*/

    	if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
    		HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
    		Set balanceMapSet = balanceMap.entrySet();
    		for (Iterator iterator = balanceMapSet.iterator(); iterator.hasNext();) {
    			Map.Entry entry = (Map.Entry) iterator.next();
    			Long itemId = (Long) entry.getKey();
    			StockReport stockReport = (StockReport) entry.getValue();
    			if (stockReport.getBalanceBF() > 0) {
        			StockControl stock = getExpiredStockItem(conn, itemId, null);
        			if (stock!= null && stock.getNotes() != null) {
        				//expiredStockItems.add(stock);
        				stockReport.setExpired(Boolean.TRUE);
        				stockReport.setExpiryDate(stock.getExpiry_date());
        				stockReport.setName(stock.getNotes());
        			}
    			}
    		}
    		//DynaSiteObjects.getStatusMap().put("expiredStockItems",expiredStockItems);

    	}
    	// TODO: delete the items loop below
    	// loop through all of the items
    	/*List<Item> items = EncountersDAO.getAll(conn, Long.valueOf(131), "SQL_RETRIEVE_ALL_ADMIN131", Item.class);
    	for (Item item : items) {
			Long itemId = item.getId();
			String name = item.getName();
			Integer balance = 0;
			if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
				HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
				StockReport stockReport = balanceMap.get(itemId);
				if (stockReport != null) {
					balance = stockReport.getBalanceBF();

				}
			}

			org.rti.zcore.art.StockControl stock = null;
			Date expiry = null;
			Class clazz = null;
			try {
				clazz = Class.forName("org.rti.zcore.art.StockControl");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// query for latest balance from stock
			String sql = "SELECT id, balance, last_patient_item_id, expiry_date FROM stock_control WHERE item_id = ? AND type_of_change != 3279 ORDER BY id DESC";
			ArrayList values = new ArrayList();
			values.add(itemId);
			List records = null;
			records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
			if (records.size() > 0) {
				stock = (org.rti.zcore.art.StockControl) records.get(0);
				if (stock.getExpiry_date() != null) {
					expiry = stock.getExpiry_date();
				}
			}

			if ((expiry != null) && (balance != null && balance > 0)) {
				//Boolean expiresLT3months = DateUtils.check3monthExpiry(DateUtils.getNow(), expiry);
				Boolean expiresLT3months = InventoryUtils.checkExpiry(DateUtils.getNow(), expiry, 3);
				if (expiresLT3months == true) {
					stock.setNotes(name);
    				stock.setItem_id(itemId);
    				expiredStockItems.add(stock);
				}
			}
		}*/
    }


	/**
	 * Transfers data about lowStockItems and expired stock to Tasks, preparing them for display in the Stock Alerts list.
	 * Sets stockAlertList in DynaSiteObjects.getStatusMap() using DynaSiteObjects.getStatusMap().get("lowStockItems")
	 * and DynaSiteObjects.getStatusMap().get("expiredStockItems").
	 * @param conn
	 * @param stockItemId - if not null, checks if the item should be removed from the lowStockItems list
	 * @throws SQLException
	 * @throws ServletException
	 */
	public static void setStockAlertList(Connection conn, Long stockItemId) throws ServletException, SQLException {
		HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
		List<Task> lowStockItems = null;
		if (DynaSiteObjects.getStatusMap().get("lowStockItems") != null) {
			lowStockItems = (List<Task>) DynaSiteObjects.getStatusMap().get("lowStockItems");
		}
		if (stockItemId != null) {
			Integer currentBalance = null;
			// Loop through the lowStockItems to see if any of these are no longer low or empty
			Integer indexOfOutOfStock = null;
			for (Task task : lowStockItems) {
				Long itemId = task.getId();
				if (balanceMap.get(itemId) != null) {
					StockReport stockReport = balanceMap.get(itemId);
					currentBalance = stockReport.getBalanceBF();
					if (currentBalance > 0) {
						// also check if it is still low stock.
						if (task.getMessageType().equals("outOfStock")) {
							indexOfOutOfStock = lowStockItems.indexOf(task);
						}
					}
				}
			}
			if (indexOfOutOfStock != null) {
				lowStockItems.remove(indexOfOutOfStock.intValue());
			}

			// find the most recent stock receipt for this item.
			Integer indexOfLowStock = null;
			String sql = "SELECT id, balance AS balance, last_patient_item_id as last_patient_item_id, expiry_date AS expiry_date FROM stock_control WHERE item_id = ? AND type_of_change = 3263 ORDER BY id DESC";
			ArrayList values = new ArrayList();
			values.add(stockItemId);
			List records = null;
			Class clazz = null;
			try {
				clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
			StockControl record = null;
			Float threshold = Float.valueOf(Constants.LOW_STOCK_WARNING_QUANTITY);
			if (records.size() > 0) {
				record = (StockControl) records.get(0);
				if (record.getBalance() != null) {
					Float stockCountThreshold = record.getBalance().floatValue() * (threshold/100);
					if ((currentBalance != null) && (currentBalance > stockCountThreshold)) {
						for (Task task : lowStockItems) {
							Long itemId = task.getId();
							if (itemId.longValue() == stockItemId.longValue()) {
								indexOfLowStock =  lowStockItems.indexOf(task);
							}
						}
					}
				}
			}

			if (indexOfLowStock != null) {
				lowStockItems.remove(indexOfLowStock.intValue());
			}
		}
		List<Task> stockAlertList = new ArrayList<Task>();

		Set balanceMapSet = balanceMap.entrySet();
		for (Iterator iterator = balanceMapSet.iterator(); iterator.hasNext();) {
			Map.Entry entry = (Map.Entry) iterator.next();
			Long itemId = (Long) entry.getKey();
			StockReport stockReport = (StockReport) entry.getValue();
			if (stockReport.getBalanceBF() > 0) {
				if (stockReport.getExpired() == Boolean.TRUE) {
					String taskName = stockReport.getName();
					Task createExpiryTask = new Task(null,null, taskName, null, null, 1, "Task");
					createExpiryTask.setActive(true);
					createExpiryTask.setMessageType("expired");
					createExpiryTask.setDateVisit(stockReport.getExpiryDate());
					stockAlertList.add(createExpiryTask);
				}
			}
		}
		if (lowStockItems.size() > 0) {
			stockAlertList.addAll(lowStockItems);
		}

		Collections.sort(stockAlertList, new DateVisitOrderComparator());
		DynaSiteObjects.getStatusMap().put("stockAlertList",stockAlertList);
	}




	/**
	 * @param conn
	 * @param itemId
	 * @param expiryDate - if null, gets the expiry from the most recent Stock transaction.
	 * @return StockControl - If item expires in next 3 months, the notes filed will have the item name for display in the Stock alerts panel.
	 * @throws ServletException
	 * @throws SQLException
	 * @throws IOException
	 */
	public static StockControl getExpiredStockItem(Connection conn, Long itemId, Date expiryDate) throws ServletException, SQLException, IOException {
		StockControl stock = null;
		Date expiry = null;
		Class clazz = null;
		try {
			clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (expiryDate == null) {
			// gets the expiry from the most recent Stock transaction.
			String sql = "SELECT id, balance, last_patient_item_id, expiry_date FROM stock_control WHERE item_id = ? AND type_of_change != 3279 ORDER BY id DESC";
			ArrayList values = new ArrayList();
			values.add(itemId);
			List records = null;
			records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
			if (records.size() > 0) {
				stock = (StockControl) records.get(0);
				expiryDate = stock.getExpiry_date();
			}
		}

		// expiryDate still may be null.
		if (expiryDate != null) {
			// stockReport.setExpiryDate(expiry);
			Boolean expiresLT3months = InventoryUtils.checkExpiry(DateUtils.getNow(), expiryDate, 3);
			if (expiresLT3months == true) {
				//Item item = (Item) DatabaseUtils.getBean(conn, Item.class, sql, values);
				Item item = null;
				String itemName = null;
				try {
					//item = (Item) EncountersDAO.getOneById(conn, itemId, Long.valueOf(131), Item.class);
					item = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN" + Long.valueOf(131), Item.class);
					itemName = item.getName();
					if (stock == null) {
						stock = new StockControl();
						stock.setExpiry_date(expiryDate);
					}
					stock.setNotes(itemName);
					stock.setItem_id(itemId);
				} catch (ObjectNotFoundException e) {
					//itemName = "Deleted Item " + itemId;
					log.debug("Item not found for id: " + itemId);
				}
				//expiredStockItems.add(stock);
				//stockReport.setExpired(Boolean.TRUE);
			}
		}
		return stock;

	}


    /**
     * Creates a list of Stock items that are equal to or below the low stock threshhold.
     * @param conn
     * @throws SQLException
     * @throws ServletException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws ObjectNotFoundException
     */
    public static void setLowStockTasks(Connection conn) throws IOException, ServletException, SQLException, ObjectNotFoundException, ClassNotFoundException {
    	if (DynaSiteObjects.getStatusMap().get("lowStockItems") == null) {
    		List<Task> lowStockItems = new ArrayList<Task>();
    		if (Constants.LOW_STOCK_WARNING_QUANTITY != null) {
    			Float threshold = Float.valueOf(Constants.LOW_STOCK_WARNING_QUANTITY);

    			// loop through all of the items
    			List<Item> items = EncountersDAO.getAll(conn, Long.valueOf(131), "SQL_RETRIEVE_ALL_ADMIN131", Item.class);
    			for (Item item : items) {
    				Long itemId = item.getId();
    				String name = item.getName();

    				//StockControl tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId);
    				//Integer currentBalance = tempStockControl.getBalance();
    				Integer currentBalance = 0;
    				if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
    					HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
    					StockReport stockReport = balanceMap.get(itemId);
    					//tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId, siteId.intValue());
    					if (stockReport != null) {
    						currentBalance = stockReport.getBalanceBF();
    					}
    				}
    				if (currentBalance > 0) {
    					// find the most recent stock receipt for this item.
    					String sql = "SELECT id, balance AS balance, last_patient_item_id as last_patient_item_id, expiry_date AS expiry_date FROM stock_control WHERE item_id = ? AND type_of_change = 3263 ORDER BY id DESC";
    					ArrayList values = new ArrayList();
    					values.add(itemId);
    					List records = null;
    					Class clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
    					records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
    					StockControl record = null;
    					if (records.size() > 0) {
    						record = (StockControl) records.get(0);
    						if (record.getBalance() != null) {
    							Float stockCountThreshold = record.getBalance().floatValue() * (threshold/100);
    							if (currentBalance <= stockCountThreshold) {
    								Class itemClazz = Class.forName("org.rti.zcore.dar.gen.Item");
    								Item stockItem = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN131", itemClazz);
    								String detailName = stockItem.getName();
    								String taskName = "Low Stock Warning for " + detailName + ". On-hand: " + currentBalance;
    								Task task = new Task(null,null, taskName, null, null, 1, "Task");
    								task.setActive(true);
    								task.setMessageType("lowStock");
    			            		task.setId(itemId);
    								lowStockItems.add(task);
    							}
    						}
    					}
    				}
    			}
    		}
    		DynaSiteObjects.getStatusMap().put("lowStockItems", lowStockItems);
    	}
    }


	/**
	 * @param conn
	 * @param sc
	 * @param siteId
	 * @param itemId
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	public static void prepareStockforAlertList(Connection conn, StockControl sc, Long siteId, Long itemId)
			throws ClassNotFoundException, IOException, ServletException, SQLException, ObjectNotFoundException {
		Integer siteIdInt = null;
		if (siteId != null) {
			siteIdInt = siteId.intValue();
		}
		StockReport stockReport = InventoryDAO.getCurrentBalance(conn, itemId, siteIdInt);
		HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
		StockControl stock = getExpiredStockItem(conn, itemId, sc.getExpiry_date());
		if (stock!= null && stock.getNotes() != null) {
			stockReport.setExpired(Boolean.TRUE);
			stockReport.setExpiryDate(stock.getExpiry_date());
			stockReport.setName(stock.getNotes());
		}
		balanceMap.put(itemId, stockReport);
		// refreshes the StockAlertList.
		setStockAlertList(conn, itemId);
	}

}

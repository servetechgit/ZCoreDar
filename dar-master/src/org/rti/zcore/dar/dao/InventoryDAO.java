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
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;

import org.apache.commons.dbutils.QueryLoader;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.BaseEncounter;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.dao.EncounterValueArchiveDAO;
import org.rti.zcore.dar.gen.PatientItem;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.PopulatePatientRecord;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.sort.DateVisitOrderComparator;

/**
 * Utility methods relating to Stock Control
 * @author ckelley
 *
 */
public class InventoryDAO {

	/**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(InventoryDAO.class);

    /**
     * Gets current stock balance.
     * @param conn
     * @param itemId
     * @param siteId - It is recommended to set siteId = null. Refer to InventoryDAO.getCurrentBalance.
     * @return
     * @throws ClassNotFoundException
     * @throws IOException
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static StockControl getCurrentStockBalance(Connection conn, Long itemId, Integer siteId) throws ClassNotFoundException, IOException, ServletException, SQLException, ObjectNotFoundException {
    	StockControl tempStockControl = new StockControl();
		Long currentPatientItemId = Long.valueOf(0);
    	//List<StockControl> stockEncounterChanges = InventoryDAO.getStockEncounterChanges(conn, itemId, siteId, firstDate, endDate, null, null);
        //StockReport stockReport = InventoryDAO.generateStockSummary(conn, itemId, firstDate, stockEncounterChanges, false);
        StockReport stockReport = InventoryDAO.getCurrentBalance(conn, itemId, siteId);
        Integer currentBalance = stockReport.getOnHand();

        // Get the most recent patient_item record - we'll record this id in the currentPatientItemId field
		String sql = "SELECT encounter_id AS id FROM patient_item ORDER BY id DESC";
		Class clazz = Class.forName("org.rti.zcore.dar.gen.PatientItem");
		ArrayList values = new ArrayList();
		List items = DatabaseUtils.getList(conn, clazz, sql, values, 1);
		if (items.size() > 0) {
			PatientItem patientItem = (PatientItem) items.get(0);
			currentPatientItemId = patientItem.getId();
		}

    	tempStockControl.setBalance(currentBalance);
    	tempStockControl.setLast_patient_item_id(currentPatientItemId);
    	//tempStockControl.setExpiry_date(expiry);
    	return tempStockControl;
    }


    /**
     * This method assumes that all records are entered sequentially.
     * Gets the starting balance by querying stock_control for the most recent record before the startDate.
     * @param conn
     * @param formId
     * @param itemId
     * @param startDate
     * @return
     * @throws ClassNotFoundException
     * @throws IOException
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static StockControl getBeginningStockBalance(Connection conn, int formId, Long itemId, Date startDate)
    throws ClassNotFoundException, IOException, ServletException,
    SQLException, ObjectNotFoundException {
    	StockControl tempStockControl = new StockControl();
    	Integer prev_stock_balance = 0;
    	Integer balance = 0;
    	Integer patientBalance = 0;
    	StockControl record = null;
    	// The following fields are used to make a list of dispensed items in the period after the last stock transaction and before the startDate.
    	Long lastStockCountPatientItemId = null;	// Record id of the last item dispensed before this stock transaction happened.
    	Long currentPatientItemId = null;			// Record id of the item dispensed before the startDate
    	lastStockCountPatientItemId = Long.valueOf(0);
    	currentPatientItemId = Long.valueOf(0);
    	Class clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
    	// query for latest balance from stock, including the id (last_patient_item_id) for most recent dispensing for this drug during this period.
    	// 3279 - out-of-stock
    	String genSqlName = "SQL_RETRIEVEALL" + formId;
    	String sql = "SELECT e.id, balance, last_patient_item_id, quantity_remaining " +
    			"FROM stock_control s, encounter e " +
    			"WHERE s.id = e.id " +
    			"AND type_of_change != 3279 " +
    			"AND item_id = ? " +
    			"AND date_of_record < ? " +
    			"ORDER BY id DESC";
    	ArrayList values = new ArrayList();
    	values.add(itemId);
    	values.add(startDate);
    	List records = null;
    	records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
    	if (records.size() > 0) {
    		record = (StockControl) records.get(0);
    		if (record.getBalance() != null) {
    			prev_stock_balance = record.getBalance();
    		}
    		if (record.getLast_patient_item_id() != null) {
    			lastStockCountPatientItemId = record.getLast_patient_item_id();
    		}
    		/*if (record.getField2274() != null) {
    			quantityRemaining = record.getField2274();
    		}*/
    	}
    	// Get the first patient_item record before the start Date - we'll record this id in the currentPatientItemId field
    	// and use it to make a list of dispensed items in the period after the last stock transaction and before the startDate.
    	sql = "SELECT encounter_id AS id " +
    			"FROM patient_item p, encounter e " +
    			"WHERE p.encounter_id = e.id " +
    			"AND date_visit < ? " +
    			"ORDER BY id DESC";
    	clazz = Class.forName("org.rti.zcore.dar.gen.PatientItem");
    	values = new ArrayList();
    	values.add(startDate);
    	List items = DatabaseUtils.getList(conn, clazz, sql, values, 1);
    	if (items.size() > 0) {
    		PatientItem patientItem = (PatientItem) items.get(0);
    		currentPatientItemId = patientItem.getId();
    	}
    	// now query the patient records  - search for all patient records for this stock item dispensed between the lastStockCountPatientItemId and currentPatientItemId id's.
    	Date dateOfRecord = null;
    	List<PatientItem> patientItems = getCurrentPatientBalanceList(conn, itemId, lastStockCountPatientItemId, currentPatientItemId);
    	for (Iterator iterator = patientItems.iterator(); iterator.hasNext();) {
    		PatientItem patientItem = (PatientItem) iterator.next();
    		dateOfRecord = patientItem.getDateVisit();
    		Integer dispensed = patientItem.getDispensed();
    		if (dispensed != null)
    			patientBalance = patientBalance - dispensed;
    	}
    	balance = prev_stock_balance + patientBalance;
    	//tempStockControl.setField2274(quantityRemaining);
    	tempStockControl.setBalance(balance);
    	tempStockControl.setLast_patient_item_id(currentPatientItemId);
    	tempStockControl.setDate_of_record(dateOfRecord);
    	return tempStockControl;
    }

    public static StockControl getBeginningStockBalance(Connection conn, int formId, Long itemId, Date startDate, Date endDate, Integer currentBalance)
    throws ClassNotFoundException, IOException, ServletException,
    SQLException, ObjectNotFoundException {
    	StockControl tempStockControl = new StockControl();
    	Integer prev_stock_balance = 0;
    	Integer balance = 0;
    	Integer patientBalance = 0;
    	StockControl record = null;
    	// The following fields are used to make a list of dispensed items in the period after the last stock transaction and before the startDate.
    	Long lastStockCountPatientItemId = null;	// Record id of the last item dispensed before this stock transaction happened.
    	Long currentPatientItemId = null;			// Record id of the item dispensed before the startDate
    	lastStockCountPatientItemId = Long.valueOf(0);
    	currentPatientItemId = Long.valueOf(0);
    	Class clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
    	// query for latest balance from stock, including the id (last_patient_item_id) for most recent dispensing for this drug during this period.
    	// 3279 - out-of-stock
    	String genSqlName = "SQL_RETRIEVEALL" + formId;
    	String sql = "SELECT e.id, balance, last_patient_item_id, quantity_remaining " +
    	"FROM stock_control s, encounter e " +
    	"WHERE s.id = e.id " +
    	"AND type_of_change != 3279 " +
    	"AND item_id = ? " +
    	"AND date_of_record < ? " +
    	"ORDER BY id DESC";
    	ArrayList values = new ArrayList();
    	values.add(itemId);
    	values.add(startDate);
    	List records = null;
    	records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
    	if (records.size() > 0) {
    		record = (StockControl) records.get(0);
    		if (record.getBalance() != null) {
    			prev_stock_balance = record.getBalance();
    		}
    		if (record.getLast_patient_item_id() != null) {
    			lastStockCountPatientItemId = record.getLast_patient_item_id();
    		}
    		/*if (record.getField2274() != null) {
    			quantityRemaining = record.getField2274();
    		}*/
    	}
    	// Get the first patient_item record before the start Date - we'll record this id in the currentPatientItemId field
    	// and use it to make a list of dispensed items in the period after the last stock transaction and before the startDate.
    	sql = "SELECT encounter_id AS id " +
    	"FROM patient_item p, encounter e " +
    	"WHERE p.encounter_id = e.id " +
    	"AND date_visit < ? " +
    	"ORDER BY id DESC";
    	clazz = Class.forName("org.rti.zcore.dar.gen.PatientItem");
    	values = new ArrayList();
    	values.add(startDate);
    	List items = DatabaseUtils.getList(conn, clazz, sql, values, 1);
    	if (items.size() > 0) {
    		PatientItem patientItem = (PatientItem) items.get(0);
    		currentPatientItemId = patientItem.getId();
    	}
    	// now query the patient records  - search for all patient records for this stock item dispensed between the lastStockCountPatientItemId and currentPatientItemId id's.
    	Date dateOfRecord = null;
    	List<PatientItem> patientItems = getCurrentPatientBalanceList(conn, itemId, lastStockCountPatientItemId, currentPatientItemId);
    	for (Iterator iterator = patientItems.iterator(); iterator.hasNext();) {
    		PatientItem patientItem = (PatientItem) iterator.next();
    		dateOfRecord = patientItem.getDateVisit();
    		Integer dispensed = patientItem.getDispensed();
    		if (dispensed != null)
    			patientBalance = patientBalance - dispensed;
    	}
    	balance = prev_stock_balance + patientBalance;
    	//tempStockControl.setField2274(quantityRemaining);
    	tempStockControl.setBalance(balance);
    	tempStockControl.setLast_patient_item_id(currentPatientItemId);
    	tempStockControl.setDate_of_record(dateOfRecord);
    	return tempStockControl;
    }

	/**
	 *
	 * @param conn
	 * @param itemId
	 * @param lastStockCountPatientItemId - PatientItem id when stock was last counted (the previous count)
	 * @return list of number of dispensed
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
   public static List getCurrentPatientBalanceList(Connection conn, Long itemId, Long lastStockCountPatientItemId) throws IOException, ServletException, SQLException, ObjectNotFoundException {
   	List items = null;
   	//String sql = "SELECT id, dispensed AS dispensed FROM patient_item WHERE item_id = ? AND (id >= ? OR id <=?)";
   	String sql = "SELECT id, encounter_id AS encounterId, dispensed FROM patient_item WHERE item_id = ? AND encounter_id > ?";
   	ArrayList values = new ArrayList();
   	values.add(itemId);
   	values.add(lastStockCountPatientItemId);
   	//values.add(currentPatientItemId);
   	items = DatabaseUtils.getList(conn, PatientItem.class, sql, values);
   	return items;
   }

   /**
    * This is used for counting the balance brought forward.
    * @param conn
    * @param itemId
    * @param lastStockCountPatientItemId
    * @param currentPatientItemId
    * @return
    * @throws IOException
    * @throws ServletException
    * @throws SQLException
    * @throws ObjectNotFoundException
    */
   public static List getCurrentPatientBalanceList(Connection conn, Long itemId, Long lastStockCountPatientItemId, Long currentPatientItemId) throws IOException, ServletException, SQLException, ObjectNotFoundException {
	   	List items = null;
	   	//String sql = "SELECT id, dispensed AS dispensed FROM patient_item WHERE item_id = ? AND (id >= ? OR id <=?)";
	   	String sql = "SELECT id, encounter_id AS encounterId, dispensed FROM patient_item WHERE item_id = ? AND (encounter_id > ? AND encounter_id < ?)";
	   	ArrayList values = new ArrayList();
	   	values.add(itemId);
	   	values.add(lastStockCountPatientItemId);
	   	values.add(currentPatientItemId);
	   	items = DatabaseUtils.getList(conn, PatientItem.class, sql, values);
	   	return items;
	   }

	/**
	 * List of stock changes ordered by date_of_record DESC. Queries by date_of_record instead of date_visit.
	 *
	 * @param conn
	 * @param itemId
	 * @param siteID
	 * @param beginDate
	 *            - date_of_record instead of date_visit
	 * @param endDate
	 *            - date_of_record instead of date_visit
	 * @return
	 * @throws ClassNotFoundException
	 * @throws ServletException
	 * @throws SQLException
	 */
   public static List<StockControl> getStockChanges(Connection conn, Long itemId, int siteID, Date beginDate, Date endDate) throws ClassNotFoundException, ServletException, SQLException {
	   List records = null;
	   String dateRange = "AND date_of_record >= ? AND date_of_record <= ? ";
		if (endDate == null) {
			dateRange = "AND date_of_record = ?";
		}
	   Class clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
	   String sql = null;
		// query for latest balance from stock
		if (siteID == 0) {
		sql = "SELECT encounter.id AS id, date_of_record, type_of_change, change_value, expiry_date, " +
				//"quantity_remaining AS field2274, " +
				"created, notes, balance, expiry_date, quantity_remaining  " +
				"FROM stock_control, encounter " +
				"WHERE encounter.id = stock_control.id " +
				//"AND type_of_change = 3265 " +
				dateRange +
				"AND item_id = ? " +
				"ORDER BY date_of_record DESC";
		} else {
			sql = "SELECT encounter.id AS id, date_of_record, type_of_change, change_value, expiry_date, " +
			//"quantity_remaining AS field2274, " +
			"created, notes, balance, expiry_date, quantity_remaining " +
			"FROM stock_control, encounter " +
			"WHERE encounter.id = stock_control.id " +
			//"AND type_of_change = 3265 " +
			dateRange +
			"AND item_id = ? " +
			"AND encounter.site_id = ? " +
			"ORDER BY date_of_record DESC";
		}
		ArrayList values = new ArrayList();
		values.add(beginDate);
		if (endDate != null) {
			values.add(endDate);
		}
		values.add(itemId);
		if (siteID != 0) {
			values.add(siteID);
		}
		records = DatabaseUtils.getList(conn, clazz, sql, values);
	   return records;
   }

   /**
    * Throws ObjectNotFoundException if most recent
    * If you have entered stock as another site, note that it will not be reflected in the balance
    * if you specify another site. It is recommended to set siteId = null.
    * @param conn
    * @param itemId
    * @param siteID - It is recommended to set siteId = null.
    * @return
    * @throws ClassNotFoundException
    * @throws ServletException
    * @throws SQLException
    * @throws ObjectNotFoundException
    */
   public static StockControl getMostRecentOutOfStock(Connection conn, Long itemId, Integer siteID) throws ClassNotFoundException, ServletException, SQLException, ObjectNotFoundException {
	   StockControl record = null;
	   List list = null;
	   Class clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
	   String sql = null;
	   // query for latest stock control record
	   if (siteID == null) {
		   sql = "SELECT type_of_change AS type_of_change, change_value AS change_value, expiry_date AS expiry_date "+
			   "FROM stock_control, encounter " +
			   "WHERE encounter.id = stock_control.id " +
			   //"AND type_of_change = 3279 " +
			   "AND item_id = ? " +
			   "ORDER BY encounter.id";
	   } else {
		   sql = "SELECT type_of_change AS type_of_change, change_value AS change_value, expiry_date AS expiry_date "+
			   "FROM stock_control, encounter " +
			   "WHERE encounter.id = stock_control.id " +
			  // "AND type_of_change = 3279 " +
			   "AND item_id = ? " +
			   "AND encounter.site_id = ? " +
			   "ORDER BY encounter.id";
	   }
	   ArrayList values = new ArrayList();
	   values.add(itemId);
	   if ((siteID != null) && (siteID != 0)) {
		   values.add(siteID);
	   }
	   list = DatabaseUtils.getList(conn, clazz, sql, values, 1);
	   if (list.size()>0) {
		   record = (StockControl) list.get(0);
		   if (record.getType_of_change() != 3279) {
	    	   throw new ObjectNotFoundException();
		   }
       } else {
    	   throw new ObjectNotFoundException();
       }
	   return record;
   }

   /**
    * Creates Out-of-stock record.
    * @param conn
    * @param formDef
    * @param formId
    * @param patientId
    * @param siteId
    * @param username
    * @param sessionPatient
    * @param vo
    * @param itemId
    * @param quantityDispensed
    * @param visitDateD
    * @throws ClassNotFoundException
    * @throws InstantiationException
    * @throws IllegalAccessException
    * @throws InvocationTargetException
    * @throws IOException
    * @throws Exception
    */
   public static void createOutOfStockRecord(Connection conn, Form formDef, String formId, Long patientId,
			Long siteId, String username, SessionSubject sessionPatient, EncounterData vo, Long itemId,
			Integer quantityDispensed, Date visitDateD) throws ClassNotFoundException, InstantiationException,
			IllegalAccessException, InvocationTargetException, IOException, Exception {
		Long encounterId;
		Form formDef2 = (Form) DynaSiteObjects.getForms().get(new Long("161"));
		String classname = "org.rti.zcore.dar.gen.StockControl";
		Class formClass = Class.forName(classname);
		BaseEncounter stockControl = (BaseEncounter) formClass.newInstance();
		// don't set patient_id or pregnancy_id - this will cause constraint errors when a patient is deleted.
		stockControl.setPatientId(null);
		stockControl.setPregnancyId(null);
		stockControl.setFormId(formDef2.getId());
		stockControl.setDateVisit(visitDateD);
		// current flow is set in the session by BasePatientAction
		// but we need the flow of the form
		stockControl.setFlowId(formDef.getFlow().getId());
		Map stockControlMap = new HashMap();
		stockControlMap.put("date_of_record", visitDateD.toString());
		stockControlMap.put("item_id", itemId.toString());
		stockControlMap.put("type_of_change", "3279");	//type_of_change
		stockControlMap.put("change_value", quantityDispensed.toString());	//change_value
		stockControlMap.put("balance", "0");	//balance
		stockControlMap.put("last_patient_item_id", vo.getId());	//last_patient_item_id
		EncounterData vo2 = PopulatePatientRecord.populateEncounterData(formDef, formId, siteId, username, stockControl, stockControlMap);
		Map genQueries = QueryLoader.instance().load("/" + Constants.SQL_GENERATED_PROPERTIES);

		/**
		 * Persist the encounter
		 */
		encounterId = org.rti.zcore.dao.FormDAO.createEncounter(conn, genQueries, vo2, formDef2, username, siteId, stockControlMap);
	}

   /**
    * Deletes all records from the stock_control table and any associated encounter records.
    * @param conn
    * @return
    * @throws Exception
    */
   public static String deleteAllStockItems(Connection conn) throws Exception {
   	String result = null;
   	ArrayList values = null;
   	String sql = null;
   	int results = 0;
   	conn.setAutoCommit(false);
   	try {
   		sql = "DELETE FROM stock_control";
   		values = new ArrayList();
   		results = DatabaseUtils.update(conn, sql, values.toArray());
   		sql = "DELETE FROM encounter WHERE form_id = 161";
   		values = new ArrayList();
   		results = DatabaseUtils.update(conn, sql, values.toArray());
   		if (results > 0) {
   			result = "Encounter deleted.";
   		}
   		sql = "SELECT id FROM encounter WHERE form_id = 161";
		ResultSet rs = null;
		PreparedStatement ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		while (rs.next()) {
			Long encounterId = rs.getLong("id");
			// Delete any associated EncounterValueArchive items
	   		EncounterValueArchiveDAO.deleteForEncounter(conn, encounterId);
		}
   		conn.commit();
   	} catch (Exception e) {
   		log.error(e);
   		throw new SQLException("Error deleting this record.", e.getMessage());
   	}
   	conn.setAutoCommit(true);
   	return result;
   }

   protected static ResultSet getEncountersForDrug(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {

		ResultSet rs = null;

		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}

		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, age_category, encounter.created_by AS created_by, encounter.created " +
				"FROM encounter, patient " +
				"WHERE encounter.patient_id = patient.id " +
				"AND form_id = 132\n" +
				dateRange +
				"ORDER BY created, surname";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
				}
				rs = ps.executeQuery();
			} else {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, age_category, encounter.created_by AS created_by, encounter.created " +
				"FROM encounter, patient " +
				"WHERE encounter.patient_id = patient.id " +
				"AND form_id = 132\n" +
				dateRange +
				"AND encounter.site_id = ? " +
				"ORDER BY created, surname";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
					ps.setInt(3, siteID);
				} else {
					ps.setInt(2, siteID);
				}

				rs = ps.executeQuery();
			}
		} catch (Exception ex) {
			log.error(ex);
		}

		return rs;
	}


/**
 * Gets list of stock changes (inventory from StockControl) and items dispensed to patients for item and date period.
 * @param conn
 * @param itemId
 * @param siteId
 * @param beginDate
 * @param endDate
 * @param stockChanges if null, populates with getStockChanges().
 * @param patientStockChanges pass a non-null List<StockControl> if you don't want it to execute InventoryDAO.getPatientStockChanges
 * @return List of StockControl records, sorted by sateVisit
 * @throws ClassNotFoundException
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 * @throws IOException
 */
public static List<StockControl> getStockEncounterChanges(Connection conn, Long itemId, int siteId, Date beginDate, Date endDate, List<StockControl> stockChanges, List<StockControl> patientStockChanges)
		throws ClassNotFoundException, ServletException, SQLException, ObjectNotFoundException, IOException {
	// First get all of the stock changes from StockControl.
	// This may already be populated for example by a report, which may already have stockChanges available.
	if (stockChanges == null) {
		stockChanges = (List<StockControl>) getStockChanges(conn, itemId, siteId, beginDate, endDate);
	}
	// Now get items dispensed to patients
	if (patientStockChanges == null) {
		patientStockChanges = InventoryDAO.getPatientStockChanges(conn, itemId, siteId, beginDate, endDate);
	}
	stockChanges.addAll(patientStockChanges);
	for (StockControl stockControl : stockChanges) {
		if (stockControl.getDateVisit() == null) {
			stockControl.setDateVisit(stockControl.getDate_of_record());
		}
	}

	DateVisitOrderComparator doc = new DateVisitOrderComparator();
    Collections.sort(stockChanges, doc);
	return stockChanges;
}


/**
 * Generates a summary of stock inflow and outflow.
 * @param conn
 * @param itemId
 * @param beginDate
 * @param stockChanges - generated via getStockChanges
 * @param updateBalance default: false; Updates the balance field in db. Careful!
 * @return
 * @throws ClassNotFoundException
 * @throws IOException
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 */
public static StockReport generateStockSummary(Connection conn, Long itemId, Date beginDate,
		List<StockControl> stockChanges, boolean updateBalance) throws ClassNotFoundException, IOException, ServletException,
		SQLException, ObjectNotFoundException {
	Integer balance = 0;
	Integer balanceBF = 0;
	/*StockControl beginningStockControl = getBeginningStockBalance(conn, 161, itemId, beginDate);
    Integer balanceBF = beginningStockControl.getBalance();
	Integer balance = balanceBF;
    StockControl beginningStockControlBalance = new StockControl();
    beginningStockControlBalance.setBalance(balance);
    beginningStockControlBalance.setDate_of_record(beginningStockControl.getDate_of_record());
    beginningStockControlBalance.setDateVisit(beginningStockControl.getDate_of_record());
    beginningStockControlBalance.setNotes("Beginning Balance");*/
	Integer stockControlAdditionsTotal = 0;
	Integer stockControlDeletionsTotal = 0;
	Integer stockControlIssuedTotal = 0;
	Integer negAdjustments = 0;
	Integer posAdjustments = 0;
	for (StockControl stockControl : stockChanges) {
		if (stockControl.getBalance() != null) {
			//String notes = stockControl.getNotes();
			//stockControl.setNotes(notes);
		}
		Integer changeType = stockControl.getType_of_change();
		Integer quantity = stockControl.getChange_value();
		switch (changeType) {
		case 3263:	// received
			balance = balance + quantity;
			stockControlAdditionsTotal = stockControlAdditionsTotal + quantity;
			break;
		case 3264:	// issued
			balance = balance - quantity;
			stockControlDeletionsTotal = stockControlDeletionsTotal + quantity;
			stockControlIssuedTotal = stockControlIssuedTotal + quantity;
			break;
		case 3265:	// loss
			balance = balance - quantity;
			stockControlDeletionsTotal = stockControlDeletionsTotal + quantity;
			break;
		case 3266:	// Pos. Adjust.
			balance = balance + quantity;
			stockControlAdditionsTotal = stockControlAdditionsTotal + quantity;
			posAdjustments = posAdjustments + quantity;
			break;
		case 3267:	// Neg. Adjust.
			balance = balance - quantity;
			stockControlDeletionsTotal = stockControlDeletionsTotal + quantity;
			negAdjustments = negAdjustments + quantity;
			break;
		case 3279:	// Out-of-stock
			break;
		default:
			break;
		}
		//stockControl.setBalance(balance);
		stockControl.setComputedBalance(balance);

		if (updateBalance == true) {
			Long id = stockControl.getId();
			// don't update if it's a patient item (issued)
			if (changeType != 3264) {
				String sql = "UPDATE stock_control SET BALANCE = ? WHERE id = ?";
				ArrayList values = new ArrayList();
        		values.add(balance);
        		values.add(id);
        		// we want it to throw a new Persistence exception if it fails.
        		int result = DatabaseUtils.updateThrow(conn, sql, values.toArray());
			}
		}
	}

	StockReport stockReport = new StockReport();
	stockReport.setOnHand(balance);
	stockReport.setTotalDispensed(stockControlIssuedTotal);
	stockReport.setAdditionsTotal(stockControlAdditionsTotal);
	stockReport.setDeletionsTotal(stockControlDeletionsTotal);
	stockReport.setBalanceBF(balanceBF);
	stockReport.setNegAdjustments(negAdjustments);
	stockReport.setPosAdjustments(posAdjustments);
    //stockChanges.add(0,beginningStockControlBalance);
	return stockReport;
}

/**
 * Queries all data in order to get the current balance for an item.
 * If you have entered stock as another site, note that it will not be reflected in the balance
 * if you specify another site. It is recommended to set siteId = null.
 * @param conn
 * @param itemId
 * @param siteId - runs query for all sites if siteId = null or 0.
 * @return
 * @throws ClassNotFoundException
 * @throws IOException
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 */
public static StockReport getCurrentBalance(Connection conn, Long itemId, Integer siteId) throws ClassNotFoundException, IOException, ServletException,
		SQLException, ObjectNotFoundException {
	Integer balance = 0;
	Integer stockControlAdditionsTotal = 0;
	Integer stockControlDeletionsTotal = 0;
	Integer dispensed = 0;
	Integer negAdjustments = 0;
	Integer posAdjustments = 0;
	Integer issued = 0;
	Integer losses = 0;

	String siteIdPart = "AND site_id = ? ";
	if (siteId == null || siteId == 0) {
		siteIdPart = "";
	}

	//if (itemId == 16 || itemId == 12 || itemId == 13 || itemId == 1 ||  itemId == 3) {

	String sql = "SELECT SUM(change_value) AS stockControlAdditionsTotal " +
			"FROM stock_control, encounter " +
			"WHERE encounter.id = stock_control.id " +
			"AND (type_of_change = 3263 OR type_of_change = 3266) " +
			"AND item_id = ? " + siteIdPart;
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	if (siteId == null || siteId == 0) {
	} else {
		ps.setInt(2, siteId);
	}

	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
		stockControlAdditionsTotal = rs.getInt("stockControlAdditionsTotal");
	}
	rs.close();

	sql = "SELECT SUM(change_value) AS issued " +
			"FROM stock_control, encounter " +
			"WHERE encounter.id = stock_control.id " +
			"AND type_of_change = 3264 " +
			"AND item_id = ? " + siteIdPart;
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	if (siteId == null || siteId == 0) {
	} else {
		ps.setInt(2, siteId);
	}
	rs = ps.executeQuery();
	while (rs.next()) {
		issued = rs.getInt("issued");
	}
	rs.close();
	sql = "SELECT SUM(change_value) AS losses " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND type_of_change = 3265 " +
	"AND item_id = ? " + siteIdPart;
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	if (siteId == null || siteId == 0) {
	} else {
		ps.setInt(2, siteId);
	}
	rs = ps.executeQuery();
	while (rs.next()) {
		losses = rs.getInt("losses");
	}
	rs.close();

	sql = "SELECT SUM(change_value) AS negAdjustments " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND type_of_change = 3267 " +
	"AND item_id = ? " + siteIdPart;
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	if (siteId == null || siteId == 0) {
	} else {
		ps.setInt(2, siteId);
	}
	rs = ps.executeQuery();
	while (rs.next()) {
		negAdjustments = rs.getInt("negAdjustments");
	}
	rs.close();

	String encounterSiteIdPart = "AND encounter.site_id = ? ";
	if (siteId == null || siteId == 0) {
		encounterSiteIdPart = "";
	}

	sql = "SELECT SUM(patient_item.dispensed) AS dispensed " +
	"FROM patient_item, encounter, patient " +
	"WHERE encounter.id = patient_item.encounter_id " +
	"AND encounter.patient_id = patient.id " +
	"AND item_id = ? " + encounterSiteIdPart;

	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	if (siteId == null || siteId == 0) {
	} else {
		ps.setInt(2, siteId);
	}
	rs = ps.executeQuery();
	while (rs.next()) {
		dispensed = rs.getInt("dispensed");
	}
	rs.close();

	stockControlDeletionsTotal = (issued + losses + negAdjustments);
	balance = stockControlAdditionsTotal - (stockControlDeletionsTotal + dispensed);

	StockReport stockReport = new StockReport();
	stockReport.setOnHand(balance);
	stockReport.setTotalDispensed(dispensed);
	stockReport.setAdditionsTotal(stockControlAdditionsTotal);
	stockReport.setDeletionsTotal(stockControlDeletionsTotal);
	stockReport.setBalanceBF(balance);
	stockReport.setNegAdjustments(negAdjustments);
	stockReport.setPosAdjustments(posAdjustments);
	return stockReport;
}

/**
 * Provides Balance Brought forward for a single item.
 * If doing a report on many items, use getBalanceMap instead.
 * @param conn
 * @param itemId
 * @param siteId
 * @param endDate
 * @return
 * @throws ClassNotFoundException
 * @throws IOException
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 */
public static StockReport getBalanceBF(Connection conn, Long itemId, int siteId, Date endDate) throws ClassNotFoundException, IOException, ServletException,
SQLException, ObjectNotFoundException {
	Integer balance = 0;
	Integer stockControlAdditionsTotal = 0;
	Integer stockControlDeletionsTotal = 0;
	Integer dispensed = 0;
	Integer negAdjustments = 0;
	Integer posAdjustments = 0;
	Integer issued = 0;
	Integer losses = 0;

	//if (itemId == 16 || itemId == 12 || itemId == 13 || itemId == 1 ||  itemId == 3) {

	String sql = "SELECT SUM(change_value) AS stockControlAdditionsTotal " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND (type_of_change = 3263 OR type_of_change = 3266) " +
	"AND item_id = ? " +
	"AND site_id = ? " +
	"AND date_of_record < ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	ps.setInt(2, siteId);
	ps.setDate(3, endDate);
	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
		stockControlAdditionsTotal = rs.getInt("stockControlAdditionsTotal");
	}
	// rs.close();

/*	sql = "SELECT SUM(change_value) AS issued " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND type_of_change = 3264 " +
	"AND item_id = ? " +
	"AND site_id = ? " +
	"AND date_of_record < ?";
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	ps.setInt(2, siteId);
	ps.setDate(3, endDate);
	rs = ps.executeQuery();
	while (rs.next()) {
		issued = rs.getInt("issued");
	}
	rs.close();*/

/*	sql = "SELECT SUM(change_value) AS losses " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND type_of_change = 3265 " +
	"AND item_id = ? " +
	"AND site_id = ? " +
	"AND date_of_record < ?";
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	ps.setInt(2, siteId);
	ps.setDate(3, endDate);
	rs = ps.executeQuery();
	while (rs.next()) {
		losses = rs.getInt("losses");
	}
	rs.close();*/

/*	sql = "SELECT SUM(change_value) AS negAdjustments " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND type_of_change = 3267 " +
	"AND item_id = ? " +
	"AND site_id = ? " +
	"AND date_of_record < ?";
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	ps.setInt(2, siteId);
	ps.setDate(3, endDate);
	rs = ps.executeQuery();
	while (rs.next()) {
		negAdjustments = rs.getInt("negAdjustments");
	}
	rs.close();*/

		sql = "SELECT SUM(change_value) AS stockControlDeletionsTotal " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND (type_of_change = 3264 OR type_of_change = 3265 OR type_of_change = 3267) " +
	"AND item_id = ? " +
	"AND site_id = ? " +
	"AND date_of_record < ?";
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	ps.setInt(2, siteId);
	ps.setDate(3, endDate);
	rs = ps.executeQuery();
	while (rs.next()) {
		stockControlDeletionsTotal = rs.getInt("stockControlDeletionsTotal");
	}
	// rs.close();

	sql = "SELECT SUM(patient_item.dispensed) AS dispensed " +
	"FROM patient_item, encounter, patient " +
	"WHERE encounter.id = patient_item.encounter_id " +
	"AND encounter.patient_id = patient.id " +
	"AND item_id = ? " +
	"AND encounter.site_id = ? " +
	"AND encounter.date_visit < ?";

	/*sql = "SELECT SUM(patient_item.dispensed) AS dispensed " +
	"FROM patient_item " +
	"WHERE item_id = ? ";*/
	ps = conn.prepareStatement(sql);
	ps.setLong(1, itemId);
	ps.setInt(2, siteId);
	ps.setDate(3, endDate);
	rs = ps.executeQuery();
	while (rs.next()) {
		dispensed = rs.getInt("dispensed");
	}
	rs.close();

	/*	sql = "SELECT encounter.id AS id " +
	"FROM encounter " +
	"WHERE form_id = 132\n" +
	"AND encounter.site_id = ? ";
	ps = conn.prepareStatement(sql);
	ps.setInt(1, siteId);
	rs = ps.executeQuery();
	while (rs.next()) {
		Long id = rs.getLong("id");
		String innerSql = "SELECT SUM(patient_item.dispensed) AS dispensed " +
		"FROM patient_item, encounter " +
		"WHERE patient_item.encounter_id = encounter.id " +
		"AND patient_item.item_id = ? " +
		"AND patient_item.encounter_id = ? ";
		PreparedStatement ps2 = conn.prepareStatement(innerSql);
		ps2.setLong(1, itemId);
		ps2.setLong(2, id);
		ResultSet rs2 = ps2.executeQuery();
		while (rs2.next()) {
			int dispensedItem = rs2.getInt("dispensed");
			dispensed = dispensed + dispensedItem;
		}
		rs2.close();
	}
	rs.close();*/

	//stockControlDeletionsTotal = (issued + losses + negAdjustments);
	balance = stockControlAdditionsTotal - (stockControlDeletionsTotal + dispensed);

	//log.debug("itemId: " + itemId + " BBF: " + balance);

	/*	if (itemId == 12) {


		sql = "SELECT encounter.date_visit, patient_item.dispensed AS dispensed, surname " +
		"FROM patient_item, encounter, patient " +
		"WHERE encounter.id = patient_item.encounter_id " +
		"AND encounter.patient_id = patient.id " +
		"AND item_id = ? " +
		"AND encounter.site_id = ? " +
		"ORDER BY date_visit, surname ";
		ps = conn.prepareStatement(sql);
		ps.setLong(1, itemId);
		ps.setInt(2, siteId);
		rs = ps.executeQuery();
		while (rs.next()) {
			Date dateVisit = rs.getDate("date_visit");
			Integer dispensedItem = rs.getInt("dispensed");
			String surname = rs.getString("surname");
			log.debug(dateVisit + "," + surname + "," + dispensedItem);
		}
		rs.close();
	}*/

	/*StockControl beginningStockControl = getBeginningStockBalance(conn, 161, itemId, beginDate);
    Integer balanceBF = beginningStockControl.getBalance();
	Integer balance = balanceBF;
    StockControl beginningStockControlBalance = new StockControl();
    beginningStockControlBalance.setBalance(balance);
    beginningStockControlBalance.setDate_of_record(beginningStockControl.getDate_of_record());
    beginningStockControlBalance.setDateVisit(beginningStockControl.getDate_of_record());
    beginningStockControlBalance.setNotes("Beginning Balance");*/

	StockReport stockReport = new StockReport();
	stockReport.setOnHand(balance);
	stockReport.setTotalDispensed(dispensed);
	stockReport.setAdditionsTotal(stockControlAdditionsTotal);
	stockReport.setDeletionsTotal(stockControlDeletionsTotal);
	stockReport.setBalanceBF(balance);
	stockReport.setNegAdjustments(negAdjustments);
	stockReport.setPosAdjustments(posAdjustments);
	//stockChanges.add(0,beginningStockControlBalance);
	return stockReport;
}

/**
 * For each stock item, there are StockReport values for BalanceBF(balance), OnHand(balance),
 * AdditionsTotal(stockControlAdditionsTotal);DeletionsTotal(stockControlDeletionsTotal), and TotalDispensed(dispensed).
 * @param conn
 * @param siteId - runs query for all sites if siteId = null or 0
 * @param endDate - if calculating Balance Brought forward (BBF); null is getting current Balance.
 * @return HashMap<Long,StockReport> for each stock item.
 * @throws ClassNotFoundException
 * @throws IOException
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 */
public static HashMap<Long,StockReport> getBalanceMap(Connection conn, Integer siteId,Date beginDate, Date endDate) throws ClassNotFoundException, IOException, ServletException,
SQLException, ObjectNotFoundException {
	Integer stockControlAdditionsTotal = 0;
	Integer stockControlDeletionsTotal = 0;
	Integer dispensed = 0;
	Long itemId = null;
	StockReport stockReport = null;
	
	log.debug(" this is date "+endDate);
	//if (itemId == 16 || itemId == 12 || itemId == 13 || itemId == 1 ||  itemId == 3) {
	HashMap<Long,StockReport> map = new HashMap<Long,StockReport>();
	String datePartStock = "";
	String datePartEncounter = "";
	if (endDate != null) {
		datePartStock = "AND date_of_record < ? ";
		datePartEncounter = "AND encounter.date_visit < ? ";
	}
	String siteIdPart = "AND site_id = ? ";
	if (siteId == null || siteId == 0) {
		siteIdPart = "";
	}
	log.debug(" we are sitePart ID");
/*	if (endDate != null) {
		String sql = "SELECT item_id, MIN(encounter.date_visit)  " +
		"FROM patient_item, encounter, patient " +
		"WHERE encounter.id = patient_item.encounter_id AND encounter.patient_id = patient.id  " +
		siteIdPart;
		PreparedStatement ps = conn.prepareStatement(sql);
		if (siteId == null || siteId == 0) {
			if (endDate != null) {
				ps.setDate(1, endDate);
			}
		} else {
			ps.setInt(1, siteId);
			if (endDate != null) {
				ps.setDate(2, endDate);
			}
		}
	}*/

	String sql = "SELECT item_id, SUM(change_value) AS stockControlAdditionsTotal " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND (type_of_change = 3263 OR type_of_change = 3266) " +
	siteIdPart +
	datePartStock +
	// "AND item_id <= 20 " +
	"GROUP BY item_id";
	
	PreparedStatement ps = conn.prepareStatement(sql);
	
	log.debug(" Ps1 Sql created "+endDate);
	if (siteId == null || siteId == 0) {
		
		log.debug(" site id is null ama 0");
		if (endDate != null) {
			log.debug(" date is available");
			ps.setDate(1, endDate);
		}
		
		log.debug(" we passeddate issue");
	} else {
		log.debug(" site id is this "+siteId);
		ps.setInt(1, siteId);
		if (endDate != null) {
			ps.setDate(2, endDate);
		}
	}

	ResultSet rs = ps.executeQuery();
	
	log.debug(" rs was excecuted");
	while (rs.next()) {
		itemId = rs.getLong("item_id");
		
		log.debug(" we have itemid "+itemId);
		stockControlAdditionsTotal = rs.getInt("stockControlAdditionsTotal");
		
		log.debug(" we have controlTotal "+stockControlAdditionsTotal);
		if (map.get(itemId) == null) {
			
			
			stockReport = new StockReport();
			log.debug(" we ahave loaded stockreport ");
		} else {
			stockReport = (StockReport) map.get(itemId);
		}
		stockReport.setAdditionsTotal(stockControlAdditionsTotal);

			map.put(itemId, stockReport);
		
		
		//here1
	
		
		log.debug(" we have put on map ");
	}

	 
	
	sql = "SELECT item_id,  SUM(change_value) AS stockControlDeletionsTotal " +
	"FROM stock_control, encounter " +
	"WHERE encounter.id = stock_control.id " +
	"AND (type_of_change = 3264 OR type_of_change = 3265 OR type_of_change = 3267) " +
	siteIdPart +
	datePartStock +
	//"AND item_id <= 20 " +
	"GROUP BY item_id";
	ps = conn.prepareStatement(sql);
	
	
	if (siteId == null || siteId == 0) {
		if (endDate != null) {
			
			log.debug(" date2 is available");
			ps.setDate(1, endDate);
		}
	} else {
		
		ps.setInt(1, siteId);
		if (endDate != null) {
			ps.setDate(2, endDate);
		}
	}
	rs = ps.executeQuery();
	
	log.debug(" rs2 was excecuted");
	while (rs.next()) {
		itemId = rs.getLong("item_id");
		
		log.debug(" we  have itemId2 "+itemId);
		stockControlDeletionsTotal = rs.getInt("stockControlDeletionsTotal");
		
		log.debug(" wths isdeletion total "+stockControlDeletionsTotal);
		
		
		if (map.get(itemId) == null) {
			
			log.debug(" mapitem id is null "+itemId);
			
			
			stockReport = new StockReport();
			
			
		} else {
			
			
			stockReport = (StockReport) map.get(itemId);
			
			log.debug(" we loaded stock report");
		}
		stockReport.setDeletionsTotal(stockControlDeletionsTotal);
		
		log.debug("  detelitiontotal2 was set");
		//here
		
  
		map.put(itemId, stockReport);
     
     //here1
		
		log.debug("  we mapped itemid2");
	}
	// rs.close();
	String encounterSiteIdPart = "AND encounter.site_id = ? ";
	if (siteId == null || siteId == 0) {
		
		log.debug("  site id 3 is null or 0");
		encounterSiteIdPart = "";
	}
	
	log.debug("  the encounter site id "+encounterSiteIdPart);
	//do not enable this
	//sql="CREATE INDEX MYpatient_item ON patient_item(item_id)";
	//ps = conn.prepareStatement(sql);
	//ps.executeUpdate();
	log.debug("  the index was created ");
	sql = "SELECT item_id, SUM(patient_item.dispensed) AS dispensed " +
	"FROM patient_item, encounter, patient " +
	"WHERE encounter.id = patient_item.encounter_id " +
	"AND encounter.patient_id = patient.id " +
	encounterSiteIdPart +
	datePartEncounter +
	//"AND item_id <= 20 " +
	"GROUP BY item_id";
	ps = conn.prepareStatement(sql);
	
	log.debug("  ps4 was created "+sql);
	if (siteId == null || siteId == 0) {
		
		log.debug(" site id 4 is null or 0 "+endDate);
		if (endDate != null) {
			log.debug("  date4 is not null "+endDate);
			
			ps.setDate(1, endDate);
			
			log.debug("  we set the date");
		}
	} else {
		log.debug("  site id has something >0");
		
		ps.setInt(1, siteId);
		if (endDate != null) {
			
			ps.setDate(2, endDate);
		}
	}
	
	
	try {
		//log.debug("  we are bout to Rs Ps  "+ps.getFetchSize());
		
		log.debug("  we are bout to Rs Ps  ");
		//rs = ps.executeQuery();
	
	
	
	
	
	 
	rs = ps.executeQuery();

	
	log.debug("  rs querry was created ");
	while (rs.next()) {
		log.debug("  rs querry excecuted and returning resulting result set ");
		itemId = rs.getLong("item_id");
		dispensed = rs.getInt("dispensed");
		log.debug("  item id from query:  " + itemId  + "quantity dispensed :  " + dispensed );
		if (map.get(itemId) == null) {
			stockReport = new StockReport();
		} else {
			stockReport = (StockReport) map.get(itemId);
		}
		stockReport.setTotalDispensed(dispensed);
		map.put(itemId, stockReport);
	}
	rs.close();
	}
	//
	catch (SQLException e) {
		// TODO Auto-generated catch block
		log.debug(" this is the sql beats: " + e);
		e.printStackTrace();
		
	}
	

	
	log.debug(" db operation ok");

	Set encSet = map.entrySet();
	for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
		Map.Entry entry = (Map.Entry) iterator.next();
		Long key = (Long) entry.getKey();
		stockReport = (StockReport) entry.getValue();
		Integer additionsTotal = 0;
		Integer deletionsTotal = 0;
		Integer totalDispensed = 0;
		if (stockReport.getAdditionsTotal() != null) {
			additionsTotal = stockReport.getAdditionsTotal();
		}
		if (stockReport.getDeletionsTotal() != null) {
			deletionsTotal = stockReport.getDeletionsTotal();
		}
		if (stockReport.getTotalDispensed() != null) {
			totalDispensed = stockReport.getTotalDispensed();
		}
		Integer balance = additionsTotal - (deletionsTotal + totalDispensed);
		stockReport.setBalanceBF(balance);
		stockReport.setOnHand(balance);
	}
	


	return map;
}


/**
 * Fetches a list of items dispensed for each patient for the time period and site
 * @param conn
 * @param itemId
 * @param siteId
 * @param beginDate
 * @param endDate
 * @param stockChanges
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 * @throws IOException
 */
public static List<StockControl> getPatientStockChanges(Connection conn, Long itemId, int siteId, Date beginDate, Date endDate) throws ServletException, SQLException, ObjectNotFoundException,
		IOException {
	List<StockControl> stockChanges = new ArrayList<StockControl>();
	Form encounterForm = ((Form) DynaSiteObjects.getForms().get(new Long(132)));
	String className = "org.rti.zcore.dar.gen." + StringManipulation.fixClassname(encounterForm.getName());
	Class clazz = null;
	try {
		clazz = Class.forName(className);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	ResultSet rs = null;
	rs = getPatientDispensaryEncounters(conn, siteId, beginDate, endDate);
	while (rs.next()) {
		Long encounterId = rs.getLong("id");
		Long patientId = rs.getLong("patient_id");
		String districtPatientId = rs.getString("district_patient_id");
		String firstName = rs.getString("first_name");
		String surname = rs.getString("surname");
		//Date dateVisit = rs.getDate("date_visit");
		//Integer age = rs.getInt("age_at_first_visit");
		Integer ageCategory = rs.getInt("age_category");
		int currentSiteId = rs.getInt("site_id");
		String createdBy = rs.getString("created_by");
		Timestamp created = rs.getTimestamp("created");

		EncounterData encounter = (EncounterData) PatientItemDAO.getEncounterRawValues(conn, encounterForm, "132", encounterId, clazz);
		Date dateVisit = encounter.getDateVisit();
		Map encMap = encounter.getEncounterMap();
		Set encSet = encMap.entrySet();
		for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
			Map.Entry entry = (Map.Entry) iterator.next();
			Long key = (Long) entry.getKey();
			Integer value = (Integer) entry.getValue();
			// Someone might have forgotten to enter the value
			if (value == null) {
				value = 0;
			}
			int n = 0;
			if (key != null) {
				if (itemId.longValue() == key.longValue()) {
					StockControl stockControl = new StockControl();
					stockControl.setItem_id(itemId);
					stockControl.setChange_value(value);
					// set type_of_change to type_of_change (Issued)
					stockControl.setType_of_change(3264);
					stockControl.setDate_of_record(dateVisit);
					stockControl.setPatientId(patientId);
					stockControl.setSurname(surname);
					stockControl.setFirstName(firstName);
					stockControl.setDateVisit(dateVisit);
				//	stockControl.setNotes(surname + "," + firstName);
					stockChanges.add(stockControl);
				}
			}
		}
	}
	return stockChanges;
}

/**
 * Loops through all PatientDispensaryEncounters, processes their raw values; stuffs into a list, then adds to a HashMap.
 * @param conn
 * @param siteId
 * @param beginDate
 * @param endDate
 * @return HashMap - itemId: stockChanges
 * @throws ServletException
 * @throws SQLException
 * @throws ObjectNotFoundException
 * @throws IOException
 */
public static HashMap<Long, List<StockControl>> getPatientStockMap(Connection conn, int siteId, Date beginDate, Date endDate) throws ServletException, SQLException, ObjectNotFoundException,
IOException {
	HashMap<Long, List<StockControl>> stockMap = new HashMap<Long, List<StockControl>>();
	List<StockControl> stockChanges = new ArrayList<StockControl>();
	Form encounterForm = ((Form) DynaSiteObjects.getForms().get(new Long(132)));
	String className = "org.rti.zcore.dar.gen." + StringManipulation.fixClassname(encounterForm.getName());
	Class clazz = null;
	try {
		clazz = Class.forName(className);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	ResultSet rs = null;
    //log.debug("Before getPatientDispensaryEncounters:" + DateUtils.getTime());
	rs = getPatientDispensaryEncounters(conn, siteId, beginDate, endDate);
    //log.debug("Before looping through PatientDispensaryEncounters rs:" + DateUtils.getTime());
	while (rs.next()) {
		Long encounterId = rs.getLong("id");
		Long patientId = rs.getLong("patient_id");
		String firstName = rs.getString("first_name");
		String surname = rs.getString("surname");
		EncounterData encounter = (EncounterData) PatientItemDAO.getEncounterRawValues(conn, encounterForm, "132", encounterId, clazz);
		Date dateVisit = encounter.getDateVisit();
		Map encMap = encounter.getEncounterMap();
		Set encSet = encMap.entrySet();
		for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
			Map.Entry entry = (Map.Entry) iterator.next();
			Long key = (Long) entry.getKey();
			Integer value = (Integer) entry.getValue();
			// Someone might have forgotten to enter the value
			if (value == null) {
				value = 0;
			}
			int n = 0;
			if (key != null) {
				if (stockMap.get(key) == null) {
					stockChanges = new ArrayList<StockControl>();
				} else {
					stockChanges = stockMap.get(key);
				}
				//if (itemId.longValue() == key.longValue()) {
				StockControl stockControl = new StockControl();
				stockControl.setItem_id(key);
				stockControl.setChange_value(value);
				// set type_of_change to type_of_change (Issued)
				stockControl.setType_of_change(3264);
				stockControl.setDate_of_record(dateVisit);
				stockControl.setPatientId(patientId);
				stockControl.setSurname(surname);
				stockControl.setFirstName(firstName);
				stockControl.setDateVisit(dateVisit);
				//stockControl.setNotes(surname + "," + firstName);
				stockChanges.add(stockControl);
				stockMap.put(key, stockChanges);
			}
			//}
		}
	}
	return stockMap;
}


/**
 * Retrieve all Encounter records for this form 132 - Patient dispensary
 * Order by date_visit.
 * @param conn
 * @param siteID
 * @param beginDate
 * @param endDate - may be null.
 * @return
 * @throws ServletException
 */
public static ResultSet getPatientDispensaryEncounters(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {

	ResultSet rs = null;

	String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
	if (endDate == null) {
		dateRange = "AND date_visit = ?";
	}

	try {
		if (siteID == 0) {
			String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
			"first_name, surname, encounter.site_id, age_at_first_visit, age_category, encounter.created_by AS created_by, encounter.created " +
			"FROM encounter, patient " +
			"WHERE encounter.patient_id = patient.id " +
			"AND form_id = 132\n" +
			dateRange +
			"ORDER BY date_visit, surname";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setDate(1, beginDate);
			if (endDate != null) {
				ps.setDate(2, endDate);
			}
			rs = ps.executeQuery();
		} else {
			String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
			"first_name, surname, encounter.site_id, age_at_first_visit, age_category, encounter.created_by AS created_by, encounter.created " +
			"FROM encounter, patient " +
			"WHERE encounter.patient_id = patient.id " +
			"AND form_id = 132\n" +
			dateRange +
			"AND encounter.site_id = ? " +
			"ORDER BY date_visit, surname";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setDate(1, beginDate);
			if (endDate != null) {
				ps.setDate(2, endDate);
				ps.setInt(3, siteID);
			} else {
				ps.setInt(2, siteID);
			}

			rs = ps.executeQuery();
		}
	} catch (Exception ex) {
		log.error(ex);
	}

	return rs;
}
}

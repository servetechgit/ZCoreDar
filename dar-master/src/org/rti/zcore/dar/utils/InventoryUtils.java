/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.utils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Set;

import javax.servlet.ServletException;

import junit.runner.Version;

import org.apache.commons.dbutils.QueryLoader;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Constants;
import org.rti.zcore.dao.EncounterValueArchiveDAO;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.gen.Regimen;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.DailyActivityReport;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.utils.DatabaseUtils;

public class InventoryUtils {
	
	/**
	 * Commons Logging instance.
	 */
	static Integer balanceBF=0;
	static Integer received = 0;
	static Integer loss = 0;
	static Integer dispensed = 0;
	static Integer posAd = 0;
	static Integer negAd = 0;
	static Integer balanceCF=0;
	Integer days_out_of_stock=0;
	static Integer quantity_for_resupply=0;
	Integer quantity_for_new_patients=0;
	Integer total_req_restock=0;
	static Integer quantity_expired=0;
	static Date expiry_date;
	static  Integer outDays=0;
	public static Log log = LogFactory.getFactory().getInstance(InventoryUtils.class);

	/**
	 * Checks if expiry date is less than the amount specified.
	 *
	 * @param date1
	 * @param expiry
	 * @ param amount the amount of date or time to be added to the field.
	 * @return
	 */
	public static boolean checkExpiry(java.util.Date date1, java.util.Date expiry, int amount) {

    	boolean result = false;

    	Calendar cal1 = new GregorianCalendar();
    	cal1.setTime(date1);
    	cal1.add(java.util.Calendar.MONTH, +amount);
		long dateInFuture = cal1.getTime().getTime();

    	// date to compare to
    	Calendar cal2 = new GregorianCalendar();
    	cal2.setTime(expiry);
    	long expiry_date_value = cal2.getTime().getTime();

    	if (expiry_date_value < dateInFuture) {
    		result = true;
    	}
    	return result;
    }

	/**
	 * Populates stockReportMap with balances, losses, received, and onHand for each stock item
	 * Provides report on stock by looping through itemMap.
	 * LinkedHashMap is used to preserve the insertion order from the itemMap for display purposes.
	 * @should populate Stock Report Maps
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @param itemMap 
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	//Method Changed By servetech Systems.........from Version 1.2e(Meshack) to 1.2f(Bolo)  
	public static LinkedHashMap<String, StockReport> populateStockReportMaps(
			Connection conn,
			Date beginDate,
			Date endDate, 
			int siteId,
			LinkedHashMap<Long,Item> itemMap) 
			
			throws ClassNotFoundException,
			IOException,
			ServletException,
			SQLException,
			ObjectNotFoundException  
			
			{
		String sql;
		LinkedHashMap<String,StockReport> stockReportMap = new LinkedHashMap<String,StockReport>();
		System.out.println("Obtained all the stockReportMap");
		Set<Entry<Long,Item>> itemSet =  itemMap.entrySet();
		for (Entry<Long, Item> entry : itemSet) {
		//for (DropdownItem dropdownItem : list) {
			//Long itemId = Long.valueOf(dropdownItem.getDropdownId());
			//Map.Entry entry = (Map.Entry) iterator.next();
			Long itemId = entry.getKey();
			Item item = entry.getValue();
			String code = item.getCode().trim().replace(" ", "_");
			//Long itemId = item.getId();
			System.out.println("Item Id "+itemId+" is for Item "+item.getName());
			balanceBF=getbalanceBroughtFore(conn,itemId,beginDate);
			received = getReceivedDrugs(conn,itemId,beginDate,endDate);
			dispensed =getDispesed(conn, itemId,beginDate,endDate);
			loss = getLost(conn, itemId,beginDate,endDate);;
			posAd = getPosAdjust(conn, itemId,beginDate,endDate);;
			negAd = getNegAdjust(conn, itemId,beginDate,endDate);;
			balanceCF=getCurrentBalance();
			setExpired(conn,itemId);
			
			// keep the report easy-to-read - not a bunch of zeros.
			if (loss == 0) {
				loss = null;
			}
			if (received == 0) {
				received = null;
			}
			if (balanceBF == 0) {
				balanceBF = null;
			}

			if (balanceCF == 0) {
				if (balanceCF != null) {
					balanceCF = 0;
				} else {
					balanceCF = null;
				}
			}
			if (negAd == 0) {
				negAd = null;
			}
			if (posAd == 0) {
				posAd = null;
			}
			if (dispensed == 0) {
				dispensed = null;
			}
			if (balanceCF == 0) {
				balanceCF = null;
			}if (outDays == 0) {
				outDays =  null;
			}
			if (quantity_for_resupply == 0) {
				quantity_for_resupply =  null;
			}
			
			StockReport itemStockReport = new StockReport();
			itemStockReport.setId(itemId);
			itemStockReport.setName(item.getName());
			itemStockReport.setUnits(item.getUnit());
			itemStockReport.setItem_group_id(item.getItem_group_id());
			itemStockReport.setBalanceBF(balanceBF);
			itemStockReport.setLosses(loss);
			itemStockReport.setReceived(received);
			itemStockReport.setTotalDispensed(dispensed);
			itemStockReport.setNegAdjustments(negAd);
			itemStockReport.setPosAdjustments(posAd);
			itemStockReport.setDaysOutOfStock(outDays);
			itemStockReport.setQuantity6MonthsExpired(quantity_expired);
			itemStockReport.setExpiryDate(expiry_date);
			itemStockReport.setBalanceCF(balanceCF);
			itemStockReport.setQuantityRequiredResupply(quantity_for_resupply);
			
			
			stockReportMap.put("item" + code, itemStockReport);
			//log.debug("item" + code + ": " + itemStockReport.getReceived());
		}
		return stockReportMap;
	}

	/**
	 * Retrieve all Encounter records for this form 132 - Patient dispensary
	 * Joins with the patient table so you can use some of the patient fields.
	 * TODO: May be able to remove the join with patient.
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ServletException
	 */
	//REPORT ADJUSTMENTS BY SERVTECH SYSTEMS................................................................................
	public static int getbalanceBroughtFore(Connection conn,Long itemId,Date startDate){
		int last_day=0;
		outDays=0;
		balanceCF=0;
	   	try {
	   		
	   		String sql = " select max(date_of_record) as date from " +
	   				" app.stock_control where date_of_record< '"+startDate+"'" +
	   			    " and item_id= "+itemId;
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			if(rs.getDate("date")!=null){
				last_day=rs.getDate("date").getDay();
			ps = conn.prepareStatement("select balance from stock_control " +
					" where date_of_record='"+rs.getDate("date")+"'" +
					" and item_id= "+itemId);
			    rs = ps.executeQuery();
			
			while(rs.next())
				balanceBF = rs.getInt("balance");
			if(balanceBF==0){
				outDays=30-last_day;
			}
			}else {balanceBF =0;
			outDays=0;}
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
		return balanceBF;
	}
    public static int getReceivedDrugs(Connection conn,Long itemId,Date startDate,Date endDate){
    	
	   	try {
	   		
	   		String sql = " select sum(change_value) as balance from app.stock_control " +
	   				     " where  type_of_change=3263 " +
	   				     " and item_id="+itemId+" " +
	   				     " and date_of_record>='"+startDate+"' " +
	   				     " and date_of_record<='"+endDate+"' ";
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
				received = rs.getInt("balance");
			
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
		return received;
   }

    public static int getDispesed(Connection conn,Long itemId,Date startDate,Date endDate){
    	int  dispensed=0;
	   	try {
	   		
	   		String sql = " select sum(dispensed) as balance from app.patient_item,app.encounter where " +
	   				     " item_id="+itemId+" "+
	   				     " and encounter.date_visit >='"+startDate+"' and encounter.date_visit <='"+endDate+"' " +
	   				     " and encounter.id=patient_item.encounter_id ";
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
				dispensed = rs.getInt("balance");
			System.out.println("Dispensed "+dispensed);
			
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
		return dispensed;
	}
 public static int getLost(Connection conn,Long itemId,Date startDate,Date endDate){
	
	   	try {
	   		
	   		String sql = " select sum(change_value) as balance from app.stock_control where " +
	   				     " type_of_change=3265 " +
	   				     " and item_id="+itemId+" "+
	   				     " and date_of_record>='"+startDate+"' and date_of_record<='"+endDate+"' ";
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
				loss = rs.getInt("balance");
			
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
		return loss;
	}
 public static int setExpired(Connection conn,Long itemId){
		
	   	try {
	   		
	   		String sql = "select expiry_date, sum(change_value) as size_received from app.stock_control "+ 
	   		" where (("+ 
	   				"( MONTH(expiry_date)-MONTH(CURRENT_DATE))<=6 AND "+
	   				 "YEAR(expiry_date)=YEAR(CURRENT_DATE)  AND CURRENT_DATE < expiry_date ) "+
	   				" OR( "+  
	   				"((12-MONTH(CURRENT_DATE)) + MONTH(expiry_date))<=6   AND "+
	   				 "YEAR(CURRENT_DATE)>YEAR (expiry_date)  AND CURRENT_DATE < expiry_date "+ 
	   				  "))  AND TYPE_OF_CHANGE=3263 and item_id="+itemId+" GROUP BY item_id,expiry_date";
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				expiry_date  = rs.getDate("expiry_date");
				quantity_expired  = rs.getInt("size_received");
			}else {
				expiry_date  = null;
				quantity_expired  = null;
				
			}
			
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
		return loss;
	}
 public static String getCurrentDate(){
     String date ="";
         
         int mon= new java.util.Date().getMonth()+1;
         int day=new java.util.Date().getDate();
         int year=new java.util.Date().getYear()+1900;
         if(day>9&&mon>9)
         return year+"-"+mon+"-"+day;
         else if(mon>9&&day<10)
         return year+"-"+mon+"-0"+day;
         else if(mon<10&&day>9)
         return year+"-0"+mon+"-"+day;
         else //(mon<9&&day<9)
         return year+"-0"+mon+"-0"+day;
      }
 public static int getPosAdjust(Connection conn,Long itemId,Date startDate,Date endDate){
	 
	   	try {
	   		
	   		String sql = " select sum(change_value) as balance from app.stock_control where " +
	   				     " type_of_change=3266 " +
	   				     " and item_id="+itemId+" "+
	   				     " and date_of_record>='"+startDate+"' and date_of_record<='"+endDate+"' ";
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
				posAd = rs.getInt("balance");
			
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
	   	balanceCF=+posAd;
		return posAd;
	}
 public static int getNegAdjust(Connection conn,Long itemId,Date startDate,Date endDate){
	 negAd=0;
	   	try {
	   		
	   		String sql = " select sum(change_value) as balance from app.stock_control where " +
	   				     " type_of_change=3267 " +
	   				     " and item_id="+itemId+" "+
	   				     " and date_of_record>='"+startDate+"' and date_of_record<='"+endDate+"' ";
			ResultSet rs = null;
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
				negAd = rs.getInt("balance");
			
	   	} catch (Exception e) {
	   		log.error(e);
	   	}
	   	
		return negAd;
	}
 public static int getCurrentBalance(){
	 int stock_in=balanceBF+received+posAd;
	 int stock_out= dispensed+negAd+loss;
	 balanceCF=stock_in-stock_out;
	 quantity_for_resupply=(dispensed*2)-balanceCF;
		System.out.println("Openning stock "+balanceBF+"Stock in "+stock_in+" Stock out "+stock_out+" Resupply Value "+quantity_for_resupply);
		return balanceCF;
		
	}
 
	//END SERVTECH
	public static ResultSet getPatientDispensaryEncounters(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {
	
		ResultSet rs = null;
	
		String dateRange = "AND date_visit >= '"+beginDate+"' AND date_visit <= '"+endDate+"' ";
		if (endDate == null) {
			dateRange = "AND date_visit >= '"+beginDate+"' AND date_visit <= '"+beginDate+"' ";
		}
	
		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id," +
						" date_visit, patient_id, district_patient_id, " +
				" first_name, surname, encounter.site_id, age_at_first_visit, age_category, sex, " +
				" encounter.created_by AS created_by, encounter.created " +
				" FROM app.encounter, app.patient " +
				" WHERE encounter.patient_id = patient.id " +
				" AND form_id = 132" +
				dateRange +
				" ORDER BY created, surname";
			PreparedStatement ps = conn.prepareStatement(sql);
			
				rs = ps.executeQuery();
			} else {
				String sql = " SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				" first_name, surname, encounter.site_id, age_at_first_visit, age_category, sex, " +
				" encounter.created_by AS created_by, encounter.created " +
				" FROM app.encounter, app.patient " +
				" WHERE encounter.patient_id = patient.id " +
				" AND form_id = 132 " +
				dateRange +
				" AND encounter.site_id =  " +siteID+" "+
				" ORDER BY created, surname";
				PreparedStatement ps = conn.prepareStatement(sql);
			    rs = ps.executeQuery();
			}
		} catch (Exception ex) {
			DailyActivityReport.log.error(ex);
		}
	
		return rs;
	}

	/**
	 * 
	 * @param conn
	 * @return map of all Items in database ORDER BY item.name
	 * @should return map of items
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	public static LinkedHashMap<Long, Item> populateItemMap(Connection conn) throws ClassNotFoundException,
			IOException, ServletException, SQLException,
			ObjectNotFoundException {
		String sql;
		LinkedHashMap<Long, Item> itemMap = new LinkedHashMap<Long, Item>();
		try {
			List<Item> items = null;
			Map queries = QueryLoader.instance().load("/" + Constants.SQL_GENERATED_PROPERTIES);
			sql = (String) queries.get("SQL_RETRIEVE_ALL_ADMIN131") + " ORDER BY item.name";
			ArrayList values = new ArrayList();
			items = DatabaseUtils.getList(conn, Item.class, sql, values);
			for (Item item : items) {
				Long itemId = item.getId();
				//String code = item.getCode();
				itemMap.put(itemId, item);
			}
		} catch (SQLException e) {
			DailyActivityReport.log.error(e);
			e.printStackTrace();
		}
		return itemMap;
	}
	
	/**
	 * Map of all regimens in the database
	 * @param conn
	 * @return LinkedHashMap<regimenCode:Regimen>
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	public static LinkedHashMap<String, Regimen> populateRegimenMap(Connection conn) throws ClassNotFoundException,
	IOException, ServletException, SQLException,
	ObjectNotFoundException {
		String sql;
		LinkedHashMap<String, Regimen> regimenMap = new LinkedHashMap<String, Regimen>();
		try {
			List<Regimen> items = null;
			Map queries = QueryLoader.instance().load("/" + Constants.SQL_GENERATED_PROPERTIES);
			sql = (String) queries.get("SQL_RETRIEVE_ALL_ADMIN129") + " ORDER BY regimen.name";
			ArrayList values = new ArrayList();
			items = DatabaseUtils.getList(conn, Regimen.class, sql, values);
			for (Regimen item : items) {
				//Long itemId = item.getId();
				String code = item.getCode();
				regimenMap.put(code, item);
			}
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
		}
		return regimenMap;
	}
	
	/**
	 * Produces a map of Items based on the sorting of the codeList.
	 * Queries the item table using the code from the codeList.
	 * @param conn
	 * @param codeList
	 * @return map of Items in the order of the codeList.
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	public static LinkedHashMap<Long, Item> populateItemMap(Connection conn, ArrayList<String> codeList) throws ClassNotFoundException,
	IOException, ServletException, SQLException,
	ObjectNotFoundException {
		String sql;
		LinkedHashMap<Long, Item> itemMap = new LinkedHashMap<Long, Item>();
		try {
			Map queries = QueryLoader.instance().load("/" + Constants.SQL_GENERATED_PROPERTIES);
			sql = "SELECT id, code AS code, name AS name, item_group_id AS item_group_id, " +
					"unit AS unit, pack_size AS pack_size, use_in_report AS use_in_report " +
					"FROM item WHERE TRIM(code) = ?";
			for (String code : codeList) {
				ArrayList values = new ArrayList();
				//String[] categoryPipeCodeArray = categoryPipeCode.split(":");
				//String category = categoryPipeCodeArray[0];
				//String code = categoryPipeCodeArray[1];
				String codeTruncated = code.replace("item", "");
				values.add(codeTruncated);
				Item item;
				try {
					item = (Item) DatabaseUtils.getBean(conn, Item.class, sql, values);
					itemMap.put(item.getId(), item);
				} catch (ObjectNotFoundException e) {
					log.debug("Code: " + code + " is not in the item table.");
				}
			}
		} catch (SQLException e) {
			DailyActivityReport.log.error(e);
			e.printStackTrace();
		}
		return itemMap;
	}

	public static ResultSet connectbug(String sql)
	  {
		Connection con = null;
	    java.sql.Statement st = null;
	    ResultSet rs = null;
	    

	    String url = "jdbc:postgresql://localhost/zeprs";
	    String user = "postgres";
	    String password = "lakeatts123";

	    try {
	        con = DriverManager.getConnection(url, user, password);
	        st = con.createStatement();
	        rs = st.executeQuery(sql);



	    } catch (SQLException ex) {
	       // Logger lgr = Logger.getLogger(Version.class.getName());
	       System.out.println ( ex.getMessage());

	    } 
	        
	    
	    return rs;
	     }
	public void close(Connection con,
	java.sql.Statement st ,
	ResultSet rs ){
		
		try {
	        if (rs != null) {
	            rs.close();
	        }
	        if (st != null) {
	            st.close();
	        }
	        if (con != null) {
	            con.close();
	        }

	    } catch (SQLException ex) {
	        Logger lgr = Logger.getLogger(Version.class.getName());
	        lgr.log(Level.WARNING, ex.getMessage(), ex);
	    }
	}
	  }
	   
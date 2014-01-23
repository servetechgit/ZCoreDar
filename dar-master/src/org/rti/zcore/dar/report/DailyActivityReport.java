/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.Register;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.dao.PatientItemDAO;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.report.valueobject.ARTPatient;
import org.rti.zcore.dar.report.valueobject.ARTReport;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.dar.utils.TextFile;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.sort.CreatedComparator;

/**
 * @author ckelley
 */
public class DailyActivityReport extends Register {

	/**
	 * Commons Logging instance.
	 */
	public static Log log = LogFactory.getFactory().getInstance(DailyActivityReport.class);
    private static ArrayList ids = new ArrayList(); //ADDED BY SERVTECH sYSTEMS
	private String reportMonth;
	private String reportYear;
	private String type;
	private ARTPatient balanceBF;
	private ARTPatient received;
	private ARTPatient onHand;
	private ARTPatient losses;
	private ARTPatient balanceCF;
	private ARTReport artRegimenReport;
	private LinkedHashMap<Long, Item> itemMap;
	private LinkedHashMap<String, StockReport> stockReportMap;
	private ArrayList<StockReport> displayStockReportList = new ArrayList<StockReport>();

	public DailyActivityReport() {
		super();
	}

	/**
	 *
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 */
	public void getPatientRegister(Date beginDate, Date endDate, int siteId) {

		
		String sql = null;
		

		if (endDate == null) {
			endDate = beginDate;
		}
		//log.debug("Start report:" + DateUtils.getTime());
		Connection conn = null;
		try {
			conn = DatabaseUtils.getZEPRSConnection(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);
			System.out.println(conn.getMetaData().getUserName());
			System.out.println(conn.getMetaData().getURL());
			System.out.println(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);
			// Process report definitions
			String reportName = this.getType();
			System.out.println("Gotten the report type "+reportName);
			itemMap = getItemMapForReport(conn, reportName);
			System.out.println("Executing ItemMap "+beginDate+" >>>> "+endDate+" connection>> "+conn+" Itrmmap>> "+itemMap+" site id>> "+siteId);
			stockReportMap = InventoryUtils.populateStockReportMaps(conn, beginDate, endDate, siteId, itemMap);
			System.out.println("Executed Stock Report Map");
			artRegimenReport = assembleArtRegimenReport(conn, beginDate, endDate, siteId, stockReportMap, itemMap);
			System.out.println("Executing Stock Art Regimen Report");
			// Sort out the view spec
			ArrayList<StockReport> reportDisplayList = new ArrayList<StockReport>();
			String filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr.txt";
			System.out.println("Executed initiolization of filename "+filename);
			
			for(String line : new TextFile(filename)) {
		    	//System.out.println(line);
		    	String[] lineArray = line.split("\\|");
		    	String displayCategory = lineArray[0];
		    	if (lineArray[0].startsWith("stock")) {
		    		String code = lineArray[1];
			    	StockReport stockReport = stockReportMap.get(code);
			    	if (stockReport != null) {
			    		stockReport.setDisplayCategory(displayCategory);
				    	reportDisplayList.add(stockReport);
			    	}
		    	}
		    }
			System.out.println("Finished for iter "+filename);
			
		    displayStockReportList.addAll(reportDisplayList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				log.error(e);
			}
		}
		//log.debug("Finished report:" + DateUtils.getTime());

	}

	/**
	 * Based on the reportName, fetches the report definition and populates the itemMap
	 * only with drugs for that report.
	 * LinkedHashMap is used to preserve the insertion order from the codeList, which is from a text file.
	 * If the report is not specified, provides all drugs in the itemMap.
	 * @param conn
	 * @param reportName
	 * @return
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 */
	public static LinkedHashMap<Long, Item> getItemMapForReport(Connection conn, String reportName) throws ClassNotFoundException,
			IOException, ServletException, SQLException,
			ObjectNotFoundException {
		LinkedHashMap<Long, Item> itemMap = null;
		String reportDefinitionFileName = null;
		ArrayList<String> codeList = new ArrayList<String>();
		String sectionName = "";
		if (reportName.equals("CDRRArtReport")) {
			reportDefinitionFileName = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr.txt";
			for(String line : new TextFile(reportDefinitionFileName)) {
		    	//System.out.println(line);
		    	String[] lineArray = line.split("\\|");
		    	if (!sectionName.equals(lineArray[0])) {
		    		sectionName = lineArray[0];
		    	} else {
		    		if (lineArray[0].equals("stock_adultFDC")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	} else if (lineArray[0].equals("stock_adultSD")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	} else if (lineArray[0].equals("stock_paed1")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	} else if (lineArray[0].equals("stock_paed2")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	} else if (lineArray[0].equals("stock_misc")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	}
		    	}
			}
			itemMap = InventoryUtils.populateItemMap(conn, codeList);
		} else if (reportName.equals("ARTAdultDailyActivityReport")) {
			reportDefinitionFileName = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr.txt";
			for(String line : new TextFile(reportDefinitionFileName)) {
		    	//System.out.println(line);
		    	String[] lineArray = line.split("\\|");
		    	if (!sectionName.equals(lineArray[0])) {
		    		sectionName = lineArray[0];
		    	} else {
		    		if (lineArray[0].equals("stock_adultFDC")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	} else if (lineArray[0].equals("stock_adultSD")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	}
		    	}
			} 
			itemMap = InventoryUtils.populateItemMap(conn, codeList);
		} else if (reportName.equals("ARTChildDailyActivityReport")) {
			reportDefinitionFileName = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr.txt";
			for(String line : new TextFile(reportDefinitionFileName)) {
		    	//System.out.println(line);
		    	String[] lineArray = line.split("\\|");
		    	if (!sectionName.equals(lineArray[0])) {
		    		sectionName = lineArray[0];
		    	} else {
		    		 if (lineArray[0].equals("stock_paed1")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	} 
		    		/* else if (lineArray[0].equals("paed2")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	}*/
		    	}
			} 
			itemMap = InventoryUtils.populateItemMap(conn, codeList);
		} else if (reportName.equals("CDRROIReport")) {
			reportDefinitionFileName = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr-oi.txt";
			for(String line : new TextFile(reportDefinitionFileName)) {
				//System.out.println(line);
				String[] lineArray = line.split("\\|");
				if (!sectionName.equals(lineArray[0])) {
					sectionName = lineArray[0];
				} else {
					if (lineArray[0].equals("stock_oi")) {
						String code = lineArray[1];
						codeList.add(code);
					} 
					/* else if (lineArray[0].equals("paed2")) {
			    		String code = lineArray[1];
			    		codeList.add(code);
			    	}*/
				}
			} 
			itemMap = InventoryUtils.populateItemMap(conn, codeList);
		} else {
			itemMap = InventoryUtils.populateItemMap(conn);
		}
		return itemMap;
	}

	/**
	 * You must first populate the stockReportMap and itemMap. 
	 * Provides regimenReportMap (amounts for each regimen) and a list of patients, which can be used to populate a registry.
	 * Populates a patientArvMap while looping through the PatientDispensaryEncounter by using the getPatientArtRegimen method
	 * Populates totalDispensed in stockReportMap
	 * 
	 * Also populates other fields in the ARTRegimenReport including TotalAdultsDispensed
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @param stockReportMap
	 * @param itemMap
	 * @return
	 * @throws ServletException
	 * @throws ObjectNotFoundException
	 * @throws IOException
	 */
	public static ARTReport assembleArtRegimenReport(Connection conn, Date beginDate,
			Date endDate, int siteId, LinkedHashMap<String,StockReport> stockReportMap, LinkedHashMap<Long,Item> itemMap) throws ServletException, ObjectNotFoundException,
			IOException, SQLException {
		
		Form encounterForm = ((Form) DynaSiteObjects.getForms().get(new Long(132)));
		String className = "org.rti.zcore.dar.gen." + StringManipulation.fixClassname(encounterForm.getName());
		Class clazz = null;
		try {
			clazz = Class.forName(className);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		// For each patient, load the report class and add this patient to the list
		// also increment the total dispensed values
		// totalDispensed = new ARTAdultPatient();
		ARTReport artRegimenReport = new ARTReport();
		HashMap<Long, String> patientArvMap = new HashMap<Long, String>();
		HashMap<String, Integer> regimenReportMap = new HashMap<String, Integer>();
		SortedSet<ARTPatient> adults = new TreeSet<ARTPatient>(new CreatedComparator());
		SortedSet<ARTPatient> children = new TreeSet<ARTPatient>(new CreatedComparator());
				 
		ResultSet rs = null;
		try {
			System.out.println("headed to getPatientDispensaryEncounters");
		ids=	getPatientEncounterIdsForPeriod(conn, siteId, beginDate, endDate);
			//'rs = InventoryUtils.getPatientDispensaryEncounters(conn, siteId, beginDate, endDate);
			System.out.println("out of getPatientDispensaryEncounters");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		int i=0;
		while (i<ids.size()) {
			
			rs = getTheRestOfDetails(conn, siteId, beginDate, endDate,ids.get(i));
			rs.next();
			try {
				Long encounterId = (Long) ids.get(i);
				Long patientId = rs.getLong("patient_id");
				String districtPatientId = rs.getString("district_patient_id");
				String firstName = rs.getString("first_name");
				String surname = rs.getString("surname");
				Date dateVisit = rs.getDate("date_visit");
				//Integer age = rs.getInt("age_at_first_visit");
				Integer ageCategory = rs.getInt("age_category");
				int currentSiteId = rs.getInt("site_id");
				String createdBy = rs.getString("created_by");
				Timestamp created = rs.getTimestamp("created");
				int sex = rs.getInt("sex");

				ARTPatient patient = new ARTPatient();

				patient.setEncounterId(encounterId);
				patient.setPatientId(patientId);
				patient.setClientId(districtPatientId);
				patient.setFirstName(firstName);
				patient.setSurname(surname);
				patient.setDateVisit(dateVisit);
				patient.setSiteId(currentSiteId);
				patient.setPharmacist(createdBy);
				patient.setCreated(created);
				patient.setSex(sex);

				switch (ageCategory) {
				case 3283:
					patient.setChildOrAdult("A");
					break;
				case 3284:
					patient.setChildOrAdult("C");
					break;
				default:
					patient.setChildOrAdult("A");
					break;
				}
				System.out.println("out of PatientItemDAO.getEncounterRawValues");
				EncounterData encounter = (EncounterData) PatientItemDAO.getEncounterRawValues(conn, encounterForm, "132", encounterId, clazz);
				System.out.println("out of PatientItemDAO.getEncounterRawValues");
				Map encMap = encounter.getEncounterMap();
				Set encSet = encMap.entrySet();
				boolean includePatientInReport = false;

				HashMap<String, Integer> patientDispensed = new HashMap<String, Integer>();

				for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
					Map.Entry entry = (Map.Entry) iterator.next();
					Long key = (Long) entry.getKey();
					Integer value = (Integer) entry.getValue();
					// Someone might have forgotten to enter the value
					if (value == null) {
						value = 0;
					}
					if (key != null) {
						int n = 0;
						Item item = itemMap.get(key);
						//log.debug("item " + key + " dispensed to " + patient.getSurname());
						if (item != null) {
							String code = item.getCode().trim().replace(" ", "_");
							patientDispensed.put("item" + code, value);
							//log.debug("item " + code + " amount: " + value + " dispensed to " + patient.getSurname());
							StockReport stockReport = stockReportMap.get("item" + code);
							Integer itemDispensed = stockReport.getTotalDispensed();
							if (itemDispensed != null) {
								n = itemDispensed + value;
							} else {
								n = value;
							}
							//totalDispensed.setStavudine_LamivudineFDCTabs_30_150mg(n);
							//patientDispensed.put("item" + code, n);
							//stockReport.setTotalDispensed(n);
							includePatientInReport = true;
							//log.debug("item " + code + " dispensed to " + patient.getSurname());
						}
					}
				}

				patient.setTotalStockDispensed(patientDispensed);

				if (patientArvMap.get(patientId) == null) {
					//if (includePatientInReport == true) {
						try {System.out.println("out of ZEPRSUtils.getPatientArtRegimen");
							ResultSet artRs = ZEPRSUtils.getPatientArtRegimen(conn, patientId, beginDate, endDate);
							System.out.println("out of ZEPRSUtils.getPatientArtRegimen");
							//int totalAdultsDispensed = 0;
							while (artRs.next()) {
								String code = artRs.getString("code");
								patient.setArvRegimenCode(code);
								//if (patientArvMap.get(patientId) == null) {
								patientArvMap.put(patientId, code);
								if (patient.getChildOrAdult().equals("A")) {
									int n = artRegimenReport.getTotalAdultsDispensed();
									n++;
									artRegimenReport.setTotalAdultsDispensed(n);
								} else if (patient.getChildOrAdult().equals("C")) {
									int n = artRegimenReport.getTotalChildrenDispensed();
									n++;
									artRegimenReport.setTotalChildrenDispensed(n);
								}
								// check if this is the first visit - there might be multiples ones for this encounter
								Date firstVisit = EncountersDAO.getFirstVisit(conn, patientId);
								if (firstVisit.getTime() == dateVisit.getTime()) {
									patient.setRevisit(false);
									switch (sex) {
									case 1:
										int n = artRegimenReport.getTotalFemalesNew();
										n++;
										artRegimenReport.setTotalFemalesNew(n);
									case 2:
										n = artRegimenReport.getTotalMalesNew();
										n++;
										artRegimenReport.setTotalMalesNew(n);
									}
									if (patient.getChildOrAdult().equals("A")) {
										int n = artRegimenReport.getTotalAdultsNew();
										n++;
										artRegimenReport.setTotalAdultsNew(n);
									} else if (patient.getChildOrAdult().equals("C")) {
										int n = artRegimenReport.getTotalChildrenNew();
										n++;
										artRegimenReport.setTotalChildrenNew(n);
									}
								} else {
									patient.setRevisit(true);
									switch (sex) {
									case 1:
										int n = artRegimenReport.getTotalFemalesRevisit();
										n++;
										artRegimenReport.setTotalFemalesRevisit(n);
									case 2:
										n = artRegimenReport.getTotalMalesRevisit();
										n++;
										artRegimenReport.setTotalMalesRevisit(n);
									}
									if (patient.getChildOrAdult().equals("A")) {
										int n = artRegimenReport.getTotalAdultsRevisit();
										n++;
										artRegimenReport.setTotalAdultsRevisit(n);
									} else if (patient.getChildOrAdult().equals("C")) {
										int n = artRegimenReport.getTotalChildrenRevisit();
										n++;
										artRegimenReport.setTotalChildrenRevisit(n);
									}
								}
								String key = "regimen" + code.trim().replace(" ", "_");
								int amount = 0;
								if (regimenReportMap.get(key) != null) {
									amount = regimenReportMap.get(key);
								}
								amount++;
								regimenReportMap.put(key, amount);
							}
							artRs.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
				}
				patient.setEncounter(encounter);
				if (includePatientInReport == true) {
					if (patient.getChildOrAdult().equals("A")) {
						adults.add(patient);
					} else if (patient.getChildOrAdult().equals("C")) {
						children.add(patient);
					}
				}
			} catch (SQLException e) {
				log.error(e);
			}
			i++;
		}
		
		artRegimenReport.setRegimenReportMap(regimenReportMap);
		artRegimenReport.setAdults(adults);
		artRegimenReport.setChildren(children);
		return artRegimenReport;
	}


	/**
	 * @return Returns the reportMonth.
	 */
	public String getReportMonth() {
		return reportMonth;
	}

	/**
	 * @param reportMonth The reportMonth to set.
	 */
	public void setReportMonth(String reportMonth) {
		this.reportMonth = reportMonth;
	}

	/**
	 * @return Returns the reportYear.
	 */
	public String getReportYear() {
		return reportYear;
	}

	/**
	 * @param reportYear The reportYear to set.
	 */
	public void setReportYear(String reportYear) {
		this.reportYear = reportYear;
	}

	/**
	 * @return Returns the siteId from the super class.
	 */
	public int getSiteId() {
		return super.getSiteId();
	}

	/**
	 * @return Returns the siteName from the super class.
	 */
	public String getSiteName() {
		return super.getSiteName();
	}

/*	*//**
	 * @return Returns the patients.
	 *//*
	public SortedSet getPatients() {
		return patients;
	}

	*//**
	 * @param patient The patients to set.
	 *//*
	public void addPatient(ARTAdultPatient patient) {
		if (patients == null) {
            patients = new SortedSet();
        }
		patients.add(patient);
	}*/

	/**
	 * @return the balanceBF
	 */
	public ARTPatient getBalanceBF() {
		return balanceBF;
	}

	/**
	 * @param balanceBF the balanceBF to set
	 */
	public void setBalanceBF(ARTPatient balanceBF) {
		this.balanceBF = balanceBF;
	}

	/**
	 * @return the received
	 */
	public ARTPatient getReceived() {
		return received;
	}

	/**
	 * @param received the received to set
	 */
	public void setReceived(ARTPatient received) {
		this.received = received;
	}

	/**
	 * @return the onHand
	 */
	public ARTPatient getOnHand() {
		return onHand;
	}

	/**
	 * @param onHand the onHand to set
	 */
	public void setOnHand(ARTPatient onHand) {
		this.onHand = onHand;
	}

	/*	public void addPatientRecords(TreeMap<Date, ARTAdultPatient> patientRecords) {
        if (patients == null) {
            patients = new ArrayList<ARTAdultPatient>();
        }
        patients.addAll(patientRecords.values());
    }*/

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the artRegimenReport
	 */
	public ARTReport getArtRegimenReport() {
		return artRegimenReport;
	}

	/**
	 * @param artRegimenReport the artRegimenReport to set
	 */
	public void setArtRegimenReport(ARTReport artRegimenReport) {
		this.artRegimenReport = artRegimenReport;
	}

	/**
	 * @return the losses
	 */
	public ARTPatient getLosses() {
		return losses;
	}

	/**
	 * @param losses the losses to set
	 */
	public void setLosses(ARTPatient losses) {
		this.losses = losses;
	}

	/**
	 * @return the balanceCF
	 */
	public ARTPatient getBalanceCF() {
		return balanceCF;
	}

	/**
	 * @param balanceCF the balanceCF to set
	 */
	public void setBalanceCF(ARTPatient balanceCF) {
		this.balanceCF = balanceCF;
	}

	/**
	 * @return the stockReportMap
	 */
	public LinkedHashMap<String, StockReport> getStockReportMap() {
		return stockReportMap;
	}

	/**
	 * @param stockReportMap the stockReportMap to set
	 */
	public void setStockReportMap(LinkedHashMap<String, StockReport> stockReportMap) {
		this.stockReportMap = stockReportMap;
	}
//SERVETECH...........................................................
	
public static ArrayList getPatientEncounterIdsForPeriod(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {
	    System.out.println("getPatientDispensaryEncounters IDS");
	    ids.clear();
		ResultSet rs = null;
ArrayList ids = new ArrayList();
		String dateRange = "AND date_visit >= '"+beginDate+"' AND date_visit <=  '"+endDate+"' ";
		if (endDate == null) {
			dateRange = " ";
		}

		try {
				String sql = "SELECT encounter.id AS id FROM encounter, patient " +
				"  WHERE encounter.patient_id = patient.id " +
				" AND form_id = 132" +
				dateRange +
				" AND encounter.site_id =  " +siteID+" ";
				System.out.println(sql);
				PreparedStatement ps = conn.prepareStatement(sql);
			
				rs = ps.executeQuery();
				while (rs.next()){
					ids.add(rs.getObject("id"));
				}
			
		} catch (Exception ex) {
			log.error(ex);
		}

	return ids;
}
public static ResultSet getTheRestOfDetails(Connection conn, int siteID, Date beginDate, Date endDate,Object id) throws ServletException {
    System.out.println("Det for ID  "+id);
	ResultSet rs = null;

	String dateRange = "AND date_visit >= '"+beginDate+"' AND date_visit <=  '"+endDate+"' ";
	if (endDate == null) {
		dateRange = "";
	}

	try {
			String sql =  "SELECT date_visit, patient_id, district_patient_id, sex, " +
					"first_name, surname, encounter.site_id, age_at_first_visit, age_category, encounter.created_by AS created_by, encounter.created " +
					"FROM encounter, patient " +
					"WHERE encounter.id=" +id+" "+
					" AND form_id = 132 " +
					dateRange ;
			PreparedStatement ps = conn.prepareStatement(sql);
		
			rs = ps.executeQuery();
		
	} catch (Exception ex) {
		log.error(ex);
	}

	return rs;
}
//End SERVTECH>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
}

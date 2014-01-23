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
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.Form;
import org.rti.zcore.Register;
import org.rti.zcore.ReportCreator;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.gen.Regimen;
import org.rti.zcore.dar.gen.report.UserInfoReport;
import org.rti.zcore.dar.report.valueobject.ARTPatient;
import org.rti.zcore.dar.report.valueobject.ARTReport;
import org.rti.zcore.dar.report.valueobject.RegimenReport;
import org.rti.zcore.dar.report.valueobject.ReportDisplay;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.dar.utils.TextFile;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.sort.CreatedComparator;

/**
 * @author ckelley
 */
public class MonthlyArtReport extends Register {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(MonthlyArtReport.class);

	//ArrayList<ARTAdultPatient> patients = new ArrayList<ARTAdultPatient>(new CreatedComparator());

	private SortedSet<ARTPatient> patients = new TreeSet<ARTPatient>(new CreatedComparator());
	// private SortedMap<Long, ARTAdultPatient> patientMap = new TreeMap <Long,ARTAdultPatient>();
	private String reportMonth;
	private String reportYear;
	private String type;
	private ARTReport artRegimenReport;
	private ARTReport newEstimatedArtPatients;
	private ARTReport totalEstimatedArtPatients;
	private ArrayList<RegimenReport> regimenList;
	private HashMap<String, Integer> regimenReportMap = new HashMap<String, Integer>();
	private ArrayList<ReportDisplay> reportDisplayList;
	private LinkedHashMap<String, Regimen> regimenMap;

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

	/**
	 * @return Returns the patients.
	 */
	public SortedSet getPatients() {
		return patients;
	}

	/**
	 * @param patient The patients to set.
	 */
	public void addPatient(ARTPatient patient) {
		/*if (patients == null) {
            patients = new SortedSet();
        }*/
		patients.add(patient);
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

	public ARTReport getNewEstimatedArtPatients() {
		return newEstimatedArtPatients;
	}

	public void setNewEstimatedArtPatients(ARTReport newEstimatedArtPatients) {
		this.newEstimatedArtPatients = newEstimatedArtPatients;
	}

	public ARTReport getTotalEstimatedArtPatients() {
		return totalEstimatedArtPatients;
	}

	public void setTotalEstimatedArtPatients(
			ARTReport totalEstimatedArtPatients) {
		this.totalEstimatedArtPatients = totalEstimatedArtPatients;
	}


	/**
	 *
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 */
	public void getPatientRegister(Date beginDate, Date endDate, int siteId) {

		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = null;
		Form encounterForm = ((Form) DynaSiteObjects.getForms().get(new Long(132)));
		String className = "org.rti.zcore.dar.gen." + StringManipulation.fixClassname(encounterForm.getName());
		Class clazz = null;
		try {
			clazz = Class.forName(className);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		Connection conn = null;

		try {
			conn = DatabaseUtils.getZEPRSConnection(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);

			ReportCreator reportCreator = this.getReportCreator();
            String username = reportCreator.getUsernameR();
            UserInfoReport userInfo = (UserInfoReport) EncountersDAO.getOneReportById(conn, username, "SQL_RETRIEVE_REPORT_ID_ADMIN170", UserInfoReport.class);
            reportCreator.setEmailR(userInfo.getEmailR());	// email
            reportCreator.setFirstnameR(userInfo.getForenamesR());	// firstname
            reportCreator.setLastnameR(userInfo.getLastnameR());	// lastname
            reportCreator.setMobileR(userInfo.getMobileR());	// mobile
            reportCreator.setPhoneR(userInfo.getPhoneR());	// phone

            regimenList = new ArrayList<RegimenReport>();
    		HashMap<String,RegimenReport> regimenSpecMap = new HashMap<String,RegimenReport>();

			// Now get stats for ART regimens
			artRegimenReport = new ARTReport();
			newEstimatedArtPatients = new ARTReport();
			totalEstimatedArtPatients = new ARTReport();
			
			try {
				rs = getArtRegimens(conn, siteId, beginDate, endDate, "ASC");
				while (rs.next()) {

					Integer age = rs.getInt("age");
					Integer regimenGroup = rs.getInt("regimen_group_id");
					String code = rs.getString("code");
					String name = rs.getString("name");
					Long patientId = rs.getLong("patient_id");
					Date dateVisit = rs.getDate("date_visit");
					int sex = rs.getInt("sex");
					Integer ageCategory = rs.getInt("age_category");

					/*Long encounterId = rs.getLong("id");
					Long patientId = rs.getLong("patient_id");
					String districtPatientId = rs.getString("district_patient_id");
					String firstName = rs.getString("first_name");
					String surname = rs.getString("surname");
					Date dateVisit = rs.getDate("date_visit");
					int currentSiteId = rs.getInt("site_id");
					String createdBy = rs.getString("created_by");
					Timestamp created = rs.getTimestamp("created");*/
					
					ARTPatient patient = new ARTPatient();
					
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

					/*if (this.getDynamicReport() != null && this.getDynamicReport() == true) {
						RegimenReport regimenReport = regimenSpecMap.get(code);
						if (regimenReport == null) {
							regimenReport = new RegimenReport();
							regimenReport.setCode(code);
							regimenReport.setName(name);
							regimenReport.setRegimenGroup(regimenGroup);
							regimenSpecMap.put(code, regimenReport);
						}
						int countInt = regimenReport.getCountInt();
						countInt ++;
						regimenReport.setCountInt(countInt);
					} else {*/
						// increment the totals
						/*if (age != null && age > 14) {
							int n = artRegimenReport.getTotalAdults();
							n++;
							artRegimenReport.setTotalAdults(n);
						}
						if (age != null && age <= 14) {
							int n = artRegimenReport.getTotalChildren();
							n++;
							artRegimenReport.setTotalChildren(n);
						}*/
					
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
							//patient.setRevisit(true);
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


						//log.debug("new regimen: " + code);
						RegimenReport regimenReport = regimenSpecMap.get(code);
						if (regimenReport == null) {
							regimenReport = new RegimenReport();
							regimenReport.setCode(code);
							regimenReport.setName(name);
							regimenReport.setRegimenGroup(regimenGroup);
							regimenSpecMap.put(code, regimenReport);
						}
						int countInt = regimenReport.getCountInt();
						countInt ++;
						regimenReport.setCountInt(countInt);
						//}

						/*if (patient != null) {
						// check if this is the first visit - there might be multiples ones for this encounter
						Date firstVisit = EncountersDAO.getFirstVisit(conn, patientId);
						if (firstVisit.getTime() == dateVisit.getTime()) {
							patient.setRevisit(false);
						} else {
							patient.setRevisit(true);
						}
						this.addPatient(patient);
						if (patientMap.get(patient.getPatientId()) != null) {
                            	ARTAdultPatient encounter = (ARTAdultPatient) patientMap.get(patient.getPatientId());
                                encounters.add(patient);
                            } else {
                            	patientMap.put(patient.getPatientId(), patient);
                            }
					}*/
					//}
				}

				artRegimenReport.setRegimenReportMap(regimenReportMap); 
/*
				//if (this.getDynamicReport() != null && this.getDynamicReport() == true) {
				Set<Entry<String,RegimenReport>> set = map.entrySet();
				for (Entry<String, RegimenReport> entry : set) {
					RegimenReport report = entry.getValue();
					regimenList.add(report);
				}
				Collections.sort(regimenList, new SiteStatisticsDAO().new CodeComparator());
				//}
*/				
				// Sort out the view spec
				regimenMap = InventoryUtils.populateRegimenMap(conn);
				ArrayList<ReportDisplay> reportDisplayList = new ArrayList<ReportDisplay>();
				String filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "regimens.txt";
			    for(String line : new TextFile(filename)) {
			    	//System.out.println(line);
			    	String[] lineArray = line.split("\\|");
			    	if (lineArray[0].startsWith("regimen")) {
			    		String title = null;
			    		String regimenCode = null;
			    		Integer value = null;
			    		Integer newEstimatedArtPatientsValue = null;
			    		Integer totalEstimatedArtPatientsValue = null;
			    		String alternateCode = null;
			    		String rowNum = lineArray[1];
				    	Integer rowInt = Integer.valueOf(rowNum)-1;
				    	String cellNumStr = lineArray[2];
						int cellNum = Integer.valueOf(cellNumStr)-1;
						if (lineArray.length > 3) {
					    	regimenCode = lineArray[3];
					    	value = regimenReportMap.get("regimen" + regimenCode);
					    	//value = regimenReportMap.get(regimenCode);
					    	newEstimatedArtPatientsValue = newEstimatedArtPatients.getRegimenReportMap().get(regimenCode);
					    	totalEstimatedArtPatientsValue = totalEstimatedArtPatients.getRegimenReportMap().get(regimenCode);
						}
						if (lineArray.length > 4) {
							alternateCode = lineArray[4];
						}
				    	RegimenReport regimenReport = regimenSpecMap.get(regimenCode);
				    	if (regimenReport != null) {
				    		title = regimenReport.getName();
				    	} else { 
				    		Regimen regimen = regimenMap.get(regimenCode);
				    		if (regimen != null) {
					    		title = regimen.getName();
				    		}
				    	}
				    	ReportDisplay reportDisplay = new ReportDisplay("regimen", title, value, regimenCode, null, newEstimatedArtPatientsValue, totalEstimatedArtPatientsValue, alternateCode);
				    	reportDisplayList.add(reportDisplay);
			    	} else if (lineArray[0].equals("header") || lineArray[0].equals("subheader")) {
			    		String rowNum = lineArray[1];
				    	Integer rowInt = Integer.valueOf(rowNum)-1;
				    	String cellNumStr = lineArray[2];
						int cellNum = Integer.valueOf(cellNumStr)-1;
				    	String title = lineArray[3];
				    	String title2 = null;
				    	if (lineArray.length >4) {
 				    		if (lineArray[4] != null) {
								title2 = lineArray[4];
							}
				    	}
				    	ReportDisplay reportDisplay = new ReportDisplay("header", title, null, null, title2, null, null, null);
				    	reportDisplayList.add(reportDisplay);
			    	}
			    }
			    
			    this.setReportDisplayList(reportDisplayList);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				log.error(e);
			}

		}
	}

	/**
	 * Get ART regimen records (regimen code field) for this period/site
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @param orderBy TODO
	 * @return
	 * @throws ServletException
	 */
	public static ResultSet getArtRegimens(Connection conn, int siteID, Date beginDate, Date endDate, String orderBy) throws ServletException {

		ResultSet rs = null;

		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}

		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, sex, encounter.site_id, age_at_first_visit, age_category, " +
				"encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created, " +
				"regimen.name AS name, regimen_group_id " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
				dateRange +
				"ORDER BY created " + orderBy + " , surname";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
				}
				rs = ps.executeQuery();
			} else {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, sex, encounter.site_id, age_at_first_visit, age_category, " +
				"encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created, " +
				"regimen.name AS name, regimen_group_id " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
				dateRange +
				"AND encounter.site_id = ? " +
				"ORDER BY created " + orderBy + ", surname";
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

	public ArrayList<RegimenReport> getRegimenList() {
		return regimenList;
	}

	public void setRegimenList(ArrayList<RegimenReport> regimenList) {
		this.regimenList = regimenList;
	}

	/**
	 * @return the regimenReportMap
	 */
	public HashMap<String, Integer> getRegimenReportMap() {
		return regimenReportMap;
	}

	/**
	 * @param regimenReportMap the regimenReportMap to set
	 */
	public void setRegimenReportMap(HashMap<String, Integer> regimenReportMap) {
		this.regimenReportMap = regimenReportMap;
	}

	/**
	 * @return the reportDisplayList
	 */
	public ArrayList<ReportDisplay> getReportDisplayList() {
		return reportDisplayList;
	}

	/**
	 * @param reportDisplayList the reportDisplayList to set
	 */
	public void setReportDisplayList(ArrayList<ReportDisplay> reportDisplayList) {
		this.reportDisplayList = reportDisplayList;
	}

}

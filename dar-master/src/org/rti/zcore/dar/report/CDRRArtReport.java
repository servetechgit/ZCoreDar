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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.SortedSet;
import java.util.TimeZone;
import java.util.TreeSet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.DropdownItem;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.Register;
import org.rti.zcore.ReportCreator;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.dao.PatientItemDAO;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.gen.report.UserInfoReport;
import org.rti.zcore.dar.report.valueobject.ARTCombinedExpiration;
import org.rti.zcore.dar.report.valueobject.ARTCombinedPatient;
import org.rti.zcore.dar.report.valueobject.ARTReport;
import org.rti.zcore.dar.report.valueobject.DrugReport;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.dar.utils.RegimenUtils;
import org.rti.zcore.dar.utils.sort.DrugReportNameComparator;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.WidgetUtils;
import org.rti.zcore.utils.sort.CreatedComparator;

/**
 * @author ckelley
 * @deprecated Use DailyActivityReport instead.
 */
public class CDRRArtReport extends Register {

	/**
	 * Commons Logging instance.
	 */
	public static Log log = LogFactory.getFactory().getInstance(CDRRArtReport.class);

	//ArrayList<ARTCombinedPatient> patients = new ArrayList<ARTCombinedPatient>(new CreatedComparator());

	private SortedSet<ARTCombinedPatient> patients = new TreeSet<ARTCombinedPatient>(new CreatedComparator());
	// private SortedMap<Long, ARTCombinedPatient> patientMap = new TreeMap <Long,ARTCombinedPatient>();
	private String reportMonth;
	private String reportYear;
	private String type;
	private ARTCombinedPatient balanceBF;
	private ARTCombinedPatient received;
	private ARTCombinedPatient onHand;
	private ARTCombinedPatient totalDispensed;
	private HashMap totalDispensedMap;
	private ARTCombinedPatient losses;
	private ARTCombinedPatient posAdjustments;
	private ARTCombinedPatient negAdjustments;
	private ARTCombinedPatient balanceCF;
	private ARTCombinedPatient quantity6MonthsExpired;
	private ARTCombinedExpiration expiryDate;
	private ARTCombinedPatient daysOutOfStock;
	private ARTCombinedPatient quantityRequiredResupply;
	private ARTCombinedPatient quantityRequiredNewPatients;
	private ARTCombinedPatient totalQuantityRequired;
	private ARTReport artRegimenReport;
	private ArrayList<DrugReport> drugReportList;
	private LinkedHashMap<Long,Item> itemMap = new LinkedHashMap<Long,Item>();
	private HashMap<String, Integer> regimenReportMap;
	private LinkedHashMap<String, StockReport> stockReportMap;


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
	public void addPatient(ARTCombinedPatient patient) {
		/*if (patients == null) {
            patients = new SortedSet();
        }*/
		patients.add(patient);
	}

	/**
	 * @return the balanceBF
	 */
	public ARTCombinedPatient getBalanceBF() {
		return balanceBF;
	}

	/**
	 * @param balanceBF the balanceBF to set
	 */
	public void setBalanceBF(ARTCombinedPatient balanceBF) {
		this.balanceBF = balanceBF;
	}

	/**
	 * @return the received
	 */
	public ARTCombinedPatient getReceived() {
		return received;
	}

	/**
	 * @param received the received to set
	 */
	public void setReceived(ARTCombinedPatient received) {
		this.received = received;
	}

	/**
	 * @return the onHand
	 */
	public ARTCombinedPatient getOnHand() {
		return onHand;
	}

	/**
	 * @param onHand the onHand to set
	 */
	public void setOnHand(ARTCombinedPatient onHand) {
		this.onHand = onHand;
	}

	/*	public void addPatientRecords(TreeMap<Date, ARTCombinedPatient> patientRecords) {
        if (patients == null) {
            patients = new ArrayList<ARTCombinedPatient>();
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
	 * @return the totalDispensed
	 */
	public ARTCombinedPatient getTotalDispensed() {
		return totalDispensed;
	}

	public HashMap getTotalDispensedMap() {
		return totalDispensedMap;
	}

	public void setTotalDispensedMap(HashMap totalDispensedMap) {
		this.totalDispensedMap = totalDispensedMap;
	}

	/**
	 * @param totalDispensed the totalDispensed to set
	 */
	public void setTotalDispensed(ARTCombinedPatient totalDispensed) {
		this.totalDispensed = totalDispensed;
	}

	/**
	 * @return the losses
	 */
	public ARTCombinedPatient getLosses() {
		return losses;
	}

	/**
	 * @param losses the losses to set
	 */
	public void setLosses(ARTCombinedPatient losses) {
		this.losses = losses;
	}

	public ARTCombinedPatient getPosAdjustments() {
		return posAdjustments;
	}

	public void setPosAdjustments(ARTCombinedPatient posAdjustments) {
		this.posAdjustments = posAdjustments;
	}

	public ARTCombinedPatient getNegAdjustments() {
		return negAdjustments;
	}

	public void setNegAdjustments(ARTCombinedPatient negAdjustments) {
		this.negAdjustments = negAdjustments;
	}

	/**
	 * @return the balanceCF
	 */
	public ARTCombinedPatient getBalanceCF() {
		return balanceCF;
	}

	/**
	 * @param balanceCF the balanceCF to set
	 */
	public void setBalanceCF(ARTCombinedPatient balanceCF) {
		this.balanceCF = balanceCF;
	}

	public ARTCombinedPatient getQuantity6MonthsExpired() {
		return quantity6MonthsExpired;
	}

	public void setQuantity6MonthsExpired(ARTCombinedPatient quantity6MonthsExpired) {
		this.quantity6MonthsExpired = quantity6MonthsExpired;
	}

	public ARTCombinedExpiration getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(ARTCombinedExpiration expiryDate) {
		this.expiryDate = expiryDate;
	}

	public ARTCombinedPatient getDaysOutOfStock() {
		return daysOutOfStock;
	}

	public void setDaysOutOfStock(ARTCombinedPatient daysOutOfStock) {
		this.daysOutOfStock = daysOutOfStock;
	}

	public ARTCombinedPatient getQuantityRequiredResupply() {
		return quantityRequiredResupply;
	}

	public void setQuantityRequiredResupply(ARTCombinedPatient quantityRequiredResupply) {
		this.quantityRequiredResupply = quantityRequiredResupply;
	}

	public ARTCombinedPatient getQuantityRequiredNewPatients() {
		return quantityRequiredNewPatients;
	}

	public void setQuantityRequiredNewPatients(ARTCombinedPatient quantityRequiredNewPatients) {
		this.quantityRequiredNewPatients = quantityRequiredNewPatients;
	}

	public ARTCombinedPatient getTotalQuantityRequired() {
		return totalQuantityRequired;
	}

	public void setTotalQuantityRequired(ARTCombinedPatient totalQuantityRequired) {
		this.totalQuantityRequired = totalQuantityRequired;
	}

	public ArrayList<DrugReport> getDrugReportList() {
		return drugReportList;
	}

	public void setDrugReportList(ArrayList<DrugReport> drugReportList) {
		this.drugReportList = drugReportList;
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
            
            itemMap = InventoryUtils.populateItemMap(conn);
            stockReportMap = InventoryUtils.populateStockReportMaps(conn, beginDate, endDate, siteId, itemMap);

            drugReportList = new ArrayList<DrugReport>();
    		HashMap<Long,DrugReport> map = new HashMap<Long,DrugReport>();
    		
    		

			// For each patient, load the report class and add this patient to the list
			// also increment the total dispensed values
			totalDispensed = new ARTCombinedPatient();
			totalDispensedMap = new HashMap();
			try {
				rs = InventoryUtils.getPatientDispensaryEncounters(conn, siteId, beginDate, endDate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				while (rs.next()) {
					try {
						Long encounterId = rs.getLong("id");
						Long patientId = rs.getLong("patient_id");
						String districtPatientId = rs.getString("district_patient_id");
						String firstName = rs.getString("first_name");
						String surname = rs.getString("surname");
						Date dateVisit = rs.getDate("date_visit");
						Integer age = rs.getInt("age_at_first_visit");
						int currentSiteId = rs.getInt("site_id");
						String createdBy = rs.getString("created_by");
						Timestamp created = rs.getTimestamp("created");

						ARTCombinedPatient patient = new ARTCombinedPatient();

						patient.setEncounterId(encounterId);
						patient.setPatientId(patientId);
						patient.setClientId(districtPatientId);
						patient.setFirstName(firstName);
						patient.setSurname(surname);
						patient.setDateVisit(dateVisit);
						patient.setSiteId(currentSiteId);
						patient.setPharmacist(createdBy);
						patient.setCreated(created);

						if (age <=14) {
							patient.setChildOrAdult("C");
						} else {
							patient.setChildOrAdult("A");
						}

						EncounterData encounter = (EncounterData) PatientItemDAO.getEncounterRawValues(conn, encounterForm, "132", encounterId, clazz);
						Map encMap = encounter.getEncounterMap();
						Set encSet = encMap.entrySet();
						boolean isArtVisit = false;
						for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
							Map.Entry entry = (Map.Entry) iterator.next();
							Long key = (Long) entry.getKey();
							Integer value = (Integer) entry.getValue();
							// Someone might have forgotten to enter the value
							if (value == null) {
								value = 0;
							}

							Item item = itemMap.get(key);
							if (item == null) {
								log.debug("item is null for key: " + key + " value: " + value);
							}

							int n = 0;
							if (key != null) {
								/*if (this.getDynamicReport() != null && this.getDynamicReport() == true) {
									DrugReport drugReport = map.get(key);
									if (drugReport == null) {
										drugReport = new DrugReport();
										drugReport.setId(item.getId());
										drugReport.setName(item.getName());
										drugReport.setGroup(item.getItem_group_id());
										drugReport.setItem(item);
										map.put(key, drugReport);
									}

									int count = 0;
									if (drugReport.getTotalDispensed() != null) {
										count = drugReport.getTotalDispensed() + value;
									} else {
										count = value;
									}
									drugReport.setTotalDispensed(count);
								}*/

								switch (key.intValue()) {
								case 1:
									patient.setStavudine_LamivudineFDCTabs_30_150mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_LamivudineFDCTabs_30_150mg() != null) {
										n = totalDispensed.getStavudine_LamivudineFDCTabs_30_150mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_LamivudineFDCTabs_30_150mg(n);
									break;
								/*case 2:
									patient.setStavudine_LamivudineFDCTabs_40_150mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_LamivudineFDCTabs_40_150mg() != null) {
										n = totalDispensed.getStavudine_LamivudineFDCTabs_40_150mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_LamivudineFDCTabs_40_150mg(n);
									break;*/
								case 3:
									patient.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg() != null) {
										n = totalDispensed.getStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(n);
									break;
								/*case 4:
									patient.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg() != null) {
										n = totalDispensed.getStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(n);
									break;*/
								case 5:
									patient.setZidovudine_LamivudineTabs_capsFDC_300_150mg(value);
									isArtVisit = true;
									if (totalDispensed.getZidovudine_LamivudineTabs_capsFDC_300_150mg() != null) {
										n = totalDispensed.getZidovudine_LamivudineTabs_capsFDC_300_150mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setZidovudine_LamivudineTabs_capsFDC_300_150mg(n);
									break;
								case 6:
									patient.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(value);
									isArtVisit = true;
									if (totalDispensed.getZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg() != null) {
										n = totalDispensed.getZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(n);
									break;
								case 7:
									patient.setAbacavirTabs300mg(value);
									isArtVisit = true;
									if (totalDispensed.getAbacavirTabs300mg() != null) {
										n = totalDispensed.getAbacavirTabs300mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAbacavirTabs300mg(n);
									break;
								/*case 8:
									patient.setDidanosineTabs100mg(value);
									isArtVisit = true;
									if (totalDispensed.getDidanosineTabs100mg() != null) {
										n = totalDispensed.getDidanosineTabs100mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDidanosineTabs100mg(n);
									break;
								case 9:
									patient.setDidanosineTabs200mg(value);
									isArtVisit = true;
									if (totalDispensed.getDidanosineTabs200mg() != null) {
										n = totalDispensed.getDidanosineTabs200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDidanosineTabs200mg(n);
									break;
								case 10:
									patient.setDidanosineTabs50mg(value);
									isArtVisit = true;
									if (totalDispensed.getDidanosineTabs50mg() != null) {
										n = totalDispensed.getDidanosineTabs50mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDidanosineTabs50mg(n);
									break;*/
								case 11:
									patient.setEfavirenzTabs_caps200mg(value);
									isArtVisit = true;
									if (totalDispensed.getEfavirenzTabs_caps200mg() != null) {
										n = totalDispensed.getEfavirenzTabs_caps200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setEfavirenzTabs_caps200mg(n);
									break;
								case 12:
									patient.setEfavirenzTabs600mg(value);
									isArtVisit = true;
									if (totalDispensed.getEfavirenzTabs600mg() != null) {
										n = totalDispensed.getEfavirenzTabs600mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setEfavirenzTabs600mg(n);
									break;
								case 13:
									patient.setLamivudineTabs150mg(value);
									isArtVisit = true;
									if (totalDispensed.getLamivudineTabs150mg() != null) {
										n = totalDispensed.getLamivudineTabs150mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setLamivudineTabs150mg(n);
									break;
						/*		case 14:
									patient.setLopinavir_ritonavirTabs_caps133(value);
									isArtVisit = true;
									if (totalDispensed.getLopinavir_ritonavirTabs_caps133() != null) {
										n = totalDispensed.getLopinavir_ritonavirTabs_caps133() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setLopinavir_ritonavirTabs_caps133(n);
									break;*/
								case 15:
									patient.setNelfinavirTabs250mg(value);
									isArtVisit = true;
									if (totalDispensed.getNelfinavirTabs250mg() != null) {
										n = totalDispensed.getNelfinavirTabs250mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setNelfinavirTabs250mg(n);
									break;
								case 16:
									patient.setNevirapineTabs200mg(value);
									isArtVisit = true;
									if (totalDispensed.getNevirapineTabs200mg() != null) {
										n = totalDispensed.getNevirapineTabs200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setNevirapineTabs200mg(n);
									break;
								case 17:
									patient.setStavudineTabs_Caps30mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudineTabs_Caps30mg() != null) {
										n = totalDispensed.getStavudineTabs_Caps30mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudineTabs_Caps30mg(n);
									break;
								/*case 18:
									patient.setStavudineTabs_Caps40mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudineTabs_Caps40mg() != null) {
										n = totalDispensed.getStavudineTabs_Caps40mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudineTabs_Caps40mg(n);
									break;*/
								case 19:
									patient.setTenofovirTabs_caps300mg(value);
									isArtVisit = true;
									if (totalDispensed.getTenofovirTabs_caps300mg() != null) {
										n = totalDispensed.getTenofovirTabs_caps300mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setTenofovirTabs_caps300mg(n);
									break;
								case 20:
									patient.setZidovudineTabs300mg(value);
									isArtVisit = true;
									if (totalDispensed.getZidovudineTabs300mg() != null) {
										n = totalDispensed.getZidovudineTabs300mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setZidovudineTabs300mg(n);
									break;
								case 21:
									patient.setAbacavir_liquid_20mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getAbacavir_liquid_20mg_ml() != null) {
										n = totalDispensed.getAbacavir_liquid_20mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAbacavir_liquid_20mg_ml(n);
									break;
								case 22:
									patient.setDidanosine_Tabs_caps_25mg(value);
									isArtVisit = true;
									if (totalDispensed.getDidanosine_Tabs_caps_25mg() != null) {
										n = totalDispensed.getDidanosine_Tabs_caps_25mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDidanosine_Tabs_caps_25mg(n);
									break;
								/*case 23:
									patient.setDidanosine_liquid_10mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getDidanosine_liquid_10mg_ml() != null) {
										n = totalDispensed.getDidanosine_liquid_10mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDidanosine_liquid_10mg_ml(n);
									break;*/
								case 24:
									patient.setEfavirenz_Tabs_50mg(value);
									isArtVisit = true;
									if (totalDispensed.getEfavirenz_Tabs_50mg() != null) {
										n = totalDispensed.getEfavirenz_Tabs_50mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setEfavirenz_Tabs_50mg(n);
									break;
								case 25:
									patient.setEfavirenz_liquid_30mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getEfavirenz_liquid_30mg_ml() != null) {
										n = totalDispensed.getEfavirenz_liquid_30mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setEfavirenz_liquid_30mg_ml(n);
									break;
								case 26:
									patient.setLamivudine_liquid_10mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getLamivudine_liquid_10mg_ml() != null) {
										n = totalDispensed.getLamivudine_liquid_10mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setLamivudine_liquid_10mg_ml(n);
									break;
								case 27:
									patient.setLopinavir_ritonavir_liquid_80(value);
									isArtVisit = true;
									if (totalDispensed.getLopinavir_ritonavir_liquid_80() != null) {
										n = totalDispensed.getLopinavir_ritonavir_liquid_80() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setLopinavir_ritonavir_liquid_80(n);
									break;
								/*case 28:
									patient.setNelfinavir_powder_50mg_125ml(value);
									isArtVisit = true;
									if (totalDispensed.getNelfinavir_powder_50mg_125ml() != null) {
										n = totalDispensed.getNelfinavir_powder_50mg_125ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setNelfinavir_powder_50mg_125ml(n);
									break;*/
								case 29:
									patient.setNevirapine_susp_10mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getNevirapine_susp_10mg_ml() != null) {
										n = totalDispensed.getNevirapine_susp_10mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setNevirapine_susp_10mg_ml(n);
									break;
								case 30:
									patient.setStavudine_Tabs_caps_15mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_Tabs_caps_15mg() != null) {
										n = totalDispensed.getStavudine_Tabs_caps_15mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_Tabs_caps_15mg(n);
									break;
								case 31:
									patient.setStavudine_Tabs_caps_20mg(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_Tabs_caps_20mg() != null) {
										n = totalDispensed.getStavudine_Tabs_caps_20mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_Tabs_caps_20mg(n);
									break;
								/*case 32:
									patient.setStavudine_liquid_1mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getStavudine_liquid_1mg_ml() != null) {
										n = totalDispensed.getStavudine_liquid_1mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setStavudine_liquid_1mg_ml(n);
									break;*/
								case 33:
									patient.setZidovudine_Tabs_caps_100mg(value);
									isArtVisit = true;
									if (totalDispensed.getZidovudine_Tabs_caps_100mg() != null) {
										n = totalDispensed.getZidovudine_Tabs_caps_100mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setZidovudine_Tabs_caps_100mg(n);
									break;
								case 34:
									patient.setZidovudine_liquid_10mg_ml(value);
									isArtVisit = true;
									if (totalDispensed.getZidovudine_liquid_10mg_ml() != null) {
										n = totalDispensed.getZidovudine_liquid_10mg_ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setZidovudine_liquid_10mg_ml(n);
									break;
								default:
									if (item != null) {
										boolean addDynamicReport = true;
										String code = item.getCode();
										if (code != null) {
											if (code.equals("ddl400")) {
												addDynamicReport = false;
												patient.setDidanosine400mg(value);
												isArtVisit = true;
												if (totalDispensed.getDidanosine400mg() != null) {
													n = totalDispensed.getDidanosine400mg() + value;
												} else {
													n = value;
												}
												totalDispensedMap.put(key.intValue(), n);
												totalDispensed.setDidanosine400mg(n);
												totalDispensed.setDidanosine400mgItemId(item.getId());
											} else if (code.equals("ddl250")) {
												addDynamicReport = false;
												patient.setDidanosine250mg(value);
												isArtVisit = true;
												if (totalDispensed.getDidanosine250mg() != null) {
													n = totalDispensed.getDidanosine250mg() + value;
												} else {
													n = value;
												}
												totalDispensedMap.put(key.intValue(), n);
												totalDispensed.setDidanosine250mg(n);
												totalDispensed.setDidanosine250mgItemId(item.getId());
											} else if (code.equals("ddl50")) {
												addDynamicReport = false;
												patient.setDidanosine50mg(value);
												isArtVisit = true;
												if (totalDispensed.getDidanosine50mg() != null) {
													n = totalDispensed.getDidanosine50mg() + value;
												} else {
													n = value;
												}
												totalDispensedMap.put(key.intValue(), n);
												totalDispensed.setDidanosine50mg(n);
												totalDispensed.setDidanosine50mgItemId(item.getId());
											} else if (code.equals("lpvr20050")) {
												addDynamicReport = false;
												patient.setLopinavir_ritonavir200_50mg(value);
												isArtVisit = true;
												if (totalDispensed.getLopinavir_ritonavir200_50mg() != null) {
													n = totalDispensed.getLopinavir_ritonavir200_50mg() + value;
												} else {
													n = value;
												}
												totalDispensedMap.put(key.intValue(), n);
												totalDispensed.setLopinavir_ritonavir200_50mg(n);
												totalDispensed.setLopinavir_ritonavir200_50mgItemId(item.getId());
											} else {
												//log.debug("No fields for " + item.getName() + " Code: " + code);
											}
										} else {
											// log.debug("No fields for " + item.getName() + " Code: " + code);
										}
										if (addDynamicReport) {
											DrugReport drugReport = map.get(key);
											if (drugReport == null) {
												//log.debug("Adding to dynamic report " + item.getName() + " Code: " + code);
												drugReport = new DrugReport();
												drugReport.setId(item.getId());
												drugReport.setName(item.getName());
												drugReport.setGroup(item.getItem_group_id());
												drugReport.setItem(item);
												map.put(key, drugReport);
											}

											int count = 0;
											if (drugReport.getTotalDispensed() != null) {
												count = drugReport.getTotalDispensed() + value;
											} else {
												count = value;
											}
											drugReport.setTotalDispensed(count);
										}
									}

									break;
								}
							}  else {
								log.debug("Key is null: Patient ID: " + patientId + " EncounterId: " + encounterId + " in form 132");
							}
						}
						// no need to do this query if it's not an art visit
						if (isArtVisit == true) {
							// check if this is the first visit - there might be multiples ones for this encounter
							Date firstVisit = EncountersDAO.getFirstVisit(conn, patientId);
							if (firstVisit.getTime() == dateVisit.getTime()) {
								patient.setRevisit(false);
							} else {
								patient.setRevisit(true);
							}
						}
						// don't add this patient if it's not an art visit
						if (isArtVisit == true) {
							patient.setEncounter(encounter);
							if (patient != null) {
								this.addPatient(patient);
								/*if (patientMap.get(patient.getPatientId()) != null) {
                                	ARTCombinedPatient encounter = (ARTCombinedPatient) patientMap.get(patient.getPatientId());
                                    encounters.add(patient);
                                } else {
                                	patientMap.put(patient.getPatientId(), patient);
                                }*/
							}
						}

					} catch (SQLException e) {
						log.error(e);
					}
				}

			} catch (SQLException e) {
				log.error(e);
			}

			// Get the stock onHand for each item
			try {
				balanceBF = new ARTCombinedPatient();
				received = new ARTCombinedPatient();
				onHand = new ARTCombinedPatient();
				losses = new ARTCombinedPatient();
				negAdjustments = new ARTCombinedPatient();
				posAdjustments  = new ARTCombinedPatient();
				quantity6MonthsExpired = new ARTCombinedPatient();
				expiryDate = new ARTCombinedExpiration();
				daysOutOfStock = new ARTCombinedPatient();
				quantityRequiredResupply = new ARTCombinedPatient();
				quantityRequiredNewPatients = new ARTCombinedPatient();
				totalQuantityRequired = new ARTCombinedPatient();

				//HashMap<Long, List<StockControl>> stockMap = InventoryDAO.getPatientStockMap(conn, siteId, beginDate, endDate);
				HashMap<Long,StockReport> balanceMap = InventoryDAO.getBalanceMap(conn, null, null,endDate);
				HashMap<Long,StockReport> balanceBFMap = InventoryDAO.getBalanceMap(conn, siteId, beginDate,endDate);

				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(org.rti.zcore.Constants.DATE_FORMAT_SHORT);
		    	sdf.setTimeZone(TimeZone.getDefault());

				Integer currentBalance = null;
				List<DropdownItem> list = WidgetUtils.getList(conn, "item", "id", "WHERE ITEM_GROUP_ID < 9", "ORDER BY id", DropdownItem.class, null);

				for (DropdownItem dropdownItem : list) {
					Long itemId = Long.valueOf(dropdownItem.getDropdownId());
					/*StockControl tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId);
					currentBalance = tempStockControl.getBalance();*/
					List<StockControl> stockChanges = (List<StockControl>) InventoryDAO.getStockChanges(conn, itemId, siteId, beginDate, endDate);
					StockReport stockReport = balanceMap.get(itemId);
			        if (stockReport == null) {
			        	currentBalance = 0;
			        } else {
			        	currentBalance = stockReport.getOnHand();
			        }
					/*List<StockControl> patientStockChanges = stockMap.get(itemId);
					if (patientStockChanges == null) {
						patientStockChanges = new ArrayList<StockControl>();
					}
					List<StockControl> stockEncounterChanges = InventoryDAO.getStockEncounterChanges(conn, itemId, siteId, beginDate, endDate, stockChanges, patientStockChanges);
			        StockReport stockReport = InventoryDAO.generateStockSummary(conn, itemId, beginDate, stockEncounterChanges, false);
			        currentBalance = stockReport.getOnHand();*/
					Integer stockReceived = 0;
					Integer stockLoss = 0;
					Integer stockNegAdjust = 0;
					Integer stockPosAdjust = 0;
					Integer stock6monthExpiry = 0;
					Integer stockRemaining = 0;
					Integer outOfStockDays = 0;
					Integer stockResupply = 0;
					Integer stockNew = 0;
					Integer totalRequired = 0;
					String expiry = null;
					String expiryValue = null;
					Boolean isExpirySet = false;
					int i =0;
					//Integer totalLosses = 0;
					Date expiryDateD = null;
					if (stockChanges.size() >0) {
						for (Iterator iterator = stockChanges.iterator(); iterator.hasNext();) {
							StockControl stock = (StockControl) iterator.next();
							i++;
							Integer changeType = stock.getType_of_change();
							Integer quantity = stock.getChange_value();
							//expiryValue = stock.getExpiry_date();
							if (stock.getExpiry_date() != null) {
								expiryValue = sdf.format(stock.getExpiry_date().getTime());
							}
							Timestamp created = stock.getCreated();
							if (quantity != null) {
								if (expiryValue != null) {
									//Boolean sixMonthsExpiry = DateUtils.check6monthExpiry(endDate, expiryValue);
									if (stock.getExpiry_date() != null) {
										Boolean sixMonthsExpiry = InventoryUtils.checkExpiry(endDate, stock.getExpiry_date(), 6);
										// TODO: need to make sure that previous stock is not exhausted
										// currently you may use the remaining field in the form to tweak the results.
										if (sixMonthsExpiry == true) {
											//stock6monthExpiry++;
											stock6monthExpiry = currentBalance;
											/*if (remaining != null) {
											stockRemaining = stockRemaining + remaining;
										}*/
											// do not display expiry unless stock6monthExpiry >0
											if (stock6monthExpiry >0) {
												if (isExpirySet == false) {
													expiry = expiryValue;
													isExpirySet = true;
													expiryDateD = stock.getExpiry_date();
												}
											}
										}
									}
								}
								switch (changeType.intValue()) {
								case 3263:	// received
									stockReceived = stockReceived + quantity;
									break;
								case 3265:	// loss
									stockLoss = stockLoss + quantity;
									break;
								case 3266:	// Pos. Adjust.
									stockPosAdjust = stockPosAdjust + quantity;
									break;
								case 3267:	// Neg. Adjust.
									stockNegAdjust = stockNegAdjust + quantity;
									break;
								case 3279:	// Out-of-stock
									if (i==1) {
										// calc how many days since this out-of-stock record was created
										long days = DateUtils.calculateDays(created, endDate);
										outOfStockDays = Long.valueOf(days).intValue();
										if (outOfStockDays == 0) {
											outOfStockDays = 1;
										}
									}
									break;
								default:
									break;
								}
							}
						}
					}

					int totalDispensedInt = 0;
					if (totalDispensedMap.get(itemId.intValue()) != null) {
						try {
							totalDispensedInt = (Integer) totalDispensedMap.get(itemId.intValue());
						} catch (Exception e) {
							log.debug("itemId: " + itemId.intValue() + " totalDispensedMap: " + totalDispensedMap.toString());
						}
					}

					stockResupply = (3*totalDispensedInt)-currentBalance;
					if (stockResupply < 0) {
						stockResupply = 0;
					}

					/*StockControl beginningStockControl = InventoryDAO.getBeginningStockBalance(conn, 161, itemId, beginDate);
					Integer beginningBalance = beginningStockControl.getBalance();*/
					StockReport stockReportBbf = balanceBFMap.get(itemId);
			        Integer beginningBalance = 0;
			        if (stockReportBbf == null) {
			        	beginningBalance = 0;
			        } else {
			        	beginningBalance = stockReportBbf.getOnHand();
			        }

					if (stockRemaining > 0) {
						stock6monthExpiry = stockRemaining;
					}
					if (currentBalance == 0) {
						expiry = null;
					}
					// keep the report easy-to-read - not a bunch of zeros.
					if (stockLoss == 0) {
						stockLoss = null;
					}
					if (stockReceived == 0) {
						stockReceived = null;
					}
					if (stockPosAdjust == 0) {
						stockPosAdjust = null;
					}
					if (stockNegAdjust == 0) {
						stockNegAdjust = null;
					}
					if (stock6monthExpiry == 0) {
						stock6monthExpiry = null;
					}
					if (outOfStockDays == 0) {
						//if (value > 0) {
							outOfStockDays = null;
						//}
					}
					if (stockResupply == 0) {
						stockResupply = null;
					}
					if (stockNew == 0) {
						stockNew = null;
					}
					if (totalRequired == 0) {
						totalRequired = null;
					}

					// You want to see if the stock balance is 0.
					/*if (value == 0) {
						value = null;
					}*/

					Item item = itemMap.get(itemId);
					if (this.getDynamicReport() != null && this.getDynamicReport() == true) {
						DrugReport drugReport = map.get(itemId);
						if (drugReport == null) {
							drugReport = new DrugReport();
							drugReport.setId(item.getId());
							drugReport.setName(item.getName());
							drugReport.setGroup(item.getItem_group_id());
							drugReport.setItem(item);
						}
						drugReport.setBalanceBF(beginningBalance);
						drugReport.setOnHand(currentBalance);
						drugReport.setLosses(stockLoss);
						drugReport.setReceived(stockReceived);
						drugReport.setPosAdjustments(stockPosAdjust);
						drugReport.setNegAdjustments(stockNegAdjust);
						drugReport.setQuantity6MonthsExpired(stock6monthExpiry);
						drugReport.setExpiryDate(expiryDateD);
						drugReport.setDaysOutOfStock(outOfStockDays);
						drugReport.setQuantityRequiredResupply(stockResupply);
						drugReport.setQuantityRequiredNewPatients(stockNew);
						drugReport.setTotalQuantityRequired(totalRequired);

						if ((drugReport.getTotalDispensed() != null) || (stockChanges.size() > 0)  || ((currentBalance != 0) && (beginningBalance != 0))) {
							map.put(itemId, drugReport);
						}
					}

					switch (itemId.intValue()) {
					case 1:
						balanceBF.setStavudine_LamivudineFDCTabs_30_150mg(beginningBalance);
						onHand.setStavudine_LamivudineFDCTabs_30_150mg(currentBalance);
						losses.setStavudine_LamivudineFDCTabs_30_150mg(stockLoss);
						received.setStavudine_LamivudineFDCTabs_30_150mg(stockReceived);
						posAdjustments.setStavudine_LamivudineFDCTabs_30_150mg(stockPosAdjust);
						negAdjustments.setStavudine_LamivudineFDCTabs_30_150mg(stockNegAdjust);
						quantity6MonthsExpired.setStavudine_LamivudineFDCTabs_30_150mg(stock6monthExpiry);
						expiryDate.setStavudine_LamivudineFDCTabs_30_150mg(expiry);
						daysOutOfStock.setStavudine_LamivudineFDCTabs_30_150mg(outOfStockDays);
						quantityRequiredResupply.setStavudine_LamivudineFDCTabs_30_150mg(stockResupply);
						quantityRequiredNewPatients.setStavudine_LamivudineFDCTabs_30_150mg(stockNew);
						totalQuantityRequired.setStavudine_LamivudineFDCTabs_30_150mg(totalRequired);
						break;
					/*case 2:
						balanceBF.setStavudine_LamivudineFDCTabs_40_150mg(beginningBalance);
						onHand.setStavudine_LamivudineFDCTabs_40_150mg(currentBalance);
						losses.setStavudine_LamivudineFDCTabs_40_150mg(stockLoss);
						received.setStavudine_LamivudineFDCTabs_40_150mg(stockReceived);
						posAdjustments.setStavudine_LamivudineFDCTabs_40_150mg(stockPosAdjust);
						negAdjustments.setStavudine_LamivudineFDCTabs_40_150mg(stockNegAdjust);
						quantity6MonthsExpired
								.setStavudine_LamivudineFDCTabs_40_150mg(stock6monthExpiry);
						expiryDate.setStavudine_LamivudineFDCTabs_40_150mg(expiry);
						daysOutOfStock.setStavudine_LamivudineFDCTabs_40_150mg(outOfStockDays);
						quantityRequiredResupply.setStavudine_LamivudineFDCTabs_40_150mg(stockResupply);
						quantityRequiredNewPatients.setStavudine_LamivudineFDCTabs_40_150mg(stockNew);
						totalQuantityRequired.setStavudine_LamivudineFDCTabs_40_150mg(totalRequired);
						break;*/
					case 3:
						balanceBF.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(beginningBalance);
						onHand.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(currentBalance);
						losses.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stockLoss);
						received.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stockReceived);
						posAdjustments.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stockPosAdjust);
						negAdjustments
								.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stockNegAdjust);
						quantity6MonthsExpired
								.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stock6monthExpiry);
						expiryDate.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(expiry);
						daysOutOfStock.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(outOfStockDays);
						quantityRequiredResupply.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stockResupply);
						quantityRequiredNewPatients.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(stockNew);
						totalQuantityRequired.setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(totalRequired);
						break;
					/*case 4:
						balanceBF.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(beginningBalance);
						onHand.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(currentBalance);
						losses.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stockLoss);
						received.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stockReceived);
						posAdjustments.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stockPosAdjust);
						negAdjustments
								.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stockNegAdjust);
						quantity6MonthsExpired
								.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stock6monthExpiry);
						expiryDate.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(expiry);
						daysOutOfStock.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(outOfStockDays);
						quantityRequiredResupply.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stockResupply);
						quantityRequiredNewPatients.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(stockNew);
						totalQuantityRequired.setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(totalRequired);
						break;*/
					case 5:
						balanceBF.setZidovudine_LamivudineTabs_capsFDC_300_150mg(beginningBalance);
						onHand.setZidovudine_LamivudineTabs_capsFDC_300_150mg(currentBalance);
						losses.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stockLoss);
						received.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stockReceived);
						posAdjustments.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stockPosAdjust);
						negAdjustments
								.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stockNegAdjust);
						quantity6MonthsExpired
								.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stock6monthExpiry);
						expiryDate.setZidovudine_LamivudineTabs_capsFDC_300_150mg(expiry);
						daysOutOfStock.setZidovudine_LamivudineTabs_capsFDC_300_150mg(outOfStockDays);
						quantityRequiredResupply.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stockResupply);
						quantityRequiredNewPatients.setZidovudine_LamivudineTabs_capsFDC_300_150mg(stockNew);
						totalQuantityRequired.setZidovudine_LamivudineTabs_capsFDC_300_150mg(totalRequired);
						break;
					case 6:
						balanceBF.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(beginningBalance);
						onHand.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(currentBalance);
						losses.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stockLoss);
						received.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stockReceived);
						posAdjustments.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stockPosAdjust);
						negAdjustments
								.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stockNegAdjust);
						quantity6MonthsExpired
								.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stock6monthExpiry);
						expiryDate.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(expiry);
						daysOutOfStock.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(outOfStockDays);
						quantityRequiredResupply.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stockResupply);
						quantityRequiredNewPatients.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(stockNew);
						totalQuantityRequired.setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(totalRequired);
						break;
					case 7:
						balanceBF.setAbacavirTabs300mg(beginningBalance);
						onHand.setAbacavirTabs300mg(currentBalance);
						losses.setAbacavirTabs300mg(stockLoss);
						received.setAbacavirTabs300mg(stockReceived);
						posAdjustments.setAbacavirTabs300mg(stockPosAdjust);
						negAdjustments.setAbacavirTabs300mg(stockNegAdjust);
						quantity6MonthsExpired.setAbacavirTabs300mg(stock6monthExpiry);
						expiryDate.setAbacavirTabs300mg(expiry);
						daysOutOfStock.setAbacavirTabs300mg(outOfStockDays);
						quantityRequiredResupply.setAbacavirTabs300mg(stockResupply);
						quantityRequiredNewPatients.setAbacavirTabs300mg(stockNew);
						totalQuantityRequired.setAbacavirTabs300mg(totalRequired);
						break;
					/*case 8:
						balanceBF.setDidanosineTabs100mg(beginningBalance);
						onHand.setDidanosineTabs100mg(currentBalance);
						losses.setDidanosineTabs100mg(stockLoss);
						negAdjustments.setDidanosineTabs100mg(stockNegAdjust);
						posAdjustments.setDidanosineTabs100mg(stockPosAdjust);
						received.setDidanosineTabs100mg(stockReceived);
						quantity6MonthsExpired.setDidanosineTabs100mg(stock6monthExpiry);
						expiryDate.setDidanosineTabs100mg(expiry);
						daysOutOfStock.setDidanosineTabs100mg(outOfStockDays);
						quantityRequiredResupply.setDidanosineTabs100mg(stockResupply);
						quantityRequiredNewPatients.setDidanosineTabs100mg(stockNew);
						totalQuantityRequired.setDidanosineTabs100mg(totalRequired);
						break;
					case 9:
						balanceBF.setDidanosineTabs200mg(beginningBalance);
						onHand.setDidanosineTabs200mg(currentBalance);
						losses.setDidanosineTabs200mg(stockLoss);
						negAdjustments.setDidanosineTabs200mg(stockNegAdjust);
						posAdjustments.setDidanosineTabs200mg(stockPosAdjust);
						received.setDidanosineTabs200mg(stockReceived);
						quantity6MonthsExpired.setDidanosineTabs200mg(stock6monthExpiry);
						expiryDate.setDidanosineTabs200mg(expiry);
						daysOutOfStock.setDidanosineTabs200mg(outOfStockDays);
						quantityRequiredResupply.setDidanosineTabs200mg(stockResupply);
						quantityRequiredNewPatients.setDidanosineTabs200mg(stockNew);
						totalQuantityRequired.setDidanosineTabs200mg(totalRequired);
						break;
					case 10:
						balanceBF.setDidanosineTabs50mg(beginningBalance);
						onHand.setDidanosineTabs50mg(currentBalance);
						losses.setDidanosineTabs50mg(stockLoss);
						negAdjustments.setDidanosineTabs50mg(stockNegAdjust);
						posAdjustments.setDidanosineTabs50mg(stockPosAdjust);
						received.setDidanosineTabs50mg(stockReceived);
						quantity6MonthsExpired.setDidanosineTabs50mg(stock6monthExpiry);
						expiryDate.setDidanosineTabs50mg(expiry);
						daysOutOfStock.setDidanosineTabs50mg(outOfStockDays);
						quantityRequiredResupply.setDidanosineTabs50mg(stockResupply);
						quantityRequiredNewPatients.setDidanosineTabs50mg(stockNew);
						totalQuantityRequired.setDidanosineTabs50mg(totalRequired);
						break;*/
					case 11:
						balanceBF.setEfavirenzTabs_caps200mg(beginningBalance);
						onHand.setEfavirenzTabs_caps200mg(currentBalance);
						losses.setEfavirenzTabs_caps200mg(stockLoss);
						received.setEfavirenzTabs_caps200mg(stockReceived);
						posAdjustments.setEfavirenzTabs_caps200mg(stockPosAdjust);
						negAdjustments.setEfavirenzTabs_caps200mg(stockNegAdjust);
						quantity6MonthsExpired.setEfavirenzTabs_caps200mg(stock6monthExpiry);
						expiryDate.setEfavirenzTabs_caps200mg(expiry);
						daysOutOfStock.setEfavirenzTabs_caps200mg(outOfStockDays);
						quantityRequiredResupply.setEfavirenzTabs_caps200mg(stockResupply);
						quantityRequiredNewPatients.setEfavirenzTabs_caps200mg(stockNew);
						totalQuantityRequired.setEfavirenzTabs_caps200mg(totalRequired);
						break;
					case 12:
						balanceBF.setEfavirenzTabs600mg(beginningBalance);
						onHand.setEfavirenzTabs600mg(currentBalance);
						losses.setEfavirenzTabs600mg(stockLoss);
						received.setEfavirenzTabs600mg(stockReceived);
						posAdjustments.setEfavirenzTabs600mg(stockPosAdjust);
						negAdjustments.setEfavirenzTabs600mg(stockNegAdjust);
						quantity6MonthsExpired.setEfavirenzTabs600mg(stock6monthExpiry);
						expiryDate.setEfavirenzTabs600mg(expiry);
						daysOutOfStock.setEfavirenzTabs600mg(outOfStockDays);
						quantityRequiredResupply.setEfavirenzTabs600mg(stockResupply);
						quantityRequiredNewPatients.setEfavirenzTabs600mg(stockNew);
						totalQuantityRequired.setEfavirenzTabs600mg(totalRequired);
						break;
					case 13:
						balanceBF.setLamivudineTabs150mg(beginningBalance);
						onHand.setLamivudineTabs150mg(currentBalance);
						losses.setLamivudineTabs150mg(stockLoss);
						received.setLamivudineTabs150mg(stockReceived);
						posAdjustments.setLamivudineTabs150mg(stockPosAdjust);
						negAdjustments.setLamivudineTabs150mg(stockNegAdjust);
						quantity6MonthsExpired.setLamivudineTabs150mg(stock6monthExpiry);
						expiryDate.setLamivudineTabs150mg(expiry);
						daysOutOfStock.setLamivudineTabs150mg(outOfStockDays);
						quantityRequiredResupply.setLamivudineTabs150mg(stockResupply);
						quantityRequiredNewPatients.setLamivudineTabs150mg(stockNew);
						totalQuantityRequired.setLamivudineTabs150mg(totalRequired);
						break;
					/*case 14:
						balanceBF.setLopinavir_ritonavirTabs_caps133(beginningBalance);
						onHand.setLopinavir_ritonavirTabs_caps133(currentBalance);
						losses.setLopinavir_ritonavirTabs_caps133(stockLoss);
						received.setLopinavir_ritonavirTabs_caps133(stockReceived);
						posAdjustments.setLopinavir_ritonavirTabs_caps133(stockPosAdjust);
						negAdjustments.setLopinavir_ritonavirTabs_caps133(stockNegAdjust);
						quantity6MonthsExpired
								.setLopinavir_ritonavirTabs_caps133(stock6monthExpiry);
						expiryDate.setLopinavir_ritonavirTabs_caps133(expiry);
						daysOutOfStock.setLopinavir_ritonavirTabs_caps133(outOfStockDays);
						quantityRequiredResupply.setLopinavir_ritonavirTabs_caps133(stockResupply);
						quantityRequiredNewPatients.setLopinavir_ritonavirTabs_caps133(stockNew);
						totalQuantityRequired.setLopinavir_ritonavirTabs_caps133(totalRequired);
						break;*/
					case 15:
						balanceBF.setNelfinavirTabs250mg(beginningBalance);
						onHand.setNelfinavirTabs250mg(currentBalance);
						losses.setNelfinavirTabs250mg(stockLoss);
						received.setNelfinavirTabs250mg(stockReceived);
						posAdjustments.setNelfinavirTabs250mg(stockPosAdjust);
						negAdjustments.setNelfinavirTabs250mg(stockNegAdjust);
						quantity6MonthsExpired.setNelfinavirTabs250mg(stock6monthExpiry);
						expiryDate.setNelfinavirTabs250mg(expiry);
						daysOutOfStock.setNelfinavirTabs250mg(outOfStockDays);
						quantityRequiredResupply.setNelfinavirTabs250mg(stockResupply);
						quantityRequiredNewPatients.setNelfinavirTabs250mg(stockNew);
						totalQuantityRequired.setNelfinavirTabs250mg(totalRequired);
						break;
					case 16:
						balanceBF.setNevirapineTabs200mg(beginningBalance);
						onHand.setNevirapineTabs200mg(currentBalance);
						losses.setNevirapineTabs200mg(stockLoss);
						received.setNevirapineTabs200mg(stockReceived);
						posAdjustments.setNevirapineTabs200mg(stockPosAdjust);
						negAdjustments.setNevirapineTabs200mg(stockNegAdjust);
						quantity6MonthsExpired.setNevirapineTabs200mg(stock6monthExpiry);
						expiryDate.setNevirapineTabs200mg(expiry);
						daysOutOfStock.setNevirapineTabs200mg(outOfStockDays);
						quantityRequiredResupply.setNevirapineTabs200mg(stockResupply);
						quantityRequiredNewPatients.setNevirapineTabs200mg(stockNew);
						totalQuantityRequired.setNevirapineTabs200mg(totalRequired);
						break;
					case 17:
						balanceBF.setStavudineTabs_Caps30mg(beginningBalance);
						onHand.setStavudineTabs_Caps30mg(currentBalance);
						losses.setStavudineTabs_Caps30mg(stockLoss);
						received.setStavudineTabs_Caps30mg(stockReceived);
						posAdjustments.setStavudineTabs_Caps30mg(stockPosAdjust);
						negAdjustments.setStavudineTabs_Caps30mg(stockNegAdjust);
						quantity6MonthsExpired.setStavudineTabs_Caps30mg(stock6monthExpiry);
						expiryDate.setStavudineTabs_Caps30mg(expiry);
						daysOutOfStock.setStavudineTabs_Caps30mg(outOfStockDays);
						quantityRequiredResupply.setStavudineTabs_Caps30mg(stockResupply);
						quantityRequiredNewPatients.setStavudineTabs_Caps30mg(stockNew);
						totalQuantityRequired.setStavudineTabs_Caps30mg(totalRequired);
						break;
					/*case 18:
						balanceBF.setStavudineTabs_Caps40mg(beginningBalance);
						onHand.setStavudineTabs_Caps40mg(currentBalance);
						losses.setStavudineTabs_Caps40mg(stockLoss);
						received.setStavudineTabs_Caps40mg(stockReceived);
						posAdjustments.setStavudineTabs_Caps40mg(stockPosAdjust);
						negAdjustments.setStavudineTabs_Caps40mg(stockNegAdjust);
						quantity6MonthsExpired.setStavudineTabs_Caps40mg(stock6monthExpiry);
						expiryDate.setStavudineTabs_Caps40mg(expiry);
						daysOutOfStock.setStavudineTabs_Caps40mg(outOfStockDays);
						quantityRequiredResupply.setStavudineTabs_Caps40mg(stockResupply);
						quantityRequiredNewPatients.setStavudineTabs_Caps40mg(stockNew);
						totalQuantityRequired.setStavudineTabs_Caps40mg(totalRequired);
						break;*/
					case 19:
						balanceBF.setTenofovirTabs_caps300mg(beginningBalance);
						onHand.setTenofovirTabs_caps300mg(currentBalance);
						losses.setTenofovirTabs_caps300mg(stockLoss);
						received.setTenofovirTabs_caps300mg(stockReceived);
						posAdjustments.setTenofovirTabs_caps300mg(stockPosAdjust);
						negAdjustments.setTenofovirTabs_caps300mg(stockNegAdjust);
						quantity6MonthsExpired.setTenofovirTabs_caps300mg(stock6monthExpiry);
						expiryDate.setTenofovirTabs_caps300mg(expiry);
						daysOutOfStock.setTenofovirTabs_caps300mg(outOfStockDays);
						quantityRequiredResupply.setTenofovirTabs_caps300mg(stockResupply);
						quantityRequiredNewPatients.setTenofovirTabs_caps300mg(stockNew);
						totalQuantityRequired.setTenofovirTabs_caps300mg(totalRequired);
						break;
					case 20:
						balanceBF.setZidovudineTabs300mg(beginningBalance);
						onHand.setZidovudineTabs300mg(currentBalance);
						losses.setZidovudineTabs300mg(stockLoss);
						received.setZidovudineTabs300mg(stockReceived);
						posAdjustments.setZidovudineTabs300mg(stockPosAdjust);
						negAdjustments.setZidovudineTabs300mg(stockNegAdjust);
						quantity6MonthsExpired.setZidovudineTabs300mg(stock6monthExpiry);
						expiryDate.setZidovudineTabs300mg(expiry);
						daysOutOfStock.setZidovudineTabs300mg(outOfStockDays);
						quantityRequiredResupply.setZidovudineTabs300mg(stockResupply);
						quantityRequiredNewPatients.setZidovudineTabs300mg(stockNew);
						totalQuantityRequired.setZidovudineTabs300mg(totalRequired);
						break;
					case 21:
						balanceBF.setAbacavir_liquid_20mg_ml(beginningBalance);
						onHand.setAbacavir_liquid_20mg_ml(currentBalance);
						losses.setAbacavir_liquid_20mg_ml(stockLoss);
						received.setAbacavir_liquid_20mg_ml(stockReceived);
						posAdjustments.setAbacavir_liquid_20mg_ml(stockPosAdjust);
						negAdjustments.setAbacavir_liquid_20mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setAbacavir_liquid_20mg_ml(stock6monthExpiry);
						expiryDate.setAbacavir_liquid_20mg_ml(expiry);
						daysOutOfStock.setAbacavir_liquid_20mg_ml(outOfStockDays);
						quantityRequiredResupply.setAbacavir_liquid_20mg_ml(stockResupply);
						quantityRequiredNewPatients.setAbacavir_liquid_20mg_ml(stockNew);
						totalQuantityRequired.setAbacavir_liquid_20mg_ml(totalRequired);
						break;
					case 22:
						balanceBF.setDidanosine_Tabs_caps_25mg(beginningBalance);
						onHand.setDidanosine_Tabs_caps_25mg(currentBalance);
						losses.setDidanosine_Tabs_caps_25mg(stockLoss);
						received.setDidanosine_Tabs_caps_25mg(stockReceived);
						posAdjustments.setDidanosine_Tabs_caps_25mg(stockPosAdjust);
						negAdjustments.setDidanosine_Tabs_caps_25mg(stockNegAdjust);
						quantity6MonthsExpired.setDidanosine_Tabs_caps_25mg(stock6monthExpiry);
						expiryDate.setDidanosine_Tabs_caps_25mg(expiry);
						daysOutOfStock.setDidanosine_Tabs_caps_25mg(outOfStockDays);
						quantityRequiredResupply.setDidanosine_Tabs_caps_25mg(stockResupply);
						quantityRequiredNewPatients.setDidanosine_Tabs_caps_25mg(stockNew);
						totalQuantityRequired.setDidanosine_Tabs_caps_25mg(totalRequired);
						break;
					/*case 23:
						balanceBF.setDidanosine_liquid_10mg_ml(beginningBalance);
						onHand.setDidanosine_liquid_10mg_ml(currentBalance);
						losses.setDidanosine_liquid_10mg_ml(stockLoss);
						received.setDidanosine_liquid_10mg_ml(stockReceived);
						posAdjustments.setDidanosine_liquid_10mg_ml(stockPosAdjust);
						negAdjustments.setDidanosine_liquid_10mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setDidanosine_liquid_10mg_ml(stock6monthExpiry);
						expiryDate.setDidanosine_liquid_10mg_ml(expiry);
						daysOutOfStock.setDidanosine_liquid_10mg_ml(outOfStockDays);
						quantityRequiredResupply.setDidanosine_liquid_10mg_ml(stockResupply);
						quantityRequiredNewPatients.setDidanosine_liquid_10mg_ml(stockNew);
						totalQuantityRequired.setDidanosine_liquid_10mg_ml(totalRequired);
						break;*/
					case 24:
						balanceBF.setEfavirenz_Tabs_50mg(beginningBalance);
						onHand.setEfavirenz_Tabs_50mg(currentBalance);
						losses.setEfavirenz_Tabs_50mg(stockLoss);
						received.setEfavirenz_Tabs_50mg(stockReceived);
						posAdjustments.setEfavirenz_Tabs_50mg(stockPosAdjust);
						negAdjustments.setEfavirenz_Tabs_50mg(stockNegAdjust);
						quantity6MonthsExpired.setEfavirenz_Tabs_50mg(stock6monthExpiry);
						expiryDate.setEfavirenz_Tabs_50mg(expiry);
						daysOutOfStock.setEfavirenz_Tabs_50mg(outOfStockDays);
						quantityRequiredResupply.setEfavirenz_Tabs_50mg(stockResupply);
						quantityRequiredNewPatients.setEfavirenz_Tabs_50mg(stockNew);
						totalQuantityRequired.setEfavirenz_Tabs_50mg(totalRequired);
						break;
					case 25:
						balanceBF.setEfavirenz_liquid_30mg_ml(beginningBalance);
						onHand.setEfavirenz_liquid_30mg_ml(currentBalance);
						losses.setEfavirenz_liquid_30mg_ml(stockLoss);
						received.setEfavirenz_liquid_30mg_ml(stockReceived);
						posAdjustments.setEfavirenz_liquid_30mg_ml(stockPosAdjust);
						negAdjustments.setEfavirenz_liquid_30mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setEfavirenz_liquid_30mg_ml(stock6monthExpiry);
						expiryDate.setEfavirenz_liquid_30mg_ml(expiry);
						daysOutOfStock.setEfavirenz_liquid_30mg_ml(outOfStockDays);
						quantityRequiredResupply.setEfavirenz_liquid_30mg_ml(stockResupply);
						quantityRequiredNewPatients.setEfavirenz_liquid_30mg_ml(stockNew);
						totalQuantityRequired.setEfavirenz_liquid_30mg_ml(totalRequired);
						break;
					case 26:
						balanceBF.setLamivudine_liquid_10mg_ml(beginningBalance);
						onHand.setLamivudine_liquid_10mg_ml(currentBalance);
						losses.setLamivudine_liquid_10mg_ml(stockLoss);
						received.setLamivudine_liquid_10mg_ml(stockReceived);
						posAdjustments.setLamivudine_liquid_10mg_ml(stockPosAdjust);
						negAdjustments.setLamivudine_liquid_10mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setLamivudine_liquid_10mg_ml(stock6monthExpiry);
						expiryDate.setLamivudine_liquid_10mg_ml(expiry);
						daysOutOfStock.setLamivudine_liquid_10mg_ml(outOfStockDays);
						quantityRequiredResupply.setLamivudine_liquid_10mg_ml(stockResupply);
						quantityRequiredNewPatients.setLamivudine_liquid_10mg_ml(stockNew);
						totalQuantityRequired.setLamivudine_liquid_10mg_ml(totalRequired);
						break;
					case 27:
						balanceBF.setLopinavir_ritonavir_liquid_80(beginningBalance);
						onHand.setLopinavir_ritonavir_liquid_80(currentBalance);
						losses.setLopinavir_ritonavir_liquid_80(stockLoss);
						received.setLopinavir_ritonavir_liquid_80(stockReceived);
						posAdjustments.setLopinavir_ritonavir_liquid_80(stockPosAdjust);
						negAdjustments.setLopinavir_ritonavir_liquid_80(stockNegAdjust);
						quantity6MonthsExpired.setLopinavir_ritonavir_liquid_80(stock6monthExpiry);
						expiryDate.setLopinavir_ritonavir_liquid_80(expiry);
						daysOutOfStock.setLopinavir_ritonavir_liquid_80(outOfStockDays);
						quantityRequiredResupply.setLopinavir_ritonavir_liquid_80(stockResupply);
						quantityRequiredNewPatients.setLopinavir_ritonavir_liquid_80(stockNew);
						totalQuantityRequired.setLopinavir_ritonavir_liquid_80(totalRequired);
						break;
					/*case 28:
						balanceBF.setNelfinavir_powder_50mg_125ml(beginningBalance);
						onHand.setNelfinavir_powder_50mg_125ml(currentBalance);
						losses.setNelfinavir_powder_50mg_125ml(stockLoss);
						received.setNelfinavir_powder_50mg_125ml(stockReceived);
						posAdjustments.setNelfinavir_powder_50mg_125ml(stockPosAdjust);
						negAdjustments.setNelfinavir_powder_50mg_125ml(stockNegAdjust);
						quantity6MonthsExpired.setNelfinavir_powder_50mg_125ml(stock6monthExpiry);
						expiryDate.setNelfinavir_powder_50mg_125ml(expiry);
						daysOutOfStock.setNelfinavir_powder_50mg_125ml(outOfStockDays);
						quantityRequiredResupply.setNelfinavir_powder_50mg_125ml(stockResupply);
						quantityRequiredNewPatients.setNelfinavir_powder_50mg_125ml(stockNew);
						totalQuantityRequired.setNelfinavir_powder_50mg_125ml(totalRequired);
						break;*/
					case 29:
						balanceBF.setNevirapine_susp_10mg_ml(beginningBalance);
						onHand.setNevirapine_susp_10mg_ml(currentBalance);
						losses.setNevirapine_susp_10mg_ml(stockLoss);
						received.setNevirapine_susp_10mg_ml(stockReceived);
						posAdjustments.setNevirapine_susp_10mg_ml(stockPosAdjust);
						negAdjustments.setNevirapine_susp_10mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setNevirapine_susp_10mg_ml(stock6monthExpiry);
						expiryDate.setNevirapine_susp_10mg_ml(expiry);
						daysOutOfStock.setNevirapine_susp_10mg_ml(outOfStockDays);
						quantityRequiredResupply.setNevirapine_susp_10mg_ml(stockResupply);
						quantityRequiredNewPatients.setNevirapine_susp_10mg_ml(stockNew);
						totalQuantityRequired.setNevirapine_susp_10mg_ml(totalRequired);
						break;
					case 30:
						balanceBF.setStavudine_Tabs_caps_15mg(beginningBalance);
						onHand.setStavudine_Tabs_caps_15mg(currentBalance);
						losses.setStavudine_Tabs_caps_15mg(stockLoss);
						received.setStavudine_Tabs_caps_15mg(stockReceived);
						posAdjustments.setStavudine_Tabs_caps_15mg(stockPosAdjust);
						negAdjustments.setStavudine_Tabs_caps_15mg(stockNegAdjust);
						quantity6MonthsExpired.setStavudine_Tabs_caps_15mg(stock6monthExpiry);
						expiryDate.setStavudine_Tabs_caps_15mg(expiry);
						daysOutOfStock.setStavudine_Tabs_caps_15mg(outOfStockDays);
						quantityRequiredResupply.setStavudine_Tabs_caps_15mg(stockResupply);
						quantityRequiredNewPatients.setStavudine_Tabs_caps_15mg(stockNew);
						totalQuantityRequired.setStavudine_Tabs_caps_15mg(totalRequired);
						break;
					case 31:
						balanceBF.setStavudine_Tabs_caps_20mg(beginningBalance);
						onHand.setStavudine_Tabs_caps_20mg(currentBalance);
						losses.setStavudine_Tabs_caps_20mg(stockLoss);
						received.setStavudine_Tabs_caps_20mg(stockReceived);
						posAdjustments.setStavudine_Tabs_caps_20mg(stockPosAdjust);
						negAdjustments.setStavudine_Tabs_caps_20mg(stockNegAdjust);
						quantity6MonthsExpired.setStavudine_Tabs_caps_20mg(stock6monthExpiry);
						expiryDate.setStavudine_Tabs_caps_20mg(expiry);
						daysOutOfStock.setStavudine_Tabs_caps_20mg(outOfStockDays);
						quantityRequiredResupply.setStavudine_Tabs_caps_20mg(stockResupply);
						quantityRequiredNewPatients.setStavudine_Tabs_caps_20mg(stockNew);
						totalQuantityRequired.setStavudine_Tabs_caps_20mg(totalRequired);
						break;
					/*case 32:
						balanceBF.setStavudine_liquid_1mg_ml(beginningBalance);
						onHand.setStavudine_liquid_1mg_ml(currentBalance);
						losses.setStavudine_liquid_1mg_ml(stockLoss);
						received.setStavudine_liquid_1mg_ml(stockReceived);
						posAdjustments.setStavudine_liquid_1mg_ml(stockPosAdjust);
						negAdjustments.setStavudine_liquid_1mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setStavudine_liquid_1mg_ml(stock6monthExpiry);
						expiryDate.setStavudine_liquid_1mg_ml(expiry);
						daysOutOfStock.setStavudine_liquid_1mg_ml(outOfStockDays);
						quantityRequiredResupply.setStavudine_liquid_1mg_ml(stockResupply);
						quantityRequiredNewPatients.setStavudine_liquid_1mg_ml(stockNew);
						totalQuantityRequired.setStavudine_liquid_1mg_ml(totalRequired);
						break;*/
					case 33:
						balanceBF.setZidovudine_Tabs_caps_100mg(beginningBalance);
						onHand.setZidovudine_Tabs_caps_100mg(currentBalance);
						losses.setZidovudine_Tabs_caps_100mg(stockLoss);
						received.setZidovudine_Tabs_caps_100mg(stockReceived);
						posAdjustments.setZidovudine_Tabs_caps_100mg(stockPosAdjust);
						negAdjustments.setZidovudine_Tabs_caps_100mg(stockNegAdjust);
						quantity6MonthsExpired.setZidovudine_Tabs_caps_100mg(stock6monthExpiry);
						expiryDate.setZidovudine_Tabs_caps_100mg(expiry);
						daysOutOfStock.setZidovudine_Tabs_caps_100mg(outOfStockDays);
						quantityRequiredResupply.setZidovudine_Tabs_caps_100mg(stockResupply);
						quantityRequiredNewPatients.setZidovudine_Tabs_caps_100mg(stockNew);
						totalQuantityRequired.setZidovudine_Tabs_caps_100mg(totalRequired);
						break;
					case 34:
						balanceBF.setZidovudine_liquid_10mg_ml(beginningBalance);
						onHand.setZidovudine_liquid_10mg_ml(currentBalance);
						losses.setZidovudine_liquid_10mg_ml(stockLoss);
						received.setZidovudine_liquid_10mg_ml(stockReceived);
						posAdjustments.setZidovudine_liquid_10mg_ml(stockPosAdjust);
						negAdjustments.setZidovudine_liquid_10mg_ml(stockNegAdjust);
						quantity6MonthsExpired.setZidovudine_liquid_10mg_ml(stock6monthExpiry);
						expiryDate.setZidovudine_liquid_10mg_ml(expiry);
						daysOutOfStock.setZidovudine_liquid_10mg_ml(outOfStockDays);
						quantityRequiredResupply.setZidovudine_liquid_10mg_ml(stockResupply);
						quantityRequiredNewPatients.setZidovudine_liquid_10mg_ml(stockNew);
						totalQuantityRequired.setZidovudine_liquid_10mg_ml(totalRequired);
						break;
					default:
						/*DrugReport drugReport = map.get(itemId);
						if (drugReport == null) {
							drugReport = new DrugReport();
							drugReport.setId(item.getId());
							drugReport.setName(item.getName());
							drugReport.setGroup(item.getItem_group_id());
							drugReport.setItem(item);
						}
						drugReport.setBalanceBF(beginningBalance);
						drugReport.setOnHand(currentBalance);
						drugReport.setLosses(stockLoss);
						drugReport.setReceived(stockReceived);
						drugReport.setPosAdjustments(stockPosAdjust);
						drugReport.setNegAdjustments(stockNegAdjust);
						drugReport.setQuantity6MonthsExpired(stock6monthExpiry);
						drugReport.setExpiryDate(expiryDateD);
						drugReport.setDaysOutOfStock(outOfStockDays);
						drugReport.setQuantityRequiredResupply(stockResupply);
						drugReport.setQuantityRequiredNewPatients(stockNew);
						drugReport.setTotalQuantityRequired(totalRequired);

						if ((drugReport.getTotalDispensed() != null) || (stockChanges.size() > 0)  || ((currentBalance != 0) && (beginningBalance != 0))) {
							map.put(itemId, drugReport);
						}*/


						if (item != null) {
							boolean addDynamicReport = true;
							String code = item.getCode();
							if (code != null) {
								if (code.equals("ddl400")) {
									addDynamicReport = false;
									balanceBF.setDidanosine400mg(beginningBalance);
									onHand.setDidanosine400mg(currentBalance);
									losses.setDidanosine400mg(stockLoss);
									received.setDidanosine400mg(stockReceived);
									posAdjustments.setDidanosine400mg(stockPosAdjust);
									negAdjustments.setDidanosine400mg(stockNegAdjust);
									quantity6MonthsExpired.setDidanosine400mg(stock6monthExpiry);
									expiryDate.setDidanosine400mg(expiry);
									daysOutOfStock.setDidanosine400mg(outOfStockDays);
									quantityRequiredResupply.setDidanosine400mg(stockResupply);
									quantityRequiredNewPatients.setDidanosine400mg(stockNew);
									totalQuantityRequired.setDidanosine400mg(totalRequired);
								} else if (code.equals("ddl250")) {
									addDynamicReport = false;
									balanceBF.setDidanosine250mg(beginningBalance);
									onHand.setDidanosine250mg(currentBalance);
									losses.setDidanosine250mg(stockLoss);
									received.setDidanosine250mg(stockReceived);
									posAdjustments.setDidanosine250mg(stockPosAdjust);
									negAdjustments.setDidanosine250mg(stockNegAdjust);
									quantity6MonthsExpired.setDidanosine250mg(stock6monthExpiry);
									expiryDate.setDidanosine250mg(expiry);
									daysOutOfStock.setDidanosine250mg(outOfStockDays);
									quantityRequiredResupply.setDidanosine250mg(stockResupply);
									quantityRequiredNewPatients.setDidanosine250mg(stockNew);
									totalQuantityRequired.setDidanosine250mg(totalRequired);
								} else if (code.equals("ddl50")) {
									addDynamicReport = false;
									balanceBF.setDidanosine50mg(beginningBalance);
									onHand.setDidanosine50mg(currentBalance);
									losses.setDidanosine50mg(stockLoss);
									received.setDidanosine50mg(stockReceived);
									posAdjustments.setDidanosine50mg(stockPosAdjust);
									negAdjustments.setDidanosine50mg(stockNegAdjust);
									quantity6MonthsExpired.setDidanosine50mg(stock6monthExpiry);
									expiryDate.setDidanosine50mg(expiry);
									daysOutOfStock.setDidanosine50mg(outOfStockDays);
									quantityRequiredResupply.setDidanosine50mg(stockResupply);
									quantityRequiredNewPatients.setDidanosine50mg(stockNew);
									totalQuantityRequired.setDidanosine50mg(totalRequired);
								} else if (code.equals("lpvr20050")) {
									addDynamicReport = false;
									balanceBF.setLopinavir_ritonavir200_50mg(beginningBalance);
									onHand.setLopinavir_ritonavir200_50mg(currentBalance);
									losses.setLopinavir_ritonavir200_50mg(stockLoss);
									received.setLopinavir_ritonavir200_50mg(stockReceived);
									posAdjustments.setLopinavir_ritonavir200_50mg(stockPosAdjust);
									negAdjustments.setLopinavir_ritonavir200_50mg(stockNegAdjust);
									quantity6MonthsExpired.setLopinavir_ritonavir200_50mg(stock6monthExpiry);
									expiryDate.setLopinavir_ritonavir200_50mg(expiry);
									daysOutOfStock.setLopinavir_ritonavir200_50mg(outOfStockDays);
									quantityRequiredResupply.setLopinavir_ritonavir200_50mg(stockResupply);
									quantityRequiredNewPatients.setLopinavir_ritonavir200_50mg(stockNew);
									totalQuantityRequired.setLopinavir_ritonavir200_50mg(totalRequired);
								} else {
									//log.debug("No fields for " + item.getName() + " Code: " + code);
								}
							} else {
								// log.debug("No fields for " + item.getName() + " Code: " + code + " addDynamicReport: " + addDynamicReport);
							}
							if (addDynamicReport) {
								DrugReport drugReport = map.get(itemId);
								if (drugReport == null) {
									drugReport = new DrugReport();
									drugReport.setId(item.getId());
									drugReport.setName(item.getName());
									drugReport.setGroup(item.getItem_group_id());
									drugReport.setItem(item);
									//map.put(key, drugReport);
								}

								drugReport.setBalanceBF(beginningBalance);
								drugReport.setOnHand(currentBalance);
								drugReport.setLosses(stockLoss);
								drugReport.setReceived(stockReceived);
								drugReport.setPosAdjustments(stockPosAdjust);
								drugReport.setNegAdjustments(stockNegAdjust);
								drugReport.setQuantity6MonthsExpired(stock6monthExpiry);
								drugReport.setExpiryDate(expiryDateD);
								drugReport.setDaysOutOfStock(outOfStockDays);
								drugReport.setQuantityRequiredResupply(stockResupply);
								drugReport.setQuantityRequiredNewPatients(stockNew);
								drugReport.setTotalQuantityRequired(totalRequired);

								if ((drugReport.getTotalDispensed() != null) || (stockChanges.size() > 0)  || ((currentBalance != 0) && (beginningBalance != 0))) {
									map.put(itemId, drugReport);
								}
							}
						}

						break;
					}
				}

				Set<Entry<Long,DrugReport>> set = map.entrySet();
				for (Entry<Long, DrugReport> entry : set) {
					DrugReport report = entry.getValue();
					drugReportList.add(report);
				}

				//Collections.sort(drugReportList, new SiteStatisticsDAO().new CodeComparator());
				Collections.sort(drugReportList, new DrugReportNameComparator());

			} catch (SQLException e) {
				log.error(e);
			}

			// Now get stats for ART regimens
			artRegimenReport = new ARTReport();
			regimenReportMap = new HashMap<String, Integer>();
			try {
				rs = RegimenUtils.getArtRegimens(conn, siteId, beginDate, endDate);
				while (rs.next()) {

					Integer age = rs.getInt("age");
					String code = rs.getString("code");

					Long encounterId = rs.getLong("id");
					Long patientId = rs.getLong("patient_id");
					String districtPatientId = rs.getString("district_patient_id");
					String firstName = rs.getString("first_name");
					String surname = rs.getString("surname");
					Date dateVisit = rs.getDate("date_visit");
					int currentSiteId = rs.getInt("site_id");
					String createdBy = rs.getString("created_by");
					Timestamp created = rs.getTimestamp("created");

					ARTCombinedPatient patient = new ARTCombinedPatient();

					patient.setEncounterId(encounterId);
					patient.setPatientId(patientId);
					patient.setClientId(districtPatientId);
					patient.setFirstName(firstName);
					patient.setSurname(surname);
					patient.setDateVisit(dateVisit);
					patient.setSiteId(currentSiteId);
					patient.setPharmacist(createdBy);
					patient.setArvRegimenCode(code);
					patient.setCreated(created);

					if (age <=14) {
						patient.setChildOrAdult("C");
					} else {
						patient.setChildOrAdult("A");
					}


					// increment the totals
					if (age != null && age > 14) {
						int n = artRegimenReport.getTotalAdults();
						n++;
						artRegimenReport.setTotalAdults(n);
					}
					if (age != null && age <= 14) {
						int n = artRegimenReport.getTotalChildren();
						n++;
						artRegimenReport.setTotalChildren(n);
					}
					
					/*String key = "regimen" + code.trim().replace(" ", "_");
					int amount = 0;
					if (regimenReportMap.get(key) != null) {
						amount = regimenReportMap.get(key);
					}
					amount++;
					regimenReportMap.put(key, amount);*/

					if (patient != null) {
						// check if this is the first visit - there might be multiples ones for this encounter
						Date firstVisit = EncountersDAO.getFirstVisit(conn, patientId);
						if (firstVisit.getTime() == dateVisit.getTime()) {
							patient.setRevisit(false);
						} else {
							patient.setRevisit(true);
						}
						this.addPatient(patient);
						/*if (patientMap.get(patient.getPatientId()) != null) {
                            	ARTCombinedPatient encounter = (ARTCombinedPatient) patientMap.get(patient.getPatientId());
                                encounters.add(patient);
                            } else {
                            	patientMap.put(patient.getPatientId(), patient);
                            }*/
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			artRegimenReport.setRegimenReportMap(regimenReportMap); 
			
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
	 * @return the itemMap
	 */
	public LinkedHashMap<Long, Item> getItemMap() {
		return itemMap;
	}

	/**
	 * @param itemMap the itemMap to set
	 */
	public void setItemMap(LinkedHashMap<Long, Item> itemMap) {
		this.itemMap = itemMap;
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

}

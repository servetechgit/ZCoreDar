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
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.SortedSet;
import java.util.TimeZone;
import java.util.TreeSet;

import javax.servlet.ServletException;

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
import org.rti.zcore.dar.report.valueobject.ARTReport;
import org.rti.zcore.dar.report.valueobject.DrugReport;
import org.rti.zcore.dar.report.valueobject.OIExpiration;
import org.rti.zcore.dar.report.valueobject.OIPatient;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.dar.utils.sort.DrugReportNameComparator;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.WidgetUtils;
import org.rti.zcore.utils.sort.CreatedComparator;

/**
 * @author ckelley
 */
public class CDRROIReport extends Register {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(CDRROIReport.class);

	//ArrayList<ARTCombinedPatient> patients = new ArrayList<ARTCombinedPatient>(new CreatedComparator());

	private SortedSet<OIPatient> patients = new TreeSet<OIPatient>(new CreatedComparator());
	// private SortedMap<Long, ARTCombinedPatient> patientMap = new TreeMap <Long,ARTCombinedPatient>();
	private String reportMonth;
	private String reportYear;
	private String type;
	private OIPatient balanceBF;
	private OIPatient received;
	private OIPatient onHand;
	private OIPatient totalDispensed;
	private HashMap totalDispensedMap;
	private OIPatient losses;
	private OIPatient posAdjustments;
	private OIPatient negAdjustments;
	private OIPatient balanceCF;
	private OIPatient quantity6MonthsExpired;
	private OIExpiration expiryDate;
	private OIPatient daysOutOfStock;
	private OIPatient quantityRequiredResupply;
	private OIPatient quantityRequiredNewPatients;
	private OIPatient totalQuantityRequired;
	private ARTReport artRegimenReport;
	private ArrayList<DrugReport> drugReportList;

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
	public void addPatient(OIPatient patient) {
		/*if (patients == null) {
            patients = new SortedSet();
        }*/
		patients.add(patient);
	}

	/**
	 * @return the balanceBF
	 */
	public OIPatient getBalanceBF() {
		return balanceBF;
	}

	/**
	 * @param balanceBF the balanceBF to set
	 */
	public void setBalanceBF(OIPatient balanceBF) {
		this.balanceBF = balanceBF;
	}

	/**
	 * @return the received
	 */
	public OIPatient getReceived() {
		return received;
	}

	/**
	 * @param received the received to set
	 */
	public void setReceived(OIPatient received) {
		this.received = received;
	}

	/**
	 * @return the onHand
	 */
	public OIPatient getOnHand() {
		return onHand;
	}

	/**
	 * @param onHand the onHand to set
	 */
	public void setOnHand(OIPatient onHand) {
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
	public OIPatient getTotalDispensed() {
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
	public void setTotalDispensed(OIPatient totalDispensed) {
		this.totalDispensed = totalDispensed;
	}

	/**
	 * @return the losses
	 */
	public OIPatient getLosses() {
		return losses;
	}

	/**
	 * @param losses the losses to set
	 */
	public void setLosses(OIPatient losses) {
		this.losses = losses;
	}

	public OIPatient getPosAdjustments() {
		return posAdjustments;
	}

	public void setPosAdjustments(OIPatient posAdjustments) {
		this.posAdjustments = posAdjustments;
	}

	public OIPatient getNegAdjustments() {
		return negAdjustments;
	}

	public void setNegAdjustments(OIPatient negAdjustments) {
		this.negAdjustments = negAdjustments;
	}

	/**
	 * @return the balanceCF
	 */
	public OIPatient getBalanceCF() {
		return balanceCF;
	}

	/**
	 * @param balanceCF the balanceCF to set
	 */
	public void setBalanceCF(OIPatient balanceCF) {
		this.balanceCF = balanceCF;
	}

	public OIPatient getQuantity6MonthsExpired() {
		return quantity6MonthsExpired;
	}

	public void setQuantity6MonthsExpired(OIPatient quantity6MonthsExpired) {
		this.quantity6MonthsExpired = quantity6MonthsExpired;
	}

	public OIExpiration getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(OIExpiration expiryDate) {
		this.expiryDate = expiryDate;
	}

	public OIPatient getDaysOutOfStock() {
		return daysOutOfStock;
	}

	public void setDaysOutOfStock(OIPatient daysOutOfStock) {
		this.daysOutOfStock = daysOutOfStock;
	}

	public OIPatient getQuantityRequiredResupply() {
		return quantityRequiredResupply;
	}

	public void setQuantityRequiredResupply(OIPatient quantityRequiredResupply) {
		this.quantityRequiredResupply = quantityRequiredResupply;
	}

	public OIPatient getQuantityRequiredNewPatients() {
		return quantityRequiredNewPatients;
	}

	public void setQuantityRequiredNewPatients(OIPatient quantityRequiredNewPatients) {
		this.quantityRequiredNewPatients = quantityRequiredNewPatients;
	}

	public OIPatient getTotalQuantityRequired() {
		return totalQuantityRequired;
	}

	public void setTotalQuantityRequired(OIPatient totalQuantityRequired) {
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

            drugReportList = new ArrayList<DrugReport>();
    		HashMap<Long,DrugReport> map = new HashMap<Long,DrugReport>();
    		HashMap<Long,Item> itemMap = new HashMap<Long,Item>();

    		// Create a map with Item id, name
    		ArrayList<Item> items = (ArrayList<Item>) EncountersDAO.getAll(conn, Long.valueOf(131), "SQL_RETRIEVE_ALL_ADMIN_PAGER131", Item.class);

    		for (Item item : items) {
    			itemMap.put(item.getId(), item);
			}

			// For each patient, load the report class and add this patient to the list
			// also increment the total dispensed values
			totalDispensed = new OIPatient();
			totalDispensedMap = new HashMap();
			try {
				rs = getEncounters(conn, siteId, beginDate, endDate);
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

						OIPatient patient = new OIPatient();

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


							int n = 0;
							if (key != null) {
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

								switch (key.intValue()) {
								case 51:
									patient.setAcyclovir200mg(value);
									isArtVisit = true;
									if (totalDispensed.getAcyclovir200mg() != null) {
										n = totalDispensed.getAcyclovir200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAcyclovir200mg(n);
									break;
								case 52:
									patient.setAcyclovirIVInfusion(value);
									isArtVisit = true;
									if (totalDispensed.getAcyclovirIVInfusion() != null) {
										n = totalDispensed.getAcyclovirIVInfusion() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAcyclovirIVInfusion(n);
									break;
								case 50:
									patient.setAminosidineSulphate(value);
									isArtVisit = true;
									if (totalDispensed.getAminosidineSulphate() != null) {
										n = totalDispensed.getAminosidineSulphate() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAminosidineSulphate(n);
									break;
								case 49:
									patient.setAminosidineSulphateliquid(value);
									isArtVisit = true;
									if (totalDispensed.getAminosidineSulphateliquid() != null) {
										n = totalDispensed.getAminosidineSulphateliquid() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAminosidineSulphateliquid(n);
									break;
								case 44:
									patient.setAmphotericinBInjection(value);
									isArtVisit = true;
									if (totalDispensed.getAmphotericinBInjection() != null) {
										n = totalDispensed.getAmphotericinBInjection() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setAmphotericinBInjection(n);
									break;
								case 48:
									patient.setCeftriaxoneInj250mgIM(value);
									isArtVisit = true;
									if (totalDispensed.getCeftriaxoneInj250mgIM() != null) {
										n = totalDispensed.getCeftriaxoneInj250mgIM() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setCeftriaxoneInj250mgIM(n);
									break;
								case 47:
									patient.setCiprofloxacinTabs500mg(value);
									isArtVisit = true;
									if (totalDispensed.getCiprofloxacinTabs500mg() != null) {
										n = totalDispensed.getCiprofloxacinTabs500mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setCiprofloxacinTabs500mg(n);
									break;
								case 46:
									patient.setCotrimoxazoleDS960mg(value);
									isArtVisit = true;
									if (totalDispensed.getCotrimoxazoleDS960mg() != null) {
										n = totalDispensed.getCotrimoxazoleDS960mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setCotrimoxazoleDS960mg(n);
									break;
								case 174:
									patient.setCotrimoxazoleTabs480mg(value);
									isArtVisit = true;
									if (totalDispensed.getCotrimoxazoleTabs480mg() != null) {
										n = totalDispensed.getCotrimoxazoleTabs480mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setCotrimoxazoleTabs480mg(n);
									break;
								case 45:
									patient.setCotrimoxazolesusp240mg_5ml(value);
									isArtVisit = true;
									if (totalDispensed.getCotrimoxazolesusp240mg_5ml() != null) {
										n = totalDispensed.getCotrimoxazolesusp240mg_5ml() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setCotrimoxazolesusp240mg_5ml(n);
									break;
								case 35:
									patient.setDiflucan200mg(value);
									isArtVisit = true;
									if (totalDispensed.getDiflucan200mg() != null) {
										n = totalDispensed.getDiflucan200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDiflucan200mg(n);
									break;
								case 37:
									patient.setDiflucanInfusion(value);
									isArtVisit = true;
									if (totalDispensed.getDiflucanInfusion() != null) {
										n = totalDispensed.getDiflucanInfusion() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDiflucanInfusion(n);
									break;
								case 36:
									patient.setDiflucansuspension(value);
									isArtVisit = true;
									if (totalDispensed.getDiflucansuspension() != null) {
										n = totalDispensed.getDiflucansuspension() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setDiflucansuspension(n);
									break;
								case 39:
									patient.setFluconazole150mg(value);
									isArtVisit = true;
									if (totalDispensed.getFluconazole150mg() != null) {
										n = totalDispensed.getFluconazole150mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setFluconazole150mg(n);
									break;
								case 38:
									patient.setFluconazole200mg(value);
									isArtVisit = true;
									if (totalDispensed.getFluconazole200mg() != null) {
										n = totalDispensed.getFluconazole200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setFluconazole200mg(n);
									break;
								case 40:
									patient.setFluconazole50mg(value);
									isArtVisit = true;
									if (totalDispensed.getFluconazole50mg() != null) {
										n = totalDispensed.getFluconazole50mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setFluconazole50mg(n);
									break;
								case 41:
									patient.setKetaconazole200mg(value);
									isArtVisit = true;
									if (totalDispensed.getKetaconazole200mg() != null) {
										n = totalDispensed.getKetaconazole200mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setKetaconazole200mg(n);
									break;
								case 42:
									patient.setMiconazoleNitrate2OralGel(value);
									isArtVisit = true;
									if (totalDispensed.getMiconazoleNitrate2OralGel() != null) {
										n = totalDispensed.getMiconazoleNitrate2OralGel() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setMiconazoleNitrate2OralGel(n);
									break;
								case 43:
									patient.setNystatinOralSuspension100000Units(value);
									isArtVisit = true;
									if (totalDispensed.getNystatinOralSuspension100000Units() != null) {
										n = totalDispensed.getNystatinOralSuspension100000Units() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setNystatinOralSuspension100000Units(n);
									break;
								case 53:
									patient.setPyridoxine25mg(value);
									isArtVisit = true;
									if (totalDispensed.getPyridoxine25mg() != null) {
										n = totalDispensed.getPyridoxine25mg() + value;
									} else {
										n = value;
									}
									totalDispensedMap.put(key.intValue(), n);
									totalDispensed.setPyridoxine25mg(n);
									break;
								default:
									break;
								}
							} else {
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
				balanceBF = new OIPatient();
				received = new OIPatient();
				onHand = new OIPatient();
				losses = new OIPatient();
				negAdjustments = new OIPatient();
				posAdjustments  = new OIPatient();
				quantity6MonthsExpired = new OIPatient();
				expiryDate = new OIExpiration();
				daysOutOfStock = new OIPatient();
				quantityRequiredResupply = new OIPatient();
				quantityRequiredNewPatients = new OIPatient();
				totalQuantityRequired = new OIPatient();

				//HashMap<Long, List<StockControl>> stockMap = InventoryDAO.getPatientStockMap(conn, siteId, beginDate, endDate);
				HashMap<Long,StockReport> balanceMap = InventoryDAO.getBalanceMap(conn, siteId, null,endDate);
				HashMap<Long,StockReport> balanceBFMap = InventoryDAO.getBalanceMap(conn, null, beginDate,endDate);
				//https://ogembo@bitbucket.org/ogembo/zcore-dar.git
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(org.rti.zcore.Constants.DATE_FORMAT_SHORT);
		    	sdf.setTimeZone(TimeZone.getDefault());
//https://github.com/boloogembo/chrisekelley.github.io.git
		    	//https://github.com/chrisekelley/dar
		    	//https://github.com/chrisekelley/dar.git
		    	//https://github.com/boloogembo/chrisekelley.github.io.git
		    	//https://github.com/boloogembo/dar.git
				Integer currentBalance = null;
				List<DropdownItem> list = WidgetUtils.getList(conn, "item", "id", " WHERE ITEM_GROUP_ID < 9 ", " ORDER BY id ", DropdownItem.class, null);
				for (DropdownItem dropdownItem : list) {
					Long itemId = Long.valueOf(dropdownItem.getDropdownId());
					List<StockControl> stockChanges = (List<StockControl>) InventoryDAO.getStockChanges(conn, itemId, siteId, beginDate, endDate);
					StockReport stockReport = balanceMap.get(itemId);
			        if (stockReport == null) {
			        	currentBalance = 0;
			        } else {
			        	currentBalance = stockReport.getOnHand();
			        }
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
					//String expiryStr = null;
					Boolean isExpirySet = false;
					int i =0;
					//Integer totalLosses = 0;
					//List<StockControl> stockChanges = (List<StockControl>) InventoryDAO.getStockChanges(conn, itemId, siteId, beginDate, endDate);
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
									} else {
										//log.debug("stock.getExpiry_date() -- null for itemId: " + stock.getId());
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

					switch (itemId.intValue()) {
					case 51:
						balanceBF.setAcyclovir200mg(beginningBalance);
						onHand.setAcyclovir200mg(currentBalance);
						losses.setAcyclovir200mg(stockLoss);
						received.setAcyclovir200mg(stockReceived);
						posAdjustments.setAcyclovir200mg(stockPosAdjust);
						negAdjustments.setAcyclovir200mg(stockNegAdjust);
						quantity6MonthsExpired.setAcyclovir200mg(stock6monthExpiry);
						expiryDate.setAcyclovir200mg(expiry);
						daysOutOfStock.setAcyclovir200mg(outOfStockDays);
						quantityRequiredResupply.setAcyclovir200mg(stockResupply);
						quantityRequiredNewPatients.setAcyclovir200mg(stockNew);
						totalQuantityRequired.setAcyclovir200mg(totalRequired);
						break;
					case 52:
						balanceBF.setAcyclovirIVInfusion(beginningBalance);
						onHand.setAcyclovirIVInfusion(currentBalance);
						losses.setAcyclovirIVInfusion(stockLoss);
						received.setAcyclovirIVInfusion(stockReceived);
						posAdjustments.setAcyclovirIVInfusion(stockPosAdjust);
						negAdjustments.setAcyclovirIVInfusion(stockNegAdjust);
						quantity6MonthsExpired
								.setAcyclovirIVInfusion(stock6monthExpiry);
						expiryDate.setAcyclovirIVInfusion(expiry);
						daysOutOfStock.setAcyclovirIVInfusion(outOfStockDays);
						quantityRequiredResupply.setAcyclovirIVInfusion(stockResupply);
						quantityRequiredNewPatients.setAcyclovirIVInfusion(stockNew);
						totalQuantityRequired.setAcyclovirIVInfusion(totalRequired);
						break;
					case 50:
						balanceBF.setAminosidineSulphate(beginningBalance);
						onHand.setAminosidineSulphate(currentBalance);
						losses.setAminosidineSulphate(stockLoss);
						received.setAminosidineSulphate(stockReceived);
						posAdjustments.setAminosidineSulphate(stockPosAdjust);
						negAdjustments
								.setAminosidineSulphate(stockNegAdjust);
						quantity6MonthsExpired
								.setAminosidineSulphate(stock6monthExpiry);
						expiryDate.setAminosidineSulphate(expiry);
						daysOutOfStock.setAminosidineSulphate(outOfStockDays);
						quantityRequiredResupply.setAminosidineSulphate(stockResupply);
						quantityRequiredNewPatients.setAminosidineSulphate(stockNew);
						totalQuantityRequired.setAminosidineSulphate(totalRequired);
						break;
					case 49:
						balanceBF.setAminosidineSulphateliquid(beginningBalance);
						onHand.setAminosidineSulphateliquid(currentBalance);
						losses.setAminosidineSulphateliquid(stockLoss);
						received.setAminosidineSulphateliquid(stockReceived);
						posAdjustments.setAminosidineSulphateliquid(stockPosAdjust);
						negAdjustments
								.setAminosidineSulphateliquid(stockNegAdjust);
						quantity6MonthsExpired
								.setAminosidineSulphateliquid(stock6monthExpiry);
						expiryDate.setAminosidineSulphateliquid(expiry);
						daysOutOfStock.setAminosidineSulphateliquid(outOfStockDays);
						quantityRequiredResupply.setAminosidineSulphateliquid(stockResupply);
						quantityRequiredNewPatients.setAminosidineSulphateliquid(stockNew);
						totalQuantityRequired.setAminosidineSulphateliquid(totalRequired);
						break;
					case 44:
						balanceBF.setAmphotericinBInjection(beginningBalance);
						onHand.setAmphotericinBInjection(currentBalance);
						losses.setAmphotericinBInjection(stockLoss);
						received.setAmphotericinBInjection(stockReceived);
						posAdjustments.setAmphotericinBInjection(stockPosAdjust);
						negAdjustments
								.setAmphotericinBInjection(stockNegAdjust);
						quantity6MonthsExpired
								.setAmphotericinBInjection(stock6monthExpiry);
						expiryDate.setAmphotericinBInjection(expiry);
						daysOutOfStock.setAmphotericinBInjection(outOfStockDays);
						quantityRequiredResupply.setAmphotericinBInjection(stockResupply);
						quantityRequiredNewPatients.setAmphotericinBInjection(stockNew);
						totalQuantityRequired.setAmphotericinBInjection(totalRequired);
						break;
					case 48:
						balanceBF.setCeftriaxoneInj250mgIM(beginningBalance);
						onHand.setCeftriaxoneInj250mgIM(currentBalance);
						losses.setCeftriaxoneInj250mgIM(stockLoss);
						received.setCeftriaxoneInj250mgIM(stockReceived);
						posAdjustments.setCeftriaxoneInj250mgIM(stockPosAdjust);
						negAdjustments
								.setCeftriaxoneInj250mgIM(stockNegAdjust);
						quantity6MonthsExpired
								.setCeftriaxoneInj250mgIM(stock6monthExpiry);
						expiryDate.setCeftriaxoneInj250mgIM(expiry);
						daysOutOfStock.setCeftriaxoneInj250mgIM(outOfStockDays);
						quantityRequiredResupply.setCeftriaxoneInj250mgIM(stockResupply);
						quantityRequiredNewPatients.setCeftriaxoneInj250mgIM(stockNew);
						totalQuantityRequired.setCeftriaxoneInj250mgIM(totalRequired);
						break;
					case 47:
						balanceBF.setCiprofloxacinTabs500mg(beginningBalance);
						onHand.setCiprofloxacinTabs500mg(currentBalance);
						losses.setCiprofloxacinTabs500mg(stockLoss);
						received.setCiprofloxacinTabs500mg(stockReceived);
						posAdjustments.setCiprofloxacinTabs500mg(stockPosAdjust);
						negAdjustments.setCiprofloxacinTabs500mg(stockNegAdjust);
						quantity6MonthsExpired.setCiprofloxacinTabs500mg(stock6monthExpiry);
						expiryDate.setCiprofloxacinTabs500mg(expiry);
						daysOutOfStock.setCiprofloxacinTabs500mg(outOfStockDays);
						quantityRequiredResupply.setCiprofloxacinTabs500mg(stockResupply);
						quantityRequiredNewPatients.setCiprofloxacinTabs500mg(stockNew);
						totalQuantityRequired.setCiprofloxacinTabs500mg(totalRequired);
						break;
					case 46:
						balanceBF.setCotrimoxazoleDS960mg(beginningBalance);
						onHand.setCotrimoxazoleDS960mg(currentBalance);
						losses.setCotrimoxazoleDS960mg(stockLoss);
						negAdjustments.setCotrimoxazoleDS960mg(stockNegAdjust);
						posAdjustments.setCotrimoxazoleDS960mg(stockPosAdjust);
						received.setCotrimoxazoleDS960mg(stockReceived);
						quantity6MonthsExpired.setCotrimoxazoleDS960mg(stock6monthExpiry);
						expiryDate.setCotrimoxazoleDS960mg(expiry);
						daysOutOfStock.setCotrimoxazoleDS960mg(outOfStockDays);
						quantityRequiredResupply.setCotrimoxazoleDS960mg(stockResupply);
						quantityRequiredNewPatients.setCotrimoxazoleDS960mg(stockNew);
						totalQuantityRequired.setCotrimoxazoleDS960mg(totalRequired);
						break;
					case 174:
						balanceBF.setCotrimoxazoleTabs480mg(beginningBalance);
						onHand.setCotrimoxazoleTabs480mg(currentBalance);
						losses.setCotrimoxazoleTabs480mg(stockLoss);
						negAdjustments.setCotrimoxazoleTabs480mg(stockNegAdjust);
						posAdjustments.setCotrimoxazoleTabs480mg(stockPosAdjust);
						received.setCotrimoxazoleTabs480mg(stockReceived);
						quantity6MonthsExpired.setCotrimoxazoleTabs480mg(stock6monthExpiry);
						expiryDate.setCotrimoxazoleTabs480mg(expiry);
						daysOutOfStock.setCotrimoxazoleTabs480mg(outOfStockDays);
						quantityRequiredResupply.setCotrimoxazoleTabs480mg(stockResupply);
						quantityRequiredNewPatients.setCotrimoxazoleTabs480mg(stockNew);
						totalQuantityRequired.setCotrimoxazoleTabs480mg(totalRequired);
						break;
					case 45:
						balanceBF.setCotrimoxazolesusp240mg_5ml(beginningBalance);
						onHand.setCotrimoxazolesusp240mg_5ml(currentBalance);
						losses.setCotrimoxazolesusp240mg_5ml(stockLoss);
						negAdjustments.setCotrimoxazolesusp240mg_5ml(stockNegAdjust);
						posAdjustments.setCotrimoxazolesusp240mg_5ml(stockPosAdjust);
						received.setCotrimoxazolesusp240mg_5ml(stockReceived);
						quantity6MonthsExpired.setCotrimoxazolesusp240mg_5ml(stock6monthExpiry);
						expiryDate.setCotrimoxazolesusp240mg_5ml(expiry);
						daysOutOfStock.setCotrimoxazolesusp240mg_5ml(outOfStockDays);
						quantityRequiredResupply.setCotrimoxazolesusp240mg_5ml(stockResupply);
						quantityRequiredNewPatients.setCotrimoxazolesusp240mg_5ml(stockNew);
						totalQuantityRequired.setCotrimoxazolesusp240mg_5ml(totalRequired);
						break;
					case 35:
						balanceBF.setDiflucan200mg(beginningBalance);
						onHand.setDiflucan200mg(currentBalance);
						losses.setDiflucan200mg(stockLoss);
						received.setDiflucan200mg(stockReceived);
						posAdjustments.setDiflucan200mg(stockPosAdjust);
						negAdjustments.setDiflucan200mg(stockNegAdjust);
						quantity6MonthsExpired.setDiflucan200mg(stock6monthExpiry);
						expiryDate.setDiflucan200mg(expiry);
						daysOutOfStock.setDiflucan200mg(outOfStockDays);
						quantityRequiredResupply.setDiflucan200mg(stockResupply);
						quantityRequiredNewPatients.setDiflucan200mg(stockNew);
						totalQuantityRequired.setDiflucan200mg(totalRequired);
						break;
					case 37:
						balanceBF.setDiflucanInfusion(beginningBalance);
						onHand.setDiflucanInfusion(currentBalance);
						losses.setDiflucanInfusion(stockLoss);
						received.setDiflucanInfusion(stockReceived);
						posAdjustments.setDiflucanInfusion(stockPosAdjust);
						negAdjustments.setDiflucanInfusion(stockNegAdjust);
						quantity6MonthsExpired.setDiflucanInfusion(stock6monthExpiry);
						expiryDate.setDiflucanInfusion(expiry);
						daysOutOfStock.setDiflucanInfusion(outOfStockDays);
						quantityRequiredResupply.setDiflucanInfusion(stockResupply);
						quantityRequiredNewPatients.setDiflucanInfusion(stockNew);
						totalQuantityRequired.setDiflucanInfusion(totalRequired);
						break;
					case 36:
						balanceBF.setDiflucansuspension(beginningBalance);
						onHand.setDiflucansuspension(currentBalance);
						losses.setDiflucansuspension(stockLoss);
						received.setDiflucansuspension(stockReceived);
						posAdjustments.setDiflucansuspension(stockPosAdjust);
						negAdjustments.setDiflucansuspension(stockNegAdjust);
						quantity6MonthsExpired.setDiflucansuspension(stock6monthExpiry);
						expiryDate.setDiflucansuspension(expiry);
						daysOutOfStock.setDiflucansuspension(outOfStockDays);
						quantityRequiredResupply.setDiflucansuspension(stockResupply);
						quantityRequiredNewPatients.setDiflucansuspension(stockNew);
						totalQuantityRequired.setDiflucansuspension(totalRequired);
						break;
					case 39:
						balanceBF.setFluconazole150mg(beginningBalance);
						onHand.setFluconazole150mg(currentBalance);
						losses.setFluconazole150mg(stockLoss);
						received.setFluconazole150mg(stockReceived);
						posAdjustments.setFluconazole150mg(stockPosAdjust);
						negAdjustments.setFluconazole150mg(stockNegAdjust);
						quantity6MonthsExpired
								.setFluconazole150mg(stock6monthExpiry);
						expiryDate.setFluconazole150mg(expiry);
						daysOutOfStock.setFluconazole150mg(outOfStockDays);
						quantityRequiredResupply.setFluconazole150mg(stockResupply);
						quantityRequiredNewPatients.setFluconazole150mg(stockNew);
						totalQuantityRequired.setFluconazole150mg(totalRequired);
						break;
					case 38:
						balanceBF.setFluconazole200mg(beginningBalance);
						onHand.setFluconazole200mg(currentBalance);
						losses.setFluconazole200mg(stockLoss);
						received.setFluconazole200mg(stockReceived);
						posAdjustments.setFluconazole200mg(stockPosAdjust);
						negAdjustments.setFluconazole200mg(stockNegAdjust);
						quantity6MonthsExpired.setFluconazole200mg(stock6monthExpiry);
						expiryDate.setFluconazole200mg(expiry);
						daysOutOfStock.setFluconazole200mg(outOfStockDays);
						quantityRequiredResupply.setFluconazole200mg(stockResupply);
						quantityRequiredNewPatients.setFluconazole200mg(stockNew);
						totalQuantityRequired.setFluconazole200mg(totalRequired);
						break;
					case 40:
						balanceBF.setFluconazole50mg(beginningBalance);
						onHand.setFluconazole50mg(currentBalance);
						losses.setFluconazole50mg(stockLoss);
						received.setFluconazole50mg(stockReceived);
						posAdjustments.setFluconazole50mg(stockPosAdjust);
						negAdjustments.setFluconazole50mg(stockNegAdjust);
						quantity6MonthsExpired.setFluconazole50mg(stock6monthExpiry);
						expiryDate.setFluconazole50mg(expiry);
						daysOutOfStock.setFluconazole50mg(outOfStockDays);
						quantityRequiredResupply.setFluconazole50mg(stockResupply);
						quantityRequiredNewPatients.setFluconazole50mg(stockNew);
						totalQuantityRequired.setFluconazole50mg(totalRequired);
						break;
					case 41:
						balanceBF.setKetaconazole200mg(beginningBalance);
						onHand.setKetaconazole200mg(currentBalance);
						losses.setKetaconazole200mg(stockLoss);
						received.setKetaconazole200mg(stockReceived);
						posAdjustments.setKetaconazole200mg(stockPosAdjust);
						negAdjustments.setKetaconazole200mg(stockNegAdjust);
						quantity6MonthsExpired.setKetaconazole200mg(stock6monthExpiry);
						expiryDate.setKetaconazole200mg(expiry);
						daysOutOfStock.setKetaconazole200mg(outOfStockDays);
						quantityRequiredResupply.setKetaconazole200mg(stockResupply);
						quantityRequiredNewPatients.setKetaconazole200mg(stockNew);
						totalQuantityRequired.setKetaconazole200mg(totalRequired);
						break;
					case 42:
						balanceBF.setMiconazoleNitrate2OralGel(beginningBalance);
						onHand.setMiconazoleNitrate2OralGel(currentBalance);
						losses.setMiconazoleNitrate2OralGel(stockLoss);
						received.setMiconazoleNitrate2OralGel(stockReceived);
						posAdjustments.setMiconazoleNitrate2OralGel(stockPosAdjust);
						negAdjustments.setMiconazoleNitrate2OralGel(stockNegAdjust);
						quantity6MonthsExpired.setMiconazoleNitrate2OralGel(stock6monthExpiry);
						expiryDate.setMiconazoleNitrate2OralGel(expiry);
						daysOutOfStock.setMiconazoleNitrate2OralGel(outOfStockDays);
						quantityRequiredResupply.setMiconazoleNitrate2OralGel(stockResupply);
						quantityRequiredNewPatients.setMiconazoleNitrate2OralGel(stockNew);
						totalQuantityRequired.setMiconazoleNitrate2OralGel(totalRequired);
						break;
					case 43:
						balanceBF.setNystatinOralSuspension100000Units(beginningBalance);
						onHand.setNystatinOralSuspension100000Units(currentBalance);
						losses.setNystatinOralSuspension100000Units(stockLoss);
						received.setNystatinOralSuspension100000Units(stockReceived);
						posAdjustments.setNystatinOralSuspension100000Units(stockPosAdjust);
						negAdjustments.setNystatinOralSuspension100000Units(stockNegAdjust);
						quantity6MonthsExpired.setNystatinOralSuspension100000Units(stock6monthExpiry);
						expiryDate.setNystatinOralSuspension100000Units(expiry);
						daysOutOfStock.setNystatinOralSuspension100000Units(outOfStockDays);
						quantityRequiredResupply.setNystatinOralSuspension100000Units(stockResupply);
						quantityRequiredNewPatients.setNystatinOralSuspension100000Units(stockNew);
						totalQuantityRequired.setNystatinOralSuspension100000Units(totalRequired);
						break;
					case 53:
						balanceBF.setPyridoxine25mg(beginningBalance);
						onHand.setPyridoxine25mg(currentBalance);
						losses.setPyridoxine25mg(stockLoss);
						received.setPyridoxine25mg(stockReceived);
						posAdjustments.setPyridoxine25mg(stockPosAdjust);
						negAdjustments.setPyridoxine25mg(stockNegAdjust);
						quantity6MonthsExpired.setPyridoxine25mg(stock6monthExpiry);
						expiryDate.setPyridoxine25mg(expiry);
						daysOutOfStock.setPyridoxine25mg(outOfStockDays);
						quantityRequiredResupply.setPyridoxine25mg(stockResupply);
						quantityRequiredNewPatients.setPyridoxine25mg(stockNew);
						totalQuantityRequired.setPyridoxine25mg(totalRequired);
						break;
					default:
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
			try {
				rs = getArtRegimens(conn, siteId, beginDate, endDate);
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

					OIPatient patient = new OIPatient();

					patient.setEncounterId(encounterId);
					patient.setPatientId(patientId);
					patient.setClientId(districtPatientId);
					patient.setFirstName(firstName);
					patient.setSurname(surname);
					patient.setDateVisit(dateVisit);
					patient.setSiteId(currentSiteId);
					patient.setPharmacist(createdBy);
					//patient.setArvRegimenCode(code);
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
	 * Retrieve all Encounter records for this form 132 - Patient dispensary
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ServletException
	 */
	protected static ResultSet getEncounters(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {

		ResultSet rs = null;

		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}

		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, encounter.created " +
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
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, encounter.created " +
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
	 * Get ART regimen records (regimen code field) for this period/site
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ServletException
	 */
	protected static ResultSet getArtRegimens(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {

		ResultSet rs = null;

		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}

		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
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
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
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

}

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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.DropdownItem;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.Register;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.dao.PatientItemDAO;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.OIPatient;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.WidgetUtils;

/**
 * @author ckelley
 */
public class OIDailyActivityReport extends Register {


	/**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(OIDailyActivityReport.class);

    ArrayList<OIPatient> patients = new ArrayList<OIPatient>();
    String reportMonth;
    String reportYear;
    String type;
    OIPatient balanceBF;
    OIPatient received;
    OIPatient balanceCF;
    OIPatient onHand;
    OIPatient totalDispensed;
    OIPatient losses;


    public OIDailyActivityReport() {
		super();
	}

	public OIDailyActivityReport(ArrayList<OIPatient> patients, String reportMonth, String reportYear, String type,
			OIPatient balanceBF, OIPatient received, OIPatient balanceCF, OIPatient onHand, OIPatient totalDispensed,
			OIPatient losses) {
		super();
		this.patients = patients;
		this.reportMonth = reportMonth;
		this.reportYear = reportYear;
		this.type = type;
		this.balanceBF = balanceBF;
		this.received = received;
		this.balanceCF = balanceCF;
		this.onHand = onHand;
		this.totalDispensed = totalDispensed;
		this.losses = losses;
	}

	/*SafeMotherhoodRegisterReport() {
        reportMonth = null;
        reportYear = null;
        // patients = new ArrayList();
    }*/

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
    public ArrayList getPatients() {
        return patients;
    }

    /**
     * @param patient The patients to set.
     */
    public void addPatient(OIPatient patient) {
        if (patients == null) {
            patients = new ArrayList();
        }
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

	public void addPatientRecords(TreeMap<Date, OIPatient> patientRecords) {
        if (patients == null) {
            patients = new ArrayList<OIPatient>();
        }
        patients.addAll(patientRecords.values());
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public OIPatient getBalanceCF() {
		return balanceCF;
	}

	public void setBalanceCF(OIPatient balanceCF) {
		this.balanceCF = balanceCF;
	}

	public OIPatient getTotalDispensed() {
		return totalDispensed;
	}

	public void setTotalDispensed(OIPatient totalDispensed) {
		this.totalDispensed = totalDispensed;
	}

	public OIPatient getLosses() {
		return losses;
	}

	public void setLosses(OIPatient losses) {
		this.losses = losses;
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

            // Get the stock each patient used.
                    try {
                    	balanceBF = new OIPatient();
        				received = new OIPatient();
                        balanceCF = new OIPatient();
                        onHand = new OIPatient();
                        losses = new OIPatient();
                        Integer currentBalance = null;
            			//HashMap<Long, List<StockControl>> stockMap = InventoryDAO.getPatientStockMap(conn, siteId, beginDate, endDate);
            			HashMap<Long,StockReport> balanceMap = InventoryDAO.getBalanceMap(conn, siteId, null,endDate);
        				HashMap<Long,StockReport> balanceBFMap = InventoryDAO.getBalanceMap(conn, siteId, beginDate,endDate);
                        //EncounterData encounter = (EncounterData) PatientItemDAO.getEncounterRawValues(conn, encounterForm, "132", encounterId, clazz);
                    	List<DropdownItem> list = WidgetUtils.getList(conn, "item", "id", "WHERE (ITEM_GROUP_ID > 3 AND  ITEM_GROUP_ID < 9)", "ORDER BY id", DropdownItem.class, null);
                    	for (DropdownItem dropdownItem : list) {
							Long itemId = Long.valueOf(dropdownItem.getDropdownId());
							/*List<StockControl> stockChanges = (List<StockControl>) InventoryDAO.getStockChanges(conn, itemId, siteId, beginDate, endDate);
							List<StockControl> patientStockChanges = stockMap.get(itemId);
							if (patientStockChanges == null) {
								patientStockChanges = new ArrayList<StockControl>();
							}
							List<StockControl> stockEncounterChanges = InventoryDAO.getStockEncounterChanges(conn, itemId, siteId, beginDate, endDate, stockChanges, patientStockChanges);
					        StockReport stockReport = InventoryDAO.generateStockSummary(conn, itemId, beginDate, stockEncounterChanges, false);
					        currentBalance = stockReport.getOnHand();*/
							List<StockControl> stockChanges = (List<StockControl>) InventoryDAO.getStockChanges(conn, itemId, siteId, beginDate, endDate);
							StockReport stockReport = balanceMap.get(itemId);
					        if (stockReport == null) {
					        	currentBalance = 0;
					        } else {
					        	currentBalance = stockReport.getOnHand();
					        }
							Integer stockReceived = 0;
							Integer stockLoss = 0;
							int i =0;
							if (stockChanges.size() >0) {
								for (Iterator iterator = stockChanges.iterator(); iterator.hasNext();) {
									StockControl stock = (StockControl) iterator.next();
									i++;
									Integer changeType = stock.getType_of_change();
									Integer quantity = stock.getChange_value();
									//expiryValue = stock.getExpiry_date();
									/*Timestamp created = stock.getCreated();*/
									if (quantity != null) {
										/*if (expiryValue != null) {
											Boolean sixMonthsExpiry = DateUtils.checkExpiry(endDate, expiryValue);
											// TODO: need to make sure that previous stock is not exhausted
											// currently you may use the remaining field in the form to tweak the results.
											if (sixMonthsExpiry == true) {
												//stock6monthExpiry++;
												stock6monthExpiry = currentBalance;
												if (remaining != null) {
													stockRemaining = stockRemaining + remaining;
												}
												// do not display expiry unless stock6monthExpiry >0
												if (stock6monthExpiry >0) {
													if (isExpirySet == false) {
														expiry = expiryValue;
														isExpirySet = true;
													}
												}
											}
										}*/
										switch (changeType.intValue()) {
										case 3263:	// received
											stockReceived = stockReceived + quantity;
											break;
										case 3265:	// loss
											stockLoss = stockLoss + quantity;
											break;
										/*
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
											break;*/
										default:
											break;
										}
									}
								}
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
							Integer stockOnHand = beginningBalance + stockReceived;

							// keep the report easy-to-read - not a bunch of zeros.
							if (stockLoss == 0) {
								stockLoss = null;
							}
							if (stockReceived == 0) {
								stockReceived = null;
							}
							if (currentBalance == 0) {
								currentBalance = null;
							}
							if (beginningBalance == 0) {
								beginningBalance = null;
							}
							if (stockOnHand == 0) {
								stockOnHand = null;
							}

							switch (itemId.intValue()) {
							case 51:
								balanceBF.setAcyclovir200mg(beginningBalance);
								balanceCF.setAcyclovir200mg(currentBalance);
								received.setAcyclovir200mg(stockReceived);
								onHand.setAcyclovir200mg(stockOnHand);
								losses.setAcyclovir200mg(stockLoss);
								break;
							case 52:
								balanceBF.setAcyclovirIVInfusion(beginningBalance);
								balanceCF.setAcyclovirIVInfusion(currentBalance);
								received.setAcyclovirIVInfusion(stockReceived);
								onHand.setAcyclovirIVInfusion(stockOnHand);
								losses.setAcyclovirIVInfusion(stockLoss);
								break;
							case 50:
								balanceBF.setAminosidineSulphate(beginningBalance);
								balanceCF.setAminosidineSulphate(currentBalance);
								received.setAminosidineSulphate(stockReceived);
								onHand.setAminosidineSulphate(stockOnHand);
								losses.setAminosidineSulphate(stockLoss);
								break;
							case 49:
								balanceBF.setAminosidineSulphateliquid(beginningBalance);
								balanceCF.setAminosidineSulphateliquid(currentBalance);
								received.setAminosidineSulphateliquid(stockReceived);
								onHand.setAminosidineSulphateliquid(stockOnHand);
								losses.setAminosidineSulphateliquid(stockLoss);
								break;
							case 44:
								balanceBF.setAmphotericinBInjection(beginningBalance);
								balanceCF.setAmphotericinBInjection(currentBalance);
								received.setAmphotericinBInjection(stockReceived);
								onHand.setAmphotericinBInjection(stockOnHand);
								losses.setAmphotericinBInjection(stockLoss);
								break;
							case 48:
								balanceBF.setCeftriaxoneInj250mgIM(beginningBalance);
								balanceCF.setCeftriaxoneInj250mgIM(currentBalance);
								received.setCeftriaxoneInj250mgIM(stockReceived);
								onHand.setCeftriaxoneInj250mgIM(stockOnHand);
								losses.setCeftriaxoneInj250mgIM(stockLoss);
								break;
							case 47:
								balanceBF.setCiprofloxacinTabs500mg(beginningBalance);
								balanceCF.setCiprofloxacinTabs500mg(currentBalance);
								received.setCiprofloxacinTabs500mg(stockReceived);
								onHand.setCiprofloxacinTabs500mg(stockOnHand);
								losses.setCiprofloxacinTabs500mg(stockLoss);
								break;
							case 46:
								balanceBF.setCotrimoxazoleDS960mg(beginningBalance);
								balanceCF.setCotrimoxazoleDS960mg(currentBalance);
								received.setCotrimoxazoleDS960mg(stockReceived);
								onHand.setCotrimoxazoleDS960mg(stockOnHand);
								losses.setCotrimoxazoleDS960mg(stockLoss);
								break;
							case 174:
								balanceBF.setCotrimoxazoleTabs480mg(beginningBalance);
								balanceCF.setCotrimoxazoleTabs480mg(currentBalance);
								received.setCotrimoxazoleTabs480mg(stockReceived);
								onHand.setCotrimoxazoleTabs480mg(stockOnHand);
								losses.setCotrimoxazoleTabs480mg(stockLoss);
								break;
							case 45:
								balanceBF.setCotrimoxazolesusp240mg_5ml(beginningBalance);
								balanceCF.setCotrimoxazolesusp240mg_5ml(currentBalance);
								received.setCotrimoxazolesusp240mg_5ml(stockReceived);
								onHand.setCotrimoxazolesusp240mg_5ml(stockOnHand);
								losses.setCotrimoxazolesusp240mg_5ml(stockLoss);
								break;
							case 35:
								balanceBF.setDiflucan200mg(beginningBalance);
								balanceCF.setDiflucan200mg(currentBalance);
								received.setDiflucan200mg(stockReceived);
								onHand.setDiflucan200mg(stockOnHand);
								losses.setDiflucan200mg(stockLoss);
								break;
							case 37:
								balanceBF.setDiflucanInfusion(beginningBalance);
								balanceCF.setDiflucanInfusion(currentBalance);
								received.setDiflucanInfusion(stockReceived);
								onHand.setDiflucanInfusion(stockOnHand);
								losses.setDiflucanInfusion(stockLoss);
								break;
							case 36:
								balanceBF.setDiflucansuspension(beginningBalance);
								balanceCF.setDiflucansuspension(currentBalance);
								received.setDiflucansuspension(stockReceived);
								onHand.setDiflucansuspension(stockOnHand);
								losses.setDiflucansuspension(stockLoss);
								break;
							case 39:
								balanceBF.setFluconazole150mg(beginningBalance);
								balanceCF.setFluconazole150mg(currentBalance);
								received.setFluconazole150mg(stockReceived);
								onHand.setFluconazole150mg(stockOnHand);
								losses.setFluconazole150mg(stockLoss);
								break;
							case 38:
								balanceBF.setFluconazole200mg(beginningBalance);
								balanceCF.setFluconazole200mg(currentBalance);
								received.setFluconazole200mg(stockReceived);
								onHand.setFluconazole200mg(stockOnHand);
								losses.setFluconazole200mg(stockLoss);
								break;
							case 40:
								balanceBF.setFluconazole50mg(beginningBalance);
								balanceCF.setFluconazole50mg(currentBalance);
								received.setFluconazole50mg(stockReceived);
								onHand.setFluconazole50mg(stockOnHand);
								losses.setFluconazole50mg(stockLoss);
								break;
							case 41:
								balanceBF.setKetaconazole200mg(beginningBalance);
								balanceCF.setKetaconazole200mg(currentBalance);
								received.setKetaconazole200mg(stockReceived);
								onHand.setKetaconazole200mg(stockOnHand);
								losses.setKetaconazole200mg(stockLoss);
								break;
							case 42:
								balanceBF.setMiconazoleNitrate2OralGel(beginningBalance);
								balanceCF.setMiconazoleNitrate2OralGel(currentBalance);
								received.setMiconazoleNitrate2OralGel(stockReceived);
								onHand.setMiconazoleNitrate2OralGel(stockOnHand);
								losses.setMiconazoleNitrate2OralGel(stockLoss);
								break;
							case 43:
								balanceBF.setNystatinOralSuspension100000Units(beginningBalance);
								balanceCF.setNystatinOralSuspension100000Units(currentBalance);
								received.setNystatinOralSuspension100000Units(stockReceived);
								onHand.setNystatinOralSuspension100000Units(stockOnHand);
								losses.setNystatinOralSuspension100000Units(stockLoss);
								break;
							case 53:
								balanceBF.setPyridoxine25mg(beginningBalance);
								balanceCF.setPyridoxine25mg(currentBalance);
								received.setPyridoxine25mg(stockReceived);
								onHand.setPyridoxine25mg(stockOnHand);
								losses.setPyridoxine25mg(stockLoss);
								break;

							default:
								break;
							}
						}
                        /*if (patient != null) {
                            this.setOnHand(patient);
                        }*/
                    } catch (SQLException e) {
                        log.error(e);
                    }
                /*}
            } catch (SQLException e) {
                log.error(e);
            }*/

            // For each patient, load the report class and add this patient to the list
			// also increment the total dispensed values
			totalDispensed = new OIPatient();
            try {
                //rs = getOIEncounters(conn, siteId, beginDate, endDate);
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
                        int currentSiteId = rs.getInt("site_id");
						Integer ageCategory = rs.getInt("age_category");
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

                        EncounterData encounter = (EncounterData) PatientItemDAO.getEncounterRawValues(conn, encounterForm, "132", encounterId, clazz);
                        Map encMap = encounter.getEncounterMap();
                        Set encSet = encMap.entrySet();
						boolean isOiVisit = false;
                        for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
							Map.Entry entry = (Map.Entry) iterator.next();
							Long key = (Long) entry.getKey();
							Integer value = (Integer) entry.getValue();
							int n = 0;
							if (key != null) {
								switch (key.intValue()) {
								case 51:
									patient.setAcyclovir200mg(value);
									isOiVisit = true;
									if (totalDispensed.getAcyclovir200mg() != null) {
										n = totalDispensed.getAcyclovir200mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setAcyclovir200mg(n);
									break;
								case 52:
									patient.setAcyclovirIVInfusion(value);
									isOiVisit = true;
									if (totalDispensed.getAcyclovirIVInfusion() != null) {
										n = totalDispensed.getAcyclovirIVInfusion() + value;
									} else {
										n = value;
									}
									totalDispensed.setAcyclovirIVInfusion(n);
									break;
								case 50:
									patient.setAminosidineSulphate(value);
									isOiVisit = true;
									if (totalDispensed.getAminosidineSulphate() != null) {
										n = totalDispensed.getAminosidineSulphate() + value;
									} else {
										n = value;
									}
									totalDispensed.setAminosidineSulphate(n);
									break;
								case 49:
									patient.setAminosidineSulphateliquid(value);
									isOiVisit = true;
									if (totalDispensed.getAminosidineSulphateliquid() != null) {
										n = totalDispensed.getAminosidineSulphateliquid() + value;
									} else {
										n = value;
									}
									totalDispensed.setAminosidineSulphateliquid(n);
									break;
								case 44:
									patient.setAmphotericinBInjection(value);
									isOiVisit = true;
									if (totalDispensed.getAmphotericinBInjection() != null) {
										n = totalDispensed.getAmphotericinBInjection() + value;
									} else {
										n = value;
									}
									totalDispensed.setAmphotericinBInjection(n);
									break;
								case 48:
									patient.setCeftriaxoneInj250mgIM(value);
									isOiVisit = true;

									if (totalDispensed.getCeftriaxoneInj250mgIM() != null) {
										n = totalDispensed.getCeftriaxoneInj250mgIM() + value;
									} else {
										n = value;
									}
									totalDispensed.setCeftriaxoneInj250mgIM(n);
									break;
								case 47:
									patient.setCiprofloxacinTabs500mg(value);
									isOiVisit = true;
									if (totalDispensed.getCiprofloxacinTabs500mg() != null) {
										n = totalDispensed.getCiprofloxacinTabs500mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setCiprofloxacinTabs500mg(n);
									break;
								case 46:
									patient.setCotrimoxazoleDS960mg(value);
									isOiVisit = true;
									if (totalDispensed.getCotrimoxazoleDS960mg() != null) {
										n = totalDispensed.getCotrimoxazoleDS960mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setCotrimoxazoleDS960mg(n);
									break;
								case 174:
									patient.setCotrimoxazoleTabs480mg(value);
									isOiVisit = true;
									if (totalDispensed.getCotrimoxazoleTabs480mg() != null) {
										n = totalDispensed.getCotrimoxazoleTabs480mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setCotrimoxazoleTabs480mg(n);
									break;
								case 45:
									patient.setCotrimoxazolesusp240mg_5ml(value);
									isOiVisit = true;
									if (totalDispensed.getCotrimoxazolesusp240mg_5ml() != null) {
										n = totalDispensed.getCotrimoxazolesusp240mg_5ml() + value;
									} else {
										n = value;
									}
									totalDispensed.setCotrimoxazolesusp240mg_5ml(n);
									break;
								case 35:
									patient.setDiflucan200mg(value);
									isOiVisit = true;
									if (totalDispensed.getDiflucan200mg() != null) {
										n = totalDispensed.getDiflucan200mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setDiflucan200mg(n);
									break;
								case 37:
									patient.setDiflucanInfusion(value);
									isOiVisit = true;
									if (totalDispensed.getDiflucanInfusion() != null) {
										n = totalDispensed.getDiflucanInfusion() + value;
									} else {
										n = value;
									}
									totalDispensed.setDiflucanInfusion(n);
									break;
								case 36:
									patient.setDiflucansuspension(value);
									isOiVisit = true;
									if (totalDispensed.getDiflucansuspension() != null) {
										n = totalDispensed.getDiflucansuspension() + value;
									} else {
										n = value;
									}
									totalDispensed.setDiflucansuspension(n);
									break;
								case 39:
									patient.setFluconazole150mg(value);
									isOiVisit = true;
									if (totalDispensed.getFluconazole150mg() != null) {
										n = totalDispensed.getFluconazole150mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setFluconazole150mg(n);
									break;
								case 38:
									patient.setFluconazole200mg(value);
									isOiVisit = true;
									if (totalDispensed.getFluconazole200mg() != null) {
										n = totalDispensed.getFluconazole200mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setFluconazole200mg(n);
									break;
								case 40:
									patient.setFluconazole50mg(value);
									isOiVisit = true;
									if (totalDispensed.getFluconazole50mg() != null) {
										n = totalDispensed.getFluconazole50mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setFluconazole50mg(n);
									break;
								case 41:
									patient.setKetaconazole200mg(value);
									isOiVisit = true;
									if (totalDispensed.getKetaconazole200mg() != null) {
										n = totalDispensed.getKetaconazole200mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setKetaconazole200mg(n);
									break;
								case 42:
									patient.setMiconazoleNitrate2OralGel(value);
									isOiVisit = true;
									if (totalDispensed.getMiconazoleNitrate2OralGel() != null) {
										n = totalDispensed.getMiconazoleNitrate2OralGel() + value;
									} else {
										n = value;
									}
									totalDispensed.setMiconazoleNitrate2OralGel(n);
									break;
								case 43:
									patient.setNystatinOralSuspension100000Units(value);
									isOiVisit = true;
									if (totalDispensed.getNystatinOralSuspension100000Units() != null) {
										n = totalDispensed.getNystatinOralSuspension100000Units() + value;
									} else {
										n = value;
									}
									totalDispensed.setNystatinOralSuspension100000Units(n);
									break;
								case 53:
									patient.setPyridoxine25mg(value);
									isOiVisit = true;
									if (totalDispensed.getPyridoxine25mg() != null) {
										n = totalDispensed.getPyridoxine25mg() + value;
									} else {
										n = value;
									}
									totalDispensed.setPyridoxine25mg(n);
									break;
								default:
									break;
								}
							}
						}
                     // don't add this patient if it's not an OI visit
						if (isOiVisit == true) {
							// check if this is the first visit - there might be multiples ones for this encounter
							Date firstVisit = EncountersDAO.getFirstVisit(conn, patientId);
							if (firstVisit.getTime() == dateVisit.getTime()) {
								patient.setRevisit(false);
							} else {
								patient.setRevisit(true);
							}
						}
							/*if (patient.getChildOrAdult().equals("A")) {
								this.addPatient(patient);
							}*/
						if (isOiVisit == true) {
							patient.setEncounter(encounter);
	                        this.addPatient(patient);
						}

                    } catch (SQLException e) {
                        log.error(e);
                    }
                }
            } catch (SQLException e) {
                log.error(e);
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
     * Retrieve all Encounter records for this form 132
     * @param conn
     * @param siteID
     * @param beginDate
     * @param endDate
     * @return
     * @throws ServletException
     */
    protected static ResultSet getOIEncounters(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {

        ResultSet rs = null;

        String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
        if (endDate == null) {
        	dateRange = "AND date_visit = ?";
        }

        try {
            if (siteID == 0) {
                String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
                		"first_name, surname, encounter.site_id, encounter.created_by AS created_by, " +
        				"age_at_first_visit AS age, age_category, encounter.created " +
                		"FROM encounter, patient, patient_item " +
                        "WHERE encounter.patient_id = patient.id " +
                        "AND encounter.id = patient_item.encounter_id " +
                        "AND (patient_item.item_id = 51 OR " +
                        "patient_item.item_id = 52 OR " +
                        "patient_item.item_id = 50 OR " +
                        "patient_item.item_id = 49 OR " +
                        "patient_item.item_id = 44 OR " +
                        "patient_item.item_id = 48 OR " +
                        "patient_item.item_id = 47 OR " +
                        "patient_item.item_id = 46 OR " +
                        "patient_item.item_id = 174 OR " +
                        "patient_item.item_id = 45 OR " +
                        "patient_item.item_id = 35 OR " +
                        "patient_item.item_id = 37 OR " +
                        "patient_item.item_id = 36 OR " +
                        "patient_item.item_id = 39 OR " +
                        "patient_item.item_id = 38 OR " +
                        "patient_item.item_id = 40 OR " +
                        "patient_item.item_id = 41 OR " +
                        "patient_item.item_id = 42 OR " +
                        "patient_item.item_id = 43 OR " +
                        "patient_item.item_id = 53) " +
                        "AND form_id = 132\n" +
                        dateRange +
                        "ORDER BY patient_id DESC, date_visit DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setDate(1, beginDate);
                if (endDate != null) {
                	ps.setDate(2, endDate);
                }
                rs = ps.executeQuery();
            } else {
                String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
                 "first_name, surname, encounter.site_id, encounter.created_by AS created_by, " +
 				 "age_at_first_visit AS age, age_category, encounter.created " +
         		 "FROM encounter, patient, patient_item " +
                 "WHERE encounter.patient_id = patient.id " +
                 "AND encounter.id = patient_item.encounter_id " +
                 "AND (patient_item.item_id = 51 OR " +
                 "patient_item.item_id = 52 OR " +
                 "patient_item.item_id = 50 OR " +
                 "patient_item.item_id = 49 OR " +
                 "patient_item.item_id = 44 OR " +
                 "patient_item.item_id = 48 OR " +
                 "patient_item.item_id = 47 OR " +
                 "patient_item.item_id = 46 OR " +
                 "patient_item.item_id = 174 OR " +
                 "patient_item.item_id = 45 OR " +
                 "patient_item.item_id = 35 OR " +
                 "patient_item.item_id = 37 OR " +
                 "patient_item.item_id = 36 OR " +
                 "patient_item.item_id = 39 OR " +
                 "patient_item.item_id = 38 OR " +
                 "patient_item.item_id = 40 OR " +
                 "patient_item.item_id = 41 OR " +
                 "patient_item.item_id = 42 OR " +
                 "patient_item.item_id = 43 OR " +
                 "patient_item.item_id = 53) " +
                 "AND form_id = 132\n" +
                 dateRange +
                 "AND encounter.site_id = ? " +
                  "ORDER BY patient_id DESC, date_visit DESC";
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

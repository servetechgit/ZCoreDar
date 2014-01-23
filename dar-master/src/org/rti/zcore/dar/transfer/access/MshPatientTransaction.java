/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.transfer.access;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Constants;
import org.rti.zcore.Event;
import org.rti.zcore.dar.utils.DateOfVisitOrderable;
import org.rti.zcore.impl.SessionSubject;

public class MshPatientTransaction implements DateOfVisitOrderable {

	private static Log log = LogFactory.getFactory().getInstance(MshPatientTransaction.class);
	private static final SimpleDateFormat dateformatter = new SimpleDateFormat(Constants.DATE_FORMAT_SHORT);

	private String ARTID;
	private Timestamp DateofVisit;
	private String Drugname;
	private String BrandName;
	private Integer TransactionCode;
	private String unit;
	private Integer ARVQty;
	private String Dose;
	private Integer duration;
	private String Regimen;
	private String LastRegimen;
	private String Comment;
	private String Operator;
	private String Indication;
	private Float Weight;
	private Integer pillCount;
	private Integer Adherence;

	// Zcore-related fields used for persisting encounters other than PatientRegistration.
	private Long patientId;
	private Long eventId;
	private String patientUuid;
	private String eventUuid;
	private SessionSubject sessionPatient;
	private Event event;

	public String getARTID() {
		return ARTID;
	}
	public void setARTID(String aRTID) {
		ARTID = aRTID;
	}
	public Timestamp getDateofVisit() {
		return DateofVisit;
	}
	public void setDateofVisit(Timestamp dateofVisit) {
		DateofVisit = dateofVisit;
	}
	public String getDrugname() {
		return Drugname;
	}
	public void setDrugname(String drugname) {
		Drugname = drugname;
	}
	public String getBrandName() {
		return BrandName;
	}
	public void setBrandName(String brandName) {
		BrandName = brandName;
	}
	public Integer getTransactionCode() {
		return TransactionCode;
	}
	public void setTransactionCode(Integer transactionCode) {
		TransactionCode = transactionCode;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public Integer getARVQty() {
		return ARVQty;
	}
	public void setARVQty(Integer aRVQty) {
		ARVQty = aRVQty;
	}
	public String getDose() {
		return Dose;
	}
	public void setDose(String dose) {
		Dose = dose;
	}
	public Integer getDuration() {
		return duration;
	}
	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	public String getRegimen() {
		return Regimen;
	}
	public void setRegimen(String regimen) {
		Regimen = regimen;
	}
	public String getLastRegimen() {
		return LastRegimen;
	}
	public void setLastRegimen(String lastRegimen) {
		LastRegimen = lastRegimen;
	}
	public String getComment() {
		return Comment;
	}
	public void setComment(String comment) {
		Comment = comment;
	}
	public String getOperator() {
		return Operator;
	}
	public void setOperator(String operator) {
		Operator = operator;
	}
	public String getIndication() {
		return Indication;
	}
	public void setIndication(String indication) {
		Indication = indication;
	}
	public Float getWeight() {
		return Weight;
	}
	public void setWeight(Float weight) {
		Weight = weight;
	}
	public Integer getPillCount() {
		return pillCount;
	}
	public void setPillCount(Integer pillCount) {
		this.pillCount = pillCount;
	}
	public Integer getAdherence() {
		return Adherence;
	}
	public void setAdherence(Integer adherence) {
		Adherence = adherence;
	}

	public Long getPatientId() {
		return patientId;
	}
	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}
	public Long getEventId() {
		return eventId;
	}
	public void setEventId(Long eventId) {
		this.eventId = eventId;
	}
	public String getPatientUuid() {
		return patientUuid;
	}
	public void setPatientUuid(String patientUuid) {
		this.patientUuid = patientUuid;
	}
	public String getEventUuid() {
		return eventUuid;
	}
	public void setEventUuid(String eventUuid) {
		this.eventUuid = eventUuid;
	}
	public SessionSubject getSessionPatient() {
		return sessionPatient;
	}
	public void setSessionPatient(SessionSubject sessionPatient) {
		this.sessionPatient = sessionPatient;
	}
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}
	@Override
	public String toString() {
		String tc = null;
		switch (TransactionCode) {
		case 1:
			tc = "Start";
			break;
		case 2:
			tc = "Routine Refill";
			break;
		case 3:
			tc = "Switch Regimen";
			break;
		case 4:
			tc = "Treatment";
			break;
		default:
			break;
		}

		String reg = getRegimenName(Regimen);
		String lastReg = getRegimenName(LastRegimen);
		String dateVisit = null;
		if (DateofVisit != null) {
			dateVisit = dateformatter.format((java.util.Date) DateofVisit);
		}

		return ""
		//+ (ARTID != null ? "ARTID=" + ARTID + ", " : "")
		+ (DateofVisit != null ? "" + dateVisit + " ": "")
		+ (tc != null ? "" + tc + " " : "")
		+ (Drugname != null ? "" + Drugname + " " : "")
		//+ (BrandName != null ? "BrandName=" + BrandName + ", " : "")
		+ (ARVQty != null ? "" + ARVQty + " " : "")
		+ (unit != null ? "" + unit + "; " : "")
		+ (Dose != null ? "Dose: " + Dose + "; " : "")
		//+ (pillCount != null ? "pillCount=" + pillCount + ", " : "")
		+ (duration != null ? "Duration: " + duration + "; " : "")
		+ (Regimen != null ? "Regimen: " + reg + "; " : "")
		+ (LastRegimen != null ? "Last Regimen=" + lastReg + "; ": "")
		//+ (Operator != null ? "Operator=" + Operator + ", " : "")
		+ (Indication != null ? "Indication: " + Indication + "; " : "")
		+ (Weight != null ? "Weight: " + Weight + "; " : "")
		//+ (Adherence != null ? "Adherence: " + Adherence + "; " : "")
		+ (Comment != null ? "Comment: " + Comment + "; " : "");
	}

	public String getRegimenName(String regimenCode) {
		String reg = null;
		if (regimenCode != null) {
			if (regimenCode.equals("R01")) {
				reg = "OI only";
			} else if (regimenCode.equals("R02")) {	//1A
				reg = "1A";
			} else if (regimenCode.equals("R03")) {	//R03	2A	3
				reg = "2A";
			} else if (regimenCode.equals("R04")) {	//R04	3A	5
				reg = "3A";
			} else if (regimenCode.equals("R05")) {	//R05	3B	6
				reg = "3B";
			} else if (regimenCode.equals("R06")) {	//R06	4A	7
				reg = "4A";
			} else if (regimenCode.equals("R07")) {	//R07	5A	9
				reg = "5A";
			} else if (regimenCode.equals("R08")) {	//R08	5B	10
				reg = "5B";
			} else if (regimenCode.equals("R09")) {	//R09	6A	11
				reg = "6A";
			} else if (regimenCode.equals("R10")) {	//R10	6B	12
				reg = "6B";
			} else if (regimenCode.equals("R11")) {	//R10	6B	12
				reg = "6C";
			} else if (regimenCode.equals("R12")) {	//R12	7A	13
				reg = "7A";
			} else if (regimenCode.equals("R14")) {	// not in system
				reg = "7C (TDF/3TC/LPVR)";
			} else if (regimenCode.equals("R17")) {	// not in system
				reg = "6E (ABC/3TC/NVP)";
			} else if (regimenCode.equals("R18")) {	// not in system
				reg = "8B(AZT/3TC/LPVR)";
			} else if (regimenCode.equals("R21")) {	//R21	PEP 1	21	PEP 1 (AZT/3TC)
				reg = "PEP 1";
			} else if (regimenCode.equals("R23")) {	//R23	PEP 3	24
				reg = "PEP 3";
			} else if (regimenCode.equals("R26")) {	//R26	C1A	36
				reg = "C1A";
			} else if (regimenCode.equals("R27")) {	//R27	C2A	40
				reg = "C2A";
			} else if (regimenCode.equals("R28")) {	//R28	C3A	44
				reg = "C3A";
			} else if (regimenCode.equals("R29")) {	//R29	C3B	45
				reg = "C3B";
			} else if (regimenCode.equals("R30")) {	//R30	C4A	48
				reg = "C4A";
			} else if (regimenCode.equals("R31")) {	//R31	C4B	49
				reg = "C4B";
			} else if (regimenCode.equals("R32")) {	//R32	C4C	50
				reg = "C4C";
			} else {
				reg = regimenCode;
				log.debug("Unable to import regimen for patient id: " + ARTID + " regimenCode: " + regimenCode);
			}
		}
		return reg;
	}

}

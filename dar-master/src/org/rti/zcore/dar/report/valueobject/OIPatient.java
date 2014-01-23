/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report.valueobject;

import java.sql.Date;
import java.sql.Timestamp;

import org.rti.zcore.EncounterData;

public class OIPatient {


	private Long patientId;
	private Long encounterId;
    private String clientId;
    private String surname;
    private String firstName;
    private Integer siteId;
    private Date dateVisit;
    private EncounterData encounter;
    private Integer acyclovir200mg;
    private Integer acyclovirIVInfusion;
    private Integer aminosidineSulphate;
    private Integer aminosidineSulphateliquid;
    private Integer amphotericinBInjection;
    private Integer ceftriaxoneInj250mgIM;
    private Integer ciprofloxacinTabs500mg;
    private Integer cotrimoxazoleDS960mg;
    private Integer cotrimoxazoleTabs480mg;
    private Integer cotrimoxazolesusp240mg_5ml;
    private Integer diflucan200mg;
    private Integer diflucanInfusion;
    private Integer diflucansuspension;
    private Integer fluconazole150mg;
    private Integer fluconazole200mg;
    private Integer fluconazole50mg;
    private Integer ketaconazole200mg;
    private Integer miconazoleNitrate2OralGel;
    private Integer nystatinOralSuspension100000Units;
    private Integer pyridoxine25mg;
    private Integer age;
    private Boolean revisit;
    private String diagnosis;
    private String pharmacist;
    private String childOrAdult;
	private Timestamp created;

	/**
	 * @return the patientId
	 */
	public Long getPatientId() {
		return patientId;
	}
	/**
	 * @param patientId the patientId to set
	 */
	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}
	/**
	 * @return the encounterId
	 */
	public Long getEncounterId() {
		return encounterId;
	}
	/**
	 * @param encounterId the encounterId to set
	 */
	public void setEncounterId(Long encounterId) {
		this.encounterId = encounterId;
	}
	/**
	 * @return the clientId
	 */
	public String getClientId() {
		return clientId;
	}
	/**
	 * @param clientId the clientId to set
	 */
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	/**
	 * @return the surname
	 */
	public String getSurname() {
		return surname;
	}
	/**
	 * @param surname the surname to set
	 */
	public void setSurname(String surname) {
		this.surname = surname;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the siteId
	 */
	public Integer getSiteId() {
		return siteId;
	}
	/**
	 * @param siteId the siteId to set
	 */
	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}
	/**
	 * @return the dateVisit
	 */
	public Date getDateVisit() {
		return dateVisit;
	}
	/**
	 * @param dateVisit the dateVisit to set
	 */
	public void setDateVisit(Date dateVisit) {
		this.dateVisit = dateVisit;
	}
	/**
	 * @return the encounter
	 */
	public EncounterData getEncounter() {
		return encounter;
	}
	/**
	 * @param encounter the encounter to set
	 */
	public void setEncounter(EncounterData encounter) {
		this.encounter = encounter;
	}
	/**
	 * @return the acyclovir200mg
	 */
	public Integer getAcyclovir200mg() {
		return acyclovir200mg;
	}
	/**
	 * @param acyclovir200mg the acyclovir200mg to set
	 */
	public void setAcyclovir200mg(Integer acyclovir200mg) {
		this.acyclovir200mg = acyclovir200mg;
	}
	/**
	 * @return the acyclovirIVInfusion
	 */
	public Integer getAcyclovirIVInfusion() {
		return acyclovirIVInfusion;
	}
	/**
	 * @param acyclovirIVInfusion the acyclovirIVInfusion to set
	 */
	public void setAcyclovirIVInfusion(Integer acyclovirIVInfusion) {
		this.acyclovirIVInfusion = acyclovirIVInfusion;
	}
	/**
	 * @return the aminosidineSulphate
	 */
	public Integer getAminosidineSulphate() {
		return aminosidineSulphate;
	}
	/**
	 * @param aminosidineSulphate the aminosidineSulphate to set
	 */
	public void setAminosidineSulphate(Integer aminosidineSulphate) {
		this.aminosidineSulphate = aminosidineSulphate;
	}
	/**
	 * @return the aminosidineSulphateliquid
	 */
	public Integer getAminosidineSulphateliquid() {
		return aminosidineSulphateliquid;
	}
	/**
	 * @param aminosidineSulphateliquid the aminosidineSulphateliquid to set
	 */
	public void setAminosidineSulphateliquid(Integer aminosidineSulphateliquid) {
		this.aminosidineSulphateliquid = aminosidineSulphateliquid;
	}
	/**
	 * @return the amphotericinBInjection
	 */
	public Integer getAmphotericinBInjection() {
		return amphotericinBInjection;
	}
	/**
	 * @param amphotericinBInjection the amphotericinBInjection to set
	 */
	public void setAmphotericinBInjection(Integer amphotericinBInjection) {
		this.amphotericinBInjection = amphotericinBInjection;
	}
	/**
	 * @return the ceftriaxoneInj250mgIM
	 */
	public Integer getCeftriaxoneInj250mgIM() {
		return ceftriaxoneInj250mgIM;
	}
	/**
	 * @param ceftriaxoneInj250mgIM the ceftriaxoneInj250mgIM to set
	 */
	public void setCeftriaxoneInj250mgIM(Integer ceftriaxoneInj250mgIM) {
		this.ceftriaxoneInj250mgIM = ceftriaxoneInj250mgIM;
	}
	/**
	 * @return the ciprofloxacinTabs500mg
	 */
	public Integer getCiprofloxacinTabs500mg() {
		return ciprofloxacinTabs500mg;
	}
	/**
	 * @param ciprofloxacinTabs500mg the ciprofloxacinTabs500mg to set
	 */
	public void setCiprofloxacinTabs500mg(Integer ciprofloxacinTabs500mg) {
		this.ciprofloxacinTabs500mg = ciprofloxacinTabs500mg;
	}
	/**
	 * @return the cotrimoxazoleDS960mg
	 */
	public Integer getCotrimoxazoleDS960mg() {
		return cotrimoxazoleDS960mg;
	}
	/**
	 * @param cotrimoxazoleDS960mg the cotrimoxazoleDS960mg to set
	 */
	public void setCotrimoxazoleDS960mg(Integer cotrimoxazoleDS960mg) {
		this.cotrimoxazoleDS960mg = cotrimoxazoleDS960mg;
	}
	/**
	 * @return the cotrimoxazoleTabs480mg
	 */
	public Integer getCotrimoxazoleTabs480mg() {
		return cotrimoxazoleTabs480mg;
	}
	/**
	 * @param cotrimoxazoleTabs480mg the cotrimoxazoleTabs480mg to set
	 */
	public void setCotrimoxazoleTabs480mg(Integer cotrimoxazoleTabs480mg) {
		this.cotrimoxazoleTabs480mg = cotrimoxazoleTabs480mg;
	}
	/**
	 * @return the cotrimoxazolesusp240mg_5ml
	 */
	public Integer getCotrimoxazolesusp240mg_5ml() {
		return cotrimoxazolesusp240mg_5ml;
	}
	/**
	 * @param cotrimoxazolesusp240mg_5ml the cotrimoxazolesusp240mg_5ml to set
	 */
	public void setCotrimoxazolesusp240mg_5ml(Integer cotrimoxazolesusp240mg_5ml) {
		this.cotrimoxazolesusp240mg_5ml = cotrimoxazolesusp240mg_5ml;
	}
	/**
	 * @return the diflucan200mg
	 */
	public Integer getDiflucan200mg() {
		return diflucan200mg;
	}
	/**
	 * @param diflucan200mg the diflucan200mg to set
	 */
	public void setDiflucan200mg(Integer diflucan200mg) {
		this.diflucan200mg = diflucan200mg;
	}
	/**
	 * @return the diflucanInfusion
	 */
	public Integer getDiflucanInfusion() {
		return diflucanInfusion;
	}
	/**
	 * @param diflucanInfusion the diflucanInfusion to set
	 */
	public void setDiflucanInfusion(Integer diflucanInfusion) {
		this.diflucanInfusion = diflucanInfusion;
	}
	/**
	 * @return the diflucansuspension
	 */
	public Integer getDiflucansuspension() {
		return diflucansuspension;
	}
	/**
	 * @param diflucansuspension the diflucansuspension to set
	 */
	public void setDiflucansuspension(Integer diflucansuspension) {
		this.diflucansuspension = diflucansuspension;
	}
	/**
	 * @return the fluconazole150mg
	 */
	public Integer getFluconazole150mg() {
		return fluconazole150mg;
	}
	/**
	 * @param fluconazole150mg the fluconazole150mg to set
	 */
	public void setFluconazole150mg(Integer fluconazole150mg) {
		this.fluconazole150mg = fluconazole150mg;
	}
	/**
	 * @return the fluconazole200mg
	 */
	public Integer getFluconazole200mg() {
		return fluconazole200mg;
	}
	/**
	 * @param fluconazole200mg the fluconazole200mg to set
	 */
	public void setFluconazole200mg(Integer fluconazole200mg) {
		this.fluconazole200mg = fluconazole200mg;
	}
	/**
	 * @return the fluconazole50mg
	 */
	public Integer getFluconazole50mg() {
		return fluconazole50mg;
	}
	/**
	 * @param fluconazole50mg the fluconazole50mg to set
	 */
	public void setFluconazole50mg(Integer fluconazole50mg) {
		this.fluconazole50mg = fluconazole50mg;
	}
	/**
	 * @return the ketaconazole200mg
	 */
	public Integer getKetaconazole200mg() {
		return ketaconazole200mg;
	}
	/**
	 * @param ketaconazole200mg the ketaconazole200mg to set
	 */
	public void setKetaconazole200mg(Integer ketaconazole200mg) {
		this.ketaconazole200mg = ketaconazole200mg;
	}
	/**
	 * @return the miconazoleNitrate2OralGel
	 */
	public Integer getMiconazoleNitrate2OralGel() {
		return miconazoleNitrate2OralGel;
	}
	/**
	 * @param miconazoleNitrate2OralGel the miconazoleNitrate2OralGel to set
	 */
	public void setMiconazoleNitrate2OralGel(Integer miconazoleNitrate2OralGel) {
		this.miconazoleNitrate2OralGel = miconazoleNitrate2OralGel;
	}
	/**
	 * @return the nystatinOralSuspension100000Units
	 */
	public Integer getNystatinOralSuspension100000Units() {
		return nystatinOralSuspension100000Units;
	}
	/**
	 * @param nystatinOralSuspension100000Units the nystatinOralSuspension100000Units to set
	 */
	public void setNystatinOralSuspension100000Units(
			Integer nystatinOralSuspension100000Units) {
		this.nystatinOralSuspension100000Units = nystatinOralSuspension100000Units;
	}
	/**
	 * @return the pyridoxine25mg
	 */
	public Integer getPyridoxine25mg() {
		return pyridoxine25mg;
	}
	/**
	 * @param pyridoxine25mg the pyridoxine25mg to set
	 */
	public void setPyridoxine25mg(Integer pyridoxine25mg) {
		this.pyridoxine25mg = pyridoxine25mg;
	}
	/**
	 * @return the age
	 */
	public Integer getAge() {
		return age;
	}
	/**
	 * @param age the age to set
	 */
	public void setAge(Integer age) {
		this.age = age;
	}
	/**
	 * @return the revisit
	 */
	public Boolean getRevisit() {
		return revisit;
	}
	/**
	 * @param revisit the revisit to set
	 */
	public void setRevisit(Boolean revisit) {
		this.revisit = revisit;
	}
	/**
	 * @return the diagnosis
	 */
	public String getDiagnosis() {
		return diagnosis;
	}
	/**
	 * @param diagnosis the diagnosis to set
	 */
	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}
	/**
	 * @return the pharmacist
	 */
	public String getPharmacist() {
		return pharmacist;
	}
	/**
	 * @param pharmacist the pharmacist to set
	 */
	public void setPharmacist(String pharmacist) {
		this.pharmacist = pharmacist;
	}
	public String getChildOrAdult() {
		return childOrAdult;
	}
	public void setChildOrAdult(String childOrAdult) {
		this.childOrAdult = childOrAdult;
	}
	public Timestamp getCreated() {
		return created;
	}
	public void setCreated(Timestamp created) {
		this.created = created;
	}

}

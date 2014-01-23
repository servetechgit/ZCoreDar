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
import java.util.HashMap;

import org.rti.zcore.Creatable;
import org.rti.zcore.EncounterData;

public class ARTPatient implements Creatable {

	private Long id;
	private Long patientId;
	private Long encounterId;
    private String clientId;
    private String surname;
    private String firstName;
    private Integer siteId;
    private Date dateVisit;
    private EncounterData encounter;
    private HashMap<String, Integer> totalStockDispensed;
    private Integer sex;
    
    // Tip: Instead of removing unused drugs from this list of fields, mark it with an "unused" comment. 
    // If you remove a bunch of unused drug fields, alot of code will break in ARTAdultDailyActivityReport
    /*private Integer stavudine_LamivudineFDCTabs_30_150mg;
    private Integer stavudine_LamivudineFDCTabs_40_150mg;	// unused
    private Integer stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
    private Integer stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;	//unused
    private Integer zidovudine_LamivudineTabs_capsFDC_300_150mg;
    private Integer zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
    private Integer abacavirTabs300mg;
    private Integer didanosineTabs200mg;	//unused
    
    private Integer didanosineTabs100mg;	//unused
    
    private Integer didanosineTabs50mg;	//unused
    private Integer efavirenzTabs600mg;
    private Integer efavirenzTabs_caps200mg;	//unused
    private Integer lamivudineTabs150mg;
    private Integer lopinavir_ritonavirTabs_caps133;	//unused
    
    private Integer nelfinavirTabs250mg;	//unused
    private Integer nevirapineTabs200mg;
    private Integer stavudineTabs_Caps30mg;	//unused
    private Integer stavudineTabs_Caps40mg;	//unused
    private Integer tenofovirTabs_caps300mg;
    private Integer zidovudineTabs300mg;
    private Integer tenofovir_Lamivudine_Efavirenz_TDF_3TC_EFV_FDC_300_300_600mg_FDC_Tabs;
    private Integer tenofovir_Lamivudine_TDF_3TC_FDC_300_300mgTabs;
    private Integer didanosineTabs400mg;
    private Integer didanosineTabs250mg;
    private Integer lopinavir_ritonavirTabs_caps200_50mg;*/
    private String childOrAdult;
    private Integer age;
    private Boolean revisit;
    private String diagnosis;
    private String pharmacist;
    private String arvRegimenCode;
	private Long arvRegimenId;
	private Timestamp created;



	/**
	 * @return the created
	 */
	public Timestamp getCreated() {
		return created;
	}
	/**
	 * @param created the created to set
	 */
	public void setCreated(Timestamp created) {
		this.created = created;
	}
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
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
	/**
	 * @return the childOrAdult
	 */
	public String getChildOrAdult() {
		return childOrAdult;
	}
	/**
	 * @param childOrAdult the childOrAdult to set
	 */
	public void setChildOrAdult(String childOrAdult) {
		this.childOrAdult = childOrAdult;
	}
	/**
	 * @return the arvRegimenCode
	 */
	public String getArvRegimenCode() {
		return arvRegimenCode;
	}
	/**
	 * @param arvRegimenCode the arvRegimenCode to set
	 */
	public void setArvRegimenCode(String arvRegimenCode) {
		this.arvRegimenCode = arvRegimenCode;
	}
	/**
	 * @return the arvRegimenId
	 */
	public Long getArvRegimenId() {
		return arvRegimenId;
	}
	/**
	 * @param arvRegimenId the arvRegimenId to set
	 */
	public void setArvRegimenId(Long arvRegimenId) {
		this.arvRegimenId = arvRegimenId;
	}
	/**
	 * @return the sex
	 */
	public Integer getSex() {
		return sex;
	}
	/**
	 * @param sex the sex to set
	 */
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	/**
	 * @return the totalStockDispensed
	 */
	public HashMap<String, Integer> getTotalStockDispensed() {
		return totalStockDispensed;
	}
	/**
	 * @param totalStockDispensed the totalStockDispensed to set
	 */
	public void setTotalStockDispensed(HashMap<String, Integer> totalStockDispensed) {
		this.totalStockDispensed = totalStockDispensed;
	}

}


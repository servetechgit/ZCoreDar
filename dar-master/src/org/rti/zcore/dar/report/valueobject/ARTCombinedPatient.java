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

import org.rti.zcore.Creatable;
import org.rti.zcore.EncounterData;

/**
 * Combines ARTAdultPatient and ARTChildPatient for CDRR-ART report.
 * @author ckelley
 *
 */
public class ARTCombinedPatient implements Creatable {

	private Long id;
	private Long patientId;
	private Long encounterId;
    private String clientId;
    private String surname;
    private String firstName;
    private Integer siteId;
    private Date dateVisit;
    private EncounterData encounter;
    private Integer stavudine_LamivudineFDCTabs_30_150mg;
    private Integer stavudine_LamivudineFDCTabs_40_150mg;
    private Integer stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
    private Integer stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
    private Integer zidovudine_LamivudineTabs_capsFDC_300_150mg;
    private Integer zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
    private Integer abacavirTabs300mg;
    private Integer didanosineTabs200mg;
    private Integer didanosineTabs100mg;
    private Integer didanosineTabs50mg;
    private Integer efavirenzTabs600mg;
    private Integer efavirenzTabs_caps200mg;
    private Integer lamivudineTabs150mg;
    private Integer lopinavir_ritonavirTabs_caps133;
    private Integer nelfinavirTabs250mg;
    private Integer nevirapineTabs200mg;
    private Integer stavudineTabs_Caps30mg;
    private Integer stavudineTabs_Caps40mg;
    private Integer tenofovirTabs_caps300mg;
    private Integer zidovudineTabs300mg;
    private Integer abacavir_liquid_20mg_ml;
    private Integer didanosine_Tabs_caps_25mg;
    private Integer didanosine_liquid_10mg_ml;
    private Integer efavirenz_Tabs_50mg;
    private Integer efavirenz_liquid_30mg_ml;
    private Integer lamivudine_liquid_10mg_ml;
    private Integer lopinavir_ritonavir_liquid_80;
    private Integer nelfinavir_powder_50mg_125ml;
    private Integer nevirapine_susp_10mg_ml;
    private Integer stavudine_Tabs_caps_15mg;
    private Integer stavudine_Tabs_caps_20mg;
    private Integer stavudine_liquid_1mg_ml;
    private Integer zidovudine_Tabs_caps_100mg;
    private Integer zidovudine_liquid_10mg_ml;
    private String childOrAdult;
    private Integer age;
    private Boolean revisit;
    private String diagnosis;
    private String pharmacist;
    private String arvRegimenCode;
	private Long arvRegimenId;
	private Timestamp created;
	// new drugs 01102010
	private Integer didanosine400mg;
	private Integer didanosine250mg;
	private Integer didanosine50mg;
	private Integer lopinavir_ritonavir200_50mg;
	// stores itemId values for new drugs.
	private Long didanosine400mgItemId;
	private Long didanosine250mgItemId;
	private Long didanosine50mgItemId;
	private Long lopinavir_ritonavir200_50mgItemId;
	// Lopinavir/ritonavir (LPV/r) 200/50mg



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
	 * @return the stavudine_LamivudineFDCTabs_30_150mg
	 */
	public Integer getStavudine_LamivudineFDCTabs_30_150mg() {
		return stavudine_LamivudineFDCTabs_30_150mg;
	}
	/**
	 * @param stavudine_LamivudineFDCTabs_30_150mg the stavudine_LamivudineFDCTabs_30_150mg to set
	 */
	public void setStavudine_LamivudineFDCTabs_30_150mg(
			Integer stavudine_LamivudineFDCTabs_30_150mg) {
		this.stavudine_LamivudineFDCTabs_30_150mg = stavudine_LamivudineFDCTabs_30_150mg;
	}
	/**
	 * @return the stavudine_LamivudineFDCTabs_40_150mg
	 */
	public Integer getStavudine_LamivudineFDCTabs_40_150mg() {
		return stavudine_LamivudineFDCTabs_40_150mg;
	}
	/**
	 * @param stavudine_LamivudineFDCTabs_40_150mg the stavudine_LamivudineFDCTabs_40_150mg to set
	 */
	public void setStavudine_LamivudineFDCTabs_40_150mg(
			Integer stavudine_LamivudineFDCTabs_40_150mg) {
		this.stavudine_LamivudineFDCTabs_40_150mg = stavudine_LamivudineFDCTabs_40_150mg;
	}
	/**
	 * @return the stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg
	 */
	public Integer getStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg() {
		return stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	}
	/**
	 * @param stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg the stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg to set
	 */
	public void setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(
			Integer stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg) {
		this.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg = stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	}
	/**
	 * @return the stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg
	 */
	public Integer getStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg() {
		return stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	}
	/**
	 * @param stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg the stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg to set
	 */
	public void setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(
			Integer stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg) {
		this.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg = stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	}
	/**
	 * @return the zidovudine_LamivudineTabs_capsFDC_300_150mg
	 */
	public Integer getZidovudine_LamivudineTabs_capsFDC_300_150mg() {
		return zidovudine_LamivudineTabs_capsFDC_300_150mg;
	}
	/**
	 * @param zidovudine_LamivudineTabs_capsFDC_300_150mg the zidovudine_LamivudineTabs_capsFDC_300_150mg to set
	 */
	public void setZidovudine_LamivudineTabs_capsFDC_300_150mg(
			Integer zidovudine_LamivudineTabs_capsFDC_300_150mg) {
		this.zidovudine_LamivudineTabs_capsFDC_300_150mg = zidovudine_LamivudineTabs_capsFDC_300_150mg;
	}
	/**
	 * @return the zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg
	 */
	public Integer getZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg() {
		return zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	}
	/**
	 * @param zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg the zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg to set
	 */
	public void setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(
			Integer zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg) {
		this.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg = zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	}
	/**
	 * @return the abacavirTabs300mg
	 */
	public Integer getAbacavirTabs300mg() {
		return abacavirTabs300mg;
	}
	/**
	 * @param abacavirTabs300mg the abacavirTabs300mg to set
	 */
	public void setAbacavirTabs300mg(Integer abacavirTabs300mg) {
		this.abacavirTabs300mg = abacavirTabs300mg;
	}
	/**
	 * @return the didanosineTabs200mg
	 */
	public Integer getDidanosineTabs200mg() {
		return didanosineTabs200mg;
	}
	/**
	 * @param didanosineTabs200mg the didanosineTabs200mg to set
	 */
	public void setDidanosineTabs200mg(Integer didanosineTabs200mg) {
		this.didanosineTabs200mg = didanosineTabs200mg;
	}
	/**
	 * @return the didanosineTabs100mg
	 */
	public Integer getDidanosineTabs100mg() {
		return didanosineTabs100mg;
	}
	/**
	 * @param didanosineTabs100mg the didanosineTabs100mg to set
	 */
	public void setDidanosineTabs100mg(Integer didanosineTabs100mg) {
		this.didanosineTabs100mg = didanosineTabs100mg;
	}
	/**
	 * @return the didanosineTabs50mg
	 */
	public Integer getDidanosineTabs50mg() {
		return didanosineTabs50mg;
	}
	/**
	 * @param didanosineTabs50mg the didanosineTabs50mg to set
	 */
	public void setDidanosineTabs50mg(Integer didanosineTabs50mg) {
		this.didanosineTabs50mg = didanosineTabs50mg;
	}
	/**
	 * @return the efavirenzTabs600mg
	 */
	public Integer getEfavirenzTabs600mg() {
		return efavirenzTabs600mg;
	}
	/**
	 * @param efavirenzTabs600mg the efavirenzTabs600mg to set
	 */
	public void setEfavirenzTabs600mg(Integer efavirenzTabs600mg) {
		this.efavirenzTabs600mg = efavirenzTabs600mg;
	}
	/**
	 * @return the efavirenzTabs_caps200mg
	 */
	public Integer getEfavirenzTabs_caps200mg() {
		return efavirenzTabs_caps200mg;
	}
	/**
	 * @param efavirenzTabs_caps200mg the efavirenzTabs_caps200mg to set
	 */
	public void setEfavirenzTabs_caps200mg(Integer efavirenzTabs_caps200mg) {
		this.efavirenzTabs_caps200mg = efavirenzTabs_caps200mg;
	}
	/**
	 * @return the lamivudineTabs150mg
	 */
	public Integer getLamivudineTabs150mg() {
		return lamivudineTabs150mg;
	}
	/**
	 * @param lamivudineTabs150mg the lamivudineTabs150mg to set
	 */
	public void setLamivudineTabs150mg(Integer lamivudineTabs150mg) {
		this.lamivudineTabs150mg = lamivudineTabs150mg;
	}
	/**
	 * @return the lopinavir_ritonavirTabs_caps133
	 */
	public Integer getLopinavir_ritonavirTabs_caps133() {
		return lopinavir_ritonavirTabs_caps133;
	}
	/**
	 * @param lopinavir_ritonavirTabs_caps133 the lopinavir_ritonavirTabs_caps133 to set
	 */
	public void setLopinavir_ritonavirTabs_caps133(
			Integer lopinavir_ritonavirTabs_caps133) {
		this.lopinavir_ritonavirTabs_caps133 = lopinavir_ritonavirTabs_caps133;
	}
	/**
	 * @return the nelfinavirTabs250mg
	 */
	public Integer getNelfinavirTabs250mg() {
		return nelfinavirTabs250mg;
	}
	/**
	 * @param nelfinavirTabs250mg the nelfinavirTabs250mg to set
	 */
	public void setNelfinavirTabs250mg(Integer nelfinavirTabs250mg) {
		this.nelfinavirTabs250mg = nelfinavirTabs250mg;
	}
	/**
	 * @return the nevirapineTabs200mg
	 */
	public Integer getNevirapineTabs200mg() {
		return nevirapineTabs200mg;
	}
	/**
	 * @param nevirapineTabs200mg the nevirapineTabs200mg to set
	 */
	public void setNevirapineTabs200mg(Integer nevirapineTabs200mg) {
		this.nevirapineTabs200mg = nevirapineTabs200mg;
	}
	/**
	 * @return the stavudineTabs_Caps30mg
	 */
	public Integer getStavudineTabs_Caps30mg() {
		return stavudineTabs_Caps30mg;
	}
	/**
	 * @param stavudineTabs_Caps30mg the stavudineTabs_Caps30mg to set
	 */
	public void setStavudineTabs_Caps30mg(Integer stavudineTabs_Caps30mg) {
		this.stavudineTabs_Caps30mg = stavudineTabs_Caps30mg;
	}
	/**
	 * @return the stavudineTabs_Caps40mg
	 */
	public Integer getStavudineTabs_Caps40mg() {
		return stavudineTabs_Caps40mg;
	}
	/**
	 * @param stavudineTabs_Caps40mg the stavudineTabs_Caps40mg to set
	 */
	public void setStavudineTabs_Caps40mg(Integer stavudineTabs_Caps40mg) {
		this.stavudineTabs_Caps40mg = stavudineTabs_Caps40mg;
	}
	/**
	 * @return the tenofovirTabs_caps300mg
	 */
	public Integer getTenofovirTabs_caps300mg() {
		return tenofovirTabs_caps300mg;
	}
	/**
	 * @param tenofovirTabs_caps300mg the tenofovirTabs_caps300mg to set
	 */
	public void setTenofovirTabs_caps300mg(Integer tenofovirTabs_caps300mg) {
		this.tenofovirTabs_caps300mg = tenofovirTabs_caps300mg;
	}
	/**
	 * @return the zidovudineTabs300mg
	 */
	public Integer getZidovudineTabs300mg() {
		return zidovudineTabs300mg;
	}
	/**
	 * @param zidovudineTabs300mg the zidovudineTabs300mg to set
	 */
	public void setZidovudineTabs300mg(Integer zidovudineTabs300mg) {
		this.zidovudineTabs300mg = zidovudineTabs300mg;
	}

	public Integer getAbacavir_liquid_20mg_ml() {
		return abacavir_liquid_20mg_ml;
	}
	public void setAbacavir_liquid_20mg_ml(Integer abacavir_liquid_20mg_ml) {
		this.abacavir_liquid_20mg_ml = abacavir_liquid_20mg_ml;
	}
	public Integer getDidanosine_Tabs_caps_25mg() {
		return didanosine_Tabs_caps_25mg;
	}
	public void setDidanosine_Tabs_caps_25mg(Integer didanosine_Tabs_caps_25mg) {
		this.didanosine_Tabs_caps_25mg = didanosine_Tabs_caps_25mg;
	}
	public Integer getDidanosine_liquid_10mg_ml() {
		return didanosine_liquid_10mg_ml;
	}
	public void setDidanosine_liquid_10mg_ml(Integer didanosine_liquid_10mg_ml) {
		this.didanosine_liquid_10mg_ml = didanosine_liquid_10mg_ml;
	}
	public Integer getEfavirenz_Tabs_50mg() {
		return efavirenz_Tabs_50mg;
	}
	public void setEfavirenz_Tabs_50mg(Integer efavirenz_Tabs_50mg) {
		this.efavirenz_Tabs_50mg = efavirenz_Tabs_50mg;
	}
	public Integer getEfavirenz_liquid_30mg_ml() {
		return efavirenz_liquid_30mg_ml;
	}
	public void setEfavirenz_liquid_30mg_ml(Integer efavirenz_liquid_30mg_ml) {
		this.efavirenz_liquid_30mg_ml = efavirenz_liquid_30mg_ml;
	}
	public Integer getLamivudine_liquid_10mg_ml() {
		return lamivudine_liquid_10mg_ml;
	}
	public void setLamivudine_liquid_10mg_ml(Integer lamivudine_liquid_10mg_ml) {
		this.lamivudine_liquid_10mg_ml = lamivudine_liquid_10mg_ml;
	}
	public Integer getLopinavir_ritonavir_liquid_80() {
		return lopinavir_ritonavir_liquid_80;
	}
	public void setLopinavir_ritonavir_liquid_80(
			Integer lopinavir_ritonavir_liquid_80) {
		this.lopinavir_ritonavir_liquid_80 = lopinavir_ritonavir_liquid_80;
	}
	public Integer getNelfinavir_powder_50mg_125ml() {
		return nelfinavir_powder_50mg_125ml;
	}
	public void setNelfinavir_powder_50mg_125ml(Integer nelfinavir_powder_50mg_125ml) {
		this.nelfinavir_powder_50mg_125ml = nelfinavir_powder_50mg_125ml;
	}
	public Integer getNevirapine_susp_10mg_ml() {
		return nevirapine_susp_10mg_ml;
	}
	public void setNevirapine_susp_10mg_ml(Integer nevirapine_susp_10mg_ml) {
		this.nevirapine_susp_10mg_ml = nevirapine_susp_10mg_ml;
	}
	public Integer getStavudine_Tabs_caps_15mg() {
		return stavudine_Tabs_caps_15mg;
	}
	public void setStavudine_Tabs_caps_15mg(Integer stavudine_Tabs_caps_15mg) {
		this.stavudine_Tabs_caps_15mg = stavudine_Tabs_caps_15mg;
	}
	public Integer getStavudine_Tabs_caps_20mg() {
		return stavudine_Tabs_caps_20mg;
	}
	public void setStavudine_Tabs_caps_20mg(Integer stavudine_Tabs_caps_20mg) {
		this.stavudine_Tabs_caps_20mg = stavudine_Tabs_caps_20mg;
	}
	public Integer getStavudine_liquid_1mg_ml() {
		return stavudine_liquid_1mg_ml;
	}
	public void setStavudine_liquid_1mg_ml(Integer stavudine_liquid_1mg_ml) {
		this.stavudine_liquid_1mg_ml = stavudine_liquid_1mg_ml;
	}
	public Integer getZidovudine_Tabs_caps_100mg() {
		return zidovudine_Tabs_caps_100mg;
	}
	public void setZidovudine_Tabs_caps_100mg(Integer zidovudine_Tabs_caps_100mg) {
		this.zidovudine_Tabs_caps_100mg = zidovudine_Tabs_caps_100mg;
	}
	public Integer getZidovudine_liquid_10mg_ml() {
		return zidovudine_liquid_10mg_ml;
	}
	public void setZidovudine_liquid_10mg_ml(Integer zidovudine_liquid_10mg_ml) {
		this.zidovudine_liquid_10mg_ml = zidovudine_liquid_10mg_ml;
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
	public Integer getDidanosine400mg() {
		return didanosine400mg;
	}
	public void setDidanosine400mg(Integer didanosine400mg) {
		this.didanosine400mg = didanosine400mg;
	}
	public Integer getDidanosine250mg() {
		return didanosine250mg;
	}
	public void setDidanosine250mg(Integer didanosine250mg) {
		this.didanosine250mg = didanosine250mg;
	}
	public Integer getDidanosine50mg() {
		return didanosine50mg;
	}
	public void setDidanosine50mg(Integer didanosine50mg) {
		this.didanosine50mg = didanosine50mg;
	}
	public Integer getLopinavir_ritonavir200_50mg() {
		return lopinavir_ritonavir200_50mg;
	}
	public void setLopinavir_ritonavir200_50mg(Integer lopinavirRitonavir200_50mg) {
		lopinavir_ritonavir200_50mg = lopinavirRitonavir200_50mg;
	}
	public Long getDidanosine400mgItemId() {
		return didanosine400mgItemId;
	}
	public void setDidanosine400mgItemId(Long didanosine400mgItemId) {
		this.didanosine400mgItemId = didanosine400mgItemId;
	}
	public Long getDidanosine250mgItemId() {
		return didanosine250mgItemId;
	}
	public void setDidanosine250mgItemId(Long didanosine250mgItemId) {
		this.didanosine250mgItemId = didanosine250mgItemId;
	}
	public Long getDidanosine50mgItemId() {
		return didanosine50mgItemId;
	}
	public void setDidanosine50mgItemId(Long didanosine50mgItemId) {
		this.didanosine50mgItemId = didanosine50mgItemId;
	}
	public Long getLopinavir_ritonavir200_50mgItemId() {
		return lopinavir_ritonavir200_50mgItemId;
	}
	public void setLopinavir_ritonavir200_50mgItemId(Long lopinavirRitonavir200_50mgItemId) {
		lopinavir_ritonavir200_50mgItemId = lopinavirRitonavir200_50mgItemId;
	}

}


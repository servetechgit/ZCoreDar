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

import java.sql.Timestamp;

import org.rti.zcore.Creatable;

/**
 * Combines ARTAdultPatient and ARTChildPatient for CDRR-ART report. For expired
 * date Strings.
 *
 * @author ckelley
 *
 */
public class OIExpiration implements Creatable {

	private Long id;
	private Timestamp created;

	private String acyclovir200mg;
	private String acyclovirIVInfusion;
	private String aminosidineSulphate;
	private String aminosidineSulphateliquid;
	private String amphotericinBInjection;
	private String ceftriaxoneInj250mgIM;
	private String ciprofloxacinTabs500mg;
	private String cotrimoxazoleDS960mg;
	private String cotrimoxazoleTabs480mg;
	private String cotrimoxazolesusp240mg_5ml;
	private String diflucan200mg;
	private String diflucanInfusion;
	private String diflucansuspension;
	private String fluconazole150mg;
	private String fluconazole200mg;
	private String fluconazole50mg;
	private String ketaconazole200mg;
	private String miconazoleNitrate2OralGel;
	private String nystatinOralSuspension100000Units;
	private String pyridoxine25mg;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Timestamp getCreated() {
		return created;
	}
	public void setCreated(Timestamp created) {
		this.created = created;
	}
	/**
	 * @return the acyclovir200mg
	 */
	public String getAcyclovir200mg() {
		return acyclovir200mg;
	}
	/**
	 * @param acyclovir200mg the acyclovir200mg to set
	 */
	public void setAcyclovir200mg(String acyclovir200mg) {
		this.acyclovir200mg = acyclovir200mg;
	}
	/**
	 * @return the acyclovirIVInfusion
	 */
	public String getAcyclovirIVInfusion() {
		return acyclovirIVInfusion;
	}
	/**
	 * @param acyclovirIVInfusion the acyclovirIVInfusion to set
	 */
	public void setAcyclovirIVInfusion(String acyclovirIVInfusion) {
		this.acyclovirIVInfusion = acyclovirIVInfusion;
	}
	/**
	 * @return the aminosidineSulphate
	 */
	public String getAminosidineSulphate() {
		return aminosidineSulphate;
	}
	/**
	 * @param aminosidineSulphate the aminosidineSulphate to set
	 */
	public void setAminosidineSulphate(String aminosidineSulphate) {
		this.aminosidineSulphate = aminosidineSulphate;
	}
	/**
	 * @return the aminosidineSulphateliquid
	 */
	public String getAminosidineSulphateliquid() {
		return aminosidineSulphateliquid;
	}
	/**
	 * @param aminosidineSulphateliquid the aminosidineSulphateliquid to set
	 */
	public void setAminosidineSulphateliquid(String aminosidineSulphateliquid) {
		this.aminosidineSulphateliquid = aminosidineSulphateliquid;
	}
	/**
	 * @return the amphotericinBInjection
	 */
	public String getAmphotericinBInjection() {
		return amphotericinBInjection;
	}
	/**
	 * @param amphotericinBInjection the amphotericinBInjection to set
	 */
	public void setAmphotericinBInjection(String amphotericinBInjection) {
		this.amphotericinBInjection = amphotericinBInjection;
	}
	/**
	 * @return the ceftriaxoneInj250mgIM
	 */
	public String getCeftriaxoneInj250mgIM() {
		return ceftriaxoneInj250mgIM;
	}
	/**
	 * @param ceftriaxoneInj250mgIM the ceftriaxoneInj250mgIM to set
	 */
	public void setCeftriaxoneInj250mgIM(String ceftriaxoneInj250mgIM) {
		this.ceftriaxoneInj250mgIM = ceftriaxoneInj250mgIM;
	}
	/**
	 * @return the ciprofloxacinTabs500mg
	 */
	public String getCiprofloxacinTabs500mg() {
		return ciprofloxacinTabs500mg;
	}
	/**
	 * @param ciprofloxacinTabs500mg the ciprofloxacinTabs500mg to set
	 */
	public void setCiprofloxacinTabs500mg(String ciprofloxacinTabs500mg) {
		this.ciprofloxacinTabs500mg = ciprofloxacinTabs500mg;
	}
	/**
	 * @return the cotrimoxazoleDS960mg
	 */
	public String getCotrimoxazoleDS960mg() {
		return cotrimoxazoleDS960mg;
	}
	/**
	 * @param cotrimoxazoleDS960mg the cotrimoxazoleDS960mg to set
	 */
	public void setCotrimoxazoleDS960mg(String cotrimoxazoleDS960mg) {
		this.cotrimoxazoleDS960mg = cotrimoxazoleDS960mg;
	}
	/**
	 * @return the cotrimoxazoleTabs480mg
	 */
	public String getCotrimoxazoleTabs480mg() {
		return cotrimoxazoleTabs480mg;
	}
	/**
	 * @param cotrimoxazoleTabs480mg the cotrimoxazoleTabs480mg to set
	 */
	public void setCotrimoxazoleTabs480mg(String cotrimoxazoleTabs480mg) {
		this.cotrimoxazoleTabs480mg = cotrimoxazoleTabs480mg;
	}
	/**
	 * @return the cotrimoxazolesusp240mg_5ml
	 */
	public String getCotrimoxazolesusp240mg_5ml() {
		return cotrimoxazolesusp240mg_5ml;
	}
	/**
	 * @param cotrimoxazolesusp240mg_5ml the cotrimoxazolesusp240mg_5ml to set
	 */
	public void setCotrimoxazolesusp240mg_5ml(String cotrimoxazolesusp240mg_5ml) {
		this.cotrimoxazolesusp240mg_5ml = cotrimoxazolesusp240mg_5ml;
	}
	/**
	 * @return the diflucan200mg
	 */
	public String getDiflucan200mg() {
		return diflucan200mg;
	}
	/**
	 * @param diflucan200mg the diflucan200mg to set
	 */
	public void setDiflucan200mg(String diflucan200mg) {
		this.diflucan200mg = diflucan200mg;
	}
	/**
	 * @return the diflucanInfusion
	 */
	public String getDiflucanInfusion() {
		return diflucanInfusion;
	}
	/**
	 * @param diflucanInfusion the diflucanInfusion to set
	 */
	public void setDiflucanInfusion(String diflucanInfusion) {
		this.diflucanInfusion = diflucanInfusion;
	}
	/**
	 * @return the diflucansuspension
	 */
	public String getDiflucansuspension() {
		return diflucansuspension;
	}
	/**
	 * @param diflucansuspension the diflucansuspension to set
	 */
	public void setDiflucansuspension(String diflucansuspension) {
		this.diflucansuspension = diflucansuspension;
	}
	/**
	 * @return the fluconazole150mg
	 */
	public String getFluconazole150mg() {
		return fluconazole150mg;
	}
	/**
	 * @param fluconazole150mg the fluconazole150mg to set
	 */
	public void setFluconazole150mg(String fluconazole150mg) {
		this.fluconazole150mg = fluconazole150mg;
	}
	/**
	 * @return the fluconazole200mg
	 */
	public String getFluconazole200mg() {
		return fluconazole200mg;
	}
	/**
	 * @param fluconazole200mg the fluconazole200mg to set
	 */
	public void setFluconazole200mg(String fluconazole200mg) {
		this.fluconazole200mg = fluconazole200mg;
	}
	/**
	 * @return the fluconazole50mg
	 */
	public String getFluconazole50mg() {
		return fluconazole50mg;
	}
	/**
	 * @param fluconazole50mg the fluconazole50mg to set
	 */
	public void setFluconazole50mg(String fluconazole50mg) {
		this.fluconazole50mg = fluconazole50mg;
	}
	/**
	 * @return the ketaconazole200mg
	 */
	public String getKetaconazole200mg() {
		return ketaconazole200mg;
	}
	/**
	 * @param ketaconazole200mg the ketaconazole200mg to set
	 */
	public void setKetaconazole200mg(String ketaconazole200mg) {
		this.ketaconazole200mg = ketaconazole200mg;
	}
	/**
	 * @return the miconazoleNitrate2OralGel
	 */
	public String getMiconazoleNitrate2OralGel() {
		return miconazoleNitrate2OralGel;
	}
	/**
	 * @param miconazoleNitrate2OralGel the miconazoleNitrate2OralGel to set
	 */
	public void setMiconazoleNitrate2OralGel(String miconazoleNitrate2OralGel) {
		this.miconazoleNitrate2OralGel = miconazoleNitrate2OralGel;
	}
	/**
	 * @return the nystatinOralSuspension100000Units
	 */
	public String getNystatinOralSuspension100000Units() {
		return nystatinOralSuspension100000Units;
	}
	/**
	 * @param nystatinOralSuspension100000Units the nystatinOralSuspension100000Units to set
	 */
	public void setNystatinOralSuspension100000Units(String nystatinOralSuspension100000Units) {
		this.nystatinOralSuspension100000Units = nystatinOralSuspension100000Units;
	}
	/**
	 * @return the pyridoxine25mg
	 */
	public String getPyridoxine25mg() {
		return pyridoxine25mg;
	}
	/**
	 * @param pyridoxine25mg the pyridoxine25mg to set
	 */
	public void setPyridoxine25mg(String pyridoxine25mg) {
		this.pyridoxine25mg = pyridoxine25mg;
	}

}


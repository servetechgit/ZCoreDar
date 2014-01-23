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

/**
 * Combines ARTAdultPatient and ARTChildPatient for CDRR-ART report. For expired
 * dates.
 *
 * @author ckelley
 *
 */
public class OIExpirationDate implements Creatable {

	private Long id;
	private Timestamp created;

	private Date acyclovir200mg;
	private Date acyclovirIVInfusion;
	private Date aminosidineSulphate;
	private Date aminosidineSulphateliquid;
	private Date amphotericinBInjection;
	private Date ceftriaxoneInj250mgIM;
	private Date ciprofloxacinTabs500mg;
	private Date cotrimoxazoleDS960mg;
	private Date cotrimoxazoleTabs480mg;
	private Date cotrimoxazolesusp240mg_5ml;
	private Date diflucan200mg;
	private Date diflucanInfusion;
	private Date diflucansuspension;
	private Date fluconazole150mg;
	private Date fluconazole200mg;
	private Date fluconazole50mg;
	private Date ketaconazole200mg;
	private Date miconazoleNitrate2OralGel;
	private Date nystatinOralSuspension100000Units;
	private Date pyridoxine25mg;

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
	public Date getAcyclovir200mg() {
		return acyclovir200mg;
	}
	public void setAcyclovir200mg(Date acyclovir200mg) {
		this.acyclovir200mg = acyclovir200mg;
	}
	public Date getAcyclovirIVInfusion() {
		return acyclovirIVInfusion;
	}
	public void setAcyclovirIVInfusion(Date acyclovirIVInfusion) {
		this.acyclovirIVInfusion = acyclovirIVInfusion;
	}
	public Date getAminosidineSulphate() {
		return aminosidineSulphate;
	}
	public void setAminosidineSulphate(Date aminosidineSulphate) {
		this.aminosidineSulphate = aminosidineSulphate;
	}
	public Date getAminosidineSulphateliquid() {
		return aminosidineSulphateliquid;
	}
	public void setAminosidineSulphateliquid(Date aminosidineSulphateliquid) {
		this.aminosidineSulphateliquid = aminosidineSulphateliquid;
	}
	public Date getAmphotericinBInjection() {
		return amphotericinBInjection;
	}
	public void setAmphotericinBInjection(Date amphotericinBInjection) {
		this.amphotericinBInjection = amphotericinBInjection;
	}
	public Date getCeftriaxoneInj250mgIM() {
		return ceftriaxoneInj250mgIM;
	}
	public void setCeftriaxoneInj250mgIM(Date ceftriaxoneInj250mgIM) {
		this.ceftriaxoneInj250mgIM = ceftriaxoneInj250mgIM;
	}
	public Date getCiprofloxacinTabs500mg() {
		return ciprofloxacinTabs500mg;
	}
	public void setCiprofloxacinTabs500mg(Date ciprofloxacinTabs500mg) {
		this.ciprofloxacinTabs500mg = ciprofloxacinTabs500mg;
	}
	public Date getCotrimoxazoleDS960mg() {
		return cotrimoxazoleDS960mg;
	}
	public void setCotrimoxazoleDS960mg(Date cotrimoxazoleDS960mg) {
		this.cotrimoxazoleDS960mg = cotrimoxazoleDS960mg;
	}
	public Date getCotrimoxazoleTabs480mg() {
		return cotrimoxazoleTabs480mg;
	}
	public void setCotrimoxazoleTabs480mg(Date cotrimoxazoleTabs480mg) {
		this.cotrimoxazoleTabs480mg = cotrimoxazoleTabs480mg;
	}
	public Date getCotrimoxazolesusp240mg_5ml() {
		return cotrimoxazolesusp240mg_5ml;
	}
	public void setCotrimoxazolesusp240mg_5ml(Date cotrimoxazolesusp240mg_5ml) {
		this.cotrimoxazolesusp240mg_5ml = cotrimoxazolesusp240mg_5ml;
	}
	public Date getDiflucan200mg() {
		return diflucan200mg;
	}
	public void setDiflucan200mg(Date diflucan200mg) {
		this.diflucan200mg = diflucan200mg;
	}
	public Date getDiflucanInfusion() {
		return diflucanInfusion;
	}
	public void setDiflucanInfusion(Date diflucanInfusion) {
		this.diflucanInfusion = diflucanInfusion;
	}
	public Date getDiflucansuspension() {
		return diflucansuspension;
	}
	public void setDiflucansuspension(Date diflucansuspension) {
		this.diflucansuspension = diflucansuspension;
	}
	public Date getFluconazole150mg() {
		return fluconazole150mg;
	}
	public void setFluconazole150mg(Date fluconazole150mg) {
		this.fluconazole150mg = fluconazole150mg;
	}
	public Date getFluconazole200mg() {
		return fluconazole200mg;
	}
	public void setFluconazole200mg(Date fluconazole200mg) {
		this.fluconazole200mg = fluconazole200mg;
	}
	public Date getFluconazole50mg() {
		return fluconazole50mg;
	}
	public void setFluconazole50mg(Date fluconazole50mg) {
		this.fluconazole50mg = fluconazole50mg;
	}
	public Date getKetaconazole200mg() {
		return ketaconazole200mg;
	}
	public void setKetaconazole200mg(Date ketaconazole200mg) {
		this.ketaconazole200mg = ketaconazole200mg;
	}
	public Date getMiconazoleNitrate2OralGel() {
		return miconazoleNitrate2OralGel;
	}
	public void setMiconazoleNitrate2OralGel(Date miconazoleNitrate2OralGel) {
		this.miconazoleNitrate2OralGel = miconazoleNitrate2OralGel;
	}
	public Date getNystatinOralSuspension100000Units() {
		return nystatinOralSuspension100000Units;
	}
	public void setNystatinOralSuspension100000Units(Date nystatinOralSuspension100000Units) {
		this.nystatinOralSuspension100000Units = nystatinOralSuspension100000Units;
	}
	public Date getPyridoxine25mg() {
		return pyridoxine25mg;
	}
	public void setPyridoxine25mg(Date pyridoxine25mg) {
		this.pyridoxine25mg = pyridoxine25mg;
	}
}


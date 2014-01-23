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
public class ARTCombinedExpirationDate implements Creatable {

	private Long id;
	private Timestamp created;

    private Date stavudine_LamivudineFDCTabs_30_150mg;
	private Date stavudine_LamivudineFDCTabs_40_150mg;
	private Date stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	private Date stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	private Date zidovudine_LamivudineTabs_capsFDC_300_150mg;
	private Date zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	private Date abacavirTabs300mg;
	private Date didanosineTabs200mg;
	private Date didanosineTabs100mg;
	private Date didanosineTabs50mg;
	private Date efavirenzTabs600mg;
	private Date efavirenzTabs_caps200mg;
	private Date lamivudineTabs150mg;
	private Date lopinavir_ritonavirTabs_caps133;
	private Date nelfinavirTabs250mg;
	private Date nevirapineTabs200mg;
	private Date stavudineTabs_Caps30mg;
	private Date stavudineTabs_Caps40mg;
	private Date tenofovirTabs_caps300mg;
	private Date zidovudineTabs300mg;
	private Date abacavir_liquid_20mg_ml;
	private Date didanosine_Tabs_caps_25mg;
	private Date didanosine_liquid_10mg_ml;
	private Date efavirenz_Tabs_50mg;
	private Date efavirenz_liquid_30mg_ml;
	private Date lamivudine_liquid_10mg_ml;
	private Date lopinavir_ritonavir_liquid_80;
	private Date nelfinavir_powder_50mg_125ml;
	private Date nevirapine_susp_10mg_ml;
	private Date stavudine_Tabs_caps_15mg;
	private Date stavudine_Tabs_caps_20mg;
	private Date stavudine_liquid_1mg_ml;
	private Date zidovudine_Tabs_caps_100mg;
	private Date zidovudine_liquid_10mg_ml;

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
	public Date getStavudine_LamivudineFDCTabs_30_150mg() {
		return stavudine_LamivudineFDCTabs_30_150mg;
	}
	public void setStavudine_LamivudineFDCTabs_30_150mg(Date stavudine_LamivudineFDCTabs_30_150mg) {
		this.stavudine_LamivudineFDCTabs_30_150mg = stavudine_LamivudineFDCTabs_30_150mg;
	}
	public Date getStavudine_LamivudineFDCTabs_40_150mg() {
		return stavudine_LamivudineFDCTabs_40_150mg;
	}
	public void setStavudine_LamivudineFDCTabs_40_150mg(Date stavudine_LamivudineFDCTabs_40_150mg) {
		this.stavudine_LamivudineFDCTabs_40_150mg = stavudine_LamivudineFDCTabs_40_150mg;
	}
	public Date getStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg() {
		return stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	}
	public void setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(
			Date stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg) {
		this.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg = stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	}
	public Date getStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg() {
		return stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	}
	public void setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(
			Date stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg) {
		this.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg = stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	}
	public Date getZidovudine_LamivudineTabs_capsFDC_300_150mg() {
		return zidovudine_LamivudineTabs_capsFDC_300_150mg;
	}
	public void setZidovudine_LamivudineTabs_capsFDC_300_150mg(Date zidovudine_LamivudineTabs_capsFDC_300_150mg) {
		this.zidovudine_LamivudineTabs_capsFDC_300_150mg = zidovudine_LamivudineTabs_capsFDC_300_150mg;
	}
	public Date getZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg() {
		return zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	}
	public void setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(
			Date zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg) {
		this.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg = zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	}
	public Date getAbacavirTabs300mg() {
		return abacavirTabs300mg;
	}
	public void setAbacavirTabs300mg(Date abacavirTabs300mg) {
		this.abacavirTabs300mg = abacavirTabs300mg;
	}
	public Date getDidanosineTabs200mg() {
		return didanosineTabs200mg;
	}
	public void setDidanosineTabs200mg(Date didanosineTabs200mg) {
		this.didanosineTabs200mg = didanosineTabs200mg;
	}
	public Date getDidanosineTabs100mg() {
		return didanosineTabs100mg;
	}
	public void setDidanosineTabs100mg(Date didanosineTabs100mg) {
		this.didanosineTabs100mg = didanosineTabs100mg;
	}
	public Date getDidanosineTabs50mg() {
		return didanosineTabs50mg;
	}
	public void setDidanosineTabs50mg(Date didanosineTabs50mg) {
		this.didanosineTabs50mg = didanosineTabs50mg;
	}
	public Date getEfavirenzTabs600mg() {
		return efavirenzTabs600mg;
	}
	public void setEfavirenzTabs600mg(Date efavirenzTabs600mg) {
		this.efavirenzTabs600mg = efavirenzTabs600mg;
	}
	public Date getEfavirenzTabs_caps200mg() {
		return efavirenzTabs_caps200mg;
	}
	public void setEfavirenzTabs_caps200mg(Date efavirenzTabs_caps200mg) {
		this.efavirenzTabs_caps200mg = efavirenzTabs_caps200mg;
	}
	public Date getLamivudineTabs150mg() {
		return lamivudineTabs150mg;
	}
	public void setLamivudineTabs150mg(Date lamivudineTabs150mg) {
		this.lamivudineTabs150mg = lamivudineTabs150mg;
	}
	public Date getLopinavir_ritonavirTabs_caps133() {
		return lopinavir_ritonavirTabs_caps133;
	}
	public void setLopinavir_ritonavirTabs_caps133(Date lopinavir_ritonavirTabs_caps133) {
		this.lopinavir_ritonavirTabs_caps133 = lopinavir_ritonavirTabs_caps133;
	}
	public Date getNelfinavirTabs250mg() {
		return nelfinavirTabs250mg;
	}
	public void setNelfinavirTabs250mg(Date nelfinavirTabs250mg) {
		this.nelfinavirTabs250mg = nelfinavirTabs250mg;
	}
	public Date getNevirapineTabs200mg() {
		return nevirapineTabs200mg;
	}
	public void setNevirapineTabs200mg(Date nevirapineTabs200mg) {
		this.nevirapineTabs200mg = nevirapineTabs200mg;
	}
	public Date getStavudineTabs_Caps30mg() {
		return stavudineTabs_Caps30mg;
	}
	public void setStavudineTabs_Caps30mg(Date stavudineTabs_Caps30mg) {
		this.stavudineTabs_Caps30mg = stavudineTabs_Caps30mg;
	}
	public Date getStavudineTabs_Caps40mg() {
		return stavudineTabs_Caps40mg;
	}
	public void setStavudineTabs_Caps40mg(Date stavudineTabs_Caps40mg) {
		this.stavudineTabs_Caps40mg = stavudineTabs_Caps40mg;
	}
	public Date getTenofovirTabs_caps300mg() {
		return tenofovirTabs_caps300mg;
	}
	public void setTenofovirTabs_caps300mg(Date tenofovirTabs_caps300mg) {
		this.tenofovirTabs_caps300mg = tenofovirTabs_caps300mg;
	}
	public Date getZidovudineTabs300mg() {
		return zidovudineTabs300mg;
	}
	public void setZidovudineTabs300mg(Date zidovudineTabs300mg) {
		this.zidovudineTabs300mg = zidovudineTabs300mg;
	}
	public Date getAbacavir_liquid_20mg_ml() {
		return abacavir_liquid_20mg_ml;
	}
	public void setAbacavir_liquid_20mg_ml(Date abacavir_liquid_20mg_ml) {
		this.abacavir_liquid_20mg_ml = abacavir_liquid_20mg_ml;
	}
	public Date getDidanosine_Tabs_caps_25mg() {
		return didanosine_Tabs_caps_25mg;
	}
	public void setDidanosine_Tabs_caps_25mg(Date didanosine_Tabs_caps_25mg) {
		this.didanosine_Tabs_caps_25mg = didanosine_Tabs_caps_25mg;
	}
	public Date getDidanosine_liquid_10mg_ml() {
		return didanosine_liquid_10mg_ml;
	}
	public void setDidanosine_liquid_10mg_ml(Date didanosine_liquid_10mg_ml) {
		this.didanosine_liquid_10mg_ml = didanosine_liquid_10mg_ml;
	}
	public Date getEfavirenz_Tabs_50mg() {
		return efavirenz_Tabs_50mg;
	}
	public void setEfavirenz_Tabs_50mg(Date efavirenz_Tabs_50mg) {
		this.efavirenz_Tabs_50mg = efavirenz_Tabs_50mg;
	}
	public Date getEfavirenz_liquid_30mg_ml() {
		return efavirenz_liquid_30mg_ml;
	}
	public void setEfavirenz_liquid_30mg_ml(Date efavirenz_liquid_30mg_ml) {
		this.efavirenz_liquid_30mg_ml = efavirenz_liquid_30mg_ml;
	}
	public Date getLamivudine_liquid_10mg_ml() {
		return lamivudine_liquid_10mg_ml;
	}
	public void setLamivudine_liquid_10mg_ml(Date lamivudine_liquid_10mg_ml) {
		this.lamivudine_liquid_10mg_ml = lamivudine_liquid_10mg_ml;
	}
	public Date getLopinavir_ritonavir_liquid_80() {
		return lopinavir_ritonavir_liquid_80;
	}
	public void setLopinavir_ritonavir_liquid_80(Date lopinavir_ritonavir_liquid_80) {
		this.lopinavir_ritonavir_liquid_80 = lopinavir_ritonavir_liquid_80;
	}
	public Date getNelfinavir_powder_50mg_125ml() {
		return nelfinavir_powder_50mg_125ml;
	}
	public void setNelfinavir_powder_50mg_125ml(Date nelfinavir_powder_50mg_125ml) {
		this.nelfinavir_powder_50mg_125ml = nelfinavir_powder_50mg_125ml;
	}
	public Date getNevirapine_susp_10mg_ml() {
		return nevirapine_susp_10mg_ml;
	}
	public void setNevirapine_susp_10mg_ml(Date nevirapine_susp_10mg_ml) {
		this.nevirapine_susp_10mg_ml = nevirapine_susp_10mg_ml;
	}
	public Date getStavudine_Tabs_caps_15mg() {
		return stavudine_Tabs_caps_15mg;
	}
	public void setStavudine_Tabs_caps_15mg(Date stavudine_Tabs_caps_15mg) {
		this.stavudine_Tabs_caps_15mg = stavudine_Tabs_caps_15mg;
	}
	public Date getStavudine_Tabs_caps_20mg() {
		return stavudine_Tabs_caps_20mg;
	}
	public void setStavudine_Tabs_caps_20mg(Date stavudine_Tabs_caps_20mg) {
		this.stavudine_Tabs_caps_20mg = stavudine_Tabs_caps_20mg;
	}
	public Date getStavudine_liquid_1mg_ml() {
		return stavudine_liquid_1mg_ml;
	}
	public void setStavudine_liquid_1mg_ml(Date stavudine_liquid_1mg_ml) {
		this.stavudine_liquid_1mg_ml = stavudine_liquid_1mg_ml;
	}
	public Date getZidovudine_Tabs_caps_100mg() {
		return zidovudine_Tabs_caps_100mg;
	}
	public void setZidovudine_Tabs_caps_100mg(Date zidovudine_Tabs_caps_100mg) {
		this.zidovudine_Tabs_caps_100mg = zidovudine_Tabs_caps_100mg;
	}
	public Date getZidovudine_liquid_10mg_ml() {
		return zidovudine_liquid_10mg_ml;
	}
	public void setZidovudine_liquid_10mg_ml(Date zidovudine_liquid_10mg_ml) {
		this.zidovudine_liquid_10mg_ml = zidovudine_liquid_10mg_ml;
	}
}


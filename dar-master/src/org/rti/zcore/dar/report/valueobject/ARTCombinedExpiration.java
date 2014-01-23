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
public class ARTCombinedExpiration implements Creatable {

	private Long id;
	private Timestamp created;

    private String stavudine_LamivudineFDCTabs_30_150mg;
	private String stavudine_LamivudineFDCTabs_40_150mg;
	private String stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	private String stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	private String zidovudine_LamivudineTabs_capsFDC_300_150mg;
	private String zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	private String abacavirTabs300mg;
	private String didanosineTabs200mg;
	private String didanosineTabs100mg;
	private String didanosineTabs50mg;
	private String efavirenzTabs600mg;
	private String efavirenzTabs_caps200mg;
	private String lamivudineTabs150mg;
	private String lopinavir_ritonavirTabs_caps133;
	private String nelfinavirTabs250mg;
	private String nevirapineTabs200mg;
	private String stavudineTabs_Caps30mg;
	private String stavudineTabs_Caps40mg;
	private String tenofovirTabs_caps300mg;
	private String zidovudineTabs300mg;
	private String abacavir_liquid_20mg_ml;
	private String didanosine_Tabs_caps_25mg;
	private String didanosine_liquid_10mg_ml;
	private String efavirenz_Tabs_50mg;
	private String efavirenz_liquid_30mg_ml;
	private String lamivudine_liquid_10mg_ml;
	private String lopinavir_ritonavir_liquid_80;
	private String nelfinavir_powder_50mg_125ml;
	private String nevirapine_susp_10mg_ml;
	private String stavudine_Tabs_caps_15mg;
	private String stavudine_Tabs_caps_20mg;
	private String stavudine_liquid_1mg_ml;
	private String zidovudine_Tabs_caps_100mg;
	private String zidovudine_liquid_10mg_ml;
	// new drugs 01102010
	private String didanosine400mg;
	private String didanosine250mg;
	private String didanosine50mg;
	private String lopinavir_ritonavir200_50mg;


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
	public String getStavudine_LamivudineFDCTabs_30_150mg() {
		return stavudine_LamivudineFDCTabs_30_150mg;
	}
	public void setStavudine_LamivudineFDCTabs_30_150mg(String stavudineLamivudineFDCTabs_30_150mg) {
		stavudine_LamivudineFDCTabs_30_150mg = stavudineLamivudineFDCTabs_30_150mg;
	}
	public String getStavudine_LamivudineFDCTabs_40_150mg() {
		return stavudine_LamivudineFDCTabs_40_150mg;
	}
	public void setStavudine_LamivudineFDCTabs_40_150mg(String stavudineLamivudineFDCTabs_40_150mg) {
		stavudine_LamivudineFDCTabs_40_150mg = stavudineLamivudineFDCTabs_40_150mg;
	}
	public String getStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg() {
		return stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg;
	}
	public void setStavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg(
			String stavudineLamivudineNevirapineFDCTabs_30_150_200mg) {
		stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg = stavudineLamivudineNevirapineFDCTabs_30_150_200mg;
	}
	public String getStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg() {
		return stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg;
	}
	public void setStavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg(
			String stavudineLamivudineNevirapineFDCTabs_40_150_200mg) {
		stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg = stavudineLamivudineNevirapineFDCTabs_40_150_200mg;
	}
	public String getZidovudine_LamivudineTabs_capsFDC_300_150mg() {
		return zidovudine_LamivudineTabs_capsFDC_300_150mg;
	}
	public void setZidovudine_LamivudineTabs_capsFDC_300_150mg(String zidovudineLamivudineTabsCapsFDC_300_150mg) {
		zidovudine_LamivudineTabs_capsFDC_300_150mg = zidovudineLamivudineTabsCapsFDC_300_150mg;
	}
	public String getZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg() {
		return zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg;
	}
	public void setZidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg(
			String zidovudineLamivudineNevirapineTabsCapsFDC_300_150_200mg) {
		zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg = zidovudineLamivudineNevirapineTabsCapsFDC_300_150_200mg;
	}
	public String getAbacavirTabs300mg() {
		return abacavirTabs300mg;
	}
	public void setAbacavirTabs300mg(String abacavirTabs300mg) {
		this.abacavirTabs300mg = abacavirTabs300mg;
	}
	public String getDidanosineTabs200mg() {
		return didanosineTabs200mg;
	}
	public void setDidanosineTabs200mg(String didanosineTabs200mg) {
		this.didanosineTabs200mg = didanosineTabs200mg;
	}
	public String getDidanosineTabs100mg() {
		return didanosineTabs100mg;
	}
	public void setDidanosineTabs100mg(String didanosineTabs100mg) {
		this.didanosineTabs100mg = didanosineTabs100mg;
	}
	public String getDidanosineTabs50mg() {
		return didanosineTabs50mg;
	}
	public void setDidanosineTabs50mg(String didanosineTabs50mg) {
		this.didanosineTabs50mg = didanosineTabs50mg;
	}
	public String getEfavirenzTabs600mg() {
		return efavirenzTabs600mg;
	}
	public void setEfavirenzTabs600mg(String efavirenzTabs600mg) {
		this.efavirenzTabs600mg = efavirenzTabs600mg;
	}
	public String getEfavirenzTabs_caps200mg() {
		return efavirenzTabs_caps200mg;
	}
	public void setEfavirenzTabs_caps200mg(String efavirenzTabsCaps200mg) {
		efavirenzTabs_caps200mg = efavirenzTabsCaps200mg;
	}
	public String getLamivudineTabs150mg() {
		return lamivudineTabs150mg;
	}
	public void setLamivudineTabs150mg(String lamivudineTabs150mg) {
		this.lamivudineTabs150mg = lamivudineTabs150mg;
	}
	public String getLopinavir_ritonavirTabs_caps133() {
		return lopinavir_ritonavirTabs_caps133;
	}
	public void setLopinavir_ritonavirTabs_caps133(String lopinavirRitonavirTabsCaps133) {
		lopinavir_ritonavirTabs_caps133 = lopinavirRitonavirTabsCaps133;
	}
	public String getNelfinavirTabs250mg() {
		return nelfinavirTabs250mg;
	}
	public void setNelfinavirTabs250mg(String nelfinavirTabs250mg) {
		this.nelfinavirTabs250mg = nelfinavirTabs250mg;
	}
	public String getNevirapineTabs200mg() {
		return nevirapineTabs200mg;
	}
	public void setNevirapineTabs200mg(String nevirapineTabs200mg) {
		this.nevirapineTabs200mg = nevirapineTabs200mg;
	}
	public String getStavudineTabs_Caps30mg() {
		return stavudineTabs_Caps30mg;
	}
	public void setStavudineTabs_Caps30mg(String stavudineTabsCaps30mg) {
		stavudineTabs_Caps30mg = stavudineTabsCaps30mg;
	}
	public String getStavudineTabs_Caps40mg() {
		return stavudineTabs_Caps40mg;
	}
	public void setStavudineTabs_Caps40mg(String stavudineTabsCaps40mg) {
		stavudineTabs_Caps40mg = stavudineTabsCaps40mg;
	}
	public String getTenofovirTabs_caps300mg() {
		return tenofovirTabs_caps300mg;
	}
	public void setTenofovirTabs_caps300mg(String tenofovirTabsCaps300mg) {
		tenofovirTabs_caps300mg = tenofovirTabsCaps300mg;
	}
	public String getZidovudineTabs300mg() {
		return zidovudineTabs300mg;
	}
	public void setZidovudineTabs300mg(String zidovudineTabs300mg) {
		this.zidovudineTabs300mg = zidovudineTabs300mg;
	}
	public String getAbacavir_liquid_20mg_ml() {
		return abacavir_liquid_20mg_ml;
	}
	public void setAbacavir_liquid_20mg_ml(String abacavirLiquid_20mgMl) {
		abacavir_liquid_20mg_ml = abacavirLiquid_20mgMl;
	}
	public String getDidanosine_Tabs_caps_25mg() {
		return didanosine_Tabs_caps_25mg;
	}
	public void setDidanosine_Tabs_caps_25mg(String didanosineTabsCaps_25mg) {
		didanosine_Tabs_caps_25mg = didanosineTabsCaps_25mg;
	}
	public String getDidanosine_liquid_10mg_ml() {
		return didanosine_liquid_10mg_ml;
	}
	public void setDidanosine_liquid_10mg_ml(String didanosineLiquid_10mgMl) {
		didanosine_liquid_10mg_ml = didanosineLiquid_10mgMl;
	}
	public String getEfavirenz_Tabs_50mg() {
		return efavirenz_Tabs_50mg;
	}
	public void setEfavirenz_Tabs_50mg(String efavirenzTabs_50mg) {
		efavirenz_Tabs_50mg = efavirenzTabs_50mg;
	}
	public String getEfavirenz_liquid_30mg_ml() {
		return efavirenz_liquid_30mg_ml;
	}
	public void setEfavirenz_liquid_30mg_ml(String efavirenzLiquid_30mgMl) {
		efavirenz_liquid_30mg_ml = efavirenzLiquid_30mgMl;
	}
	public String getLamivudine_liquid_10mg_ml() {
		return lamivudine_liquid_10mg_ml;
	}
	public void setLamivudine_liquid_10mg_ml(String lamivudineLiquid_10mgMl) {
		lamivudine_liquid_10mg_ml = lamivudineLiquid_10mgMl;
	}
	public String getLopinavir_ritonavir_liquid_80() {
		return lopinavir_ritonavir_liquid_80;
	}
	public void setLopinavir_ritonavir_liquid_80(String lopinavirRitonavirLiquid_80) {
		lopinavir_ritonavir_liquid_80 = lopinavirRitonavirLiquid_80;
	}
	public String getNelfinavir_powder_50mg_125ml() {
		return nelfinavir_powder_50mg_125ml;
	}
	public void setNelfinavir_powder_50mg_125ml(String nelfinavirPowder_50mg_125ml) {
		nelfinavir_powder_50mg_125ml = nelfinavirPowder_50mg_125ml;
	}
	public String getNevirapine_susp_10mg_ml() {
		return nevirapine_susp_10mg_ml;
	}
	public void setNevirapine_susp_10mg_ml(String nevirapineSusp_10mgMl) {
		nevirapine_susp_10mg_ml = nevirapineSusp_10mgMl;
	}
	public String getStavudine_Tabs_caps_15mg() {
		return stavudine_Tabs_caps_15mg;
	}
	public void setStavudine_Tabs_caps_15mg(String stavudineTabsCaps_15mg) {
		stavudine_Tabs_caps_15mg = stavudineTabsCaps_15mg;
	}
	public String getStavudine_Tabs_caps_20mg() {
		return stavudine_Tabs_caps_20mg;
	}
	public void setStavudine_Tabs_caps_20mg(String stavudineTabsCaps_20mg) {
		stavudine_Tabs_caps_20mg = stavudineTabsCaps_20mg;
	}
	public String getStavudine_liquid_1mg_ml() {
		return stavudine_liquid_1mg_ml;
	}
	public void setStavudine_liquid_1mg_ml(String stavudineLiquid_1mgMl) {
		stavudine_liquid_1mg_ml = stavudineLiquid_1mgMl;
	}
	public String getZidovudine_Tabs_caps_100mg() {
		return zidovudine_Tabs_caps_100mg;
	}
	public void setZidovudine_Tabs_caps_100mg(String zidovudineTabsCaps_100mg) {
		zidovudine_Tabs_caps_100mg = zidovudineTabsCaps_100mg;
	}
	public String getZidovudine_liquid_10mg_ml() {
		return zidovudine_liquid_10mg_ml;
	}
	public void setZidovudine_liquid_10mg_ml(String zidovudineLiquid_10mgMl) {
		zidovudine_liquid_10mg_ml = zidovudineLiquid_10mgMl;
	}
	public String getDidanosine400mg() {
		return didanosine400mg;
	}
	public void setDidanosine400mg(String didanosine400mg) {
		this.didanosine400mg = didanosine400mg;
	}
	public String getDidanosine250mg() {
		return didanosine250mg;
	}
	public void setDidanosine250mg(String didanosine250mg) {
		this.didanosine250mg = didanosine250mg;
	}
	public String getDidanosine50mg() {
		return didanosine50mg;
	}
	public void setDidanosine50mg(String didanosine50mg) {
		this.didanosine50mg = didanosine50mg;
	}
	public String getLopinavir_ritonavir200_50mg() {
		return lopinavir_ritonavir200_50mg;
	}
	public void setLopinavir_ritonavir200_50mg(String lopinavirRitonavir200_50mg) {
		lopinavir_ritonavir200_50mg = lopinavirRitonavir200_50mg;
	}


}


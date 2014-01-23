<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:formatDate value="${register.beginDate}" pattern="${dateFormatLong}" var="beginDate"/>
<fmt:formatDate value="${register.endDate}" pattern="${dateFormatLong}" var="endDate"/>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-report-wide.jsp'>
<template:put name='title' direct='true'>ART Adult Daily Activity Report for ${register.siteName}
:&nbsp;${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='header' direct='true'>Combined Daily Activity Report for ${register.siteName}:&nbsp;${beginDate}
<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
	<tr>
        <td colspan="3">ART Program Sponsor</td>
        <td colspan="3">KEMSA</td>
        <th class="sideways" rowspan="2">ARV Regimen Code</th>
        <th colspan="15">ADULT FORMULATIONS</th>
        <th colspan="20">PAEDIATRIC FORMULATIONS</th>
        <th colspan="13">DRUGS FOR OIs</th>
    </tr>
    <tr>
    	<td colspan="3">Name of Facility</td>
        <td colspan="3">${register.siteName}</td>
        
		<th class="sideways">Zidovudine/Lamivudine/Nevirapine <br/>(AZT/3TC/NVP) FDC (300/150/200mg) Tabs</th>
		<th class="sideways">Zidovudine/Lamivudine (AZT/3TC) <br/>FDC (300/150mg) Tabs</th>
		<th class="sideways">Tenofovir/Lamivudine/Efavirenz <br/>(TDF/3TC/EFV) FDC (300/300/600mg) FDC Tabs</th>
		<th class="sideways">Tenofovir/Lamivudine (TDF/3TC) <br/>FDC (300/300mg) Tabs</th>
		<th class="sideways">Stavudine/Lamivudine/Nevirapine <br/>(d4T/3TC/NVP) FDC (30/150/200mg) Tabs     </th>
		<th class="sideways">Stavudine/Lamivudine (d4T/3TC) <br/>FDC (30/150mg) Tabs</th>
		<th class="sideways">Efavirenz (EFV) 600mg Tabs</th>
		<th class="sideways">Lamivudine (3TC) 150mg Tabs</th>
		<th class="sideways">Nevirapine (NVP) 200mg Tabs</th>
		<th class="sideways">Tenofovir (TDF) 300mg Tabs</th>
		<th class="sideways">Zidovudine (AZT) 300mg Tabs</th>
		<th class="sideways">Abacavir (ABC) 300mg Tabs</th>
		<th class="sideways">Didanosine (ddI) 400mg EC Tabs</th>
		<th class="sideways">Didanosine (ddI) 250mg EC Tabs</th>
		<th class="sideways">Lopinavir/ritonavir (LPV/r) 200/50mg Tabs</th>
		
		<th class="sideways">Zidovudine/Lamivudine/Nevirapine (AZT/3TC/NVP) FDC (60/30/50mg) tabs</th>
		<th class="sideways">Zidovudine/Lamivudine (AZT/3TC) FDC (60/30mg) Tabs</th>
		<th class="sideways">Abacavir/Lamivudine (ABC/3TC) 60mg/30mg FDC Tabs</th>
		<th class="sideways">Stavudine/Lamivudine/Nevirapine (d4T/3TC/NVP) FDC (12/60/100mg) Tabs</th>
		<th class="sideways">Abacavir (ABC) liquid 20mg/ml (Bottles)</th>
		<th class="sideways">Didanosine (ddI) 25mg Buffered Tabs</th>
		<th class="sideways">Didanosine (ddI) 125mg EC Tabs</th>
		<th class="sideways">Didanosine (ddI) 200mg EC Tabs</th>
		<th class="sideways">Efavirenz (EFV) 50mg Caps</th>
		<th class="sideways">Efavirenz (EFV) 200mg Tabs</th>
		<th class="sideways">Lamivudine (3TC) liquid 10mg/ml (Bottles)</th>
		<th class="sideways">Lopinavir/ritonavir (LPV/r) 100/25mg Tabs</th>
		<th class="sideways">Lopinavir/ritonavir (LPV/r) liquid 80/20mg/ml (Bottles)</th>
		<th class="sideways">Nevirapine (NVP) 50mg Tabs</th>
		<th class="sideways">Nevirapine (NVP) Susp 10mg/ml (Bottles)</th>
		<th class="sideways">Nevirapine (NVP) Susp 10mg/ml (For PMTCT only) (Bottles)</th>
		<th class="sideways">Stavudine (d4T) 15mg Caps.</th>
		<th class="sideways">Stavudine (d4T) 20mg Caps.</th>
		<th class="sideways">Zidovudine (AZT) 100mg Caps.</th>
		<th class="sideways">Zidovudine (AZT) liquid 10mg/ml (Bottles)</th>
		
		<th class="sideways">Cotrimoxazole 480mg Tabs</th>
		<th class="sideways">Cotrimoxazole 960mg Tabs</th>
		<th class="sideways">Cotrimoxazole suspension 240mg/5ml (Bottles)</th>
		<th class="sideways">Dapsone 100mg Tabs</th>
		<th class="sideways">Diflucan 200mg Tabs</th>
		<th class="sideways">Diflucan Suspension 50mg/5mlSuspension (Bottles)</th>
		<th class="sideways">Diflucan IV Infusion 2mg/ml (Bottles)</th>
		<th class="sideways">Fluconazole 200mg Tabs</th>
		<th class="sideways">Fluconazole 50mg Tabs / Caps</th>
		<th class="sideways">Amphotericin B 50mg IV Injection (Vials)</th>
		<th class="sideways">Acyclovir 400mg Tabs</th>
		<th class="sideways">Pyridoxine 50mg Tabs</th>
		<th class="sideways">Miconazole muco-adhesive 10mg Tabs</th>
		
    </tr>
    <tr>
        <th colspan="6" align="right">Balance B/F (A)</th>
        <th>&nbsp;</th>
        <td align="center">${register.stockReportMap.item6.balanceBF}</td>
        <td align="center">${register.stockReportMap.item5.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemTDF_3TC_EFV_300_300_600.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemTDF_3TC_300_300.balanceBF}</td>
        <td align="center">${register.stockReportMap.item3.balanceBF}</td>
        <td align="center">${register.stockReportMap.item1.balanceBF}</td>
        <td align="center">${register.stockReportMap.item12.balanceBF}</td>
        <td align="center">${register.stockReportMap.item13.balanceBF}</td>
        <td align="center">${register.stockReportMap.item16.balanceBF}</td>
        <td align="center">${register.stockReportMap.item19.balanceBF}</td>
        <td align="center">${register.stockReportMap.item20.balanceBF}</td>
        <td align="center">${register.stockReportMap.item7.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemddI_400.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemddI_250.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemLPV_r_200_50.balanceBF}</td>
        
        <td align="center">${register.stockReportMap.item218.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.balanceBF}</td>
        <td align="center">${register.stockReportMap.item219.balanceBF}</td>
        <td align="center">${register.stockReportMap.item217.balanceBF}</td>
        <td align="center">${register.stockReportMap.item21.balanceBF}</td>
        <td align="center">${register.stockReportMap.item22.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemddl20.balanceBF}</td>
        <td align="center">${register.stockReportMap.item9.balanceBF}</td>
        <td align="center">${register.stockReportMap.item24.balanceBF}</td>
        <td align="center">${register.stockReportMap.item11.balanceBF}</td>
        <td align="center">${register.stockReportMap.item26.balanceBF}</td>
        <td align="center">${register.stockReportMap.item220.balanceBF}</td>
        <td align="center">${register.stockReportMap.item27.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemNVP_50.balanceBF}</td>
        <td align="center">${register.stockReportMap.item29.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemNVP_10_PMTCT.balanceBF}</td>
        <td align="center">${register.stockReportMap.item30.balanceBF}</td>
        <td align="center">${register.stockReportMap.item31.balanceBF}</td>
        <td align="center">${register.stockReportMap.item33.balanceBF}</td>
        <td align="center">${register.stockReportMap.item34.balanceBF}</td>
        
        <td align="center">${register.stockReportMap.itemPHA0048.balanceBF}</td>
        <td align="center">${register.stockReportMap.item46.balanceBF}</td>
        <td align="center">${register.stockReportMap.item45.balanceBF}</td>
        <td align="center">${register.stockReportMap.item207.balanceBF}</td>
        <td align="center">${register.stockReportMap.item35.balanceBF}</td>
        <td align="center">${register.stockReportMap.item36.balanceBF}</td>
        <td align="center">${register.stockReportMap.item37.balanceBF}</td>
        <td align="center">${register.stockReportMap.item38.balanceBF}</td>
        <td align="center">${register.stockReportMap.item40.balanceBF}</td>
        <td align="center">${register.stockReportMap.item44.balanceBF}</td>
        <td align="center">${register.stockReportMap.item202.balanceBF}</td>
        <td align="center">${register.stockReportMap.item210.balanceBF}</td>
        <td align="center">${register.stockReportMap.item205.balanceBF}</td>
       
	</tr>
    <tr>
        <th colspan="6" align="right">Quantity Received (B)</th>
        <th>&nbsp;</th>
        <td align="center">${register.stockReportMap.item6.received}</td>
		<td align="center">${register.stockReportMap.item5.received}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_EFV_300_300_600.received}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_300_300.received}</td>
		<td align="center">${register.stockReportMap.item3.received}</td>
        <td align="center">${register.stockReportMap.item1.received}</td>
        <td align="center">${register.stockReportMap.item12.received}</td>
        <td align="center">${register.stockReportMap.item13.received}</td>
        <td align="center">${register.stockReportMap.item16.received}</td>
        <td align="center">${register.stockReportMap.item19.received}</td>
        <td align="center">${register.stockReportMap.item20.received}</td>
        <td align="center">${register.stockReportMap.item7.received}</td>
        <td align="center">${register.stockReportMap.itemddI_400.received}</td>
        <td align="center">${register.stockReportMap.itemddI_250.received}</td>
        <td align="center">${register.stockReportMap.itemLPV_r_200_50.received}</td>
        
        <td align="center">${register.stockReportMap.item218.received}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.received}</td>
        <td align="center">${register.stockReportMap.item219.received}</td>
        <td align="center">${register.stockReportMap.item217.received}</td>
        <td align="center">${register.stockReportMap.item21.received}</td>
        <td align="center">${register.stockReportMap.item22.received}</td>
        <td align="center">${register.stockReportMap.itemddl200.received}</td>
        <td align="center">${register.stockReportMap.item9.received}</td>
        <td align="center">${register.stockReportMap.item24.received}</td>
        <td align="center">${register.stockReportMap.item11.received}</td>
        <td align="center">${register.stockReportMap.item26.received}</td>
        <td align="center">${register.stockReportMap.item220.received}</td>
        <td align="center">${register.stockReportMap.item27.received}</td>
        <td align="center">${register.stockReportMap.itemNVP_50.received}</td>
        <td align="center">${register.stockReportMap.item29.received}</td>
        <td align="center">${register.stockReportMap.itemNVP_10_PMTCT.received}</td>
        <td align="center">${register.stockReportMap.item30.received}</td>
        <td align="center">${register.stockReportMap.item31.received}</td>
        <td align="center">${register.stockReportMap.item33.received}</td>
        <td align="center">${register.stockReportMap.item34.received}</td>
        
		 <td align="center">${register.stockReportMap.itemPHA0048.received}</td>
        <td align="center">${register.stockReportMap.item46.received}</td>
        <td align="center">${register.stockReportMap.item45.received}</td>
        <td align="center">${register.stockReportMap.item207.received}</td>
        <td align="center">${register.stockReportMap.item35.received}</td>
        <td align="center">${register.stockReportMap.item36.received}</td>
        <td align="center">${register.stockReportMap.item37.received}</td>
        <td align="center">${register.stockReportMap.item38.received}</td>
        <td align="center">${register.stockReportMap.item40.received}</td>
        <td align="center">${register.stockReportMap.item44.received}</td>
        <td align="center">${register.stockReportMap.item202.received}</td>
        <td align="center">${register.stockReportMap.item210.received}</td>
        <td align="center">${register.stockReportMap.item205.received}</td>
	</tr>
    <tr>
        <th colspan="6" align="right">Stock on Hand (Balance B/F plus Quantity Received)<br/>(C= A + B)</th>
        <th>&nbsp;</th>
		<td align="center">${register.stockReportMap.item6.onHand}</td>
		<td align="center">${register.stockReportMap.item5.onHand}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_EFV_300_300_600.onHand}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_300_300.onHand}</td>
		<td align="center">${register.stockReportMap.item3.onHand}</td>
        <td align="center">${register.stockReportMap.item1.onHand}</td>
        <td align="center">${register.stockReportMap.item12.onHand}</td>
        <td align="center">${register.stockReportMap.item13.onHand}</td>
        <td align="center">${register.stockReportMap.item16.onHand}</td>
        <td align="center">${register.stockReportMap.item19.onHand}</td>
        <td align="center">${register.stockReportMap.item20.onHand}</td>
        <td align="center">${register.stockReportMap.item7.onHand}</td>
        <td align="center">${register.stockReportMap.itemddI_400.onHand}</td>
        <td align="center">${register.stockReportMap.itemddI_250.onHand}</td>
        <td align="center">${register.stockReportMap.itemLPV_r_200_50.onHand}</td>
        
        <td align="center">${register.stockReportMap.item218.onHand}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.onHand}</td>
        <td align="center">${register.stockReportMap.item219.onHand}</td>
        <td align="center">${register.stockReportMap.item217.onHand}</td>
        <td align="center">${register.stockReportMap.item21.onHand}</td>
        <td align="center">${register.stockReportMap.item22.onHand}</td>
        <td align="center">${register.stockReportMap.itemddl200.onHand}</td>
        <td align="center">${register.stockReportMap.item9.onHand}</td>
        <td align="center">${register.stockReportMap.item24.onHand}</td>
        <td align="center">${register.stockReportMap.item11.onHand}</td>
        <td align="center">${register.stockReportMap.item26.onHand}</td>
        <td align="center">${register.stockReportMap.item220.onHand}</td>
        <td align="center">${register.stockReportMap.item27.onHand}</td>
        <td align="center">${register.stockReportMap.itemNVP_50.onHand}</td>
        <td align="center">${register.stockReportMap.item29.onHand}</td>
        <td align="center">${register.stockReportMap.itemNVP_10_PMTCT.onHand}</td>
        <td align="center">${register.stockReportMap.item30.onHand}</td>
        <td align="center">${register.stockReportMap.item31.onHand}</td>
        <td align="center">${register.stockReportMap.item33.onHand}</td>
        <td align="center">${register.stockReportMap.item34.onHand}</td>
        
         <td align="center">${register.stockReportMap.itemPHA0048.onHand}</td>
        <td align="center">${register.stockReportMap.item46.onHand}</td>
        <td align="center">${register.stockReportMap.item45.onHand}</td>
        <td align="center">${register.stockReportMap.item207.onHand}</td>
        <td align="center">${register.stockReportMap.item35.onHand}</td>
        <td align="center">${register.stockReportMap.item36.onHand}</td>
        <td align="center">${register.stockReportMap.item37.onHand}</td>
        <td align="center">${register.stockReportMap.item38.onHand}</td>
        <td align="center">${register.stockReportMap.item40.onHand}</td>
        <td align="center">${register.stockReportMap.item44.onHand}</td>
        <td align="center">${register.stockReportMap.item202.onHand}</td>
        <td align="center">${register.stockReportMap.item210.onHand}</td>
        <td align="center">${register.stockReportMap.item205.onHand}</td>
		
	</tr>
    <tr>
        <th width="70px">Date&nbsp;Visit</th>
        <th width="120px">Client No.</th>
        <th width="120px">Client&nbsp;name</th>
        <th title="Age:- C for Child (<=14 Yrs) or A for Adults (>14 yrs)">Child or Adult</th>
        <th title="New Client (N) or Revisit (R)">New or Revisit</th>
        <th title="Dispensing pharmacist (Signature)">Pharmacist</th>
        <th colspan="49"></th>
	</tr>

<c:set var="smRegisterString" value="unknown"/>
<logic:iterate id="patient" name="register" property="artRegimenReport.allPatients" indexId="cnt">

	<tr>
    	<td align="center"><fmt:formatDate type="date" pattern="${dateFormatLong}" value="${patient.dateVisit}"/></td>
    	<td align="center" >${patient.clientId}</td>
        <td align="center" class="small" width="120px">
		<c:url value="viewEncounter.do" var="dispensing"><c:param name="patientId" value="${patient.patientId}"/><c:param name="id" value="${patient.encounter.id}"/>
    	</c:url>
        <a href='<c:out value="/${appName}/${dispensing}"/>'>${patient.surname}, ${patient.firstName}</a>
	   	</td>
	   	<td align="center">${patient.childOrAdult}</td>
	   	<td align="center"><c:if test="${patient.revisit == true}">R</c:if><c:if test="${patient.revisit == false}">N</c:if></td>
	   	<td align="center">${patient.pharmacist}</td>
	   	<td align="center">${patient.arvRegimenCode}</td>
	   	<td align="center">${patient.totalStockDispensed.item6}</td>
		<td align="center">${patient.totalStockDispensed.item5}</td>
		<td align="center">${patient.totalStockDispensed.itemTDF_3TC_EFV_300_300_600}</td>
		<td align="center">${patient.totalStockDispensed.itemTDF_3TC_300_300}</td>
		<td align="center">${patient.totalStockDispensed.item3}</td>
        <td align="center">${patient.totalStockDispensed.item1}</td>
        <td align="center">${patient.totalStockDispensed.item12}</td>
        <td align="center">${patient.totalStockDispensed.item13}</td>
        <td align="center">${patient.totalStockDispensed.item16}</td>
        <td align="center">${patient.totalStockDispensed.item19}</td>
        <td align="center">${patient.totalStockDispensed.item20}</td>
        <td align="center">${patient.totalStockDispensed.item7}</td>
        <td align="center">${patient.totalStockDispensed.itemddI_400}</td>
        <td align="center">${patient.totalStockDispensed.itemddI_250}</td>
        <td align="center">${patient.totalStockDispensed.itemLPV_r_200_50}</td>
        
        <td align="center">${patient.totalStockDispensed.item218}</td>
        <td align="center">${patient.totalStockDispensed.itemAZT_3TC_60_30}</td>
        <td align="center">${patient.totalStockDispensed.item219}</td>
        <td align="center">${patient.totalStockDispensed.item217}</td>
        <td align="center">${patient.totalStockDispensed.item21}</td>
        <td align="center">${patient.totalStockDispensed.item22}</td>
        <td align="center">${patient.totalStockDispensed.itemddl200}</td>
        <td align="center">${patient.totalStockDispensed.item9}</td>
        <td align="center">${patient.totalStockDispensed.item24}</td>
        <td align="center">${patient.totalStockDispensed.item11}</td>
        <td align="center">${patient.totalStockDispensed.item26}</td>
        <td align="center">${patient.totalStockDispensed.item220}</td>
        <td align="center">${patient.totalStockDispensed.item27}</td>
        <td align="center">${patient.totalStockDispensed.itemNVP_50}</td>
        <td align="center">${patient.totalStockDispensed.item29}</td>
        <td align="center">${patient.totalStockDispensed.itemNVP_10_PMTCT}</td>
        <td align="center">${patient.totalStockDispensed.item30}</td>
        <td align="center">${patient.totalStockDispensed.item31}</td>
        <td align="center">${patient.totalStockDispensed.item33}</td>
        <td align="center">${patient.totalStockDispensed.item34}</td>
        
        <td align="center">${patient.totalStockDispensed.itemPHA0048}</td>
        <td align="center">${patient.totalStockDispensed.item46}</td>
        <td align="center">${patient.totalStockDispensed.item45}</td>
        <td align="center">${patient.totalStockDispensed.item207}</td>
        <td align="center">${patient.totalStockDispensed.item35}</td>
        <td align="center">${patient.totalStockDispensed.item36}</td>
        <td align="center">${patient.totalStockDispensed.item37}</td>
        <td align="center">${patient.totalStockDispensed.item38}</td>
        <td align="center">${patient.totalStockDispensed.item40}</td>
        <td align="center">${patient.totalStockDispensed.item44}</td>
        <td align="center">${patient.totalStockDispensed.item202}</td>
        <td align="center">${patient.totalStockDispensed.item210}</td>
        <td align="center">${patient.totalStockDispensed.item205}</td>
        
	</tr>
</logic:iterate>
	    <tr>
	        <th colspan="6" align="right">Total Quantity Dispensed (D)</th>
	        <th>&nbsp;</th>
	        <td align="center">${register.stockReportMap.item6.totalDispensed}</td>
		<td align="center">${register.stockReportMap.item5.totalDispensed}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_EFV_300_300_600.totalDispensed}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_300_300.totalDispensed}</td>
		<td align="center">${register.stockReportMap.item3.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item1.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item12.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item13.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item16.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item19.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item20.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item7.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemddI_400.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemddI_250.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemLPV_r_200_50.totalDispensed}</td>
        
        <td align="center">${register.stockReportMap.item218.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item219.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item217.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item21.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item22.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemddl200.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item9.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item24.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item11.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item26.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item220.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item27.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemNVP_50.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item29.totalDispensed}</td>
        <td align="center">${register.stockReportMap.itemNVP_10_PMTCT.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item30.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item31.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item33.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item34.totalDispensed}</td>
        
        
		<td align="center">${register.stockReportMap.itemPHA0048.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item46.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item45.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item207.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item35.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item36.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item37.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item38.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item40.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item44.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item202.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item210.totalDispensed}</td>
        <td align="center">${register.stockReportMap.item205.totalDispensed}</td>
        
        
	</tr>
	    <tr>
	        <th colspan="6" align="right">Losses (E)</th>
	        <th>&nbsp;</th>
	        <td align="center">${register.stockReportMap.item6.losses}</td>
		<td align="center">${register.stockReportMap.item5.losses}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_EFV_300_300_600.losses}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_300_300.losses}</td>
		<td align="center">${register.stockReportMap.item3.losses}</td>
        <td align="center">${register.stockReportMap.item1.losses}</td>
        <td align="center">${register.stockReportMap.item12.losses}</td>
        <td align="center">${register.stockReportMap.item13.losses}</td>
        <td align="center">${register.stockReportMap.item16.losses}</td>
        <td align="center">${register.stockReportMap.item19.losses}</td>
        <td align="center">${register.stockReportMap.item20.losses}</td>
        <td align="center">${register.stockReportMap.item7.losses}</td>
        <td align="center">${register.stockReportMap.itemddI_400.losses}</td>
        <td align="center">${register.stockReportMap.itemddI_250.losses}</td>
        <td align="center">${register.stockReportMap.itemLPV_r_200_50.losses}</td>
        
        <td align="center">${register.stockReportMap.item218.losses}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.losses}</td>
        <td align="center">${register.stockReportMap.item219.losses}</td>
        <td align="center">${register.stockReportMap.item217.losses}</td>
        <td align="center">${register.stockReportMap.item21.losses}</td>
        <td align="center">${register.stockReportMap.item22.losses}</td>
        <td align="center">${register.stockReportMap.itemddl200.losses}</td>
        <td align="center">${register.stockReportMap.item9.losses}</td>
        <td align="center">${register.stockReportMap.item24.losses}</td>
        <td align="center">${register.stockReportMap.item11.losses}</td>
        <td align="center">${register.stockReportMap.item26.losses}</td>
        <td align="center">${register.stockReportMap.item220.losses}</td>
        <td align="center">${register.stockReportMap.item27.losses}</td>
        <td align="center">${register.stockReportMap.itemNVP_50.losses}</td>
        <td align="center">${register.stockReportMap.item29.losses}</td>
        <td align="center">${register.stockReportMap.itemNVP_10_PMTCT.losses}</td>
        <td align="center">${register.stockReportMap.item30.losses}</td>
        <td align="center">${register.stockReportMap.item31.losses}</td>
        <td align="center">${register.stockReportMap.item33.losses}</td>
        <td align="center">${register.stockReportMap.item34.losses}</td>
        
       <td align="center">${register.stockReportMap.itemPHA0048.losses}</td>
        <td align="center">${register.stockReportMap.item46.losses}</td>
        <td align="center">${register.stockReportMap.item45.losses}</td>
        <td align="center">${register.stockReportMap.item207.losses}</td>
        <td align="center">${register.stockReportMap.item35.losses}</td>
        <td align="center">${register.stockReportMap.item36.losses}</td>
        <td align="center">${register.stockReportMap.item37.losses}</td>
        <td align="center">${register.stockReportMap.item38.losses}</td>
        <td align="center">${register.stockReportMap.item40.losses}</td>
        <td align="center">${register.stockReportMap.item44.losses}</td>
        <td align="center">${register.stockReportMap.item202.losses}</td>
        <td align="center">${register.stockReportMap.item210.losses}</td>
        <td align="center">${register.stockReportMap.item205.losses}</td>
		
		</tr>
	    <tr>
	        <th colspan="6" align="right">Balance CF (G)</th>
	        <th>&nbsp;</th>
		<td align="center">${register.stockReportMap.item6.balanceCF}</td>
		<td align="center">${register.stockReportMap.item5.balanceCF}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_EFV_300_300_600.balanceCF}</td>
		<td align="center">${register.stockReportMap.itemTDF_3TC_300_300.balanceCF}</td>
		<td align="center">${register.stockReportMap.item3.balanceCF}</td>
        <td align="center">${register.stockReportMap.item1.balanceCF}</td>
        <td align="center">${register.stockReportMap.item12.balanceCF}</td>
        <td align="center">${register.stockReportMap.item13.balanceCF}</td>
        <td align="center">${register.stockReportMap.item16.balanceCF}</td>
        <td align="center">${register.stockReportMap.item19.balanceCF}</td>
        <td align="center">${register.stockReportMap.item20.balanceCF}</td>
        <td align="center">${register.stockReportMap.item7.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemddI_400.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemddI_250.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemLPV_r_200_50.balanceCF}</td>
        
        <td align="center">${register.stockReportMap.item218.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.balanceCF}</td>
        <td align="center">${register.stockReportMap.item219.balanceCF}</td>
        <td align="center">${register.stockReportMap.item217.balanceCF}</td>
        <td align="center">${register.stockReportMap.item21.balanceCF}</td>
        <td align="center">${register.stockReportMap.item22.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemddl200.balanceCF}</td>
        <td align="center">${register.stockReportMap.item9.balanceCF}</td>
        <td align="center">${register.stockReportMap.item24.balanceCF}</td>
        <td align="center">${register.stockReportMap.item11.balanceCF}</td>
        <td align="center">${register.stockReportMap.item26.balanceCF}</td>
        <td align="center">${register.stockReportMap.item220.balanceCF}</td>
        <td align="center">${register.stockReportMap.item27.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemNVP_50.balanceCF}</td>
        <td align="center">${register.stockReportMap.item29.balanceCF}</td>
        <td align="center">${register.stockReportMap.itemNVP_10_PMTCT.balanceCF}</td>
        <td align="center">${register.stockReportMap.item30.balanceCF}</td>
        <td align="center">${register.stockReportMap.item31.balanceCF}</td>
        <td align="center">${register.stockReportMap.item33.balanceCF}</td>
        <td align="center">${register.stockReportMap.item34.balanceCF}</td>
        
        <td align="center">${register.stockReportMap.itemPHA0048.balanceCF}</td>
        <td align="center">${register.stockReportMap.item46.balanceCF}</td>
        <td align="center">${register.stockReportMap.item45.balanceCF}</td>
        <td align="center">${register.stockReportMap.item207.balanceCF}</td>
        <td align="center">${register.stockReportMap.item35.balanceCF}</td>
        <td align="center">${register.stockReportMap.item36.balanceCF}</td>
        <td align="center">${register.stockReportMap.item37.balanceCF}</td>
        <td align="center">${register.stockReportMap.item38.balanceCF}</td>
        <td align="center">${register.stockReportMap.item40.balanceCF}</td>
        <td align="center">${register.stockReportMap.item44.balanceCF}</td>
        <td align="center">${register.stockReportMap.item202.balanceCF}</td>
        <td align="center">${register.stockReportMap.item210.balanceCF}</td>
        <td align="center">${register.stockReportMap.item205.balanceCF}</td>
        
        
	</tr>
</table>

</template:put>
</template:insert>

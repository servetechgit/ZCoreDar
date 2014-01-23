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
<template:put name='title' direct='true'>ART Child Daily Activity Report for ${register.siteName}&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='header' direct='true'>ART Child Daily Activity Report for ${register.siteName}:&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<c:set var="pageBreakCount" value="0"/>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
	<tr>
        <td colspan="3">ART Program Sponsor</td>
        <td colspan="3">KEMSA</td>
        <th class="sideways" rowspan="2">ARV Regimen Code</th>
        <th colspan="20">PAEDIATRIC FORMULATIONS</th>
    </tr>
    <tr>
        <td colspan="3">Name of Facility</td>
        <td colspan="3">${register.siteName}</td>
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
    </tr>
    <tr>
        <th colspan="6" align="right">Balance B/F (A)</th>
        <th>&nbsp;</th>
        <td align="center">${register.stockReportMap.item218.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemAZT_3TC_60_30.balanceBF}</td>
        <td align="center">${register.stockReportMap.item219.balanceBF}</td>
        <td align="center">${register.stockReportMap.item217.balanceBF}</td>
        <td align="center">${register.stockReportMap.item21.balanceBF}</td>
        <td align="center">${register.stockReportMap.item22.balanceBF}</td>
        <td align="center">${register.stockReportMap.itemddl200.balanceBF}</td>
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
	</tr>
    <tr>
        <th colspan="6" align="right">Quantity Received (B)</th>
        <th>&nbsp;</th>
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
	</tr>
    <tr>
        <th colspan="6" align="right">Stock on Hand (Balance B/F plus Quantity Received)<br/>(C= A + B)</th>
        <th>&nbsp;</th>
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
	</tr>
    <tr>
        <th width="70px">Date&nbsp;Visit</th>
        <th width="120px">Client No.</th>
        <th width="120px">Client&nbsp;name</th>
        <th title="Age:- C for Child (<=14 Yrs) or A for Adults (>14 yrs)">Child or Adult</th>
        <th title="New Client (N) or Revisit (R)">New or Revisit</th>
        <th title="Dispensing pharmacist (Signature)">Pharmacist</th>
        <td colspan="22"></td>
	</tr>
	
<c:set var="smRegisterString" value="unknown"/>
<logic:iterate id="patient" name="register" property="artRegimenReport.children" indexId="cnt">
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
	</tr>
</logic:iterate>



	    <tr>
	        <th colspan="6" align="right">Total Quantity Dispensed (D)</th>
		<th>&nbsp;</th>
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
	</tr>
	    <tr>
	        <th colspan="6" align="right">Losses (E)</th>
	        <th>&nbsp;</th>
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
		</tr>
	    <tr>
	        <th colspan="6" align="right">Balance CF (G)</th>
	        <th>&nbsp;</th>
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
	</tr>
</table>
</template:put>
</template:insert>

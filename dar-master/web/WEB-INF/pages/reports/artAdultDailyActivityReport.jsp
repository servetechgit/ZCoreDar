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
<template:put name='header' direct='true'>ART Adult Daily Activity Report for ${register.siteName}:&nbsp;${beginDate}
<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
	<tr>
        <td colspan="3">ART Program Sponsor</td>
        <td colspan="3">KEMSA</td>
        <th class="sideways" rowspan="2">ARV Regimen Code</th>
        <th colspan="15">ADULT FORMULATIONS</th>
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
		
	</tr>
    <tr>
        <th width="70px">Date&nbsp;Visit</th>
        <th width="120px">Client No.</th>
        <th width="120px">Client&nbsp;name</th>
        <th title="Age:- C for Child (<=14 Yrs) or A for Adults (>14 yrs)">Child or Adult</th>
        <th title="New Client (N) or Revisit (R)">New or Revisit</th>
        <th title="Dispensing pharmacist (Signature)">Pharmacist</th>
        <th colspan="17"></th>
	</tr>

<c:set var="smRegisterString" value="unknown"/>
<logic:iterate id="patient" name="register" property="artRegimenReport.adults" indexId="cnt">
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
	</tr>
</table>

</template:put>
</template:insert>

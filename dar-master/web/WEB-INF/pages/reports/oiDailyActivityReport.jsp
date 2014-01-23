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
<fmt:formatDate value="${dateNow}" pattern="${dateFormatLong}" var="dateNowLong"/>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-report-wide.jsp'>
<template:put name='title' direct='true'>OI Daily Activity Report for ${register.siteName}&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='header' direct='true'>OI Daily Activity Report for ${register.siteName}&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
    <tr>
        <th colspan="7"></th>
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
        <th>Date:</th>
        <td>${dateNowLong}</td>
        <th colspan="5">Balance B/F (A)</th>
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
        <th>Date:</th>
        <td>${dateNowLong}</td>
        <th colspan="5">Quantity Received (B)</th>
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
        <th>Date:</th>
        <td>${dateNowLong}</td>
        <th colspan="5">Stock on Hand (Balance B/F plus Quantity Received) (C= A + B)</th>
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
        <th width="150px">Client&nbsp;name</th>
        <th title="Age:- C for Child (<=14 Yrs) or A for Adults (>14 yrs)">Child or Adult</th>
        <th title="New Client (N) or Revisit (R)">New or Revisit</th>
        <th title="Diagnosis (Diflucan only): CM / OC">Diagnosis</th>
        <th title="Dispensing pharmacist (Signature)">Pharmacist</th>
        <td colspan="20"></td>
	</tr>
<c:set var="smRegisterString" value="unknown"/>
<c:set var="patientName" value="unknown"/>
<logic:iterate id="patient" name="register" property="artRegimenReport.allPatients" indexId="cnt">
<c:set var="pageBreakCount" value="${pageBreakCount + 1}"/>
	<tr>
    	<td align="center" class="small" width="70px;"><fmt:formatDate type="date" pattern="${dateFormatLong}" value="${patient.dateVisit}"/></td>
    	<td align="center" >${patient.clientId}</td>
        <td align="center" class="small" width="120px">
    	<c:url value="viewEncounter.do" var="dispensing"><c:param name="patientId" value="${patient.patientId}"/><c:param name="id" value="${patient.encounter.id}"/>
    	</c:url>
        <a href='<c:out value="/${appName}/${dispensing}"/>'>${patient.surname}, ${patient.firstName}</a>
	   	</td>
	   	<td>${patient.childOrAdult}</td>
	   	<td><c:if test="${patient.revisit == true}">R</c:if><c:if test="${patient.revisit == false}">N</c:if></td>
	   	<td>${patient.diagnosis}</td>
	   	<td>${patient.pharmacist}</td>
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
        <th colspan="7">Total Quantity Dispensed  (D)</th>
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
        <th colspan="7">Losses (E)</th>
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
        <th colspan="7">Balance C/F (G= C + F - D - E)</th>
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

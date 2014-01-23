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

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-report-wide-ajax.jsp'>
<template:put name='title' direct='true'>CDRR-ART Report for ${register.siteName}&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='header' direct='true'>CDRR-ART Report for ${register.siteName}:&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<p>Instructions: Double-click on the field in the "Quantity Required for NEW patients" column to enter values for the corresponding drug.
You may also make adjustments to the calculated value for the "Total Quantity Required" column.</p>
<c:choose>
<c:when test="${!empty isCombinedReport}">
<table  border="1" cellspacing="2" cellpadding="3" width="100%" class="reportTablePrint">
<tr>
<td valign="middle" style="background: #DDD;text-align: center;font-size: 110%">
<c:choose>
<c:when test="${! empty isFacilityReport}">
Once you have completed this report, click the "Save" button to save this report and continue to the CDRR-OI Report.
</c:when>
<c:otherwise>
Once you have completed this report, click the "Save" button to save this report and continue to the Monthly ART Report.
</c:otherwise>
</c:choose>
</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center">
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('CDRRArtReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:when test="${! empty isFacilityReport}">
<input type="button" value="Save" onclick="saveReport('CDRRArtReport', null, true);" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRRArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
<p>type of Service provided at the facility</p>
<table border="1" cellspacing="2" cellpadding="3"  width="308" height="20">
	<tr>
		<td width="141" >ART</td>
		<td width="143">&nbsp;</td>
	</tr>
	<tr>
		<td>PMTCT</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>PEP</td>
		<td>&nbsp;</td>
	</tr>
</table>
</c:when>
<c:otherwise>
<%-- <p>After you make an entry in the "Quantity Required for NEW patients" column, the report will be saved at:<br/> <a href="file:///${fn:replace(register.reportPath,'\\','/')}">${register.reportPath}</a></p> --%>
</c:otherwise>
</c:choose>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
<tr>
<th rowspan="3">Drug Name</th>
<th rowspan="3">Basic Units</th>
<th rowspan="2">Beginning Balance</th>
<th rowspan="2">Quantity Received this period</th>
<th rowspan="2">Total Quantity dispensed this period</th>
<th rowspan="2">Losses</th> 
<th rowspan="2"> positive Adjustments</th>
<th rowspan="2">Negative Adjustments</th>
<th rowspan="2">End of Month Physical Count</th>
<th colspan="2">Drugs with less than 6 months to expiry</th>
<th rowspan="2">Days out of stock</th>
<th rowspan="2" title="Quantity for Re-supply(I) = 3 * Total Dispensed(C) - Current Balance(G)" >Quantity required for Re-supply</th>
</tr>
<tr>
<td>Quantity</td>
<td>Expiry Date</td>
</tr>
<tr>
<th>A</th>
<th>B</th>
<th>C</th>
<th>D</th>
<th>E</th>
<th>F</th>
<th>G = A+B-C-D+E-F</th>
<th>&nbsp;</th>
<th>&nbsp;</th>
<th>G</th>
<th>H</th>
</tr>
<%--<c:choose>
 <c:when test="${! empty dynamicReport}">
    <c:forEach items="${register.drugReportList}" var="drug">
    <tr>
        <c:url value="reports/stockChanges.do" var="stock_control">
			<c:param name="siteId" value="${siteId}"/>
			<c:param name="beginDate" value="${register.beginDate}"/>
			<c:param name="endDate" value="${register.endDate}"/>
			<c:param name="itemId" value="${drug.id}"/>
		</c:url>
		<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${drug.name}</a></td>
		<td>${drug.item.unit}</td>
		<td align="center">${drug.balanceBF}</td>
		<td align="center">${drug.received}</td>
		<td align="center">${drug.totalDispensed}</td>
		<td align="center">${drug.losses}</td>
		<td align="center">${drug.posAdjustments}</td>
		<td align="center">${drug.negAdjustments}</td>
		<td align="center">${drug.onHand}</td>
		<td align="center">${drug.quantity6MonthsExpired}</td>
		<td align="center">${drug.expiryDate}</td>
		<td align="center">${drug.daysOutOfStock}</td>
		<td align="center">${drug.quantityRequiredResupply}</td>
		
    </tr>
    </c:forEach>
</c:when>
<c:otherwise> --%>
<tr>
<th colspan="15">Adult Preparations</th>
</tr>
<tr>
<th colspan="15">Fixed Dose Combination drugs (FDCs)</th>
</tr>

<c:forEach items="${register.stockReportMap}" var="stockReportMapItem">
<c:set var="stockReport" value="${stockReportMapItem.value}" />
<c:if test="${stockReport.displayCategory == 'stock_adultFDC'}">
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${stockReport.id}"/>
</c:url>
<tr>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${stockReport.name}</a></td>
	<td>${stockReport.units}</td>
	<td align="center">${stockReport.balanceBF}</td>
	<td align="center">${stockReport.received}</td>
	<td align="center">${stockReport.totalDispensed}</td>
	<td align="center">${stockReport.losses}</td>
	<td align="center">${stockReport.posAdjustments}</td>
	<td align="center">${stockReport.negAdjustments}</td>
	<td align="center">${stockReport.balanceCF}</td>
	<td align="center">${stockReport.quantity6MonthsExpired}</td>
	<td align="center">${stockReport.expiryDate}</td>
	<td align="center">${stockReport.daysOutOfStock}</td>
	<td align="center">${stockReport.quantityRequiredResupply}</td>
</tr>
</c:if>
</c:forEach>

<tr>
<th colspan="15">Single Drugs</th>
</tr>

<c:forEach items="${register.stockReportMap}" var="stockReportMapItem">
<c:set var="stockReport" value="${stockReportMapItem.value}" />
<c:if test="${stockReport.displayCategory == 'stock_adultSD'}">
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${stockReport.id}"/>
</c:url>
<tr>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${stockReport.name}</a></td>
	<td>${stockReport.units}</td>
	<td align="center">${stockReport.balanceBF}</td>
	<td align="center">${stockReport.received}</td>
	<td align="center">${stockReport.totalDispensed}</td>
	<td align="center">${stockReport.losses}</td>
	<td align="center">${stockReport.posAdjustments}</td>
	<td align="center">${stockReport.negAdjustments}</td>
	<td align="center">${stockReport.balanceCF}</td>
	<td align="center">${stockReport.quantity6MonthsExpired}</td>
	<td align="center">${stockReport.expiryDate}</td>
	<td align="center">${stockReport.daysOutOfStock}</td>
	<td align="center">${stockReport.quantityRequiredResupply}</td>
</tr>
</c:if>
</c:forEach>

<tr>
<th colspan="15">Paediatric Preparations 1</th>
</tr>
<c:forEach items="${register.stockReportMap}" var="stockReportMapItem">
<c:set var="stockReport" value="${stockReportMapItem.value}" />
<c:if test="${stockReport.displayCategory == 'stock_paed1'}">
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${stockReport.id}"/>
</c:url>
<tr>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${stockReport.name}</a></td>
	<td>${stockReport.units}</td>
	<td align="center">${stockReport.balanceBF}</td>
	<td align="center">${stockReport.received}</td>
	<td align="center">${stockReport.totalDispensed}</td>
	<td align="center">${stockReport.losses}</td>
	<td align="center">${stockReport.posAdjustments}</td>
	<td align="center">${stockReport.negAdjustments}</td>
	<td align="center">${stockReport.balanceCF}</td>
	<td align="center">${stockReport.quantity6MonthsExpired}</td>
	<td align="center">${stockReport.expiryDate}</td>
	<td align="center">${stockReport.daysOutOfStock}</td>
	<td align="center">${stockReport.quantityRequiredResupply}</td>
	
</tr>
</c:if>
</c:forEach>

<%--Commenting out paeds2 --%>

<%-- 
<tr>
<th colspan="15">Paediatric Preparations 2</th>
</tr>
<c:forEach items="${register.stockReportMap}" var="stockReportMapItem">
<c:set var="stockReport" value="${stockReportMapItem.value}" />
<c:if test="${stockReport.displayCategory == 'stock_paed2'}">
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${stockReport.id}"/>
</c:url>
<tr>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${stockReport.name}</a></td>
	<td>${stockReport.units}</td>
	<td align="center">${stockReport.balanceBF}</td>
	<td align="center">${stockReport.received}</td>
	<td align="center">${stockReport.totalDispensed}</td>
	<td align="center">${stockReport.losses}</td>
	<td align="center">${stockReport.posAdjustments}</td>
	<td align="center">${stockReport.negAdjustments}</td>
	<td align="center">${stockReport.balanceCF}</td>
	<td align="center">${stockReport.quantity6MonthsExpired}</td>
	<td align="center">${stockReport.expiryDate}</td>
	<td align="center">${stockReport.daysOutOfStock}</td>
	<td align="center">${stockReport.quantityRequiredResupply}</td>
</tr>

</c:if>
</c:forEach> 
--%>
<tr>
<th colspan="15">Drugs for OIs</th>
</tr>
<c:forEach items="${register.stockReportMap}" var="stockReportMapItem">
<c:set var="stockReport" value="${stockReportMapItem.value}" />
<c:if test="${stockReport.displayCategory == 'stock_oi'}">
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${stockReport.id}"/>
</c:url>
<tr>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${stockReport.name}</a></td>
	<td>${stockReport.units}</td>
	<td align="center">${stockReport.balanceBF}</td>
	<td align="center">${stockReport.received}</td>
	<td align="center">${stockReport.totalDispensed}</td>
	<td align="center">${stockReport.losses}</td>
	<td align="center">${stockReport.posAdjustments}</td>
	<td align="center">${stockReport.negAdjustments}</td>
	<td align="center">${stockReport.balanceCF}</td>
	<td align="center">${stockReport.quantity6MonthsExpired}</td>
	<td align="center">${stockReport.expiryDate}</td>
	<td align="center">${stockReport.daysOutOfStock}</td>
	<td align="center">${stockReport.quantityRequiredResupply}</td>
</tr>

</c:if>
</c:forEach>



<%--
</c:otherwise>
</c:choose>
 <tr>
<th colspan="15">Other Preparations</th>
</tr>
<c:forEach items="${register.drugReportList}" var="drug">
    <tr>
        <c:url value="reports/stockChanges.do" var="stock_control">
			<c:param name="siteId" value="${siteId}"/>
			<c:param name="beginDate" value="${register.beginDate}"/>
			<c:param name="endDate" value="${register.endDate}"/>
			<c:param name="itemId" value="${drug.id}"/>
		</c:url>
		<td><a href='<c:out value="/${appName}/${stock_control}"/>'>${drug.name}</a></td>
		<td>${drug.item.unit}</td>
		<td align="center">${drug.balanceBF}</td>
		<td align="center">${drug.received}</td>
		<td align="center">${drug.totalDispensed}</td>
		<td align="center">${drug.losses}</td>
		<td align="center">${drug.posAdjustments}</td>
		<td align="center">${drug.negAdjustments}</td>
		<td align="center">${drug.onHand}</td>
		<td align="center">${drug.quantity6MonthsExpired}</td>
		<td align="center">${drug.expiryDate}</td>
		<td align="center">${drug.daysOutOfStock}</td>
		<td align="center">${drug.quantityRequiredResupply}</td>
		<td align="center" ondblclick="callDynamicReportWidget('quantityRequiredNewPatients.drug${drug.id}', 'CDRRArtReport')" class="reportInput">
		<span id="value.quantityRequiredNewPatients.drug${drug.id}">${drug.quantityRequiredNewPatients}</span>
		<span id="widget.quantityRequiredNewPatients.drug${drug.id}"></span>
		</td>
		<td align="center" ondblclick="callDynamicReportWidget('totalQuantityRequired.drug${drug.id}', 'CDRRArtReport')" class="reportInput">
		<span id="value.totalQuantityRequired.drug${drug.id}">${drug.totalQuantityRequired}</span>
		<span id="widget.totalQuantityRequired.drug${drug.id}"></span>
		</td>
    </tr>
    </c:forEach> --%>

</table>
<p>&nbsp;</p>
<table border="1" cellpadding="3" width="75%">


<tr>
	<td>Report prepared by: </td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;">&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>Designation: </td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
	<td colspan="2">&nbsp;</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>Name of Reporting officer</td>
	<td colspan="8">&nbsp;</td>
</tr>

<tr>
	<td>Contact Telephone:</td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;">&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>Date: </td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
	<td colspan="2">&nbsp;</td>
</tr>

<tr>
	<td>Report approved by: </td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;">&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>Designation: </td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
	<td colspan="2">&nbsp;</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>Head of Institution</td>
	<td colspan="8">&nbsp;</td>
</tr>

<tr>
	<td>Contact Telephone:</td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;">&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>Date: </td>
	<td>&nbsp;</td>
	<td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
	<td colspan="2">&nbsp;</td>
</tr>
</table>
<c:choose>
<c:when test="${!empty isCombinedReport}">
<table  border="1" cellspacing="2" cellpadding="3"  width="100%">
<tr>
<td valign="middle" style="background: #DDD;text-align: center;font-size: 110%">
<c:choose>
<c:when test="${! empty isFacilityReport}">
Once you have completed this report, click the "Save" button to save this report and continue to the CDRR-OI Report.
</c:when>
<c:otherwise>
Once you have completed this report, click the "Save" button to save this report and continue to the Monthly ART Report.
</c:otherwise>
</c:choose>
</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center" >
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('CDRRArtReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:when test="${! empty isFacilityReport}">
<input type="button" value="Save" onclick="saveReport('CDRRArtReport', null, true);" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRRArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
</c:choose>
</template:put>
</template:insert>

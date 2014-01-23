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

<template:put name='title' direct='true'>CDRR-OI Report for ${register.siteName}:&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='header' direct='true'>CDRR-OI Report for ${register.siteName}:&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<p>Instructions: Double-click on the field in the "Quantity Required for NEW patients" column to enter a value for the corresponding drug.
You may also make adjustments to the calculated value for the "Total Quantity Required" column.</p>
<c:choose>
<c:when test="${!empty isCombinedReport}">
<table  border="1" cellspacing="2" cellpadding="3" width="100%" class="reportTablePrint">
<tr>
<td style="background: #DDD;text-align: center;font-size: 110%">Once you have completed this report,
click the "Save" button to save this report and continue to the Monthly ART Summary Report.</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center" >
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('CDRROIReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:when test="${! empty isFacilityReport}">
<input type="button" value="Save" onclick="saveReport('CDRROIReport', null, true);" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRROIReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
</c:choose>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
<tr>
<th rowspan="3">Drug Name</th>
<th rowspan="3">Basic Units</th>
<th rowspan="2">Beginning Balance</th>
<th rowspan="2">Quantity Received this period</th>
<th rowspan="2">Total Quantity dispensed this period</th>
<th rowspan="2">Losses</th>
<th rowspan="2">Positive Adjustments</th>
<th rowspan="2">Negative Adjustments</th>
<th rowspan="2">Ending Balance / Physical Count</th>
<th colspan="2">Drugs with less than 6 months to expiry</th>
<th rowspan="2">Days out of stock</th>
<th rowspan="2" title="Quantity for Re-supply(I) = 3 * Total Dispensed(C) - Current Balance(G)" >Quantity required for Re-supply</th>
<th rowspan="2" title="Double-click on each cell in this column to enter this data. Use the number of new patients per regimen on the Monthly Patient Summary to calculate the number of patients per regimen.">Quantity Required for NEW patients</th>
<th rowspan="2">Total Quantity Required
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
<th>H</th>
<th>I</th>
<th>J</th>
<th>K</th>
</tr>
<tr>
<th colspan="15" style="text-align: left; padding-left: 3em;">Drugs for OI's</th>
</tr>

<c:forEach items="${register.stockReportMap}" var="stockReportMapItem">
<c:set var="stockReport" value="${stockReportMapItem.value}" />
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${stockReport.id}"/>
</c:url>
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
	
	<td align="center" ondblclick="callReportWidget('stockReportMap.${stockReportMapItem.key}.quantityRequiredNewPatients', 'CDRROIReport')" class="reportInput">
	<span id="value.stockReportMap.${stockReportMapItem.key}.quantityRequiredNewPatients">${stockReport.quantityRequiredNewPatients}</span>
	<span id="widget.stockReportMap.${stockReportMapItem.key}.quantityRequiredNewPatients"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('stockReportMap.${stockReportMapItem.key}.totalQuantityRequired', 'CDRROIReport')" class="reportInput">
	<span id="value.stockReportMap.${stockReportMapItem.key}.totalQuantityRequired">${stockReport.totalQuantityRequired}</span>
	<span id="widget.stockReportMap.${stockReportMapItem.key}.totalQuantityRequired"></span>
	</td>
</tr>
</c:forEach>



</table>
<c:choose>
<c:when test="${!empty isCombinedReport}">
<table  border="1" cellspacing="2" cellpadding="3" width="100%" class="reportTablePrint">
<tr>
<td style="background: #DDD;text-align: right;font-size: 110%">Once you have completed this report,
click the "Save" button to save this report and continue to the Monthly ART Summary Report.</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center" >
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('CDRROIReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:when test="${! empty isFacilityReport}">
<input type="button" value="Save" onclick="saveReport('CDRROIReport', null, true);" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRROIReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
</c:choose>
</template:put>
</template:insert>

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
<input type="button" value="Save" onclick="saveReport('CDRROIReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/></td>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRROIReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/></td>
</c:otherwise>
</c:choose>
</tr>
</table>
</c:when>
<c:otherwise>
<p>After you make an entry in the "Quantity Required for NEW patients" column, the report will be saved at:<br/> <a href="file:///${fn:replace(register.reportPath,'\\','/')}">${register.reportPath}</a></p>
</c:otherwise>
</c:choose>
<script language="javascript" type="text/javascript">
    function scrollUp() {
        var divY = document.getElementById('scrollBody').scrollTop;
        var newDivY = divY - 50;
        document.getElementById('scrollBody').scrollTop = newDivY;
    }

    function scrollDown() {
        var divY = document.getElementById('scrollBody').scrollTop;
        var newDivY = divY + 50;
        document.getElementById('scrollBody').scrollTop = newDivY;
    }
</script>

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
<th colspan="15" style="text-align: left; padding-left: 3em;">AntiFungals</th>
</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="35"/>
</c:url>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Diflucan 200mg</a></td>
	<td>Tablet</td>
	<td align="center">${register.balanceBF.diflucan200mg}</td>
	<td align="center">${register.received.diflucan200mg}</td>
	<td align="center">${register.totalDispensed.diflucan200mg}</td>
	<td align="center">${register.losses.diflucan200mg}</td>
	<td align="center">${register.posAdjustments.diflucan200mg}</td>
	<td align="center">${register.negAdjustments.diflucan200mg}</td>
	<td align="center">${register.onHand.diflucan200mg}</td>
	<td align="center">${register.quantity6MonthsExpired.diflucan200mg}</td>
	<td align="center">${register.expiryDate.diflucan200mg}</td>
	<td align="center">${register.daysOutOfStock.diflucan200mg}</td>
	<td align="center">${register.quantityRequiredResupply.diflucan200mg}</td>

	<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.diflucan200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.diflucan200mg">${register.quantityRequiredNewPatients.diflucan200mg}</span>
	<span id="widget.quantityRequiredNewPatients.diflucan200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.diflucan200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.diflucan200mg">${register.totalQuantityRequired.diflucan200mg}</span>
	<span id="widget.totalQuantityRequired.diflucan200mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="36"/>
</c:url>
<td>
<a href='<c:out value="/${appName}/${stock_control}"/>'>Diflucan suspension (bottles)</a></td>
<td></td>
<td align="center">${register.balanceBF.diflucansuspension}</td>
<td align="center">${register.received.diflucansuspension}</td>
<td align="center">${register.totalDispensed.diflucansuspension}</td>
<td align="center">${register.losses.diflucansuspension}</td>
<td align="center">${register.posAdjustments.diflucansuspension}</td>
<td align="center">${register.negAdjustments.diflucansuspension}</td>
<td align="center">${register.onHand.diflucansuspension}</td>
<td align="center">${register.quantity6MonthsExpired.diflucansuspension}</td>
<td align="center">${register.expiryDate.diflucansuspension}</td>
<td align="center">${register.daysOutOfStock.diflucansuspension}</td>
<td align="center">${register.quantityRequiredResupply.diflucansuspension}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.diflucansuspension', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.diflucansuspension">${register.quantityRequiredNewPatients.diflucansuspension}</span>
	<span id="widget.quantityRequiredNewPatients.diflucansuspension"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.diflucansuspension', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.diflucansuspension">${register.totalQuantityRequired.diflucansuspension}</span>
	<span id="widget.totalQuantityRequired.diflucansuspension"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="37"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Diflucan Infusion (bottles)</a></td>
<td></td>
<td align="center">${register.balanceBF.diflucanInfusion}</td>
<td align="center">${register.received.diflucanInfusion}</td>
<td align="center">${register.totalDispensed.diflucanInfusion}</td>
<td align="center">${register.losses.diflucanInfusion}</td>
<td align="center">${register.posAdjustments.diflucanInfusion}</td>
<td align="center">${register.negAdjustments.diflucanInfusion}</td>
<td align="center">${register.onHand.diflucanInfusion}</td>
<td align="center">${register.quantity6MonthsExpired.diflucanInfusion}</td>
<td align="center">${register.expiryDate.diflucanInfusion}</td>
<td align="center">${register.daysOutOfStock.diflucanInfusion}</td>
<td align="center">${register.quantityRequiredResupply.diflucanInfusion}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.diflucanInfusion', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.diflucanInfusion">${register.quantityRequiredNewPatients.diflucanInfusion}</span>
	<span id="widget.quantityRequiredNewPatients.diflucanInfusion"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.diflucanInfusion', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.diflucanInfusion">${register.totalQuantityRequired.diflucanInfusion}</span>
	<span id="widget.totalQuantityRequired.diflucanInfusion"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="38"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Fluconazole 200mg</a></td>
<td>Tabs/caps</td>
<td align="center">${register.balanceBF.fluconazole200mg}</td>
<td align="center">${register.received.fluconazole200mg}</td>
<td align="center">${register.totalDispensed.fluconazole200mg}</td>
<td align="center">${register.losses.fluconazole200mg}</td>
<td align="center">${register.posAdjustments.fluconazole200mg}</td>
<td align="center">${register.negAdjustments.fluconazole200mg}</td>
<td align="center">${register.onHand.fluconazole200mg}</td>
<td align="center">${register.quantity6MonthsExpired.fluconazole200mg}</td>
<td align="center">${register.expiryDate.fluconazole200mg}</td>
<td align="center">${register.daysOutOfStock.fluconazole200mg}</td>
<td align="center">${register.quantityRequiredResupply.fluconazole200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.fluconazole200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.fluconazole200mg">${register.quantityRequiredNewPatients.fluconazole200mg}</span>
	<span id="widget.quantityRequiredNewPatients.fluconazole200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.fluconazole200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.fluconazole200mg">${register.totalQuantityRequired.fluconazole200mg}</span>
	<span id="widget.totalQuantityRequired.fluconazole200mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="41"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Ketaconazole 200mg</a></td>
<td>Tablets</td>
<td align="center">${register.balanceBF.ketaconazole200mg}</td>
<td align="center">${register.received.ketaconazole200mg}</td>
<td align="center">${register.totalDispensed.ketaconazole200mg}</td>
<td align="center">${register.losses.ketaconazole200mg}</td>
<td align="center">${register.posAdjustments.ketaconazole200mg}</td>
<td align="center">${register.negAdjustments.ketaconazole200mg}</td>
<td align="center">${register.onHand.ketaconazole200mg}</td>
<td align="center">${register.quantity6MonthsExpired.ketaconazole200mg}</td>
<td align="center">${register.expiryDate.ketaconazole200mg}</td>
<td align="center">${register.daysOutOfStock.ketaconazole200mg}</td>
<td align="center">${register.quantityRequiredResupply.ketaconazole200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.ketaconazole200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.ketaconazole200mg">${register.quantityRequiredNewPatients.ketaconazole200mg}</span>
	<span id="widget.quantityRequiredNewPatients.ketaconazole200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.ketaconazole200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.ketaconazole200mg">${register.totalQuantityRequired.ketaconazole200mg}</span>
	<span id="widget.totalQuantityRequired.ketaconazole200mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="42"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Miconazole Nitrate 2% Oral Gel</a></td>
<td>Tube</td>
<td align="center">${register.balanceBF.miconazoleNitrate2OralGel}</td>
<td align="center">${register.received.miconazoleNitrate2OralGel}</td>
<td align="center">${register.totalDispensed.miconazoleNitrate2OralGel}</td>
<td align="center">${register.losses.miconazoleNitrate2OralGel}</td>
<td align="center">${register.posAdjustments.miconazoleNitrate2OralGel}</td>
<td align="center">${register.negAdjustments.miconazoleNitrate2OralGel}</td>
<td align="center">${register.onHand.miconazoleNitrate2OralGel}</td>
<td align="center">${register.quantity6MonthsExpired.miconazoleNitrate2OralGel}</td>
<td align="center">${register.expiryDate.miconazoleNitrate2OralGel}</td>
<td align="center">${register.daysOutOfStock.miconazoleNitrate2OralGel}</td>
<td align="center">${register.quantityRequiredResupply.miconazoleNitrate2OralGel}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.miconazoleNitrate2OralGel', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.miconazoleNitrate2OralGel">${register.quantityRequiredNewPatients.miconazoleNitrate2OralGel}</span>
	<span id="widget.quantityRequiredNewPatients.miconazoleNitrate2OralGel"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.miconazoleNitrate2OralGel', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.miconazoleNitrate2OralGel">${register.totalQuantityRequired.miconazoleNitrate2OralGel}</span>
	<span id="widget.totalQuantityRequired.miconazoleNitrate2OralGel"></span>
	</td>

</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="43"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Nystatin Oral Suspension 100,000 Units
</a></td>
<td></td>
<td align="center">${register.balanceBF.nystatinOralSuspension100000Units}</td>
<td align="center">${register.received.nystatinOralSuspension100000Units}</td>
<td align="center">${register.totalDispensed.nystatinOralSuspension100000Units}</td>
<td align="center">${register.losses.nystatinOralSuspension100000Units}</td>
<td align="center">${register.posAdjustments.nystatinOralSuspension100000Units}</td>
<td align="center">${register.negAdjustments.nystatinOralSuspension100000Units}</td>
<td align="center">${register.onHand.nystatinOralSuspension100000Units}</td>
<td align="center">${register.quantity6MonthsExpired.nystatinOralSuspension100000Units}</td>
<td align="center">${register.expiryDate.nystatinOralSuspension100000Units}</td>
<td align="center">${register.daysOutOfStock.nystatinOralSuspension100000Units}</td>
<td align="center">${register.quantityRequiredResupply.nystatinOralSuspension100000Units}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.nystatinOralSuspension100000Units', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.nystatinOralSuspension100000Units">${register.quantityRequiredNewPatients.nystatinOralSuspension100000Units}</span>
	<span id="widget.quantityRequiredNewPatients.nystatinOralSuspension100000Units"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.nystatinOralSuspension100000Units', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.nystatinOralSuspension100000Units">${register.totalQuantityRequired.nystatinOralSuspension100000Units}</span>
	<span id="widget.totalQuantityRequired.nystatinOralSuspension100000Units"></span>
	</td>

</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="44"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Amphotericin B Injection</a></td>
<td>Vials</td>
<td align="center">${register.balanceBF.amphotericinBInjection}</td>
<td align="center">${register.received.amphotericinBInjection}</td>
<td align="center">${register.totalDispensed.amphotericinBInjection}</td>
<td align="center">${register.losses.amphotericinBInjection}</td>
<td align="center">${register.posAdjustments.amphotericinBInjection}</td>
<td align="center">${register.negAdjustments.amphotericinBInjection}</td>
<td align="center">${register.onHand.amphotericinBInjection}</td>
<td align="center">${register.quantity6MonthsExpired.amphotericinBInjection}</td>
<td align="center">${register.expiryDate.amphotericinBInjection}</td>
<td align="center">${register.daysOutOfStock.amphotericinBInjection}</td>
<td align="center">${register.quantityRequiredResupply.amphotericinBInjection}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.amphotericinBInjection', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.amphotericinBInjection">${register.quantityRequiredNewPatients.amphotericinBInjection}</span>
	<span id="widget.quantityRequiredNewPatients.amphotericinBInjection"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.amphotericinBInjection', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.amphotericinBInjection">${register.totalQuantityRequired.amphotericinBInjection}</span>
	<span id="widget.totalQuantityRequired.amphotericinBInjection"></span>
	</td>

</tr>

<tr>
<th colspan="15" style="text-align: left; padding-left: 3em;">AntiBacterials
</th>
</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="45"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Cotrimoxazole susp 240mg/5ml (bottles)</a></td>
<td></td>
<td align="center">${register.balanceBF.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.received.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.totalDispensed.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.losses.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.posAdjustments.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.negAdjustments.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.onHand.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.quantity6MonthsExpired.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.expiryDate.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.daysOutOfStock.cotrimoxazolesusp240mg_5ml}</td>
<td align="center">${register.quantityRequiredResupply.cotrimoxazolesusp240mg_5ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.cotrimoxazolesusp240mg_5ml', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.cotrimoxazolesusp240mg_5ml">${register.quantityRequiredNewPatients.cotrimoxazolesusp240mg_5ml}</span>
	<span id="widget.quantityRequiredNewPatients.cotrimoxazolesusp240mg_5ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.cotrimoxazolesusp240mg_5ml', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.cotrimoxazolesusp240mg_5ml">${register.totalQuantityRequired.cotrimoxazolesusp240mg_5ml}</span>
	<span id="widget.totalQuantityRequired.cotrimoxazolesusp240mg_5ml"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="174"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Cotrimoxazole 480mg</a></td>
<td>Tablets</td>
<td align="center">${register.balanceBF.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.received.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.totalDispensed.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.losses.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.posAdjustments.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.negAdjustments.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.onHand.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.quantity6MonthsExpired.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.expiryDate.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.daysOutOfStock.cotrimoxazoleTabs480mg}</td>
<td align="center">${register.quantityRequiredResupply.cotrimoxazoleTabs480mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.cotrimoxazoleTabs480mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.cotrimoxazoleTabs480mg">${register.quantityRequiredNewPatients.cotrimoxazoleTabs480mg}</span>
	<span id="widget.quantityRequiredNewPatients.cotrimoxazoleTabs480mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.cotrimoxazoleTabs480mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.cotrimoxazoleTabs480mg">${register.totalQuantityRequired.cotrimoxazoleTabs480mg}</span>
	<span id="widget.totalQuantityRequired.cotrimoxazoleTabs480mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="46"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Cotrimoxazole DS 960mg</a></td>
<td>Tablets</td>
<td align="center">${register.balanceBF.cotrimoxazoleDS960mg}</td>
<td align="center">${register.received.cotrimoxazoleDS960mg}</td>
<td align="center">${register.totalDispensed.cotrimoxazoleDS960mg}</td>
<td align="center">${register.losses.cotrimoxazoleDS960mg}</td>
<td align="center">${register.posAdjustments.cotrimoxazoleDS960mg}</td>
<td align="center">${register.negAdjustments.cotrimoxazoleDS960mg}</td>
<td align="center">${register.onHand.cotrimoxazoleDS960mg}</td>
<td align="center">${register.quantity6MonthsExpired.cotrimoxazoleDS960mg}</td>
<td align="center">${register.expiryDate.cotrimoxazoleDS960mg}</td>
<td align="center">${register.daysOutOfStock.cotrimoxazoleDS960mg}</td>
<td align="center">${register.quantityRequiredResupply.cotrimoxazoleDS960mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.cotrimoxazoleDS960mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.cotrimoxazoleDS960mg">${register.quantityRequiredNewPatients.cotrimoxazoleDS960mg}</span>
	<span id="widget.quantityRequiredNewPatients.cotrimoxazoleDS960mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.cotrimoxazoleDS960mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.cotrimoxazoleDS960mg">${register.totalQuantityRequired.cotrimoxazoleDS960mg}</span>
	<span id="widget.totalQuantityRequired.cotrimoxazoleDS960mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="47"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Ciprofloxacin Tabs 500mg</a></td>
<td>Tabs/caps</td>
<td align="center">${register.balanceBF.ciprofloxacinTabs500mg}</td>
<td align="center">${register.received.ciprofloxacinTabs500mg}</td>
<td align="center">${register.totalDispensed.ciprofloxacinTabs500mg}</td>
<td align="center">${register.losses.ciprofloxacinTabs500mg}</td>
<td align="center">${register.posAdjustments.ciprofloxacinTabs500mg}</td>
<td align="center">${register.negAdjustments.ciprofloxacinTabs500mg}</td>
<td align="center">${register.onHand.ciprofloxacinTabs500mg}</td>
<td align="center">${register.quantity6MonthsExpired.ciprofloxacinTabs500mg}</td>
<td align="center">${register.expiryDate.ciprofloxacinTabs500mg}</td>
<td align="center">${register.daysOutOfStock.ciprofloxacinTabs500mg}</td>
<td align="center">${register.quantityRequiredResupply.ciprofloxacinTabs500mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.ciprofloxacinTabs500mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.ciprofloxacinTabs500mg">${register.quantityRequiredNewPatients.ciprofloxacinTabs500mg}</span>
	<span id="widget.quantityRequiredNewPatients.ciprofloxacinTabs500mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.ciprofloxacinTabs500mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.ciprofloxacinTabs500mg">${register.totalQuantityRequired.ciprofloxacinTabs500mg}</span>
	<span id="widget.totalQuantityRequired.ciprofloxacinTabs500mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="48"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Ceftriaxone Inj. 250mg IM</a></td>
<td>Vials</td>
<td align="center">${register.balanceBF.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.received.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.totalDispensed.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.losses.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.posAdjustments.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.negAdjustments.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.onHand.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.quantity6MonthsExpired.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.expiryDate.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.daysOutOfStock.ceftriaxoneInj250mgIM}</td>
<td align="center">${register.quantityRequiredResupply.ceftriaxoneInj250mgIM}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.ceftriaxoneInj250mgIM', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.ceftriaxoneInj250mgIM">${register.quantityRequiredNewPatients.ceftriaxoneInj250mgIM}</span>
	<span id="widget.quantityRequiredNewPatients.ceftriaxoneInj250mgIM"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.ceftriaxoneInj250mgIM', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.ceftriaxoneInj250mgIM">${register.totalQuantityRequired.ceftriaxoneInj250mgIM}</span>
	<span id="widget.totalQuantityRequired.ceftriaxoneInj250mgIM"></span>
	</td>

</tr>

<tr>
	<th colspan="15" style="text-align: left; padding-left: 3em;">AntiProtozoal Drugs</th>
</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="49"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Aminosidine Sulphate liquid (bottles)</a></td>
<td></td>
<td align="center">${register.balanceBF.aminosidineSulphateliquid}</td>
<td align="center">${register.received.aminosidineSulphateliquid}</td>
<td align="center">${register.totalDispensed.aminosidineSulphateliquid}</td>
<td align="center">${register.losses.aminosidineSulphateliquid}</td>
<td align="center">${register.posAdjustments.aminosidineSulphateliquid}</td>
<td align="center">${register.negAdjustments.aminosidineSulphateliquid}</td>
<td align="center">${register.onHand.aminosidineSulphateliquid}</td>
<td align="center">${register.quantity6MonthsExpired.aminosidineSulphateliquid}</td>
<td align="center">${register.expiryDate.aminosidineSulphateliquid}</td>
<td align="center">${register.daysOutOfStock.aminosidineSulphateliquid}</td>
<td align="center">${register.quantityRequiredResupply.aminosidineSulphateliquid}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.aminosidineSulphateliquid', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.aminosidineSulphateliquid">${register.quantityRequiredNewPatients.aminosidineSulphateliquid}</span>
	<span id="widget.quantityRequiredNewPatients.aminosidineSulphateliquid"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.aminosidineSulphateliquid', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.aminosidineSulphateliquid">${register.totalQuantityRequired.aminosidineSulphateliquid}</span>
	<span id="widget.totalQuantityRequired.aminosidineSulphateliquid"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="50"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Aminosidine Sulphate</a></td>
<td></td>
<td align="center">${register.balanceBF.aminosidineSulphate}</td>
<td align="center">${register.received.aminosidineSulphate}</td>
<td align="center">${register.totalDispensed.aminosidineSulphate}</td>
<td align="center">${register.losses.aminosidineSulphate}</td>
<td align="center">${register.posAdjustments.aminosidineSulphate}</td>
<td align="center">${register.negAdjustments.aminosidineSulphate}</td>
<td align="center">${register.onHand.aminosidineSulphate}</td>
<td align="center">${register.quantity6MonthsExpired.aminosidineSulphate}</td>
<td align="center">${register.expiryDate.aminosidineSulphate}</td>
<td align="center">${register.daysOutOfStock.aminosidineSulphate}</td>
<td align="center">${register.quantityRequiredResupply.aminosidineSulphate}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.aminosidineSulphate', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.aminosidineSulphate">${register.quantityRequiredNewPatients.aminosidineSulphate}</span>
	<span id="widget.quantityRequiredNewPatients.aminosidineSulphate"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.aminosidineSulphate', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.aminosidineSulphate">${register.totalQuantityRequired.aminosidineSulphate}</span>
	<span id="widget.totalQuantityRequired.aminosidineSulphate"></span>
	</td>

</tr>

<tr>
	<th colspan="15" style="text-align: left; padding-left: 3em;">AntiVirals </th>
</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="51"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Acyclovir 200mg</a></td>
<td>Tablets</td>
<td align="center">${register.balanceBF.acyclovir200mg}</td>
<td align="center">${register.received.acyclovir200mg}</td>
<td align="center">${register.totalDispensed.acyclovir200mg}</td>
<td align="center">${register.losses.acyclovir200mg}</td>
<td align="center">${register.posAdjustments.acyclovir200mg}</td>
<td align="center">${register.negAdjustments.acyclovir200mg}</td>
<td align="center">${register.onHand.acyclovir200mg}</td>
<td align="center">${register.quantity6MonthsExpired.acyclovir200mg}</td>
<td align="center">${register.expiryDate.acyclovir200mg}</td>
<td align="center">${register.daysOutOfStock.acyclovir200mg}</td>
<td align="center">${register.quantityRequiredResupply.acyclovir200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.acyclovir200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.acyclovir200mg">${register.quantityRequiredNewPatients.acyclovir200mg}</span>
	<span id="widget.quantityRequiredNewPatients.acyclovir200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.acyclovir200mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.acyclovir200mg">${register.totalQuantityRequired.acyclovir200mg}</span>
	<span id="widget.totalQuantityRequired.acyclovir200mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="52"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Acyclovir IV Infusion</a></td>
<td>Vials</td>
<td align="center">${register.balanceBF.acyclovirIVInfusion}</td>
<td align="center">${register.received.acyclovirIVInfusion}</td>
<td align="center">${register.totalDispensed.acyclovirIVInfusion}</td>
<td align="center">${register.losses.acyclovirIVInfusion}</td>
<td align="center">${register.posAdjustments.acyclovirIVInfusion}</td>
<td align="center">${register.negAdjustments.acyclovirIVInfusion}</td>
<td align="center">${register.onHand.acyclovirIVInfusion}</td>
<td align="center">${register.quantity6MonthsExpired.acyclovirIVInfusion}</td>
<td align="center">${register.expiryDate.acyclovirIVInfusion}</td>
<td align="center">${register.daysOutOfStock.acyclovirIVInfusion}</td>
<td align="center">${register.quantityRequiredResupply.acyclovirIVInfusion}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.acyclovirIVInfusion', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.acyclovirIVInfusion">${register.quantityRequiredNewPatients.acyclovirIVInfusion}</span>
	<span id="widget.quantityRequiredNewPatients.acyclovirIVInfusion"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.acyclovirIVInfusion', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.acyclovirIVInfusion">${register.totalQuantityRequired.acyclovirIVInfusion}</span>
	<span id="widget.totalQuantityRequired.acyclovirIVInfusion"></span>
	</td>

</tr>

<tr>
	<th colspan="15" style="text-align: left; padding-left: 3em;">Others</th>
</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId"  value="53"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Pyridoxine 25mg</a></td>
<td>Tabs/caps</td>
<td align="center">${register.balanceBF.pyridoxine25mg}</td>
<td align="center">${register.received.pyridoxine25mg}</td>
<td align="center">${register.totalDispensed.pyridoxine25mg}</td>
<td align="center">${register.losses.pyridoxine25mg}</td>
<td align="center">${register.posAdjustments.pyridoxine25mg}</td>
<td align="center">${register.negAdjustments.pyridoxine25mg}</td>
<td align="center">${register.onHand.pyridoxine25mg}</td>
<td align="center">${register.quantity6MonthsExpired.pyridoxine25mg}</td>
<td align="center">${register.expiryDate.pyridoxine25mg}</td>
<td align="center">${register.daysOutOfStock.pyridoxine25mg}</td>
<td align="center">${register.quantityRequiredResupply.pyridoxine25mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.pyridoxine25mg', 'CDRROIReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.pyridoxine25mg">${register.quantityRequiredNewPatients.pyridoxine25mg}</span>
	<span id="widget.quantityRequiredNewPatients.pyridoxine25mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.pyridoxine25mg', 'CDRROIReport')" class="reportInput">
	<span id="value.totalQuantityRequired.pyridoxine25mg">${register.totalQuantityRequired.pyridoxine25mg}</span>
	<span id="widget.totalQuantityRequired.pyridoxine25mg"></span>
	</td>
</tr>
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
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRROIReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
<c:otherwise>
<p>After you make an entry in the "Quantity Required for NEW patients" column, the report will be saved at:<br/> ${register.reportPath}</p>
</c:otherwise>
</c:choose>
</template:put>
</template:insert>

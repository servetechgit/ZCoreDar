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
<td valign="middle" style="background: #DDD;text-align: center;font-size: 110%">Once you have completed this report, click the "Save" button to save this report and continue to the CDRR-OI Report.</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center">
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('CDRRArtReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRRArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
<c:otherwise>
<p>After you make an entry in the "Quantity Required for NEW patients" column, the report will be saved at:<br/> <a href="file:///${fn:replace(register.reportPath,'\\','/')}">${register.reportPath}</a></p>
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
<th rowspan="2">Positive Adjustments</th>
<th rowspan="2">Negative Adjustments</th>
<th rowspan="2">Ending Balance / Physical Count</th>
<th colspan="2">Drugs with less than 6 months to expiry</th>
<th rowspan="2">Days out of stock</th>
<th rowspan="2" title="Quantity for Re-supply(I) = 3 * Total Dispensed(C) - Current Balance(G)" >Quantity required for Re-supply</th>
<th rowspan="2" title="Double-click on each cell in this column to enter this data. Use the number of new patients per regimen on the Monthly Patient Summary to calculate the number of patients per regimen.">Quantity Required for NEW patients</th>
<th rowspan="2" >Total Quantity Required
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
<c:choose>
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
		<td align="center" ondblclick="callDynamicReportWidget('quantityRequiredNewPatients.drug${drug.id}', 'CDRRArtReport')" class="reportInput">
		<span id="value.quantityRequiredNewPatients.drug${drug.id}">${drug.quantityRequiredNewPatients}</span>
		<span id="widget.quantityRequiredNewPatients.drug${drug.id}"></span>
		</td>
		<td align="center" ondblclick="callDynamicReportWidget('totalQuantityRequired.drug${drug.id}', 'CDRRArtReport')" class="reportInput">
		<span id="value.totalQuantityRequired.drug${drug.id}">${drug.totalQuantityRequired}</span>
		<span id="widget.totalQuantityRequired.drug${drug.id}"></span>
		</td>
    </tr>
    </c:forEach>
</c:when>
<c:otherwise>
<tr>
<th colspan="15">Adult Preparations</th>
</tr>
<tr>
<th colspan="15">Fixed Dose Combination drugs (FDCs)</th>
</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="1"/>
</c:url>
	<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine/Lamivudine FDC<br/>
	(30/150mg)</a></td>
	<td>Tablet</td>
	<td align="center">${register.balanceBF.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.received.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.totalDispensed.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.losses.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.posAdjustments.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.negAdjustments.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.onHand.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.quantity6MonthsExpired.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.expiryDate.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.daysOutOfStock.stavudine_LamivudineFDCTabs_30_150mg}</td>
	<td align="center">${register.quantityRequiredResupply.stavudine_LamivudineFDCTabs_30_150mg}</td>

	<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_30_150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_30_150mg">${register.quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_30_150mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_30_150mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_LamivudineFDCTabs_30_150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_LamivudineFDCTabs_30_150mg">${register.totalQuantityRequired.stavudine_LamivudineFDCTabs_30_150mg}</span>
	<span id="widget.totalQuantityRequired.stavudine_LamivudineFDCTabs_30_150mg"></span>
	</td>
</tr>
<%--
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="2"/>
</c:url>
<td>
<a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine/Lamivudine FDC<br />
(40/150mg)</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.received.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.totalDispensed.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.losses.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.posAdjustments.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.negAdjustments.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.onHand.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.expiryDate.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.daysOutOfStock.stavudine_LamivudineFDCTabs_40_150mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudine_LamivudineFDCTabs_40_150mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_40_150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_40_150mg">${register.quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_40_150mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_LamivudineFDCTabs_40_150mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_LamivudineFDCTabs_40_150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_LamivudineFDCTabs_40_150mg">${register.totalQuantityRequired.stavudine_LamivudineFDCTabs_40_150mg}</span>
	<span id="widget.totalQuantityRequired.stavudine_LamivudineFDCTabs_40_150mg"></span>
	</td>

</tr>
--%>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="3"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine/Lamivudine/Nevirapine<br/>
FDC (30/150/200mg)</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.received.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.totalDispensed.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.losses.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.posAdjustments.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.negAdjustments.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.onHand.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.expiryDate.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.daysOutOfStock.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg">${register.quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg">${register.totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</span>
	<span id="widget.totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg"></span>
	</td>

</tr>
<%--
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="4"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine/Lamivudine/Nevirapine<br />
FDC (40/150/200mg)</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.received.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.totalDispensed.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.losses.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.posAdjustments.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.negAdjustments.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.onHand.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.expiryDate.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.daysOutOfStock.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg">${register.quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg">${register.totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</span>
	<span id="widget.totalQuantityRequired.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg"></span>
	</td>

</tr>
--%>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="5"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Zidovudine/Lamivudine<br />
FDC (300/150mg)</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.received.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.totalDispensed.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.losses.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.posAdjustments.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.negAdjustments.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.onHand.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.quantity6MonthsExpired.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.expiryDate.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.daysOutOfStock.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
<td align="center">${register.quantityRequiredResupply.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.zidovudine_LamivudineTabs_capsFDC_300_150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.zidovudine_LamivudineTabs_capsFDC_300_150mg">${register.quantityRequiredNewPatients.zidovudine_LamivudineTabs_capsFDC_300_150mg}</span>
	<span id="widget.quantityRequiredNewPatients.zidovudine_LamivudineTabs_capsFDC_300_150mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.zidovudine_LamivudineTabs_capsFDC_300_150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.zidovudine_LamivudineTabs_capsFDC_300_150mg">${register.totalQuantityRequired.zidovudine_LamivudineTabs_capsFDC_300_150mg}</span>
	<span id="widget.totalQuantityRequired.zidovudine_LamivudineTabs_capsFDC_300_150mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="6"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Zidovudine/Lamivudine/Nevirapine<br />
FDC (300/150/200mg)</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.received.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.totalDispensed.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.losses.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.posAdjustments.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.negAdjustments.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.onHand.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.quantity6MonthsExpired.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.expiryDate.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.daysOutOfStock.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
<td align="center">${register.quantityRequiredResupply.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg">${register.quantityRequiredNewPatients.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</span>
	<span id="widget.quantityRequiredNewPatients.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg">${register.totalQuantityRequired.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</span>
	<span id="widget.totalQuantityRequired.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg"></span>
	</td>

</tr>
<tr>
<th colspan="15">Fixed Dose Combination drugs (FDCs)</th>
</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="7"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Abacavir 300mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.abacavirTabs300mg}</td>
<td align="center">${register.received.abacavirTabs300mg}</td>
<td align="center">${register.totalDispensed.abacavirTabs300mg}</td>
<td align="center">${register.losses.abacavirTabs300mg}</td>
<td align="center">${register.posAdjustments.abacavirTabs300mg}</td>
<td align="center">${register.negAdjustments.abacavirTabs300mg}</td>
<td align="center">${register.onHand.abacavirTabs300mg}</td>
<td align="center">${register.quantity6MonthsExpired.abacavirTabs300mg}</td>
<td align="center">${register.expiryDate.abacavirTabs300mg}</td>
<td align="center">${register.daysOutOfStock.abacavirTabs300mg}</td>
<td align="center">${register.quantityRequiredResupply.abacavirTabs300mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.abacavirTabs300mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.abacavirTabs300mg">${register.quantityRequiredNewPatients.abacavirTabs300mg}</span>
	<span id="widget.quantityRequiredNewPatients.abacavirTabs300mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.abacavirTabs300mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.abacavirTabs300mg">${register.totalQuantityRequired.abacavirTabs300mg}</span>
	<span id="widget.totalQuantityRequired.abacavirTabs300mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${register.totalDispensed.didanosine400mgItemId}"/>
	<c:param name="code" value="ddl400"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine 400mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosine400mg}</td>
<td align="center">${register.received.didanosine400mg}</td>
<td align="center">${register.totalDispensed.didanosine400mg}</td>
<td align="center">${register.losses.didanosine400mg}</td>
<td align="center">${register.posAdjustments.didanosine400mg}</td>
<td align="center">${register.negAdjustments.didanosine400mg}</td>
<td align="center">${register.onHand.didanosine400mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosine400mg}</td>
<td align="center">${register.expiryDate.didanosine400mg}</td>
<td align="center">${register.daysOutOfStock.didanosine400mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosine400mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosine400mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosine400mg">${register.quantityRequiredNewPatients.didanosine400mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosine400mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosine400mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosine400mg">${register.totalQuantityRequired.didanosine400mg}</span>
	<span id="widget.totalQuantityRequired.didanosine400mg"></span>
	</td>

</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${register.totalDispensed.didanosine250mgItemId}"/>
	<c:param name="code" value="ddl250"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine 250mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosine250mg}</td>
<td align="center">${register.received.didanosine250mg}</td>
<td align="center">${register.totalDispensed.didanosine250mg}</td>
<td align="center">${register.losses.didanosine250mg}</td>
<td align="center">${register.posAdjustments.didanosine250mg}</td>
<td align="center">${register.negAdjustments.didanosine250mg}</td>
<td align="center">${register.onHand.didanosine250mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosine250mg}</td>
<td align="center">${register.expiryDate.didanosine250mg}</td>
<td align="center">${register.daysOutOfStock.didanosine250mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosine250mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosine250mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosine250mg">${register.quantityRequiredNewPatients.didanosine250mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosine250mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosine250mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosine250mg">${register.totalQuantityRequired.didanosine250mg}</span>
	<span id="widget.totalQuantityRequired.didanosine250mg"></span>
	</td>

</tr>
<%--
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="9"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine 200mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosineTabs200mg}</td>
<td align="center">${register.received.didanosineTabs200mg}</td>
<td align="center">${register.totalDispensed.didanosineTabs200mg}</td>
<td align="center">${register.losses.didanosineTabs200mg}</td>
<td align="center">${register.posAdjustments.didanosineTabs200mg}</td>
<td align="center">${register.negAdjustments.didanosineTabs200mg}</td>
<td align="center">${register.onHand.didanosineTabs200mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosineTabs200mg}</td>
<td align="center">${register.expiryDate.didanosineTabs200mg}</td>
<td align="center">${register.daysOutOfStock.didanosineTabs200mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosineTabs200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosineTabs200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosineTabs200mg">${register.quantityRequiredNewPatients.didanosineTabs200mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosineTabs200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosineTabs200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosineTabs200mg">${register.totalQuantityRequired.didanosineTabs200mg}</span>
	<span id="widget.totalQuantityRequired.didanosineTabs200mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="8"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine 100mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosineTabs100mg}</td>
<td align="center">${register.received.didanosineTabs100mg}</td>
<td align="center">${register.totalDispensed.didanosineTabs100mg}</td>
<td align="center">${register.losses.didanosineTabs100mg}</td>
<td align="center">${register.posAdjustments.didanosineTabs100mg}</td>
<td align="center">${register.negAdjustments.didanosineTabs100mg}</td>
<td align="center">${register.onHand.didanosineTabs100mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosineTabs100mg}</td>
<td align="center">${register.expiryDate.didanosineTabs100mg}</td>
<td align="center">${register.daysOutOfStock.didanosineTabs100mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosineTabs100mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosineTabs100mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosineTabs100mg">${register.quantityRequiredNewPatients.didanosineTabs100mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosineTabs100mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosineTabs100mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosineTabs100mg">${register.totalQuantityRequired.didanosineTabs100mg}</span>
	<span id="widget.totalQuantityRequired.didanosineTabs100mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="10"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine 50mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosineTabs50mg}</td>
<td align="center">${register.received.didanosineTabs50mg}</td>
<td align="center">${register.totalDispensed.didanosineTabs50mg}</td>
<td align="center">${register.losses.didanosineTabs50mg}</td>
<td align="center">${register.posAdjustments.didanosineTabs50mg}</td>
<td align="center">${register.negAdjustments.didanosineTabs50mg}</td>
<td align="center">${register.onHand.didanosineTabs50mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosineTabs50mg}</td>
<td align="center">${register.expiryDate.didanosineTabs50mg}</td>
<td align="center">${register.daysOutOfStock.didanosineTabs50mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosineTabs50mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosineTabs50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosineTabs50mg">${register.quantityRequiredNewPatients.didanosineTabs50mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosineTabs50mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosineTabs50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosineTabs50mg">${register.totalQuantityRequired.didanosineTabs50mg}</span>
	<span id="widget.totalQuantityRequired.didanosineTabs50mg"></span>
	</td>

</tr>

--%>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="12"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Efavirenz 600mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.efavirenzTabs600mg}</td>
<td align="center">${register.received.efavirenzTabs600mg}</td>
<td align="center">${register.totalDispensed.efavirenzTabs600mg}</td>
<td align="center">${register.losses.efavirenzTabs600mg}</td>
<td align="center">${register.posAdjustments.efavirenzTabs600mg}</td>
<td align="center">${register.negAdjustments.efavirenzTabs600mg}</td>
<td align="center">${register.onHand.efavirenzTabs600mg}</td>
<td align="center">${register.quantity6MonthsExpired.efavirenzTabs600mg}</td>
<td align="center">${register.expiryDate.efavirenzTabs600mg}</td>
<td align="center">${register.daysOutOfStock.efavirenzTabs600mg}</td>
<td align="center">${register.quantityRequiredResupply.efavirenzTabs600mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.efavirenzTabs600mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.efavirenzTabs600mg">${register.quantityRequiredNewPatients.efavirenzTabs600mg}</span>
	<span id="widget.quantityRequiredNewPatients.efavirenzTabs600mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.efavirenzTabs600mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.efavirenzTabs600mg">${register.totalQuantityRequired.efavirenzTabs600mg}</span>
	<span id="widget.totalQuantityRequired.efavirenzTabs600mg"></span>
	</td>

</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="13"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Lamivudine 150mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.lamivudineTabs150mg}</td>
<td align="center">${register.received.lamivudineTabs150mg}</td>
<td align="center">${register.totalDispensed.lamivudineTabs150mg}</td>
<td align="center">${register.losses.lamivudineTabs150mg}</td>
<td align="center">${register.posAdjustments.lamivudineTabs150mg}</td>
<td align="center">${register.negAdjustments.lamivudineTabs150mg}</td>
<td align="center">${register.onHand.lamivudineTabs150mg}</td>
<td align="center">${register.quantity6MonthsExpired.lamivudineTabs150mg}</td>
<td align="center">${register.expiryDate.lamivudineTabs150mg}</td>
<td align="center">${register.daysOutOfStock.lamivudineTabs150mg}</td>
<td align="center">${register.quantityRequiredResupply.lamivudineTabs150mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.lamivudineTabs150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.lamivudineTabs150mg">${register.quantityRequiredNewPatients.lamivudineTabs150mg}</span>
	<span id="widget.quantityRequiredNewPatients.lamivudineTabs150mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.lamivudineTabs150mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.lamivudineTabs150mg">${register.totalQuantityRequired.lamivudineTabs150mg}</span>
	<span id="widget.totalQuantityRequired.lamivudineTabs150mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${register.totalDispensed.lopinavir_ritonavir200_50mgItemId}"/>
	<c:param name="code" value="lpvr20050"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Lopinavir/ritonavir (LPV/r) <br />200/50mg</a></td>
<td>Capsule</td>
<td align="center">${register.balanceBF.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.received.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.totalDispensed.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.losses.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.posAdjustments.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.negAdjustments.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.onHand.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.quantity6MonthsExpired.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.expiryDate.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.daysOutOfStock.lopinavir_ritonavir200_50mg}</td>
<td align="center">${register.quantityRequiredResupply.lopinavir_ritonavir200_50mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.lopinavir_ritonavir200_50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.lopinavir_ritonavir200_50mg">${register.quantityRequiredNewPatients.lopinavir_ritonavir200_50mg}</span>
	<span id="widget.quantityRequiredNewPatients.lopinavir_ritonavir200_50mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.lopinavir_ritonavir200_50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.lopinavir_ritonavir200_50mg">${register.totalQuantityRequired.lopinavir_ritonavir200_50mg}</span>
	<span id="widget.totalQuantityRequired.lopinavir_ritonavir200_50mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="15"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Nelfinavir 250mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.nelfinavirTabs250mg}</td>
<td align="center">${register.received.nelfinavirTabs250mg}</td>
<td align="center">${register.totalDispensed.nelfinavirTabs250mg}</td>
<td align="center">${register.losses.nelfinavirTabs250mg}</td>
<td align="center">${register.posAdjustments.nelfinavirTabs250mg}</td>
<td align="center">${register.negAdjustments.nelfinavirTabs250mg}</td>
<td align="center">${register.onHand.nelfinavirTabs250mg}</td>
<td align="center">${register.quantity6MonthsExpired.nelfinavirTabs250mg}</td>
<td align="center">${register.expiryDate.nelfinavirTabs250mg}</td>
<td align="center">${register.daysOutOfStock.nelfinavirTabs250mg}</td>
<td align="center">${register.quantityRequiredResupply.nelfinavirTabs250mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.nelfinavirTabs250mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.nelfinavirTabs250mg">${register.quantityRequiredNewPatients.nelfinavirTabs250mg}</span>
	<span id="widget.quantityRequiredNewPatients.nelfinavirTabs250mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.nelfinavirTabs250mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.nelfinavirTabs250mg">${register.totalQuantityRequired.nelfinavirTabs250mg}</span>
	<span id="widget.totalQuantityRequired.nelfinavirTabs250mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="16"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Nevirapine 200mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.nevirapineTabs200mg}</td>
<td align="center">${register.received.nevirapineTabs200mg}</td>
<td align="center">${register.totalDispensed.nevirapineTabs200mg}</td>
<td align="center">${register.losses.nevirapineTabs200mg}</td>
<td align="center">${register.posAdjustments.nevirapineTabs200mg}</td>
<td align="center">${register.negAdjustments.nevirapineTabs200mg}</td>
<td align="center">${register.onHand.nevirapineTabs200mg}</td>
<td align="center">${register.quantity6MonthsExpired.nevirapineTabs200mg}</td>
<td align="center">${register.expiryDate.nevirapineTabs200mg}</td>
<td align="center">${register.daysOutOfStock.nevirapineTabs200mg}</td>
<td align="center">${register.quantityRequiredResupply.nevirapineTabs200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.nevirapineTabs200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.nevirapineTabs200mg">${register.quantityRequiredNewPatients.nevirapineTabs200mg}</span>
	<span id="widget.quantityRequiredNewPatients.nevirapineTabs200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.nevirapineTabs200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.nevirapineTabs200mg">${register.totalQuantityRequired.nevirapineTabs200mg}</span>
	<span id="widget.totalQuantityRequired.nevirapineTabs200mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="17"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine 30mg</a></td>
<td>Tab/Cap</td>
<td align="center">${register.balanceBF.stavudineTabs_Caps30mg}</td>
<td align="center">${register.received.stavudineTabs_Caps30mg}</td>
<td align="center">${register.totalDispensed.stavudineTabs_Caps30mg}</td>
<td align="center">${register.losses.stavudineTabs_Caps30mg}</td>
<td align="center">${register.posAdjustments.stavudineTabs_Caps30mg}</td>
<td align="center">${register.negAdjustments.stavudineTabs_Caps30mg}</td>
<td align="center">${register.onHand.stavudineTabs_Caps30mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudineTabs_Caps30mg}</td>
<td align="center">${register.expiryDate.stavudineTabs_Caps30mg}</td>
<td align="center">${register.daysOutOfStock.stavudineTabs_Caps30mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudineTabs_Caps30mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudineTabs_Caps30mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudineTabs_Caps30mg">${register.quantityRequiredNewPatients.stavudineTabs_Caps30mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudineTabs_Caps30mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudineTabs_Caps30mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudineTabs_Caps30mg">${register.totalQuantityRequired.stavudineTabs_Caps30mg}</span>
	<span id="widget.totalQuantityRequired.stavudineTabs_Caps30mg"></span>
	</td>

</tr>
<%--
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="18"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine 40mg</a></td>
<td>Tab/Cap</td>
<td align="center">${register.balanceBF.stavudineTabs_Caps40mg}</td>
<td align="center">${register.received.stavudineTabs_Caps40mg}</td>
<td align="center">${register.totalDispensed.stavudineTabs_Caps40mg}</td>
<td align="center">${register.losses.stavudineTabs_Caps40mg}</td>
<td align="center">${register.posAdjustments.stavudineTabs_Caps40mg}</td>
<td align="center">${register.negAdjustments.stavudineTabs_Caps40mg}</td>
<td align="center">${register.onHand.stavudineTabs_Caps40mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudineTabs_Caps40mg}</td>
<td align="center">${register.expiryDate.stavudineTabs_Caps40mg}</td>
<td align="center">${register.daysOutOfStock.stavudineTabs_Caps40mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudineTabs_Caps40mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudineTabs_Caps40mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudineTabs_Caps40mg">${register.quantityRequiredNewPatients.stavudineTabs_Caps40mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudineTabs_Caps40mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudineTabs_Caps40mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudineTabs_Caps40mg">${register.totalQuantityRequired.stavudineTabs_Caps40mg}</span>
	<span id="widget.totalQuantityRequired.stavudineTabs_Caps40mg"></span>
	</td>

</tr>
--%>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="19"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Tenofovir 300mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.tenofovirTabs_caps300mg}</td>
<td align="center">${register.received.tenofovirTabs_caps300mg}</td>
<td align="center">${register.totalDispensed.tenofovirTabs_caps300mg}</td>
<td align="center">${register.losses.tenofovirTabs_caps300mg}</td>
<td align="center">${register.posAdjustments.tenofovirTabs_caps300mg}</td>
<td align="center">${register.negAdjustments.tenofovirTabs_caps300mg}</td>
<td align="center">${register.onHand.tenofovirTabs_caps300mg}</td>
<td align="center">${register.quantity6MonthsExpired.tenofovirTabs_caps300mg}</td>
<td align="center">${register.expiryDate.tenofovirTabs_caps300mg}</td>
<td align="center">${register.daysOutOfStock.tenofovirTabs_caps300mg}</td>
<td align="center">${register.quantityRequiredResupply.tenofovirTabs_caps300mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.tenofovirTabs_caps300mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.tenofovirTabs_caps300mg">${register.quantityRequiredNewPatients.tenofovirTabs_caps300mg}</span>
	<span id="widget.quantityRequiredNewPatients.tenofovirTabs_caps300mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.tenofovirTabs_caps300mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.tenofovirTabs_caps300mg">${register.totalQuantityRequired.tenofovirTabs_caps300mg}</span>
	<span id="widget.totalQuantityRequired.tenofovirTabs_caps300mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="20"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Zidovudine 300mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.zidovudineTabs300mg}</td>
<td align="center">${register.received.zidovudineTabs300mg}</td>
<td align="center">${register.totalDispensed.zidovudineTabs300mg}</td>
<td align="center">${register.losses.zidovudineTabs300mg}</td>
<td align="center">${register.posAdjustments.zidovudineTabs300mg}</td>
<td align="center">${register.negAdjustments.zidovudineTabs300mg}</td>
<td align="center">${register.onHand.zidovudineTabs300mg}</td>
<td align="center">${register.quantity6MonthsExpired.zidovudineTabs300mg}</td>
<td align="center">${register.expiryDate.zidovudineTabs300mg}</td>
<td align="center">${register.daysOutOfStock.zidovudineTabs300mg}</td>
<td align="center">${register.quantityRequiredResupply.zidovudineTabs300mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.zidovudineTabs300mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.zidovudineTabs300mg">${register.quantityRequiredNewPatients.zidovudineTabs300mg}</span>
	<span id="widget.quantityRequiredNewPatients.zidovudineTabs300mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.zidovudineTabs300mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.zidovudineTabs300mg">${register.totalQuantityRequired.zidovudineTabs300mg}</span>
	<span id="widget.totalQuantityRequired.zidovudineTabs300mg"></span>
	</td>

</tr>
<tr>
<th colspan="15">Paediatric Preparations</th>
</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="21"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Abacavir liquid 20mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.received.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.totalDispensed.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.losses.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.posAdjustments.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.negAdjustments.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.onHand.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.quantity6MonthsExpired.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.expiryDate.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.daysOutOfStock.abacavir_liquid_20mg_ml}</td>
<td align="center">${register.quantityRequiredResupply.abacavir_liquid_20mg_ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.abacavir_liquid_20mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.abacavir_liquid_20mg_ml">${register.quantityRequiredNewPatients.abacavir_liquid_20mg_ml}</span>
	<span id="widget.quantityRequiredNewPatients.abacavir_liquid_20mg_ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.abacavir_liquid_20mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.abacavir_liquid_20mg_ml">${register.totalQuantityRequired.abacavir_liquid_20mg_ml}</span>
	<span id="widget.totalQuantityRequired.abacavir_liquid_20mg_ml"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="22"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine 25mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.received.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.totalDispensed.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.losses.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.posAdjustments.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.negAdjustments.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.onHand.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.expiryDate.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.daysOutOfStock.didanosine_Tabs_caps_25mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosine_Tabs_caps_25mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosine_Tabs_caps_25mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosine_Tabs_caps_25mg">${register.quantityRequiredNewPatients.didanosine_Tabs_caps_25mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosine_Tabs_caps_25mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosine_Tabs_caps_25mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosine_Tabs_caps_25mg">${register.totalQuantityRequired.didanosine_Tabs_caps_25mg}</span>
	<span id="widget.totalQuantityRequired.didanosine_Tabs_caps_25mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/>
	<c:param name="beginDate" value="${register.beginDate}"/>
	<c:param name="endDate" value="${register.endDate}"/>
	<c:param name="itemId" value="${register.totalDispensed.didanosine50mgItemId}"/>
	<c:param name="code" value="ddl50"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Didanosine (ddI) 50mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.didanosine50mg}</td>
<td align="center">${register.received.didanosine50mg}</td>
<td align="center">${register.totalDispensed.didanosine50mg}</td>
<td align="center">${register.losses.didanosine50mg}</td>
<td align="center">${register.posAdjustments.didanosine50mg}</td>
<td align="center">${register.negAdjustments.didanosine50mg}</td>
<td align="center">${register.onHand.didanosine50mg}</td>
<td align="center">${register.quantity6MonthsExpired.didanosine50mg}</td>
<td align="center">${register.expiryDate.didanosine50mg}</td>
<td align="center">${register.daysOutOfStock.didanosine50mg}</td>
<td align="center">${register.quantityRequiredResupply.didanosine50mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.didanosine50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.didanosine50mg">${register.quantityRequiredNewPatients.didanosine50mg}</span>
	<span id="widget.quantityRequiredNewPatients.didanosine50mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.didanosine50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.didanosine50mg">${register.totalQuantityRequired.didanosine50mg}</span>
	<span id="widget.totalQuantityRequired.didanosine50mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="24"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Efavirenz 50mg</a></td>
<td>Capsule</td>
<td align="center">${register.balanceBF.efavirenz_Tabs_50mg}</td>
<td align="center">${register.received.efavirenz_Tabs_50mg}</td>
<td align="center">${register.totalDispensed.efavirenz_Tabs_50mg}</td>
<td align="center">${register.losses.efavirenz_Tabs_50mg}</td>
<td align="center">${register.posAdjustments.efavirenz_Tabs_50mg}</td>
<td align="center">${register.negAdjustments.efavirenz_Tabs_50mg}</td>
<td align="center">${register.onHand.efavirenz_Tabs_50mg}</td>
<td align="center">${register.quantity6MonthsExpired.efavirenz_Tabs_50mg}</td>
<td align="center">${register.expiryDate.efavirenz_Tabs_50mg}</td>
<td align="center">${register.daysOutOfStock.efavirenz_Tabs_50mg}</td>
<td align="center">${register.quantityRequiredResupply.efavirenz_Tabs_50mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.efavirenz_Tabs_50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.efavirenz_Tabs_50mg">${register.quantityRequiredNewPatients.efavirenz_Tabs_50mg}</span>
	<span id="widget.quantityRequiredNewPatients.efavirenz_Tabs_50mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.efavirenz_Tabs_50mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.efavirenz_Tabs_50mg">${register.totalQuantityRequired.efavirenz_Tabs_50mg}</span>
	<span id="widget.totalQuantityRequired.efavirenz_Tabs_50mg"></span>
	</td>

</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="11"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Efavirenz 200mg</a></td>
<td>Capsule</td>
<td align="center">${register.balanceBF.efavirenzTabs_caps200mg}</td>
<td align="center">${register.received.efavirenzTabs_caps200mg}</td>
<td align="center">${register.totalDispensed.efavirenzTabs_caps200mg}</td>
<td align="center">${register.losses.efavirenzTabs_caps200mg}</td>
<td align="center">${register.posAdjustments.efavirenzTabs_caps200mg}</td>
<td align="center">${register.negAdjustments.efavirenzTabs_caps200mg}</td>
<td align="center">${register.onHand.efavirenzTabs_caps200mg}</td>
<td align="center">${register.quantity6MonthsExpired.efavirenzTabs_caps200mg}</td>
<td align="center">${register.expiryDate.efavirenzTabs_caps200mg}</td>
<td align="center">${register.daysOutOfStock.efavirenzTabs_caps200mg}</td>
<td align="center">${register.quantityRequiredResupply.efavirenzTabs_caps200mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.efavirenzTabs_caps200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.efavirenzTabs_caps200mg">${register.quantityRequiredNewPatients.efavirenzTabs_caps200mg}</span>
	<span id="widget.quantityRequiredNewPatients.efavirenzTabs_caps200mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.efavirenzTabs_caps200mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.efavirenzTabs_caps200mg">${register.totalQuantityRequired.efavirenzTabs_caps200mg}</span>
	<span id="widget.totalQuantityRequired.efavirenzTabs_caps200mg"></span>
	</td>

</tr>

<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="25"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Efavirenz liquid 30mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.received.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.totalDispensed.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.losses.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.posAdjustments.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.negAdjustments.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.onHand.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.quantity6MonthsExpired.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.expiryDate.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.daysOutOfStock.efavirenz_liquid_30mg_ml}</td>
<td align="center">${register.quantityRequiredResupply.efavirenz_liquid_30mg_ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.efavirenz_liquid_30mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.efavirenz_liquid_30mg_ml">${register.quantityRequiredNewPatients.efavirenz_liquid_30mg_ml}</span>
	<span id="widget.quantityRequiredNewPatients.efavirenz_liquid_30mg_ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.efavirenz_liquid_30mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.efavirenz_liquid_30mg_ml">${register.totalQuantityRequired.efavirenz_liquid_30mg_ml}</span>
	<span id="widget.totalQuantityRequired.efavirenz_liquid_30mg_ml"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="26"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Lamivudine liquid 10mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.received.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.totalDispensed.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.losses.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.posAdjustments.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.negAdjustments.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.onHand.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.quantity6MonthsExpired.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.expiryDate.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.daysOutOfStock.lamivudine_liquid_10mg_ml}</td>
<td align="center">${register.quantityRequiredResupply.lamivudine_liquid_10mg_ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.lamivudine_liquid_10mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.lamivudine_liquid_10mg_ml">${register.quantityRequiredNewPatients.lamivudine_liquid_10mg_ml}</span>
	<span id="widget.quantityRequiredNewPatients.lamivudine_liquid_10mg_ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.lamivudine_liquid_10mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.lamivudine_liquid_10mg_ml">${register.totalQuantityRequired.lamivudine_liquid_10mg_ml}</span>
	<span id="widget.totalQuantityRequired.lamivudine_liquid_10mg_ml"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="27"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Lopinavir/ritonavir liquid 80/20mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.received.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.totalDispensed.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.losses.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.posAdjustments.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.negAdjustments.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.onHand.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.quantity6MonthsExpired.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.expiryDate.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.daysOutOfStock.lopinavir_ritonavir_liquid_80}</td>
<td align="center">${register.quantityRequiredResupply.lopinavir_ritonavir_liquid_80}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.lopinavir_ritonavir_liquid_80', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.lopinavir_ritonavir_liquid_80">${register.quantityRequiredNewPatients.lopinavir_ritonavir_liquid_80}</span>
	<span id="widget.quantityRequiredNewPatients.lopinavir_ritonavir_liquid_80"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.lopinavir_ritonavir_liquid_80', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.lopinavir_ritonavir_liquid_80">${register.totalQuantityRequired.lopinavir_ritonavir_liquid_80}</span>
	<span id="widget.totalQuantityRequired.lopinavir_ritonavir_liquid_80"></span>
	</td>

</tr>

<%--
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="28"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Nelfinavir powder 50mg/1.25ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.received.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.totalDispensed.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.losses.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.posAdjustments.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.negAdjustments.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.onHand.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.quantity6MonthsExpired.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.expiryDate.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.daysOutOfStock.nelfinavir_powder_50mg_125ml}</td>
<td align="center">${register.quantityRequiredResupply.nelfinavir_powder_50mg_125ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.nelfinavir_powder_50mg_125ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.nelfinavir_powder_50mg_125ml">${register.quantityRequiredNewPatients.nelfinavir_powder_50mg_125ml}</span>
	<span id="widget.quantityRequiredNewPatients.nelfinavir_powder_50mg_125ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.nelfinavir_powder_50mg_125ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.nelfinavir_powder_50mg_125ml">${register.totalQuantityRequired.nelfinavir_powder_50mg_125ml}</span>
	<span id="widget.totalQuantityRequired.nelfinavir_powder_50mg_125ml"></span>
	</td>

</tr>
 --%>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="29"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Nevirapine susp 10mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.received.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.totalDispensed.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.losses.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.posAdjustments.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.negAdjustments.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.onHand.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.quantity6MonthsExpired.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.expiryDate.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.daysOutOfStock.nevirapine_susp_10mg_ml}</td>
<td align="center">${register.quantityRequiredResupply.nevirapine_susp_10mg_ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.nevirapine_susp_10mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.nevirapine_susp_10mg_ml">${register.quantityRequiredNewPatients.nevirapine_susp_10mg_ml}</span>
	<span id="widget.quantityRequiredNewPatients.nevirapine_susp_10mg_ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.nevirapine_susp_10mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.nevirapine_susp_10mg_ml">${register.totalQuantityRequired.nevirapine_susp_10mg_ml}</span>
	<span id="widget.totalQuantityRequired.nevirapine_susp_10mg_ml"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="30"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine 15mg</a></td>
<td>Capsule</td>
<td align="center">${register.balanceBF.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.received.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.totalDispensed.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.losses.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.posAdjustments.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.negAdjustments.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.onHand.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.expiryDate.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.daysOutOfStock.stavudine_Tabs_caps_15mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudine_Tabs_caps_15mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_Tabs_caps_15mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_Tabs_caps_15mg">${register.quantityRequiredNewPatients.stavudine_Tabs_caps_15mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_Tabs_caps_15mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_Tabs_caps_15mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_Tabs_caps_15mg">${register.totalQuantityRequired.stavudine_Tabs_caps_15mg}</span>
	<span id="widget.totalQuantityRequired.stavudine_Tabs_caps_15mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="31"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine 20mg</a></td>
<td>Capsule</td>
<td align="center">${register.balanceBF.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.received.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.totalDispensed.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.losses.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.posAdjustments.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.negAdjustments.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.onHand.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.quantity6MonthsExpired.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.expiryDate.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.daysOutOfStock.stavudine_Tabs_caps_20mg}</td>
<td align="center">${register.quantityRequiredResupply.stavudine_Tabs_caps_20mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_Tabs_caps_20mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_Tabs_caps_20mg">${register.quantityRequiredNewPatients.stavudine_Tabs_caps_20mg}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_Tabs_caps_20mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_Tabs_caps_20mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_Tabs_caps_20mg">${register.totalQuantityRequired.stavudine_Tabs_caps_20mg}</span>
	<span id="widget.totalQuantityRequired.stavudine_Tabs_caps_20mg"></span>
	</td>

</tr>

<%--
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="32"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Stavudine liquid, 1mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.received.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.totalDispensed.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.losses.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.posAdjustments.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.negAdjustments.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.onHand.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.quantity6MonthsExpired.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.expiryDate.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.daysOutOfStock.stavudine_liquid_1mg_ml}</td>
<td align="center">${register.quantityRequiredResupply.stavudine_liquid_1mg_ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.stavudine_liquid_1mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.stavudine_liquid_1mg_ml">${register.quantityRequiredNewPatients.stavudine_liquid_1mg_ml}</span>
	<span id="widget.quantityRequiredNewPatients.stavudine_liquid_1mg_ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.stavudine_liquid_1mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.stavudine_liquid_1mg_ml">${register.totalQuantityRequired.stavudine_liquid_1mg_ml}</span>
	<span id="widget.totalQuantityRequired.stavudine_liquid_1mg_ml"></span>
	</td>

</tr>
 --%>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="33"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Zidovudine 100mg</a></td>
<td>Tablet</td>
<td align="center">${register.balanceBF.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.received.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.totalDispensed.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.losses.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.posAdjustments.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.negAdjustments.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.onHand.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.quantity6MonthsExpired.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.expiryDate.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.daysOutOfStock.zidovudine_Tabs_caps_100mg}</td>
<td align="center">${register.quantityRequiredResupply.zidovudine_Tabs_caps_100mg}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.zidovudine_Tabs_caps_100mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.zidovudine_Tabs_caps_100mg">${register.quantityRequiredNewPatients.zidovudine_Tabs_caps_100mg}</span>
	<span id="widget.quantityRequiredNewPatients.zidovudine_Tabs_caps_100mg"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.zidovudine_Tabs_caps_100mg', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.zidovudine_Tabs_caps_100mg">${register.totalQuantityRequired.zidovudine_Tabs_caps_100mg}</span>
	<span id="widget.totalQuantityRequired.zidovudine_Tabs_caps_100mg"></span>
	</td>

</tr>
<tr>
<c:url value="reports/stockChanges.do" var="stock_control">
	<c:param name="siteId" value="${siteId}"/><c:param name="beginDate" value="${register.beginDate}"/><c:param name="endDate" value="${register.endDate}"/><c:param name="itemId" value="34"/>
</c:url>
<td><a href='<c:out value="/${appName}/${stock_control}"/>'>Zidovudine liquid 10mg/ml</a></td>
<td>Bottle</td>
<td align="center">${register.balanceBF.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.received.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.totalDispensed.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.losses.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.posAdjustments.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.negAdjustments.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.onHand.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.quantity6MonthsExpired.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.expiryDate.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.daysOutOfStock.zidovudine_liquid_10mg_ml}</td>
<td align="center">${register.quantityRequiredResupply.zidovudine_liquid_10mg_ml}</td>

<td align="center" ondblclick="callReportWidget('quantityRequiredNewPatients.zidovudine_liquid_10mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.quantityRequiredNewPatients.zidovudine_liquid_10mg_ml">${register.quantityRequiredNewPatients.zidovudine_liquid_10mg_ml}</span>
	<span id="widget.quantityRequiredNewPatients.zidovudine_liquid_10mg_ml"></span>
	</td>

	<td align="center" ondblclick="callReportWidget('totalQuantityRequired.zidovudine_liquid_10mg_ml', 'CDRRArtReport')" class="reportInput">
	<span id="value.totalQuantityRequired.zidovudine_liquid_10mg_ml">${register.totalQuantityRequired.zidovudine_liquid_10mg_ml}</span>
	<span id="widget.totalQuantityRequired.zidovudine_liquid_10mg_ml"></span>
	</td>

</tr>
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
    </c:forEach>

</table>
<p>&nbsp;</p>
<table border="1" cellpadding="3" width="75%">
<tr>
<th colspan="11" align="left">Comments (including explanation of losses and adjustments): </th>
</tr>
<tr>
	<td colspan="10" rowspan="3" style="border: 1px solid gray;">&nbsp;</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td colspan="10">&nbsp;</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td>Report submitted by: </td>
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
	<td>Report received by: </td>
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
<td style="background: #DDD;text-align:center;font-size: 110%">Once you have completed this report, click the "Save" button to save this report and continue to the CDRR-OI Report.</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center" >
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('CDRRArtReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('CDRRArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
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

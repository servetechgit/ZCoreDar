<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:formatDate value="${beginDate}" pattern="${dateFormatLong}" var="beginDate"/>
<fmt:formatDate value="${endDate}" pattern="${dateFormatLong}" var="endDate"/>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' direct='true'>
<c:choose>
<c:when test=" ${! empty beginDate}">
<${detailName} List for period: ${beginDate} - ${endDate}
</c:when>
<c:otherwise>
${detailName} List of stock changes through ${endDate}
</c:otherwise>
</c:choose>
</template:put>
<template:put name='content' direct='true'>
<c:choose>
<c:when test=" ${! empty beginDate}">
<h2>${detailName} List for period: ${beginDate} - ${endDate}</h2>
</c:when>
<c:otherwise>
<h2>${detailName} List of stock changes through ${endDate}</h2>
</c:otherwise>
</c:choose>
<div id="forms">
	<table class="enhancedtable">
		<tbody>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Beginning Balance</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Quantity Received this period</strong></th>
				<th id="dels" class="enhancedtabletighterCell" valign="middle"><strong>Quantity dispensed this period</strong></th>
				<th id="issued" class="enhancedtabletighterCell" valign="middle"><strong>Total Issued to Patients</strong></th>
				<th id="issued" class="enhancedtabletighterCell" valign="middle"><strong>Positive Adjustments</strong></th>
				<th id="issued" class="enhancedtabletighterCell" valign="middle"><strong>Negative Adjustments</strong></th>
				<th id="issued" class="enhancedtabletighterCell" valign="middle"><strong>Ending Balance / Physical Count</strong></th>
			</tr>
			<tr>
				<td>${stockReport.balanceBF}</td>
				<td>${stockReport.additionsTotal}</td>
				<td>${stockReport.deletionsTotal}</td>
				<td>${stockReport.totalDispensed}</td>
				<td>${stockReport.posAdjustments}</td>
				<td>${stockReport.negAdjustments}</td>
				<td>${stockReport.onHand}</td>
			</tr>
		</tbody>
	</table>
	<p>&nbsp;</p>
		<table class="enhancedtable">
			<tbody>
				<tr>
					<th id="dateH" class="enhancedtabletighterCell" valign="middle" width="70px"><strong>Date</strong></th>
					<th id="typeH" class="enhancedtabletighterCell" valign="middle"><strong>Type of Stock Change</strong></th>
					<th id="exireH" class="enhancedtabletighterCell" valign="middle" width="70px"><strong>Expiry Date</strong></th>
					<th id="regH" class="enhancedtabletighterCell" valign="middle"><strong>Reference / Notes</strong></th>
					<th id="quantH" class="enhancedtabletighterCell" valign="middle"><strong>Additions</strong></th>
					<th id="quantH" class="enhancedtabletighterCell" valign="middle"><strong>Subtractions</strong></th>
					<th id="balH" class="enhancedtabletighterCell" valign="middle"><strong>Recorded Balance</strong></th>
					<th id="balH" class="enhancedtabletighterCell" valign="middle"><strong>Calculated Balance</strong></th>
				</tr>
				<c:forEach items="${stockChanges}" var="encounter" varStatus="item">
				<tr>
					<td><fmt:formatDate type="date" pattern="${dateFormatLong}" value="${encounter.date_of_record}"/></td>
					<td><c:choose>
					<c:when test="${encounter.type_of_change == 3263}">Received</c:when>
					<c:when test="${encounter.type_of_change == 3264}">Issued</c:when>
					<c:when test="${encounter.type_of_change == 3265}">Losses</c:when>
					<c:when test="${encounter.type_of_change == 3266}">Pos. Adjust.</c:when>
					<c:when test="${encounter.type_of_change == 3267}">Neg. Adjust.</c:when>
					<c:when test="${encounter.type_of_change == 3279}">Out-of-stock</c:when>
					</c:choose></td>
					<td><fmt:formatDate type="date" pattern="${dateFormatLong}" value="${encounter.expiry_date}"/></td>
					<td>${encounter.notes}</td>
					<c:set var="posAdjust" value=""/>
					<c:choose>
						<c:when test="${encounter.type_of_change == 3263}"><c:set var="posAdjust" value="${encounter.change_value}"/></c:when>
						<c:when test="${encounter.type_of_change == 3264}"></c:when>
						<c:when test="${encounter.type_of_change == 3265}"></c:when>
						<c:when test="${encounter.type_of_change == 3266}"><c:set var="posAdjust" value="${encounter.change_value}"/></c:when>
						<c:when test="${encounter.type_of_change == 3267}"></c:when>
						<c:when test="${encounter.type_of_change == 3279}"></c:when>
					</c:choose>
					<td>${posAdjust}</td>
					<c:set var="negAdjust" value=""/>
					<c:choose>
						<c:when test="${encounter.type_of_change == 3263}"></c:when>
						<c:when test="${encounter.type_of_change == 3264}"><c:set var="negAdjust" value="${encounter.change_value}"/></c:when>
						<c:when test="${encounter.type_of_change == 3265}"><c:set var="negAdjust" value="${encounter.change_value}"/></c:when>
						<c:when test="${encounter.type_of_change == 3266}"></c:when>
						<c:when test="${encounter.type_of_change == 3267}"><c:set var="negAdjust" value="${encounter.change_value}"/></c:when>
						<c:when test="${encounter.type_of_change == 3279}"></c:when>
					</c:choose>
					<td>${negAdjust}</td>
					<td>${encounter.balance}</td>
					<td>${encounter.computedBalance}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
</template:put>
</template:insert>

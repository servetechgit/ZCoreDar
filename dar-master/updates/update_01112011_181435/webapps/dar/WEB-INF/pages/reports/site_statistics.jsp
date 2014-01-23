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

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' content='${detailName} Site statistics for period: ${beginDate} - ${endDate}' direct='true'/>
<template:put name='header' content='${detailName} Site statistics for period: ${beginDate} - ${endDate}' direct='true'/>
<template:put name='content' direct='true'>
<h2>Site statistics for period: ${beginDate} - ${endDate}</h2>
<div id="forms">
	<h2>New and Active ARV Clients</h2>
	<p>New Clients: from period ${beginDate} - ${endDate}</p>
	<p>Active ARV patients: ARV patients who have had drugs dispensed in the past three months.</p>
	<table class="enhancedtable">
		<tbody>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>New Clients</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Active ARV Clients</strong></th>
			</tr>
			<tr>
				<td>${register.stats.newClients}</td>
				<td>${register.stats.activeArvClients}</td>
			</tr>
		</tbody>
	</table>
		<h2>Clients by Age and Gender</h2>
		<p>All clients in the database</p>
	<table class="enhancedtable">
		<tbody>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle">&nbsp;</th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Total</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Males</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Females</strong></th>
				<!--
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Male Adults</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Female Adults</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Male Children</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Female Children</strong></th>
			-->
			</tr>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Adults</strong></th>
				<td>${register.stats.adults}</td>
				<td>${register.stats.maleAdults}</td>
				<td>${register.stats.femaleAdults}</td>
			</tr>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Children</strong></th>
				<td>${register.stats.children}</td>
				<td>${register.stats.maleChildren}</td>
				<td>${register.stats.femaleChildren}</td>
			</tr>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>All</strong></th>
				<td>${register.stats.allClients}</td>
				<td>${register.stats.males}</td>
				<td>${register.stats.females}</td>
			</tr>
		</tbody>
	</table>
	<h2>Status changes: ${beginDate} - ${endDate}</h2>
	<table class="enhancedtable">
		<tbody>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Died</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Transferred</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Defaulters</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Other</strong></th>
			</tr>
			<tr>
				<td>${register.stats.statusDied}</td>
				<td>${register.stats.statusTransferred}</td>
				<td>${register.stats.statusDefaulters}</td>
				<td>${register.stats.statusOther}</td>
			</tr>
		</tbody>
	</table>
	<h2>Regimens: ${beginDate} - ${endDate}</h2>
	<table class="enhancedtable">
		<tbody>
			<tr>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Code</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Name</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Count</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Percentage</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Adults</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Children</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Male</strong></th>
				<th id="adds" class="enhancedtabletighterCell" valign="middle"><strong>Female</strong></th>
			</tr>
			<c:forEach items="${register.stats.regimens}" var="regimen">
			<tr>
				<td>${regimen.code}</td>
				<td>${regimen.name}</td>
				<td>${regimen.count}</td>
				<td>${regimen.percentage}</td>
				<td>${regimen.totalAdults}</td>
				<td>${regimen.totalChildren}</td>
				<td>${regimen.totalMale}</td>
				<td>${regimen.totalFemale}</td>
			</tr>
			</c:forEach>

		</tbody>
	</table>
	<p>&nbsp;</p>

		</div>
</template:put>
</template:insert>

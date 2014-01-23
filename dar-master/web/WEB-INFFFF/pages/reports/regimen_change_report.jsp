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
<template:put name='title' content='Regimen Change Report for period: ${beginDate} - ${endDate}' direct='true'/>
<template:put name='header' content='Regimen Change Report  for period: ${beginDate} - ${endDate}' direct='true'/>
<template:put name='content' direct='true'>
<h2>Regimen Change Report for period: ${beginDate} - ${endDate}</h2>
<div id="forms">
		<table class="enhancedtable">
			<tbody>
				<tr>
					<th id="dateH" class="enhancedtabletighterCell" valign="middle"><strong>Date started</strong></th>
					<th id="typeH" class="enhancedtabletighterCell" valign="middle"><strong>Client</strong></th>
					<th id="exireH" class="enhancedtabletighterCell" valign="middle"><strong>Previous Regimen</strong></th>
					<th id="exireH" class="enhancedtabletighterCell" valign="middle"><strong>Regimen</strong></th>
					<th id="regH" class="enhancedtabletighterCell" valign="middle"><strong>Reason for change</strong></th>
				</tr>
				<c:forEach items="${register.regimens}" var="encounter" varStatus="item">
				    <c:url value="patientHome.do" var="url"><c:param name="patientId" value="${encounter.patientId}"/></c:url>

				<tr>
					<td><fmt:formatDate value="${encounter.date_started}" pattern="${dateFormatLong}"/></td>
					<td><a href='<c:out value="/${appName}/${url}"/>'>${encounter.surname}, ${encounter.firstName}</a></td>
					<td>${encounter.regimen_1R}</td>
					<td>${encounter.regimen_1R}</td>
					<td>${encounter.regimen_change_reasonR}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
</template:put>
</template:insert>

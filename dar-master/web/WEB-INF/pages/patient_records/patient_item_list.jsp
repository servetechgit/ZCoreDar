<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:choose>
    <c:when test="${empty param.flowId}">
    <c:set var="flowId" value="${tasklist.currentFlowId}"/>
    </c:when>
    <c:otherwise>
    <c:set var="flowId" value="${param.flowId}"/>
    </c:otherwise>
</c:choose>
<c:set var="labelEnd"/>
<c:if test="${! empty zeprs_session.sessionPatient.dateEventEnd}">
    <fmt:formatDate value="${zeprs_session.sessionPatient.dateEventBegin}" pattern="dd MMM yy" var="pregStart" />
    <fmt:formatDate value="${zeprs_session.sessionPatient.dateEventEnd}" pattern="dd MMM yy" var="pregEnd" />
    <c:set var="labelEnd" value=": ${pregStart} - ${pregEnd} Pregnancy"/>
</c:if>
<c:set var="template" value="/WEB-INF/templates/${appTemplateDir}/template-print.jsp"/>
<template:insert template='${template}'>
<template:put name='title' direct='true'>Patient Tasks</template:put>
<template:put name='content' direct='true'>
<div id="tasklist">
<h2>Dispensing${labelEnd}</h2>
<c:if test="${(!empty zeprs_session.sessionPatient.dead && zeprs_session.sessionPatient.dead != 'true')}">
<p>
<strong><html:link action="/PatientItem/new.do" paramId="patientId" paramName="patientId">Create New Dispensing Record</html:link>:</strong>
 Dispense stock to clients.
</p>
</c:if>
<p><strong>Past Stock Transactions</strong></p>
<table class="enhancedtable">
<thead>
<tr>
<th>Date of Visit</th>
<th>Item</th>
<th>No. of Days</th>
<th>Quantity Dispensed</th>
</tr>
</thead>
<tbody>
<logic:iterate id="task" name="items">
<c:if test="${!empty task.encounterId}">
<logic:present name="task" property="records" >
<logic:iterate id="record" name="task" property="records">
	<tr>
		<c:url value="viewEncounter.do" var="url">
		    <c:param name="id" value="${task.encounterId}"/>
		    <c:param name="patientId" value="${task.patientId}"/>
		</c:url>
		<td><a href='<c:out value="/${appName}/${url}"/>'><fmt:formatDate value="${task.dateVisit}" pattern="dd MMM yy"/></a></td>
		<c:set var="currentIndex" value="1"/>
		<logic:iterate id="encounterMapItem" name="record" property="encounterMap" indexId="index">
		<c:set var="thisItem" value="PBF${index+1}_item_id"/>
		<logic:notEmpty name="record" property="encounterMap.${thisItem}">
		<c:if test="${(currentIndex != index+1)}">
		</tr><tr>
		<td><a href='<c:out value="/${appName}/${url}"/>'><fmt:formatDate value="${task.dateVisit}" pattern="dd MMM yy"/></a></td>
		<c:set var="currentIndex" value="${index+1}"/>
		</c:if>
		<bean:define id="thisValue" name="record" property="encounterMap.${thisItem}" />
		<td>${thisValue}</td>
		</logic:notEmpty>
		<c:set var="thisDay" value="PBF${index+1}_number_of_days"/>
		<logic:notEmpty name="record" property="encounterMap.${thisDay}">
		<bean:define id="thisDaysValue" name="record" property="encounterMap.${thisDay}" />
		<td>${thisDaysValue}</td>
		</logic:notEmpty>

		<c:set var="thisDispensed" value="PBF${index+1}_dispensed"/>
		<logic:notEmpty name="record" property="encounterMap.${thisDispensed}">
		<bean:define id="thisDispensedValue" name="record" property="encounterMap.${thisDispensed}" />
		<td>${thisDispensedValue}</td>
		</logic:notEmpty>
		</logic:iterate>
	</tr>
	</logic:iterate>
</logic:present>
</c:if>
</logic:iterate>
</tbody>
</table>
</div>
<c:import url="../problems/problems_chart.jsp" />
</template:put>
</template:insert>
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
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri='/WEB-INF/tlds/zeprs.tld' prefix='zeprs' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-print.jsp'>
    <template:put name='title' direct='true'><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></template:put>
    <template:put name='header' direct='true'><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></template:put>
    <template:put name='content' direct='true'>
    <div id="maincol-pad">
    <c:import url="verify_form.jsp"></c:import>
    <c:if test="${! empty syncEvents}">
			<p><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.desc" /></p>
			<table class="enhancedtable" width="90%">
				<tr>
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.importTimestamp" /></th>
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.exportTimestamp" /></th>
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.className" /></th>
					<!--
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.parentUuid" /></th>
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.objectUuid" /></th>
					-->
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.exception" /></th>
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.exceptionClass" /></th>
					<th><bean:message bundle="ApplicationResources" key="admin.index.syncLog.exceptionMessage" /></th>
				</tr>
				<c:forEach items="${syncEvents}" var="syncEvent">
				<fmt:formatDate value="${syncEvent.syncDate}" pattern="yyyy/MMM/W" var="archivePath"/>
					<tr>
						<td colspan="9"><strong><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.syncDate" />:</strong>
						<c:choose>
							<c:when test="${syncEvent.syncEventType == 2}"><a href="/archive/${siteAbbrev}/log/complete/<c:out value='${archivePath}'/>/syncEvent_${syncEvent.uuid}.json">${syncEvent.syncDate}</a></c:when>
							<c:when test="${syncEvent.syncEventType == 1}"><a href="/archive/${siteAbbrev}/import/<c:out value='${archivePath}'/>/importResults_syncEvent_${syncEvent.uuid}.json">${syncEvent.syncDate}</a></c:when>
						</c:choose>
						</td>
					</tr>
					<c:if test="${! empty syncEvent.encounters}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.encounters" /></td>
						</tr>
						<c:forEach items="${syncEvent.encounters}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.patients}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.patients" /></td>
						</tr>
						<c:forEach items="${syncEvent.patients}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.events}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.events" /></td>
						</tr>
						<c:forEach items="${syncEvent.events}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.comments}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.comments" /></td>
						</tr>
						<c:forEach items="${syncEvent.comments}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.outcome}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.outcome" /></td>
						</tr>
						<c:forEach items="${syncEvent.outcome}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.edits}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.edits" /></td>
						</tr>
						<c:forEach items="${syncEvent.edits}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.outcomeDeletions}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.outcomeDeletions" /></td>
						</tr>
						<c:forEach items="${syncEvent.outcomeDeletions}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.problemDeletions}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.problemDeletions" /></td>
						</tr>
						<c:forEach items="${syncEvent.problemDeletions}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.relationships}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.relationships" /></td>
						</tr>
						<c:forEach items="${syncEvent.relationships}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.organizations}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.organizations" /></td>
						</tr>
						<c:forEach items="${syncEvent.organizations}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.contacts}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.contacts" /></td>
						</tr>
						<c:forEach items="${syncEvent.contacts}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.users}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.users" /></td>
						</tr>
						<c:forEach items="${syncEvent.users}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.courts}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.courts" /></td>
						</tr>
						<c:forEach items="${syncEvent.courts}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.policeStations}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.policeStations" /></td>
						</tr>
						<c:forEach items="${syncEvent.policeStations}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.adminRecords}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.adminRecords" /></td>
						</tr>
						<c:forEach items="${syncEvent.adminRecords}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${! empty syncEvent.deletions}">
						<tr>
							<td colspan="9"><bean:message bundle="ApplicationResources" key="admin.index.syncEvent.deletions" /></td>
						</tr>
						<c:forEach items="${syncEvent.deletions}" var="item">
							<tr>
								<td>${item.importTimestamp}</td>
								<td>${item.exportTimestamp}</td>
								<td>${item.className}</td>
								<td>${item.exception}</td>
								<td>${item.exceptionClass}</td>
								<td>${item.exceptionMessage}</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
			</table>
		</c:if>
         </div>
    </template:put>
</template:insert>
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:insert
	template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
	<template:put name='title' direct='true'><bean:message bundle="ApplicationResources" key="admin.header.short"/>:
	<c:choose>
		<c:when test="${propFilename == 'site'}">
			<bean:message bundle="ApplicationResources" key="properties.edit.property"/>
		</c:when>
		<c:otherwise>
			<bean:message bundle="ApplicationResources" key="properties.edit.translation"/> ${propFilename}
		</c:otherwise>
	</c:choose>
	</template:put>
	<template:put name='header' direct='true'>
		<html:link action="/admin/home"><bean:message bundle="ApplicationResources" key="admin.header.short"/></html:link>: <html:link
			action="/admin/formList"><bean:message bundle="ApplicationResources" key="admin.formlist.form.admin"/></html:link>:
			<c:choose>
				<c:when test="${propFilename == 'site'}">
					<bean:message bundle="ApplicationResources" key="properties.edit.property"/>
				</c:when>
				<c:otherwise>
					<bean:message bundle="ApplicationResources" key="properties.edit.translation"/> ${propFilename}
				</c:otherwise>
			</c:choose>
			</template:put>
	<template:put name='help' content="" direct="true" />
	<template:put name='content' direct='true'>
		<script type='text/javascript'
			src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
		<script type='text/javascript'
			src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
		<script type='text/javascript'
			src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>

		<span class="error"><html:errors /></span>
		<a name="top"></a>
		<html:form action="admin/properties/save" method="POST">
			<input type="hidden" name="propFilename" value="${propFilename}" />
			<input type="hidden" name="selectedLocale" value="${selectedLocale}" />
			<c:if test="${! empty param.saved}">
				<p><span class="error"><bean:message
					bundle="ApplicationResources"
					key="labels.admin.form.translation.saved" /></span></p>
			</c:if>
			<table class="enhancedtable">

			<c:choose>
			<c:when test="${propFilename == 'site'}">
				<tr>
					<th><bean:message key="properties.edit.key" bundle="ApplicationResources" /></th>
					<th><span><bean:message bundle="ApplicationResources" key="properties.edit.value" /></span></th>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th><bean:message key="locale.translate.original" bundle="ApplicationResources" /></th>
					<th><span><bean:message bundle="ApplicationResources" key="locale.translate.translation" /></span>: ${selectedLocaleName}</th>
				</tr>
			</c:otherwise>
			</c:choose>

				<logic:iterate id="property" name="defaultPropMap" indexId="i">
					<tr>
					<c:set var="theValue" value="${property['value']}" />
					<c:set var="defKeyValue" value="${property['key']}" />
						<td>${theValue}<br/>
						<c:set var="localtionArray" value="${fn:split(defKeyValue,'_')}"/>
						<c:set var="location" value="${localtionArray[0]}"/>
						<c:choose>
						<c:when test="${fn:startsWith(defKeyValue,'admin_index')}"><html:link action="/admin/home.do" target="new"><bean:message bundle="ApplicationResources" key="admin.header.long"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'config')}"><html:link action="/config/home.do" target="new"><bean:message bundle="ApplicationResources" key="config.header"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'home')}"><html:link action="/home.do" target="new"><bean:message bundle="ApplicationResources" key="home.title"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'labels_admin')}"><html:link action="/admin/home.do" target="new"><bean:message bundle="ApplicationResources" key="admin.header.long"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'headings_admin')}"><html:link action="/admin/home.do" target="new"><bean:message bundle="ApplicationResources" key="admin.header.long"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'app_chooseReport')}"><html:link action="/reports.do" target="new"><bean:message bundle="ApplicationResources" key="reports.header"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'setup_site')}"><html:link action="/setup.do" target="new"><bean:message bundle="ApplicationResources" key="reports.header"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'errors')}"><bean:message bundle="ApplicationResources" key="properties.errors"/></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'labels_problem')}"><bean:message bundle="ApplicationResources" key="properties.problem.form"/></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'record_')}"><bean:message bundle="ApplicationResources" key="properties.patient.record"/></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'locale_translate')}"><bean:message bundle="ApplicationResources" key="properties.form.translation"/></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'admin_site')}"><html:link action="/admin/sites/list.do" target="new"><bean:message bundle="ApplicationResources" key="properties.site.admin"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'admin_user_groups')}"><html:link action="/admin/users.do" target="new"><bean:message bundle="ApplicationResources" key="admin.index.user.admin"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'admin_formlist')}"><html:link action="/admin/formList.do" target="new"><bean:message bundle="ApplicationResources" key="admin.formlist.form.admin"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'admin_flow')}"><html:link action="/admin/flow/list.do" target="new"><bean:message bundle="ApplicationResources" key="admin.flow.header"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'admin_subscription')}"><html:link action="/admin/subscription/new.do" target="new"><bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/></html:link></c:when>
						<c:when test="${fn:startsWith(defKeyValue,'problemsChart')}">Task List</c:when>
						<c:when test="${fn:startsWith(defKeyValue,'tasks')}">Task List</c:when>
						<c:otherwise>${fn:replace(defKeyValue,'_','.')}</c:otherwise>
						</c:choose>
						</td>
						<td id="cell_${defKeyValue}">
						<html:textarea property="${defKeyValue}" styleId="locale_${defKeyValue}" value="${propMap[defKeyValue]}" cols="60" rows="3"/></td>
					</tr>
				</logic:iterate>
			</table>
			<html:submit>

						<c:choose>
			<c:when test="${propFilename == 'site'}">
				<bean:message bundle="ApplicationResources" key="labels.admin.form.properties.edit.submit" />
			</c:when>
			<c:otherwise>
				<bean:message bundle="ApplicationResources" key="labels.admin.form.locale.edit.submit" />
			</c:otherwise>
			</c:choose>
			</html:submit>
		</html:form>
	</template:put>
</template:insert>
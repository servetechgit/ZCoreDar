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
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
<template:put name='title' content='Admin: Form Admin' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home"><bean:message bundle="ApplicationResources" key="admin.formlist.admin"/></html:link>: <bean:message bundle="ApplicationResources" key="admin.formlist.form.admin"/></template:put>
<template:put name='help' content="" direct="true"/>
<template:put name='content' direct='true'>
<script language="JavaScript" type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwrdisplay/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
    <script type="text/javascript">
        WidgetDisplay.dispatchFlows(initFlows);
        WidgetDisplay.dispatchFormTypes(initFormTypes);
        WidgetDisplay.dispatchFormDomains(initFormDomains);
    </script>
<c:choose>
    <c:when test="${param.formEnabled == 0}">
    <c:set var="sql" value="SELECT f.id, f.label,f.name AS table_name, f.require_reauth, f.require_patient, f.is_enabled, f.form_type_id, fl.name AS flowName, fl.id AS flowId, f.flow_order, f.max_submissions, ft.name AS formType, fd.name AS formDomain, f.records_per_encounter AS recordsPerEncounter, f.global_identifier_name AS globalIdentifierName, f.start_new_event AS startNewEvent, f.event_type AS eventType FROM ADMIN.form f LEFT JOIN ADMIN.form_domain fd ON fd.id = f.form_domain_id LEFT JOIN ADMIN.form_type ft ON ft.id = f.form_type_id LEFT JOIN ADMIN.flow fl ON f.flow_id = fl.id ORDER by flowName, flow_order"/>
    </c:when>
    <c:otherwise>
    <c:set var="sql" value="SELECT f.id, f.label,f.name AS table_name, f.require_reauth, f.require_patient, f.is_enabled, f.form_type_id, fl.name AS flowName, fl.id AS flowId, f.flow_order, f.max_submissions, ft.name AS formType, fd.name AS formDomain, f.records_per_encounter AS recordsPerEncounter, f.global_identifier_name AS globalIdentifierName, f.start_new_event AS startNewEvent, f.event_type AS eventType FROM ADMIN.form f LEFT JOIN ADMIN.form_domain fd ON fd.id = f.form_domain_id LEFT JOIN ADMIN.form_type ft ON ft.id = f.form_type_id LEFT JOIN ADMIN.flow fl ON f.flow_id = fl.id WHERE is_enabled=1 ORDER by flowName, flow_order"/>
    </c:otherwise>
</c:choose>
<sql:query var = "results" dataSource="jdbc/zeprsDB" sql="${sql}"/>
<h2>
<c:choose>
    <c:when test="${param.formEnabled == 0}">
    <bean:message bundle="ApplicationResources" key="admin.formlist.all"/> |
    <html:link action="/admin/formList"><bean:message bundle="ApplicationResources" key="admin.formlist.enabled"/></html:link>
    </c:when>
    <c:otherwise>
    <bean:message bundle="ApplicationResources" key="admin.formlist.enabled"/> |
    <html:link href="/${appName}/admin/formList.do;jsessionid=${pageContext.request.session.id}?formEnabled=0"><bean:message bundle="ApplicationResources" key="admin.formlist.all"/></html:link>
    </c:otherwise>
</c:choose>
 | <html:link action="/admin/form/new"><bean:message bundle="ApplicationResources" key="admin.index.form.create"/></html:link> | <html:link action="/admin/form/import"><bean:message bundle="ApplicationResources" key="admin.index.form.import"/></html:link>
</h2>
<p>
      <html:form action="/admin/locale/save" method="POST">

	<strong><bean:message bundle="ApplicationResources" key="admin.formlist.lang.default"/></strong> ${defaultLocaleName} <br />
	<strong><bean:message bundle="ApplicationResources" key="admin.formlist.lang.other"/></strong>
	<c:forEach var='item' items='${localeDisplayMap}' varStatus="status">
		<c:set var="string" value="${item.key}"/>
		<c:url value="admin/locale/delete.do" var="local_link">
		<c:param name="language" value="${fn:substring(string, 0, 2)}"/>
		<c:param name="country" value="${fn:substring(string, 3, 5)}"/>
		<c:param name="variant" value="${fn:substring(string, 6, 8)}"/>
		</c:url>
		${item.value}
		<a href='<c:out value="/${appName}/${local_link}"/>' onclick="return confirm('Caution: Are you sure you want to delete languge from the system?');self.close();">X</a>
		<c:if test="${!status.last}">|</c:if>
	</c:forEach>
				<html:select property="formLocale">
		            <!--<c:forEach items="${locales}" var="locale">
						<html:option value="${locale.key}">${locale.value}</html:option>
					</c:forEach>
		            -->
		            <c:forEach items="${sortedLocaleList}" var="locale">
						<html:option value="${locale.key}">${locale.value}</html:option>
					</c:forEach>
	            </html:select>
				<html:submit><bean:message bundle="ApplicationResources" key="labels.admin.form.addLocale"/></html:submit>
    </html:form>
</p>
    <p><bean:message bundle="ApplicationResources" key="admin.formlist.edit.instructions"/><a href="#" onclick="toggleOld('instructions')"><bean:message bundle="ApplicationResources" key="admin.formlist.more.instruct"/></a> </p>
     <div id="instructions" style="display:none;">
        <h2><bean:message bundle="ApplicationResources" key="admin.formlist.instruct"/></h2>
        <ul>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.label"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.table"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.enabled"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.reauth"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.reqPatient"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.flow"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.flow.order"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.display"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.domain"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.max"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.start"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.event"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.records"/></li>
            <li><bean:message bundle="ApplicationResources" key="admin.formlist.instruct.source"/></li>
        </ul>
    </div>
<table cellpadding="2" cellspacing="0" bgColor = "white" summary="Form list" border="1">
<tr class="patientrowheader">
<th><bean:message bundle="ApplicationResources" key="admin.formlist.form"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.delete"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.items"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.table"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.enabled"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.auth"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.patient"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.flow"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.order"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.form.display"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.form.domain"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.max"/></th>
<th><bean:message bundle="ApplicationResources" key="labels.admin.form.startNewEvent"/></th>
<th><bean:message bundle="ApplicationResources" key="labels.admin.form.eventType"/></th>
<th width="100px" title="Patient Bridge forms only"><bean:message bundle="ApplicationResources" key="admin.formlist.records"/></th>
<th><bean:message bundle="ApplicationResources" key="admin.formlist.source"/></th>

</tr>
    <c:forEach var="row" items="${results.rows}">
<tr>
    <td id="label${row.id}" ondblclick="getInputWidget('label${row.id}', 'form.label','${row.label}', 'label', '${row.id}', 40)">${row.label}</td>
    <c:url value="admin/form/delete.do" var="del"><c:param name="formId" value="${row.id}"/></c:url>
    <td id="delete${row.id}" align="center"><a href='<c:out value="/${appName}/${del}"/>' onclick="return confirm('Caution: Are you sure you want to delete this form from the system?');self.close();">X</a></td>
    <td>
        <html:link action="/admin/form/edit" paramId="id" paramName="row" paramProperty="id">Items</html:link>
    </td>
    <td id="name${row.id}" ondblclick="getInputWidget('name${row.id}', 'form.name','${row.table_name}', 'name', '${row.id}', 30)">${row.table_name}</td>
    <td id="enabled${row.id}" ondblclick="toggleFormElement('enabled${row.id}', 'form.enabled', 'is_enabled', '${row.id}')">${row.is_enabled}</td>
    <td id="requireReauth${row.id}" ondblclick="toggleFormElement('requireReauth${row.id}', 'form.requireReauth', 'require_reauth', '${row.id}')">${row.require_reauth}</td>
    <td id="requirePatient${row.id}" ondblclick="toggleFormElement('requirePatient${row.id}', 'form.requirePatient', 'require_patient', '${row.id}')">${row.require_patient}</td>
    <td id="flowId${row.id}" ondblclick="getSelectWidget('flowId${row.id}', 'form.flowId','${row.flowId}', 'flow_id', '${row.id}', flows)">${row.flowName}</td>
    <td id="flowOrder${row.id}" ondblclick="getInputWidget('flowOrder${row.id}', 'form.flowOrder','${row.flow_order}', 'flow_order', '${row.id}', 2)">${row.flow_order}</td>
    <td id="formTypeId${row.id}" ondblclick="getSelectWidget('formTypeId${row.id}', 'form.formTypeId','${row.form_type_id}', 'form_type_id', '${row.id}', formTypes)">${row.formType}</td>
    <td id="formDomainId${row.id}" ondblclick="getSelectWidget('formDomainId${row.id}', 'form.formDomainId','${row.form_domain_id}', 'form_domain_id', '${row.id}', formDomains)">${row.formDomain}</td>
    <td id="maxSubmissions${row.id}" ondblclick="getInputWidget('maxSubmissions${row.id}', 'form.maxSubmissions','${row.max_submissions}', 'max_submissions', '${row.id}', 2)">${row.max_submissions}</td>
    <td id="startNewEvent${row.id}" ondblclick="toggleFormElement('startNewEvent${row.id}', 'form.startNewEvent', 'start_new_event', '${row.id}', 2)">${row.startNewEvent}</td>
    <td id="eventType${row.id}" ondblclick="getInputWidget('eventType${row.id}', 'form.eventType','${row.event_type}', 'event_type', '${row.id}', 10)">${row.eventType}</td>
	<td id="recordsPerEncounter${row.id}" ondblclick="getInputWidget('recordsPerEncounter${row.id}', 'form.recordsPerEncounter','${row.recordsPerEncounter}', 'records_per_encounter', '${row.id}', 2)">${row.recordsPerEncounter}</td>
    <td id="globalIdentifierName${row.id}" ondblclick="getGlobalIdWidget('globalIdentifierName${row.id}', 'form.globalIdentifierName','${row.globalIdentifierName}', 'global_identifier_name', '${row.id}')">${row.globalIdentifierName}</td>
</tr>
</c:forEach>
</table>

</template:put>
</template:insert>
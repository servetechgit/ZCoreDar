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
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
<template:put name='title' content='Admin: Create Form' direct='true'/>
<template:put name='help' content='' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: <html:link action="/admin/formList">Form Admin</html:link>: Create Form</template:put>
<template:put name='content' direct='true'>
<script type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>
<%--<h2><bean:message bundle="ApplicationResources" key="headings.admin.form.formOptions"/></h2>--%>
<div id="admin1">
<span class="error"><html:errors /></span>
<html:form action="admin/form/save" method="POST" onsubmit="return validateAdminForm(this);">
<html:hidden property="id"/>
<input type="hidden" name="formId" value="${form_id}">
<logic:present parameter="formId" >
<bean:parameter id="form_id" name="formId" />
</logic:present>
<logic:notPresent parameter="formId">
    <logic:present parameter="id" ><bean:parameter id="form_id" name="id" /></logic:present>
</logic:notPresent>
<table border="1" cellpadding="2" cellspacing="1">
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.label"/>: </td>
        <td><html:text property="label" size="35"/></td>
        <td>Label field can be descriptive - this is displayed at the top of the form.</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.name"/>: </td>
        <td><html:text property="name" size="35" styleId="name" maxlength="128"/></td>
        <td>Name field should be a short, one word, lower-case name. It must begin with a letter and contain only letters, underscore characters (_), and digits and be limited to 128 characters. It is used internally by the system to create the database table.</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.requireReauth"/>: </td>
        <td><bean:message bundle="ApplicationResources" key="labels.global.yes"/> <input name="requireReauth" value="1" type="radio" checked="checked">
        <bean:message bundle="ApplicationResources" key="labels.global.no"/> <input name="requireReauth" value="0" type="radio"></td>
        <td>Require Reauthentication: Do you need a username/password field displayed at bottom of form? This will force user to re-authenticate before the form will be processed. Default: Yes. </td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.requirePatient"/>:</td>
        <td><bean:message bundle="ApplicationResources" key="labels.global.yes"/> <input name="requirePatient" value="1" type="radio" checked="checked">
<bean:message bundle="ApplicationResources" key="labels.global.no"/> <input name="requirePatient" value="0" type="radio"></td>
<td>Require Patient: Most forms require a patient. Default: Yes. Only form that does not require a patient is Enrollment.</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.enabled"/>: </td>
        <td><bean:message bundle="ApplicationResources" key="labels.global.yes"/> <input name="enabled" value="1" type="radio" checked="checked">
<bean:message bundle="ApplicationResources" key="labels.global.no"/> <input name="enabled" value="0" type="radio"> </td>
<td>Enabled: Is the form enabled? Default: Yes.</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.flow"/>: </td>
        <%--<td><html:select property="flow.id">--%>
        <td><html:select property="flowId">
        <logic:iterate id="flow" name="flows">
        <html:option value="${flow.id}">${flow.name}</html:option>
        </logic:iterate>
        </html:select></td>
        <td>Flow: In which flow does this form belong?</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.flowOrder"/>: </td>
        <td><html:text property="flowOrder" size="3"/></td>
        <td>Order in Flow: Within its flow sequence, where does this form appear? If this is a new form, you need to make sure it's next in sequence.</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.formType"/>: </td>
        <%--<td><html:select property="formType.id">--%>
        <td><html:select property="formTypeId">
            <c:forEach items="${formTypes}" var="type">
				<c:choose>
				<c:when test="${type.id == '1'}"><option value="${type.id}" selected>${type.name}</option></c:when>
				<c:otherwise><html:option value="${type.id}">${type.name}</html:option></c:otherwise>
				</c:choose>
				</c:forEach>
            </html:select></td>
            <td>Form Type - Default is "Basic." Options:
				<ul>
				<li>Admin: Used for managing items not tied to a patient, such as contacts.</li>
				<li>Basic: Typical form - Default</li>
				<li>Chart: Builds a chart, with previous records to the left of the form.</li>
				<li>List: Creates form at top, then list of previous records beneath.</li>
				<li>Patient Bridge: Creates multiple instances of the form object.</li>
				</ul>
			</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.formDomain"/>: </td>
        <td><html:select property="formDomainId">
            <c:forEach items="${formDomains}" var="domain">
            <html:option value="${domain.id}">${domain.name}</html:option>
            </c:forEach>
            </html:select></td>
            <td>Form Domain - Default is "All Patients." </td>
    </tr>
    <tr>
    	<td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.formLocale"/>: </td>
    	<td><html:select property="formLocale">
            <c:forEach items="${formLocale}" var="locale">
				<c:choose>
				<c:when test="${locale == sessionLocale}"><option value="${locale}" selected>${locale}</option></c:when>
				<c:otherwise><html:option value="${locale}">${locale}</html:option></c:otherwise>
				</c:choose>
				</c:forEach>
            </html:select></td>
            <td>Form Locale - Default form locale </td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.maxSubmissions"/>: </td>
        <td><html:text property="maxSubmissions" size="3"/></td>
        <td>Max. Submissions - You may leave this blank. How many times may the form be submitted for each patient? Enter "1" if you want the the form to be submitted only once for a patient.</td>
    </tr>
	<tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.startNewEvent"/>: </td>
        <td><input name="startNewEvent" value="1" type="checkbox"></td>
        <td>Start a new Event (pregnancy, case, etc) when this form is submitted? Default: Unchecked.</td>
    </tr>
    <tr>
        <td class="formrowlabel"><bean:message bundle="ApplicationResources" key="labels.admin.form.eventType"/>: </td>
        <td><html:text property="eventType" size="35" styleId="eventType" maxlength="128"/></td>
        <td>Name of class that must have a new record when starting a new event. Optional.</td>
    </tr>
    <tr>
        <td class="formrowlabel" colspan="2" align="right"><html:submit value="Save" onclick="bCancel=false;"/></td>
        <td>&nbsp;</td>
    </tr>
</table></div>
<%--<zeprs:rule_list provider="${subject}" formId="${form_id}"/>--%>
<html:javascript formName="adminForm" dynamicJavascript="true" staticJavascript="false" bundle="ApplicationResources"/>
</html:form>
</template:put>
</template:insert>
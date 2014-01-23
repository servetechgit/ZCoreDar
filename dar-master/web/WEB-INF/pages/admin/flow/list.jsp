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
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
<template:put name='title' content='Admin: Flow Admin' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: Flow Admin</template:put>
<template:put name='help' content="" direct="true"/>
<template:put name='content' direct='true'>
<script language="JavaScript" type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwrdisplay/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
<logic:messagesPresent>
   <ul>
   <html:messages id="error">
      <li class="valError"><bean:write name="error"/></li>
   </html:messages>
   </ul>
</logic:messagesPresent>
<p>Flows are used to organize listings of forms and records. </p>
<p>Create a new flow in the following form. After this form is submitted, the new flow will appear in the list below, which is in alphabetical order.</p>
            <html:form action="admin/flow/save" method="POST">
<table border="1" cellpadding="2" cellspacing="1">
    <tr>
        <td class="formrowlabel">Flow Name: </td>
        <td><html:text property="name" size="35" styleId="name" maxlength="128"/></td>
        <td>The Flow Name field should be a single word or phrase (e.g.: Pharmacy). It should not be a duplicate of any of the names in the list below.
		It is limited to 255 characters. </td>
    </tr>
    <tr>
        <td class="formrowlabel">Flow Order: </td>
        <td><html:text property="flowOrder" size="5" styleId="flowOrder" maxlength="8"/></td>
        <td>The Flow Order field should be a number. It is used to order the flows when using a wizard-style flow from form-to-form..</td>
    </tr>
    <tr>
        <td class="formrowlabel" colspan="2" align="right"><html:submit value="Save" onclick="bCancel=false;"/></td>
        <td>&nbsp;</td>
    </tr>
</table>
</html:form>
<h2>Flow Listing</h2>
<p>Instructions: Double click each item to edit.</p>
<table cellpadding="2" cellspacing="0" bgColor = "white" summary="Flow list" border="1">
<tr class="patientrowheader">
<th>Flow ID</th>
<th>Flow name</th>
<th>Flow Order</th>
</tr>
    <c:forEach var="flow" items="${list}">
<tr>
    <td id="id${flow.id}" >${flow.id}</td>
    <td id="name${flow.id}" ondblclick="getInputWidget('name${flow.id}', 'flow.name','${flow.name}', 'name', '${flow.id}', 40)" title="The Flow Name field should be a single word or phrase (e.g.: Pharmacy). It should not be a duplicate of any of the names in the list below. It is limited to 255 characters.">${flow.name}</td>
    <td id="flowOrder${flow.id}" ondblclick="getInputWidget('flowOrder${flow.id}', 'flow.flowOrder','${flow.flowOrder}', 'flow_order', '${flow.id}', 40)" title="The flow order should be a number." >${flow.flowOrder}</td>
</tr>
</c:forEach>
</table>

</template:put>
</template:insert>
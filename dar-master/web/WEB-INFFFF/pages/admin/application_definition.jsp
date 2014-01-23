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
<template:put name='title' content='Admin: Form Admin' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: Application Definition</template:put>
<template:put name='help' content="" direct="true"/>
<template:put name='content' direct='true'>

<table cellpadding="2" cellspacing="0" bgColor = "white" summary="Form list" border="1">
<tr class="patientrowheader">
<th>Form</th>
<th>Table</th>
<th>Enabled?</th>
<th>Auth?</th>
<th>Patient?</th>
<th>Flow</th>
<th>Order</th>
<th>Form Display</th>
<th>Form Domain</th>
</tr>
    <c:forEach var="row" items="${application.forms}">
<tr>
    <td id="label${row.id}">${row.label}</td>
    <td id="name${row.id}" >${row.name}</td>
    <td id="requireReauth${row.id}">${row.requireReauth}</td>
    <td id="requirePatient${row.id}">${row.requirePatient}</td>
    <td id="flowId${row.id}">${row.flow.name}</td>
    <td id="flowOrder${row.id}">${row.flow.flowOrder}</td>
    <td id="formTypeId${row.id}">${row.formType.name}</td>
    <td id="formDomainId${row.id}">${row.formDomain.name}</td>
</tr>
</c:forEach>
</table>

</template:put>
</template:insert>
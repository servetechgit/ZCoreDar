<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ page import="java.util.List"%>
<%@ page import="org.rti.zcore.DynaSiteObjects"%>
<%@ page import="org.rti.zcore.utils.DateUtils"%>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>

<c:url value="dynagen.do" var="source"><c:param name="gen" value="1"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="sql"><c:param name="gen" value="2"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="sql2"><c:param name="gen" value="9"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="struts"><c:param name="gen" value="3"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="xml"><c:param name="gen" value="4"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="all"><c:param name="gen" value="5"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="hib"><c:param name="gen" value="6"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="report"><c:param name="gen" value="8"/><c:param name="dev" value="true"/></c:url>
    <c:url value="dynagen.do" var="formChanges"><c:param name="gen" value="10"/></c:url>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' content='Configuration' direct='true'/>
<template:put name='header' content='Configuration' direct='true'/>
<template:put name='help' content='Configuration' direct='true'/>
<template:put name='content' direct='true'>
<div id="forms">
<h2>Configuration</h2>
<logic:present role="RUN_SITE_SETUP">
<p><strong>Site</strong></p>
<ul>
	<li><a href="/${appName}/setup.do;jsessionid=${pageContext.request.session.id}">Site Configuration</a></li>
	<li><a href="/${appName}/admin/sites/list.do;jsessionid=${pageContext.request.session.id}">Add New Site Name</a> - Add new site when a site does not appear in the list from the link above.</li>
</ul>
</logic:present>
<p><strong>User</strong></p>
<c:url value="admin/records/list.do" var="users"><c:param name="formId" value="170"/></c:url>
<ul>
	<li><a href='<c:out value="/${appName}/${users}"/>'>Create and list Users</a></li>
<logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
    <li><html:link action="/admin/users">View and modify User Group Assignments</html:link></li>
</logic:present>
</ul>
<p><strong>Backup</strong></p>
<p>Click the following Backup link at the end of your day. Please be patient - this process takes a few minutes. This will create a new zip file in the backup directory (${backupDir}).
Copy the zip file to your memory stick.</p>
<ul>
	<li><html:link action="/admin/backups/backup">Backup Database</html:link></li>
</ul>
<p><strong>Updates</strong></p>
<p>Use the following links when instructed to download an update to the application or to apply an update manually.</p>
<c:url value="config/pending/update.do" var="downloadUpdates"><c:param name="update" value="1"/></c:url>
<c:url value="config/pending.do" var="viewPendingListing"></c:url>
<ul>
	<li><a href='<c:out value="/${appName}/${downloadUpdates}"/>'>Download updates</a></li>
	<li><a href='<c:out value="/${appName}/${viewPendingListing}"/>'>View updates</a></li>
</ul>
<p><strong>Appointment Threshold Notifications and Full Drug List</strong></p>
<p>Use the following form to edit the threshold for appointment notifications or to enable
dispensing all of the items in the stock list. Set display.all.drugs.when.dispensing to 0 to display only ARV and OI stock.
Set it to 1 to display all stock.
</p>
<c:url value="/admin/properties/edit.do" var="sitePropEdit"><c:param name="selectedLocale" value="default"/>
<c:param name="propFilename" value="site"/></c:url>
<ul>
	<li><a href='<c:out value="${sitePropEdit}"/>'>Site Properties</a></li>
</ul>

<logic:present role="CREATE_VIEW_MODIFY_INDIVIDUAL_PATIENT_RECORDS">
<p><strong>Pharmacy Application Administration</strong></p>
<ul>
<c:url value="admin/records/list.do" var="regime_groups"><c:param name="formId" value="128"/><c:param name="maxRows" value="0"/></c:url>
<c:url value="admin/records/list.do" var="regimen"><c:param name="formId" value="129"/><c:param name="maxRows" value="0"/></c:url>
<c:url value="admin/records/list.do" var="stock_groups"><c:param name="formId" value="130"/><c:param name="maxRows" value="0"/></c:url>
<c:url value="admin/records/list.do" var="stock"><c:param name="formId" value="131"/><c:param name="maxRows" value="0"/></c:url>
<c:url value="admin/records/list.do" var="regimen_item"><c:param name="formId" value="181"/><c:param name="maxRows" value="0"/></c:url>
<li><a href='<c:out value="/${appName}/${stock}"/>'>Stock</a> (items table)</li>
<li><a href='<c:out value="/${appName}/${stock_groups}"/>'>Stock Groups</a> (item_group table)</li>
<li><a href='<c:out value="/${appName}/${regimen}"/>'>Regimens</a></li>
<li><a href='<c:out value="/${appName}/${regime_groups}"/>'>Regimen Groups</a></li>
<li><a href='<c:out value="/${appName}/${regimen_item}"/>'>Regimen Stock</a> - Select items in a regimen - used to limit items that can be dispensed based on the patient's regimen.</li>
</ul>
</logic:present>
</div>
</template:put>
</template:insert>
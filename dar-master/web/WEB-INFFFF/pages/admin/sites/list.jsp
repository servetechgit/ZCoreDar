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
<template:put name='title' content='Admin: Site Admin' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: Site Admin</template:put>
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
<p>Create a new site in the following form. After this form is submitted, the new site will appear in the list below, which is in alphabetical order.</p>
            <html:form action="admin/sites/save" method="POST">
<table border="1" cellpadding="2" cellspacing="1">
    <tr>
        <td class="formrowlabel">Site Name: </td>
        <td><html:text property="name" size="35" styleId="name" maxlength="128"/></td>
        <td>The Site Name field should be a short, one word name (e.g.: Kasarani). It must not be a duplicate of any of the names in the list below.
		It must begin with a letter and contain only letters, underscore characters (_), and digits and be limited to 128 characters. </td>
    </tr>
    <tr>
        <td class="formrowlabel" colspan="2" align="right"><html:submit value="Save" onclick="bCancel=false;"/></td>
        <td>&nbsp;</td>
    </tr>
</table>
</html:form>
<h2>Site Listing</h2>
<p>Instructions: Double click each item to edit.</p>
<ul>
<li>The Site Name field should be a short, one word name (e.g.: Kasarani).
It must begin with a letter and contain only letters, underscore characters (_), and digits and be limited to 128 characters</li>
<li>The Abbreviation field should be a short, capitalized, 3 letter abbreviation of the name. (e.g.: KAS). It is often used by the system to create part of an Excel or XML filename.
It is also used to name a directory in the archive filesystem where archives and reports are stored.
The abbreviation must begin with a letter and contain only letters, underscore characters (_), and digits and be limited to 3-5 characters.</li>
</ul>
<table cellpadding="2" cellspacing="0" bgColor = "white" summary="Site list" border="1">
<tr class="patientrowheader">
<th>Site name</th>
<th>Abbreviation</th>
</tr>
    <c:forEach var="site" items="${sitelist}">
<tr>
    <td id="name${site.id}" ondblclick="getInputWidget('name${site.id}', 'site.name','${site.name}', 'site_name', '${site.id}', 40)" title="The Site Name field should be a short, one word name (e.g.: Kasarani). It must begin with a letter and contain only letters, underscore characters (_), and digits and be limited to 128 characters. ">${site.name}</td>
    <td id="abbreviation${site.id}" ondblclick="getInputWidget('abbreviation${site.id}', 'site.abbreviation','${site.abbreviation}', 'abbrev', '${site.id}', 40)" title="The Abbreviation field should be a short, one word name (e.g.: KAS). It is often used as part of an Excel or XML filename. It must begin with a letter and contain only letters, underscore characters (_), and digits and be limited to 3-5 characters." >${site.abbreviation}</td>
</tr>
</c:forEach>
</table>

</template:put>
</template:insert>
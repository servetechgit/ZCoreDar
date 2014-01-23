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
<%@ page import="org.rti.zcore.utils.SessionUtil"%>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:url value="dynagen.do" var="source"><c:param name="gen" value="1"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="openmrs"><c:param name="gen" value="12"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="sql"><c:param name="gen" value="2"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="sql2"><c:param name="gen" value="9"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="struts"><c:param name="gen" value="3"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="xml"><c:param name="gen" value="4"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="dyna"><c:param name="gen" value="5"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="hib"><c:param name="gen" value="6"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="report"><c:param name="gen" value="8"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="formChanges"><c:param name="gen" value="10"/></c:url>
<c:url value="dynagen.do" var="all"><c:param name="gen" value="11"/><c:param name="dev" value="true"/></c:url>
<c:url value="dynagen.do" var="localeLink"><c:param name="gen" value="13"/><c:param name="dev" value="true"/></c:url>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-home-print.jsp'>
<template:put name='title' direct='true'><bean:message bundle="ApplicationResources" key="admin.header.long"/></template:put>
<template:put name='header' direct='true'><bean:message bundle="ApplicationResources" key="admin.header.long"/></template:put>
<template:put name='help' direct='true'><bean:message bundle="ApplicationResources" key="admin.header.long"/></template:put>
<template:put name='content' direct='true'>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="theDate" value="${now}"/>
<fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${theDate}" var="dbNow" />
<script type="text/javascript" language="Javascript1.1">
function toggleAdminMenu(div1,div2,div3,div4,div5,div6,div7,div8) {
    var el = document.getElementById(div1);
    if (el != "visible")
    {
        el.style.visibility = "visible";
        el.style.display = "";
    }
    var el2 = document.getElementById(div2);
    var el3 = document.getElementById(div3);
    var el4 = document.getElementById(div4);
    var el5 = document.getElementById(div5);
    var el6 = document.getElementById(div6);
    var el7 = document.getElementById(div7);
    var el8 = document.getElementById(div8);
    el2.style.visibility = "hidden";
    el2.style.display = "none";
    el3.style.visibility = "hidden";
    el3.style.display = "none";
    el4.style.visibility = "hidden";
    el4.style.display = "none";
    el5.style.visibility = "hidden";
    el5.style.display = "none";
    el6.style.visibility = "hidden";
    el6.style.display = "none";
    el7.style.visibility = "hidden";
    el7.style.display = "none";
    el8.style.visibility = "hidden";
    el8.style.display = "none";
}
</script>
<div id="maincol-pad">
<!-- style="background-color: #2586D7; margin: 4px; width:620px; height:20px; color:#ffffff; font-size: 10pt; " -->
<br class="clearit" />

<div id="topnavContainer">
<ul id="topnavList">
<li><a href="#" onclick="toggleAdminMenu('formAdmin','properties','user','datacenter','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.form"/></a>
</li>
<li>
<a href="#" onclick="toggleAdminMenu('properties','formAdmin','user','datacenter','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.props"/></a>
</li>
<li><a href="#" onclick="toggleAdminMenu('user','properties','formAdmin','datacenter','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.user"/></a>
</li>
<li><a href="#" onclick="toggleAdminMenu('datacenter','properties','user','formAdmin','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.data"/></a>
</li>
<li><a href="#" onclick="toggleAdminMenu('lists','properties','user','datacenter','formAdmin','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.dropdowns"/></a>
</li>
<li><a href="#" onclick="toggleAdminMenu('testRecords','properties','user','datacenter','lists','formAdmin','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.tests"/></a>
</li>
<li><a href="#" onclick="toggleAdminMenu('deletePatients','properties','user','datacenter','lists','testRecords','formAdmin','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.links.delete"/></a>
</li>
<li><a href="#" onclick="toggleAdminMenu('infoLinks','properties','user','datacenter','lists','testRecords','formAdmin','deletePatients')">?</a></li>
</ul>
</div>
<br class="clearit" />
<h2><bean:message bundle="ApplicationResources" key="admin.index.header"/></h2>
<div id="infoLinks">
<table class="enhancedtable">
<tr>
<td><a href="#" onclick="toggleAdminMenu('formAdmin','properties','user','datacenter','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.form.header"/></a>
</td>
<td>Create and edit forms and fields</td>
</tr>

<tr>
<td><a href="#" onclick="toggleAdminMenu('properties','formAdmin','user','datacenter','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.prop.trans.menu.link"/></a>
</td>
<td>Edit text strings, translations, and menu items, which appear in the side navigation strip,</td>
</tr>

<tr>
<td><a href="#" onclick="toggleAdminMenu('user','properties','formAdmin','datacenter','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.user.admin"/></a>
</td>
<td>Create and edit user accounts</td>
</tr>

<tr>
<td><a href="#" onclick="toggleAdminMenu('datacenter','properties','user','formAdmin','lists','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.data.center.maintenance"/></a>
</td>
<td>Export and import data from remote sites</td>
</tr>

<tr>
<td><a href="#" onclick="toggleAdminMenu('lists','properties','user','datacenter','formAdmin','testRecords','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.list.admin"/></a>
</td>
<td>Edit items that appear in dropdowns</td>
</tr>

<tr>
<td><a href="#" onclick="toggleAdminMenu('testRecords','properties','user','datacenter','lists','formAdmin','deletePatients','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.test"/></a>
</td>
<td>Generate test records</td>
</tr>

<tr>
<td><a href="#" onclick="toggleAdminMenu('deletePatients','properties','user','datacenter','lists','testRecords','formAdmin','infoLinks')"><bean:message bundle="ApplicationResources" key="admin.index.delete"/></a>
</td>
<td>Delete multiple patients.</td>
</tr>

</table>
</div>
	<div id="formAdmin" style="visibility:hidden;display:none">
		<p><strong><bean:message bundle="ApplicationResources" key="admin.index.form.header"/></strong></p>
		 <ul>
		 	<li><html:link action="/admin/formList"><bean:message bundle="ApplicationResources" key="admin.index.form.index"/></html:link></li>
 			<li><html:link action="/admin/form/new"><bean:message bundle="ApplicationResources" key="admin.index.form.create"/></html:link></li>
 			<li><a href='<c:out value="/${appName}/admin/${formChanges}"/>' onclick="return confirm('Generate source, SQL, struts-config, and xml files for all changed forms?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.generate"/></a></li>
 			<li><html:link action="/admin/form/import"><bean:message bundle="ApplicationResources" key="admin.index.form.import"/></html:link></li>
 			<li><html:link action="/admin/field/import"><bean:message bundle="ApplicationResources" key="admin.index.field.import"/></html:link><bean:message bundle="ApplicationResources" key="admin.index.imports"/></li>
 			<li><html:link action="/admin/fieldList"><bean:message bundle="ApplicationResources" key="admin.index.field.list"/></html:link></li>
    		<li><html:link action="/admin/flow/list"><bean:message bundle="ApplicationResources" key="admin.flow.header"/></html:link></li>
    		<li><html:link action="/admin/ruleList"><bean:message bundle="ApplicationResources" key="admin.index.rules.list"/></html:link></li>
		    <li><html:link action="/admin/appupdates/view"><bean:message bundle="ApplicationResources" key="admin.index.app.update.log"/></html:link></li>
		    <c:url value="reload" var="reload"><c:param name="path" value="/${appName}"/></c:url>
		    <li><a href='<c:out value="/manager/html/${reload}"/>' onclick="return confirm('Reload app?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.reload"/></a></li>
		    </ul>

	    <p><strong><bean:message bundle="ApplicationResources" key="admin.index.codeGen"/></strong></p>
	    <p><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.desc"/></p>
	    <ul>
		    <li><a href='<c:out value="/${appName}/admin/${all}"/>' onclick="return confirm('Generate source, SQL, struts-config, and xml files?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.all"/></a>
		        <ul>
		            <li><a href='<c:out value="/${appName}/admin/${source}"/>' onclick="return confirm('Generate Only Dynasite source files?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.source"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${hib}"/>' onclick="return confirm('Generate Only Hibernate mapping files? Be sure to restart the app before clicking this link after generating dynasource');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.hib"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${sql}"/>' onclick="return confirm('Generate SQL Only');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.sql"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${sql2}"/>' onclick="return confirm('Generate SQL Delete Script Only');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.sql.delete"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${struts}"/>' onclick="return confirm('Generate dynaStruts.xml and dynaValidation.xml files Only ?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.struts"/></a><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.struts.desc"/></li>
		            <li><a href='<c:out value="/${appName}/admin/${xml}"/>' onclick="return confirm('Generate form xml Only? Please note that if you made changes to the order of a form, you should also click link above to Generate SQL.');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.xml"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${dyna}"/>' onclick="return confirm('Generate dynasite xml Only? ');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.xml.only"/></a><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.xml.only.message"/></li>
		            <li><a href='<c:out value="/${appName}/admin/${report}"/>' onclick="return confirm('Generate Report Source Only ?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.report"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${openmrs}"/>' onclick="return confirm('Generate OpenMRS Source Only ?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.openmrs"/></a></li>
		            <li><a href='<c:out value="/${appName}/admin/${localeLink}"/>' onclick="return confirm('Generate Locale Properties  Only ?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.locale"/></a><bean:message bundle="ApplicationResources" key="admin.index.dynasite.generate.locale.desc"/></li>
		         </ul>
		     </li>
	     </ul>
	</div>
	<div id="properties" style="visibility:hidden;display:none">
	<p><strong><bean:message bundle="ApplicationResources" key="admin.index.properties.default"/></strong></p>
	<p><bean:message bundle="ApplicationResources" key="admin.index.properties.desc1"/></p>
	 <ul>
		<li><bean:message bundle="ApplicationResources" key="admin.index.properties.default.instructions"/>
		 <ul>
		 	<c:url value="/admin/properties/edit.do" var="editAppFr"><c:param name="selectedLocale" value="default"/>
		 		<c:param name="propFilename" value="ApplicationResources"/></c:url>
		    <li><a href='<c:out value="${editAppFr}"/>'>ApplicationResources</a></li>
		 	<c:url value="/admin/properties/edit.do" var="editAppFr"><c:param name="selectedLocale" value="default"/>
		 		<c:param name="propFilename" value="TemplateResources"/></c:url>
		    <li><a href='<c:out value="${editAppFr}"/>'>TemplateResources</a></li>
		 	<c:url value="/admin/properties/edit.do" var="sitePropEdit"><c:param name="selectedLocale" value="default"/>
		 		<c:param name="propFilename" value="site"/></c:url>
		    <li><a href='<c:out value="${sitePropEdit}"/>'>Site Properties</a></li>
			</ul>
		</li>
	 	<li><html:link action="/admin/sortProperties"><bean:message bundle="ApplicationResources" key="admin.index.sort.props"/></html:link> - <bean:message bundle="ApplicationResources" key="admin.index.sort.props.desc"/></li>
	 	</ul>
	 <p><strong><bean:message bundle="ApplicationResources" key="admin.index.translations"/></strong></p>
	 <p><bean:message bundle="ApplicationResources" key="admin.index.properties.desc2"/></p>
	 	<ul>
		 	<li><bean:message bundle="ApplicationResources" key="admin.index.properties.instructions"/>
		 	<br/><bean:message bundle="ApplicationResources" key="admin.index.properties.instructions.add.translations"/> <html:link action="/admin/formList"><bean:message bundle="ApplicationResources" key="admin.index.form.header"/></html:link>
			 <ul>
			 	<c:forEach var='locale' items='${localeList}'>
				 	<c:url value="/admin/properties/edit.do" var="editAppFr"><c:param name="selectedLocale" value="${locale}"/>
				 		<c:param name="propFilename" value="ApplicationResources"/></c:url>
				    <li><a href='<c:out value="${editAppFr}"/>'>ApplicationResources
				    	 - ${locale}</a></li>
				 	<c:url value="/admin/properties/edit.do" var="editAppFr"><c:param name="selectedLocale" value="${locale}"/>
				 		<c:param name="propFilename" value="TemplateResources"/></c:url>
				    <li><a href='<c:out value="${editAppFr}"/>'>TemplateResources
				    	 - ${locale}</a></li>
			    </c:forEach>
			 </ul>
			 </li>
	 	</ul>
	 	<!-- <p><strong><bean:message bundle="ApplicationResources" key="admin.index.menu"/></strong></p>
		<p><bean:message bundle="ApplicationResources" key="admin.index.menu.desc"/></p>
		<ul>
			<c:url value="admin/records/list.do" var="menu"><c:param name="className" value="MenuItem"/></c:url>
			<li><a href='<c:out value="/${appName}/${menu}"/>'><bean:message bundle="ApplicationResources" key="admin.index.menu.link"/></a></li>
			-->
			<!--
			<c:url value="admin/data/import.do" var="menuImport"><c:param name="fileName" value="MenuItemList.js"/></c:url>
			<li><a href='<c:out value="/${appName}/${menuImport}"/>' onclick="return confirm('<bean:message bundle="ApplicationResources" key="admin.index.menu.import.link.warning"/>');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.menu.import.link"/></a> - <bean:message bundle="ApplicationResources" key="admin.index.menu.import.desc"/></li>
		 -->
		<!-- </ul> -->
		 
	</div>

	<div id="user" style="visibility:hidden;display:none">
	<p><strong><bean:message bundle="ApplicationResources" key="admin.index.user.admin"/></strong></p>
	<c:url value="admin/records/list.do" var="users"><c:param name="formId" value="170"/></c:url>
	<p><bean:message bundle="ApplicationResources" key="admin.index.user.add.message"/></p>
	<ul>
		<li><a href='<c:out value="/${appName}/${users}"/>'><bean:message bundle="ApplicationResources" key="admin.index.users"/></a></li>
	    <li><html:link action="/admin/users"><bean:message bundle="ApplicationResources" key="admin.index.users.groups"/></html:link></li>
	</ul>
	</div>
	<div id="datacenter" style="visibility:hidden;display:none">
	<p><strong><bean:message bundle="ApplicationResources" key="admin.index.data.center.maintenance"/></strong></p>
	<ul>
		<li><html:link action="/admin/subscription/new"><bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/></html:link><bean:message bundle="ApplicationResources" key="admin.index.subscribe.desc"/></li>
	    <li><html:link action="/admin/publisher/new"><bean:message bundle="ApplicationResources" key="admin.index.publish"/></html:link><bean:message bundle="ApplicationResources" key="admin.index.publish.desc"/></li>
	    <li><html:link action="/admin/sync/verify"><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></html:link> - <bean:message bundle="ApplicationResources" key="admin.index.sync.verify.desc"/></li>
	    <li><html:link action="/admin/server/new"><bean:message bundle="ApplicationResources" key="admin.index.master.site.server"/></html:link> - <bean:message bundle="ApplicationResources" key="admin.index.master.desc"/></li>
	    <li><html:link action="/admin/createDirectories"><bean:message bundle="ApplicationResources" key="admin.index.archive"/></html:link></li>
	    <li><html:link action="/admin/cleanDirectories" onclick="return confirm('Caution: Are you sure you want to delete all files (except some form data) in the archive?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.archive.clean"/></html:link><bean:message bundle="ApplicationResources" key="admin.index.archive.clean.desc"/></li>
	    <c:url value="deleteAdmin.do" var="deleteAdmin"><c:param name="edate" value="${dbNow}"/></c:url>
	    <li><a href='<c:out value="/${appName}/admin/${deleteAdmin}"/>' onclick="return confirm('Caution: Are you sure you want to delete all admin records (except for stock-related tables)?');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.records.admin.delete"/></a><bean:message bundle="ApplicationResources" key="admin.index.records.admin.delete.desc"/></li>
	    <%
	    if (SessionUtil.getInstance(request.getSession()).isClientConfigured()) {
            String siteAbbrev = SessionUtil.getInstance(session).getClientSettings().getSite().getAbbreviation();
            request.setAttribute("siteAbbrev", siteAbbrev);
        }
	    %>
	    <c:url value="import.do" var="importData">
	        <c:param name="url" value="importData"/>
	        <c:param name="reload" value="1"/>
	        <c:param name="siteAbbrev" value="${siteAbbrev}"/>
        </c:url>
	    <li><a href='<c:out value="/${appName}/admin/${importData}"/>' onclick="return confirm('Caution: Are you sure you want to import data?');self.close();">Import data (Place data in webapps/archive/SITE/import)</a></li>
	    <li><html:link action="/admin/backups/backup"><bean:message bundle="ApplicationResources" key="admin.index.database.backup"/></html:link></li>
	  	<li><html:link action="/admin/decrypt/list"><bean:message bundle="ApplicationResources" key="admin.index.decrypt"/></html:link> - <bean:message bundle="ApplicationResources" key="admin.index.decrypt.desc"/></li>
	    <li><html:link action="/admin/identifier/assign">Assign Identifiers to patients w/out identifiers</html:link></li>
	    <li><html:link action="/admin/restorePatient"><bean:message bundle="ApplicationResources" key="admin.index.patient.restore"/></html:link><bean:message bundle="ApplicationResources" key="admin.index.patient.import.desc"/></li>
	    <li><html:link action="/admin/derbyDatabaseSizeList"><bean:message bundle="ApplicationResources" key="admin.index.database.compact"/></html:link><bean:message bundle="ApplicationResources" key="admin.index.database.compact.desc"/></li>
	    <li><html:link action="/admin/sql/new"><bean:message bundle="ApplicationResources" key="admin.index.sql.console"/></html:link></li>
	    <!-- DAR-specific -->
	    <!--
	    <li><html:link action="/admin/updateBalance">Update Stock Control balances</html:link> - be very careful here - updates all balances for all stock items.</li>
	     -->
	</ul>
	<%--
	    <li><html:link href="/${appName}/admin/sql/new.do;jsessionid=${pageContext.request.session.id}?mail=1">Refresh Mail Database</html:link></li>

	    <li><html:link action="/admin/propogateUpdates" onclick="return confirm('Propogate updates to remote sites?');self.close();">Propogate Updates</html:link></li>
	    --%>
	<p><strong><bean:message bundle="ApplicationResources" key="admin.index.scheduler"/></strong></p>

	<p><bean:message bundle="ApplicationResources" key="admin.index.scheduler.desc"/><br/><bean:message bundle="ApplicationResources" key="admin.index.scheduler.desc2"/><br/><bean:message bundle="ApplicationResources" key="admin.index.scheduler.desc3"/><br/>
		<ul>
		    <c:url value="scheduler.do" var="start"><c:param name="action" value="start"/></c:url>
		    <c:url value="scheduler.do" var="stop"><c:param name="action" value="stop"/></c:url>
		    <c:url value="scheduler.do" var="list"><c:param name="action" value="list"/></c:url>
			<li><a href='<c:out value="/${appName}/admin/${start}"/>'><bean:message bundle="ApplicationResources" key="admin.index.start"/></a> | <a href='<c:out value="/${appName}/admin/${stop}"/>'><bean:message bundle="ApplicationResources" key="admin.index.stop"/></a>
			 | <a href='<c:out value="/${appName}/admin/${list}"/>'><bean:message bundle="ApplicationResources" key="admin.index.list"/></a></li>
		</ul>
	</p>

	<c:url value="admin/sql/update.do" var="updateAdmin"><c:param name="adminUpdate" value="1"/></c:url>
	<c:url value="admin/sql/update.do" var="restartNumbering"><c:param name="adminUpdate" value="renumberOnly"/></c:url>
	<c:url value="admin/sql/update.do" var="restartNumberingAdmin"><c:param name="adminUpdate" value="renumberOnly"/><c:param name="schema" value="ADMIN"/></c:url>
	<c:url value="admin/sql/update.do" var="restartNumberingApp"><c:param name="adminUpdate" value="renumberOnly"/><c:param name="schema" value="APP"/></c:url>
	<p><strong><bean:message bundle="ApplicationResources" key="admin.index.application.updates"/></strong></p>
	<ul>
	    <bean:define id="backupAdmin" value="admin"/>
	    <li><html:link action="/admin/backups/backup" paramId="backupType" paramName="backupAdmin"><bean:message bundle="ApplicationResources" key="admin.index.database.backup.admin"/></html:link></li>
	    <bean:define id="backupApp" value="app"/>
	    <li><html:link action="/admin/backups/backup" paramId="backupType" paramName="backupApp"><bean:message bundle="ApplicationResources" key="admin.index.database.backup.app"/></html:link></li>
	    <li><html:link action="/admin/ExportStockUpdate"><bean:message bundle="ApplicationResources" key="admin.index.database.ExportStockUpdate"/></html:link></li>
	    <li><a href='<c:out value="/${appName}/${updateAdmin}"/>' onclick="return confirm('<bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.confirm"/>');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.database.update.admin"/></a> - <bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.desc"/>
	    <li><bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.renumber"/>
	    	<ul>
		    	<li><a href='<c:out value="/${appName}/${restartNumberingAdmin}"/>' onclick="return confirm('<bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.renumber.admin.confirm"/>');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.renumber.admin"/></a> - <bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.renumber.desc"/></li>
		    	<li><a href='<c:out value="/${appName}/${restartNumberingApp}"/>' onclick="return confirm('<bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.renumber.app.confirm"/>');self.close();"><bean:message bundle="ApplicationResources" key="admin.index.database.update.admin.renumber.app"/></a></li>
		    </ul>
	    </li>
	    <li><html:link action="/admin/verifySchema"><bean:message bundle="ApplicationResources" key="admin.index.database.update.schema"/></html:link> - <bean:message bundle="ApplicationResources" key="admin.index.database.update.schema.desc"/></li>
	    <li><html:link action="/admin/app/update"><bean:message bundle="ApplicationResources" key="admin.index.database.update.application"/></html:link> - <bean:message bundle="ApplicationResources" key="admin.index.database.update.application.desc"/></li>
	</ul>
	</div>
	<div id="lists" style="visibility:hidden;display:none">
	<c:if test="${! empty adminforms}">
	<p><strong><bean:message bundle="ApplicationResources" key="admin.index.list.admin"/></strong></p>
	<p><bean:message bundle="ApplicationResources" key="admin.index.list.desc"/></p>
	<table class = "enhancedtable">
	<c:forEach items="${adminforms}" var="adminform">
	<tr>
		<logic:present name="${adminform.classname}Messages">
		<th><bean:message key="${adminform.classname}.label" bundle="${adminform.classname}Messages" /></th>
		<td><a href="/${appName}/<c:url value='admin/records/list.do'><c:param name='formId' value='${adminform.id}'/></c:url>"><bean:message bundle="ApplicationResources" key="admin.index.list.create"/></a></td>
		<td><a href="/${appName}/<c:url value='admin/exportData.do'><c:param name='objectFormId' value='${adminform.id}'/></c:url>"><bean:message bundle="ApplicationResources" key="admin.index.list.export"/></a></td>
		</logic:present>
		<logic:notPresent name="${adminform.classname}Messages">
		<td>${adminform.label}</td>
		<td><a href="/${appName}/<c:url value='admin/records/list.do'><c:param name='formId' value='${adminform.id}'/></c:url>"><bean:message bundle="ApplicationResources" key="admin.index.list.create"/></a></td>
		<td><a href="/${appName}/<c:url value='admin/exportData.do'><c:param name='objectFormId' value='${adminform.id}'/></c:url>"><bean:message bundle="ApplicationResources" key="admin.index.list.export"/></a></td>
		</logic:notPresent>
		</tr>
	</c:forEach>
	</table>
	</c:if>
	</div>
	<div id="testRecords" style="visibility:hidden;display:none">

	    <p><strong><bean:message bundle="ApplicationResources" key="admin.index.test"/></strong></p>
	    <p><bean:message bundle="ApplicationResources" key="admin.index.test.warn"/></p>
	    <p>Click "One" to create a single test patient, 10 to create ten, etc.</p>
	        <ul>
	             <li>Child client - Regimen CF1A: <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?patientType=child">One</html:link>
	             <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1&patientType=child" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	          | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5&patientType=child" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	             </li>
	             <li>Adult client - Regimen AF1A: <html:link action="/admin/createPatient.do">One</html:link> | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	         | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	         | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=10" onclick="return confirm('Create 100 test patients? This will take a little while.');self.close();">100</html:link>
	         | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=50" onclick="return confirm('Create 500 test patients? Phew! This will take a while.');self.close();">500</html:link>
	         | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=100" onclick="return confirm('Create 1000 test patients? Phew! This will take a while.');self.close();">1000</html:link>
	         | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=500" onclick="return confirm('Create 5000 test patients? Phew! This will take a while.');self.close();">5000</html:link>
	         </li>
	             <li>Adult client - Regimen AF1B: <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?patientType=AF1B">One</html:link> 
	             | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1&patientType=AF1B" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	          | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5&patientType=AF1B" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	          </li>
	             <li>Adult client - Regimen AF1C: <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?patientType=AF1C">One</html:link>
	             | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1&patientType=AF1C" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	          | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5&patientType=AF1C" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	             </li>
	             <li>Adult client - Regimen AF2A: <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?patientType=AF2A">One</html:link> 
	             | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1&patientType=AF2A" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	          | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5&patientType=AF2A" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	          </li>
	             <li>Adult client - Regimen AF2B: <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?patientType=AF2B">One</html:link> 
	             | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1&patientType=AF2B" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	          | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5&patientType=AF2B" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	             </li>
	             <li>Adult client - Regimen AF2C: <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?patientType=AF2C">One</html:link> 
	              | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=1&patientType=AF2C" onclick="return confirm('Create 10 test patients? This will take about a second.');self.close();">10</html:link>
	          | <html:link href="createPatient.do;jsessionid=${pageContext.request.session.id}?number=5&patientType=AF2C" onclick="return confirm('Create 50 test patients? This will take a minute or so.');self.close();">50</html:link>
	             </li>
	         </ul>
	</div>
	<div id="deletePatients" style="visibility:hidden;display:none">
	<h2><bean:message bundle="ApplicationResources" key="admin.index.delete"/></h2>
	<p><bean:message bundle="ApplicationResources" key="admin.index.delete.desc"/>
	<br/><bean:message bundle="ApplicationResources" key="admin.index.delete.archive.desc"/></p>
	<script type="text/javascript" src="/${appName}/config/javascript.js;jsessionid=${pageContext.request.session.id}"></script>
	<html:form action="/admin/deletePatient">
	<table cellspacing="0" cellpadding="5" class="enhancedtabletighterCell">
		<tr>
	        <th><bean:message bundle="ApplicationResources" key="admin.index.site"/></th>
	        <th><bean:message bundle="ApplicationResources" key="admin.index.begin.date"/></th>
	        <th><bean:message bundle="ApplicationResources" key="admin.index.end.date"/></th>
	        <th><bean:message bundle="ApplicationResources" key="admin.index.delete.archive"/></th>
	        <th></th>
	    </tr>
	    <tr>
			<td>
	           <select id="siteSelector" name="siteId">
	               <option value=""><bean:message bundle="ApplicationResources" key="admin.index.select.date"/></option>
	                       <option value="all"><bean:message bundle="ApplicationResources" key="admin.index.all.sites"/></option>
	                       <c:forEach var="site" begin="0" items="${sites}">
	                           <c:if test="${site.inactive != 1}">
	                           <option value="${site.id}">${site.name}</option>
	                           </c:if>
	                       </c:forEach>
	               <option value="42"><bean:message bundle="ApplicationResources" key="admin.index.old.uth"/></option>
	           </select>
	       </td>
	       	<td><zeprs:date_visit_no_form_no_label element="lazyForm" field="bdate|bdate1" /></td>
			<td><zeprs:date_visit_no_form_no_label element="lazyForm" field="edate|edate1" /></td>
			<td><input type="checkbox" name="isLogged" value="1"/></td>
			<td><center><html:submit /></center></td>
		</tr>
	</table>
	   </html:form>
<!-- DAR-specific -->
	   <h2>Delete stock</h2>
<p>Deletes all stock entered in the Stock Control form. Careful!
Consider backing up the database before doing this operation.
<html:link href="deleteStock.do;jsessionid=${pageContext.request.session.id}" onclick="return confirm('Delete all Stock? This will take a minute or so.');self.close();">Delete Stock</html:link></p>

	</div>
</div>
</template:put>
</template:insert>
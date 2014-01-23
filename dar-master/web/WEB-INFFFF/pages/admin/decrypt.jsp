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
<template:put name='title' direct='true'><bean:message bundle="ApplicationResources" key="admin.index.decrypt"/></template:put>
<template:put name='header' direct='true'><bean:message bundle="ApplicationResources" key="admin.index.decrypt"/></template:put>

<template:put name='content' direct='true'>
		<p>Click a link on the following files in the backup directory to decrypt it.</p>
		<table cellpadding="2" cellspacing="0" bgColor="white" border="1">
			<tr class="patientrowheader">
				<th>File name</th>
			</tr>
			<c:forEach var="file" items="${fileList}" varStatus="status">
			<c:url value="admin/decrypt/save.do" var="decrypt"><c:param name="fileName" value="${path}${file}"/></c:url>
			<tr><td><a href='<c:out value="/${appName}/${decrypt}"/>'>${file}</a></td></tr>
			</c:forEach>
		</table>
	</template:put>
</template:insert>
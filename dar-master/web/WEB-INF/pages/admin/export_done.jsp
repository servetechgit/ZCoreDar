<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-print.jsp'>
<template:put name='title' content='Export Patient Records' direct='true'/>
<template:put name='header' content='Export Patient Records' direct='true'/>
<template:put name='content' direct='true'>
	<div id="maincol-pad">
		<c:if test="${! empty message}"><p>${message}</p></c:if>
		<c:if test="${! empty fileList}">
			<p>File in the openmrs/archive directory:</p>
			<table class="enhancedtable">
			<tr>
				<th>File</th>
				<th>Last Modified</th>
			</tr>
			<c:forEach items="${fileList}" var="item">
			<tr>
				<td><a href="${prefix}${item.fileName}">${item.fileName}</a></td>
				<td>${item.lastModified}</td>
			</tr>
			</c:forEach>
			</table>
		</c:if>
	</div>
</template:put>
</template:insert>
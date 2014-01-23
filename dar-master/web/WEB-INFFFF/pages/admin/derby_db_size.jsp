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
    <template:put name='title' content='Admin: Derby Database Size' direct='true'/>
    <template:put name='header' content='Admin: Derby Database Size' direct='true'/>
    <template:put name='content' direct='true'>
        <html:errors/>

                <p>
The following table lists the size of each table or index in the database.
                </p>
                <p>
<c:url value="derbyDatabaseCompact.do" var="compact"><c:param name="compact" value="compact"/></c:url>
If there is a large number for Estimate Space Savings, click the <a href='<c:out value="/${appName}/admin/${compact}"/>'>Compact database</a>.
                </p>
<table class="enhancedtable">
<tr>
  <th>Table or Index</th>
  <th>Index?</th>
  <th>Number of Allocated Pages</th>
  <th>Number of Free Pages</th>
  <th>Number of Unfilled Pages</th>
  <th>Page Size</th>
  <th>Estimated Space Saving</th>
</tr>

<c:forEach var="item" begin="0" items="${items}">
  <tr>
    <td>${item.conglomerateName}</td>
    <td><c:if test="${item.isIndex ==1}">Yes</c:if></td>
    <td>${item.numAllocatedPages}</td>
    <td>${item.numFreePages}</td>
    <td>${item.numUnfilledPages}</td>
    <td>${item.pageSize}</td>
    <td>${item.estimSpaceSaving}</td>
  </tr>
</c:forEach>
</table>
    </template:put>
</template:insert>
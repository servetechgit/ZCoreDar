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
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' content='User Administration' direct='true'/>
<template:put name='header' content='' direct='true'/>
<template:put name='content' direct='true'>
    <script language="JavaScript" type='text/javascript' src='/${appName}/dwruseradmin/util.js;jsessionid=${pageContext.request.session.id}'></script>
    <script language="JavaScript" type='text/javascript' src='/${appName}/dwruseradmin/interface/User.js;jsessionid=${pageContext.request.session.id}'></script>
    <script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-user-admin.js;jsessionid=${pageContext.request.session.id}"></script>
    <script language="JavaScript" type='text/javascript' src='/${appName}/dwrdisplay/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
    <script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-generic.js;jsessionid=${pageContext.request.session.id}"></script>
    <script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-display.js;jsessionid=${pageContext.request.session.id}"></script>
    <script src="/${appName}/js/scriptaculous/prototype.js" type="text/javascript"></script>
	<script src="/${appName}/js/scriptaculous/scriptaculous.js" type="text/javascript"></script>
    <c:choose>
        <c:when test="${! empty param.rowCount}">
            <c:set var="rowCount" value="${param.rowCount}"/>
        </c:when>
        <c:otherwise>
            <c:set var="rowCount" value="15"/>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${! empty param.offset}">
            <c:set var="offset" value="${param.offset}"/>
        </c:when>
        <c:otherwise>
            <c:set var="offset" value="0"/>
        </c:otherwise>
    </c:choose>
    <div id="widePage">
        <h2><bean:message bundle="ApplicationResources" key="admin.index.user.admin"/></h2>
        <p><bean:message bundle="ApplicationResources" key="admin.user.groups.search"/><html:form action="admin/users.do">
                <input id="searchBox" type="text" size="15" maxlength="20" name="searchUsername">
                <html:submit><bean:message bundle="ApplicationResources" key="submit"/></html:submit>
                <c:if test="${! empty error}"><p class="error">${error}</p></c:if>
            </html:form>
            </p>
        <p><bean:message bundle="ApplicationResources" key="admin.user.groups.instructions"/></p>
        <table class="enhancedtable">
            <tr>
                <th><bean:message bundle="ApplicationResources" key="admin.user.groups.surname"/></th>
                <th><bean:message bundle="ApplicationResources" key="admin.user.groups.firstnames"/></th>
                <th><bean:message bundle="ApplicationResources" key="admin.user.groups.username"/></th>
                <th><bean:message bundle="ApplicationResources" key="admin.user.groups.group"/></th>
            </tr>
        <logic:iterate id="user" name="users">
               <tr>
                   <td>${user.lastName}</td>
                   <td>${user.firstName}</td>
                   <td>${user.id}</td>
                   <td id="group${user.id}" ondblclick="callGroups('${user.id}')">
                       <span id="value${user.id}" class="renderedValue">${user.groupName}</span>
                       <span id="widget${user.id}"></span>
                   </td>
               </tr>
        </logic:iterate>
            <c:choose>
                <c:when test="${! empty search}">
                <tr>
                    <td colspan="4" align="center"><html:link href="users.do;jsessionid=${pageContext.request.session.id}"><bean:message bundle="ApplicationResources" key="admin.user.groups.browse"/></html:link></td>
                </tr>
                </c:when>
                <c:otherwise>
                 <tr>
                     <td colspan="4">&nbsp;</td>
            </tr>
                </c:otherwise>
            </c:choose>
    </table>
    </div>
</template:put>
</template:insert>
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-print.jsp'>
    <template:put name='title' content='Admin: Subscriptions' direct='true'/>
    <template:put name='header' content='Admin: Subscriptions' direct='true'/>
    <template:put name='content' direct='true'>
    <div id="maincol-pad">
    <h2><bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/></h2>
    <p>
    <html:link action="/admin/home"><bean:message bundle="ApplicationResources" key="admin.formlist.admin"/></html:link> :
    <html:link action="/admin/publisher/new"><bean:message bundle="ApplicationResources" key="admin.index.publish"/></html:link> :
    <bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/> :
    <html:link action="/admin/server/new"><bean:message bundle="ApplicationResources" key="admin.index.master.site.server"/></html:link> :
    <html:link action="/admin/sync/verify"><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></html:link>
    </p>
        <script type='text/javascript'
                src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
        <script type='text/javascript'
                src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
        <script type='text/javascript'
                src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>
        <html:errors/>
        <c:if test="${! empty message}">
             <p class="bold">${message}</p>
        </c:if>
        <div>
            <p><bean:message bundle="ApplicationResources" key="admin.subscription.sitebegin"/>&nbsp;<strong>${urlProtocol}://</strong></p>
            <html:form action="admin/subscription/save" method="POST">
                <div class="row">
                    <span class="label"><bean:message bundle="ApplicationResources" key="admin.subscription.url"/></span>
                    <span class="formw"><html:text property="url" size="60"/></span>
                </div>
                <div class="row">
                    <span class="label"><bean:message bundle="ApplicationResources" key="admin.subscription.site"/></span>
                    <span class="formw"><html:text property="site" size="12"/></span>
                    <span class="label2"><bean:message bundle="ApplicationResources" key="admin.subscription.siteInstanceId"/></span>
                    <span class="formw"><html:text property="siteInstanceId" size="12"/></span>
                </div>
                <div class="row">
                    <span class="label"><bean:message bundle="ApplicationResources" key="server.username"/></span>
                    <span class="formw"><input type="text" size="12" name="username" autocomplete="off"/></span>
                    <span class="label2"><bean:message bundle="ApplicationResources" key="password"/></span>
                    <span class="formw"><input type="password" size="12" name="password" autocomplete="off"/></span>
                </div>
                <div class="row">
                    <span class="label"><bean:message bundle="ApplicationResources" key="server.serverType"/></span>
                    <span class="formw">
                    	<html:select styleId="serverType" property="serverType" onchange="toggleField('dropdown', 'webdav', 'webdavOptions','serverType', 1);" >
                    	<html:option value="" > -- </html:option>
                    		<html:option value="webdav" >webdav</html:option>
                    	</html:select>
                    </span>
                </div>
                <div class="row" style="display:none"  id="webdavOptions">
                    <span class="label"><bean:message bundle="ApplicationResources" key="server.authenticationType"/></span>
                    <span class="formw">
	                    <html:select property="authenticationType">
	                    	<html:option value="ntlm">ntlm</html:option>
	                    	<html:option value="digest">digest</html:option>
	                    </html:select>
                    </span>
                    <span class="label2"><bean:message bundle="ApplicationResources" key="admin.subscription.domain"/></span>
                    <span class="formw"><html:text property="domain" size="12"/></span>
                </div>
                <div class="row">
                    <span class="label"></span>
                    <span class="formw"><html:submit value="Save"/></span>
                </div>
            </html:form>
        </div>
        <c:if test="${! empty subscriptions}">
            <div class="row" style="width:700px;">
                <p>&nbsp;</p>
                <p class="bold"><bean:message bundle="ApplicationResources" key="admin.subscription.current"/></p>

                <p><bean:message bundle="ApplicationResources" key="admin.subscription.instructions"/></p>
                <table class="enhancedtable">
                    <tr>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.site"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.urlheader"/></th>
                        <!--<th>Record listing</th>
                        -->
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.reload"/></th>
                        <!--<th><bean:message bundle="ApplicationResources" key="admin.subscription.client"/></th>
                        -->
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.delete"/></th>
                    </tr>
                    <c:forEach items="${subscriptions}" var="subscription">
                        <c:url value="admin/import.do" var="updateLink"><c:param name="siteInstanceId" value="${subscription.siteInstanceId}"/><c:param name="url" value="${subscription.url}"/><c:param name="siteAbbrev" value="${subscription.site}"/></c:url>
                        <c:url value="admin/import.do" var="reloadLink">
	                        <c:param name="id" value="${subscription.id}"/>
	                        <c:param name="url" value="${subscription.url}"/>
	                        <c:param name="siteInstanceId" value="${subscription.siteInstanceId}"/>
	                        <c:param name="siteAbbrev" value="${subscription.site}"/>
	                        <c:param name="siteId" value="${subscription.id}"/>
	                        <c:param name="reload" value="1"/>
                        </c:url>
                        <c:url value="admin/import.do" var="importLink"><c:param name="siteInstanceId" value="${subscription.siteInstanceId}"/><c:param name="url" value="${subscription.url}"/><c:param name="siteAbbrev" value="${subscription.site}"/><c:param name="start" value="1"/></c:url>
                        <c:url value="admin/import.do" var="viewLink"><c:param name="id" value="${subscription.id}"/><c:param name="url" value="${subscription.url}"/><c:param name="view" value="1"/><c:param name="siteId" value="${subscription.id}"/></c:url>
                        <c:url value="admin/subscription/delete.do" var="deleteLink"><c:param name="siteInstanceId" value="${subscription.siteInstanceId}"/><c:param name="url" value="${subscription.url}"/><c:param name="siteAbbrev" value="${subscription.site}"/></c:url>
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${ ! empty subscription.site}"><a href='<c:out value="/${appName}/${updateLink}"/>'><span><bean:message bundle="ApplicationResources" key="general.update"/></span> ${subscription.site}</a></c:when>
                                    <c:otherwise><a href='<c:out value="/${appName}/${importLink}"/>'><bean:message bundle="ApplicationResources" key="general.import"/></a></c:otherwise>
                                </c:choose></td>
                            <td><a href="${subscription.url}">${subscription.url}</a></td>
                            <!--<td><a href='<c:out value="/${appName}/${viewLink}"/>'>Patients</a></td>
                            --><td><a href='<c:out value="/${appName}/${reloadLink}"/>'><span><bean:message bundle="ApplicationResources" key="general.reload"/></span> ${subscription.site}</a></td>
                            <!--<td><input type="text" id="patientId" onchange="importPatient('${subscription.url}', '${pageContext.request.session.id}')"/></td>
                            --><c:if test="${empty subscription.autoSubscription}">
                                 <td><a href='<c:out value="/${appName}/${deleteLink}"/>'onclick="return confirm('Caution: Are you sure you want to delete this subscription?');self.close();">X</a></td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:if>
         <c:if test="${! empty logs}">
        	<c:url var="nextUrl" value="admin/subscription/new.do">
			<c:param name="searchString" value="${searchString}"/>
			<c:param name="offset" value="${offset}"/>
			</c:url>
			<c:url var="prevURL" value="admin/subscription/new.do">
			<c:param name="searchString" value="${searchString}"/>
			<c:param name="prevRows" value="${prevRows}"/>
			</c:url>
             <div class="row">
                  <p class="bold"><bean:message bundle="ApplicationResources" key="admin.subscription.update"/></p>
                  <p><bean:message bundle="ApplicationResources" key="admin.subscription.log.header"/></p>
                   <table cellpadding="2" cellspacing="4" bgColor="white" width="100%">
			            <tr>
			            	<td><p><c:if test="${! empty prevRows}"><a href='<c:out value="/${appName}/${prevURL}"/>'">&lt;&lt;</a></c:if>
							<c:if test="${empty prevRows}">&lt;&lt;</c:if>
							<bean:message key="search.navigation" bundle="TemplateResources" />
							<c:if test="${! empty offset}"><a href='<c:out value="/${appName}/${nextUrl}"/>'">&gt;&gt;</a></c:if>
							<c:if test="${empty offset}">&gt;&gt;</c:if>
							</p></td>
						</tr>
			        </table>
                  <table class="enhancedtable">
                    <tr>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.update.local"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.update.remote"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.site"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.messages"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.errors"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.uuid"/></th>
                        <th><bean:message bundle="ApplicationResources" key="admin.subscription.update.type"/></th>
                    </tr>
                    <c:forEach items="${logs}" var="log">
                    <bean:define id="commentsR1" value="${fn:replace(log.comments,';','<br>')}" />
                    <bean:define id='exceptionMessageSpan' value='<span class="error">exceptionMessage</span>' />
                    <bean:define id="commentsR2" value="${fn:replace(commentsR1,'exceptionMessage',exceptionMessageSpan)}" />
                    <bean:define id="errorsR1" value="${fn:replace(log.errors,';','<br>')}" />
                    <fmt:formatDate value="${log.builddate}" pattern="yyyy/MMM/W" var="archivePath"/>
                        <tr>
                            <td>${log.updated}</td>
                            <td>${log.builddate}</td>
                            <td>${log.site}</td>
                            <td>${fn:replace(commentsR2,'SyncLog','<br><strong>SyncLog</strong>')}</td>
                            <td>${fn:replace(errorsR1,'SyncLog','<br><strong>SyncLog</strong>')}</td>
                            <td>
                            <c:choose>
                            	<c:when test="${log.updateType == 1}"><a href="/archive/${log.site}/log/complete/<c:out value='${archivePath}'/>/syncEvent_${log.objectUuid}.json">${log.objectUuid}</a></c:when>
                            	<c:when test="${log.updateType == 2}"><a href="/archive/${log.site}/import/<c:out value='${archivePath}'/>/importResults_syncEvent_${log.objectUuid}.json">${log.objectUuid}</a></c:when>
                            </c:choose>
                            </td>
                            <td>
                            <c:choose>
                            	<c:when test="${log.updateType == 1}">export SyncEvent</c:when>
                            	<c:when test="${log.updateType == 2}">import SyncEvent</c:when>
                            </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
			        <table cellpadding="2" cellspacing="4" bgColor="white" width="100%">
			            <tr>
			            	<td><p><c:if test="${! empty prevRows}"><a href='<c:out value="/${appName}/${prevURL}"/>'">&lt;&lt;</a></c:if>
							<c:if test="${empty prevRows}">&lt;&lt;</c:if>
							<bean:message key="search.navigation" bundle="TemplateResources" />
							<c:if test="${! empty offset}"><a href='<c:out value="/${appName}/${nextUrl}"/>'">&gt;&gt;</a></c:if>
							<c:if test="${empty offset}">&gt;&gt;</c:if>
							</p></td>
						</tr>
					</table>
	        </div>
         </c:if>
         </div>
    </template:put>
</template:insert>
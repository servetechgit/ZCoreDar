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
<%
    java.net.InetAddress i = java.net.InetAddress.getLocalHost();
    String ipAddress = i.getHostAddress();
    pageContext.setAttribute("ipAddress", ipAddress);
%>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-print.jsp'>
    <template:put name='title' content='Admin: Publisher' direct='true'/>
    <template:put name='header' content='Admin: Publisher' direct='true'/>
    <template:put name='content' direct='true'>
<div id="maincol-pad">

    <h2><bean:message bundle="ApplicationResources" key="admin.index.publish"/></h2>
    <p>
    <html:link action="/admin/home"><bean:message bundle="ApplicationResources" key="admin.formlist.admin"/></html:link> :
    <bean:message bundle="ApplicationResources" key="admin.index.publish"/> :
    <html:link action="/admin/subscription/new"><bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/></html:link> :
    <html:link action="/admin/server/new"><bean:message bundle="ApplicationResources" key="admin.index.master.site.server"/></html:link> :
    <html:link action="/admin/sync/verify"><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></html:link>

    </p>
        <html:errors/>
        <c:if test="${! empty publisher}">
            <p>This server is currently publishing the site <strong>${publisher.site.name}</strong>.</p>
        </c:if>
        <div>
                <p>
If you want to share data from this application with other pc's or servers on your network,
select this site from the dropdown, the location, enter the ip address or DNS-friendly name (dc.server.org) of this pc, and press the Save button.
                </p>
            <html:form action="admin/publisher/save" method="POST">
                <div class="row">
                    <span class="label">Site to publish:</span>
                    <span class="formw">
                        <select name="siteId">
                            <c:forEach var="site" begin="0" items="${sites}">
                                <c:if test="${site.inactive != 1}">
                                    <c:choose>
                                        <c:when test="${site.id == publisher.siteId}">
                                            <option value="${site.id}" selected="selected">${site.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${site.id}">${site.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </select>
					   Location: <select name="siteInstanceId">
					   <option value="1" <c:if test="${publisher.siteInstanceId == 1}">selected</c:if> >TCC</option>
					   <option value="2" <c:if test="${publisher.siteInstanceId == 2}">selected</c:if>>Case Manager laptop</option>
					   <option value="3" <c:if test="${publisher.siteInstanceId == 3}">selected</c:if>>Other 1</option>
					   <option value="4" <c:if test="${publisher.siteInstanceId == 4}">selected</c:if>>Other 2</option>
					   </select>
                	</span>
                </div>
                <div class="row">
                    <span class="label">IP address:</span>
                    <span class="formw">
                        <c:choose>
                            <c:when test="${! empty publisher.url}">
                                <input type="text" name="url" value="${publisher.url}"/>
                            </c:when>
                            <c:otherwise>
                                <input type="text" name="url" value="${ipAddress}"/>
                            </c:otherwise>
                        </c:choose>
                        Port:
                        <c:choose>
                            <c:when test="${! empty publisher.port}">
                                <input type="text" name="port" value="${publisher.port}" size="4"/>
                            </c:when>
                            <c:otherwise>
                                <input type="text" name="port" value="${appPort}" size="4"/>
                            </c:otherwise>
                        </c:choose>
					<html:submit value="Save"/>
                    </span>
                </div>

                <div class="row">
                    <span class="label"></span>
                    <span class="formw">
                        </span>
                </div>
            </html:form>
        </div>

        <div class="row">
            <h2>Manual record export</h2>
			<c:if test="${! empty generateStatusDate}">
            <p class="error">System is currently processing or generating a feed.<c:if test="${! empty statusMessage}"> Status: ${statusMessage}</c:if></p>
            </c:if>
  			<c:url value="scheduler.do" var="update"><c:param name="action" value="update"/></c:url>
            <p><a href='<c:out value="/${appName}/admin/${update}"/>' title="Export any patient records that have been modified since the last export by triggering a scheduled job. It is the safest way to update records, especially if you have alot.">Update exported records (scheduled job)</a> |
            <html:link action="admin/export.do" title="Export any patient records that have been modified since the last export. Best for sites with small numbers of patients.">Update exported records (Manual, for small # of records)</html:link> |
            <c:set var="all" value="1"/>
            <html:link action="admin/export.do" paramId="all" paramName="all" title="Export all patient records. Better for small number of records. It will delete the current archive log.">Export All</html:link>
            </p>

<!--
            <p>The following link will export any patient records that have been modified since the last export and
                check if there are any missing xml patient files and generate them.
                <br/>
                <br/>
                <html:link href="../export.do;jsessionid=${pageContext.request.session.id}?checkXml=true">Update exported records and render missing xml files</html:link>
            </p>
            <p>The following link will export all patient records by triggering a scheduled job.  This will generate XML for all patients. It is the safest way to export records, especially if you have alot.
            	It will delete the current archive log.
                <br/>
                <br/>
		        <c:url value="scheduler.do" var="export"><c:param name="action" value="export"/></c:url>
		    	<a href='<c:out value="/${appName}/admin/${export}"/>'>Export All</a>
		    </p>
		     -->

        </div>
<!--
        <div class="row">
            <h2>Manual Archive Creation and Extraction.</h2>
            <c:if test="${! empty generateStatusDate}">
            <p class="error">System is currently processing or generating a feed.<c:if test="${! empty statusMessage}"> Status: ${statusMessage}</c:if></p>
            </c:if>
            <p>Create Zip archive of site RSS and XML files.
			<ul>
                <c:url value="scheduler.do" var="archive"><c:param name="action" value="archive"/></c:url>
		    	<li><a href='<c:out value="/${appName}/admin/${archive}"/>'>Archive All</a>: Zips all site records into .zip file.</li>
                <c:url value="scheduler.do" var="archiveAir"><c:param name="action" value="archiveAir"/></c:url>
		    	<li><a href='<c:out value="/${appName}/admin/${archiveAir}"/>'>Archive one site - AIR</a>: Zips site records for Airport into .zip file.</li>
                <c:url value="scheduler.do" var="extractMasterArchive"><c:param name="action" value="extractMasterArchive"/></c:url>
		    	<li><a href='<c:out value="/${appName}/admin/${extractMasterArchive}"/>'>Extract Master archive zip file</a></li>
                <c:url value="scheduler.do" var="downloadExtractMasterArchive"><c:param name="action" value="downloadExtractMasterArchive"/></c:url>
		    	<li><a href='<c:out value="/${appName}/admin/${downloadExtractMasterArchive}"/>'>Download and extract Master archive zip file and index</a></li>
            </ul>
        </div>
 -->
        <div class="row">
            <h2>Scheduler</h2>

            <p>Normally the scheduler works automatically. click the following links to change its behaviour.
            The scheduler will reset to normal operation whenever the web application server is restarted.
            Selecting "List" will list pending scheduled operations.

                <br/>
                <br/>
		        <c:url value="scheduler.do" var="start"><c:param name="action" value="start"/></c:url>
		        <c:url value="scheduler.do" var="stop"><c:param name="action" value="stop"/></c:url>
		        <c:url value="scheduler.do" var="list"><c:param name="action" value="list"/></c:url>
		    	<a href='<c:out value="/${appName}/admin/${start}"/>'>Start</a> | <a href='<c:out value="/${appName}/admin/${stop}"/>'>Stop</a>
		    	 | <a href='<c:out value="/${appName}/admin/${list}"/>'>List</a>
		    </p>

        </div>

        <div class="row">
            <h2>Set Server status</h2>
            <p>Set certain server status variables.
                <ul>
                <li>Halt-Feed-Imports:
		        <c:url value="setServerStatus.do" var="haltImports"><c:param name="status" value="Halt-Feed-Imports"/></c:url>
		        <c:url value="setServerStatus.do" var="restartImports"><c:param name="status" value="Halt-Feed-Imports"/><c:param name="message" value="false"/></c:url>
		    	<a href='<c:out value="/${appName}/admin/${haltImports}"/>'>Stop import of feeds.</a> |
		    	<a href='<c:out value="/${appName}/admin/${restartImports}"/>'>Restart import of feeds</a>
		    	</li>
                <li>RSS-Gen-date:
		        <c:url value="setServerStatus.do" var="removeRssGen"><c:param name="status" value="RSS-Gen-date"/><c:param name="message" value="remove"/></c:url>
		    	<a href='<c:out value="/${appName}/admin/${removeRssGen}"/>'>Remove from Status map</a> - Used when the import feed process is stuck.
		    	</li>
		    	<li>Halt-Database-Comparison:
		        <c:url value="setServerStatus.do" var="haltDbComparison"><c:param name="status" value="Halt-Database-Comparison"/></c:url>
		        <c:url value="setServerStatus.do" var="restartDbComparison"><c:param name="status" value="Halt-Database-Comparison"/><c:param name="message" value="false"/></c:url>
		    	<a href='<c:out value="/${appName}/admin/${haltDbComparison}"/>'>Stop db comparison.</a> |
		    	<a href='<c:out value="/${appName}/admin/${restartDbComparison}"/>'>Restart db comparison</a>
		    	</li>
		    </p>
        </div>

        <div class="row">
            <h2>Local feeds</h2>

            <p>
                <a href="http://${publisher.url}:8088/archive/rss.xml">rss feed</a>
            </p>
            <p>
                <a href="http://${publisher.url}:${publisher.port}/archive/${publisher.site.abbreviation}/log/mostRecentUpdate.json">mostRecentUpdate.json</a>
            </p>
        </div>
</div>
    </template:put>
</template:insert>
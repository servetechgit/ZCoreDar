<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean"%>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template'%>
<%@ taglib uri='/WEB-INF/tlds/zeprs.tld' prefix='zeprs'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-print.jsp'>
	<template:put name='title' content='Admin: Server' direct='true' />
	<template:put name='header' content='Admin: Server' direct='true' />
	<template:put name='content' direct='true'>
<div id="maincol-pad">
    <h2><bean:message bundle="ApplicationResources" key="admin.index.master.site.server"/></h2>
    <p>
    <html:link action="/admin/home"><bean:message bundle="ApplicationResources" key="admin.formlist.admin"/></html:link> : <html:link action="/admin/publisher/new"><bean:message bundle="ApplicationResources" key="admin.index.publish"/></html:link> : <html:link action="/admin/subscription/new"><bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/></html:link> : <bean:message bundle="ApplicationResources" key="admin.index.master.site.server"/>
    </p>
		<html:errors />
		<div><html:form action="admin/server/save" method="POST">
			<div class="row">
			<p><bean:message bundle="ApplicationResources" key="server.instructions"/></p>
			<p><bean:message bundle="ApplicationResources" key="server.instruc.header"/>
			<ul>
				<li><bean:message bundle="ApplicationResources" key="server.server.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.enabled.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.loc.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.port.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.url.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.username.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.pass.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.authenticationType.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.domain.desc"/></li>
				<li><bean:message bundle="ApplicationResources" key="server.master.desc"/></li>
				</ul>
				<c:if test="${!empty file}"><p>Current file: ${file}</p></c:if>
				</p>
			</div>
			<div class="row"><span class="label"><bean:message bundle="ApplicationResources" key="server.server"/></span>
			<span class="formw"> <c:choose>
				<c:when test="${! empty server.name}">
					<input type="text" name="name" value="${server.name}"  size="40"/>
				</c:when>
				<c:otherwise>
					<input type="text" name="name" value=""  size="40"/>
				</c:otherwise>
			</c:choose> </span>

             <span class="label2"><bean:message bundle="ApplicationResources" key="server.enabled"/></span> <span
				class="formw"> <c:choose>
				<c:when test="${! empty server.enabled}">
					<input type="checkbox" name="enabled" checked="checked" />
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="enabled" />
				</c:otherwise>
			</c:choose> </span></div>

			<div class="row">
			<span class="label"><bean:message bundle="ApplicationResources" key="server.loc"/></span> <span
				class="formw"> <c:choose>
				<c:when test="${! empty server.location}">
					<input type="text" name="location" value="${server.location}"  size="40"/>
				</c:when>
				<c:otherwise>
					<input type="text" name="location" value=""  size="40"/>
				</c:otherwise>
			</c:choose></span>
			<span class="label2"><bean:message bundle="ApplicationResources" key="server.port"/></span> <span
				class="formw"> <c:choose>
				<c:when test="${! empty server.port}">
					<input type="text" name="port" value="${server.port}" size="6"/>
				</c:when>
				<c:otherwise>
					<input type="text" name="port" value=""  size="6"/>
				</c:otherwise>
			</c:choose></span>
			</div>

			<div class="row"><span class="label"><bean:message bundle="ApplicationResources" key="server.url"/></span> <span
				class="formw">
				<c:choose>
				<c:when test="${! empty server.url}">
					<input type="text" name="url" value="${server.url}" size="50"/>
				</c:when>
				<c:otherwise>
					<input type="text" name="url" value="" size="50" />
				</c:otherwise>
			</c:choose> </span></div>

			<div class="row"><span class="label"><bean:message bundle="ApplicationResources" key="server.username"/></span>
			<span class="formw"> <input type="text" name="username" value="${server.username}" /> </span>
			<span class="label2"><bean:message bundle="ApplicationResources" key="server.pass"/></span>
			<span class="formw"><input type="password" name="password" value="${server.password}" /> </span></div>

			<div class="row">
                    <span class="label"><bean:message bundle="ApplicationResources" key="server.serverType"/></span>
                    <span class="formw"><!--  onchange="toggleField('dropdown', 'webdav', 'webdavOptions','serverType', 1);"  -->
                    	<html:select styleId="serverType" property="serverType">
                    	<html:option value="" > -- </html:option>
                    		<html:option value="webdav" >webdav</html:option>
                    		<html:option value="proxy" >proxy</html:option>
                    	</html:select>
                    </span>
                </div>

                <c:choose>
	                <c:when test="${! empty server.authenticationType}">
	                   <div class="row" id="webdavOptions">
	                </c:when>
	                <c:otherwise>
	                   <div class="row" style="display:none" id="webdavOptions">
	                </c:otherwise>
                </c:choose>

                <span class="label"><bean:message bundle="ApplicationResources" key="server.authenticationType"/></span>
                <span class="formw">
                 <html:select property="authenticationType">
                   <html:option value="" > -- </html:option>
                 	<html:option value="ntlm">ntlm</html:option>
                 	<html:option value="digest">digest</html:option>
                 </html:select>
                </span>
                <span class="label2"><bean:message bundle="ApplicationResources" key="admin.subscription.domain"/></span>
                <span class="formw"><input type="text" name="domain" value="${server.domain}" /></span>
            </div>

			<div class="row"><span class="label"><bean:message bundle="ApplicationResources" key="server.master"/></span> <span
				class="formw"> <c:choose>
				<c:when test="${! empty server.master}">
					<input type="checkbox" name="master" checked="checked" />
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="master" />
				</c:otherwise>
			</c:choose> </span></div>

			<div class="row"><span class="label"></span> <span
				class="formw"> <html:submit value="Save" /></span></div>
		</html:form>
<p>&nbsp;</p>
		<p><span><bean:message bundle="ApplicationResources" key="server.dir"/></span> ${serversDirectory}<br/><bean:message bundle="ApplicationResources" key="server.files"/><ul>
			<c:forEach var="filename" items="${directory}">
				<c:url value="admin/server/new.do" var="serverFile">
					<c:param name="filename" value="${filename}" />
				</c:url>
				<li><a href='<c:out value="/${appName}/${serverFile}"/>'>${filename}</a></li>
			</c:forEach>
		</ul>
</p>

</div>
</div>
	</template:put>
</template:insert>
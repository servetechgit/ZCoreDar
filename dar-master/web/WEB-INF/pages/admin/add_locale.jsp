<%@ page import="org.apache.commons.dbcp.SQLNestedException"%>
<%@ page import="java.sql.SQLException"%>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
<template:put name='title' content='Add Locale' direct='true'/>
<template:put name='header' content='Add Locale' direct='true'/>
<template:put name='content' direct='true'>
<p>
		<html:form action="/admin/locale/save" method="POST">
				<html:hidden property="formId" value="${param.formId}" />
                <div class="row">
                    <span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.form.formLocale"/></span>
                    <span class="formw">
					<html:select property="formLocale">
			            <c:forEach items="${formLocale}" var="locale">
							<c:choose>
							<c:when test="${locale == sessionLocale}"><option value="${locale}" selected>${locale}</option></c:when>
							<c:otherwise><html:option value="${locale}">${locale}</html:option></c:otherwise>
							</c:choose>
						</c:forEach>
		            </html:select>
					<html:submit value="Save"/></span>
                </div>

	    </html:form>
</p>
</template:put>
</template:insert>
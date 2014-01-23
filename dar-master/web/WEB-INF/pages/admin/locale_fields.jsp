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
<template:put name='title' content='Admin: Edit Translation for ${subject.label}' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: <html:link action="/admin/formList">Form Admin</html:link>: <html:link action="/admin/form/edit" paramId="id" paramName="subject" paramProperty="id">Edit page</html:link>: Edit Translation for ${subject.label}</template:put>
<template:put name='help' content="" direct="true"/>
<template:put name='content' direct='true'>
<script type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>

<span class="error"><html:errors /></span>

<logic:present parameter="formId" >
<bean:parameter id="formId" name="formId" />
</logic:present>
<logic:notPresent parameter="formId">
    <logic:present parameter="id" ><bean:parameter id="formId" name="id" /></logic:present>
</logic:notPresent>
<bean:size id="numPageItems" name="subject" property="pageItems"/>
<a name="top"></a>
<html:form action="admin/form/locale/save" method="POST">
<input type="hidden" name="formId" value="${formId}"/>
<input type="hidden" name="locale" value="${param.locale}"/>
<c:if test="${! empty param.saved}"><bean:message bundle="ApplicationResources" key="labels.admin.form.translation.saved"/></c:if>
<table class="enhancedtable">
<tr>
	<th><bean:message key="locale.translate.original" bundle="ApplicationResources"/></th><th><span><bean:message bundle="ApplicationResources" key="locale.translate.translation"/></span>: ${selectedLocaleName}</th>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><th colspan="2"><bean:message bundle="ApplicationResources" key="locale.translate.form.label"/></th></tr>
<tr>
	<td id="form_${subject.id}">${subject.label}</td>
	<bean:define id="theField" value="${subject.classname}_label" />
	<c:set var="theValue" value="${lazyForm.dynaBean.map[theField]}"/>
	<td><html:text property="${theField}" styleId="locale_${pageItem.id}" size="70" value="${theValue}"/></td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><th colspan="2"><bean:message bundle="ApplicationResources" key="locale.translate.fields"/></th></tr>
    <logic:iterate id="pageItem" name="subject" property="pageItems" indexId="i">
		<c:set var="field" value="${pageItem.form_field}" />
        <c:if test="${pageItem.inputType!='display-tbl-begin' && pageItem.inputType!='display-tbl-end'&& pageItem.form_field.enabled!=false}">
        <tr>
        <td id="label_${pageItem.id}">${pageItem.form_field.label}</td>
        <td>
        <bean:define id="theField" value="${subject.classname}.${pageItem.form_field.identifier}"  />
         <c:set var="theValue" value="${lazyForm.dynaBean.map[theField]}"/>
        <%--
         value: <bean:write name="${lazyForm}" property="${subject.classname}.${pageItem.form_field.identifier}" scope="request"/>
<bean:define id="theValue"  name="propMap" property="${subject.classname}.${pageItem.form_field.identifier}"  /> --%>
        <html:text property="${pageItem.form_field.id}" styleId="locale_${pageItem.id}" size="70" value="${theValue}"/></td>
        </tr>
        <c:if test="${pageItem.form_field.type=='Enum'}">
        <tr><td colspan="2"><span style="margin:5">Enumerations</span></td></tr>
        <c:forEach var="enum" begin="0" items="${field.enumerations}">
            <c:if test='${enum.enabled ==true}'>
            <bean:define id="theEnumString" value="${subject.classname}.${pageItem.form_field.identifier}_${enum.id}"  />
     		<c:set var="theEnumValue" value="${lazyForm.dynaBean.map[theEnumString]}"/>
            <tr>
            <td>&nbsp;&nbsp;&nbsp;${enum.enumeration}</td>
            <td><html:text property="${pageItem.form_field.identifier}_${enum.id}" styleId="locale_${pageItem.id}_${enum.id}" size="70" value="${theEnumValue}"/></td>
            </tr>
            </c:if>
        </c:forEach>
        </c:if>
        </c:if>
     </logic:iterate>
</table>
<html:submit><bean:message bundle="ApplicationResources" key="labels.admin.form.locale.edit.submit" /></html:submit>
</html:form>
</template:put>
</template:insert>
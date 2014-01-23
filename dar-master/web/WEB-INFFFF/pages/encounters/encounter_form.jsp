<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="encounterForm" scope="request" type="org.rti.zcore.Form"/>
<%@ page import="java.util.List" %>
<logic:present name="drugs" scope="request">
    <jsp:useBean id="drugs" scope="request" type="java.util.List"/>
</logic:present>

<c:choose>
    <c:when test="${! empty param.template}">
        <c:set var="template" value="/WEB-INF/templates/${appTemplateDir}/template-print.jsp"/>
        <c:set var="divId" value="form-print"/>
    </c:when>
    <c:otherwise>
        <c:set var="template" value="/WEB-INF/templates/${appTemplateDir}/template-print.jsp"/>
        <c:set var="divId" value="forms"/>
    </c:otherwise>
</c:choose>
<template:insert template='${template}'>
    <template:put name='title' content='${encounterForm.label}' direct='true'/>
    <template:put name="javascript" content=""/>
    <template:put name='content' direct='true'>
     <div id="${divId}">
<c:choose>
    <c:when test="${preview == 1}">
        <jsp:include page="encounter_form_layout_long.jsp"/>
    </c:when>
    <c:when test="${encounterForm.formTypeId == 8}">
        <jsp:include page="patient_record_list.jsp"/>
    </c:when>
    <c:otherwise>
    	<c:choose>
    	<c:when test="${! empty subject}">
    			<jsp:include page="encounter_form_layout_long.jsp"/>
    	</c:when>
    	<c:otherwise>
    			<jsp:include page="encounter_form_layout_long.jsp"/>
    	</c:otherwise>
    	</c:choose>
    </c:otherwise>
</c:choose>
         <p>&nbsp;</p>
         <p>&nbsp;</p>
     </div>
<c:import url="../problems/problems_chart.jsp" />
    </template:put>
</template:insert>
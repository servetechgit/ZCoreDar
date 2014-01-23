<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="encounterForm" scope="request" type="org.rti.zcore.Form" />
<logic:present name="drugs" scope="request">
    <jsp:useBean id="drugs" scope="request" type="java.util.List"/>
</logic:present>

<c:set var="template" value="/WEB-INF/templates/${appTemplateDir}/template-print.jsp"/>
<c:set var="divId" value="forms"/>

<template:insert template='${template}'>
    <template:put name='title' content='${encounterForm.label}' direct='true'/>
    <template:put name="javascript" content=""/>
    <template:put name='content' direct='true'>
     <div id="${divId}">
<c:set var="displayform" value="0"/>
<c:if test="${(!empty zeprs_session.sessionPatient.dead && zeprs_session.sessionPatient.dead != 'true') && (empty zeprs_session.sessionPatient.dateEventEnd || ! empty subject) }">
	<c:set var="displayform" value="1"/>
</c:if>
<c:if test="${encounterForm.id == 180}">
	 <c:set var="displayform" value="1"/>
</c:if>
<c:if test="${displayform == '1'}">
	<jsp:include page="encounter_form_layout_long.jsp"/>
</c:if>
<h2>${encounterForm.label} Records</h2>
<c:if test="${encounterForm.classname == 'PerpetratorDemographics'}">
<p><html:link action="/perp/search.do"><bean:message bundle="ApplicationResources" key="perp.search"/></html:link></p>
</c:if>
<c:choose>
    <c:when test="${! empty chartItems}">
        <table cellpadding="1" cellspacing="1" class="enhancedtabletighter">
            <jsp:useBean id="now" class="java.util.Date"/>
            <%@ include file="/WEB-INF/pages/encounters/patient_record_list_items.jsp" %>
        </table>
        <p>&nbsp;</p>
    </c:when>
    <c:otherwise>
        <script type='text/javascript'>
            function confirmChartDate(field, formName)
            {
                 if (formId != null) {
                     var form = document.getElementById(formName);
                     return validateForm${encounterForm.id}(form);
                 } else {
                    return validateForm${encounterForm.id}(this);
                 }
            }
        </script>
        <c:if test="${empty chartItems}"><p><em>No records</em></p></c:if>
    </c:otherwise>
</c:choose>
<c:if test="${encounterForm.classname == 'PerpetratorDemographics'}">
	<c:if test="${empty zeprs_session.sessionPatient.dateEventEnd || ! empty subject }">
	    <jsp:include page="encounter_form_layout_long.jsp"/>
	</c:if>
</c:if>
     </div>
<c:import url="../problems/problems_chart.jsp" />
    </template:put>
</template:insert>
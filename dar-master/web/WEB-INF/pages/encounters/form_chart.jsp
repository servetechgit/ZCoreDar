<%--
  Created by IntelliJ IDEA.
  User: ckelley
  Date: Apr 11, 2005
  Time: 12:38:08 PM
--%>

<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:choose>
    <c:when test="${! empty param.template}">
    <c:set var="template" value="/WEB-INF/templates/${appTemplateDir}/template-print.jsp"/>
    </c:when>
    <c:otherwise>
    <c:set var="template" value="/WEB-INF/templates/${appTemplateDir}/template.jsp"/>
    </c:otherwise>
</c:choose>
<c:set var="labelEnd"/>
<template:insert template='${template}'>
<template:put name='title' content='${encounterForm.label}${labelEnd}' direct='true'/>
<template:put name='content' direct='true'>
<script language="JavaScript" type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/Encounter.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-generic.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-display.js;jsessionid=${pageContext.request.session.id}"></script>
<script type="text/javascript" language="Javascript1.1">

<!-- Begin

function submitForm() {
    bCancel=false;
    bCancel =  validate${encounterForm.classname}(document.${encounterForm.classname});
    if (bCancel == true) {
    document.${encounterForm.classname}.submit();
    }
}


//End -->
</script>
<c:choose>
    <c:when test="${! empty param.template}">
        <c:set var="formClass" value="form-print"/>
    </c:when>
    <c:otherwise>
        <c:set var="formClass" value="widePage3"/>
    </c:otherwise>
</c:choose>

<div id="${formClass}">
    <%--<c:if test="${(encounterForm.classname == '2') && (! empty zeprs_session.sessionPatient)}">
         <c:import url="../patient_records/previous_pregnancies.jsp" />
    </c:if>--%>
    <h2>${encounterForm.label}${labelEnd}</h2>
    <c:if test="${encounterForm.classname == 'CurrentMedicine'}"><p>Please be aware that Medications are also recorded on
        the <html:link action="/patientAnte.do" paramId="patientId" paramName="zeprs_session" paramProperty="sessionPatient.id">Antepartum</html:link> page during routine ANC visits.</p></c:if>
    <c:if test="${! empty param.referralId}">
        <c:import url="admit_to_uth.jsp"/>
    </c:if>
<logic:messagesPresent>
   <ul>
   <html:messages id="error" bundle="ApplicationResources">
      <li class="valError"><bean:write name="error"/></li>
   </html:messages>
   </ul>
</logic:messagesPresent>
<html:form action="${encounterForm.classname}/save.do" onsubmit="return validate${encounterForm.classname}(this);">
<input type="hidden" name="forward"/>
<c:choose>
    <c:when test="${encounterForm.classname == 'PrevPregnancies' && empty chartItems}">
        <p>Previous Pregnancies?:
            <input type="radio" name="prev" value="1"> Yes <input type="radio" name="prev" value="1" onclick="submitNoneForm();"> No
        </p>
    </c:when>
</c:choose>

<c:choose>
<c:when test="${! empty chartItems}">
<table cellpadding="1" cellspacing="1" class="enhancedtabletighter">
</c:when>
<c:otherwise>
<table cellpadding="1" cellspacing="1" class="enhancedtabletighter">
</c:otherwise>
</c:choose>


<%@ include file="/WEB-INF/pages/encounters/encounter_form_layout_chart.jsp" %>

</table>
<html:javascript formName="${encounterForm.classname}" dynamicJavascript="true" staticJavascript="false" bundle="ApplicationResources"/>
</html:form>
    <c:if test="${encounterForm.classname == 'CurrentMedicine'}">
    <p>&nbsp;</p>
    <h2>ARV's Dispensed</h2>

    <p>You may edit ARV records on the <span style="text-decoration: underline;"><html:link action="arv">
        ARV</html:link></span> page.</p>
    <c:choose>
    <c:when test="${fn:length(chart) > 0}">
    <table cellpadding="1" cellspacing="1" class="enhancedtabletighter">
        <%@ include file="/WEB-INF/pages/encounters/encounter_form_records_view.jsp" %>
    </table>
    </c:when>
    <c:otherwise>
    <p><em>No ARV's have been dispensed for this patient.</em></p>
    </c:otherwise>
    </c:choose>
    </c:if>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
<c:import url="../problems/problems_chart.jsp" />
</template:put>
</template:insert>
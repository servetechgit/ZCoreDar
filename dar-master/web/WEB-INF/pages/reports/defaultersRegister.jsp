<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:formatDate value="${register.beginDate}" pattern="${dateFormatLong}" var="beginDate"/>
<fmt:formatDate value="${register.endDate}" pattern="${dateFormatLong}" var="endDate"/>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' direct='true'>Defaulters Register for ${register.siteName} ${beginDate} - ${endDate}</template:put>
<template:put name='header' direct='true'>Defaulters Register for ${register.siteName} ${beginDate} - ${endDate}</template:put>
<template:put name='content' direct='true'>
<div id="forms">
<h1>Defaulters Register for ${register.siteName} ${beginDate} - ${endDate}</h1>
<p>Patients who had appointments during the past week and missed their appointments.</p>
<table border="1" cellspacing="0" cellpadding="3" class="enhancedtable">
<tr>
    <th>
        Client
    </th>
    <th>
        Client ID
    </th>
    <th>
        Address
    </th>
    <th>
        Phone
    </th>
    <th>
        Appointment Date
    </th>
</tr>

<c:set var="smRegisterString" value="unknown"/>
<logic:iterate id="patient" name="register" property="patients">

<tr>
     <td align="center" class="small">
                <html:link action="/patientHome.do" paramId="patientId" paramName="patient" paramProperty="patientId">${patient.patientRegistration.surnameR}, ${patient.patientRegistration.forenamesR}</html:link>

    </td>
    <td align="center" class="small">
        <c:choose>
            <c:when test="${! empty patient.patientRegistration.patient_id_numberR}">${patient.patientRegistration.patient_id_numberR}</c:when>
            <c:otherwise>&nbsp;</c:otherwise>
        </c:choose>
    </td>
    <td align="center" class="small">
        <c:choose>
            <c:when test="${! empty patient.patientRegistration}">${patient.patientRegistration.street_address_1R}</c:when>
            <c:otherwise>&nbsp;</c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${! empty patient.patientRegistration}"><br/>${patient.patientRegistration.street_address_2R}</c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
    </td>
    <td align="center" class="small">
        <c:choose>
            <c:when test="${! empty patient.patientRegistration}">${patient.patientRegistration.mobile_phoneR}</c:when>
            <c:otherwise>&nbsp;</c:otherwise>
        </c:choose>
    </td>
     <td align="center" class="small">
         <c:choose>
            <c:when test="${! empty patient.appointmentDate}"><fmt:formatDate value="${patient.appointmentDate}" pattern="${dateFormatLong}"/>
            </c:when>
            <c:otherwise>&nbsp;</c:otherwise>
        </c:choose>
     </td>
</tr>
</logic:iterate>
</table>
</div>
</template:put>
</template:insert>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="encounterForm" scope="request" type="org.rti.zcore.Form" />

<c:choose>
	<c:when test="${subject.id != null}">
        <h2><bean:message key="${encounterForm.classname}.label" bundle="${encounterForm.classname}Messages" />
            <logic:present role="DELETE_ARCHIVE_PATIENT_RECORDS">
                <c:url var="delUrl" value="admin/deleteEncounter.do">
                    <c:param name="encounterId" value="${subject.id}"/>
                    <c:param name="formId" value="${encounterForm.id}"/>
                </c:url>
             &nbsp;(<a href='<c:out value="/${appName}/${delUrl}"/>'onclick="return confirm('Caution: Are you sure you want to delete this record?');self.close();" title="Delete this record.">X</a>)
            </logic:present>
        </h2>
    </c:when>
    <c:otherwise>
        <h2><bean:message key="${encounterForm.classname}.label" bundle="${encounterForm.classname}Messages" /></h2>
    </c:otherwise>
</c:choose>

<c:if test="${(encounterForm.classname == 'PatientRegistration' || encounterForm.classname == 'PerpetratorDemographics') && subject.id != null}">
    <p>
        <logic:present role="DELETE_ARCHIVE_PATIENT_RECORDS">
            <html:link action="admin/deletePatient.do" paramId="patientId" paramName="patientId"
                       onclick="return confirm('Caution: Are you sure you want to delete this patient from ZEPRS?');self.close();">
                Delete Patient</html:link>
        </logic:present>
</c:if>

<c:if test="${! empty param.countAppts}">
<div style="border:2px solid red;margin:1em;padding:.5em;">
<c:if test="${! empty param.warningMessage}"><p class="error">${param.warningMessage}</p></c:if>
<p><strong>${param.countAppts} Appointments for ${param.apptDate}</strong></p>
</div>
</c:if>
<c:if test='${subject.id != null && empty preview}'>
<script language="JavaScript" type="text/javascript" src="/${appName}/dwr/util.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/Encounter.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-generic.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-display.js;jsessionid=${pageContext.request.session.id}"></script>
<c:if test="${encounterForm.classname == 'PatientItem'}">
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/StockEncounter.js;jsessionid=${pageContext.request.session.id}'></script>
</c:if>
<c:if test="${encounterForm.classname == 'PatientRegistration'}">
<script type='text/javascript' src='/${appName}/dwr/interface/PatientId.js;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript'>
var reply1 = function(data)
{
  document.getElementById('d1').innerHTML = data;
    var dataSt = new String(data);
    if (dataSt.substring(0,5) == "Error") {

    } else {
       updateRecord('patientid', 1513 ,3158 ,1, ${subject.id} , 'Form');
    }
}
var reply2 = function(data)
{
    if (data.substring(0,4) == "Error") {
        alert(data);
    } else {
      document.getElementById('patientid').value = data;
      var sumData = new Number(data.substring(0,1)) + new Number(data.substring(1,2)) + new Number(data.substring(2,3)) + new Number(data.substring(3,4)) + new Number(data.substring(4,5));
      ck = calcMod(sumData,10);
      var checksum = ck;
      document.getElementById('checksum').value = checksum;
      calcPatientId();
      patientidField = document.getElementById('patientIdRow');
      patientidField.style.display = "none";
      updateRecord('patientid', 1513 ,3158 ,1, ${subject.id} , 'Form');
    }
}
function copyPatientId() {
    var patientid = document.getElementById('patientid');
    var patient = document.getElementById('patient');
    patient.value = patientid.value;
}
</script>
</c:if>
<table border="0" cellpadding="4" cellspacing="2" width="95%"  id="recordMetaData" summary="4 col table" class="formTable">
    <tr class="sectionHeader">
        <th class="encounterlabel"><bean:message key="form.dateOfVisit" bundle="ApplicationResources"/></th>
        <th class="encounterlabel"><bean:message key="record_created" bundle="ApplicationResources"/></th>
        <th class="encounterlabel"><bean:message key="record_modified" bundle="ApplicationResources"/></th>
        <th class="encounterlabel"><bean:message key="record_site" bundle="ApplicationResources"/></th>
    </tr>
    <jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate type="both" pattern="yyyy" value="${now}" var="yearnow" />
<fmt:formatDate type="both" pattern="MM" value="${now}" var="monthnow" />
<fmt:formatDate type="both" pattern="dd" value="${now}" var="datenow" />
<c:set var="theDate" value="${now}"/>
    <tr>
        <td><fmt:formatDate value="${subject.dateVisit}"  pattern="dd MMM yy"/></td>
        <td><fmt:formatDate value="${subject.created}"  pattern="dd MMM yy  HH:mm"/>
        <br/>${subject.createdByName}</td>
        <td><fmt:formatDate value="${subject.lastModified}" pattern="dd MMM yy  HH:mm"/>
        <br/>${subject.lastModifiedByName}</td>
        <td>${subject.siteName}</td>
    </tr>
</table>
</c:if>

<logic:messagesPresent>
<p class="valError">
   <bean:message bundle="ApplicationResources" key="errors.header"/>
   <html:messages id="error" bundle="ApplicationResources">
      <li class="valError"><bean:write name="error"/></li>
   </html:messages>
   <bean:message bundle="ApplicationResources" key="errors.footer"/>
</p>
</logic:messagesPresent>

<c:set var="url" value="save"/>
<c:set var="submitJs" value="return validate${encounterForm.classname}(this);"/>
<c:if test="${! empty subject}">
<c:set var="submitJs" value="return false;"/>
</c:if>
<c:choose>
<c:when test="${(! empty preview) && (! empty instaBean)}">
      <c:set var="actionValue" value="/admin/form/preview.do"/>
      <c:set var="submitJs" value="alert('Preview Only');return false;"/>
</c:when>
    <c:otherwise>
       <c:set var="actionValue" value="${encounterForm.classname}/${url}.do"/>
    </c:otherwise>
</c:choose>
<c:if test="${encounterForm.classname == 'PatientItem'}">
<c:set var="submitJs" value="return validateEmptyFields();"/>
</c:if>
<c:if test="${encounterForm.classname == 'PatientItem' && empty zeprs_session.sessionPatient.regimenCode}">
<c:url value="ArtRegimen/new.do" var="artRegimen"><c:param name="formId" value="137"/><c:param name="patientId" value="${zeprs_session.sessionPatient.id}"/></c:url>
<p class="error">This patient has not been assigned to a regimen. Would you like to
<a title="${zeprs_session.sessionPatient.regimenName}" href='<c:out value="/${appName}/${artRegimen}"/>'>assign a regimen</a> before dispensing?</p>
</c:if>

<html:form action="${actionValue}" onsubmit="${submitJs}" styleId="${encounterForm.classname}">
<c:if test="${! empty next}">
    <input type="hidden" name="next" value="${next}"/>
</c:if>

<c:set var="trFields"/>
<c:set var="tblItem" value="0"/>
<c:choose>
    <c:when test='${! empty subject}'>
        <input type="hidden" name="id" value="${subject.id}"/>
    </c:when>
    <c:when test="${encounterForm.classname == 'PatientRegistration'}">
        <zeprs:date_visit_initial/>
    </c:when>
    <c:otherwise>
        <zeprs:date_visit/>
    </c:otherwise>
</c:choose>
<c:set var="tblItem" value="0"/>
<c:set var="tblCols" value="0"/>
<c:set var="tdBackgroundColor" value="#fff"/>
<c:set var="collapsing" value="0"/>
<jsp:include page="encounter_form_fields.jsp"/>
<c:choose>
    <c:when test="${empty subject}">
    <c:choose>
	    <c:when test="${encounterForm.id == 132}">
	                <div style="text-align: right; padding-right: 30px;">
	    </c:when>
	    <c:otherwise>
	                <div style="padding:5px;">
	    </c:otherwise>
    </c:choose>
            <c:choose>
                <c:when test='${encounterForm.requireReauth}'>
                    <zeprs:re_auth pageItem="${pageItem}"/>
                    <html:submit onclick="bCancel=false;" />
                </c:when>
                <c:otherwise>
                    <html:submit onclick="bCancel=false;" />
                </c:otherwise>
            </c:choose>
            </div>

    </c:when>
    <c:otherwise>
        <c:if test="${encounterForm.id == '4'}">
        <c:url value="patientAnte.do" var="patientAnte"><c:param name="patientId" value="${zeprs_session.sessionPatient.id}"/></c:url>
        <div style="padding:5px;"><input type="button" value="Back to Antepartum Chart" onclick="window.location.href='/zeprs/${patientAnte}';"/></div>
        </c:if>
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${(! empty preview) && (! empty instaBean)}">
    </c:when>
    <c:otherwise>
        <html:javascript formName="${encounterForm.classname}" dynamicJavascript="true" staticJavascript="false" bundle="ApplicationResources"/>
    </c:otherwise>
</c:choose>
</html:form>


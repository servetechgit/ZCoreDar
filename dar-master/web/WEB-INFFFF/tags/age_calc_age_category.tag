<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<%@ attribute name="pos" required="false" type="java.lang.Integer" %>
<%@ attribute name="remoteClass" required="false" type="java.lang.String" %>
<%@ attribute name="classname" required="false" type="java.lang.String" %>
<%@ attribute name="propertyName" required="false" type="java.lang.String" %>
<%@ attribute name="patientId" required="false" type="java.lang.Integer" %>
<%@ attribute name="eventId" required="false" type="java.lang.Integer" %>
<%@ attribute name="user" required="false" type="java.lang.String" %>
<%@ attribute name="siteId" required="false" type="java.lang.Integer" %>
<%@ attribute name="formId" required="false" type="java.lang.Integer" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="renderedValue" required="false" type="java.lang.String" %>
<%@ attribute name="encounterId" required="false" type="java.lang.Integer" %>
<c:set var="field" value="${pageItem.form_field}" />
<logic:present name="${encounterForm.classname}" property="${field.identifier}">
	<bean:define id="valueFromDb" name="${encounterForm.classname}" property="${field.identifier}"/>
</logic:present>
<bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if><br>
<input type="text" size="${pageItem.size}" maxlength="${pageItem.maxlength}" name="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" id="${field.identifier}" autocomplete="off" value="${valueFromDb}" onchange="toggleAgeCategory('manual');"/> ${field.units}

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
<c:choose>
    <c:when test="${! empty value}">
    <span id="value${field.identifier}" onclick="display('${value}', '${pageItem.id}', '${field.identifier}', '${className}', '${pageItem.formId}', '${encounterId}')" >${renderedValue}</span>
    <span id="widget${field.identifier}"></span>
    </c:when>
<c:otherwise>
    <c:choose>
   	<c:when test="${field.identifier == 'password'}">
        <input type="password" size="20" maxlength="30" name="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" id="${field.identifier}" autocomplete="off" value="${valueFromDb}"/> ${field.units}
   	</c:when>
    <c:when test="${empty pageItem.size}">
    <input type="text" size="20" name="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" id="${field.identifier}" autocomplete="off"/> ${field.units}
    </c:when>
    <c:when test="${pageItem.maxlength==0}">
    <html:text size="20" maxlength="255" property="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" styleId="${field.identifier}"/> ${field.units}
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${field.identifier == 'field1171'}">
                <c:choose>
                    <c:when test='${param.id != null}'>
                        <html:text size="${pageItem.size}" maxlength="${pageItem.maxlength}" property="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" styleId="${field.identifier}"/> ${field.units}
                   </c:when>
                   <c:otherwise>
                    <zeprs:patientid pageItem="${pageItem}"/>
                   </c:otherwise>
                </c:choose>
           </c:when>
           <c:otherwise>
			<c:choose>
				<c:when test="${! empty pageItem.currentFieldNameIdentifier}">
				<input type="text" size="${pageItem.size}" maxlength="${pageItem.maxlength}" name="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" id="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" autocomplete="off" value="${valueFromDb}"/> ${field.units}
				</c:when>
				<c:otherwise>
				<input type="text" size="${pageItem.size}" maxlength="${pageItem.maxlength}" name="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" id="${field.identifier}" autocomplete="off" value="${valueFromDb}"/> ${field.units}
				</c:otherwise>
			</c:choose>
           </c:otherwise>
        </c:choose>
    </c:otherwise>
    </c:choose>
</c:otherwise>
</c:choose>

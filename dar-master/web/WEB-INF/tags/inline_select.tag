<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt" %>
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
<%@ attribute name="onchange" required="false" type="java.lang.String" %>
<%@ attribute name="styleId" required="false" type="java.lang.String" %>
<%@ attribute name="dropdownSelectedEnumId" required="false" type="java.lang.Integer" %>
<%@ attribute name="inlineFieldIdentifier" required="false" type="java.lang.String" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="scriptName" value="reply${field.identifier}"/>
<c:set var="field" value="${pageItem.form_field}" />
<c:choose>
    <c:when test="${field.id == 1862}"> <%-- Phase of pregnancy--%>
        <logic:present name="zeprs_session" property="sessionPatient">
            <c:choose>
                <c:when test="${! empty zeprs_session.sessionPatient.parentId}"/>
                <c:otherwise>${field.label}: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br>
                </c:otherwise>
            </c:choose>
        </logic:present>
        <logic:notPresent name="zeprs_session" property="sessionPatient">
              ${field.label}: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br>
        </logic:notPresent>
    </c:when>
    <c:otherwise>${field.label}: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br></c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${(pageItem.visibleEnumIdTrigger2 > 0)}">
        <select name="${inlineFieldIdentifier}${field.identifier}" name="select${field.identifier}" onchange="toggleField2DepsChoice('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', ${pageItem.visibleEnumIdTrigger2}, '${pageItem.childIdentifier2}','${field.identifier}');" >
            <option value=""></option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <option value="${enum.id}">${enum.enumeration}</option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <option value="${enum.id}">${enum.enumeration}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </select>
    </c:when>
    <c:when test="${(pageItem.visibleEnumIdTrigger1 > 0)}">
        <select name="${inlineFieldIdentifier}${field.identifier}" name="select${field.identifier}" onchange="toggleField('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}','${field.identifier}');" >
            <option value=""></option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <option value="${enum.id}">${enum.enumeration}</option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <option value="${enum.id}">${enum.enumeration}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </select>
    </c:when>
    <c:otherwise>
        <select name="${inlineFieldIdentifier}${field.identifier}" onchange="" id="${styleId}">
        <option value=""></option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                    <c:choose>
                        <c:when test="${enum.id == dropdownSelectedEnumId}">
                            <option value="${enum.id}" selected="selected">${enum.enumeration}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${enum.id}">${enum.enumeration}</option>
                        </c:otherwise>
                    </c:choose>
                 </c:if>
            </c:forEach>
    </select>
    </c:otherwise>
</c:choose>
${field.units}
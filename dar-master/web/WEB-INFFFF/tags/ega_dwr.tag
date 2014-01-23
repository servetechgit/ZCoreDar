<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<%@ attribute name="pos" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteClass" required="true" type="java.lang.String" %>
<%@ attribute name="classname" required="true" type="java.lang.String" %>
<%@ attribute name="propertyName" required="true" type="java.lang.String" %>
<%@ attribute name="patientId" required="true" type="java.lang.Integer" %>
<%@ attribute name="eventId" required="true" type="java.lang.Integer" %>
<%@ attribute name="user" required="true" type="java.lang.String" %>
<%@ attribute name="siteId" required="true" type="java.lang.Integer" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="formId" required="true" type="java.lang.Integer" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="scriptName" value="reply${field.identifier}"/>
<c:choose>
    <c:when test="${! empty value}">
    <c:set var="days"  value="${value % 7}" />
    <c:set var="weeks" value="${value/7}" />
    <span id="${field.identifier}Results${pos}"><fmt:parseNumber value="${weeks}" integerOnly="true" />, ${days}/7</span>
    <div id="weeksPreg">
    <input type=hidden name=calcYet id=calcYet value=0>
    </div>
    <input type=hidden name=weeks id=weeks size="3">
    <%--
    <html:text size="5" styleId="days" property="${field.identifier}" onfocus="this.blur()" styleClass="disabled"/> days pregnant
    --%>

    <select name="${field.identifier}" name="${field.identifier}Field${pos}" onchange="insertSelectStringField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"  style="display:none;">
    <option value=""> -- </option>
    <%--<html:select property="${field.identifier}" styleId="days">--%>
    <c:forEach begin="1" end="350" step="1" var="day">
        <c:set var="days"  value="${day % 7}" />
        <c:set var="weeks" value="${day/7}" />
        <c:choose>
            <c:when test="${value == day}">
            <option selected value="${day}"><fmt:parseNumber value="${weeks}" integerOnly="true" />, ${days}/ 7</option>
            </c:when>
            <c:otherwise>
            <option value="${day}"><fmt:parseNumber value="${weeks}" integerOnly="true" />, ${days}/ 7</option>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    </select>
</c:when>
    <c:otherwise>
    <span id="${field.identifier}Results${pos}"></span>
    <div id="weeksPreg">
    <input type=hidden name=calcYet id=calcYet value=0>
    </div>
    <input type=hidden name=weeks id=weeks size="3">
    <%--
    <html:text size="5" styleId="days" property="${field.identifier}" onfocus="this.blur()" styleClass="disabled"/> days pregnant
    --%>

    <select name="${field.identifier}" id="${field.identifier}Field${pos}" id="days" onchange="insertSelectStringField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"  style="display:none;">
    <option value=""> -- </option>
    <%--<html:select property="${field.identifier}" styleId="days">--%>
    <c:forEach begin="1" end="350" step="1" var="day">
    <c:set var="days"  value="${day % 7}" />
    <c:set var="weeks" value="${day/7}" />
    <option value="${day}"><fmt:parseNumber value="${weeks}" integerOnly="true" /> weeks, ${days}/ 7 days</option>
    </c:forEach>
    </select>
    </c:otherwise>
</c:choose>
<script type='text/javascript'>
    var ${scriptName} = function(data)
    {
    var dvals = data.split("=");
    var key = "${field.identifier}Results" + dvals[1];
    var value =dvals[0];
    var days = value % 7;
    var weeks = Math.floor(value/7);
    var itemValue = document.getElementById(key);
    itemValue.innerHTML = weeks + ", " + days + "/7";
    var input =  document.getElementById("${field.identifier}Field" + dvals[1]);
    input.style.display = "none";
    input.style.visibility = "hidden";
    }
</script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<%@ attribute name="pos" required="true" type="java.lang.Integer" %>
<%@ attribute name="remoteClass" required="true" type="java.lang.String" %>
<%@ attribute name="classname" required="true" type="java.lang.String" %>
<%@ attribute name="propertyName" required="true" type="java.lang.String" %>
<%@ attribute name="patientId" required="true" type="java.lang.Integer" %>
<%@ attribute name="eventId" required="true" type="java.lang.Integer" %>
<%@ attribute name="user" required="true" type="java.lang.String" %>
<%@ attribute name="siteId" required="true" type="java.lang.Integer" %>
<%@ attribute name="formId" required="true" type="java.lang.Integer" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="scriptName" value="reply${field.identifier}"/>
<c:choose>
    <c:when test="${! empty value}">
    <span id="${field.identifier}Results${pos}">${value}</span>
    <%--<select name="${field.identifier}${pos}" id="${field.identifier}Field${pos}" onchange="insertSelectField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})" style="display:none;">
        <option value=""> -- </option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                    <c:choose>
                    <c:when test="${enum.enumeration == value}">
                    <option value="${enum.id}" selected>${enum.enumeration}</option>
                    </c:when>
                    <c:otherwise>
                    <option value="${enum.id}">${enum.enumeration}</option>
                    </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>
    </select>--%>
    </c:when>
    <%--<c:otherwise>
        <span id="${field.identifier}Results${pos}"></span>
        <select name="${field.identifier}${pos}" id="${field.identifier}Field${pos}" onchange="insertSelectField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})">
        <option value=""> -- </option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                    <c:choose>
                    <c:when test="${pageItem.form.id =='80'}">
                    <c:if test="${enum.enumeration != 'Other, Describe'}">
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
    </c:otherwise>--%>
    </c:choose>
   <%-- <script type='text/javascript'>
        var ${scriptName} = function(data)
        {
        var dvals = data.split("=");
        var key = "${field.identifier}Results" + dvals[1];
        var value =dvals[0];
        var itemValue = document.getElementById(key);
        itemValue.innerHTML = value;
        var input =  document.getElementById("${field.identifier}Field" + dvals[1]);
        input.style.display = "none";
        input.style.visibility = "hidden";
        }
    </script>--%>
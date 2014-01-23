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
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="formId" required="true" type="java.lang.Integer" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="scriptName" value="reply${field.identifier}"/>
<c:choose>
    <c:when test="${value == true}">
    <span id="${field.identifier}Results${pos}">Yes</span>
<%--<html:checkbox property="${field.identifier}" value="1" />--%>
<input type="checkbox" id="${field.identifier}Field${pos}" name="${field.identifier}${pos}" checked="checked" value="1" onchange="insertCheckboxField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})" style="display:none;"/>
    </c:when>
    <c:otherwise>
    <span id="${field.identifier}Results${pos}"></span>
    <input type="checkbox" id="${field.identifier}Field${pos}" name="${field.identifier}${pos}" value="1" onchange="insertCheckboxField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})" style="display:none;"/>
<%--
    <html:checkbox styleId="${field.identifier}Field${pos}" property="${field.identifier}${pos}" value="1"  onchange="insertCheckboxField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}Field${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"  style="display:none;"/>
--%>
 </c:otherwise>
</c:choose>
<script type='text/javascript'>
    var ${scriptName} = function(data)
    {
    var dvals = data.split("=");
    var key = "${field.identifier}Results" + dvals[1];
    var value =dvals[0];
    var itemValue = document.getElementById(key);
    if (value == "true") {
    itemValue.innerHTML = "Yes";
    }  else if (value == "false") {
    itemValue.innerHTML = "No";
    } else {
    itemValue.innerHTML = value;
    }
    var input =  document.getElementById("${field.identifier}Field" + dvals[1]);
    input.style.display = "none";
    input.style.visibility = "hidden";
    }
</script>
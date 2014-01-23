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
    <span id="${field.identifier}Span${pos}" style="display:none;">
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}YField${pos}" value="1" checked onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}YField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}Y">Yes</label>
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}NField${pos}" value="0" onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}NField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}N">No</label>
        <input type="radio" name="${field.identifier}${pos}" value=""/><label for="${field.identifier}">N/A</label>
    </span>
    </c:when>
    <c:when test="${value == 'Yes'}">
    <span id="${field.identifier}Results${pos}">Yes</span>
    <span id="${field.identifier}Span${pos}" style="display:none;">
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}YField${pos}" value="1" checked onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}YField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}Y">Yes</label>
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}NField${pos}" value="0" onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}NField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}N">No</label>
        <input type="radio" name="${field.identifier}${pos}" value=""/><label for="${field.identifier}">N/A</label>
    </span>
    </c:when>
    <c:when test="${value == false}">
    <span id="${field.identifier}Results${pos}">No</span>
    <span id="${field.identifier}Span${pos}" style="display:none;">
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}YField${pos}" value="1" onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}YField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}Y">Yes</label>
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}NField${pos}" value="0" checked onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}NField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}N">No</label>
        <input type="radio" name="${field.identifier}${pos}" value=""/><label for="${field.identifier}">N/A</label>
    </span>
    </c:when>
    <c:when test="${value == 'No'}">
    <span id="${field.identifier}Results${pos}">No</span>
    <span id="${field.identifier}Span${pos}" style="display:none;">
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}YField${pos}" value="1" onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}YField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}Y">Yes</label>
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}NField${pos}" value="0" checked onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}NField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}N">No</label>
        <input type="radio" name="${field.identifier}${pos}" value=""/><label for="${field.identifier}">N/A</label>
    </span>
    </c:when>
    <c:otherwise>
    <span id="${field.identifier}Results${pos}"></span>
    <span id="${field.identifier}Span${pos}" style="display:none;">
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}YField${pos}" value="1" onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}YField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}Y">Yes</label>
    <input type="radio" name="${field.identifier}${pos}" id="${field.identifier}NField${pos}" value="0" onchange="insertInputField('${remoteClass}', ${scriptName}, '${classname}','${field.identifier}', ${pos},'${field.identifier}NField${pos}',${patientId}, ${eventId},'${user}',${siteId},${formId})"/><label for="${field.identifier}N">No</label>
        <input type="radio" name="${field.identifier}${pos}" value=""/><label for="${field.identifier}">N/A</label>
    </span>
    </c:otherwise>
</c:choose>
<script type='text/javascript'>
    var ${scriptName} = function(data)
    {
    var dvals = data.split("=");
    var key = "${field.identifier}Results" + dvals[1];
    var value =dvals[0];
    var itemValue = document.getElementById(key);

    if (value == 1) {
    alert("Yes value: " + value);
    itemValue.innerHTML = "Yes";
    }  else if (value == 0) {
    alert("No value: " + value);
    itemValue.innerHTML = "No";
    } else {
    alert("hmmm value: " + value);
    itemValue.innerHTML = value;
    }
    var input =  document.getElementById("${field.identifier}Span" + dvals[1]);
    input.style.display = "none";
    input.style.visibility = "hidden";
    }
</script>




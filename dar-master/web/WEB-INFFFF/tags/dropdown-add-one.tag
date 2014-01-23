<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
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
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="inlineFieldIdentifier" value="${field.identifier}_"/>
<c:set var="inlineFormName" value="inlineForm_${field.identifier}"/>
<bean:define id="inlineForm" name="${inlineFormName}" />
<c:set var="inlineFieldsName" value="inlineFields_${field.identifier}"/>
<bean:define id="inlineFields" name="${inlineFieldsName}"/>
<c:set var="getDropdownScriptName" value="get${field.identifier}"/>
<c:set var="refreshDropdownScriptName" value="refresh${field.identifier}"/>
<c:set var="dropdownFieldName" value="select${field.identifier}"/>
${field.label}: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br/>
<c:choose>
    <c:when test="${(pageItem.visibleEnumIdTrigger2 > 0)}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleField2DepsChoice('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', ${pageItem.visibleEnumIdTrigger2}, '${pageItem.childIdentifier2}','${field.identifier}');" >
            <html:option value="">No Information</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${(pageItem.visibleEnumIdTrigger1 > 0)}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleField('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}','${field.identifier}');" >
            <html:option value="">No Information</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:otherwise>
		<html:select property="${field.identifier}" styleId="select${field.identifier}">
		<option value="">-- Select --</option>
		    <c:forEach var="dropdown" begin="0" items="${listMap[pageItem.id]}">
		    	<option value="${dropdown.dropdownId}">${dropdown.dropdownValue}</option>
		    </c:forEach>
		</html:select><span onclick="toggle2('inline${inlineForm.classname}_${field.identifier}');togglePlusMinus('plusminus${inlineForm.classname}_${field.identifier}')"><img src="/${appName}/images/plus.gif" alt="Add enumerations" border="0" id="plusminus${inlineForm.classname}_${field.identifier}"></span>
<c:set var="validationMethod" value="validate${inlineForm.classname}_${field.identifier}"/>
<script type='text/javascript'><!--

function post${field.identifier}InlineForm(className) {
	var ${inlineFieldIdentifier}fieldValues = DWRUtil.getValues( {
		<c:forEach var="field" begin="0" items="${inlineFields}" varStatus="status">
		${inlineFieldIdentifier}${field}:null<c:if test="${!status.last==true}">,</c:if>
		</c:forEach>
	}
	)

		// translate to pojo field names
	var pojo = {
			<c:forEach var="field" begin="0" items="${inlineFields}" varStatus="status">
			${field}:null<c:if test="${!status.last==true}">,</c:if>
			</c:forEach>
		}

	// copy values from form to pojo
	var props = '';
	for (prop in ${inlineFieldIdentifier}fieldValues) {
    	//alert(${inlineFieldIdentifier}fieldValues[prop]);
    	var newprop = prop.replace("${inlineFieldIdentifier}","");
    	pojo[newprop] = ${inlineFieldIdentifier}fieldValues[prop];
    	props = props + "," + newprop + ":" + ${inlineFieldIdentifier}fieldValues[prop];
	}
	//alert("props" + props);
	var postForm = ${validationMethod}('${inlineForm.classname}');
	if (postForm == true) {
		if (className == 'Organization') {
			TimsEncounter.insertOrganizationFormData(${getDropdownScriptName}, pojo, '${inlineForm.classname}', ${pageItem.id});
		} else if (className == 'AreaOf_crime') {
			TimsEncounter.insertAreaFormData(${getDropdownScriptName}, pojo, '${inlineForm.classname}', ${pageItem.id});
		} else {
			TimsEncounter.insertContactFormData(${getDropdownScriptName}, pojo, '${inlineForm.classname}', ${pageItem.id});
		}
	}
}
var selectedItem;
function ${getDropdownScriptName}(message) {
	var dvals = message.split("=");
	var pageItemId = dvals[0];
	var dropdownIdentifier =dvals[1];
	var selectedId =dvals[2];
    DWREngine.setPreHook(function() { $('disabledZone').style.visibility = 'visible'; });
    Encounter.getDropdownItems(${refreshDropdownScriptName}, pageItemId);
    DWREngine.setPostHook(function() { $('disabledZone').style.visibility = 'hidden';});
    selectedItem = selectedId;
    // alert("selectedItem: " + selectedItem);
}
var ${refreshDropdownScriptName} = function(enumerations)
{
    // alert(DWRUtil.toDescriptiveString(enumerations, 3, 3) );
	DWRUtil.removeAllOptions("${dropdownFieldName}");
    DWRUtil.addOptions("${dropdownFieldName}", ["-- Select --"]);
    DWRUtil.addOptions("${dropdownFieldName}", enumerations, "dropdownId", "dropdownValue");
    DWRUtil.setValue("${dropdownFieldName}", selectedItem);
    Fat.fade_element("${dropdownFieldName}", 60, 3000, "#FFFF33", "#FFFFFF");
}
-->
--></script>
    </c:otherwise>
</c:choose>
${field.units}
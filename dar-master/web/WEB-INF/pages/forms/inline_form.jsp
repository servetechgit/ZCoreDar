<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script language="JavaScript" type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/Encounter.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type='text/javascript' src='/${appName}/dwr/interface/TimsEncounter.js;jsessionid=${pageContext.request.session.id}'></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-generic.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/dwr-display.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/scriptaculous/prototype.js"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/scriptaculous/scriptaculous.js"></script>
<c:set var="inlineField" value="${pageItem.form_field}" />
<c:set var="inlineFieldIdentifier" value="${field.identifier}_"/>
<c:set var="inlineFormName" value="inlineForm_${field.identifier}"/>
<bean:define id="inlineForm" name="${inlineFormName}"/>
<c:if test='${! empty inlineForm}'>
<%--  form name="${inlineForm.classname}" id="${inlineForm.classname}" action="#"  --%>
<!-- span id="inline${inlineForm.classname}_${inlineField.identifier}" style="display:none; border:none;" -->
<c:forEach var="pageItem" begin="0" items="${inlineForm.pageItems}" varStatus="lineInfo">
    <c:if test='${pageItem.form_field.enabled ==true}'>
        <c:choose>
            <c:when test="${pageItem.colspan >1}">
                <c:set var="colspan" value="${pageItem.colspan}"/>
            </c:when>
            <c:otherwise>
                <c:set var="colspan" value="1"/>
            </c:otherwise>
        </c:choose>
        <c:choose><%--First setup special table formatting and hidden fields - items that don't appear in normal layout--%>
            <c:when test="${pageItem.inputType=='display-tbl-begin'}">
	            <%--Ignore visibility settings - make the table hidden if it is used as an inline form--%>
	            <table border="0" cellpadding="4" cellspacing="2" width="95%" id="inline${inlineForm.classname}_${inlineField.identifier}" summary="${pageItem.cols} col table" style="display:none; border:none; margin:5px;">
	            <c:choose>
	                <c:when test="${pageItem.cols >1}">
	                    <c:set var="inlineTblCols" value="${pageItem.cols}"/>
	                </c:when>
	                <c:otherwise>
	                    <c:set var="inlineTblCols" value="1"/>
	                </c:otherwise>
	            </c:choose>
            </c:when>
            <c:when test="${pageItem.inputType=='display-tbl-end'}">
					<tr><td colspan="${inlineTblCols}" style="border: 1px solid silver;text-align: right;">
<input type="button" id="inlineTblButton" onclick="post${dropdownfieldIdentifier}InlineForm('${inlineForm.classname}');" value="Create new ${inlineForm.label}"  title="Create new ${inlineForm.label}">
</td></tr>
                </table>
            </c:when>
            <c:otherwise><%--Now setthe rows for the normal fields--%>
                <c:set var="inlineTblItem" value="${inlineTblItem+1}"/>
                <c:if test="${inlineTblItem==1 || inlineTblItem==inlineTblCols+1}">
                    <c:choose>
                        <c:when test="${pageItem.inputType=='display-subheader'}">
                            <tr style="background-color:${tdBackgroundColor};" id="row${pageItem.form_field.id}">
                            <c:set var="inlineTblItem" value="1"/>
                            <c:set var="tdBackgroundColor" value="silver"/>
                        </c:when>
                        <c:when test="${(pageItem.visible=='false') && (empty visibility)}">
                            <tr id="row${pageItem.form_field.id}">
                            <c:set var="inlineTblItem" value="1"/>
                        </c:when>
                        <c:otherwise>
                            <tr id="row${pageItem.form_field.id}">
                            <c:set var="inlineTblItem" value="1"/>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:choose>
                <c:when test="${pageItem.inputType=='display-subheader'}">
                    <c:set var="tdBackgroundColor" value="#E6E6FA"/>
                </c:when>
                <c:when test="${pageItem.inputType=='infotext'}">
                <c:set var="tdBackgroundColor" value="#E6E6FA"/>
                </c:when>
            </c:choose>
                <c:if test='${pageItem.form_field.enabled ==true && pageItem.inputType != "multiselect_enum"}'>
                    <c:set var="field" value="${pageItem.form_field}"/>
                    <c:set var="currentField" value="${field.id}" scope="request"/>
                    <c:set var="styleId" value="${field.identifier}"/>
                    <c:choose>
                        <c:when test="${(pageItem.visible=='false') && (empty visibility)}">
                    		<td id="cell${pageItem.form_field.id}" colspan="${colspan}" style="background-color:${tdBackgroundColor};border: 1px solid silver;display:none">
                        </c:when>
                        <c:otherwise>
                            <td id="cell${pageItem.form_field.id}" colspan="${colspan}" style="background-color:${tdBackgroundColor};border: 1px solid silver;">
                        </c:otherwise>
                     </c:choose>
                        <%@ include file="/WEB-INF/pages/forms/inline_fields.jsp" %>
                    </td>
                    <c:set var="tdBackgroundColor" value="#fff"/>
                </c:if>
            </c:otherwise>
        </c:choose>
        <c:choose><%--Close the row--%>
            <c:when test="${pageItem.closeRow==true}">
                </tr><c:set var="inlineTblItem" value="0"/>
            </c:when>
            <c:when test="${(inlineTblItem==0 ||inlineTblItem==inlineTblCols) && (pageItem.inputType!='display-tbl-end') }"></tr></c:when>
        </c:choose>
    </c:if>
</c:forEach>
<!-- /span -->
<c:set var="validationMethod" value="validate${inlineForm.classname}_${inlineField.identifier}"/>

<script type='text/javascript'>
var bCancel = false;
function ${validationMethod}(formname) {
        var formValidationResult;
        formValidationResult = ${inlineForm.classname}_${inlineField.identifier}_required ();
        if (formValidationResult !='') {
            alert(formValidationResult);
            return false;
        } else {
            return true;
        }
}

function ${inlineForm.classname}_${inlineField.identifier}_required () {
var message = "";
var value = "";
 <c:forEach var="pageItem" begin="0" items="${inlineForm.pageItems}" varStatus="status">
	<c:set var="field" value="${pageItem.form_field}" />
	<c:if test="${field.required}">
	value = dwrUtilgetValue('${inlineFieldIdentifier}${field.identifier}');
	if (value == '') {
		message = message + "${field.label} is required.\n"
	}
	</c:if>
	</c:forEach>
	return (message);
}
</script>

</c:if>
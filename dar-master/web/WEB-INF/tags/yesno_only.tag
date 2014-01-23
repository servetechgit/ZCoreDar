<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:choose>
    <c:when test="${! empty pageItem.visibleEnumIdTrigger1}">
        <c:choose>
	        <c:when test="${pageItem.visibleEnumIdTrigger1 == 1}">
				<html:radio property="${field.identifier}" styleId="${field.identifier}"  value="1"  onclick="toggleField('Yes/No',${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', '${field.id}');" /><label for="${field.identifier}Y">Yes</label>
				<html:radio property="${field.identifier}" styleId="${field.identifier}" value="0"  onclick="toggleField('Yes/No',${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', '${field.id}');" /><label for="${field.identifier}N">No</label>
				<input type="radio" name="${field.identifier}" value=""/><label for="${field.identifier}">N/A</label>
	        </c:when>
	        <c:otherwise>
	        <html:radio property="${field.identifier}" styleId="${field.identifier}"  value="1"/><label for="${field.identifier}Y">Yes</label>
			<html:radio property="${field.identifier}" styleId="${field.identifier}" value="0"/><label for="${field.identifier}N">No</label>
			<input type="radio" name="${field.identifier}" value=""/><label for="${field.identifier}">N/A</label>
	        </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <html:radio property="${field.identifier}" styleId="${field.identifier}"  value="1"/><label for="${field.identifier}Y">Yes</label>
		<html:radio property="${field.identifier}" styleId="${field.identifier}" value="0"/><label for="${field.identifier}N">No</label>
		<input type="radio" name="${field.identifier}" value=""/><label for="${field.identifier}">N/A</label>
    </c:otherwise>
</c:choose>


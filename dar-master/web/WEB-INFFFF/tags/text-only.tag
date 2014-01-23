<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="size" value="${pageItem.size}" />
<c:set var="maxlength" value="${pageItem.maxlength}" />
<c:if test="${empty pageItem.size || pageItem.size == 0}">
<c:set var="size" value="20" />
</c:if>
<c:if test="${pageItem.maxlength==0}">
<c:set var="maxlength" value="255" />
</c:if>
<input type="text" size="${size}" maxlength="${maxlength}" name="${pageItem.currentFieldNameIdentifier}${recordForEncounter}${field.identifier}" id="${field.identifier}" autocomplete="off" value="${valueFromDb}"/> ${field.units}
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if><br>
<html:select property="${field.identifier}">
    <html:option value="">Not Recorded</html:option>
    <html:option value="1">&gt; 95%</html:option>
    <html:option value="2">90-95%</html:option>
    <html:option value="3">&lt; 90%</html:option>
</html:select>
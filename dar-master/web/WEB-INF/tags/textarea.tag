<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>

<c:set var="field" value="${pageItem.form_field}" />
<bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if><br>
<c:choose>
    <c:when test="${(empty pageItem.cols) || (pageItem.cols==0)}">
    <html:textarea property="${field.identifier}" cols="32" rows="2" bundle="${encounterForm.classname}Messages"/>
    </c:when>
    <c:otherwise>
    <html:textarea cols="${pageItem.cols}" rows="${pageItem.rows}" property="${field.identifier}" bundle="${encounterForm.classname}Messages"/>
    </c:otherwise>
</c:choose>
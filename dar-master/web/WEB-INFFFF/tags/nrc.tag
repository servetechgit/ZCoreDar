<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if><br>
<c:choose>
    <c:when test='${param.id != null}'>
        <html:text size="${pageItem.size}" maxlength="${pageItem.maxlength}" property="${field.identifier}"/>
    </c:when>
    <c:otherwise>
    <input id="nrc1" type="text" name="nrc1" size="4" maxlength="6" onchange="concatNRC('${field.identifier}')"> /
    <input id="nrc2" type="text" name="nrc2" size="1" maxlength="2" onchange="concatNRC('${field.identifier}')"> /
    <input id="nrc3" type="text" name="nrc3" size="1" maxlength="1" onchange="concatNRC('${field.identifier}')">
    <span id="span${field.identifier}"></span>
    <html:hidden styleId="input${field.identifier}" property="${field.identifier}" />
    </c:otherwise>
</c:choose>
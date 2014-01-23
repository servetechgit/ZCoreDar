<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if><br>
<c:choose>
    <c:when test="${field.identifier=='field490'}">
        <html:select property="${field.identifier}">
            <html:option value=""> --  </html:option>
            <html:option value="1"><bean:message bundle="ApplicationResources" key="gender.female"/></html:option>
            <html:option value="2"><bean:message bundle="ApplicationResources" key="gender.male"/></html:option>
        </html:select>
    </c:when>
    <c:otherwise>
        <html:radio property="${field.identifier}" value="1"><bean:message bundle="ApplicationResources" key="gender.female"/></html:radio>
        <html:radio property="${field.identifier}" value="2"><bean:message bundle="ApplicationResources" key="gender.male"/></html:radio>
    </c:otherwise>
</c:choose>


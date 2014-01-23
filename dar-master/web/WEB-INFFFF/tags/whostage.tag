<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if><br>
<html:radio value="1" property="${field.identifier}">1</html:radio>
<html:radio value="2" property="${field.identifier}">2</html:radio>
<html:radio value="3" property="${field.identifier}">3</html:radio>
<html:radio value="4" property="${field.identifier}">4</html:radio>

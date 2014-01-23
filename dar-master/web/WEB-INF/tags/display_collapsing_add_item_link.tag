<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<a href="#" onclick="revealItem('${pageItem.childIdentifier1}');" title="Click here to add <bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />">
<img border="0" src="/${appName}/images/plus.gif" id="plusminus"><bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" /></a>
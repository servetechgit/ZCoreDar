<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template.jsp'>
<template:put name='title' content='DAR: File Location' direct='true'/>
<template:put name='content' direct='true'>
    <div id="widePage">
    <h2>Success!</h2>
        <c:if test="${! empty path}"><p>${message}<a href="file:///${fn:replace(path,'\\','/')}">${path}</a></p></c:if>
    </div>
</template:put>
</template:insert>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template.jsp'>
<template:put name='title' content='ZEPRS' direct='true'/>
<template:put name='content' direct='true'>
<h2>Success!</h2>
    <div id="widePage">
        <c:if test="${! empty message}"><p>${message}</p></c:if>
    </div>
</template:put>
</template:insert>
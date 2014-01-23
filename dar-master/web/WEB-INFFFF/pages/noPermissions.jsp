<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-simple.jsp'>
<template:put name='title' content='Home' direct='true'/>
<template:put name='header' content='Access Denied' direct='true'/>
<template:put name='content' direct='true'>
    <h2>Access denied</h2>
    <p>You do not have permission to view this page. Please click <a href="/${appName}/home.do">"this link"</a> to login again
    or contact support for help.</p>
</template:put>
</template:insert>
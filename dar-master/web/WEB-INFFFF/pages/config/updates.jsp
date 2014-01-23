<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-home-print.jsp'>
<template:put name='title' content='Updates' direct='true'/>
<template:put name='content' direct='true'>
    <div id="widePage">
    <h2>Updates</h2>
    <p>Two types of updates are available: automatic and manual. Updates listed in the automatic section will be applied to the system automatically
     the next time ${appTitle} is restarted. Manual updates are used for complex upgrades and provide a view of the update progress when it is complete.
     Updates listed in the manual section are applied by clicking the "Apply" link in the manual listing.</p>
        <h2>Pending Automatic Updates</h2>
        <c:if test="${! empty pending}"><p>${pending}</p></c:if>
        <h2>Manual Updates</h2>
        <c:if test="${! empty manual}"><p>${manual}</p></c:if>
    </div>
</template:put>
</template:insert>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' content='Help' direct='true'/>
<template:put name='content' direct='true'>
    <div id="widePage">
    <h2>Help</h2>
<p>The DAR Data Client Admin Guide is accessible from the following locations:
<ul>
<li><a href="file:///${fn:replace(helpDoc,'\\','/')}" target="_blank">View in browser</a>.</li>
<li>Start menu -> Programs -> zCore DAR -> DAR Data Client Admin Guide.pdf</li>
</ul></p>
   <%--
<c:import url="user_guide/user_guide.html"/>

   <c:choose>
        <c:when test="${! empty page}">
        <c:import url="${page}.html"/>
        </c:when>
        <c:otherwise>
        <c:import url="toc.jsp"/>
        </c:otherwise>
    </c:choose>

        <h2>Help</h2>
<p>Please click on the following links for information about the application.</p>
<ul>
    <li><html:link href="help.do?page=userManual">User Manual</html:link></li>

    <li><html:link href="help.do?page=referrals">Referrals</html:link></li>
    <li><html:link href="help.do?page=editing">Editing records</html:link></li>
    <logic:present role="CREATE_MEDICAL_STAFF_IDS_AND_PASSWORDS_FOR_MEDICAL_STAFF">
    <li><html:link href="help.do?page=userAdmin">User Administration</html:link></li>
    </logic:present>
     --%>
</ul>
</div>
</template:put>
</template:insert>
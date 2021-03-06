<%@ page import="org.rti.zcore.utils.SessionUtil,
                 org.rti.zcore.utils.SessionUtil"%>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template.jsp'>
<template:put name='title' content='ZEPRS: Report Listing' direct='true'/>
    <h2>Reports</h2>
<template:put name='content' direct='true'>
<ul>
<logic:iterate id="report" name="subject">
<li>
<html:link action="report" paramId="report_id" paramName="report" paramProperty="id"><bean:write name="report" property="label"/></html:link>
</li>
</logic:iterate>
</ul>

</template:put>
</template:insert>
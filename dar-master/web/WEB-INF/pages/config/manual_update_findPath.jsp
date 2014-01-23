<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-home-print.jsp'>
<template:put name='title' content='Updates' direct='true'/>
<template:put name='content' direct='true'>

<div id="forms">
	<h2>Manual Updates</h2>
	<p><span class="error">Unable to locate the old version of the DAR.</span>
	<br/>Please browse to the directory that contains the installation of the DAR software that was previously in-use.
	This directory will contain a file named "dar.exe". Select that file (dar.exe) and click "Submit."</p>
	<html:form action="config/manualUpdate/saveDbPath" method="POST">
		<html:file property="fileBox" styleId="fileBox" size="30"></html:file>
		<html:submit/>
	</html:form>
</div>
<script type="text/javascript">
function copyPath()
 {
    var fileBox = document.getElementById("fileBox");
	var path = document.getElementById("fileBox");
	//var pathValue = fileBox.getAsDataURL();
	var pathValue = fileBox.value;
	path.value = pathValue;
	alert("path:" + path);
 }
</script>
</template:put>
</template:insert>
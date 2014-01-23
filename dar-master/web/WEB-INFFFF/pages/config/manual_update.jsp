<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-print-refresh.jsp'>
<template:put name='title' content='Updates' direct='true'/>
<template:put name='content' direct='true'>
    <div id="forms">
	    <h2>Manual Updates</h2>
	    <p>This database update process will display status messages below.
	    This display will be refreshed automatically every five seconds. The most recent messages will be at the top of this display.
	    Please wait for this process to be completed before proceeding.
	    </p>
	    <p><span class="error">Current step at ${currenttimeStr}: </span>
	    <c:choose>
	    <c:when test="${! empty upgradeCurrentStep}">${upgradeCurrentStep}</c:when>
	    <c:when test="${! empty param.upgradeCurrentStep}">${param.upgradeCurrentStep}</c:when>
	    <c:otherwise>Processing...</c:otherwise>
	    </c:choose>
	    <c:if test="${! empty duration}"><br/>Step Duration: ${duration}</c:if>
	    <c:if test="${! empty upgradeErrorMessages}"><br><br>
	     <span style="color: red"><strong>Error Messages during this step:</strong><br><br>
	   	<logic:iterate id="error" name="upgradeErrorMessages">
	   	 ${error}<br/>
	   	</logic:iterate>
	   	</span>
	   	</c:if>
	    </p>
	    <c:if test="${! empty results}">
	     <strong>Previous Steps:</strong><br>
	   	<logic:iterate id="thisResult" name="results">
	   	 ${thisResult}<br/>
	   	</logic:iterate>

	   	</c:if>
    </div>
</template:put>
</template:insert>
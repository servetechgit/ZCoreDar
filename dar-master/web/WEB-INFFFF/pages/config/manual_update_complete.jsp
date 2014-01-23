<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-home-print.jsp'>
<template:put name='title' content='Updates' direct='true'/>
<template:put name='content' direct='true'>
    <div id="forms">
	    <h2>Manual Updates</h2>
	    <c:choose>
	    <c:when test="${! empty upgradeFailed}">
	    <p><span class="error">The update failed. Please fix the error(s) before resuming the update.</span>
	  		<br/><strong>Final command: </strong>${upgradeCurrentStep}
	  		<c:if test="${! empty upgradeErrorMessages}"><br><br>
	     <span style="color: red"><strong>Error Messages during this step:</strong><br><br>
	        <c:forEach var="error" begin="0" items="${upgradeErrorMessages}">
	      ${error}<br/>
	   	</c:forEach>
	   	</span>
	   	</c:if>
	  	</p>
	    </c:when>
	    <c:otherwise>
	  	<p><span class="error">The update is complete.</span>
	  		<br/><strong>Final command: </strong>${upgradeCurrentStep}
	  	</p>
	    </c:otherwise>
	    </c:choose>
	    <p>The following messages display the results of each step in the order in which they were executed. 
	    If any steps are missing, there was an error. Check the webapps/archive/siteAbbrev/log/complete directory for any errorSyncLogAppUpdates log files.<br/>
	    <c:forEach var="update" begin="0" items="${results}">
	     ${update}<br/>
	   	</c:forEach>
	   	</p>
    </div>
</template:put>
</template:insert>
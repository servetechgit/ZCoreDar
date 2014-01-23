<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config.jsp'>
<template:put name='title' content='Site Configuration' direct='true'/>
<template:put name='header' content='Site Configuration' direct='true'/>
<template:put name='content' direct='true'>
<div id="widePage">
<h2>Site Configuration</h2>
<p>Please select the site or health centre that corresponds to the one in which this PC will be used.</p>
<h3>Select site</h3>
<form action="${pageContext.request.contextPath}/setup.do;jsessionid=${pageContext.request.session.id}" method="post">
   <select name="site_id">
   <c:forEach var="site" begin="0" items="${sites}">
      <c:if test="${site.inactive != 1}"><option value="${site.id}">${site.name}</option></c:if>
   </c:forEach>
   </select>
   <input type="submit" value="Submit">
</form>
</div>
</template:put>
</template:insert>
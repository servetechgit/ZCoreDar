<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pos" value="0"/>
<c:set var="tblItem" value="0"/>
<c:set var="tblCols" value="0"/>
<c:set var="tdBackgroundColor" value="#fff"/>
<c:set var="collapsing" value="0"/>
<c:set var="tdClass" value="enhancedtabletighterCell"/>
<c:set var="dataEntry" value="1"/>
<c:if test="${! empty arvChartItems}">
    <c:set var="chartItems" value="arvChartItems"/>
    <c:set var="encounterForm" value="arvEncounterForm"/>
</c:if>
<script language="JavaScript" type="text/javascript" src="/${appName}/dwr/util.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}"></script>
<script type='text/javascript' src='/${appName}/dwr/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwr/interface/Encounter.js;jsessionid=${pageContext.request.session.id}'></script>
<script type="text/javascript" src="/${appName}/js/dwr-generic.js;jsessionid=${pageContext.request.session.id}"></script>
<script type="text/javascript" src="/${appName}/js/dwr-display.js;jsessionid=${pageContext.request.session.id}"></script>
<c:set var="dataEntry" value="1"/>
<p>Clicking "Add Stock Item" will preset the Regimen dropdown.</p>
<table class="enhancedtable">
   <tr>
<%-- loop through the pageItems and build the chart--%>
<c:set var="numRows" value="0"/>
<c:set var="regimen_idValue" value=""/>

<th id="regimenHeaderCell" valign="middle" class="enhancedtabletighterCell"><strong>Regimen</strong></th>
<th id="itemsHeaderCell" valign="middle" class="enhancedtabletighterCell"><strong>Stock Items</strong></th>
</tr>
<c:forEach items="${chartItems}" var="encounter" varStatus="item">
<logic:notEmpty name="encounter" property="encounterMap.regimen_id">
<c:set var="item_idValue" value="${encounter.encounterMap.item_id}"/>
<c:if test="${(regimen_idValue != encounter.encounterMap.regimen_id) && (regimen_idValue != '')}">
	</td>
</tr>
</c:if>
<c:if test="${regimen_idValue != encounter.encounterMap.regimen_id}">
<c:set var="regimen_idValue" value="${encounter.encounterMap.regimen_id}"/>
<tr>
	<td id="cell${currentEncounterId}.${field.id}" valign="middle">
		<span id="value${currentEncounterId}.${field.id}">${encounter.encounterMap.regimen_id}</span>
		<span id="widget${currentEncounterId}.${field.id}"></span>
		<p><a href="#" onclick="setDropdown('regimen_id',${encounter.regimen_id})">Add Stock Item</a></p>
	</td>
	<td id="cell${currentEncounterId}.${field.id}" valign="middle" align="left">
	</c:if>
		<p>
		<span id="value${currentEncounterId}.${field.id}">${item_idValue}</span>
		<span id="widget${currentEncounterId}.${field.id}"></span>
		<logic:present role="DELETE_ARCHIVE_PATIENT_RECORDS">
	                <c:url var="delUrl" value="admin/deleteEncounter.do">
	                <c:choose>
	                	<c:when test="${! empty param.maxRows}">
	                	<c:param name="maxRows" value="${param.maxRows}"/>
	                	</c:when>
	                </c:choose>
	                <c:param name="encounterId" value="${encounter.id}"/>
	                	<c:param name="formId" value="${encounterForm.id}"/>
	                </c:url>
	                <a href='<c:out value="/${appName}/${delUrl}"/>' onclick="return confirm('Caution: Are you sure you want to delete this record from ZEPRS?');self.close();">X</a>
	            </logic:present>
		</p>
</logic:notEmpty>
</c:forEach>

</table>
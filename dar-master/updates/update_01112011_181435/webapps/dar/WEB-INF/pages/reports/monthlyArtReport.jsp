<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:formatDate value="${register.beginDate}" pattern="${dateFormatLong}" var="beginDate"/>
<fmt:formatDate value="${register.endDate}" pattern="${dateFormatLong}" var="endDate"/>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-report-wide-ajax.jsp'>
<template:put name='title' direct='true'>Monthly ART Patient Summary for ${register.siteName}&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='header' direct='true'>Monthly ART Patient Summary for ${register.siteName}&nbsp;
${beginDate}<c:if test="${!empty endDate}"> - ${endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<p>Instructions: Double-click on the field in the "Estimated No. of New Patients" column to enter a value for the corresponding drug. </p>
<c:choose>
<c:when test="${!empty isCombinedReport}">
<table  border="1" cellspacing="2" cellpadding="3" width="800px" class="reportTablePrint">
<tr>
<td style="background: #DDD;text-align: right;font-size: 110%">Once you have completed this report,
click the "Save" button to save this report and generate Combined Report.</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center" >
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
<c:otherwise>
<p>After you make an entry in the "Estimated No. of New Patients" column, the report will be saved at:<br/> <a href="file:///${fn:replace(register.reportPath,'\\','/')}">${register.reportPath}</a></p>
</c:otherwise>
</c:choose>
<script language="javascript" type="text/javascript">
    function scrollUp() {
        var divY = document.getElementById('scrollBody').scrollTop;
        var newDivY = divY - 50;
        document.getElementById('scrollBody').scrollTop = newDivY;
    }

    function scrollDown() {
        var divY = document.getElementById('scrollBody').scrollTop;
        var newDivY = divY + 50;
        document.getElementById('scrollBody').scrollTop = newDivY;
    }
</script>
<c:set var="pageBreakCount" value="0"/>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint" width="800px">
	<tr>
        <th>Regimen Code</th>
        <th title="Shows the various combinations of ARV drugs into ART treatment regimens. Weight bands and the drug strengths are used to differentiate between the regimens. Each regimen is coded.">Treatment Regimen<br/>(strength of dosage forms for adults are indicated)</th>
        <th title="Shows the total number of patients who are currently following each treatment regimen. ">Current No. of<br/>Patients on regimen<br/>this month</th>
        <th title="The estimated number of new patients who will start ART in the following month. The number of patients and their treatment regimens can be provided by the HIV clinic prescribers/staff (e.g. from the Pre-ART and ART registers). If an ART eligibility committee exists in the facility, it may also provide this information.
The pharmacy should discuss this with the HIV clinic. Kindly inform them that this information is important for purposes of planning your stock orders and forecasting your requirements.
Take into consideration the current number of patients being assessed for eligibility for ART, changes in patient numbers from one regimen to another, and service capacity of the facility.">Estimated No. of<br/>New Patients expected<br/>to be on this regimen<br/>next month</th>
		<th title="The total estimated number is automatically calculated as follows: The current number of patients plus the number of estimated New patients. Total Estimated Number of Patients on ART Next Month = A + B">Total Estimated No.<br/>of Patients on ART<br/>next month</th>
    </tr>
	<tr>
        <td colspan="2">&nbsp;</td>
        <td>A</td>
        <td>B</td>
		<td>=A+B</td>
    </tr>
<c:choose>
<c:when test="${! empty dynamicReport}">
    <tr><td colspan="5" style="background: gray;">Adult First Line</td></tr>
    <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 1}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
        <tr><td colspan="5" style="background: gray;">Adult Second Line</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 2}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">Other ADULT ART Regimens</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 3}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">Paediatric First Line Regimens</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 6}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">D4T/3TC/NVP</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 6750}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">Paediatric Second-Line Regime</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 7}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">Post Exposure Prophylaxis (PEP)</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 4}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">PMTCT Regimens</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 5}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>
    <tr><td colspan="5" style="background: gray;">Other Paediatric Regimens</td></tr>
        <c:forEach items="${register.regimenList}" var="regimen">
    <c:if test="${regimen.regimenGroup == 8}">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:if>
    </c:forEach>


</c:when>
<c:otherwise>
	<tr>
        <th colspan="5">Adult First-Line Regimens</th>
    </tr>
	<tr>
        <td colspan="5"><strong>First-Line Std Regimen: d4T + 3TC + NVP</strong></td>
    </tr>
	<tr>
        <td align = "center">1A</td>
        <td>d4T 30mg + 3TC 150mg + NVP 200mg  [< 60Kg]</td>
        <td>${register.artRegimenReport.regimen1A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen1A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen1A">${register.newEstimatedArtPatients.regimen1A}</span>
			<span id="widget.newEstimatedArtPatients.regimen1A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen1A">${register.totalEstimatedArtPatients.regimen1A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen1A"></span>
		</td>
    </tr>
	<tr>
        <td colspan="5"><strong>First-Line Non-Standard Regimens: d4T + 3TC + EFV, AZT + 3TC + EFV / NVP</strong></td>
    </tr>
	<tr>
        <td align = "center">2A</td>
        <td>d4T 30mg + 3TC 150mg + EFV 600mg [< 60Kg]</td>
        <td>${register.artRegimenReport.regimen2A}</td>
        <td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen2A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen2A">${register.newEstimatedArtPatients.regimen2A}</span>
			<span id="widget.newEstimatedArtPatients.regimen2A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen2A">${register.totalEstimatedArtPatients.regimen2A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen2A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">3A</td>
        <td>AZT 300mg + 3TC 150mg + EFV 600mg  [< 60Kg]</td>
        <td>${register.artRegimenReport.regimen3A}</td>
        <td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen3A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen3A">${register.newEstimatedArtPatients.regimen3A}</span>
			<span id="widget.newEstimatedArtPatients.regimen3A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen3A">${register.totalEstimatedArtPatients.regimen3A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen3A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">3B</td>
        <td>AZT 300mg + 3TC 150mg + NVP 200mg</td>
        <td>${register.artRegimenReport.regimen3B}</td>
        <td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen3B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen3B">${register.newEstimatedArtPatients.regimen3B}</span>
			<span id="widget.newEstimatedArtPatients.regimen3B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen3B">${register.totalEstimatedArtPatients.regimen3B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen3B"></span>
		</td>
    </tr>
	<tr>
        <th colspan="5">Adult Second-Line Regimens</th>
    </tr>
	<tr>
		<td><strong>Option 1</strong></td>
		<td colspan="4"><strong>AZT + ddI + LPV/r</strong></td>
	</tr>
	<tr>
        <td align = "center">4A</td>
        <td>AZT 300mg + ddI 125mg + LPV/r 133.3/33.3mg [< 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen4A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen4A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen4A">${register.newEstimatedArtPatients.regimen4A}</span>
			<span id="widget.newEstimatedArtPatients.regimen4A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen4A">${register.totalEstimatedArtPatients.regimen4A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen4A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">4B</td>
        <td>AZT 300mg + ddI 200mg + LPV/r 133.3/33.3mg [> 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen4B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen4B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen4B">${register.newEstimatedArtPatients.regimen4B}</span>
			<span id="widget.newEstimatedArtPatients.regimen4B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen4B">${register.totalEstimatedArtPatients.regimen4B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen4B"></span>
		</td>
    </tr>
	<tr>
		<td><strong>Option 2</strong></td>
		<td colspan="4"><strong>AZT + ddI + NFV</strong></td>
	</tr>
	<tr>
        <td align = "center">5A</td>
        <td>AZT 300mg + ddI 125mg + NFV 250mg [< 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen5A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen5A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen5A">${register.newEstimatedArtPatients.regimen5A}</span>
			<span id="widget.newEstimatedArtPatients.regimen5A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen5A">${register.totalEstimatedArtPatients.regimen5A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen5A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">5B</td>
        <td>AZT 300mg + ddI 200mg + NFV 250mg [> 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen5B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen5B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen5B">${register.newEstimatedArtPatients.regimen5B}</span>
			<span id="widget.newEstimatedArtPatients.regimen5B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen5B">${register.totalEstimatedArtPatients.regimen5B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen5B"></span>
		</td>
    </tr>
	<tr>
		<td><strong>Option 3</strong></td>
		<td colspan="4"><strong>AZT + ddI + NFV</strong></td>
	</tr>
	<tr>
        <td align = "center">6A</td>
        <td>ABC 300mg + ddI 125mg + LPV/r 133.3/33.mg [< 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen6A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen6A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen6A">${register.newEstimatedArtPatients.regimen6A}</span>
			<span id="widget.newEstimatedArtPatients.regimen6A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen6A">${register.totalEstimatedArtPatients.regimen6A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen6A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">6B</td>
        <td>ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg  [> 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen6B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen6B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen6B">${register.newEstimatedArtPatients.regimen6B}</span>
			<span id="widget.newEstimatedArtPatients.regimen6B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen6B">${register.totalEstimatedArtPatients.regimen6B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen6B"></span>
		</td>
    </tr>
	<tr>
		<td><strong>Option 4</strong></td>
		<td colspan="4"><strong>ABC + ddI + NFV</strong></td>
	</tr>
	<tr>
        <td align = "center">7A</td>
        <td>ABC 300mg + ddI 125mg + NFV 250mg [< 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen7A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen7A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen7A">${register.newEstimatedArtPatients.regimen7A}</span>
			<span id="widget.newEstimatedArtPatients.regimen7A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen7A">${register.totalEstimatedArtPatients.regimen7A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen7A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">7B</td>
        <td>ABC 300mg + ddI 200mg + NFV 250mg  [> 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen7B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen7B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen7B">${register.newEstimatedArtPatients.regimen7B}</span>
			<span id="widget.newEstimatedArtPatients.regimen7B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen7B">${register.totalEstimatedArtPatients.regimen7B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen7B"></span>
		</td>
    </tr>
	<tr>
        <td colspan="5" style="background: #DDDDDD"><strong>Other Adult ART Regimens</strong></td>
    </tr>
	<tr>
        <td align = "center">8</td>
        <td>AZT 300mg + 3TC 150mg + LPV/r 133.3mg/33.3mg</td>
        <td>${register.artRegimenReport.regimen8}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen8', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen8">${register.newEstimatedArtPatients.regimen8}</span>
			<span id="widget.newEstimatedArtPatients.regimen8"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen8">${register.totalEstimatedArtPatients.regimen8}</span>
			<span id="widget.totalEstimatedArtPatients.regimen8"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">9</td>
        <td>AZT 300mg + 3TC 150mg + IDV 400mg + RTV 100mg</td>
        <td>${register.artRegimenReport.regimen9}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen9', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen9">${register.newEstimatedArtPatients.regimen9}</span>
			<span id="widget.newEstimatedArtPatients.regimen9"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen9">${register.totalEstimatedArtPatients.regimen9}</span>
			<span id="widget.totalEstimatedArtPatients.regimen9"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">10A</td>
        <td>AZT 300mg + ddI 125mg + IDV 400mg + RTV 100mg [< 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen10A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen10A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen10A">${register.newEstimatedArtPatients.regimen10A}</span>
			<span id="widget.newEstimatedArtPatients.regimen10A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen10A">${register.totalEstimatedArtPatients.regimen10A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen10A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">10B</td>
        <td>AZT 300mg + ddI 200mg + IDV 400mg + RTV 100mg [> 60 Kg ]</td>
        <td>${register.artRegimenReport.regimen10B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen10B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen10B">${register.newEstimatedArtPatients.regimen10B}</span>
			<span id="widget.newEstimatedArtPatients.regimen10B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen10B">${register.totalEstimatedArtPatients.regimen10B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen10B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">11A</td>
        <td>TDF 300mg + ABC 300mg + LPV/r 133.3mg/33.3mg  </td>
        <td>${register.artRegimenReport.regimen11A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen11A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen11A">${register.newEstimatedArtPatients.regimen11A}</span>
			<span id="widget.newEstimatedArtPatients.regimen11A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen11A">${register.totalEstimatedArtPatients.regimen11A}</span>
			<span id="widget.totalEstimatedArtPatients.regimen11A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">11B</td>
        <td>TDF 300mg + AZT 300mg + LPV/r 133.3mg/33.3mg  </td>
        <td>${register.artRegimenReport.regimen11B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen11B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen11B">${register.newEstimatedArtPatients.regimen11B}</span>
			<span id="widget.newEstimatedArtPatients.regimen11B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen11B">${register.totalEstimatedArtPatients.regimen11B}</span>
			<span id="widget.totalEstimatedArtPatients.regimen11B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">11C</td>
        <td>TDF 300mg + 3TC 150mg + NVP 200mg</td>
        <td>${register.artRegimenReport.regimen11C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen11C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen11C">${register.newEstimatedArtPatients.regimen11C}</span>
			<span id="widget.newEstimatedArtPatients.regimen11C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen11C">${register.totalEstimatedArtPatients.regimen11C}</span>
			<span id="widget.totalEstimatedArtPatients.regimen11C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">11D</td>
        <td>TDF 300mg + 3TC 150mg + EFV 600mg</td>
        <td>${register.artRegimenReport.regimen11D}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen11D', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen11D">${register.newEstimatedArtPatients.regimen11D}</span>
			<span id="widget.newEstimatedArtPatients.regimen11D"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen11D">${register.totalEstimatedArtPatients.regimen11D}</span>
			<span id="widget.totalEstimatedArtPatients.regimen11D"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">11E</td>
        <td>TDF 300mg + 3TC 150mg + LPV/r 200mg/50mg  </td>
        <td>${register.artRegimenReport.regimen11E}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen11E', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen11E">${register.newEstimatedArtPatients.regimen11E}</span>
			<span id="widget.newEstimatedArtPatients.regimen11E"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen11E">${register.totalEstimatedArtPatients.regimen11E}</span>
			<span id="widget.totalEstimatedArtPatients.regimen11E"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">12</td>
        <td>d4T 30mg + 3TC 150mg + LPV/r 200mg/50mg</td>
        <td>${register.artRegimenReport.regimen12}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimen12', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen12">${register.newEstimatedArtPatients.regimen12}</span>
			<span id="widget.newEstimatedArtPatients.regimen12"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen12">${register.totalEstimatedArtPatients.regimen12}</span>
			<span id="widget.totalEstimatedArtPatients.regimen12"></span>
		</td>
    </tr>
    <tr>
		<td colspan="5" style="background: #DDDDDD"><strong>Paediatric First Line Regimens</strong></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="4"><strong>d4T + 3TC + NVP</strong></td>
	</tr>
	<tr>
        <td align = "center">C1A</td>
        <td>d4T + 3TC + NVP [0 - <10 kg]</td>
        <td>${register.artRegimenReport.regimenC1A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC1A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC1A">${register.newEstimatedArtPatients.regimenC1A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC1A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC1A">${register.totalEstimatedArtPatients.regimenC1A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC1A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C1B</td>
        <td>d4T + 3TC + NVP [10 - <20 kg]</td>
        <td>${register.artRegimenReport.regimenC1B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC1B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC1B">${register.newEstimatedArtPatients.regimenC1B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC1B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC1B">${register.totalEstimatedArtPatients.regimenC1B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC1B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C1C</td>
        <td>d4T + 3TC + NVP [20 - <30 kg]</td>
        <td>${register.artRegimenReport.regimenC1C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC1C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC1C">${register.newEstimatedArtPatients.regimenC1C}</span>
			<span id="widget.newEstimatedArtPatients.regimenC1C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC1C">${register.totalEstimatedArtPatients.regimenC1C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC1C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C1D</td>
        <td>d4T + 3TC + NVP [30 - <40 kg]</td>
        <td>${register.artRegimenReport.regimenC1D}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC1D', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC1D">${register.newEstimatedArtPatients.regimenC1D}</span>
			<span id="widget.newEstimatedArtPatients.regimenC1D"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC1D">${register.totalEstimatedArtPatients.regimenC1D}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC1D"></span>
		</td>
    </tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="4"><strong>d4T + 3TC + EFV</strong></td>
	</tr>
	<tr>
        <td align = "center">C2A</td>
        <td>d4T + 3TC + EFV [0 - <10 kg]</td>
        <td>${register.artRegimenReport.regimenC2A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC2A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC2A">${register.newEstimatedArtPatients.regimenC2A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC2A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC2A">${register.totalEstimatedArtPatients.regimenC2A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC2A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C2B</td>
        <td>d4T + 3TC + EFV [10 - <20 kg]</td>
        <td>${register.artRegimenReport.regimenC2B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC2B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC2B">${register.newEstimatedArtPatients.regimenC2B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC2B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC2B">${register.totalEstimatedArtPatients.regimenC2B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC2B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C2C</td>
        <td>d4T + 3TC + EFV [20 - <30 kg]</td>
        <td>${register.artRegimenReport.regimenC2C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC2C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC2C">${register.newEstimatedArtPatients.regimenC2C}</span>
			<span id="widget.newEstimatedArtPatients.regimenC2C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC2C">${register.totalEstimatedArtPatients.regimenC2C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC2C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C2D</td>
        <td>d4T + 3TC + EFV [30 - <40 kg]</td>
        <td>${register.artRegimenReport.regimenC2D}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC2D', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC2D">${register.newEstimatedArtPatients.regimenC2D}</span>
			<span id="widget.newEstimatedArtPatients.regimenC2D"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC2D">${register.totalEstimatedArtPatients.regimenC2D}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC2D"></span>
		</td>
    </tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="4"><strong>AZT + 3TC + EFV</strong></td>
	</tr>
	<tr>
        <td align = "center">C3A</td>
        <td>AZT + 3TC + EFV [0 - <10 kg]</td>
        <td>${register.artRegimenReport.regimenC3A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC3A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC3A">${register.newEstimatedArtPatients.regimenC3A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC3A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC3A">${register.totalEstimatedArtPatients.regimenC3A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC3A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C3B</td>
        <td>AZT + 3TC + EFV [10 - <20 kg]</td>
        <td>${register.artRegimenReport.regimenC3B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC3B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC3B">${register.newEstimatedArtPatients.regimenC3B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC3B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC3B">${register.totalEstimatedArtPatients.regimenC3B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC3B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C3C</td>
        <td>AZT + 3TC + EFV [20 - <30 kg]</td>
        <td>${register.artRegimenReport.regimenC3C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC3C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC3C">${register.newEstimatedArtPatients.regimenC3C}</span>
			<span id="widget.newEstimatedArtPatients.regimenC3C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC3C">${register.totalEstimatedArtPatients.regimenC3C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC3C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C3D</td>
        <td>AZT + 3TC + EFV [30 - <40 kg]</td>
        <td>${register.artRegimenReport.regimenC3D}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC3D', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC3D">${register.newEstimatedArtPatients.regimenC3D}</span>
			<span id="widget.newEstimatedArtPatients.regimenC3D"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC3D">${register.totalEstimatedArtPatients.regimenC3D}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC3D"></span>
		</td>
    </tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="4"><strong>AZT + 3TC + NVP</strong></td>
	</tr>
	<tr>
        <td align = "center">C4A</td>
        <td>AZT + 3TC + NVP [0 - <10 kg]</td>
		<td>${register.artRegimenReport.regimenC4A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC4A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC4A">${register.newEstimatedArtPatients.regimenC4A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC4A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC4A">${register.totalEstimatedArtPatients.regimenC4A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC4A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C4B</td>
        <td>AZT + 3TC + NVP [10 - <20 kg]</td>
        <td>${register.artRegimenReport.regimenC4B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC4B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC4B">${register.newEstimatedArtPatients.regimenC4B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC4B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC4B">${register.totalEstimatedArtPatients.regimenC4B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC4B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C4C</td>
        <td>AZT + 3TC + NVP [20 - <30 kg]</td>
        <td>${register.artRegimenReport.regimenC4C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC4C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC4C">${register.newEstimatedArtPatients.regimenC4C}</span>
			<span id="widget.newEstimatedArtPatients.regimenC4C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC4C">${register.totalEstimatedArtPatients.regimenC4C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC4C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C4D</td>
        <td>AZT + 3TC + NVP [30 - <40 kg]</td>
        <td>${register.artRegimenReport.regimenC4D}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC4D', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC4D">${register.newEstimatedArtPatients.regimenC4D}</span>
			<span id="widget.newEstimatedArtPatients.regimenC4D"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC4D">${register.totalEstimatedArtPatients.regimenC4D}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC4D"></span>
		</td>
    </tr>
	<tr>
		<th colspan="5">Paediatric Second-Line Regimens</th>
	</tr>
	<tr>
        <td align = "center">C5A</td>
        <td>d4T + ABC + LPV/r</td>
		<td>${register.artRegimenReport.regimenC5A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC5A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC5A">${register.newEstimatedArtPatients.regimenC5A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC5A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC5A">${register.totalEstimatedArtPatients.regimenC5A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC5A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C5B</td>
        <td>d4T + ABC + NFV</td>
        <td>${register.artRegimenReport.regimenC5B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC5B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC5B">${register.newEstimatedArtPatients.regimenC5B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC5B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC5B">${register.totalEstimatedArtPatients.regimenC5B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC5B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C6A</td>
        <td>AZT + ABC + LPV/r</td>
        <td>${register.artRegimenReport.regimenC6A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC6A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC6A">${register.newEstimatedArtPatients.regimenC6A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC6A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC6A">${register.totalEstimatedArtPatients.regimenC6A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC6A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C6B</td>
        <td>AZT + ABC + NFV</td>
        <td>${register.artRegimenReport.regimenC6B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC6B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC6B">${register.newEstimatedArtPatients.regimenC6B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC6B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC6B">${register.totalEstimatedArtPatients.regimenC6B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC6B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C7A</td>
        <td>ABC + ddI + LPV/r</td>
        <td>${register.artRegimenReport.regimenC7A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC7A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC7A">${register.newEstimatedArtPatients.regimenC7A}</span>
			<span id="widget.newEstimatedArtPatients.regimenC7A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC7A">${register.totalEstimatedArtPatients.regimenC7A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC7A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C7B</td>
        <td>ABC + ddI + NFV</td>
        <td>${register.artRegimenReport.regimenC7B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC7B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC7B">${register.newEstimatedArtPatients.regimenC7B}</span>
			<span id="widget.newEstimatedArtPatients.regimenC7B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC7B">${register.totalEstimatedArtPatients.regimenC7B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC7B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">C8</td>
        <td>AZT + 3TC + LPV/r</td>
        <td>${register.artRegimenReport.regimenC8}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenC8', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenC8">${register.newEstimatedArtPatients.regimenC8}</span>
			<span id="widget.newEstimatedArtPatients.regimenC8"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenC8">${register.totalEstimatedArtPatients.regimenC8}</span>
			<span id="widget.totalEstimatedArtPatients.regimenC8"></span>
		</td>
    </tr>
	<tr>
        <th colspan="5">Post Exposure Prophylaxis (PEP)</th>
    </tr>
	<tr>
        <td align = "center">PEP1</td>
        <td>AZT 300mg + 3TC 150mg </td>
        <td>${register.artRegimenReport.regimenPEP1}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP1', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP1">${register.newEstimatedArtPatients.regimenPEP1}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP1"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP1">${register.totalEstimatedArtPatients.regimenPEP1}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP1"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP2A</td>
        <td>d4T 30mg + 3TC 150mg  [< 60Kg]</td>
        <td>${register.artRegimenReport.regimenPEP2A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP2A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP2A">${register.newEstimatedArtPatients.regimenPEP2A}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP2A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP2A">${register.totalEstimatedArtPatients.regimenPEP2A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP2A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP3</td>
        <td>AZT 300mg + 3TC 150mg + LPV/r 133.3/33.3mg</td>
        <td>${register.artRegimenReport.regimenPEP3}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP3', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP3">${register.newEstimatedArtPatients.regimenPEP3}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP3"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP3">${register.totalEstimatedArtPatients.regimenPEP3}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP3"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP4</td>
        <td>AZT 300mg + 3TC 150mg + IDV 400mg + RTV 100mg</td>
        <td>${register.artRegimenReport.regimenPEP4}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP4', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP4">${register.newEstimatedArtPatients.regimenPEP4}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP4"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP4">${register.totalEstimatedArtPatients.regimenPEP4}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP4"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP5</td>
        <td>AZT 300mg + 3TC 150mg + NFV 250mg</td>
        <td>${register.artRegimenReport.regimenPEP5}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP5', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP5">${register.newEstimatedArtPatients.regimenPEP5}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP5"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP5">${register.totalEstimatedArtPatients.regimenPEP5}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP5"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP6A</td>
        <td>Paed: AZT + 3TC</td>
        <td>${register.artRegimenReport.regimenPEP6A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP6A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP6A">${register.newEstimatedArtPatients.regimenPEP6A}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP6A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP6A">${register.totalEstimatedArtPatients.regimenPEP6A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP6A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP6B</td>
        <td>Paed: AZT + 3TC + LPV/r</td>
        <td>${register.artRegimenReport.regimenPEP6B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP6B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP6B">${register.newEstimatedArtPatients.regimenPEP6B}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP6B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP6B">${register.totalEstimatedArtPatients.regimenPEP6B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP6B"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP6C</td>
        <td>Paed: AZT + 3TC + NFV</td>
        <td>${register.artRegimenReport.regimenPEP6C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP6C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP6C">${register.newEstimatedArtPatients.regimenPEP6C}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP6C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP6C">${register.totalEstimatedArtPatients.regimenPEP6C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP6C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP7A</td>
        <td>Paed: d4T + 3TC </td>
        <td>${register.artRegimenReport.regimenPEP7A}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP7A', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP7A">${register.newEstimatedArtPatients.regimenPEP7A}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP7A"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP7A">${register.totalEstimatedArtPatients.regimenPEP7A}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP7A"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PEP7B</td>
        <td>Paed: d4T + 3TC + LPV/r</td>
        <td>${register.artRegimenReport.regimenPEP7B}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPEP7B', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPEP7B">${register.newEstimatedArtPatients.regimenPEP7B}</span>
			<span id="widget.newEstimatedArtPatients.regimenPEP7B"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPEP7B">${register.totalEstimatedArtPatients.regimenPEP7B}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPEP7B"></span>
		</td>
    </tr>
	<tr>
		<th colspan="5">PMTCT Regimens</th>
	</tr>
	<tr>
		<td align = "center"><strong>1</strong></td>
		<td colspan="4"><strong>Mother</strong></td>
	</tr>
	<tr>
        <td align = "center">PMTCT 1M</td>
        <td>Nevirapine (NVP) 200mg stat</td>
        <td>${register.artRegimenReport.regimenPMTCT_1M}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_1M', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_1M">${register.newEstimatedArtPatients.regimenPMTCT_1M}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_1M"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_1M">${register.totalEstimatedArtPatients.regimenPMTCT_1M}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_1M"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PMTCT 3M</td>
        <td>AZT 300mg BD (from week 14-40); then NVP 200mg stat + AZT 600mg stat during labour; then 1 tab of AZT/3TC 300/150mg BD for one week post-partum</td>
        <td>${register.artRegimenReport.regimenPMTCT_3M}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_3M', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_3M">${register.newEstimatedArtPatients.regimenPMTCT_3M}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_3M"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_3M">${register.totalEstimatedArtPatients.regimenPMTCT_3M}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_3M"></span>
		</td>
    </tr>
    	<tr>
        <td align = "center">PMTCT 4M</td>
        <td>PMTCT HAART: AZT 300mg + 3TC 150mg + NVP 200mg</td>
        <td>${register.artRegimenReport.regimenPMTCT_4M}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_4M', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_4M">${register.newEstimatedArtPatients.regimenPMTCT_4M}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_4M"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_4M">${register.totalEstimatedArtPatients.regimenPMTCT_4M}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_4M"></span>
		</td>
    </tr>
    	<tr>
        <td align = "center">PMTCT 5M</td>
        <td>PMTCT HAART: AZT 300mg + 3TC 150mg + EFV 600mg</td>
        <td>${register.artRegimenReport.regimenPMTCT_5M}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_5M', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_5M">${register.newEstimatedArtPatients.regimenPMTCT_5M}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_5M"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_5M">${register.totalEstimatedArtPatients.regimenPMTCT_5M}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_5M"></span>
		</td>
    </tr>
    	<tr>
        <td align = "center">PMTCT 6M</td>
        <td>PMTCT HAART: AZT 300mg + 3TC 150mg + LPV/r</td>
        <td>${register.artRegimenReport.regimenPMTCT_6M}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_6M', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_6M">${register.newEstimatedArtPatients.regimenPMTCT_6M}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_6M"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_6M">${register.totalEstimatedArtPatients.regimenPMTCT_6M}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_6M"></span>
		</td>
    </tr>
	<tr>
		<td align = "center"><strong>2</strong></td>
		<td colspan="4"><strong>Child</strong></td>
	</tr>
	<tr>
        <td align = "center">PMTCT 1C</td>
        <td>Nevirapine (NVP) 2 mg/kg stat</td>
        <td>${register.artRegimenReport.regimenPMTCT_1C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_1C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_1C">${register.newEstimatedArtPatients.regimenPMTCT_1C}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_1C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_1C">${register.totalEstimatedArtPatients.regimenPMTCT_1C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_1C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PMTCT 4C</td>
        <td>NVP 2 mg/kg stat + AZT 4mg/kg bd for 6 weeks</td>
        <td>${register.artRegimenReport.regimenPMTCT_4C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_4C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_4C">${register.newEstimatedArtPatients.regimenPMTCT_4C}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_4C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_4C">${register.totalEstimatedArtPatients.regimenPMTCT_4C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_4C"></span>
		</td>
    </tr>
	<tr>
        <td align = "center">PMTCT 5C</td>
        <td>NVP 2 mg/kg stat + AZT 4mg/kg bd for 6 weeks + 3TC 4mg/kg bd for 1 week</td>
        <td>${register.artRegimenReport.regimenPMTCT_5C}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenPMTCT_5C', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenPMTCT_5C">${register.newEstimatedArtPatients.regimenPMTCT_5C}</span>
			<span id="widget.newEstimatedArtPatients.regimenPMTCT_5C"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenPMTCT_5C">${register.totalEstimatedArtPatients.regimenPMTCT_5C}</span>
			<span id="widget.totalEstimatedArtPatients.regimenPMTCT_5C"></span>
		</td>
    </tr>

	<tr>
		<th colspan="5">Other Regimens</th>
	</tr>
	<c:forEach items="${register.regimenList}" var="regimen">
    <tr>
        <td>${regimen.code}</td>
        <td>${regimen.name}</td>
        <td>${regimen.countInt}</td>
        <td align="left" ondblclick="callDynamicReportWidget('newEstimatedArtPatients.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimen${regimen.code}"></span>
		</td>
    </tr>
    </c:forEach>
</c:otherwise>
</c:choose>
</table>
<c:choose>
<c:when test="${!empty isCombinedReport}">
<table  border="1" cellspacing="2" cellpadding="3" width="800px" class="reportTablePrint">
<tr>
<td style="background: #DDD;text-align: right;font-size: 110%">Once you have completed this report,
click the "Save" button to save this report and generate Combined Report.</td>
<td style="background: green top left repeat-x; color: #FFF; font-size: 140%; font-weight: normal; padding: 8px 10px; margin: 0; text-align: center" >
<c:choose>
<c:when test="${! empty dynamicReport}">
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport', ${dynamicReport});" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
</c:when>
<c:otherwise>
<p>After you make an entry in the "Estimated No. of New Patients" column, the report will be saved at:<br/> ${register.reportPath}</p>
</c:otherwise>
</c:choose>
</template:put>
</template:insert>

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
<c:when test="${! empty isFacilityReport}">
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport', null, true);" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose></td>
</tr>
</table>
</c:when>
<c:otherwise></c:otherwise>
</c:choose>
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
    
    <c:forEach items="${register.reportDisplayList}" var="regimen">
    <c:choose>
	    <c:when test="${regimen.rowType == 'header'}">
	    <c:choose>
		    <c:when test="${! empty regimen.title2}">
		    <tr>
				<td align = "center"><strong>${regimen.title}</strong></td>
				<td colspan="4"><strong>${regimen.title2}</strong></td>
			</tr>
		    </c:when>
		    <c:otherwise>
		    <tr>
				<th colspan="5">${regimen.title}</th>
			</tr>
			</c:otherwise>
	    </c:choose>
	    </c:when>
     <c:when test="${regimen.rowType == 'regimen'}">
     <c:if test="${! empty regimen.code}">
     <tr>
        <td align = "center">
        <c:choose>
        <c:when test="${! empty regimen.alternateCode}">${regimen.code} / ${regimen.alternateCode}</c:when>
        <c:otherwise>${regimen.code}</c:otherwise>
        </c:choose>        </td>
        <td>${regimen.title}</td>
        <td>${regimen.value}</td>
		<td align="left" ondblclick="callReportWidget('newEstimatedArtPatients.regimenReportMap.regimen${regimen.code}', 'MonthlyArtReport')" class="reportInput">
			<span id="value.newEstimatedArtPatients.regimenReportMap.regimen${regimen.code}">${regimen.newEstimatedArtPatients}</span>
			<span id="widget.newEstimatedArtPatients.regimenReportMap.regimen${regimen.code}"></span>		</td>
		<td>
			<span id="value.totalEstimatedArtPatients.regimenReportMap.regimen${regimen.code}">${regimen.totalEstimatedArtPatients}</span>
			<span id="widget.totalEstimatedArtPatients.regimenReportMap.regimen${regimen.code}"></span>		</td>
    </tr>
    </c:if>
    </c:when>
    </c:choose>
    </c:forEach>
</table>

<p>here is my modifacation </p>
<p> </p>

<!-- this is addition by Antony -->

<!--  <table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint" width="800px">

	
    
    <c:forEach items="${register.reportDisplayList}" var="regimen">
    <c:choose>
	    <c:when test="${regimen.rowType == 'header'}">
	    <c:choose>
		    <c:when test="${! empty regimen.title2}">
		    <tr>
				<td align = "center"><strong>${regimen.title}</strong></td>
				<td colspan="4"><strong>${regimen.title2}</strong></td>
			</tr>
		    </c:when>
		    <c:otherwise>
		    <tr>
				<th colspan="5">${regimen.title}</th>
			</tr>
			</c:otherwise>
	    </c:choose>
	    </c:when>
     <c:when test="${regimen.rowType == 'regimen'}">
     <!-- changed from regimen code to regimen name -->
    <!--  <c:if test="${! empty regimen.title}">
     <tr>
     
      
         <td>${regimen.title}</td>  
        <td>${regimen.value}</td> 
    </tr>
    </c:if>
    </c:when>
    </c:choose>
    </c:forEach>
</table> -->

<p>
  <!-- This is end of addition by antony -->
</p>
<p>&nbsp; </p>
<table border="1" cellspacing="2" cellpadding="3"  width="481" height="20">
	<tr>
		<td width="208" >REGIMEN GROUP</td>
		<td width="102">NEW</td>
		<td width="137">REVISIT</td>
	</tr>
	<tr>
		<td>PMTCT pregnant women </td>
		<td>6</td>
		<td>4</td>
	</tr>
</table>


<p>&nbsp;</p>

<table border="1" cellspacing="2" cellpadding="3"  width="334" height="20">
	<tr>
		<td width="208" >REGIMEN GROUP</td>
		<td width="102">TOTAL</td>
	  </tr>
	<tr>
		<td>PMTCT for children</td>
		<td>12</td>
	  </tr>
	<tr>
		<td>Adult ART 1st line </td>
		<td>15</td>
	  </tr>
	<tr>
		<td>Adult ART 2nd line </td>
		<td>10</td>
	  </tr>
	<tr>
		<td>Paediatric 1st line </td>
		<td>8</td>
	  </tr>
	<tr>
		<td>Paediatric 2nd line </td>
		<td>12</td>
	  </tr>
	<tr>
		<td>paediatric 3rd line </td>
		<td>8</td>
	  </tr>
</table>

<p>&nbsp;</p>
<table border="1" cellspacing="2" cellpadding="3"  width="334" height="20">
  <tr>
    <td width="208" >OI </td>
    <td width="102">TOTAL</td>
  </tr>
  <tr>
    <td>Septrin</td>
    <td>8</td>
  </tr>
  <tr>
    <td>Dapsone</td>
    <td>9</td>
  </tr>
  <tr>
    <td>Acyclovir</td>
    <td>7</td>
  </tr>
  <tr>
    <td>Fluconazole</td>
    <td>5</td>
  </tr>
  <tr>
    <td>Pyrodoxine</td>
    <td>10</td>
  </tr>
</table>
<p>&nbsp;</p>
<table border="1" cellpadding="3" width="75%">
  <tr>
    <td>Report prepared by: </td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Designation: </td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Name of Reporting officer</td>
    <td colspan="8">&nbsp;</td>
  </tr>
  <tr>
    <td>Contact Telephone:</td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Date: </td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>Report approved by: </td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Designation: </td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Head of Institution</td>
    <td colspan="8">&nbsp;</td>
  </tr>
  <tr>
    <td>Contact Telephone:</td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>Date: </td>
    <td>&nbsp;</td>
    <td style="border: 1px solid gray;" colspan="2">&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
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
<c:when test="${! empty isFacilityReport}">
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport', null, true);" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:when>
<c:otherwise>
<input type="button" value="Save" onclick="saveReport('MonthlyArtReport');" style="font-size: medium; font-weight: bold;" tabindex="-1"/>
</c:otherwise>
</c:choose></td>
</tr>
</table>
</c:when>
</c:choose>
</template:put>
</template:insert>

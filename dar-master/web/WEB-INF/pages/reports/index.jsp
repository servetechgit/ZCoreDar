<%@ page import="java.util.Date"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="org.rti.zcore.utils.DateUtils"%>

<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    java.util.Calendar c = java.util.Calendar.getInstance();
    c.add(java.util.Calendar.MONTH, -1);
    Date date1monthpast = c.getTime();
    String DATE_FORMAT = "yyyy-MM-dd";
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
    sdf.setTimeZone(TimeZone.getDefault());
    String date1monthpastStr = sdf.format(date1monthpast);
    java.sql.Date date1monthpastSql =  java.sql.Date.valueOf(date1monthpastStr);
    pageContext.setAttribute("date1monthpast", date1monthpast);
    pageContext.setAttribute("date1monthpastSql", date1monthpastSql);
    java.sql.Date dateNow = DateUtils.getNow();
    pageContext.setAttribute("dateNow", dateNow);
    // week
    java.util.Calendar c2 = java.util.Calendar.getInstance();
    c2.add(java.util.Calendar.WEEK_OF_YEAR, -1);
    Date date1weekpast = c2.getTime();
    java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(DATE_FORMAT);
    sdf2.setTimeZone(TimeZone.getDefault());
    String date1weekpastStr = sdf2.format(date1weekpast);
    java.sql.Date date1weekpastSql =  java.sql.Date.valueOf(date1weekpastStr);
    pageContext.setAttribute("date1weekpastSql", date1weekpastSql);
    // quarter
    java.util.Calendar c3 = java.util.Calendar.getInstance();
    c3.add(java.util.Calendar.MONTH, -3);
    Date quarterPast = c3.getTime();
    java.text.SimpleDateFormat sdf3 = new java.text.SimpleDateFormat(DATE_FORMAT);
    sdf2.setTimeZone(TimeZone.getDefault());
    String quarterPastStr = sdf3.format(quarterPast);
    java.sql.Date quarterPastSql =  java.sql.Date.valueOf(quarterPastStr);
    pageContext.setAttribute("quarterPastSql", quarterPastSql);
    // week ahead
    java.util.Calendar c4 = java.util.Calendar.getInstance();
    c4.add(java.util.Calendar.WEEK_OF_YEAR, +1);
    Date date1weekahead = c4.getTime();
    java.text.SimpleDateFormat sdf4 = new java.text.SimpleDateFormat(DATE_FORMAT);
    sdf2.setTimeZone(TimeZone.getDefault());
    String date1weekaheadStr = sdf4.format(date1weekahead);
    java.sql.Date date1weekaheadSql =  java.sql.Date.valueOf(date1weekaheadStr);
    pageContext.setAttribute("date1weekaheadSql", date1weekaheadSql);
%>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' direct='true'>Reports</template:put>

<template:put name='content' direct='true'>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="theDate" value="${now}"/>
<fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${date1monthpast}" var="dbdate1monthpast" />
<fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${theDate}" var="dbNow" />

<c:choose>
    <c:when test="${empty site}">
    <c:set var="theSite" value="${patientSiteId}"/>
    </c:when>
    <c:otherwise>
    <c:set var="theSite" value="${site}"/>
    </c:otherwise>
</c:choose>

<div id="widePage">
    <h2>Reports</h2>
<p>Instructions: Select a report from the dropdown and select the begin and end dates.</p>

    <html:form action="/ChooseReportAction">
    <input type="hidden" name="task" value="run"/>
	<table cellspacing="0" cellpadding="5" class="enhancedtabletighterCell">
	<tr>
		<th>Report</th>
		<logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
        <th>Site</th>
		</logic:present>
        <th>Begin Date</th>
        <th>End Date</th>
        <th>&nbsp;</th>
    </tr>
	<tr>
		<td>
			<html:select property="report" size="1">
				<html:option value="20">Combined Monthly Reports for CDRR/ARV's</html:option>
<%-- 				<html:option value="10">ART & PMTCT LMIS Data Aggregation Tool (for Central Sites)</html:option> --%>
				<!-- <html:option value="14">Monthly Reports for ARV and OI - Dynamic</html:option> -->
				<html:option value="1">OI - Daily Activity Report</html:option>
				<html:option value="2">ART - Adults - Daily Activity Report</html:option>
				<html:option value="3">ART - Paeds - Daily Activity Report</html:option>
				<!-- <html:option value="4">OI - ART - Adults - DAR Combined Report</html:option> -->
				<html:option value="5">CDRR-ART Report</html:option>
				<!-- <html:option value="15">CDRR-ART Report - Dynamic</html:option> -->
				<html:option value="7">CDRR-OI Report</html:option>
				<!-- <html:option value="17">CDRR-OI Report - Dynamic</html:option> -->
				<html:option value="6">Monthly ART Summary Report</html:option>
				<!-- <html:option value="16">Monthly ART Summary Report - Dynamic</html:option> -->
				<html:option value="8">Appointment Register</html:option>
				<html:option value="9">Defaulters Register</html:option>
				<html:option value="11">Site Statistics Report</html:option>
				<html:option value="12">Stock Usage Report</html:option>
				<html:option value="13">Regimen Change Report</html:option>
            </html:select>
		</td>
		<logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
		<td>
            <select id="siteSelector" name="siteId">
                <option value="">Select Site</option>
                <c:choose>
                    <c:when test="${theSite=='all'}">
                            <option value="0" selected="selected" >All sites</option>
                        <c:forEach var="site" begin="0" items="${sites}">
                            <c:if test="${site.inactive != 1}">
                            <option value="${site.id}">${site.name}</option>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="0">All sites</option>
                        <c:forEach var="site" begin="0" items="${sites}">
                            <c:if test="${site.inactive != 1}">
                            <c:choose>
                            <c:when test="${theSite==site.id}">
                            <option value="${site.id}" selected="selected">${site.name}</option>
                            </c:when>
                            <c:otherwise>
                            <option value="${site.id}">${site.name}</option>
                            </c:otherwise>
                            </c:choose>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
        </td>
		</logic:present>
		<logic:notPresent role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
		<input type="hidden" name="siteId" value="${theSite}"/>
		</logic:notPresent>
        <td>
            <zeprs:date_visit_no_form_no_label element = "chooseReportForm" dateVisit = "${date1monthpastSql}" field = "bdate|bdate1"/>
        </td>

		<td>
            <zeprs:date_visit_no_form_no_label element = "chooseReportForm" dateVisit = "${dateNow}" field = "edate|edate1"/>
        </td>

        <td>
			<center><html:submit/></center>
		</td>
	</tr>
	</table>
    </html:form>
    <h2>Reports w/ set time periods</h2>

    <ul>
        <li><html:link action="ChooseReportAction?bdate=${dateNow}&siteId=${theSite}&report=2">ART Adult Daily Activity Report: today</html:link></li>
        <li><html:link action="ChooseReportAction?bdate=${dateNow}&edate=${date1weekaheadSql}&siteId=${theSite}&report=8">Appointment Register:</html:link> Upcoming Appointments (1 week)</li>
        <li><html:link action="ChooseReportAction?siteId=${zeprs_session.clientSettings.siteId}&report=9">Defaulters Register:</html:link> Patients who have missed appointments over the past week</li>
    </ul>

<logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
	<p><html:link action="archive">Record Modification Listing</html:link> - provides staff name and time that a record has been modified</p>
	<p><html:link action="reports/queryBuilder">Query Builder</html:link> - ad-hoc query interface</p>
</logic:present>

    <%--<p>The reports linked below are provided in XML format - they can be opened in Excel as well as viewed in the browser. Right-click and save to your
        pc, then open in Excel. They are currently generated at 7 AM every day.</p>

    <p>There are two versions of most reports:
        <ul>
            <li>Plain version: Enumerations (dropdowns) have an integer value</li>
            <li>Resolved version: "Resolved" appended to filename. Enumerations are in English.</li>
        </ul>
    </p>

    <p>Special reports:
        <ul>
            <li>PatientReport.xml is a special report that provides a listing of all patients currently in the system, with their
        stage of pregnancy and other useful data</li>
            <li>OutcomeReport.xml is a large file - wait for it to load.</li>
            <li>EncounterReport.xml This report lists data about each enounter, sorted by patient id and date created.
                This could be useful for tracking how long it takes a clinician to complete records for a new patient.
            </li>
        </ul>
    </p>

<table class="enhancedtable">
    <tr>
        <th>File name</th>
        <th>Date created</th>
        <th>File size</th>
    </tr>
<logic:iterate id="report" name="reports">
    <tr>
        <td><a href="data/${report.fileName};jsessionid=${pageContext.request.session.id}">${report.fileName}</a></td>
        <td><fmt:formatDate type="both" pattern="dd MMM yy hh:mm" value="${report.lastModified}" /></td>
        <td><fmt:formatNumber value="${report.length/1024}" maxFractionDigits="2"/>  kb</td>
    </tr>
</logic:iterate>
</table>--%>
<p>&nbsp;</p>
</div>
</template:put>
</template:insert>
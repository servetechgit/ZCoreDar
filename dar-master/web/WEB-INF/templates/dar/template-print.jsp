<%@ page import="org.rti.zcore.utils.DateUtils"%>

<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:setLocale value="en_GB" scope="session"/>
<%
java.sql.Date dateNow = DateUtils.getNow();
pageContext.setAttribute("dateNow", dateNow);
%>
<html>
    <head>
        <title>${zeprs_session.fullname} - Site: ${zeprs_session.clientSettings.site.name} - <template:get name='title'/> <jsp:include page="../../pages/version.html"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <script language="JavaScript" type="text/javascript" src="/${appName}/js/browser_detect.js;jsessionid=${pageContext.request.session.id}"></script>
        <script language="JavaScript" type="text/javascript" src="/${appName}/js/fat.js;jsessionid=${pageContext.request.session.id}"></script>
        <script language="JavaScript" type="text/javascript" src="/${appName}/js/zeprs.js;jsessionid=${pageContext.request.session.id}"></script>
        <script language="JavaScript" type="text/javascript" src="/${appName}/config/javascript.js;jsessionid=${pageContext.request.session.id}"></script>
		<script language="JavaScript" type="text/javascript" src="/${appName}/js/validation.js;jsessionid=${pageContext.request.session.id}"></script>
        <script type="text/javascript">
            //<![CDATA[
            var output = '';
            if (browser.isGecko)
            {
            output += '<link rel="stylesheet" href="/${appName}/css/${appTemplateDir}/styles-moz.css;jsessionid=${pageContext.request.session.id}" charset="ISO-8859-1" type="text/css">';
            }
            else
            {
            output += '<link rel="stylesheet" href="/${appName}/css/${appTemplateDir}/styles-ie.css;jsessionid=${pageContext.request.session.id}" charset="ISO-8859-1" type="text/css">';
            }
            document.write(output);
            //]]>
         </script>
    </head>
    <c:choose>
    <c:when test="${!empty dwr}">
    <body onload="startClock();DWRUtil.useLoadingMessage();">
    </c:when>
    <c:otherwise>
    <body onload="startClock();">
    </c:otherwise>
    </c:choose>
<div id="pagewidth" >
    <div id="banner-home">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="middle" background="/${appName}/images/banner_bkgd.gif" height="46" width="100" ><span class="serviceHeader"><a href="/${appName}/home.do;jsessionid=${pageContext.request.session.id}" border="0">${appTitle}</a></span><br/><span class="serviceHeaderSite">${fn:substring(zeprs_session.clientSettings.site.name,0,12)}</span></td>
            <td background="/${appName}/images/banner_bkgd.gif" align="right">&nbsp;</td>
        </tr>
    </table>
    </div>
	<logic:present name="zeprs_session" property="sessionPatient">
    <c:url value="ArtRegimen/new.do" var="artRegimen"><c:param name="formId" value="137"/><c:param name="patientId" value="${zeprs_session.sessionPatient.id}"/></c:url>
    <c:url value="PatientStatus_changes/new.do" var="currentStatus"><c:param name="patientId" value="${zeprs_session.sessionPatient.id}"/></c:url>
	<div id="patientStatus-print">
        <table cellpadding="0" cellspacing="0" bgColor = "white" summary="Patient Status Bar" width="100%">
        <thead>
            <tr class="patientrowheader">
                <th>Staff</th>
                <th>Patient</th>
                <th>Client ID</th>
                <th>Regimen</th>
                <th>Patient Status</th>
                <th>Date/Time</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="patientrow">${zeprs_session.fullname}</td>
                <td class="patientrow"><html:link styleClass="patient" action="patientHome" paramId="patientId" paramName="zeprs_session" paramProperty="sessionPatient.id" >
        ${fn:substring(zeprs_session.sessionPatient.surname,0,15)},${fn:substring(zeprs_session.sessionPatient.firstName,0,10)}</html:link></td>
                <td class="patientrow">${zeprs_session.sessionPatient.districtPatientid}</td>
                <td class="patientrow"><a title="${zeprs_session.sessionPatient.regimenName}" href='<c:out value="/${appName}/${artRegimen}"/>'>${zeprs_session.sessionPatient.regimenCode}</a></td>
                <td class="patientrow"><a title="${zeprs_session.sessionPatient.currentStatus}" href='<c:out value="/${appName}/${currentStatus}"/>'>${zeprs_session.sessionPatient.currentStatus}</a></td>
                <td class="patientrow"><fmt:formatDate type="both" pattern="dd MMM yy" value="${now}" />&nbsp;<input type="text" id="pcTime" size="7" class="clock" onfocus="this.blur()"/></td>
            </tr>
        </tbody>
        </table>
    </div>
</logic:present>
    <logic:notPresent name="zeprs_session" property="sessionPatient">
        <div id="patientStatus-print">
        <table cellpadding="0" cellspacing="0" bgColor = "white" summary="Patient Status Bar" width="100%">
        <thead>
            <tr class="patientrowheader">
                <th>Staff</th>
                <th>Date/Time</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="patientrow">${zeprs_session.fullname}</td>
                <td class="patientrow"><fmt:formatDate type="both" pattern="dd MMM yy" value="${now}" />&nbsp;<input type="text" id="pcTime" size="7" class="clock" onfocus="this.blur()"/></td>
            </tr>
        </tbody>
        </table>
    </div>
	<c:url value="admin/records/list.do" var="stock_control">
		<c:param name="formId" value="161"/>
		<c:param name="maxRows" value="20"/>
	</c:url>
	<div id="twocols" class="clearfix">
 <template:get name='content' ignore="true"/>
	</div>
    <div id="sidebar-a-print">
        <div id="sidenavcontainer">
            <ul id="navlist">
                <li style="font-size: 11pt;"><a href="/${appName}/home.do;jsessionid=${pageContext.request.session.id}">Home</a></li>
                <logic:present role="CREATE_NEW_PATIENTS_AND_SEARCH">
                <li style="margin: 0px 0px 0px 5px;">&nbsp;</li>
                <li><html:link action="form1/new.do" onclick="alert('Please ensure that you have searched for this patient before creating a new record.');">New Patient</html:link></li>
                </logic:present>
                <logic:present role="VIEW_SELECTED_REPORTS_AND_VIEW_STATISTICAL_SUMMARIES">
                <li style="margin: 0px 0px 0px 5px;">&nbsp;</li>
                <li><html:link action="/reports">Reports</html:link></li>
                <li><html:link action="ChooseReportAction?bdate=${dateNow}&siteId=${zeprs_session.clientSettings.siteId}&report=2">Daily Activity Report</html:link></li>
                <li><html:link action="ChooseReportAction?siteId=${zeprs_session.clientSettings.siteId}&report=8">Appointments</html:link></li>
        		<li><html:link action="ChooseReportAction?siteId=${zeprs_session.clientSettings.siteId}&report=9">Defaulters</html:link></li>
        		<li><html:link action="ChooseReportAction?siteId=${zeprs_session.clientSettings.siteId}&report=11">Statistics</html:link></li>
				<li><a href='<c:out value="/${appName}/${stock_control}"/>'>Stock Control</a></li>
                </logic:present>
                <li><html:link action="/help">Help</html:link></li>
                <li style="margin: 0px 0px 0px 5px;">&nbsp;</li>
                <logic:present role="CONFIGURE_APPLICATION">
                <li><html:link action="/config/home.do">Configuration</html:link></li>
                </logic:present>
                <logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
                <li><html:link action="/admin/home">Form Admin</html:link></li>
                </logic:present>
                <li><html:link action="/logout">Logout</html:link></li>
            </ul><!-- navlist -->
        </div> <!-- sidenavcontainer -->
    </div><!-- sidebar-a -->
    </logic:notPresent>
	<logic:present name="zeprs_session" property="sessionPatient">
		<div id="twocols" class="clearfix">
		 <template:get name='content' ignore="true"/>
		</div>
        <logic:present role="VIEW_INDIVIDUAL_PATIENT_RECORDS">
            <jsp:include page="sidenav-full-print.jsp"/>
        </logic:present>
        <logic:notPresent role="VIEW_INDIVIDUAL_PATIENT_RECORDS">
            <jsp:include page="sidenav-clerk.jsp"/>
        </logic:notPresent>
    </logic:present>
</div><!-- pagewidth -->
    </body>
</html>


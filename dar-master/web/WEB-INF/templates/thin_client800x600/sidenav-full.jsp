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

<%
java.sql.Date dateNow = DateUtils.getNow();
pageContext.setAttribute("dateNow", dateNow);
%>
<div id="patientStatus">
        <table cellpadding="0" cellspacing="0" bgColor = "white" summary="Patient Status Bar" width="100%">
        <thead>
            <tr class="patientrowheader">
                <th>Staff</th>
                <th>Patient</th>
                <th>Client ID</th>
                <th>Date/Time</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="patientrow">${zeprs_session.fullname}</td>
                <td class="patientrow"><html:link styleClass="patient" action="patientHome" paramId="patientId" paramName="zeprs_session" paramProperty="sessionPatient.id" >
        ${fn:substring(zeprs_session.sessionPatient.surname,0,15)},${fn:substring(zeprs_session.sessionPatient.firstName,0,10)}</html:link></td>
                <td class="patientrow">${zeprs_session.sessionPatient.districtPatientid}</td>
                <td class="patientrow"><fmt:formatDate type="both" pattern="dd/MM/yy" value="${now}" />&nbsp;<input type="text" id="pcTime" size="7" class="clock" onfocus="this.blur()"/></td>
            </tr>
        </tbody>
        </table>
    </div>

    <c:url value="patientTask.do" var="dispensing"><c:param name="patientId" value="${zeprs_session.sessionPatient.id}"/><c:param name="flowId" value="2"/></c:url>
    <c:url value="chart.do" var="health"><c:param name="id" value="136"/></c:url>
    <c:url value="patientTask.do" var="art_regimen"><c:param name="patientId" value="${zeprs_session.sessionPatient.id}"/><c:param name="flowId" value="4"/></c:url>

	<c:url value="admin/records/list.do" var="stock_control"><c:param name="formId" value="161"/></c:url>
	<c:url value="admin/records/list.do" var="regime_groups"><c:param name="formId" value="128"/></c:url>
	<c:url value="admin/records/list.do" var="regimen"><c:param name="formId" value="129"/></c:url>
	<c:url value="admin/records/list.do" var="stock_groups"><c:param name="formId" value="130"/></c:url>
	<c:url value="admin/records/list.do" var="stock"><c:param name="formId" value="131"/></c:url>

    <div id="sidebar-a">
        <div id="sidenavcontainer">
            <ul id="navlist">
                <li style="font-size: 11pt;"><a href="/${appName}/home.do;jsessionid=${pageContext.request.session.id}">Home</a></li>
                <c:if test="${! empty zeprs_session.sessionPatient.id}" >
                <li><html:link action="/demographics.do" paramId="patientId" paramName="zeprs_session" paramProperty="sessionPatient.id">Demographics</html:link></li>
                <li><a href='<c:out value="/${appName}/${dispensing}"/>'>Dispensing</a></li>
                <li><a href='<c:out value="/${appName}/${health}"/>'>Health</a></li>
                <li><a href='<c:out value="/${appName}/${art_regimen}"/>'>ART Regimen</a></li>
                </c:if>
                <li style="margin: 0px 0px 0px 5px;">&nbsp;</li>
                <logic:present role="VIEW_SELECTED_REPORTS_AND_VIEW_STATISTICAL_SUMMARIES">
                <li><html:link action="ChooseReportAction?bdate=${dateNow}&siteId=${zeprs_session.clientSettings.siteId}&report=2">Daily Activity Report</html:link></li>
                <li><a href='<c:out value="/${appName}/${stock_control}"/>'>Stock Control</a></li>
                <li><html:link  action="/reports.do">Reports</html:link></li>
                </logic:present>
                <li><html:link  action="/help.do">Help</html:link></li>
                <logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
                <li style="margin: 0px 0px 0px 5px;">&nbsp;</li>
                <li><html:link action="/admin/home.do">Admin</html:link></li>
                </logic:present>
                <li><html:link  action="/logout.do">Logout</html:link></li>

            </ul><!-- navlist -->
        </div> <!-- sidenavcontainer -->
    </div><!-- sidebar-a -->
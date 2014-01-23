<%@ page import="org.rti.zcore.utils.DateUtils"%>

<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="en_GB" scope="session"/>
<%
java.sql.Date dateNow = DateUtils.getNow();
pageContext.setAttribute("dateNow", dateNow);
%>
<%--<bean:include id="versionInfo" page="/versionInfo.do"/>--%>
<html>
    <head>
        <title>${fullName} - Site: ${siteName} - <template:get name='title'/> <jsp:include page="../../pages/version.html"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <script type="text/javascript" src="/${appName}/js/browser_detect.js;jsessionid=${pageContext.request.session.id}"></script>
        <script language="JavaScript" TYPE="text/javascript" src="/${appName}/js/validation.js;jsessionid=${pageContext.request.session.id}"></script>
        <script type="text/javascript" src="/${appName}/js/zeprs.js;jsessionid=${pageContext.request.session.id}"></script>
	    <script type="text/javascript" src="/${appName}/js/util.js;jsessionid=${pageContext.request.session.id}"></script>
        <script type="text/javascript" src="/${appName}/config/javascript.js;jsessionid=${pageContext.request.session.id}"></script>
        <script type="text/javascript" src="/${appName}/js/dwr-admin.js;jsessionid=${pageContext.request.session.id}"></script>
        <script type='text/javascript' src='/${appName}/dwr/util.js;jsessionid=${pageContext.request.session.id}'></script>
        <script type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
        <script type="text/javascript" src="/${appName}/js/fat.js;jsessionid=${pageContext.request.session.id}"></script>
        <script type="text/javascript" src="/${appName}/js/scriptaculous/prototype.js;jsessionid=${pageContext.request.session.id}"></script>
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

    <body onload="startClock();DWRUtil.useLoadingMessage();">
	<div id="pagewidth" >
    <div id="banner-home">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="middle" background="/${appName}/images/banner_bkgd.gif" height="46" width="100" ><span class="serviceHeader"><a href="/${appName}/home.do;jsessionid=${pageContext.request.session.id}" border="0">${appTitle}</a></span></td>
            <td background="/${appName}/images/banner_bkgd.gif" align="right">&nbsp;</td>
        </tr>
    </table>
    </div>
    <div id="loginStatus-print">
        <table cellpadding="0" cellspacing="0" bgColor = "white" summary="Patient Status Bar" width="100%">
        <thead>
            <tr class="patientrowheader">
                <th>Staff</th>
                <th>Date/Time</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="patientrow">${fullName}</td>
                <td class="patientrow"><fmt:formatDate type="both" pattern="dd/MM/yy" value="${now}" />&nbsp;<input type="text" id="pcTime" size="7" class="clock" onfocus="this.blur()"/></td>
            </tr>
        </tbody>
        </table>
    </div>
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
                <li style="margin: 0px 0px 0px 5px;">&nbsp;</li>
                <logic:present role="VIEW_SELECTED_REPORTS_AND_VIEW_STATISTICAL_SUMMARIES">
                <li><html:link action="/reports">Reports</html:link></li>
                </logic:present>
                <c:url value="admin/records/list.do" var="stock_control"><c:param name="formId" value="161"/></c:url>
				<c:url value="admin/records/list.do" var="regime_groups"><c:param name="formId" value="128"/></c:url>
				<c:url value="admin/records/list.do" var="regimen"><c:param name="formId" value="129"/></c:url>
				<c:url value="admin/records/list.do" var="stock_groups"><c:param name="formId" value="130"/></c:url>
				<c:url value="admin/records/list.do" var="stock"><c:param name="formId" value="131"/></c:url>
				<logic:present role="CREATE_VIEW_MODIFY_INDIVIDUAL_PATIENT_RECORDS">
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
</div><!-- pagewidth -->
    </body>
</html>
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
 // previous day
    java.util.Calendar c4 = java.util.Calendar.getInstance();
    c4.add(java.util.Calendar.DATE, -1);
    Date date1daypast = c4.getTime();
    java.text.SimpleDateFormat sdf4 = new java.text.SimpleDateFormat(DATE_FORMAT);
    sdf4.setTimeZone(TimeZone.getDefault());
    String date1daypastStr = sdf4.format(date1daypast);
    java.sql.Date date1daypastSql =  java.sql.Date.valueOf(date1daypastStr);
    pageContext.setAttribute("date1daypastSql", date1daypastSql);
%>

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

<h2><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></h2>
    <p>
    <html:link action="/admin/home"><bean:message bundle="ApplicationResources" key="admin.formlist.admin"/></html:link> :
    <html:link action="/admin/publisher/new"><bean:message bundle="ApplicationResources" key="admin.index.publish"/></html:link> :
    <html:link action="/admin/subscription/new"><bean:message bundle="ApplicationResources" key="admin.index.subscriptions"/></html:link> :
    <html:link action="/admin/server/new"><bean:message bundle="ApplicationResources" key="admin.index.master.site.server"/></html:link> :
    <bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/>
    </p>

		<p><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.desc" />&nbsp; <bean:message
			bundle="ApplicationResources" key="admin.index.sync.verify.info" /></p>
		<p><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.instructions" /></p>

		<html:form action="/admin/sync/list">
    <input type="hidden" name="task" value="run"/>
	<table cellspacing="0" cellpadding="5" class="enhancedtabletighterCell">
	<tr>
        <th><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.site" /></th>
        <th><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.beginDate" /></th>
        <th><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.endDate" /></th>
        <th><bean:message bundle="ApplicationResources" key="admin.index.sync.verify.errorsOnly" /></th>
        <th>&nbsp;</th>
    </tr>
	<tr>
		<td>
            <select id="siteSelector" name="siteAbbrev">
                <option value=""> -- </option>
                <c:choose>
                    <c:when test="${theSite=='all'}">
                            <option value="0" selected="selected" >All sites</option>
                        <c:forEach var="site" begin="0" items="${sites}">
                            <c:if test="${site.inactive != 1}">
                            <option value="${site.abbreviation}">${site.name}</option>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <option value="0">All sites</option>
                        <c:forEach var="site" begin="0" items="${sites}">
                            <c:if test="${site.inactive != 1}">
                            <c:choose>
                            <c:when test="${theSite==site.id}">
                            <option value="${site.abbreviation}" selected="selected">${site.name}</option>
                            </c:when>
                            <c:otherwise>
                            <option value="${site.abbreviation}">${site.name}</option>
                            </c:otherwise>
                            </c:choose>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>

        </td>

        <td>
            <zeprs:date_visit_no_form_no_label element = "lazyForm" dateVisit = "${date1weekpastSql}" field = "bdate|bdate1"/>
        </td>

		<td>
            <zeprs:date_visit_no_form_no_label element = "lazyForm" dateVisit = "${dateNow}" field = "edate|edate1"/>
        </td>

        <td><input type="radio" name="errors" value="1" />Yes <input type="radio" name="errors" value="0" />No</td>

        <td>
			<center><html:submit/></center>
		</td>
	</tr>
	</table>
    </html:form>
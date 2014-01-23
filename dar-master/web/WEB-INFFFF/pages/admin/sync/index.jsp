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
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-config-print.jsp'>
<template:put name='title' direct='true'><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></template:put>
<template:put name='content' direct='true'>
<h2><bean:message bundle="ApplicationResources" key="admin.index.sync.verify"/></h2>

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
<c:import url="verify_form.jsp"></c:import>
</div>
</template:put>
</template:insert>
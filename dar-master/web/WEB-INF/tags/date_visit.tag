<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ attribute name="dateVisit" required="false" type="java.sql.Date" %>
<c:set var="field" value="${pageItem.form_field}" />
<jsp:useBean id="now" class="java.util.Date" />
<c:choose>
    <c:when test="${! empty dateVisit}">
        <fmt:formatDate type="both" pattern="yyyy" value="${dateVisit}" var="yearnow" />
        <fmt:formatDate type="both" pattern="MM" value="${dateVisit}" var="monthnow" />
        <fmt:formatDate type="both" pattern="dd" value="${dateVisit}" var="datenow" />
        <c:set var="theDate" value="${dateVisit}"/>
    </c:when>
    <c:otherwise>
        <fmt:formatDate type="both" pattern="yyyy" value="${now}" var="yearnow" />
        <fmt:formatDate type="both" pattern="MM" value="${now}" var="monthnow" />
        <fmt:formatDate type="both" pattern="dd" value="${now}" var="datenow" />
        <c:set var="theDate" value="${now}"/>
    </c:otherwise>
</c:choose>
<fmt:formatDate type="both" pattern="dd MMM yy" value="${theDate}" var="nicedateVisit" />
<fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${theDate}" var="dbdateVisit" />
<c:set var="lastTwoYears" value="${yearnow - 2}"/>
<c:set var="lastYear" value="${yearnow - 1}"/>
<c:set var="twoYears" value="${yearnow + 2}"/>
<c:set var="sixtyYears" value="${yearnow - 60}"/>
<strong><bean:message bundle="ApplicationResources" key="form.dateOfVisit"/>:</strong> <span class="asterix">*</span>
    <a href="javascript://" onclick="showCalendar('${yearnow}','${monthnow}','${datenow}','dd MMM yy','${encounterForm.classname}','date_visit',event,${lastTwoYears},${twoYears});">
    <img alt="Select Date" border="0" src="/${appName}/images/calendar.gif" align="middle">&nbsp;&nbsp;</a><span id="spandate_visit" class="dateDisplay">${nicedateVisit}</span>
    <div id="slcalcoddate_visit" style="position:absolute; left:100px; top:100px; z-index:10; visibility:hidden;">
    <script type="text/javascript">printCalendar("Sun","Mon","Tue","Wed","Thu","Fri","Sat","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","${datenow}","${monthnow}","${yearnow}","date_visit");</script></div>
    <img alt="spacer" src="/${appName}/images/clearpixel.gif">
    <html:hidden styleId="date_visit"  styleClass="disabled-date" onfocus="this.blur()" property="date_visit" value="${yearnow}-${monthnow}-${datenow}"/>

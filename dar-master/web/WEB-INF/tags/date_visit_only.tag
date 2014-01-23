<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt" %>
<%@ attribute name="pageItem" required="false" type="org.rti.zcore.PageItem" %>
<%@ attribute name="pos" required="false" type="java.lang.Integer" %>
<c:set var="scriptName" value="replydate_visit"/>
<jsp:useBean id="now" class="java.util.Date" />
<c:choose>
    <c:when test="${! empty value}">
       <fmt:formatDate type="both" pattern="yyyy" value="${value}" var="yearnow" />
        <fmt:formatDate type="both" pattern="MM" value="${value}" var="monthnow" />
        <fmt:formatDate type="both" pattern="dd" value="${value}" var="datenow" />
        <c:set var="theDate" value="${value}"/>
    </c:when>
    <c:otherwise>
        <fmt:formatDate type="both" pattern="yyyy" value="${now}" var="yearnow" />
        <fmt:formatDate type="both" pattern="MM" value="${now}" var="monthnow" />
        <fmt:formatDate type="both" pattern="dd" value="${now}" var="datenow" />
        <c:set var="theDate" value="${now}"/>
    </c:otherwise>
</c:choose>
<fmt:formatDate type="both" pattern="dd MMM yy" value="${theDate}" var="niceDate" />
<fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${theDate}" var="dbDate" />
<c:set var="lastTwoYears" value="${yearnow - 2}"/>
<c:set var="lastYear" value="${yearnow - 1}"/>
<c:set var="twoYears" value="${yearnow + 2}"/>
<c:set var="sixtyYears" value="${yearnow - 60}"/>
<span id="spandate_visit" onclick="showCalendar('${yearnow}','${monthnow}','${datenow}','dd MMM yy','${encounterForm.classname}','date_visit',event,${lastTwoYears},${twoYears});" class="underline">${niceDate}</span>
<div id="slcalcoddate_visit" style="position:absolute; left:100px; top:100px; z-index:10; visibility:hidden;">
<script type="text/javascript">printCalendar("Sun","Mon","Tue","Wed","Thu","Fri","Sat","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","${datenow}","${monthnow}","${yearnow}","date_visit");</script></div>
<span id="correctDateVisit${pos}" style="display:none;">
    <input type="text" id="date_visit" class="disabled-date"  onfocus="this.blur()" name="date_visit" value="${dbDate}" />
</span>
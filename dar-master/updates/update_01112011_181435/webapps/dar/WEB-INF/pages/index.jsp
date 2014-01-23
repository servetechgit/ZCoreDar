<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="en"/>
<c:choose>
<c:when test="${empty site}">
<c:set var="theSite" value="${patientSiteId}"/>
<c:set var="site" value="${site}"/>
</c:when>
<c:otherwise>
<c:set var="theSite" value="${site}"/>
</c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${! empty param.rowCount}">
        <c:set var="rowCount" value="${param.rowCount}"/>
    </c:when>
    <c:otherwise>
        <c:set var="rowCount" value="11"/>
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${! empty offset}">
        <c:set var="offset" value="${offset}"/>
    </c:when>
    <c:when test="${! empty param.offset}">
        <c:set var="offset" value="${param.offset}"/>
    </c:when>
    <c:otherwise>
        <c:set var="offset" value="0"/>
    </c:otherwise>
</c:choose>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-home-print.jsp'>
<template:put name="title" content="Home" direct="true"/>
<template:put name='content' direct='true'>
<div id="maincol">
    <div id="search-results">
        <form name="searchForm" action="${pageContext.request.contextPath}/home.do;jsessionid=${pageContext.request.session.id}" method="post">
            <input type="hidden" id="first_surname" name="first_surname">
            <input type="hidden" id="max_rows" name="max_rows">
            <input type="hidden" id="start_row" name="start_row">
            <table>
                <tr>
                    <td><h1>Search for Client</h1></td>
                    <td>
                        <table class="enhancedtable">
                            <tr>
                                <td>
                                    <input type="text" id="search_string" name="search_string">
                                </td>
                <logic:present role="ALTER_PROGRAMS_AND_SCREEN_APPEARANCE">
                                <td>
                                    <select name="site">
                                        <c:choose>
                                            <c:when test="${theSite=='all'}">
                                                    <option value="all" selected="selected" >All sites</option>
                                                <c:forEach var="site" begin="0" items="${sites}">
                                                    <c:if test="${site.inactive != 1}"><option value="${site.id}">${site.name}</option></c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="all">All sites</option>
                                                <c:forEach var="site" begin="0" items="${sites}">
                                                    <c:if test="${site.inactive != 1}"><c:choose>
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
                                <td>
                                    <input type="submit" value="Search">
                                </td>
                                <td>Search keywords: family name, first names, Client ID</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    <c:choose>
        <c:when test="${!empty results}">
            <%
            //  Set up alternating row colors
            java.lang.String classRow = "evenRow";
            %>
            <c:choose>
            <c:when test="${empty searchString}">
            <c:set var="search" value="All Clients"/>
            </c:when>
            <c:otherwise>
            <c:set var="search" value="${searchString}"/>
            </c:otherwise>
            </c:choose>
           	<c:url var="nextUrl" value="home.do">
				<c:param name="search_string" value="${searchString}"/>
				<c:param name="offset" value="${offset}"/>
			</c:url>
			<c:url var="prevURL" value="home.do">
				<c:param name="searchString" value="${searchString}"/>
				<c:param name="prevRows" value="${prevRows}"/>
			</c:url>
    		<div id="search-results-body">
				 <table cellpadding="2" cellspacing="2" bgColor="white" width="100%">
					<tr>
						<td colspan="4">Search term: <i>${search}</i>,
						<c:choose>
							<c:when test="${empty searchString}">sorted by date record last modified.</c:when>
							<c:otherwise>sorted by surname.</c:otherwise>
						</c:choose>
						</td>
						<td  colspan = "3" align="right">
						<c:if test="${empty noNavigationWidget}"><c:if test="${! empty prevRows}">
						<a href='<c:out value="/${appName}/${prevURL}"/>'">&lt;&lt;</a></c:if>
							<c:if test="${empty prevRows}">&lt;&lt;</c:if>
							<bean:message key="search.navigation" bundle="TemplateResources" />
							<c:if test="${! empty offset}"><a href='<c:out value="/${appName}/${nextUrl}"/>'">&gt;&gt;</a></c:if>
							<c:if test="${empty offset}">&gt;&gt;</c:if>
			        	</c:if>
			        	</td>
					</tr>
            <!-- <div id="search-results-list"> -->
	            <c:choose>
		            <c:when test="${fn:length(results) < 1}">
		            <tr><td colspan = "7">Client cannot be found with this search term; please try again.</td></tr>
		            </c:when>
	            <c:otherwise>
                    <tr class="rowheader">
                        <th>Client</th>
                        <th>Age</th>
                        <th>Client ID</th>
                        <th>Address</th>
                        <th>Health Worker</th>
                        <th>Site</th>
                        <th>Last Modified</th>
                    </tr>
                    <c:forEach var="row" items="${results}" varStatus="i">
                        <%
                            //  Set up alternating row colors
                            classRow = classRow.equals("evenRow") ? "oddRow" : "evenRow";
                        %>
                        <tr class="<%= classRow %>">
                            <td><html:link action="/patientHome" paramId="patientId" paramName="row"
                                           paramProperty="id">${row.surname}, ${row.firstName}</html:link></td>
                            <td><c:choose>
                            <c:when test="${! empty row.age}">${row.age}</c:when>
                            <c:when test="${(empty row.age) && (!empty row.ageAtFirstVisit)}">${row.ageAtFirstVisit}</c:when>
                            <c:when test="${(empty row.age) && (empty row.ageAtFirstVisit) && (!empty row.sequenceNumber)}">
                            <c:choose>
                            <c:when test="${row.sequenceNumber == 3283}">Adult</c:when>
                            <c:when test="${row.sequenceNumber == 3284}">Child</c:when>
                            </c:choose>
                            </c:when>
                            </c:choose></td>
                            <td><bean:write name="row" property="districtPatientid"/></td>
                            <td><bean:write name="row" property="address"/></td>
                            <td>${row.lastModifiedBy}</td>
                            <td>${row.siteName}</td>
                            <fmt:formatDate value="${row.lastModified}" pattern="dd MMM yy" var="last_modified"/>
                            <td><c:out value="${last_modified}"/></td>
                        </tr>
                    </c:forEach>
	            </c:otherwise>
	            </c:choose>
            </table>
            <!-- </div> -->
            </div>

		<!--
        <div id="search-results-list-pager">
        <table cellpadding="2" cellspacing="4" bgColor="white" width="100%">
                <tr>
                <td>Displays only the first 200 records. Refine your search if necessary.</td>
            </tr>
        </table>
        </div>
         -->
        </c:when>
        <c:otherwise>
		<div id="search-results-body">
        <p>No patients were found in the system based on your query. Please choose one of the following:
            <ul>
                <li><html:link action="search">Perform another search for a patient</html:link></li>
                <li><html:link action="PatientRegistration/new.do">Create New Patient</html:link></li>
                </ul>
            </p>
		</div>
        </c:otherwise>
    </c:choose>

    </div>
</div>
<c:import url="problems/problems_chart.jsp" />
</template:put>
</template:insert>
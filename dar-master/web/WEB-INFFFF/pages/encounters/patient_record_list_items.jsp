<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="pos" value="0"/>
<c:set var="tblItem" value="0"/>
<c:set var="tblCols" value="0"/>
<c:set var="tdBackgroundColor" value="#fff"/>
<c:set var="collapsing" value="0"/>
<c:set var="tdClass" value="enhancedtabletighterCell"/>
<c:set var="dataEntry" value="1"/>
<c:if test="${! empty arvChartItems}">
    <c:set var="chartItems" value="arvChartItems"/>
    <c:set var="encounterForm" value="arvEncounterForm"/>
</c:if>

<script language="JavaScript" type="text/javascript" src="/${appName}/dwr/util.js;jsessionid=${pageContext.request.session.id}"></script>
<script language="JavaScript" type="text/javascript" src="/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}"></script>
<script type='text/javascript' src='/${appName}/dwr/interface/WidgetDisplay.js;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwr/interface/Encounter.js;jsessionid=${pageContext.request.session.id}'></script>
<script type="text/javascript" src="/${appName}/js/dwr-generic.js;jsessionid=${pageContext.request.session.id}"></script>
<script type="text/javascript" src="/${appName}/js/dwr-display.js;jsessionid=${pageContext.request.session.id}"></script>
<c:choose>
    <c:when test="${(zeprs_session.sessionPatient.currentFlowId ==9) || (zeprs_session.sessionPatient.currentFlowId ==1) || (zeprs_session.sessionPatient.currentFlowId ==2)
                        || (zeprs_session.sessionPatient.currentFlowId ==7)}">
        <c:set var="dataEntry" value="1"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${(encounterForm.flowId == 1) || (encounterForm.flowId == 2) || (encounterForm.flowId == 7)}">
                <c:set var="dataEntry" value="0"/>
                <c:if test="${encounterForm.id == 55}"><c:set var="dataEntry" value="1"/></c:if>
            </c:when>
            <c:otherwise>
                <c:set var="dataEntry" value="1"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
    <script type='text/javascript'>
        var chartDates = new Array();

        function confirmChartDate(field, formName)
        {
            var input = document.getElementsByName(field).item(0);
            var date = fixDate(input.value, "-");
            //alert("date: " + date);
            var match = 0;
            for (var i = 0; i < chartDates.length; i++)
            {
                var theDate = chartDates[i];
                if (date == theDate) {
                    match = 1;
                }
            }
            if (match == 1) {
                alert("You are trying to enter duplicate information. Please change the date in the form or edit information directly on the record table below.");
                return false;
            } else {
                if (formId != null) {
                    var form = document.getElementById(formName);
                    return validateForm${encounterForm.id}(form);
                } else {
                    return validateForm${encounterForm.id}(this);
                }

            }
        }

    </script>
<table class="enhancedtable">
   <tr>
<%-- loop through the pageItems and build the chart--%>
<c:set var="numRows" value="0"/>
<th id="dateRequestedHeader" valign="middle" class="enhancedtabletighterCell" width="60"><strong>Date of Visit</strong></th>
<c:forEach var="pageItem" begin="0" items="${encounterForm.pageItems}" varStatus="lineInfo">
    <c:set var="field" value="${pageItem.form_field}" />
    <c:set var="currentField" value="${field.id}" scope="request"/>
    <c:if test='${pageItem.form_field.enabled ==true && pageItem.form_field.type != "Display"}'>
    	<c:if test='${pageItem.inputType != "hidden-no-listing"}'>
	        <c:choose>
	        <c:when test='${pageItem.inputType=="yesno_dwr"}'>
	        <c:set var="revealType" value="Span"/>
	        </c:when>
	        <c:otherwise>
	        <c:set var="revealType" value="Field"/>
	        </c:otherwise>
	        </c:choose>
            <c:if test="${(pageItem.inputType != 'multiselect_enum')}">
                <th id="${field.identifier}Cell${pos}" valign="middle" class="enhancedtabletighterCell"><strong>${field.label}</strong></th>
            </c:if>
        </c:if>
    </c:if>
</c:forEach>
<c:choose>
<c:when test="${encounterForm.id == 179}">
        <th class="enhancedtabletighterCell"><strong>Del.</strong></th>
</c:when>
<c:otherwise>
    <logic:present role="DELETE_ARCHIVE_PATIENT_RECORDS">
        <th class="enhancedtabletighterCell"><strong>Del.</strong></th>
    </logic:present>
</c:otherwise>
</c:choose>

</tr>
    <c:forEach items="${chartItems}" var="encounter" varStatus="item">
        <tr>
            <c:choose>
                <c:when test="${! empty encounter}">
                <c:set var="pos" value="${encounter.id}"/>
                </c:when>
                <c:otherwise>
                <c:set var="pos" value="0"/>
                </c:otherwise>
            </c:choose>
            <c:set var="numRows" value="${item.index+1}"/>
            <c:set var="currentEncounterId" value="${encounter.id}" scope="request"/>
            <c:forEach var="pageItem" begin="0" items="${encounterForm.pageItems}" varStatus="lineInfo">
            <c:if test="${(param.highlight == pos) || (param.extendedTestId == pos)}">
                <c:set var="tdClass" value="problemCell"/>
            </c:if>
            <c:if test="${lineInfo.index == 1}">
            	<td id="cellDateRequested" valign="middle" class="${tdClass}">
					<logic:notEmpty name="encounter" property="dateVisit">
						<bean:define id="thisValue" name="encounter" property="dateVisit" />
						<zeprs:date_visit_dwr pageItem="${pageItem}" pos="${pos}" remoteClass="${remoteClass}" classname="${classname}" propertyName="${pageItem.form_field.starSchemaName}" patientId="${zeprs_session.sessionPatient.id}" eventId="${zeprs_session.sessionPatient.currentEventId}" user = "${user}" siteId="${siteId}" value="${thisValue}"/>
					</logic:notEmpty>
					<logic:empty name="encounter" property="dateVisit">
						<zeprs:date_visit_dwr pageItem="${pageItem}" pos="${pos}" remoteClass="${remoteClass}" classname="${classname}" propertyName="${pageItem.form_field.starSchemaName}" patientId="${zeprs_session.sessionPatient.id}" eventId="${zeprs_session.sessionPatient.currentEventId}" user = "${user}" siteId="${siteId}"/>
					</logic:empty>
					</td>
            </c:if>
            <c:if test='${pageItem.form_field.enabled ==true && pageItem.form_field.type != "Display" && pageItem.inputType != "multiselect_enum" && pageItem.inputType != "hidden-no-listing"}'>
                <c:set var="field" value="${pageItem.form_field}"/>
                <c:set var="currentField" value="${field.id}" scope="request"/>
                <td id="cell${currentEncounterId}.${field.id}" valign="middle" class="${tdClass}" ondblclick="callChartWidget('${pageItem.id}', '${field.id}', '${pageItem.formId}', '${currentEncounterId}', '${pageItem.inputType}')">
                    <logic:notEmpty name="encounter" property="encounterMap.${field.identifier}">
                        <bean:define id="thisValue" name="encounter" property="encounterMap.${field.identifier}"/>
						<c:set var="displayValue" value="${thisValue}"/>
					<c:choose>
	                    <c:when test="${(pageItem.inputType =='emptyDate') || (pageItem.inputType =='birthdate') || (pageItem.inputType =='dateToday') || (pageItem.inputType =='dateOneMonthFuture')}">
                        <c:set var="displayValue" value="${thisValue}"/>
						</c:when>
					</c:choose>
                    <c:choose>
                        <c:when test="${! empty displayValue}">
                        	<c:choose>
		                        <c:when test="${field.id == 2366 && !empty encounter.patientId && encounter.patientId != 0}">
		                        <span id="value${currentEncounterId}.${field.id}">
		                        <html:link action="/patientHome" paramId="patientId" paramName="encounter" paramProperty="patientId">${displayValue}</html:link>
		                        </span>
		                        <span id="widget${currentEncounterId}.${field.id}"></span>
		                        </c:when>
		                        <c:otherwise>
		                        <span id="value${currentEncounterId}.${field.id}">${displayValue}</span>
		                        <span id="widget${currentEncounterId}.${field.id}"></span>
		                        </c:otherwise>
	                        </c:choose>
                        </c:when>
                        <c:otherwise>
                        <span id="value${currentEncounterId}.${field.id}"></span>
                        <span id="widget${currentEncounterId}.${field.id}"></span>
                        </c:otherwise>
                    </c:choose>
                    </logic:notEmpty>
                    <logic:empty name="encounter" property="encounterMap.${field.identifier}">
                       <span id="value${currentEncounterId}.${field.id}"></span>
                       <span id="widget${currentEncounterId}.${field.id}"></span>
                    </logic:empty>
                    <c:if test="${(pageItem.inputType =='emptyDate') || (pageItem.inputType =='birthdate') || (pageItem.inputType =='dateToday') || (pageItem.inputType =='dateOneMonthFuture')}">
                        <c:set var="dateValue" value="${now}"/>
                        <c:set var="theDate" value="${now}"/>
                        <c:if test="${! empty renderedValue}">
	                        <c:if test="${! empty dateFormatShort}">
	 						<fmt:parseDate pattern="${dateFormatShort}" value="${renderedValue}" var="dateValue"/>
	 						<c:set var="theDate" value="${dateValue}"/>
	                        </c:if>
                        </c:if>
                        <fmt:formatDate type="both" pattern="yyyy" value="${dateValue}" var="yearnow" />
                        <fmt:formatDate type="both" pattern="MM" value="${dateValue}" var="monthnow" />
                        <fmt:formatDate type="both" pattern="dd" value="${dateValue}" var="datenow" />
                        <div id="slcalcodfield${currentEncounterId}.${field.id}" style="position:absolute; left:100px; top:100px; z-index:10; visibility:hidden;">
                            <script type="text/javascript">printCalendar("Sun","Mon","Tue","Wed","Thu","Fri","Sat","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","${datenow}","${monthnow}","${yearnow}","field${currentEncounterId}.${field.id}");</script>
                        </div>
                        <c:if test="${pageItem.inputType =='dateToday'}">
                            <script type='text/javascript'>
                                chartDates[chartDates.length] = '${thisValue}';
                            </script>
                        </c:if>
                    </c:if>
                    </td>
            </c:if>
             <c:set var="tdClass" value="enhancedtabletighterCell"/>
            </c:forEach>
            <c:choose>
			<c:when test="${encounterForm.id == 179}">
			        <c:url var="delUrl" value="admin/deleteEncounter.do">
	                    <c:param name="encounterId" value="${encounter.id}"/>
	                    <c:param name="formId" value="${encounterForm.id}"/>
	                </c:url>
	                <td valign="middle" class="${tdClass}"><a href='<c:out value="/${appName}/${delUrl}"/>' onclick="return confirm('Caution: Are you sure you want to delete this record?');self.close();">X</a></td>
			</c:when>
			<c:otherwise>
	            <logic:present role="DELETE_ARCHIVE_PATIENT_RECORDS">
	            <c:url var="delUrl" value="admin/deleteEncounter.do">
	                    <c:param name="encounterId" value="${encounter.id}"/>
	                    <c:param name="formId" value="${encounterForm.id}"/>
	                </c:url>
	                <td valign="middle" class="${tdClass}"><a href='<c:out value="/${appName}/${delUrl}"/>' onclick="return confirm('Caution: Are you sure you want to delete this record?');self.close();">X</a></td>
	            </logic:present>
			</c:otherwise>
			</c:choose>
        </tr>
        </c:forEach>
</table>
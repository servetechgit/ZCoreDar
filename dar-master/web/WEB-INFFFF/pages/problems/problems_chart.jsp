<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="fn" uri='/WEB-INF/fn.tld' %>

<c:choose>
<c:when test="${empty param.patientId}">
<logic:present name="zeprs_session" property="sessionPatient">
<c:set var="patientId" value="${zeprs_session.sessionPatient.id}"/>
</logic:present>
<logic:notPresent name="zeprs_session" property="sessionPatient">
<c:set var="patientId" value="0"/>
</logic:notPresent>
</c:when>
<c:otherwise>
<c:set var="patientId" value="${param.patientId}"/>
</c:otherwise>
</c:choose>
<c:url value="problem.do"  var="probUrl">
    <c:param name="patientId" value="${patientId}"/>
    <c:param name="problemType" value="problem"/>
    <c:param name="mode" value="create"/>
</c:url>
<div id="rightFloatCol">
<!-- <div id="probList">
   <div id="probListItemsSide"> -->
    <logic:empty name="activeProblems">
    <table class="enhancedtable" width="100%">
    <tr><td colspan="2"><span style="color:red">No active problems</span></td></tr></logic:empty>
    <logic:notEmpty name="activeProblems">
    <table class="enhancedtable" width="260px">
    <tr style="background:#90bade;border:1px solid #000; vertical-align : middle; text-align:center">
        <td style="background:#90bade;border:1px solid #000; vertical-align : middle; text-align:center" colspan="2">
			<h2 style="background:#90bade;vertical-align : middle; ">Stock Alerts</h2>
		</td>
    </tr>
    <tr>
        <td class="enhancedtableheader">Stock</td>
        <td class="enhancedtableheader" width="50px">Expiry</td>
    </tr>
<logic:iterate id="thisproblem" name="activeProblems">
<c:url value="problem.do"  var="myUrl">
    <c:choose>
        <c:when test="${thisproblem.class.name=='org.rti.zcore.Problem'}">
        <c:param name="problemId" value="${thisproblem.id}"/>
        <c:param name="patientId" value="${thisproblem.patientId}"/>
        <c:param name="problemType" value="problem"/>
        </c:when>
        <c:otherwise>
        <c:param name="problemId" value="${thisproblem.id}"/>
        <c:param name="patientId" value="${thisproblem.patientId}"/>
        <c:param name="problemType" value="outcome"/>
        </c:otherwise>
    </c:choose>
    <c:param name="mode" value="create"/>
    <c:if test="${status=='false'}">
     <c:param name="status" value="false"/>
    </c:if>
</c:url>
<c:url value="problem.do"  var="editUrl">
    <c:choose>
        <c:when test="${thisproblem.class.name=='org.rti.zcore.Problem'}">
        <c:param name="problemId" value="${thisproblem.id}"/>
        <c:param name="patientId" value="${thisproblem.patientId}"/>
        <c:param name="problemType" value="problem"/>
        </c:when>
        <c:otherwise>
        <c:param name="problemId" value="${thisproblem.id}"/>
        <c:param name="patientId" value="${thisproblem.patientId}"/>
        <c:param name="problemType" value="outcome"/>
        </c:otherwise>
    </c:choose>
    <c:param name="mode" value="edit"/>
    <c:if test="${status=='false'}">
     <c:param name="status" value="false"/>
    </c:if>
</c:url>
    <c:choose>
        <c:when test="${thisproblem.class.name=='org.rti.zcore.Problem'}">
            <c:choose>
            <c:when test="${problemId==thisproblem.id && outcome!=1}">
                <c:set var="currproblemName" value="${thisproblem.problemName}" scope="request"/>
                <c:forTokens items="${thisproblem.onsetDate}" delims="-" var="onset" varStatus="i">
                    <c:choose>
                        <c:when test="${i.index==0}">
                        <c:set var="onsetYear" value="${onset}" scope="request"/>
                        </c:when>
                        <c:when test="${i.index==1}">
                        <c:set var="onsetMonth" value="${onset}" scope="request"/>
                        </c:when>
                        <c:when test="${i.index==2}">
                        <c:set var="onsetDate" value="${onset}" scope="request"/>
                        </c:when>
                    </c:choose>
                </c:forTokens>
                <c:set var="curronsetDate" value="${thisproblem.onsetDate}" scope="request"/>
                <c:set var="curractive" value="${thisproblem.active}" scope="request"/>
                <tr class="currentProblem">
                    <td><a href='<c:out value="/${appName}/${editUrl}"/>'>${thisproblem.problemName}</a></td>
                    <td><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}"/></td>
                </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <td><a href='<c:out value="/${appName}/${editUrl}"/>'>${thisproblem.problemName}</a></td>
                    <td width="50px" ><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}"/></td>
                </tr>
            </c:otherwise>
         </c:choose>
    	</c:when>
        <c:when test="${thisproblem.class.name=='org.cidrz.webapp.dynasite.rules.impl.EncounterOutcome'}">
            <c:set var="currproblemName" value="${thisproblem.message}" scope="request"/>
            <c:choose>
                <c:when test="${problemId==thisproblem.id && outcome==1}">

                <c:set var="curractive" value="${thisproblem.active}" scope="request"/>
                <c:set var="currform" value="${thisproblem.formId}" scope="request"/>
                <c:set var="currencounterId" value="${thisproblem.encounterId}" scope="request"/>
                <c:set var="currclass" value="${thisproblem.class.name}" scope="request"/>
                <tr class="currentProblem">
                    <td><html:link action="form${thisproblem.requiredFormId}/new.do" paramId="patientId" paramName="thisproblem" paramProperty="patientId">Required Form: ${currproblemName}</html:link></td>
                    <td width="50px" ><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}" /></td>
                </tr>
                </c:when>
                <c:otherwise>
                <tr>
                    <td><html:link action="form${thisproblem.requiredFormId}/new.do" paramId="patientId" paramName="thisproblem" paramProperty="patientId">Required Form: ${currproblemName}</html:link></td>
                    <td width="50px" ><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}" /></td>
                </tr>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:when test="${thisproblem.class.name=='org.cidrz.webapp.dynasite.rules.impl.ReferralOutcome'}">
            <c:choose>
                <c:when test="${problemId==thisproblem.id && outcome==1}">
                <c:set var="currproblemName" value="${thisproblem.reason}" scope="request"/>
                <c:set var="curractive" value="${thisproblem.active}" scope="request"/>
                <c:set var="currencounterId" value="${thisproblem.encounterId}" scope="request"/>
                <c:set var="currclass" value="${thisproblem.class.name}" scope="request"/>
                <tr class="currentProblem">
                    <td><a href='<c:out value="/${appName}/${editUrl}"/>'>${thisproblem.reason}</a> <a href='<c:out value="/${appName}/${editUrl}"/>'>(e)</a></td>
                    <td width="50px"><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}" /></td>
                </tr>
                </c:when>
                <c:otherwise>
                <tr>
                    <td><a href='<c:out value="/${appName}/${editUrl}"/>'>${thisproblem.reason}</a></td>
                    <td width="50px"><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}" /></td>
                </tr>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:when test="${thisproblem.class.name=='org.cidrz.webapp.dynasite.rules.impl.InfoOutcome'}">
            <c:choose>
                <c:when test="${problemId==thisproblem.id && outcome==1}">
                    <c:set var="currproblemName" value="${thisproblem.message}" scope="request"/>
                    <c:set var="curractive" value="${thisproblem.active}" scope="request"/>
                    <c:set var="currencounterId" value="${thisproblem.encounterId}" scope="request"/>
                    <c:set var="currclass" value="${thisproblem.class.name}" scope="request"/>
                    <tr class="currentProblem">
                        <td><a href='<c:out value="/${appName}/${editUrl}"/>'>${special}${thisproblem.message}</a></td>
                    <td width="50px"><fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}" /></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td><a href='<c:out value="/${appName}/${editUrl}"/>'>${special}${thisproblem.message}</a></td>
                        <td width="50px"><html:link action="/viewEncounter" paramId="id" paramName="thisproblem" paramProperty="encounterId">
                                    <fmt:formatDate type="both" pattern="dd MMM yy" value="${thisproblem.lastModified}"/></html:link></td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:when test="${thisproblem.class.name=='org.rti.zcore.Task'}">
        <tr>
        <c:if test="${! empty formNames}">
            <logic:notEmpty name="formNames" property="form${thisproblem.formId}">
            <bean:define id="thisFormName" name="formNames" property="form${thisproblem.formId}"/>
            </logic:notEmpty>
            <logic:empty name="formNames" property="form${thisproblem.formId}">
            <bean:define id="thisFormName" value=""/>
            </logic:empty>
        </c:if>
            <c:choose>
                <c:when test="${! empty thisproblem.messageType}">
					<c:choose>
						<c:when test="${thisproblem.messageType == 'expired'}">
							<td>${thisproblem.label}</td>
							<td><fmt:formatDate value="${thisproblem.dateVisit}" pattern="dd MMM yy"/></td>
						</c:when>
						<c:when test="${thisproblem.messageType == 'lowStock'}">
							<td>${thisproblem.label}</td>
							<td><fmt:formatDate value="${thisproblem.dateVisit}" pattern="dd MMM yy"/></td>
						</c:when>
						<c:when test="${thisproblem.messageType == 'outOfStock'}">
							<td>${thisproblem.label}</td>
							<td><fmt:formatDate value="${thisproblem.dateVisit}" pattern="dd MMM yy"/></td>
						</c:when>
						<c:otherwise>
							<td colspan="2" class="sectionHeader" style="background:#ddd;">${thisproblem.label}</td>
						</c:otherwise>
					</c:choose>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${! empty thisFormName}">
                        <td colspan="2"><html:link action="${thisFormName}.do" paramId="patientId" paramName="patientId">${thisproblem.label}</html:link></td>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${thisproblem.label == 'RPR'}">
                         <td colspan="2"><html:link href="rpr.do;jsessionid=${pageContext.request.session.id}?patientId=${thisproblem.patientId}&highlight=${thisproblem.encounterId}">${thisproblem.label}</html:link></td>
                                </c:when>
                                <c:when test="${thisproblem.incomplete == true}">
                         <td colspan="2"><html:link href="labs.do;jsessionid=${pageContext.request.session.id}?patientId=${thisproblem.patientId}&highlight=${thisproblem.encounterId}">${thisproblem.label}</html:link></td>
                                </c:when>
                                <c:otherwise>
                         <td colspan="2"><html:link action="form${thisproblem.formId}/new.do">${thisproblem.label}</html:link></td>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </tr>
        </c:when>
</c:choose>
</logic:iterate>

</logic:notEmpty>
</table>
  <!--
  </div>
 </div> -->
</div>
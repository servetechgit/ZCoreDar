<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>

<%@ attribute name="pos" required="false" type="java.lang.Integer" %>
<%@ attribute name="remoteClass" required="false" type="java.lang.String" %>
<%@ attribute name="classname" required="false" type="java.lang.String" %>
<%@ attribute name="propertyName" required="false" type="java.lang.String" %>
<%@ attribute name="patientId" required="false" type="java.lang.Integer" %>
<%@ attribute name="eventId" required="false" type="java.lang.Integer" %>
<%@ attribute name="user" required="false" type="java.lang.String" %>
<%@ attribute name="siteId" required="false" type="java.lang.Integer" %>
<%@ attribute name="formId" required="false" type="java.lang.Integer" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="renderedValue" required="false" type="java.lang.String" %>
<%@ attribute name="encounterId" required="false" type="java.lang.Integer" %>
<%@ attribute name="onchange" required="false" type="java.lang.String" %>
<%@ attribute name="styleId" required="false" type="java.lang.String" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:set var="scriptName" value="reply${field.identifier}"/>
<c:set var="field" value="${pageItem.form_field}" />
<c:choose>
    <c:when test="${field.id == 1862}"> <%-- Phase of pregnancy--%>
        <logic:present name="zeprs_session" property="sessionPatient">
            <c:choose>
                <c:when test="${! empty zeprs_session.sessionPatient.parentId}"/>
                <c:otherwise><bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br>
                </c:otherwise>
            </c:choose>
        </logic:present>
        <logic:notPresent name="zeprs_session" property="sessionPatient">
              <bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br>
        </logic:notPresent>
    </c:when>
    <c:otherwise><bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span></c:if><br></c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${field.id == 1677}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleFieldSafeMotherhood('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', ${pageItem.visibleEnumIdTrigger2}, '${pageItem.visibleDependencies2}','${field.identifier}');" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${field.id == 224}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="validateBP();" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${field.id == 52}"><%-- Pregnancy Course--%>
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="pregCourseAbort();" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${field.id == 225}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="validateBP();" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${field.id == 1931}"> <%--Date of test field in Counseling visit form--%>
        <jsp:useBean id="now" class="java.util.Date"/>
        <fmt:formatDate type="both" pattern="yyyy" value="${now}" var="yearnow"/>
        <fmt:formatDate type="both" pattern="MM" value="${now}" var="monthnow"/>
        <fmt:formatDate type="both" pattern="dd" value="${now}" var="datenow"/>
        <c:set var="theDate" value="${now}"/>
        <fmt:formatDate type="both" pattern="dd/MM/yyyy" value="${theDate}" var="nicedateVisit"/>
        <fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${theDate}" var="dbdateVisit"/>
        <html:select property="${field.identifier}" styleId="select${field.identifier}"
                     onchange="toggleField('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}','${field.identifier}');insertDate(1865, '${nicedateVisit}', '${dbdateVisit}');">
            <html:option value="">-- Select --</html:option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                </c:if>
            </c:forEach>
        </html:select>
    </c:when>

    <c:when test="${field.id == 1845}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="selectLabResults();" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>

    <c:when test="${field.id == 1854}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="selectDrugEnum();" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${field.id == 1862}"> <%-- Phase of pregnancy--%>
        <logic:present name="zeprs_session" property="sessionPatient">
            <c:choose>
                <c:when test="${! empty zeprs_session.sessionPatient.parentId}">
                    <html:hidden property="${field.identifier}"/>
                </c:when>
                <c:otherwise>
                    <html:select property="${field.identifier}" styleId="select${field.identifier}">
                        <html:option value="">-- Select --</html:option>
                        <c:forEach var="enum" begin="0" items="${field.enumerations}">
                            <c:if test='${enum.enabled ==true}'>
                                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                            </c:if>
                        </c:forEach>
                    </html:select>
                </c:otherwise>
            </c:choose>
        </logic:present>
        <logic:notPresent name="zeprs_session" property="sessionPatient">
            <html:select property="${field.identifier}" styleId="select${field.identifier}">
                <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
            </html:select>
        </logic:notPresent>
    </c:when>

    <c:when test="${field.id == 1266}">
        <!-- dependencies-->
         <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleField3DepsChoice('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', ${pageItem.visibleEnumIdTrigger2}, '${pageItem.visibleDependencies2}','2910','1841','${field.identifier}');" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">true
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
       <c:when test="${field.id == 1998}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="selectPatientEnrolledDropdown();" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${(pageItem.visibleEnumIdTrigger2 > 0)}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleField2DepsChoice('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', ${pageItem.visibleEnumIdTrigger2}, '${pageItem.childIdentifier2}','${field.identifier}');" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${(pageItem.visibleEnumIdTrigger1 > 0)}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleField('dropdown', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}','${field.identifier}');" >
            <html:option value="">-- Select --</html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                        <c:choose>
                            <c:when test="${enum.enumeration == 'Admit to UTH'}">
                                <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:otherwise>
        <html:select property="${field.identifier}" styleId="${styleId}" onchange="${onchange}">
        <html:option value="">-- Select --</html:option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                    <c:choose>
                        <c:when test="${enum.enumeration == 'Admit to UTH'}">
                            <c:if test="${zeprs_session.clientSettings.site.siteTypeId ==2}">
                                <html:option value="${enum.id}"><bean:message key="${encounterForm.classname}.${field.identifier}_${enum.id}" bundle="${encounterForm.classname}Messages" /> -tr</html:option>
                            </c:if>
                        </c:when>
                        <c:when test="${enum.id == 3279}">
						<!--  disable Out-of-Stock for Stock Control form -->
                        </c:when>
                        <c:otherwise>
                            <html:option value="${enum.id}"><bean:message key="${encounterForm.classname}.${field.identifier}_${enum.id}" bundle="${encounterForm.classname}Messages" /></html:option>
                        </c:otherwise>
                    </c:choose>
                 </c:if>
            </c:forEach>
    </html:select>
    </c:otherwise>
</c:choose>
${field.units}
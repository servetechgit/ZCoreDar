<%@ page import="java.util.List"%>
<%@ page import="org.rti.zcore.utils.WidgetUtils"%>

<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
        <c:choose>
            <c:when test='${pageItem.inputType=="radio"}'>
                <c:choose>
                <c:when test='${param.id != null}'>
                <zeprs:radio pageItem="${pageItem}" edit="1" onchange="${onchange}"  styleId="${styleId}"/>
                </c:when>
                <c:otherwise>
                <zeprs:radio pageItem="${pageItem}" edit="0" onchange="${onchange}"  styleId="${styleId}"/>
                </c:otherwise>
                </c:choose>
            </c:when>

            <c:when test='${pageItem.inputType=="radio-vertical"}'>
                <zeprs:radio_vert pageItem="${pageItem}"/>
            </c:when>

            <c:when test='${pageItem.inputType=="radio-no-label"}'>
                <zeprs:radio_no_label pageItem="${pageItem}"/>
            </c:when>

            <c:when test='${pageItem.inputType=="checkbox"}'>
               <zeprs:checkbox pageItem="${pageItem}"/>
           </c:when>

            <c:when test='${pageItem.inputType=="checkbox_dwr"}'>
                <zeprs:checkbox pageItem="${pageItem}"/>
            </c:when>

           <c:when test='${pageItem.inputType=="Yes/No"}'>
               <zeprs:yesno pageItem="${pageItem}"/>
           </c:when>

            <c:when test='${pageItem.inputType=="multiselect_enum"}'>
                <zeprs:multiselect_enum pageItem="${pageItem}" multiValues="${multiValues[field.id]}"/>
            </c:when>

            <c:when test='${pageItem.inputType=="multiselect_enum_input"}'>
                <zeprs:multiselect_enum pageItem="${pageItem}" multiValues="${multiValues[field.id]}"/>
            </c:when>

            <c:when test='${pageItem.inputType=="select-only"}'>
                <zeprs:select-only pageItem="${pageItem}"/>
            </c:when>

            <c:when test='${pageItem.inputType=="select-multitoggle"}'>
                <zeprs:select-multitoggle pageItem="${pageItem}"/>
            </c:when>

            <c:when test='${pageItem.inputType=="select-dwr-label"}'>
                <c:choose>
                <c:when test="${! empty encounter}">
                    <logic:notEmpty name="encounter" property="${field.identifier}">
                        <bean:define id="thisValue" name="encounter" property="encounterMap.${field.identifier}" />
                        <zeprs:select-dwr-label pageItem="${pageItem}" pos="${pos}" remoteClass="${remoteClass}" classname="${classname}" propertyName="${pageItem.form_field.starSchemaName}" patientId="${zeprs_session.sessionPatient.id}" eventId="${zeprs_session.sessionPatient.currentEventId}" user = "${user}" siteId="${siteId}" formId="${pageItem.form.id}" value="${thisValue}"/>
                    </logic:notEmpty>
                    <logic:empty name="encounter" property="${field.identifier}">
                        <zeprs:select-dwr-label pageItem="${pageItem}" pos="${pos}" remoteClass="${remoteClass}" classname="${classname}" propertyName="${pageItem.form_field.starSchemaName}" patientId="${zeprs_session.sessionPatient.id}" eventId="${zeprs_session.sessionPatient.currentEventId}" user = "${user}" formId="${pageItem.form.id}" siteId="${siteId}"/>
                    </logic:empty>
                </c:when>
                <c:otherwise>
                    <zeprs:select pageItem="${pageItem}" value="${thisValue}" renderedValue="${renderedValue}" encounterId="${encounterId}"/>
                </c:otherwise>
                </c:choose>
            </c:when>

            <c:when test="${pageItem.inputType=='lab_results'}">
                <%
                    // Lab Studies
                    List labResultEnums = WidgetUtils.getDynaSiteLabEnums();
                    request.setAttribute("labResultEnums", labResultEnums);
                %>
                <zeprs:lab_results pageItem="${pageItem}"/>
            </c:when>

            <c:when test="${pageItem.inputType=='drug_interventions'}">
                <%
                    // Drug Interventions
                    List drugInterventionEnums = WidgetUtils.getDynaSiteDrugEnums();
                    request.setAttribute("drugInterventionEnums", drugInterventionEnums);
                %>
                <zeprs:drug_interventions pageItem="${pageItem}"/>
            </c:when>

           <c:otherwise>
                <zeprs:select pageItem="${pageItem}" value="${thisValue}" renderedValue="${renderedValue}" encounterId="${encounterId}" onchange="${onchange}"  styleId="${styleId}"/>
           </c:otherwise>
        </c:choose>

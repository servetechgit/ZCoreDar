<%@ page import="org.rti.zcore.utils.SessionUtil,
                 java.util.List,
                 org.rti.zcore.dynasite.dao.DistrictDAO"%>
<%@ page import="org.rti.zcore.utils.WidgetUtils"%>
<%@ page import="org.rti.zcore.DynaSiteObjects"%>
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<c:choose>
    <c:when test='${pageItem.inputType=="apgar"}'>
        <c:choose>
        <c:when test='${param.id != null}'>
        <zeprs:apgar pageItem="${pageItem}" edit="true"/>
        </c:when>
        <c:otherwise>
        <zeprs:apgar pageItem="${pageItem}"/>
        </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test='${pageItem.inputType=="ega"}'>
        <zeprs:ega pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="position"}'>
        <zeprs:position pageItem="${pageItem}"/>
    </c:when>
    <c:when test='${pageItem.inputType=="position-dropdown"}'>
        <zeprs:position-dropdown pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="nrc"}'>
        <zeprs:nrc pageItem="${pageItem}"/>
    </c:when>
    <c:when test='${pageItem.inputType=="sites"}'>
        <%
        String patientSiteId = SessionUtil.getInstance(session).getClientSettings().getSiteId().toString();
        request.setAttribute("patientSiteId",patientSiteId);
        %>
        <zeprs:sites pageItem="${pageItem}"/>
    </c:when>
    <c:when test='${pageItem.inputType=="sites_not_selected"}'>
        <zeprs:sites_not_selected pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="other_pharm_dropdown"}'>
        <zeprs:other_pharm_dropdown pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="other_pharm_paeds_dropdown"}'>
        <zeprs:other_pharm_paeds_dropdown pageItem="${pageItem}"/>
    </c:when>

	<c:when test='${pageItem.inputType=="checkbox"}'>
		<zeprs:checkbox pageItem="${pageItem}"/>
   </c:when>

	<c:when test='${pageItem.inputType=="Yes/No"}'>
       <zeprs:yesno pageItem="${pageItem}"/>
   </c:when>

    <c:when test='${field.type=="Section title"}'>
       <zeprs:spacer pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="textarea"}'>
        <zeprs:textarea pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="textarea_dwr"}'>
        <zeprs:textarea_dwr pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="patientid"}'>
        <zeprs:patientid pageItem="${pageItem}"/>
    </c:when>

     <c:when test='${pageItem.inputType=="district"}'>
        <%
        List districts = DynaSiteObjects.getDistricts();
        request.setAttribute("districts",districts);
        %>
        <zeprs:district pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="patientid_districts"}'>
        <%
        List districts2 = DynaSiteObjects.getDistricts();
        request.setAttribute("districts",districts2);
        String patientDistrictId = SessionUtil.getInstance(session).getClientSettings().getDistrictId().toString();
        request.setAttribute("patientDistrictId",patientDistrictId);
        %>
        <zeprs:patientid_districts pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="patientid_sites"}'>
        <%
        String patientSiteId2 = SessionUtil.getInstance(session).getClientSettings().getSiteId().toString();
        request.setAttribute("patientSiteId",patientSiteId2);
        %>
        <zeprs:patientid_sites pageItem="${pageItem}"/>
    </c:when>

    <c:when test="${pageItem.inputType=='display-header'}"></c:when>
    <c:when test="${pageItem.inputType=='display-header-row'}"></c:when>

    <c:when test="${pageItem.inputType=='lab_results'}">
        <%
            // Lab Studies
    List labResultEnums2 = WidgetUtils.getDynaSiteLabEnums();
    request.setAttribute("labResultEnums", labResultEnums2);
        %>
        <zeprs:lab_results pageItem="${pageItem}"/>
    </c:when>

    <c:when test='${pageItem.inputType=="Yes/No"}'>
        <zeprs:yesno_only pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='text-only'}"><zeprs:text-only pageItem="${pageItem}"/></c:when>

    <c:when test='${pageItem.inputType=="uterus_size"}'>
        <zeprs:uterus_size pageItem="${pageItem}"/>
    </c:when>
    <c:when test='${pageItem.inputType=="firm"}'>
        <zeprs:firm pageItem="${pageItem}"/>
    </c:when>
    <c:when test='${pageItem.inputType=="fundal_height"}'>
        <zeprs:fundal_height pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='text-dwr'}">
        <zeprs:input pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='dropdown'}">
        <zeprs:dropdown pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='dropdown-add-one'}">
        <zeprs:dropdown-add-one pageItem="${pageItem}"/>
        <c:set var="dropdownId" value="${pageItem.id}"/>
        <c:set var="dropdownfieldIdentifier" value="${pageItem.form_field.identifier}"/>
        <c:set var="dropdownSelectedEnumId" value="${pageItem.selectedEnum}"/>
        <c:set var="forceCloseRow" value="${pageItem.closeRow}"/>
	<%@ include file="inline_form.jsp" %>
<jsp:useBean id="pageItem" class="org.rti.zcore.PageItem" />
<jsp:setProperty name="pageItem" property="closeRow" value="${forceCloseRow}" />
    </c:when>
    <c:when test="${pageItem.inputType=='hidden-empty'}">
        <zeprs:hidden pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='hidden-no-edit'}">
        <zeprs:hidden pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='hidden-no-listing'}">
        <zeprs:hidden pageItem="${pageItem}"/>
    </c:when>
    <c:when test="${pageItem.inputType=='age_calc_age_category'}">
        <zeprs:age_calc_age_category pageItem="${pageItem}" value="${thisValue}" renderedValue="${renderedValue}" encounterId="${encounterId}"/>
    </c:when>
    <c:otherwise>
        <zeprs:input pageItem="${pageItem}" value="${thisValue}" renderedValue="${renderedValue}" encounterId="${encounterId}"/>
    </c:otherwise>

</c:choose>
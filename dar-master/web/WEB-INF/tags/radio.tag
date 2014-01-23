<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<%@ attribute name="edit" required="true" type="java.lang.String" %>
<%@ attribute name="onclickFill_In" required="false" type="java.lang.String" %>
<%@ attribute name="styleId" required="false" type="java.lang.String" %>
<%@ attribute name="numericStyleId" required="false" type="java.lang.Boolean" %>
<%@ attribute name="lineBreak" required="false" type="java.lang.Boolean" %>
<%@ attribute name="onchange" required="false" type="java.lang.String" %>
<c:set var="field" value="${pageItem.form_field}" />
<div class="row"><span class="labelNoBold"><bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span> </c:if></span>
<span class="formw">
<c:forEach var="enum" begin="0" items="${field.enumerations}"  varStatus="ctr">
    <c:choose>
           <%--<c:when test="${(pageItem.visibleEnumIdTrigger1 > 0) && (pageItem.visibleEnumIdTrigger2 > 0)}">
                <html:radio property="${field.identifier}" styleId="${field.identifier}${enum.id}" value="${enum.id}" onclick="toggleField2Deps('radio',${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}',${pageItem.visibleEnumIdTrigger2}, '${pageItem.childIdentifier2}','${field.identifier}${enum.id}');"/> ${enum.enumeration}
            </c:when>--%>
            <c:when test="${field.id == 1487}">
            <html:radio property="${field.identifier}" styleId="${field.identifier}${enum.id}" value="${enum.id}" onclick="toggleField2DepsChoice('radio', ${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}', ${pageItem.visibleEnumIdTrigger2}, '${pageItem.childIdentifier2}','${field.identifier}${enum.id}');"/> ${enum.enumeration}
                <%--<c:if test="${(enum.id == pageItem.selectedEnum) && (edit == '0')}">
                <script type="text/javascript" language="Javascript1.1">
                <!-- Begin
                 var selRadio = document.getElementById("${field.identifier}${enum.id}");
                 selRadio.checked=true;
                //End -->
                </script>
                </c:if>--%>
            </c:when>
            <c:when test="${(pageItem.visibleEnumIdTrigger1 > 0) && (pageItem.visibleEnumIdTrigger1 > 0)}">
               <html:radio property="${field.identifier}" styleId="${field.identifier}${enum.id}" value="${enum.id}" onclick="toggleField('radio',${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}','${field.identifier}${enum.id}');"/> ${enum.enumeration}
            </c:when>
            <c:when test="${(pageItem.visibleEnumIdTrigger2 > 0) && (pageItem.visibleEnumIdTrigger2 > 0)}">
                <html:radio property="${field.identifier}" styleId="${field.identifier}${enum.id}" value="${enum.id}" onclick="toggleField('radio',${pageItem.visibleEnumIdTrigger2}, '${pageItem.childIdentifier2}','${field.identifier}${enum.id}');"/> ${enum.enumeration}
            </c:when>
            <c:otherwise>
				<c:choose>
					<c:when test="${! empty onclickFill_In}">
						<c:choose>
							<c:when test="${! empty numericStyleId}">
								<html:radio property="${field.identifier}" value="${enum.id}" onclick="${onclickFill_In}(${enum.numericValue})" styleId="${field.identifier}${enum.numericValue}"/> ${enum.enumeration}
							</c:when>
				            <c:otherwise>
								<html:radio property="${field.identifier}" value="${enum.id}"/> ${enum.enumeration}
				            </c:otherwise>
						</c:choose>
					</c:when>
		            <c:otherwise>
						<html:radio property="${field.identifier}" value="${enum.id}"/> ${enum.enumeration}
		            </c:otherwise>
				</c:choose>
            </c:otherwise>
     </c:choose>
<c:if test="${lineBreak == true}"><br/></c:if>
</c:forEach>
</span>
</div>
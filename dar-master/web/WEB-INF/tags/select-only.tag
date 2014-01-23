<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<c:choose>
    <c:when test="${field.identifier == 224}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="validateBP();" >
            <html:option value=""> -- Select -- </html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
    <c:when test="${field.identifier == 225}">
        <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="validateBP();" >
            <html:option value=""> -- Select -- </html:option>
                <c:forEach var="enum" begin="0" items="${field.enumerations}">
                    <c:if test='${enum.enabled ==true}'>
                    <html:option value="${enum.id}">${enum.enumeration}</html:option>
                    </c:if>
                </c:forEach>
        </html:select>
    </c:when>
<c:when test="${(pageItem.visibleEnumIdTrigger1 > 0)}">
    <html:select property="${field.identifier}" styleId="select${field.identifier}" onchange="toggleField('dropdown',${pageItem.visibleEnumIdTrigger1}, '${pageItem.childIdentifier1}','${field.identifier}');" >
        <html:option value=""> -- </html:option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                <html:option value="${enum.id}">${enum.enumeration}</html:option>
                </c:if>
            </c:forEach>
    </html:select>
</c:when>
<c:otherwise>
    <html:select property="${field.identifier}" styleId="select${field.identifier}" >
        <html:option value=""> -- </html:option>
            <c:forEach var="enum" begin="0" items="${field.enumerations}">
                <c:if test='${enum.enabled ==true}'>
                    <c:choose>
                    <c:when test="${pageItem.form.id =='80'}">
                    <c:if test="${enum.enumeration != 'Other, Describe'}">
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
</c:otherwise>
</c:choose>
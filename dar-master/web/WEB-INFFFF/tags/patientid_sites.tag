<%@ tag import="org.rti.zcore.utils.SessionUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/fmt.tld" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="pageItem" required="false" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<html:hidden styleId="siteId" property="${field.identifier}" value="${siteAlphaId}"/>
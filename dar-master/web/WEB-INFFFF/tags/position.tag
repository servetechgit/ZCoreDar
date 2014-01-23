<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ attribute name="pageItem" required="true" type="org.rti.zcore.PageItem" %>
<c:set var="field" value="${pageItem.form_field}" />
<label><bean:message key="${encounterForm.classname}.${field.identifier}" bundle="${encounterForm.classname}Messages" />: <c:if test='${field.required}'><span class="asterix">*</span></label></c:if>
<br/>
<table width="100%" cellspacing="1" cellpadding="4" border="1">
     <tr>
        <td colspan="2" align="center"><p>Please click on the image that displays the position.<br/>
        If breech, point of designation is the sacrum. Use the same diagrams.</p>
        <html:text styleClass="disabled" onfocus="this.blur()" styleId="pos${field.identifier}" property="${field.identifier}" onchange="" /></td>
    </tr>
    <tr>
        <td align="center"><strong>Occiput Posterior</strong><br/><!-- 12:00 -->
        <img id = "pos1" src="/${appName}/images/position/circle.gif" alt="Occiput Posterior" onclick="document.getElementById('pos${field.identifier}').value='Occiput Posterior';highlightImg('pos1');"></td>
        <td align="center"><strong>Right Occiput Posterior</strong><br/><!-- 1:30 -->
        <img id = "pos2" src="/${appName}/images/position/circle45.gif" alt="Right Occiput Posterior" onclick="document.getElementById('pos${field.identifier}').value='Right Occiput Posterior';highlightImg('pos2');"></td>
    </tr>
    <tr>
        <td align="center"><strong>Right Occiput Transverse</strong><br/><!-- 3:00 -->
        <img id = "pos3" src="/${appName}/images/position/circle90.gif" alt="Position 3" onclick="document.getElementById('pos${field.identifier}').value='Right Occiput Transverse';highlightImg('pos3');"></td>
        <td align="center"><strong>Right Occiput Anterior</strong><br/><!-- 4:30 -->
        <img id = "pos4" src="/${appName}/images/position/circle135.gif" alt="Position 4" onclick="document.getElementById('pos${field.identifier}').value='Right Occiput Anterior';highlightImg('pos4');"></td>
    </tr>
    <tr>
        <td align="center"><strong>Occiput Anterior</strong><br/><!-- 6:00 -->
        <img id = "pos5" src="/${appName}/images/position/circle180.gif" alt="Position 5" onclick="document.getElementById('pos${field.identifier}').value='Occiput Anterior';highlightImg('pos5');"></td>
        <td align="center"><strong>Left Occiput Anterior</strong><br/><!-- 7:30 -->
        <img id = "pos6" src="/${appName}/images/position/circle225.gif" alt="Position 6" onclick="document.getElementById('pos${field.identifier}').value='Left Occiput Anterior';highlightImg('pos6');"></td>
    </tr>
    <tr>
        <td align="center"><strong>Left Occiput Transverse</strong><br/><!-- 9:00 -->
        <img id = "pos7" src="/${appName}/images/position/circle270.gif" alt="Position 7" onclick="document.getElementById('pos${field.identifier}').value='Left Occiput Transverse';highlightImg('pos7');"></td>
        <td align="center"><strong>Left Occiput Posterior</strong><br/><!-- 10:30 -->
        <img id = "pos8" src="/${appName}/images/position/circle315.gif" alt="Position 8" onclick="document.getElementById('pos${field.identifier}').value='Left Occiput Posterior';highlightImg('pos8');"></td>
    </tr>
</table>
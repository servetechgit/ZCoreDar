<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ page import="org.rti.zcore.DynaSiteObjects"%>
<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri='/WEB-INF/tlds/zeprs.tld' prefix='zeprs' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
<template:put name='title' content='Admin: Create Page Item' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: <html:link action="/admin/formList">Form Admin</html:link>: Create Page Item</template:put>
<template:put name='content' direct='true'>
<c:if test="${subject.inputType == 'druglist'}" >
<%
	pageContext.setAttribute("drugs", DynaSiteObjects.getDrugs());
%>

</c:if>
<div id="adminToolbar">
	<c:choose>
		<c:when test="${!empty param.formId}">
		<html:link action="/admin/form/edit?id=${param.formId}">Return to Form</html:link> |
		</c:when>
		<c:when test="${!empty request.formId}">
		<html:link action="/admin/form/edit?id=${request.formId}">Return to Form</html:link> |
		</c:when>
		<c:otherwise>
		<html:link action="/admin/form/edit?id=${formId}">Return to Form</html:link> |
		</c:otherwise>
	</c:choose>
	<a href="#" onclick="toggle2('createFieldInstructions');">Instructions</a>
</div>

<div id="admin1">
<span class="error"><html:errors  header="Error(s):" /></span>
	<h2>Field Options</h2>
	<html:form action="admin/pageItem/save" method="POST" onsubmit="return validateAdminPageItem(this);">
	<c:choose>
	<c:when test="${!empty param.formId}">
	<input type="hidden" name="formId" value="${param.formId}">
	</c:when>
	<c:when test="${!empty request.formId}">
	<input type="hidden" name="formId" value="${request.formId}">
	</c:when>
	<c:otherwise>
	<input type="hidden" name="formId" value="${formId}">
	</c:otherwise>
	</c:choose>
	<html:hidden property="form_field.id"/>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.label" />: </span>
		<span class="formw"><html:text property="form_field.label" size="35" /></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.columnName" />: </span>
		<span class="formw"><html:text property="form_field.starSchemaName" /></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.type" />: </span>
		<span class="formw">
			<html:select property="form_field.type" styleId="formFieldType">
			<html:option value="Text"/>
			<html:option value="Enum">Enum (dropdown)</html:option>
			<html:option value="Integer"/>
			<html:option value="Long"/>
			<html:option value="Float"/>
			<html:option value="Date"/>
			<html:option value="Time"/>
			<html:option value="Year"/>
			<html:option value="Boolean"/>
			<html:option value="Yes/No"/>
			<html:option value="sex">Sex</html:option>
			<html:option value="MultiEnum"/>
			<html:option value="Display"/>
			</html:select>
		</span>
	</div>
	<script type="text/javascript">
	//<![CDATA[
		$("formFieldType").onchange = function () {
		if ($("formFieldType").value == "Enum") {
			$("inputType").value ="select";
		}
	}
	</script>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.required" />: </span>
		<span class="formw"><html:checkbox  property="form_field.required" /></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.minValue" />: </span>
		<span class="formw"><html:text property="form_field.minValue" size="3" /></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.maxValue" />: </span>
		<span class="formw"><html:text property="form_field.maxValue" size="3" /></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.units" />: </span>
		<span class="formw"><html:text property="form_field.units" /></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.enabled" />: </span>
		<span class="formw"><input type="checkbox" name="form_field.enabled" value="on" checked="checked"></span>
	</div>
	<div class="row">
		<span class="label"><bean:message bundle="ApplicationResources" key="labels.admin.field.shared" />: </span>
		<span class="formw"><html:checkbox property="form_field.shared" /></span>
	</div>
</div>

<div id="createFieldInstructions" onClick='document.getElementById("createFieldInstructions").style.display="none"' style="position:absolute;
	display:none;">
<h2>Instructions</h2>
<ul>
<li>Label is the name that will be displayed to the left of the field. </li>
<li>"Column name" need to be a short, one word name to describe the field in the database.
It begin with a letter and contain only letters, underscore characters (_), and digits.
It may not be any of the <a href="http://db.apache.org/derby/docs/dev/ref/rrefkeywords29722.html">Derby Reserved Words</a> nor any of the field names in EncounterData.</li>
<li>The <strong>Field Type</strong> determines the data type in the database. After choosing the Field Type, choose how the form field is rendered
 and how it is validated in the Item Display Options.<br/>
    Some of the less obvious selections:
    <ul>
    <li>Text: Data Type - VARCHAR(255). Text-entry box. Under Display options be sure to choose either "Text" or "Text area."</li>
    <li>Enum (dropdown): Data Type - int. Creates an Integer field in database. Usually renders as a drop-down with Enumerations that have been manually populated.
    Under Display options be sure to choose either "Radio Button","Checkbox", or "Drop Down." Create the enumerations when you edit the field.</li>
    <li>Integer: Data Type - int. You may enter the Validation Min and Max in Item Display Options. Renders as a text input box.</li>
    <li>Long: Data Type - BIGINT(20. You may enter the Validation Min and Max in Item Display Options. Renders as a text input box.</li>
    <li>Float: Data Type - float. You may enter the Validation Min and Max in Item Display Options. Renders as a text input box.</li>
    <li>Time: Data Type - time. This will render as a Time widget</li>
    <li>Date: Data Type - date. This will render as a Date widget</li>
    <li>Year: Data Type - int(5). Drop-down with Years starting from what is entered in Validation Min to this year.</li>
    <li>Boolean: Data Type - tinyint(1). Checkbox.
    <li>Yes/No: Data Type - tinyint(4). Yes/No radio buttons.
    <li>Sex: Data Type - tinyint(4). Dropdown w/ Male/Female enumerations.
    <li>Display - Does not create a field in the database; instead, used to identify display elements such as table begin or end commands.
    </ul>
</li>
<li>It is rare to select "Required," but sometimes you must insist the user fill out the field.
If checked, and the user neglects to make an entry in the field,  the system will make an alert and will not process the form until the field is filled out.</li>
<li>Item Display</li>
<ul>
<li>If you have selected Enum as the Field Type, be sure to select the correct Input type. Radio button or dropdown.
<b>Note:</b> Checkboxes are a difficult case. Right now, there are only single enumerations for checkboxes -
the system does not handle multiple checkboxes for a single field.
Therefore, create a separate field for every checkbox.</li>
<li>If you want this field to appear only when another field's value is selected, uncheck "Visible." <br>
</li>
<li>Textarea: For a bigger textarea, use Rows: 5, Cols:40. Otherwise, leave blank.</li>
<li>Hidden: For a hidden field, choose Hidden field - empty. If you'd like a value pre-filled, choose Hidden field - preset and enter the preset value in the Units field.</li>
<li>Colspan: Used to make a widget span more than a single table cell. Normally you'd leave this field blank.</li>
<li>Close Row: If you use the Colspan property, and the item being edited is the last one in a row, check this box.</li>
</ul>
</div>

<div id="admin2">
<h2>Item Display Options</h2>
<html:hidden property="_enumerationOrder"/>
<html:hidden property="id" />
<div class="row">
<span class="label">Widget: </span>
<span class="formw">
<html:select property="inputType" styleId="inputType">
<html:option value="text">Text</html:option>
<html:option value="text-only">Text - no label</html:option>
<html:option value="text-dwr">Text - DWR</html:option>
<html:option value="radio">Radio Button</html:option>
<html:option value="checkbox">Checkbox</html:option>
<html:option value="checkbox_dwr">Checkbox - DWR</html:option>
<html:option value="Yes/No">Yes/No</html:option>
<html:option value="yesno_dwr">Yes/No - DWR</html:option>
<html:option value="yesno_br">Yes/No - br after label</html:option>
<html:option value="yesno_no_na">Yes/No - no N/A choice</html:option>
<html:option value="textarea">Text Area</html:option>
<html:option value="textarea_dwr">Text Area - DWR - Label</html:option>
<html:option value="select">Drop-down</html:option>
<html:option value="dropdown">Drop-down from table</html:option>
<html:option value="dropdown-add-one">Drop-down from table - with "Add One" link</html:option>
<html:option value="select-only">Drop-down - no label</html:option>
<html:option value="select-dwr">Drop-down - DWR</html:option>
<html:option value="select-dwr-label">Drop-down - DWR - Label</html:option>
<html:option value="druglist">Drug List</html:option>
<html:option value="lab_results">Lab Results</html:option>
<html:option value="sites">Site dropdown</html:option>
<html:option value="emptyDate">Date (Empty) widget</html:option>
<html:option value="dateToday">Date (Prefilled w/ today's date)</html:option>
<html:option value="dateOneMonthFuture">Date (Prefilled w/ date 1 month in future)</html:option>
<html:option value="date_visit_dwr_label">Date (Empty) - DWR</html:option>
<html:option value="birthdate">Birth date widget (60 year option)</html:option>
<html:option value="month">Month dropdown</html:option>
<html:option value="month_no_label">Month (no label) dropdown</html:option>
<html:option value="lmp">LMP Date widget</html:option>
<html:option value="edd">EDD Date widget</html:option>
<html:option value="ega">EGA Date widget</html:option>
<html:option value="ega_dwr">EGA Date widget - DWR</html:option>
<html:option value="ega_pregnancyDating">EGA Date widget - Pregnancy Dating</html:option>
<html:option value="display-header">Section Header</html:option>
<html:option value="display-subheader">Sub-section Header</html:option>
<html:option value="collapsing-display-header-begin">Begin Collapsing Section Header</html:option>
<html:option value="collapsing-display-header-end">End Collapsing Section Header</html:option>
<html:option value="display-tbl-begin">Begin table</html:option>
<html:option value="display-tbl-end">End table</html:option>
<html:option value="display-tbl-right-begin">Begin right div table</html:option>
<html:option value="display-tbl-right-end">End right div table</html:option>
<html:option value="display-spacer-field">Field spacer (blank td)</html:option>
<html:option value="multiselect_enum">Multiselect: Enum</html:option>
<html:option value="multiselect_item">Multiselect: Item</html:option>
<html:option value="collapsing-tbl-for-yesno">Collapsing table for Yes/No</html:option>
<html:option value="display_collapsing_add_item_link">Collapsing "Add item" link</html:option>
<html:option value="nrc">NRC Number Widget</html:option>
<html:option value="patientid">Patient ID: hidden field</html:option>
<html:option value="patientid_districts"> -- Patient ID: widget</html:option>
<html:option value="patientid_sites"> -- Patient ID: Site hidden field</html:option>
<html:option value="infotext">Informational Text</html:option>
<html:option value="hidden_dwr">Hidden field - DWR</html:option>
<html:option value="hidden-empty">Hidden field - empty</html:option>
<html:option value="hidden-preset">Hidden field - preset</html:option>
<html:option value="firm">Firm (UTH Firm)</html:option>
</html:select></span>
</div>
<div class="row">
<span class="label">Visible:</span>
<span class="formw"><c:choose>
    <c:when test="${empty subject}"><input type="checkbox" name="visible" value="on" checked="checked"></c:when>
    <c:otherwise><html:checkbox property="visible" /></c:otherwise>
</c:choose></span>
</div>

<div class="row">
<span class="label">Text field:</span>
</div>
<div class="row">
<span class="label">Size: </span>
<span class="formw"><html:text property="size" size="3" /></span>
</div>
<div class="row">
<span class="label">Max Length: </span>
<span class="formw"><html:text property="maxlength" size="3" /></span>
</div>

<div class="row">
	<span class="label">Textarea: </span>
	<span class="formw"></span>
</div>
<div class="row">
<span class="label">Rows: </span><span
class="formw"><html:text property="rows" size="3"/></span>
</div>
<div class="row">
<span class="label">Cols:</span><span
class="formw"><html:text property="cols" size="3"/></span>
</div>

<div class="row">
	<span class="label">Table Layout: </span>
	<span class="formw"></span>
</div>
<div class="row">
<span class="label">Colspan: </span><span
class="formw"><html:text property="colspan" size="2" maxlength="2"/></span>
</div>
<div class="row">
<span class="label">Close row: </span><span
class="formw"><html:checkbox property="closeRow"/></span>
</div>
<div class="row">
<p>
<html:submit value="Save" />
</div>
<html:javascript bundle="ApplicationResources" formName="adminPageItem" dynamicJavascript="true" staticJavascript="false"/>
</html:form>
</div>
</template:put>
<template:put name='help' direct="true" content=""/>
</template:insert>

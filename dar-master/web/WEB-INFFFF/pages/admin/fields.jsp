<%--
  ~    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
  ~
  ~    Licensed under the Apache License, Version 2.0 (the "License");
  ~    you may not use this file except in compliance with the License.
  ~    You may obtain a copy of the License at
  ~
  ~        http://www.apache.org/licenses/LICENSE-2.0
  --%>

<%@ taglib uri="/WEB-INF/tlds/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tlds/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tlds/struts-bean.tld" prefix="bean" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri='/WEB-INF/tlds/zeprs.tld' prefix='zeprs' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-admin.jsp'>
<template:put name='title' content='Admin: Edit Items for ${subject.label}' direct='true'/>
<template:put name='header' direct='true'><html:link action="/admin/home">Admin</html:link>: <html:link action="/admin/formList">Form Admin</html:link>: Edit Items for ${subject.label}</template:put>
<template:put name='help' content="" direct="true"/>
<template:put name='content' direct='true'>
<script type='text/javascript' src='/${appName}/js/engine2.jsp;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwrdyna/util.js;jsessionid=${pageContext.request.session.id}'></script>
<script type='text/javascript' src='/${appName}/dwrdyna/interface/Dynasite.js;jsessionid=${pageContext.request.session.id}'></script>

<span class="error"><html:errors /></span>

<logic:present parameter="formId" >
<bean:parameter id="formId" name="formId" />
</logic:present>
<logic:notPresent parameter="formId">
    <logic:present parameter="id" ><bean:parameter id="formId" name="id" /></logic:present>
</logic:notPresent>
<bean:size id="numPageItems" name="subject" property="pageItems"/>
<a name="top"></a>
<div id="adminToolbar">
	<html:link action="/admin/form/edit" paramId="id" paramName="subject" paramProperty="id">Refresh page</html:link> |
	<html:link action="/admin/pageItem/new" paramId="formId" paramName="subject" paramProperty="id"><bean:message bundle="ApplicationResources" key="labels.admin.form.addField"/></html:link> |
	<a href="#" onclick="hideElement('editArea'); justReveal('addSharedField');">Add Shared Field</a> |
	    <c:url value="reload" var="reload"><c:param name="path" value="/${appName}"/></c:url>
	<a href='<c:out value="/manager/html/${reload}"/>' onclick="return confirm('Reload ${appTitle} app?');self.close();">Reload ${appTitle} web application</a> |
	<a href="#" onclick="fireMyPopup('adminInstructions', 'editArea')">Instructions</a>
	<p>
<p>
	<c:if test="${! empty availableLocale}">
	<strong><bean:message bundle="ApplicationResources" key="labels.admin.form.availableLocales"/>: &nbsp;</strong>
	<c:forEach var='item' items='${localeDisplayMap}' varStatus="status">
		<c:set var="string" value="${item.key}"/>
		<c:url value="locale/edit.do" var="loc">
		<c:param name="id" value="${subject.id}"/>
		<c:param name="locale" value="${string}"/>
		</c:url>
		<a href='<c:out value="${loc}"/>'>${item.value}</a>
		<c:if test="${!status.last}">|</c:if>
	</c:forEach>
	</c:if>
</p>
</div>
<div id="adminInstructions" onClick='document.getElementById("adminInstructions").style.display="none"' style='position: absolute; width: 250px; height: 250px; display: none; background: #ddd; border: 1px solid #000; padding:.5em;'>
<h2>Instructions</h2>
<p><bean:message bundle="ApplicationResources" key="headings.admin.form.fields.instructions"/><br/>
Disabled Items are in red/italics. Shared Items have asterix surrounding name.
</p>
</div>
<html:form action="admin/form/preview" method="POST">
<input type="hidden" name="id" value="${subject.id}">
<c:set var="className" value="normalField"/>
<c:set var="numPageItems" value="${fn:length(subject.pageItems)}"/>
<h2>Items on this form</h2>
<html:button property="check" value="Save Field Order" onclick="fieldOrderChanged()" styleId="saveOrderBtn"/> |
<html:submit property="preview" value="Preview Form" onclick="bCancel=false;"/>
<input type="hidden" name="formId" value="${formId}"/>

<ul id="fieldList">
    <logic:iterate id="pageItem" name="subject" property="pageItems" indexId="i">
    <c:choose>
        <c:when test="${pageItem.form_field.enabled==false}">
            <c:set var="className" value="disabledField"/>
        </c:when>
        <c:otherwise>
            <c:set var="className" value="normalField"/>
        </c:otherwise>
    </c:choose>
	<li id="item_${pageItem.id}" class="${className}" onclick="dispatchPageItem('fieldList', '${pageItem.id}', event);">
            <c:if test="${pageItem.inputType=='display-tbl-begin'}"><em> &nbsp;| ---&nbsp;</c:if>
            <c:if test="${pageItem.inputType=='display-tbl-end'}"><em> &nbsp;---&nbsp;</c:if>
            <c:if test="${pageItem.form_field.shared==true}">* </c:if>
            <c:if test="${pageItem.inputType=='collapsing-display-header-begin'}"><strong>** </c:if>
                <span id="label_${pageItem.id}">${fn:substring(pageItem.form_field.label,0,30)}</span> (<bean:write bundle="ApplicationResources" name="pageItem"
                                                                             property="displayOrder"/>)
            <c:if test="${pageItem.form_field.shared==true}">*${pageItem.form_field.id}*</c:if>
            <c:if test="${pageItem.form_field.enabled==false}">* disabled *</c:if>
            <c:if test="${pageItem.inputType=='display-header'}"> **header** </c:if>
            <c:if test="${pageItem.inputType=='collapsing-display-header-begin'}"> **</strong></c:if>
            <c:if test="${pageItem.inputType=='display-tbl-begin'}">&nbsp;---&nbsp;</em></c:if>
            <c:if test="${pageItem.inputType=='display-tbl-end'}">&nbsp;---&nbsp;|&nbsp;</em></c:if>
            <html:link href="/${appName}/admin/pageItem/delete.do;jsessionid=${pageContext.request.session.id}?id=${pageItem.id}&formId=${subject.id}" onclick="confirm_entry();" title="Click to delete this pageItem from this form." >(X)</html:link>
            </li>
     </logic:iterate>
</ul>
    <script type="text/javascript">
        Sortable.create('fieldList',{tag:'li'});
        //Sortable.create('fieldList',{ghosting:true,constraint:false});
        //poststring = Sortable.serialize('fieldList');
        //alert(Sortable.serialize('fieldList'));
     // poststring now contains key[]=value pairs separated by &
        <!--
        function confirm_entry() {
        var answer = confirm ("Are you sure you want to delete this pageItem from the form?")
        if (answer)
        return ;
        }
        // -->
        </script>

<div id="addSharedField" style="position:absolute; left:226px; top:100px; display:none; visibility:hidden">
    <p><span id="sharedResult" class="error"></span></p>
    <p>
       <strong>Shared Items:</strong>
        <select name="_allfields" id="sharedFields">
            <c:forEach items="${shared_fields}" var="field">
                <option value="${field.id}">${fn:substring(field.label,0,40)} (${field.id})
                    <c:if test="${field.type=='display'}"> **DISPLAY** </c:if></option>
            </c:forEach>
        </select>
        <html:button property="_add" value="<< Use Shared Field <<" onclick="addSharedField('sharedFields', '${numPageItems}', ${subject.id})"/>
    </p>
</div>

<div id="editArea" style="position:absolute; left:234px; top:105px; display:none; visibility:hidden">
<p>Editing Field ID: <span id="field.id"></span>, PageItem ID: <span id="pageItem.id"></span>&nbsp;&nbsp;<span id="result" class="error"></span></p>
<div id="editPageItem" style="display:none; visibility:hidden">
	<p>Label: <input type="text" id="field.label" size="40"/>
	    Enabled: <input type="checkbox" id="field.enabled"/>
	    Required: <input type="checkbox" id="field.required"/>
	    Shared: <input type="checkbox" id="field.shared"/>
	</p>

	<p>Column Name (for database): <input type="text" id="field.starSchemaName"/>
	    Validation - Min: <input id="field.minValue" size="3" type="text">
	    Max: <input id="field.maxValue" size="3" type="text"></p>

	<p>Data Type: <select id="field.type"></select> Units: <input id="field.units" size="10" type="text"></p>

    <p id="enumerations" style="display:none; visibility:hidden">Enumerations: <select id="enums" onclick="dispatchEnum('enums');"></select>
	    <span onclick="renderEnumInputField(currentFieldId);"><img src="/${appName}/images/plus.gif" alt="Add enumerations" border="0"></span>
	    <a href="#" onclick="sortEnumerations(currentFieldId,${formId},'${pageContext.request.session.id}');" title="Sort enums alphabetically"> Sort </a>
	 </p>
     <p id="enumerationsCreation" style="display:none; visibility:hidden"></p>
     <p id="enumerationsEdit" style="display:none; visibility:hidden">
         <input type="hidden" id="id">
         Text: <input type="text" id="enumeration"> Numeric Value: <input type="text" id="numericValue" size="4"> Order: <input type="text" id="displayOrder"> Enabled: <input type="checkbox" id="enabled">
         <input value="Update Enumeration" onclick="UpdateEnum()" type="button" class="btnRed" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btnRed'"/>
     </p>
     <p>Widget: <select id="pageItem.inputType">
         <option value="text">Text</option>
         <option value="text-only">Text - no label</option>
         <option value="text-dwr">Text - DWR</option>
         <option value="radio">Radio Button</option>
         <option value="checkbox">Checkbox</option>
         <option value="checkbox_dwr">Checkbox - DWR</option>
         <option value="Yes/No">Yes/No</option>
         <option value="yesno_only">Yes/No - no label</option>
         <option value="yesno_dwr">Yes/No - DWR</option>
         <option value="yesno_br">Yes/No - br after label</option>
         <option value="yesno_br_each">Yes/No - br after each item</option>
         <option value="yesno_no_na">Yes/No - no N/A choice</option>
         <option value="textarea">Text Area</option>
         <option value="textarea_dwr">Text Area - DWR - Label</option>
         <option value="select">Drop-down</option>
         <option value="dropdown">Drop-down from table</option>
         <option value="dropdown-add-one">Drop-down from table - with "Add One" link</option>
         <option value="select-only">Drop-down - no label</option>
         <option value="select-dwr">Drop-down - DWR</option>
         <option value="select-dwr-label">Drop-down - DWR - Label</option>
         <option value="select-multitoggle">Drop-down - Multi-Toggle</option>
         <option value="emptyDate">Date (Empty) widget</option>
         <option value="dateToday">Date (Prefilled w/ today's date)</option>
         <option value="dateOneMonthFuture">Date (Prefilled w/ date 1 month in future)</option>
         <option value="birthdate">Birth date widget (80 year option)</option>
         <option value="age_calc_age_category">Age input box with Age Category calculation</option>
         <option value="date_visit_dwr_label">Date (Empty) - DWR</option>
         <option value="month">Month dropdown</option>
         <option value="month_no_label">Month (no label) dropdown</option>
         <option value="lmp">LMP Date widget</option>
         <option value="edd">EDD Date widget</option>
         <option value="ega">EGA Date widget</option>
         <option value="ega_dwr">EGA Date widget - DWR</option>
         <option value="ega_pregnancyDating">EGA Date widget - Pregnancy Dating</option>
         <option value="display-header">Section Header</option>
         <option value="display-subheader">Sub-section Header</option>
         <option value="collapsing-display-header-begin">Begin Collapsing Section Header</option>
         <option value="collapsing-display-header-end">End Collapsing Section Header</option>
         <option value="display-tbl-begin">Begin table</option>
         <option value="display-tbl-end">End table</option>
         <option value="display-tbl-right-begin">Begin right div table</option>
         <option value="display-tbl-right-end">End right div table</option>
         <option value="display-spacer-field">Field spacer (blank td)</option>
         <option value="multiselect_enum">Multiselect: Enum</option>
         <option value="multiselect_enum_input">Multiselect: Enum Input Field</option>
         <option value="multiselect_item">Multiselect: Item</option>
         <option value="collapsing-tbl-for-yesno">Collapsing table for Yes/No</option>
         <option value="display_collapsing_add_item_link">Collapsing "Add item" link</option>
         <option value="nrc">NRC Number Widget</option>
         <option value="patientid">Patient ID: hidden field</option>
         <option value="patientid_districts"> -- Patient ID: widget</option>
         <option value="patientid_sites"> -- Patient ID: Site hidden field</option>
         <option value="infotext">Informational Text</option>
         <option value="hidden_dwr">Hidden field - DWR</option>
         <option value="hidden-empty">Hidden field - empty</option>
		 <option value="hidden-preset">Hidden field - preset</option>
         <option value="hidden-no-edit">Hidden field - no edit</option>
         <option value="hidden-no-listing">Hidden field - no listing (for foreign keys)</option>
         <option value="prevPregnanciesLink">Previous Pregnancies link</option>
         <option value="uterus_size">Uterus Size in Weeks</option>
         <option value="firm">Firm (UTH Firm)</option>
         <option value="fundal_height">Fundal Height Dropdown</option>
         <option value="druglist">Drug List</option>
         <option value="lab_results">Lab Results</option>
         <option value="drug_interventions">Drug Intervention Enums</option>
         <option value="currentMedicine">Current Medicine</option>
         <option value="currentImmunizations">Current Immunizations</option>
         <option value="position">Position diagrams</option>
         <option value="position-dropdown">Position dropdown</option>
         <option value="position-dropdown-dwr">Position dropdown - DWR</option>
         <option value="apgar">Apgar Score</option>
         <option value="sites">Site dropdown - current site selected</option>
         <option value="sites_not_selected">Site dropdown - no selection</option>
     </select> Visible: <input type="checkbox" id="pageItem.visible"/> Highlight: <input type="checkbox" id="pageItem.highlightCell"/> Colspan: <input id="pageItem.colspan" size="1" type="text"> Close Row: <input type="checkbox" id="pageItem.closeRow"/></p>
     <p id="inputSize" style="display:none; visibility:hidden">Size: <input id="pageItem.size" size="3" type="text"> Maxlength: <input id="pageItem.maxlength" size="3" type="text"></p>
     <p id="textareaSize" style="display:none; visibility:hidden">Rows: <input id="pageItem.rows" size="3" type="text"> Cols: <input id="pageItem.cols" size="3" type="text"></p>
	<p id="dropdownStuff">Dropdown Table: <input id="pageItem.dropdownTable" type="text"/>
     <span title="Text from table that should display in the dropdown - example: 'contact_surname || ', ' || contact_firstname'">Dropdown Column:</span> <input id="pageItem.dropdownColumn"  type="text"/ size="40"><br/>
     <span title="Preprend with 'WHERE '">Dropdown Constraint:</span> <input id="pageItem.dropdownConstraint" type="text" size="80"/><br/>
     <span title="Preprend with 'ORDER BY '">Order by Clause:</span> <input id="pageItem.dropdownOrderByClause" type="text" size="80"/><br/>
     <span title="Enter the id of the enum that should be pre-selected">Selected Enum Id:</span> <input id="pageItem.selectedEnum" type="text" size="3"/>
     <span title="Use uuid or id for dropdown identifier? Default: uuid.">FK Identifier:</span> <input id="pageItem.fkIdentifier" type="text" size="5"/>
     </p>

     <c:set var="depSelectSize" value="${fn:length(subject.pageItems)}"/>
 <c:if test="${depSelectSize > 10}">
     <c:set var="depSelectSize" value="10"/>
 </c:if>

 <table id="dependencies" style="display:none; visibility:hidden">
     <tr><td>Field Dependencies 1:</td><td>Field Dependencies 2:</td></tr>
     <tr>
         <td><select name="test[]" id="pageItem.visibleDependencies1" size="${depSelectSize}" multiple="multiple">
         <option value=""> -- </option>
         <logic:iterate id="pageItem" name="subject" property="pageItems">
             <option value="${pageItem.form_field.id}"><c:if test="${pageItem.form_field.shared ==true}">
                 *</c:if>${fn:substring(pageItem.form_field.label,0,80)}<c:if test="${pageItem.form_field.shared ==true}">*</c:if> </option>
         </logic:iterate>
     </select></td>
         <td><select id="pageItem.visibleDependencies2" size="${depSelectSize}" multiple="multiple">
         <option value=""> -- </option>
         <logic:iterate id="pageItem" name="subject" property="pageItems">
             <option value="${pageItem.form_field.id}"><c:if test="${pageItem.form_field.shared ==true}">
                 *</c:if>${fn:substring(pageItem.form_field.label,0,80)}<c:if test="${pageItem.form_field.shared ==true}">*</c:if> </option>
         </logic:iterate>
        </select></td>
        </tr>
        <tr>
            <td>Trigger: <br/>
            <select id="pageItem.visibleEnumIdTrigger1"></select></td>
            <td>Trigger: <br/>
            <select id="pageItem.visibleEnumIdTrigger2"></select></td>
            </tr>
        </table>

<p><input value="Update Field" onclick="writePageItem();" type="button" class="btnRed" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btnRed'">
</p>
<p><html:link action="/admin/rule/new" onclick="dispatchCreateRules(this);">Create rule</html:link> | <a href="#" onclick="dispatchRules();">Edit Rules</a></p>
<p class="formrowlabelAdmin" id="displayItemProps"></p>
</div>
<div id="ruleParamList" style="display:none; visibility:hidden">
    <table border="1" class="enhancedtable">
        <thead>
            <tr>
                <th>Rules</th>
            </tr>
        </thead>
        <tbody id="ruleParams">
        </tbody>
    </table>
</div>
</div>
<input type="hidden" name="fieldOrder" id="fieldOrder" value="${fieldOrder}" size="80">
<script type="text/javascript">
    // var origFieldOrder = $("fieldOrder").value;
    // alert("origFieldOrder: " + origFieldOrder.value)
</script>
</html:form>
</template:put>
</template:insert>
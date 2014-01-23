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
<%@ taglib uri="/WEB-INF/tlds/zeprs.tld" prefix="zeprs" %>
<%@ taglib uri='/WEB-INF/tlds/struts-tiles.tld' prefix='template' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<template:insert template='/WEB-INF/templates/${appTemplateDir}/template-report-wide.jsp'>
<template:put name='title' direct='true'>ART Adult Daily Activity Report for ${register.siteName}&nbsp;
${register.beginDate}<c:if test="${!empty register.endDate}"> - ${register.endDate}</c:if></template:put>
<template:put name='header' direct='true'>ART Adult Daily Activity Report for ${register.siteName}&nbsp;
${register.beginDate}<c:if test="${!empty register.endDate}"> - ${register.endDate}</c:if></template:put>
<template:put name='content' direct='true'>
<script language="javascript" type="text/javascript">
    function scrollUp() {
        var divY = document.getElementById('scrollBody').scrollTop;
        var newDivY = divY - 50;
        document.getElementById('scrollBody').scrollTop = newDivY;
    }

    function scrollDown() {
        var divY = document.getElementById('scrollBody').scrollTop;
        var newDivY = divY + 50;
        document.getElementById('scrollBody').scrollTop = newDivY;
    }
</script>

<c:set var="pageBreakCount" value="0"/>
<table border="1" cellspacing="0" cellpadding="3" class="reportTablePrint">
	<tr>
        <td colspan="3">ART Program Sponsor</td>
        <td colspan="3">KEMSA</td>
        <th class="sideways" rowspan="2">ARV Regimen Code</th>
        <th colspan="20">ADULT FORMULATIONS</th>
    </tr>
    <tr>
    	<td colspan="3">Name of Facility</td>
        <td colspan="3">${register.siteName}</td>
        <th class="sideways">Stavudine/Lamivudine FDC Tabs<br/>(30/150mg)</th>
		<th class="sideways">Stavudine/Lamivudine FDC Tabs<br/>(40/150mg)</th>
		<th class="sideways">Stavudine/Lamivudine/Nevirapine<br/>FDC Tabs (30/150/200mg)</th>
		<th class="sideways">Stavudine/Lamivudine/Nevirapine<br/>FDC Tabs (40/150/200mg)</th>
		<th class="sideways">Zidovudine/Lamivudine Tabs/caps<br/>FDC (300/150mg)</th>
		<th class="sideways">Zidovudine/Lamivudine/Nevirapine<br/>Tabs/caps FDC (300/150/200mg)</th>
		<th class="sideways">Abacavir Tabs 300mg</th>
		<th class="sideways">Didanosine Tabs 200mg</th>
		<th class="sideways">Didanosine Tabs 100mg</th>
		<th class="sideways">Didanosine Tabs 50mg</th>
		<th class="sideways">Efavirenz Tabs 600mg</th>
		<th class="sideways">Efavirenz Tabs/caps 200mg</th>
		<th class="sideways">Lamivudine Tabs 150mg</th>
		<th class="sideways">Lopinavir/ritonavir Tabs/caps<br/>133.3/33.3mg</th>
		<th class="sideways">Nelfinavir Tabs 250mg</th>
		<th class="sideways">Nevirapine Tabs 200mg</th>
		<th class="sideways">Stavudine Tabs/Caps 30mg</th>
		<th class="sideways">Stavudine Tabs/Caps 40mg</th>
		<th class="sideways">Tenofovir Tabs/caps 300mg</th>
		<th class="sideways">Zidovudine Tabs 300mg</th>
    </tr>
    <tr>
        <th colspan="6" align="right">Balance B/F (A)</th>
        <th>&nbsp;</th>
        <td align="center">${register.balanceBF.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${register.balanceBF.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${register.balanceBF.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${register.balanceBF.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${register.balanceBF.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${register.balanceBF.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${register.balanceBF.abacavirTabs300mg}</td>
		<td align="center">${register.balanceBF.didanosineTabs200mg}</td>
		<td align="center">${register.balanceBF.didanosineTabs100mg}</td>
		<td align="center">${register.balanceBF.didanosineTabs50mg}</td>
		<td align="center">${register.balanceBF.efavirenzTabs600mg}</td>
		<td align="center">${register.balanceBF.efavirenzTabs_caps200mg}</td>
		<td align="center">${register.balanceBF.lamivudineTabs150mg}</td>
		<td align="center">${register.balanceBF.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${register.balanceBF.nelfinavirTabs250mg}</td>
		<td align="center">${register.balanceBF.nevirapineTabs200mg}</td>
		<td align="center">${register.balanceBF.stavudineTabs_Caps30mg}</td>
		<td align="center">${register.balanceBF.stavudineTabs_Caps40mg}</td>
		<td align="center">${register.balanceBF.tenofovirTabs_caps300mg}</td>
		<td align="center">${register.balanceBF.zidovudineTabs300mg}</td>
	</tr>
    <tr>
        <th colspan="6" align="right">Quantity Received (B)</th>
        <th>&nbsp;</th>
        <td align="center">${register.received.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${register.received.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${register.received.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${register.received.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${register.received.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${register.received.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${register.received.abacavirTabs300mg}</td>
		<td align="center">${register.received.didanosineTabs200mg}</td>
		<td align="center">${register.received.didanosineTabs100mg}</td>
		<td align="center">${register.received.didanosineTabs50mg}</td>
		<td align="center">${register.received.efavirenzTabs600mg}</td>
		<td align="center">${register.received.efavirenzTabs_caps200mg}</td>
		<td align="center">${register.received.lamivudineTabs150mg}</td>
		<td align="center">${register.received.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${register.received.nelfinavirTabs250mg}</td>
		<td align="center">${register.received.nevirapineTabs200mg}</td>
		<td align="center">${register.received.stavudineTabs_Caps30mg}</td>
		<td align="center">${register.received.stavudineTabs_Caps40mg}</td>
		<td align="center">${register.received.tenofovirTabs_caps300mg}</td>
		<td align="center">${register.received.zidovudineTabs300mg}</td>
	</tr>
    <tr>
        <th colspan="6" align="right">Stock on Hand (Balance B/F plus Quantity Received)<br/>(C= A + B)</th>
        <th>&nbsp;</th>
		<td align="center">${register.onHand.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${register.onHand.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${register.onHand.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${register.onHand.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${register.onHand.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${register.onHand.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${register.onHand.abacavirTabs300mg}</td>
		<td align="center">${register.onHand.didanosineTabs200mg}</td>
		<td align="center">${register.onHand.didanosineTabs100mg}</td>
		<td align="center">${register.onHand.didanosineTabs50mg}</td>
		<td align="center">${register.onHand.efavirenzTabs600mg}</td>
		<td align="center">${register.onHand.efavirenzTabs_caps200mg}</td>
		<td align="center">${register.onHand.lamivudineTabs150mg}</td>
		<td align="center">${register.onHand.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${register.onHand.nelfinavirTabs250mg}</td>
		<td align="center">${register.onHand.nevirapineTabs200mg}</td>
		<td align="center">${register.onHand.stavudineTabs_Caps30mg}</td>
		<td align="center">${register.onHand.stavudineTabs_Caps40mg}</td>
		<td align="center">${register.onHand.tenofovirTabs_caps300mg}</td>
		<td align="center">${register.onHand.zidovudineTabs300mg}</td>
	</tr>
    <tr>
        <th>Date Visit</th>
        <th width="120px">Client No.</th>
        <th width="120px">Client&nbsp;name</th>
        <th title="Age:- C for Child (<=14 Yrs) or A for Adults (>14 yrs)">Child or Adult</th>
        <th title="New Client (N) or Revisit (R)">New or Revisit</th>
        <th title="Dispensing pharmacist (Signature)">Pharmacist</th>
        <th colspan="21"></th>
	</tr>

<c:set var="smRegisterString" value="unknown"/>
<c:set var="patientName" value="unknown"/>
<logic:iterate id="patient" name="register" property="patients" indexId="cnt">
	<tr>
    	<td align="center" class="small" width="50px;"><fmt:formatDate type="date" pattern="dd/MM/yyyy" value="${patient.dateVisit}"/></td>
    	<td align="center" >${patient.clientId}</td>
        <td align="center" class="small" width="120px">
		<c:url value="patientTask.do" var="dispensing"><c:param name="patientId" value="${patient.patientId}"/>
    	<c:param name="flowId" value="2"/>
    	</c:url>
        <a href='<c:out value="/${appName}/${dispensing}"/>'>${patient.surname}, ${patient.firstName}</a>
	   	</td>
	   	<td align="center">${patient.childOrAdult}</td>
	   	<td align="center"><c:if test="${patient.revisit == true}">R</c:if><c:if test="${patient.revisit == false}">N</c:if></td>
	   	<td align="center">${patient.pharmacist}</td>
	   	<td align="center">${patient.arvRegimenCode}</td>
	   	<td align="center">${patient.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${patient.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${patient.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${patient.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${patient.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${patient.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${patient.abacavirTabs300mg}</td>
		<td align="center">${patient.didanosineTabs200mg}</td>
		<td align="center">${patient.didanosineTabs100mg}</td>
		<td align="center">${patient.didanosineTabs50mg}</td>
		<td align="center">${patient.efavirenzTabs600mg}</td>
		<td align="center">${patient.efavirenzTabs_caps200mg}</td>
		<td align="center">${patient.lamivudineTabs150mg}</td>
		<td align="center">${patient.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${patient.nelfinavirTabs250mg}</td>
		<td align="center">${patient.nevirapineTabs200mg}</td>
		<td align="center">${patient.stavudineTabs_Caps30mg}</td>
		<td align="center">${patient.stavudineTabs_Caps40mg}</td>
		<td align="center">${patient.tenofovirTabs_caps300mg}</td>
		<td align="center">${patient.zidovudineTabs300mg}</td>
	</tr>
</logic:iterate>
	    <tr>
	        <th colspan="6" align="right">Total Quantity Dispensed (D)</th>
	        <th>&nbsp;</th>
	        <td align="center">${register.totalDispensed.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${register.totalDispensed.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${register.totalDispensed.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${register.totalDispensed.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${register.totalDispensed.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${register.totalDispensed.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${register.totalDispensed.abacavirTabs300mg}</td>
		<td align="center">${register.totalDispensed.didanosineTabs200mg}</td>
		<td align="center">${register.totalDispensed.didanosineTabs100mg}</td>
		<td align="center">${register.totalDispensed.didanosineTabs50mg}</td>
		<td align="center">${register.totalDispensed.efavirenzTabs600mg}</td>
		<td align="center">${register.totalDispensed.efavirenzTabs_caps200mg}</td>
		<td align="center">${register.totalDispensed.lamivudineTabs150mg}</td>
		<td align="center">${register.totalDispensed.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${register.totalDispensed.nelfinavirTabs250mg}</td>
		<td align="center">${register.totalDispensed.nevirapineTabs200mg}</td>
		<td align="center">${register.totalDispensed.stavudineTabs_Caps30mg}</td>
		<td align="center">${register.totalDispensed.stavudineTabs_Caps40mg}</td>
		<td align="center">${register.totalDispensed.tenofovirTabs_caps300mg}</td>
		<td align="center">${register.totalDispensed.zidovudineTabs300mg}</td>
	</tr>
	    <tr>
	        <th colspan="6" align="right">Losses (E)</th>
	        <th>&nbsp;</th>
	        <td align="center">${register.losses.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${register.losses.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${register.losses.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${register.losses.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${register.losses.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${register.losses.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${register.losses.abacavirTabs300mg}</td>
		<td align="center">${register.losses.didanosineTabs200mg}</td>
		<td align="center">${register.losses.didanosineTabs100mg}</td>
		<td align="center">${register.losses.didanosineTabs50mg}</td>
		<td align="center">${register.losses.efavirenzTabs600mg}</td>
		<td align="center">${register.losses.efavirenzTabs_caps200mg}</td>
		<td align="center">${register.losses.lamivudineTabs150mg}</td>
		<td align="center">${register.losses.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${register.losses.nelfinavirTabs250mg}</td>
		<td align="center">${register.losses.nevirapineTabs200mg}</td>
		<td align="center">${register.losses.stavudineTabs_Caps30mg}</td>
		<td align="center">${register.losses.stavudineTabs_Caps40mg}</td>
		<td align="center">${register.losses.tenofovirTabs_caps300mg}</td>
		<td align="center">${register.losses.zidovudineTabs300mg}</td>
		</tr>
	    <tr>
	        <th colspan="6" align="right">Balance CF (G)</th>
	        <th>&nbsp;</th>
		<td align="center">${register.balanceCF.stavudine_LamivudineFDCTabs_30_150mg}</td>
		<td align="center">${register.balanceCF.stavudine_LamivudineFDCTabs_40_150mg}</td>
		<td align="center">${register.balanceCF.stavudine_Lamivudine_NevirapineFDCTabs_30_150_200mg}</td>
		<td align="center">${register.balanceCF.stavudine_Lamivudine_NevirapineFDCTabs_40_150_200mg}</td>
		<td align="center">${register.balanceCF.zidovudine_LamivudineTabs_capsFDC_300_150mg}</td>
		<td align="center">${register.balanceCF.zidovudine_Lamivudine_NevirapineTabs_capsFDC_300_150_200mg}</td>
		<td align="center">${register.balanceCF.abacavirTabs300mg}</td>
		<td align="center">${register.balanceCF.didanosineTabs200mg}</td>
		<td align="center">${register.balanceCF.didanosineTabs100mg}</td>
		<td align="center">${register.balanceCF.didanosineTabs50mg}</td>
		<td align="center">${register.balanceCF.efavirenzTabs600mg}</td>
		<td align="center">${register.balanceCF.efavirenzTabs_caps200mg}</td>
		<td align="center">${register.balanceCF.lamivudineTabs150mg}</td>
		<td align="center">${register.balanceCF.lopinavir_ritonavirTabs_caps133}</td>
		<td align="center">${register.balanceCF.nelfinavirTabs250mg}</td>
		<td align="center">${register.balanceCF.nevirapineTabs200mg}</td>
		<td align="center">${register.balanceCF.stavudineTabs_Caps30mg}</td>
		<td align="center">${register.balanceCF.stavudineTabs_Caps40mg}</td>
		<td align="center">${register.balanceCF.tenofovirTabs_caps300mg}</td>
		<td align="center">${register.balanceCF.zidovudineTabs300mg}</td>
	</tr>
	<tr>
        <td colspan="26">&nbsp;</td>
    </tr>
    <tr>
	    <th colspan="1">TOTAL ADULTS</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.totalAdults}</td>
	    <th colspan="2" rowspan="2">NUMBER OF PATIENTS <br/>PER A.R.T. REGIMEN</th>
	    <th>1A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen1A}</td>
	    <th>&nbsp;</th>
	    <th>2A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen2A}</td>
	    <th>3A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen3A}</td>
	    <th>4A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen4A}</td>
	    <th>5A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen5A}</td>
	    <th>6A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen6A}</td>
	    <th>7A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen7A}</td>
	    <th>PEP</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPEP1}</td>
	    <th>PEP2B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPEP2B}</td>
	    <th>PMTCT 1C</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPMTCT_1C}</td>
	    <th>PMTCT 1M</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPMTCT_1M}</td>
    </tr>
    <tr>
	    <th colspan="2">&nbsp;</th>
	    <th>1B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen1B}</td>
	    <th>&nbsp;</th>
	    <th>2B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen2B}</td>
	    <th>3B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen3B}</td>
	    <th>4B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen4B}</td>
	    <th>5B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen5B}</td>
	    <th>6B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen6B}</td>
	    <th>7B</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimen7B}</td>
	    <th>PEP2A</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPEP2A}</td>
	    <th>PEP3</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPEP3}</td>
	    <th>PMTCT 2C</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPMTCT_2C}</td>
	    <th>PMTCT 2M</th><td style="vertical-align : middle; text-align: center">${register.artRegimenReport.regimenPMTCT_2M}</td>
    </tr>
</table>

</template:put>
</template:insert>

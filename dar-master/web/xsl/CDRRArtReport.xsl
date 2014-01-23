<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:dt="http://xsltsl.org/date-time">
    <xsl:import href="utils/stdlib.xsl"/>
    <xsl:output method="html" encoding="UTF-8" media-type="text/html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>CDRR-ART Report</title>
 <style type="text/css">
    body {
   }
	.reportTablePrint{
		border-collapse:collapse;
	    font-family:Arial, sans-serif;
	mso-font-charset:0;
	font-size:10.0pt;
	}
	.reportTablePrint td {
		border-top:.5pt solid windowtext;
		border-right:.5pt solid windowtext;
		border-bottom:.5pt solid windowtext;
		border-left:.5pt solid windowtext;
	}
	.reportTablePrint th {
		border-right:.2pt solid windowtext;
		vertical-align : middle;
	}

	.header {
	}

	.headerCell th {
		border-top:.5pt solid windowtext;
		border-right:.5pt solid windowtext;
		border-bottom:.5pt solid windowtext;
		border-left:.5pt solid windowtext;
	}
	.headerCell td {
		border-top:.5pt solid windowtext;
		border-right:.5pt solid windowtext;
		border-bottom:.5pt solid windowtext;
		border-left:.5pt solid windowtext;
	}
	.units {
		border-top:.5pt solid windowtext;
		border-right:1.0pt solid windowtext;
		border-bottom:.5pt solid windowtext;
		border-left:.5pt solid windowtext;
	}
	.reportTablePrint th {
		vertical-align : middle;
		border:1px solid #000;
		}
	.category {
		border:1px solid #000;
		background-color:#ddd;
		text-align:left;
		padding-left:2em;
	}
	.categoryHeader {
		border:1px solid #000;
		background-color:#ddd;
		padding-left:2em;
	}
 	    </style>
            </head>
<body>
<table border="0" class="header" width="650px">
<tr>
	<th colspan="15" class="headerCell">MINISTRY OF HEALTH</th>
</tr>
<tr>
	<th colspan="15" class="headerCell">FACILITY CONSUMPTION DATA REPORT AND REQUEST FOR ANTIRETROVIRAL DRUGS</th>
</tr>
<tr>
<th colspan="15" class="headerCell"></th>
</tr>
<tr>
	<th class="headerCell" align="left">ART Program Sponsor:</th>
	<td colspan="4"  style="border: 1px solid gray;" >KEMSA</td>
	<td colspan="10" class="headerCell"></td>
</tr>
<tr>
	<th class="headerCell" align="left">Facility Name:</th>
	<td colspan="4" style="border: 1px solid gray;"><xsl:value-of select="CDRRArtReport/siteName"/></td>
	<td colspan="10" class="headerCell"></td>
</tr>
<tr>
	<th align="left">Province:</th>
	<td colspan="4" style="border: 1px solid gray;" >Nairobi</td>
	<td colspan="4"></td>
	<th colspan="2">District</th>
	<td colspan="3" style="border: 1px solid gray;"></td>
	<td></td>
</tr>
<tr>
	<th align="left">Period of Reporting:  Beginning:</th>
	<td colspan="4" align="left" style="border: 1px solid gray;" ><xsl:value-of select="CDRRArtReport/beginDate"/></td>
	<td colspan="4"></td>
	<th colspan="2">Ending:</th>
	<td colspan="3" align="left" style="border: 1px solid gray;" ><xsl:value-of select="CDRRArtReport/endDate"/></td>
	<td></td>
</tr>
<tr>
	<th colspan="15"></th>
</tr>
</table>
<table border="0" class="reportTablePrint" width="650px">
<tr>
<th rowspan="3">Drug Name</th>
<th rowspan="3">Basic<br/>Units</th>
<th rowspan="2">Beginning<br/>Balance</th>
<th rowspan="2">Quantity<br/>Received<br/>this period</th>
<th rowspan="2">Total<br/>Quantity<br/>dispensed</th>
<th rowspan="2">Losses</th>
<th rowspan="2">Positive<br/>Adjustments</th>
<th rowspan="2">Negative<br/>Adjustments</th>
<th rowspan="2">Ending<br/>Balance/<br/>Physical<br/>Count</th>
<th colspan="2">Drugs with<br/>less than<br/>6 months<br/>to expiry</th>
<th rowspan="2">Days out<br/>of stock</th>
<th rowspan="2">Quantity<br/>required for<br/>Re-supply</th>
<th rowspan="2">Quantity<br/>required for<br/>New<br/>patients</th>
<th rowspan="2">Total<br/>Quantity<br/>Required</th>
</tr>
<tr>
<td>Quantity</td>
<td>Expiry Date</td>
</tr>
<tr>
<th>A</th>
<th>B</th>
<th>C</th>
<th>D</th>
<th>E</th>
<th>F</th>
<th>G = A+B-C-<br/>D+E-F</th>
<th> </th>
<th> </th>
<th>H</th>
<th>I</th>
<th>J</th>
<th>K</th>
</tr>
<tr>
<th colspan="15" class="categoryHeader">Adult Preparations</th>
</tr>
<tr>
<th colspan="15" class="category">Fixed Dose Combination drugs (FDCs)</th>
</tr>
<tr>
	<td>Stavudine/Lamivudine FDC<br />
	(30/150mg)</td>
	<td>Tablet</td>
	<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__LamivudineFDCTabs__30__150mg"/>
	</td>
	<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__LamivudineFDCTabs__30__150mg"/></td>
	<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__LamivudineFDCTabs__30__150mg"/></td>
</tr>
<tr>
<td>Stavudine/Lamivudine FDC<br />
(40/150mg)</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__LamivudineFDCTabs__40__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__LamivudineFDCTabs__40__150mg"/></td>
</tr>
<tr>
<td>Stavudine/Lamivudine/Nevirapine<br/>
FDC (30/150/200mg)</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__Lamivudine__NevirapineFDCTabs__30__150__200mg"/></td>
</tr>
<tr>
	<!--value="3"-->
<td>Stavudine/Lamivudine/Nevirapine<br />
FDC (40/150/200mg)</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__Lamivudine__NevirapineFDCTabs__40__150__200mg"/></td>
</tr>
<tr>
	<!-- value="5" -->
<td>Zidovudine/Lamivudine<br />
FDC (300/150mg)</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/zidovudine__LamivudineTabs__capsFDC__300__150mg"/></td>
</tr>
<tr>
	<!-- value="6" -->
<td>Zidovudine/Lamivudine/Nevirapine<br />
FDC (300/150/200mg)</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/zidovudine__Lamivudine__NevirapineTabs__capsFDC__300__150__200mg"/></td>
</tr>
<tr>
<th colspan="15" class="category">Fixed Dose Combination drugs (FDCs)</th>
</tr>
<tr>
	<!-- value="7" -->
<td>Abacavir 300mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/abacavirTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/abacavirTabs300mg"/></td>
</tr>
<tr>
	<!-- value="9" -->
<td>Didanosine 200mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/didanosineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/didanosineTabs200mg"/></td>
</tr>
<tr>
	<!-- value="8" -->
<td>Didanosine 100mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/didanosineTabs100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/didanosineTabs100mg"/></td>
</tr>
<tr>
	<!-- value="10" -->
<td>Didanosine 50mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/didanosineTabs50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/didanosineTabs50mg"/></td>
</tr>

<tr>
	<!-- value="11" -->
<td>Efavirenz 200mg</td>
<td>Capsule</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/efavirenzTabs__caps200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/efavirenzTabs__caps200mg"/></td>
</tr>

<tr>
	<!-- value="12" -->
<td>Efavirenz 600mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/efavirenzTabs600mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/efavirenzTabs600mg"/></td>
</tr>

<tr>
	<!-- value="13" -->
<td>Lamivudine 150mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/lamivudineTabs150mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/lamivudineTabs150mg"/></td>
</tr>
<tr>
	<!-- value="14" -->
<td>Lopinavir/ritonavir<br />
133.3/33.3mg</td>
<td>Capsule</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/lopinavir__ritonavirTabs__caps133"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/lopinavir__ritonavirTabs__caps133"/></td>
</tr>
<tr>
	<!-- value="15" -->
<td>Nelfinavir 250mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/nelfinavirTabs250mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/nelfinavirTabs250mg"/></td>
</tr>
<tr>
	<!-- value="16" -->
<td>Nevirapine 200mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/nevirapineTabs200mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/nevirapineTabs200mg"/></td>
</tr>
<tr>
	<!-- value="17" -->
<td>Stavudine 30mg</td>
<td>Tab/Cap</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudineTabs__Caps30mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudineTabs__Caps30mg"/></td>
</tr>
<tr>
	<!-- value="18" -->
<td>Stavudine 40mg</td>
<td>Tab/Cap</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudineTabs__Caps40mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudineTabs__Caps40mg"/></td>
</tr>
<tr>
	<!-- value="19" -->
<td>Tenofovir 300mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/tenofovirTabs__caps300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/tenofovirTabs__caps300mg"/></td>
</tr>
<tr>
	<!-- value="20" -->
<td>Zidovudine 300mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/zidovudineTabs300mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/zidovudineTabs300mg"/></td>
</tr>
<tr>
<th colspan="15" class="categoryHeader">Paediatric Preparations</th>
</tr>
<tr>
	<!-- value="21" -->
<td>Abacavir liquid 20mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/abacavir__liquid__20mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/abacavir__liquid__20mg__ml"/></td>
</tr>
<tr>
	<!-- value="22" -->
<td>Didanosine 25mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/didanosine__Tabs__caps__25mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/didanosine__Tabs__caps__25mg"/></td>
</tr>
<tr>
	<!-- value="23" -->
<td>Didanosine liquid 10mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/didanosine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/didanosine__liquid__10mg__ml"/></td>
</tr>
<tr>
	<!-- value="24" -->
<td>Efavirenz 50mg</td>
<td>Capsule</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/efavirenz__Tabs__50mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/efavirenz__Tabs__50mg"/></td>
</tr>
<tr>
	<!-- value="25" -->
<td>Efavirenz liquid 30mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/efavirenz__liquid__30mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/efavirenz__liquid__30mg__ml"/></td>
</tr>
<tr>
	<!-- value="26" -->
<td>Lamivudine liquid 10mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/lamivudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/lamivudine__liquid__10mg__ml"/></td>
</tr>
<tr>
	<!-- value="27" -->
<td>Lopinavir/ritonavir liquid 80/20mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/lopinavir__ritonavir__liquid__80"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/lopinavir__ritonavir__liquid__80"/></td>
</tr>
<tr>
	<!-- value="28" -->
<td>Nelfinavir powder 50mg/1.25ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/nelfinavir__powder__50mg__125ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/nelfinavir__powder__50mg__125ml"/></td>
</tr>
<tr>
	<!-- value="29" -->
<td>Nevirapine susp 10mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/nevirapine__susp__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/nevirapine__susp__10mg__ml"/></td>
</tr>
<tr>
	<!-- value="30" -->
<td>Stavudine 15mg</td>
<td>Capsule</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__Tabs__caps__15mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__Tabs__caps__15mg"/></td>
</tr>
<tr>
	<!-- value="31" -->
<td>Stavudine 20mg</td>
<td>Capsule</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__Tabs__caps__20mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__Tabs__caps__20mg"/></td>
</tr>
<tr>
	<!-- value="32" -->
<td>Stavudine liquid, 1mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/stavudine__liquid__1mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/stavudine__liquid__1mg__ml"/></td>
</tr>
<tr>
<td>Zidovudine 100mg</td>
<td>Tablet</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/zidovudine__Tabs__caps__100mg"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/zidovudine__Tabs__caps__100mg"/></td>
</tr>
<tr>
<td>Zidovudine liquid 10mg/ml</td>
<td>Bottle</td>
<td align="center"><xsl:value-of select="CDRRArtReport/balanceBF/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/received/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalDispensed/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/losses/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/posAdjustments/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/negAdjustments/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/onHand/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantity6MonthsExpired/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/expiryDate/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/daysOutOfStock/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredResupply/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/quantityRequiredNewPatients/zidovudine__liquid__10mg__ml"/></td>
<td align="center"><xsl:value-of select="CDRRArtReport/totalQuantityRequired/zidovudine__liquid__10mg__ml"/></td>
</tr>
	</table>
<p>
</p>
<table border="0" cellpadding="3" width="75%">
<tr>
<th colspan="9" align="left">Comments (including explanation of losses and adjustments): </th>
</tr>
<tr>
	<td colspan="8" rowspan="3" style="border: 1px solid gray;"><!--nbsp--></td>
	<td><!--nbsp--></td>
</tr>

<tr>
	<td><!--nbsp--></td>
</tr>
<tr>
	<td><!--nbsp--></td>
</tr>
<tr>
	<td colspan="9"><!--nbsp--></td>
</tr>

<tr>
	<td>Report submitted by: </td>
	<td style="border: 1px solid gray;" colspan="2"><xsl:value-of select="CDRRArtReport/reportCreator/lastnameR"/>, <xsl:value-of select="CDRRArtReport/reportCreator/firstnameR"/></td>
	<td><!--nbsp--></td>
	<td>Designation: </td>
	<td><!--nbsp--></td>
	<td style="border: 1px solid gray;" colspan="2"><!--nbsp--></td>
	<td colspan="1"><!--nbsp--></td>
</tr>
<tr>
	<td><!--nbsp--></td>
	<td colspan="3">Name of Reporting officer</td>
	<td colspan="4"><!--nbsp--></td>
</tr>

<tr>
	<td>Contact Telephone:</td>
	<td style="border: 1px solid gray;" colspan="2"><xsl:value-of select="CDRRArtReport/reportCreator/mobileR"/></td>
	<td><!--nbsp--></td>
	<td>Date: </td>
	<td><!--nbsp--></td>
	<td style="border: 1px solid gray;" colspan="2"><xsl:value-of select="CDRRArtReport/reportDate"/></td>
	<td colspan="1"><!--nbsp--></td>
</tr>

<tr>
	<td>Report received by: </td>
	<td style="border: 1px solid gray;" colspan="2"><!--nbsp--></td>
	<td><!--nbsp--></td>
	<td>Designation: </td>
	<td><!--nbsp--></td>
	<td style="border: 1px solid gray;" colspan="2"><!--nbsp--></td>
	<td colspan="1"><!--nbsp--></td>
</tr>

<tr>
	<td><!--nbsp--></td>
	<td colspan="3">Head of Institution</td>
	<td colspan="4"><!--nbsp--></td>
</tr>

<tr>
	<td>Contact Telephone:</td>
	<td style="border: 1px solid gray;" colspan="2"><!--nbsp--></td>
	<td><!--nbsp--></td>
	<td>Date: </td>
	<td><!--nbsp--></td>
	<td style="border: 1px solid gray;" colspan="2"><!--nbsp--></td>
	<td colspan="1"><!--nbsp--></td>
</tr>
	</table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
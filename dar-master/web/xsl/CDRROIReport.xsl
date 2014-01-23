<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:dt="http://xsltsl.org/date-time">
    <xsl:import href="utils/stdlib.xsl"/>
    <xsl:output method="html" encoding="UTF-8" media-type="text/html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>CDRR-OI Report</title>
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
 	    </style>
            </head>
<body>

<table border="0" class="header" width="650px">
<tr>
	<th colspan="15" class="headerCell">MINISTRY OF HEALTH</th>
</tr>
<tr>
	<th colspan="15" class="headerCell">CONSUMPTION DATA REPORT AND REQUEST FOR DRUGS FOR OPPORTUNISTIC INFECTIONS (OIs)</th>
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
	<td colspan="4" style="border: 1px solid gray;"><xsl:value-of select="CDRROIReport/siteName"/></td>
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
	<td colspan="4" align="left" style="border: 1px solid gray;" ><xsl:value-of select="CDRROIReport/beginDate"/></td>
	<td colspan="4"></td>
	<th colspan="2">Ending:</th>
	<td colspan="3" align="left" style="border: 1px solid gray;" ><xsl:value-of select="CDRROIReport/endDate"/></td>
	<td></td>
</tr>
<tr>
	<th colspan="15"></th>
</tr>
</table>
<table border="0" class="reportTablePrint" width="650px">
<tr>
<th rowspan="3">Drug Name</th>
<th rowspan="3" class="units">Basic<br/>Units</th>
<th rowspan="2" width="20px">Beginning<br/>Balance</th>
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
<th colspan="15" class="category">AntiFungals</th>
</tr>
<tr>
	<td>Diflucan 200mg</td>
	<td class="units">Tablets</td>
	<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/diflucan200mg"/>
	</td>
	<td align="center"><xsl:value-of select="CDRROIReport/received/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/losses/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/onHand/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/diflucan200mg"/></td>
	<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/diflucan200mg"/></td>
</tr>
<tr>
<td>Diflucan suspension (bottles)</td>
<td></td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/diflucansuspension"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/diflucansuspension"/></td>
</tr>
<tr>
<td>Diflucan Infusion (bottles)</td>
<td></td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/diflucanInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/diflucanInfusion"/></td>
</tr>
<tr>
	<!--value="3"-->
<td>Fluconazole 200mg</td>
<td>Tabs/caps</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/fluconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/fluconazole200mg"/></td>
</tr>
<tr>
	<!-- value="5" -->
<td>Fluconazole 150mg</td>
<td>Tabs/caps</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/fluconazole150mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/fluconazole150mg"/></td>
</tr>


<tr>
	<!-- value="6" -->
<td>Fluconazole 50mg</td>
<td>Tabs/caps</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/fluconazole50mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/fluconazole50mg"/></td>
</tr>

<tr>
	<!-- value="6" -->
<td>Ketaconazole 200mg</td>
<td>Tablets</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/ketaconazole200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/ketaconazole200mg"/></td>
</tr>

<tr>
	<!-- value="6" -->
<td>Miconazole Nitrate 2% Oral Gel</td>
<td>Tube</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/miconazoleNitrate2OralGel"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/miconazoleNitrate2OralGel"/></td>
</tr>

<tr>
	<!-- value="6" -->
<td>Nystatin Oral Suspension 100,000 Units</td>
<td></td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/nystatinOralSuspension100000Units"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/nystatinOralSuspension100000Units"/></td>
</tr>

<tr>
	<!-- value="6" -->
<td>Amphotericin B Injection</td>
<td>Vials</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/amphotericinBInjection"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/amphotericinBInjection"/></td>
</tr>

<tr>
<th colspan="15" class="category">AntiBacterials</th>
</tr>

<tr>
	<!-- value="7" -->
<td>Cotrimoxazole susp 240mg/5ml (bottles)</td>
<td></td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/cotrimoxazolesusp240mg_5ml"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/cotrimoxazolesusp240mg_5ml"/></td>
</tr>
<tr>
	<!-- value="9" -->
<td>Cotrimoxazole 480mg</td>
<td>Tablets</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/cotrimoxazoleTabs480mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/cotrimoxazoleTabs480mg"/></td>
</tr>
<tr>
	<!-- value="8" -->
<td>Cotrimoxazole DS 960mg</td>
<td>Tablets</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/cotrimoxazoleDS960mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/cotrimoxazoleDS960mg"/></td>
</tr>
<tr>
	<!-- value="10" -->
<td>Ciprofloxacin Tabs 500mg</td>
<td>Tabs/caps</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/ciprofloxacinTabs500mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/ciprofloxacinTabs500mg"/></td>
</tr>
<tr>
	<!-- value="12" -->
<td>Ceftriaxone Inj. 250mg IM</td>
<td>Vials</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/ceftriaxoneInj250mgIM"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/ceftriaxoneInj250mgIM"/></td>
</tr>

<tr>
<th colspan="15" class="category">AntiProtozoal Drugs</th>
</tr>

<tr>
	<!-- value="11" -->
<td>Aminosidine Sulphate liquid (bottles)</td>
<td></td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/aminosidineSulphateliquid"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/aminosidineSulphateliquid"/></td>
</tr>
<tr>
	<!-- value="13" -->
<td>Aminosidine Sulphate</td>
<td>Tablets</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/aminosidineSulphate"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/aminosidineSulphate"/></td>
</tr>

<tr>
<th colspan="15" class="category">AntiVirals </th>
</tr>

<tr>
	<!-- value="14" -->
<td>Acyclovir 200mg</td>
<td>Tablets</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/acyclovir200mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/acyclovir200mg"/></td>
</tr>
<tr>
	<!-- value="15" -->
<td>Acyclovir IV Infusion</td>
<td>Vials</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/acyclovirIVInfusion"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/acyclovirIVInfusion"/></td>
</tr>

<tr>
<th colspan="15" class="category">Others</th>
</tr>

<tr>
	<!-- value="16" -->
<td>Pyridoxine 25mg</td>
<td>Tabs/caps</td>
<td align="center"><xsl:value-of select="CDRROIReport/balanceBF/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/received/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalDispensed/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/losses/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/posAdjustments/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/negAdjustments/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/onHand/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantity6MonthsExpired/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/expiryDate/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/daysOutOfStock/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredResupply/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/quantityRequiredNewPatients/pyridoxine25mg"/></td>
<td align="center"><xsl:value-of select="CDRROIReport/totalQuantityRequired/pyridoxine25mg"/></td>
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
	<td style="border: 1px solid gray;" colspan="2"><xsl:value-of select="CDRROIReport/reportCreator/lastnameR"/>, <xsl:value-of select="CDRROIReport/reportCreator/firstnameR"/></td>
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
	<td style="border: 1px solid gray;" colspan="2"><xsl:value-of select="CDRROIReport/reportCreator/mobileR"/></td>
	<td><!--nbsp--></td>
	<td>Date: </td>
	<td><!--nbsp--></td>
	<td style="border: 1px solid gray;" colspan="2"><xsl:value-of select="CDRROIReport/reportDate"/></td>
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
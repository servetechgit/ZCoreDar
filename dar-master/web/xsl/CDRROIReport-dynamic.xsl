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
 <xsl:for-each select="CDRROIReport/drugReportList/*">
 	<tr>
        <td><xsl:value-of select="name"/></td>
        <td><xsl:value-of select="item/unit"/></td>
	<td align="center"><xsl:value-of select="balanceBF"/></td>
	<td align="center"><xsl:value-of select="received"/></td>
	<td align="center"><xsl:value-of select="totalDispensed"/></td>
	<td align="center"><xsl:value-of select="losses"/></td>
	<td align="center"><xsl:value-of select="posAdjustments"/></td>
	<td align="center"><xsl:value-of select="negAdjustments"/></td>
	<td align="center"><xsl:value-of select="onHand"/></td>
	<td align="center"><xsl:value-of select="quantity6MonthsExpired"/></td>
	<td align="center"><xsl:value-of select="expiryDate"/></td>
	<td align="center"><xsl:value-of select="daysOutOfStock"/></td>
	<td align="center"><xsl:value-of select="quantityRequiredResupply"/></td>
	<td align="center"><xsl:value-of select="quantityRequiredNewPatients"/></td>
	<td align="center"><xsl:value-of select="totalQuantityRequired"/></td>
    </tr>
 </xsl:for-each>
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
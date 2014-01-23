<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:dt="http://xsltsl.org/date-time"
                xmlns:s="urn:schemas-microsoft-com:office:spreadsheet">
    <xsl:import href="utils/stdlib.xsl"/>
    <xsl:output method="html" encoding="UTF-8" media-type="text/html"/>
    <xsl:template match="/">
         <html xmlns:o="urn:schemas-microsoft-com:office:office"
        xmlns:x="urn:schemas-microsoft-com:office:excel"
               xmlns:s="urn:schemas-microsoft-com:office:spreadsheet"
           xmlns="http://www.w3.org/TR/REC-html40">
            <head>
                <title>Monthly ART Report</title>
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

<table border="0" class="header" width="550px" x:worksheet="Monthly ART Summary">
<tr>
	<th colspan="5" class="headerCell">MINISTRY OF HEALTH</th>
</tr>
<tr>
	<th colspan="5" class="headerCell">MONTHLY A.R.T PATIENT SUMMARY REPORT</th>
</tr>
<tr>
<th colspan="15" class="headerCell"></th>
</tr>
<tr>
	<th class="headerCell" align="left">ART Program Sponsor:</th>
	<td style="border: 1px solid gray;" >KEMSA</td>
	<td colspan="3" class="headerCell"></td>
</tr>
<tr>
	<th class="headerCell" align="left">Facility Name:</th>
	<td style="border: 1px solid gray;"><xsl:value-of select="MonthlyArtReport/siteName"/></td>
	<td></td>
	<th>A.R.T Facility code:</th>
	<td style="border: 1px solid gray;"></td>
</tr>
<tr>
	<th align="left">Province:</th>
	<td style="border: 1px solid gray;" >Nairobi</td>
	<td></td>
	<th>District</th>
	<td style="border: 1px solid gray;"></td>
</tr>
<tr>
	<th align="left">Period of Reporting:  Beginning:</th>
	<td align="left" style="border: 1px solid gray;" ><xsl:value-of select="MonthlyArtReport/beginDate"/></td>
	<td></td>
	<th>Ending:</th>
	<td align="left" style="border: 1px solid gray;" ><xsl:value-of select="MonthlyArtReport/endDate"/></td>
</tr>
<tr>
	<th colspan="15"></th>
</tr>
</table>
<table border="0" class="reportTablePrint" width="650px">
<tr>
        <th>Regimen Code</th>
        <th title="Shows the various combinations of ARV drugs into ART treatment regimens. Weight bands and the drug strengths are used to differentiate between the regimens. Each regimen is coded.">Treatment Regimen<br/>(strength of dosage forms for adults are indicated)</th>
        <th title="Shows the total number of patients who are currently following each treatment regimen. ">Current No. of Patients on regimen this month</th>
        <th title="The estimated number of new patients who will start ART in the following month. The number of patients and their treatment regimens can be provided by the HIV clinic prescribers/staff (e.g. from the Pre-ART and ART registers). If an ART eligibility committee exists in the facility, it may also provide this information.
The pharmacy should discuss this with the HIV clinic. Kindly inform them that this information is important for purposes of planning your stock orders and forecasting your requirements.
Take into consideration the current number of patients being assessed for eligibility for ART, changes in patient numbers from one regimen to another, and service capacity of the facility.">Estimated No. of New Patients expected to be on this regimen next month</th>
		<th title="The total estimated number is automatically calculated as follows: The current number of patients plus the number of estimated New patients. Total Estimated Number of Patients on ART Next Month = A + B">Total Estimated No. of Patients on ART next month</th>
    </tr>
	<tr>
        <td colspan="2"></td>
        <td>A</td>
        <td>B</td>
		<td>A+B</td>
    </tr>
 <xsl:for-each select="MonthlyArtReport/regimenList/*">
 	<tr>
        <td><xsl:value-of select="code"/></td>
        <td><xsl:value-of select="name"/></td>
        <td><xsl:value-of select="countInt"/></td>
        <td><xsl:value-of select="newEstimatedArtPatients"/></td>
        <td><xsl:value-of select="totalEstimatedArtPatients"/></td>
    </tr>
 </xsl:for-each>
</table>
<p>
</p>
<table border="0" cellpadding="3" width="75%">
<tr>
	<td>Report submitted by: </td>
	<td style="border: 1px solid gray;"><xsl:value-of select="MonthlyArtReport/reportCreator/lastnameR"/>, <xsl:value-of select="MonthlyArtReport/reportCreator/firstnameR"/></td>
	<td><!--nbsp--></td>
	<td>Designation: </td>
	<td style="border: 1px solid gray;"><!--nbsp--></td>
</tr>
<tr>
	<td><!--nbsp--></td>
	<td>Name of Reporting officer</td>
	<td colspan="3"><!--nbsp--></td>
</tr>

<tr>
	<td>Contact Telephone:</td>
	<td style="border: 1px solid gray;"><xsl:value-of select="MonthlyArtReport/reportCreator/mobileR"/></td>
	<td><!--nbsp--></td>
	<td>Date: </td>
	<td style="border: 1px solid gray;"><xsl:value-of select="MonthlyArtReport/reportDate"/></td>
</tr>

<tr>
	<td>Report received by: </td>
	<td style="border: 1px solid gray;"><!--nbsp--></td>
	<td><!--nbsp--></td>
	<td>Designation: </td>
	<td style="border: 1px solid gray;"><!--nbsp--></td>
	<td colspan="1"><!--nbsp--></td>
</tr>

<tr>
	<td><!--nbsp--></td>
	<td>Head of Institution</td>
	<td colspan="3"><!--nbsp--></td>
</tr>

<tr>
	<td>Contact Telephone:</td>
	<td style="border: 1px solid gray;"><!--nbsp--></td>
	<td><!--nbsp--></td>
	<td>Date: </td>
	<td style="border: 1px solid gray;"><!--nbsp--></td>
</tr>
	</table>
<table>
<tr>
<td colspan="5"> </td>
</tr>
<tr>
<td colspan="5">Notes:</td>
</tr>
<tr>
<td colspan="5">Please request the clinicians i/c HIV clinic to provide you with information on the Expected Numbers of New patients to be put on ART</td>
</tr>
<tr>
<td colspan="5">in the following month for you to fill in Column C.</td>
</tr>
<tr>
<td colspan="5">Kindly inform them that this information is important for purposes of planning your stock orders and forecasting your requirements.</td>
</tr>
	</table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
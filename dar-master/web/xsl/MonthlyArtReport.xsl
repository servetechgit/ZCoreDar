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

<tr>
	<th colspan="5" class="category">Adult First-Line Regimens</th>
</tr>
<tr>
    <td colspan="5"><strong>First-Line Std Regimen: d4T + 3TC + NVP</strong></td>
</tr>
<tr>
        <td>1A</td>
        <td>d4T 30mg + 3TC 150mg + NVP 200mg  [&lt; 60Kg] test</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenReportMap/entry[@key='regimen1A']"/>
        <xsl:value-of select="document('')//xsl:variable[@name='map']/regimenReportMap/entry[@key='regimen1A']"/>
        <xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenReportMap/entry[key = 'regimen1A']/value"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenReportMap/regimen1A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenReportMap/regimen1A"/></td>
    </tr>

<tr>
        <td>1B</td>
        <td>d4T 40mg + 3TC 150mg + NVP 200mg [> 60Kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen1B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen1B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen1B"/></td>
    </tr>
	<tr>
        <td colspan="5"><strong>First-Line Non-Standard Regimens: d4T + 3TC + EFV, AZT + 3TC + EFV / NVP</strong></td>
    </tr>
	<tr>
        <td>2A</td>
        <td>d4T 30mg + 3TC 150mg + EFV 600mg [&lt; 60Kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen2A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen2A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen2A"/></td>
    </tr>
	<tr>
        <td>2B</td>
        <td>d4T 40mg + 3TC 150mg + EFV 600mg  [> 60Kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen2B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen2B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen2B"/></td>
    </tr>
	<tr>
        <td>3A</td>
        <td>AZT 300mg + 3TC 150mg + EFV 600mg  [&lt; 60Kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen3A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen3A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen3A"/></td>
    </tr>
	<tr>
        <td>3B</td>
        <td>AZT 300mg + 3TC 150mg + NVP 200mg</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen3B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen3B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen3B"/></td>
    </tr>
	<tr>
        <th colspan="5" class="category">Adult Second-Line Regimens</th>
    </tr>
	<tr>
		<td><strong>Option 1</strong></td>
		<td colspan="4"><strong>AZT + ddI + LPV/r</strong></td>
	</tr>
	<tr>
        <td>4A</td>
        <td>AZT 300mg + ddI 125mg + LPV/r 133.3/33.3mg [&lt; 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen4A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen4A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen4A"/></td>
    </tr>
	<tr>
        <td>4B</td>
        <td>AZT 300mg + ddI 200mg + LPV/r 133.3/33.3mg [> 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen4B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen4B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen4B"/></td>
    </tr>
	<tr>
		<td><strong>Option 2</strong></td>
		<td colspan="4"><strong>AZT + ddI + NFV</strong></td>
	</tr>
	<tr>
        <td>5A</td>
        <td>AZT 300mg + ddI 125mg + NFV 250mg [&lt; 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen5A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen5A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen5A"/></td>
    </tr>
	<tr>
        <td>5B</td>
        <td>AZT 300mg + ddI 200mg + NFV 250mg [> 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen5B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen5B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen5B"/></td>
    </tr>
	<tr>
		<td><strong>Option 3</strong></td>
		<td colspan="4"><strong>AZT + ddI + NFV</strong></td>
	</tr>
	<tr>
        <td>6A</td>
        <td>ABC 300mg + ddI 125mg + LPV/r 133.3/33.mg [&lt; 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen6A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen6A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen6A"/></td>
    </tr>
	<tr>
        <td>6B</td>
        <td>ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg  [> 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen6B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen6B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen6B"/></td>
    </tr>
	<tr>
		<td><strong>Option 4</strong></td>
		<td colspan="4"><strong>ABC + ddI + NFV</strong></td>
	</tr>
	<tr>
        <td>7A</td>
        <td>ABC 300mg + ddI 125mg + NFV 250mg [&lt; 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen7A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen7A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen7A"/></td>
    </tr>
	<tr>
        <td>7B</td>
        <td>ABC 300mg + ddI 200mg + NFV 250mg  [> 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen7B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen7B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen7B"/></td>
    </tr>
	<tr>
        <th colspan="5" class="category">Other Adult ART Regimens</th>
    </tr>
	<tr>
        <td>8</td>
        <td>AZT 300mg + 3TC 150mg + LPV/r 133.3mg/33.3mg</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen8"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen8"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen8"/></td>
    </tr>
	<tr>
        <td>9</td>
        <td>AZT 300mg + 3TC 150mg + IDV 400mg + RTV 100mg</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen9"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen9"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen9"/></td>
    </tr>
	<tr>
        <td>10A</td>
        <td>AZT 300mg + ddI 125mg + IDV 400mg + RTV 100mg [&lt; 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen10A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen10A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen10A"/></td>
    </tr>
	<tr>
        <td>10B</td>
        <td>AZT 300mg + ddI 200mg + IDV 400mg + RTV 100mg [> 60 Kg ]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen10B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen10B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen10B"/></td>
    </tr>
	<tr>
        <td>11A</td>
        <td>TDF 300mg + ABC 300mg + LPV/r 133.3mg/33.3mg  </td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen11A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen11A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen11A"/></td>
    </tr>
	<tr>
        <td>11B</td>
        <td>TDF 300mg + AZT 300mg + LPV/r 133.3mg/33.3mg  </td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimen11B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimen11B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimen11B"/></td>
    </tr>
	<tr>
        <th colspan="5" class="category">Post Exposure Prophylaxis (PEP)</th>
    </tr>
	<tr>
        <td>PEP1</td>
        <td>AZT 300mg + 3TC 150mg </td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP1"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP1"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP1"/></td>
    </tr>
	<tr>
        <td>PEP2A</td>
        <td>d4T 30mg + 3TC 150mg  [&lt; 60Kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP2A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP2A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP2A"/></td>
    </tr>
	<tr>
        <td>PEP2B</td>
        <td>d4T 40mg + 3TC 150mg  [> 60Kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP2B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP2B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP2B"/></td>
    </tr>
	<tr>
        <td>PEP3</td>
        <td>AZT 300mg + 3TC 150mg + LPV/r 133.3/33.3mg</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP3"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP3"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP3"/></td>
    </tr>
	<tr>
        <td>PEP4</td>
        <td>AZT 300mg + 3TC 150mg + IDV 400mg + RTV 100mg</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP4"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP4"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP4"/></td>
    </tr>
	<tr>
        <td>PEP5</td>
        <td>AZT 300mg + 3TC 150mg + NFV 250mg</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP5"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP5"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP5"/></td>
    </tr>
	<tr>
        <td>PEP6A</td>
        <td>Paed: AZT + 3TC</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP6A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP6A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP6A"/></td>
    </tr>
	<tr>
        <td>PEP6B</td>
        <td>Paed: AZT + 3TC + LPV/r</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP6B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP6B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP6B"/></td>
    </tr>
	<tr>
        <td>PEP6C</td>
        <td>Paed: AZT + 3TC + NFV</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP6C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP6C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP6C"/></td>
    </tr>
	<tr>
        <td>PEP7A</td>
        <td>Paed: d4T + 3TC </td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP7A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP7A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP7A"/></td>
    </tr>
	<tr>
        <td>PEP7B</td>
        <td>Paed: d4T + 3TC + LPV/r</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPEP7B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPEP7B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPEP7B"/></td>
    </tr>
	<tr>
		<th colspan="5" class="category">PMTCT Regimens</th>
	</tr>
	<tr>
		<td><strong>1</strong></td>
		<td colspan="4"><strong>Mother</strong></td>
	</tr>
	<tr>
        <td>PMTCT 1M</td>
        <td>Nevirapine (NVP) 200mg stat</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPMTCT__1M"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPMTCT__1M"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPMTCT__1M"/></td>
    </tr>
	<tr>
        <td>PMTCT 2M</td>
        <td>AZT 300mg bd (from week 28-40) + AZT 600mg stat + NVP 200mg stat</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPMTCT__2M"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPMTCT__2M"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPMTCT__2M"/></td>
    </tr>
	<tr>
		<td><strong>2</strong></td>
		<td colspan="4"><strong>Child</strong></td>
	</tr>
	<tr>
        <td>PMTCT 1C</td>
        <td>Nevirapine (NVP) 2 mg/kg stat</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPMTCT__1C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPMTCT__1C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPMTCT__1C"/></td>
    </tr>
	<tr>
        <td>PMTCT 2C</td>
        <td>NVP 2 mg/kg stat + AZT 4mg/kg bd for 1 week</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenPMTCT__2C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenPMTCT__2C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenPMTCT__2C"/></td>
    </tr>
	<tr>
		<th  colspan="5" class="category">Paediatric First Line Regimens</th>
	</tr>
	<tr>
		<td> </td>
		<td colspan="4"><strong>d4T + 3TC + NVP</strong></td>
	</tr>
	<tr>
        <td>C1A</td>
        <td>d4T + 3TC + NVP [0 - &lt;10 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC1A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC1A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC1A"/></td>
    </tr>
	<tr>
        <td>C1B</td>
        <td>d4T + 3TC + NVP [10 - &lt;20 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC1B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC1B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC1B"/></td>
    </tr>
	<tr>
        <td>C1C</td>
        <td>d4T + 3TC + NVP [20 - &lt;30 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC1C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC1C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC1C"/></td>
    </tr>
	<tr>
        <td>C1D</td>
        <td>d4T + 3TC + NVP [30 - &lt;40 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC1D"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC1D"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC1D"/></td>
    </tr>
	<tr>
		<td> </td>
		<td colspan="4"><strong>d4T + 3TC + EFV</strong></td>
	</tr>
	<tr>
        <td>C2A</td>
        <td>d4T + 3TC + EFV [0 - &lt;10 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC2A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC2A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC2A"/></td>
    </tr>
	<tr>
        <td>C2B</td>
        <td>d4T + 3TC + EFV [10 - &lt;20 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC2B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC2B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC2B"/></td>
    </tr>
	<tr>
        <td>C2C</td>
        <td>d4T + 3TC + EFV [20 - &lt;30 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC2C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC2C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC2C"/></td>
    </tr>
	<tr>
        <td>C2D</td>
        <td>d4T + 3TC + EFV [30 - &lt;40 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC2D"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC2D"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC2D"/></td>
    </tr>
	<tr>
		<td> </td>
		<td colspan="4"><strong>AZT + 3TC + EFV</strong></td>
	</tr>
	<tr>
        <td>C3A</td>
        <td>AZT + 3TC + EFV [0 - &lt;10 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC3A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC3A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC3A"/></td>
    </tr>
	<tr>
        <td>C3B</td>
        <td>AZT + 3TC + EFV [10 - &lt;20 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC3B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC3B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC3B"/></td>
    </tr>
	<tr>
        <td>C3C</td>
        <td>AZT + 3TC + EFV [20 - &lt;30 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC3C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC3C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC3C"/></td>
    </tr>
	<tr>
        <td>C3D</td>
        <td>AZT + 3TC + EFV [30 - &lt;40 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC3D"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC3D"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC3D"/></td>
    </tr>
	<tr>
		<td> </td>
		<td colspan="4"><strong>AZT + 3TC + NVP</strong></td>
	</tr>
	<tr>
        <td>C4A</td>
        <td>AZT + 3TC + NVP [0 - &lt;10 kg]</td>
		<td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC4A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC4A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC4A"/></td>
    </tr>
	<tr>
        <td>C4B</td>
        <td>AZT + 3TC + NVP [10 - &lt;20 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC4B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC4B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC4B"/></td>
    </tr>
	<tr>
        <td>C4C</td>
        <td>AZT + 3TC + NVP [20 - &lt;30 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC4C"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC4C"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC4C"/></td>
    </tr>
	<tr>
        <td>C4D</td>
        <td>AZT + 3TC + NVP [30 - &lt;40 kg]</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC4D"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC4D"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC4D"/></td>
    </tr>
	<tr>
		<th colspan="5" class="category">Paediatric Second-Line Regimens</th>
	</tr>
	<tr>
        <td>C5A</td>
        <td>d4T + ABC + LPV/r</td>
		<td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC5A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC5A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC5A"/></td>
    </tr>
	<tr>
        <td>C5B</td>
        <td>d4T + ABC + NFV</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC5B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC5B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC5B"/></td>
    </tr>
	<tr>
        <td>C6A</td>
        <td>AZT + ABC + LPV/r</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC6A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC6A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC6A"/></td>
    </tr>
	<tr>
        <td>C6B</td>
        <td>AZT + ABC + NFV</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC6B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC6B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC6B"/></td>
    </tr>
	<tr>
        <td>C7A</td>
        <td>ABC + ddI + LPV/r</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC7A"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC7A"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC7A"/></td>
    </tr>
	<tr>
        <td>C7B</td>
        <td>ABC + ddI + NFV</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC7B"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC7B"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC7B"/></td>
    </tr>
	<tr>
        <td>C8</td>
        <td>AZT + 3TC + LPV/r</td>
        <td><xsl:value-of select="MonthlyArtReport/artRegimenReport/regimenC8"/></td>
        <td><xsl:value-of select="MonthlyArtReport/newEstimatedArtPatients/regimenC8"/></td>
		<td><xsl:value-of select="MonthlyArtReport/totalEstimatedArtPatients/regimenC8"/></td>
    </tr>
	<tr>
		<th colspan="5" class="category">Other Paediatric Regimens</th>
	</tr>
	<tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
		<td></td>
    </tr>
	<tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
		<td></td>
    </tr>
	<tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
		<td></td>
    </tr>

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
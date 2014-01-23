/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.Principal;
import java.sql.Connection;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.ClientSettings;
import org.rti.zcore.Constants;
import org.rti.zcore.Register;
import org.rti.zcore.Site;
import org.rti.zcore.dar.DarConstants;
import org.rti.zcore.dar.utils.TextFile;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.struts.ParameterActionForward;

/**
 * This is used to generate the combined reports in a single Excel file for KEMSA.
 * @author ckelley
 * @date   Mar 10, 2009
 */
public final class CombinedReportAction extends BaseAction {

	/**
	 * Commons Logging instance.
	 */
	private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

	/**
	 * Process the specified HTTP request, and create the corresponding HTTP
	 * response (or forward to another web component that will create it).
	 * Return an <code>ActionForward</code> instance describing where and how
	 * control should be forwarded, or <code>null</code> if the response has
	 * already been completed.
	 *
	 * @param mapping  The ActionMapping used to select this instance
	 * @param form     The optional ActionForm bean for this request (if any)
	 * @param request  The HTTP request we are processing
	 * @param response The HTTP response we are creating
	 * @return Action to forward to
	 * @throws Exception if an input/output error or servlet exception occurs
	 */
	protected ActionForward doExecute(ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response)
	throws Exception {
		ParameterActionForward fwd = null;
		Principal user = request.getUserPrincipal();
		String username = user.getName();
		Connection conn = null;
		HttpSession session = request.getSession();
		/*boolean dynamicReport = false;
		boolean isFacilityReport = false;
		if (request.getParameter("dynamicReport") != null) {
			dynamicReport = true;
        }
		if (request.getParameter("isFacilityReport") != null) {
			isFacilityReport = true;
		}*/
		SessionUtil zeprs_session = null;
		Site site = null;
		String siteAbbrev = null;
		String reportName = null;
		Register report = null;
		Class clazz = null;
		String className = null;
		try {
			zeprs_session = (SessionUtil) session.getAttribute("zeprs_session");
		} catch (Exception e) {
			// unit testing - it's ok...
		}
		try {
			ClientSettings clientSettings = zeprs_session.getClientSettings();
			site = clientSettings.getSite();
			siteAbbrev = site.getAbbreviation();
		} catch (SessionUtil.AttributeNotFoundException e) {
			log.error(e);
		} catch (NullPointerException e) {
			// it's ok - unit testing
			siteAbbrev = "test";
		}
		
		DailyActivityReport aReport = null;
		MonthlyArtReport mReport = null;

		String template = DarConstants.COMBINED_REPORT_FILENAME;
		
		/*if (isFacilityReport) {
			template = "Monthly Facility Reports for ART and OI";
		} else {
			template = "ART_&_PMTCT_LMIS_Data_Aggregation_Tool";
		}*/

		int i=1;
		//String reportFileName = "Monthly Reports for ARV and OI" + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;

		String reportFileName = template + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
		String path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
		// check if file exists
		File f = new File(path);
		while(f.exists()) {
			i++;
			//reportFileName = "Monthly Reports for ARV and OI" + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
			reportFileName = template + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
			path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
			f = new File(path);
		}
		//String reportFileName = report.getReportFileName();
		//String pathXml = Constants.ARCHIVE_PATH + site.getAbbreviation()  + Constants.pathSep + "reports" + Constants.pathSep + reportFileName + ".xml";
		//String pathExcel = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName + ".xls";
		//String combinedReport = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + "Monthly Reports for ARV and OI.xls";
		String pathExcelMaster = null;
		/*if (dynamicReport) {
			pathExcelMaster = Constants.ARCHIVE_PATH + Constants.pathSep + "Monthly Reports for ARV and OI-dynamic.xls";
		} else {*/
			//pathExcelMaster = Constants.ARCHIVE_PATH + Constants.pathSep + "Monthly Reports for ARV and OI.xls";
			pathExcelMaster = Constants.ARCHIVE_PATH + Constants.pathSep + template;
		//}

		String[] args = new String[]{pathExcelMaster};
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(org.rti.zcore.Constants.DATE_FORMAT_EXCEL_LONG);
    	sdf.setTimeZone(TimeZone.getDefault());

		try
		{
			POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(pathExcelMaster));
			HSSFWorkbook wb =  new HSSFWorkbook(fs);

			// CDRR-ART
			reportName = "CDRRArtReport";	//  may use CDRRArtReport, CDRROIReport, or MonthlyArtReport
			className = "org.rti.zcore.dar.report." + StringManipulation.fixClassname(reportName);

			try {
				clazz = Class.forName(className);
			} catch (ClassNotFoundException e) {
				log.error(e);
			}
			try {
				report = (Register) clazz.newInstance();
			} catch (InstantiationException e) {
				log.error(e);
			} catch (IllegalAccessException e) {
				log.error(e);
			}
			report = SessionUtil.getInstance(session).getReports().get(reportName);
			if (report != null) {
				aReport = (DailyActivityReport) report;
				HSSFSheet aSsheet  = null;
				int sheetPos = 0;
				String rowNumStr = null;
				int rowNum = 0;
				String cellNumStr = null;
				int cellNum = 0;
				String districtName = null;
				String provinceName = null;
				// Must first pre-fill the header info in the Facilities spreadsheet - Office 2010 compatibility issue.
				String filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "facilities.txt";
			    for(String line : new TextFile(filename)) {
			    	//System.out.println(line);
			    	String[] lineArray = line.split("\\|");
			    	String itemName = lineArray[0];
			    	if (itemName.equals("sheet")) {
			    		String sheetPosStr = lineArray[1];
			    		sheetPos = Integer.valueOf(sheetPosStr)-1;
			    		aSsheet  = wb.getSheetAt(sheetPos);
			    	} else if (itemName.equals("siteName")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
						HSSFRichTextString hssfRichTextString = new HSSFRichTextString(report.getSiteName());
						HSSFCell cell = aSsheet.getRow(rowNum).getCell(cellNum);
						cell.setCellValue(hssfRichTextString);
			    	} else if (itemName.equals("district")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		districtName = lineArray[3];
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(districtName));
			    	} else if (itemName.equals("province")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		provinceName = lineArray[3];
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(provinceName));
			    	} else if (itemName.equals("beginDate")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(sdf.format(report.getBeginDate().getTime())));
			    	} else if (itemName.equals("endDate")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(sdf.format(report.getEndDate().getTime())));
			    	}
			    }
			    filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr.txt";
			    for(String line : new TextFile(filename)) {
			    	//System.out.println(line);
			    	String[] lineArray = line.split("\\|");
			    	String itemName = lineArray[0];
			    	if (itemName.equals("sheet")) {
			    		String sheetPosStr = lineArray[1];
			    		sheetPos = Integer.valueOf(sheetPosStr)-1;
			    		aSsheet  = wb.getSheetAt(sheetPos);
			    	} else if (itemName.equals("siteName")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		HSSFRichTextString hssfRichTextString = new HSSFRichTextString(report.getSiteName());
			    		HSSFCell cell = aSsheet.getRow(rowNum).getCell(cellNum);
			    		cell.setCellValue(hssfRichTextString);
			    	} else if (itemName.equals("district")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		districtName = lineArray[3];
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(districtName));
			    	} else if (itemName.equals("province")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		provinceName = lineArray[3];
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(provinceName));
			    	} else if (itemName.equals("beginDate")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(sdf.format(report.getBeginDate().getTime())));
			    	} else if (itemName.equals("endDate")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		aSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(sdf.format(report.getEndDate().getTime())));
			    	}
			    }
				
				/*aSsheet.getRow(3).getCell(1).setCellValue(new HSSFRichTextString(report.getSiteName()));
				aSsheet.getRow(3).getCell(7).setCellValue(new HSSFRichTextString("Nairobi"));
				aSsheet.getRow(3).getCell(13).setCellValue(new HSSFRichTextString("Nairobi"));
				aSsheet.getRow(4).getCell(1).setCellValue(new HSSFRichTextString(sdf.format(report.getBeginDate().getTime())));
				aSsheet.getRow(4).getCell(7).setCellValue(new HSSFRichTextString(sdf.format(report.getEndDate().getTime())));*/
				CDRRArtSheetPopulater.populateCDRRArtSheet(aReport, aSsheet, 12);
				//CDRRArtSheetPopulater.populateDynamicCDRRArtSheet(aReport, aSsheet, 43, wb, false);
			}

			// CDRR-OI no longer used.
			/*reportName = "CDRROIReport";	//  may use CDRRArtReport, CDRROIReport, or MonthlyArtReport
			className = "org.rti.zcore.dar.report." + StringManipulation.fixClassname(reportName);
			report = null;
			clazz = null;
			try {
				clazz = Class.forName(className);
			} catch (ClassNotFoundException e) {
				log.error(e);
			}
			try {
				report = (Register) clazz.newInstance();
			} catch (InstantiationException e) {
				log.error(e);
			} catch (IllegalAccessException e) {
				log.error(e);
			}
			report = SessionUtil.getInstance(session).getReports().get(reportName);
			if (report != null) {
				CDRROIReport oReport = (CDRROIReport) report;
				HSSFSheet oSsheet  = null;
				if (isFacilityReport) {
					oSsheet  = wb.getSheetAt(1);
				} else {
					oSsheet  = wb.getSheetAt(2);
				//}
				oSsheet.getRow(3).getCell(1).setCellValue(new HSSFRichTextString("KEMSA"));
				oSsheet.getRow(4).getCell(1).setCellValue(new HSSFRichTextString(report.getSiteName()));
				oSsheet.getRow(5).getCell(1).setCellValue(new HSSFRichTextString("Nairobi"));
				oSsheet.getRow(6).getCell(1).setCellValue(new HSSFRichTextString(sdf.format(report.getBeginDate().getTime())));
				oSsheet.getRow(6).getCell(11).setCellValue(new HSSFRichTextString(sdf.format(report.getEndDate().getTime())));
				// now fill in the report data
				if (dynamicReport) {
					CDRROiSheetPopulater.populateDynamicCDRRPOiSheet(oReport, oSsheet);
				} else {
					//CDRROiSheetPopulater.populateCDRRPOiSheet(oReport, oSsheet);
				//}
			}*/

			reportName = "MonthlyArtReport";	//  may use CDRRArtReport, CDRROIReport, or MonthlyArtReport
			className = "org.rti.zcore.dar.report." + StringManipulation.fixClassname(reportName);
			report = null;
			clazz = null;
			try {
				clazz = Class.forName(className);
			} catch (ClassNotFoundException e) {
				log.error(e);
			}
			try {
				report = (Register) clazz.newInstance();
			} catch (InstantiationException e) {
				log.error(e);
			} catch (IllegalAccessException e) {
				log.error(e);
			}
			report = SessionUtil.getInstance(session).getReports().get(reportName);

			if (report != null) {
				mReport = (MonthlyArtReport) report;
				// Monthly ART Report
				HSSFSheet mSsheet  = null;
				
				// populate the statistics
				//SiteStatisticsReport register = new SiteStatisticsReport();
				/*int siteId = report.getSiteId();
				SiteStatistics stats = new SiteStatistics();
				try {
					conn = DatabaseUtils.getZEPRSConnection(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);
					Integer newClients = SiteStatisticsDAO.getNewClients(conn, beginDate, endDate, siteId);
	        			stats.setNewClients(newClients);
					Integer femaleAdults = SiteStatisticsDAO.getFemaleAdults(conn, siteId);
					stats.setFemaleAdults(femaleAdults);
					Integer femaleChildren = SiteStatisticsDAO.getFemaleChildren(conn, siteId);
					stats.setFemaleChildren(femaleChildren);
					stats.setFemales(femaleAdults + femaleChildren);
					Integer maleAdults = SiteStatisticsDAO.getMaleAdults(conn, siteId);
					stats.setMaleAdults(maleAdults);
					Integer maleChildren = SiteStatisticsDAO.getMaleChildren(conn, siteId);
					stats.setMaleChildren(maleChildren);
					stats.setMales(maleAdults + maleChildren);
					stats.setAdults(maleAdults + femaleAdults);
					stats.setChildren(maleChildren + femaleChildren);
					stats.setAllClients(maleAdults + femaleAdults +maleChildren + femaleChildren);
	        			Integer statusDied = SiteStatisticsDAO.getStatusDied(conn, beginDate, endDate, siteId);
	        			stats.setStatusDied(statusDied);
	        			Integer statusTransferred = SiteStatisticsDAO.getStatusTransferred(conn, beginDate, endDate, siteId);
	        			stats.setStatusTransferred(statusTransferred);
	        			Integer statusDefaulters = SiteStatisticsDAO.getStatusDefaulters(conn, beginDate, endDate, siteId);
	        			stats.setStatusDefaulters(statusDefaulters);
	        			Integer statusOther = SiteStatisticsDAO.getStatusOther(conn, beginDate, endDate, siteId);
	        			stats.setStatusOther(statusOther);
	        			Integer activeArvClients = SiteStatisticsDAO.getActiveArvClients(conn, beginDate, endDate, siteId);
	        			stats.setActiveArvClients(activeArvClients);
	        			ArrayList<RegimenReport> regimens = SiteStatisticsDAO.getRegimens(conn, beginDate, endDate, siteId);
	        			stats.setRegimens(regimens);
					mSsheet.getRow(8).getCell(2).setCellValue(new HSSFRichTextString("Client totals include all clients in the database."));
					mSsheet.getRow(9).getCell(2).setCellValue(new HSSFRichTextString(stats.getAdults().toString()));
					mSsheet.getRow(9).getCell(6).setCellValue(new HSSFRichTextString(stats.getChildren().toString()));
					mSsheet.getRow(11).getCell(2).setCellValue(new HSSFRichTextString(stats.getMales().toString()));
					mSsheet.getRow(11).getCell(4).setCellValue(new HSSFRichTextString(stats.getFemales().toString()));
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						conn.close();
					} catch (SQLException e) {
						log.error(e);
					}
				}*/
				
				String filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "regimens.txt";
				int sheetPos = 0;
				String rowNumStr = null;
				int rowNum = 0;
				String cellNumStr = null;
				int cellNum = 0;
				String districtName = null;
				String provinceName = null;
				
			    for(String line : new TextFile(filename)) {
			    	//System.out.println(line);
			    	String[] lineArray = line.split("\\|");
			    	String itemName = lineArray[0];
			    	if (itemName.equals("sheet")) {
			    		String sheetPosStr = lineArray[1];
			    		sheetPos = Integer.valueOf(sheetPosStr)-1;
			    		mSsheet  = wb.getSheetAt(sheetPos);
			    	} else if (itemName.equals("siteName")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(report.getSiteName()));
			    	} else if (itemName.equals("district")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		districtName = lineArray[3];
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(districtName));
			    	} else if (itemName.equals("province")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		provinceName = lineArray[3];
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(provinceName));
			    	} else if (itemName.equals("beginDate")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(sdf.format(report.getBeginDate().getTime())));
			    	} else if (itemName.equals("endDate")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(new HSSFRichTextString(sdf.format(report.getEndDate().getTime())));
			    	} else if (itemName.equals("adultsTotal")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		//${register.artRegimenReport.totalAdultsDispensed}
			    		HSSFCell cell = mSsheet.getRow(rowNum).getCell(cellNum);
			    		cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cell.setCellValue(aReport.getArtRegimenReport().getTotalAdultsDispensed());
			    	} else if (itemName.equals("childrenTotal")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		//${register.artRegimenReport.totalAdultsDispensed}
			    		HSSFCell cell = mSsheet.getRow(rowNum).getCell(cellNum);
			    		cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cell.setCellValue(aReport.getArtRegimenReport().getTotalChildrenDispensed());
			    	} 
			    	/*else if (itemName.equals("totalMalesNew")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		//${register.artRegimenReport.totalAdultsDispensed}
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(aReport.getArtRegimenReport().getTotalChildrenDispensed());
			    	} else if (itemName.equals("totalMalesRevisit")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		//${register.artRegimenReport.totalAdultsDispensed}
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(aReport.getArtRegimenReport().getTotalChildrenDispensed());
			    	} else if (itemName.equals("totalFemalesNew")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		//${register.artRegimenReport.totalAdultsDispensed}
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(aReport.getArtRegimenReport().getTotalChildrenDispensed());
			    	} else if (itemName.equals("totalFemalesRevisit")) {
			    		rowNumStr = lineArray[1];
			    		rowNum = Integer.valueOf(rowNumStr)-1;
			    		cellNumStr = lineArray[2];
			    		cellNum = Integer.valueOf(cellNumStr)-1;
			    		//${register.artRegimenReport.totalAdultsDispensed}
			    		mSsheet.getRow(rowNum).getCell(cellNum).setCellValue(aReport.getArtRegimenReport().getTotalChildrenDispensed());
			    	}*/
			    }
				MonthlyArtSheetPopulater.populateMonthlyArtSheet(mReport, mSsheet, 8);
				//MonthlyArtSheetPopulater.populateDynamicMonthlyArtSheet(mReport, mSsheet, 100);
				
			}
			FileOutputStream stream = new FileOutputStream(path);
			wb.write(stream);
			stream.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		 fwd = new ParameterActionForward(mapping.findForward(SUCCESS_FORWARD));
		 String url = path.replace("&", "%26");
		 fwd.addParameter("path",url);
		//return mapping.findForward("success");
		return fwd;
	}
}
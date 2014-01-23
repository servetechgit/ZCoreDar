/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

/*
 * Created on Mar 24, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package org.rti.zcore.dar.report;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.security.Principal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.rti.zcore.ClientSettings;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Register;
import org.rti.zcore.Report;
import org.rti.zcore.ReportCreator;
import org.rti.zcore.Site;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.SessionUtil;

import com.thoughtworks.xstream.XStream;

/**
 * @author ericl
 *         <p/>
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class ChooseReportAction extends BaseAction {

    /**
     * Commons Logging instance.
     */
    private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

     protected ActionForward doExecute(ActionMapping mapping,
                                       ActionForm form,
                                       HttpServletRequest request,
                                       HttpServletResponse response)
            throws Exception {
	    //log.debug("Starting Report:" + DateUtils.getTime());
        HttpSession session = request.getSession();
    	SessionUtil zeprs_session = null;
        try {
    		zeprs_session = (SessionUtil) session.getAttribute("zeprs_session");
    	} catch (Exception e) {
    		// unit testing - it's ok...
    	}
        String task = "";
        if (request.getParameter("task") != null) {
            task = request.getParameter("task");
        }
        boolean isXml = false;
        if (request.getParameter("isXml") != null) {
            isXml = true;
        }
        boolean isCombinedReport = false;	// For combined Monthly Reports for ARV and OI
        boolean isFacilityReport = false;	// For combined Monthly Reports for ARV and OI
        boolean dynamicReport = false;	// For combined Monthly Reports for ARV and OI
        if (request.getParameter("isCombinedReport") != null) {
        	isCombinedReport = true;
            request.setAttribute("isCombinedReport", "1");
        }
        if (request.getParameter("dynamicReport") != null) {
        	dynamicReport = true;
        	request.setAttribute("dynamicReport", "1");
        }
        if (request.getParameter("isFacilityReport") != null) {
        	isFacilityReport = true;
    		request.setAttribute("isFacilityReport", "1");
    	}

        Report report = null;
        Register register = null;

        int reportID = 0;

        //int reportID = Integer.parseInt(((chooseReportForm) form).getReport());
        if (request.getParameter("report") != null) {
             reportID = (Integer.valueOf(request.getParameter("report").toString()));
         } else {
         return mapping.findForward("reports");
         }

         Date beginDate = null;
         Date endDate = null;
         if (request.getParameter("bdate") != null) {
             beginDate = Date.valueOf(String.valueOf(request.getParameter("bdate")));
         }
         if (request.getParameter("edate") != null) {
             endDate = Date.valueOf(String.valueOf(request.getParameter("edate")));
         }

         if (reportID == 10) {
         	isCombinedReport = true;
         	reportID = 5;
         } else if (reportID == 14) {
        	dynamicReport = true;
         	isCombinedReport = true;
         	reportID = 5;
         } else if (reportID == 15) {
        	 dynamicReport = true;
        	 reportID = 5;
         } else if (reportID == 16) {
        	 dynamicReport = true;
        	 reportID = 6;
         } else if (reportID == 17) {
        	 dynamicReport = true;
        	 reportID = 7;
         } else if (reportID == 20) {
        	 isFacilityReport = false;
        	 isCombinedReport = true;
          	 reportID = 5;
         }

         /*if (isCombinedReport == true) {
             Calendar gc = new GregorianCalendar();
             gc.setTime(endDate);
             int maxDate = gc.getActualMaximum(Calendar.DAY_OF_MONTH);
             int month = gc.get(Calendar.MONTH);
             int year = gc.get(Calendar.YEAR);
             gc.set(year, month, 0, 0, 0, 0);
             gc.add(Calendar.DAY_OF_MONTH, 1);
             Calendar monthEndCal = new GregorianCalendar();
             monthEndCal.set(year, month, maxDate, 0, 0, 0);
             // re-assign values for begin/endDate
             beginDate = new Date(gc.getTime().getTime());
             endDate = new Date(monthEndCal.getTime().getTime());
         }*/

         java.util.Calendar c = java.util.Calendar.getInstance();
         c.add(java.util.Calendar.MONTH, -1);
         java.util.Date date1monthpast = c.getTime();
         String DATE_FORMAT = "yyyy-MM-dd";
         java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
         sdf.setTimeZone(TimeZone.getDefault());
         String date1monthpastStr = sdf.format(date1monthpast);
         java.sql.Date date1monthpastSql =  java.sql.Date.valueOf(date1monthpastStr);

         // week behind - for defaulters report
         java.util.Calendar c2 = java.util.Calendar.getInstance();
         c2.add(java.util.Calendar.WEEK_OF_YEAR, -1);
         java.util.Date date1weekpast = c2.getTime();
         sdf.setTimeZone(TimeZone.getDefault());
         String date1weekpastStr = sdf.format(date1weekpast);
         java.sql.Date date1weekpastSql =  java.sql.Date.valueOf(date1weekpastStr);

         // week ahead
         java.util.Calendar c4 = java.util.Calendar.getInstance();
         c4.add(java.util.Calendar.WEEK_OF_YEAR, +1);
         java.util.Date date1weekahead = c4.getTime();
         java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(DATE_FORMAT);
         sdf2.setTimeZone(TimeZone.getDefault());
         String date1weekaheadStr = sdf2.format(date1weekahead);
         java.sql.Date date1weekaheadSql =  java.sql.Date.valueOf(date1weekaheadStr);

         // Name of the forward to use - see ChooseReportAction in struts-config
         // Most of the reports have thier own jsp page. Name sets the name of this file.
         String name = "none";
        // int siteId = ((chooseReportForm) form).getSiteId();
         int siteId = 0;
         if (request.getParameter("siteId") != null) {
             siteId = (Integer.valueOf(request.getParameter("siteId").toString()));
         }
        // boolean  isXml= ((chooseReportForm) form).isXml();
        String siteName;
        if (siteId == 0) {
            siteName = "All sites";
        } else {
            Site site = (Site) DynaSiteObjects.getClinicMap().get((long) siteId);
            siteName = site.getName();
        }
        request.setAttribute("siteId", siteId);
        request.setAttribute("siteName", siteName);
        List records = new ArrayList();
        String abbrev = "enc";
        Class clazz = EncounterData.class;

        java.sql.Date dateNow = DateUtils.getNow();
        request.setAttribute("dateNow", dateNow);

        request.setAttribute("bdate", beginDate);
        request.setAttribute("edate", endDate);

        Principal user = request.getUserPrincipal();
        String username = user.getName();
        ReportCreator reportCreator = new ReportCreator();
        reportCreator.setUsernameR(username);
        System.out.println("Report Id "+reportID);
        switch (reportID) {
             /**/
        
            case 1:
            	System.out.println("OIDailyActivityReport");
            	register = new DailyActivityReport();
            	register.setType("OIDailyActivityReport");
                register.setSiteName(siteName);
                register.getPatientRegister(beginDate, endDate, siteId);
                register.setBeginDate(beginDate);
                register.setEndDate(endDate);
                request.setAttribute("register", register);
                name = "OIDailyActivityReport";
                abbrev = "OIDAR";
                clazz = DailyActivityReport.class;
                break;
            case 2:
            	System.out.println("ARTAdultDailyActivityReport");
            	register = new DailyActivityReport();
            	register.setType("ARTAdultDailyActivityReport");
            	register.setSiteName(siteName);
            	register.getPatientRegister(beginDate, endDate, siteId);
                System.out.println("BAck from Database");
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	request.setAttribute("register", register);
            	name = "ARTAdultDailyActivityReport";
            	abbrev = "ARTADAR";
            	clazz = DailyActivityReport.class;
            	break;
            case 3:
            	System.out.println("OIDailyActivityReport");
            	register = new DailyActivityReport();
            	register.setType("ARTChildDailyActivityReport");
            	register.setSiteName(siteName);
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	request.setAttribute("register", register);
            	name = "ARTChildDailyActivityReport";
            	abbrev = "ARTCDAR";
            	clazz = DailyActivityReport.class;
            	break;
/*            case 4:
            	register = new OIARTAdultDailyActivityReport();
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	request.setAttribute("register", register);
            	name = "OIARTAdultDailyActivityReport";
            	abbrev = "OIARTADAR";
            	clazz = OIARTAdultDailyActivityReport.class;
            	break;*/
            case 5:
            	System.out.println("CDRRArtReport");
            	//register = new CDRRArtReport();
            	register = new DailyActivityReport();
            	/*if (dynamicReport == true) {
            		request.setAttribute("dynamicReport", "1");
            		register.setDynamicReport(true);
            	}*/
            	
            	register.setType("CDRRArtReport");
            	register.setSiteName(siteName);
                register.setReportCreator(reportCreator);
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	ClientSettings clientSettings = zeprs_session.getClientSettings();
        		Site site = clientSettings.getSite();
        		String siteAbbrev = site.getAbbreviation();
        		int i=1;
    			String reportFileName = "CDRRArtReport" + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
    			String path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    			// check if file exists
    			File f = new File(path);
    			while(f.exists()) {
    				i++;
    				reportFileName = "CDRRArtReport" + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
    				path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    				f = new File(path);
    			}
    			register.setReportFileName(reportFileName);
    			register.setReportPath(path);
            	request.setAttribute("register", register);
            	if (isCombinedReport == true) {
                	request.setAttribute("isCombinedReport", "1");
            	}
            	if (isFacilityReport == true) {
            		request.setAttribute("isFacilityReport", "1");
            	}
            	name = "CDRRArtReport";
            	abbrev = "CDRRArt";
            	//clazz = CDRRArtReport.class;
            	SessionUtil.getInstance(session).getReports().put(name, register);
            	break;
            case 6:
            	System.out.println("print");
            	register = new MonthlyArtReport();
            	/*if (dynamicReport == true) {
            		request.setAttribute("dynamicReport", "1");
            		register.setDynamicReport(true);
            	}*/
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
                register.setReportCreator(reportCreator);
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	clientSettings = zeprs_session.getClientSettings();
        		site = clientSettings.getSite();
        		siteAbbrev = site.getAbbreviation();
        		i=1;
    			reportFileName = "MonthlyArtReport" + "-" + siteAbbrev + "-"
        		+ username + "-" + DateUtils.getNowPretty() + "-" + i;
    			path = Constants.ARCHIVE_PATH + site.getAbbreviation()
    					+ Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    			// check if file exists
    			f = new File(path);
    			while(f.exists()) {
    				i++;
    				reportFileName = "MonthlyArtReport" + "-" + siteAbbrev + "-" + username +
    						"-" + DateUtils.getNowPretty() + "-" + i;
    				path = Constants.ARCHIVE_PATH + site.getAbbreviation() +
    						Constants.pathSep + "reports" + Constants.pathSep +
    						reportFileName+".xls";
    				f = new File(path);
    			}
    			register.setReportFileName(reportFileName);
    			register.setReportPath(path);
            	request.setAttribute("register", register);
            	name = "MonthlyArtReport";
            	abbrev = "MART";
            	clazz = MonthlyArtReport.class;
            	SessionUtil.getInstance(session).getReports().put(name, register);
            	break;
            case 7:
            	//register = new CDRROIReport();

            	System.out.println("CDRROIReport");
            	register = new DailyActivityReport();
            	register.setType("CDRROIReport");
            	/*if (dynamicReport == true) {
            		request.setAttribute("dynamicReport", "1");
            		register.setDynamicReport(true);
            	}*/
            	register.setSiteName(siteName);
                register.setReportCreator(reportCreator);
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	clientSettings = zeprs_session.getClientSettings();
        		site = clientSettings.getSite();
        		siteAbbrev = site.getAbbreviation();
        		i=1;
    			reportFileName = "CDRROIReport" + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
    			path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    			// check if file exists
    			f = new File(path);
    			while(f.exists()) {
    				i++;
    				reportFileName = "CDRROIReport" + "-" + siteAbbrev + "-" + username + "-" + DateUtils.getNowPretty() + "-" + i;
    				path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    				f = new File(path);
    			}
    			register.setReportFileName(reportFileName);
    			register.setReportPath(path);
            	request.setAttribute("register", register);
            	name = "CDRROIReport";
            	abbrev = "CDRROI";
            	clazz = CDRROIReport.class;
            	SessionUtil.getInstance(session).getReports().put(name, register);
            	break;
            case 8:

            	System.out.println("8 AppointmentRegister");
            	register = new AppointmentRegister();
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
            	register.setReportCreator(reportCreator);
            	if (beginDate == null) {
            		beginDate = dateNow;
            	}
            	if (endDate == null) {
            		endDate = date1weekaheadSql;
            	}
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	request.setAttribute("register", register);
            	name = "AppointmentRegister";
            	abbrev = "APPREG";
            	clazz = AppointmentRegister.class;
            	break;
            case 9:
            	System.out.println("9+ DefaultersRegister");
            	System.out.println("9+ DefaultersRegister");
            	register = new DefaultersRegister();
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
            	register.setReportCreator(reportCreator);
            	if (beginDate == null) {
            		beginDate = date1weekpastSql;
            	}
            	if (endDate == null) {
            		endDate = dateNow;
            	}
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	request.setAttribute("register", register);
            	name = "DefaultersRegister";
            	abbrev = "DEFREG";
            	clazz = DefaultersRegister.class;
            	break;
            case 11:

            	System.out.println("9+SiteStatisticsReport");
            	register = new SiteStatisticsReport();
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
            	register.setReportCreator(reportCreator);
            	if (beginDate == null) {
            		beginDate = date1monthpastSql;
            	}
            	if (endDate == null) {
            		endDate = dateNow;
            	}
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	request.setAttribute("register", register);
            	name = "SiteStatisticsReport";
            	abbrev = "SSR";
            	clazz = SiteStatisticsReport.class;
            	break;
            case 12:
            	System.out.println("12+StockUsageReport");
            	register = new StockUsageReport();
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
                register.setReportCreator(reportCreator);
                clientSettings = zeprs_session.getClientSettings();
        		site = clientSettings.getSite();
        		siteAbbrev = site.getAbbreviation();
                i=1;
    			reportFileName = "Monthly Drug Usage Report" + "-" + siteName.trim() + "-" + username.trim() + "-" + DateUtils.getNowPretty() + "-" + i;
    			path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    			// check if file exists
    			f = new File(path);
    			while(f.exists()) {
    				i++;
    				reportFileName = "Monthly Drug Usage Report" + "-" + siteName.trim() + "-" + username.trim() + "-" + DateUtils.getNowPretty() + "-" + i;
    				path = Constants.ARCHIVE_PATH + site.getAbbreviation() + Constants.pathSep + "reports" + Constants.pathSep + reportFileName+".xls";
    				f = new File(path);
    			}
    			beginDate = Date.valueOf("1900-01-01");
    			endDate = DateUtils.getNow();
    			register.setReportFileName(reportFileName);
    			register.setReportPath(path);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
				try {
					register.getPatientRegister(beginDate, endDate, siteId);
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("exception", e);
					return mapping.findForward("error");
				}
            	request.setAttribute("register", register);
            	name = "StockUsageReport";
            	if ((!register.getType().equals("error")) && (!register.getType().equals("empty"))) {
                   /* response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "attachment; filename=" + path);*/
                    //return(null);
                	request.setAttribute("message", "Report saved at ");
                	request.setAttribute("path", path);
            	} else if (register.getType().equals("empty")) {
            		request.setAttribute("exception", "There was were not any stock transactions to generate this report.");
					return mapping.findForward("error");
            	} else {
            		request.setAttribute("exception", "There was an error generating this report.");
					return mapping.findForward("error");
            	}
            	break;
            case 13:
            	System.out.println("RegimenChangeReport");
            	register = new RegimenChangeReport();
            	register.setType("print");   // not (longer) view version
            	register.setSiteName(siteName);
            	register.setReportCreator(reportCreator);
            	if (beginDate == null) {
            		beginDate = date1monthpastSql;
            	}
            	if (endDate == null) {
            		endDate = dateNow;
            	}
            	register.getPatientRegister(beginDate, endDate, siteId);
            	register.setBeginDate(beginDate);
            	register.setEndDate(endDate);
            	register.setReportDate(dateNow);
            	register.setSiteId(siteId);
            	request.setAttribute("register", register);
            	name = "RegimenChangeReport";
            	abbrev = "RCR";
            	clazz = RegimenChangeReport.class;
            	break;

                 /**/
            default:
                break;

        }    // end switch

       /* if ((reportID == 12) && (!register.getType().equals("error"))) {
        	return(null);
        }*/

        if (isXml) {
            String reportType = null;

            if (records.size() > 0) {
               reportType = "records";
            } else if (register != null) {
               reportType = "register";
            }

            if (reportType != null) {
                XStream xstream = new XStream();
                xstream.alias(abbrev, clazz);
                xstream.alias("log", org.apache.commons.logging.impl.Log4JLogger.class);
                // response.setContentType("text/html");
                response.setContentType("text/xml");
                response.setContentType("application/vnd.ms-excel");
                PrintWriter writer = response.getWriter();
                writer.write("<?xml version=\"1.0\"?>\n");
                if (reportType.equals("records") ) {
                    xstream.toXML(records, writer);
                } else {
                    xstream.toXML(register, writer);
                }
                //writer.write(xml);
                writer.flush();
                writer.close();
                // use writer to render text
                return(null);
                // log.info("saved register " + path + name + "Register.xml");
            }
        }
        if (task.equals("generate")) {
            if (report != null) {
                XStream xstream = new XStream();
                String path = Constants.REPORTS_XML_PATH;
                Writer writer = new BufferedWriter(new FileWriter(path + name + "Report.xml"));
                writer.write("<?xml version=\"1.0\"?>\n");
                xstream.toXML(report, writer);
                //writer.write(xml);
                writer.flush();
                writer.close();
                log.info("saved report " + path + name + "Report.xml");
            } else if (register != null) {
                XStream xstream = new XStream();
                String path = Constants.REPORTS_XML_PATH;
                Writer writer = new BufferedWriter(new FileWriter(path + name + "Report.xml"));
                writer.write("<?xml version=\"1.0\"?>\n");
                xstream.toXML(register, writer);
                //writer.write(xml);
                writer.flush();
                writer.close();
                log.info("saved register " + path + name + "Report.xml");
            }

        }

        return mapping.findForward(name);

    }

}

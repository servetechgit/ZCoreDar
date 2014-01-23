/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.remote;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.ResourceBundle;

import javax.servlet.http.HttpSession;
import javax.xml.transform.TransformerException;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.ClientSettings;
import org.rti.zcore.Constants;
import org.rti.zcore.Register;
import org.rti.zcore.Site;
import org.rti.zcore.dar.report.CDRRArtReport;
import org.rti.zcore.dar.report.MonthlyArtReport;
import org.rti.zcore.dar.report.valueobject.DrugReport;
import org.rti.zcore.dar.report.valueobject.RegimenReport;
import org.rti.zcore.dar.utils.ReportOutput;
import org.rti.zcore.exception.PersistenceException;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.StringManipulation;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.sun.org.apache.xml.internal.utils.WrappedRuntimeException;

public class ReportHelper {

    /**
     * Commons Logging instance.
     */
    public static Log log = LogFactory.getFactory().getInstance(ReportHelper.class);
	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("resources.ApplicationResources");


	/**
	 * Update report value and saves report to an Excel file.
	 * @param identifier
	 * @param reportName
	 * @param value
	 * @param isFacilityReport
	 * @return
	 */
	public static String updateReport(String identifier, String reportName, String value, Boolean isFacilityReport) throws FileNotFoundException {
		String result = "";
		WebContext exec = WebContextFactory.get();
		String username = null;
		SessionUtil zeprs_session = null;
		Site site = null;
		String siteAbbrev = null;
		try {
			username = exec.getHttpServletRequest().getUserPrincipal().getName();
		} catch (NullPointerException e) {
			// unit testing - it's ok...
			username = "demo";
		}
		HttpSession session = exec.getSession();
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

		String parentField = null;
		String childField = null;

		if (identifier.equals("Save") || identifier.equals("SaveNext")) {

		} else {
			String[] identArray = identifier.split("\\.");
			parentField = identArray[0];
			childField = identArray[1];
		}

		Register report = null;
		String className = "org.rti.zcore.dar.report." + StringManipulation.fixClassname(reportName);
		Class clazz = null;
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

		if (identifier.equals("Save") || identifier.equals("SaveNext") || value != null) {
			Integer valueInt = null;
			report = SessionUtil.getInstance(session).getReports().get(reportName);
			String totalIdent = "";
			String reportFileName = report.getReportFileName();
			String pathXml = Constants.ARCHIVE_PATH + site.getAbbreviation() + "/reports/"+reportFileName+".xml";
			String pathExcel = Constants.ARCHIVE_PATH + site.getAbbreviation() + "/reports/"+reportFileName+".xls";
			String bdate = report.getBeginDate().toString();
			String edate = report.getEndDate().toString();
			String siteId = String.valueOf(report.getSiteId());
			String jsessionId = session.getId();
			String[] identifierArray = identifier.split("\\.");
			int len = identifierArray.length;
			String keyForMap = null;
			try {
				if (identifier.equals("Save")) {
					result = "Report saved at " + pathExcel;
				} else if (identifier.equals("SaveNext")) {
					String reportId = null;
					if (reportName.equals("CDRRArtReport")) {
						if ((isFacilityReport != null) && (isFacilityReport == Boolean.TRUE)) {
							reportId = "7";
							result = "/dar/ChooseReportAction.do;jsessionid=" + jsessionId + "?bdate=" + bdate + "&edate=" +
							edate + "&siteId=" + siteId + "&report=" + reportId + "&isCombinedReport=1&isFacilityReport=1";
						} else {
							// Skipping CDRROIReport
							reportId = "6";
							result = "/dar/ChooseReportAction.do;jsessionid=" + jsessionId + "?bdate=" + bdate + "&edate=" +
							edate + "&siteId=" + siteId + "&report=" + reportId + "&isCombinedReport=1";
						}
					} else if (reportName.equals("CDRROIReport")) {
						reportId = "6";
						result = "/dar/ChooseReportAction.do;jsessionid=" + jsessionId + "?bdate=" + bdate + "&edate=" +
						edate + "&siteId=" + siteId + "&report=" + reportId + "&isCombinedReport=1&isFacilityReport=1";
					} else {
						if ((isFacilityReport != null) && (isFacilityReport == Boolean.TRUE)) {
							result = "/dar/reports/combined/gen.do;jsessionid=" + jsessionId +  "?isFacilityReport=1";
						} else {
							result = "/dar/reports/combined/gen.do;jsessionid=" + jsessionId;
						}
					}
				} else {
					try {
						valueInt = Integer.valueOf(value);
					} catch (NumberFormatException e) {
						try {
							throw new PersistenceException("This input field requires an integer value (e.g.: 55). You entered : " + value, e, false);
						} catch (PersistenceException e1) {
							return result = identifier + "=" + "Error:" + e1.getMessage();
						}
					}
					
					
					if (identifier.contains("regimenReportMap")) {
						keyForMap = identifierArray[len-1];
						// should be newEstimatedArtPatients.
						String parentObjectName = identifier.replace("." +  identifierArray[len-2] + "." + keyForMap, "");
						try {
							Object parent = null;
							parent = PropertyUtils.getNestedProperty(report, parentObjectName);
							PropertyUtils.setMappedProperty(parent, "regimenReportMap", keyForMap, valueInt);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} else if (identifier.contains("stockReportMap")) {
						keyForMap = identifierArray[len-2];
						//String propertyName = identifierArray[len-1];
						// parentObjectName should be stockReportMap
						//String parentObjectName = identifier.replace("." +  keyForMap + "." + childField, "");
						try {
							PropertyUtils.setNestedProperty(report, identifier, valueInt);
							//Object parent = PropertyUtils.getNestedProperty(report, parentObjectName);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					} else {
						PropertyUtils.setProperty(report, identifier, valueInt);
					}
					//valueInt = (Integer) PropertyUtils.getProperty(report, identifier);
					/*HashMap<String, Integer> regimenReportMap = report.get
					regimenReportMap.put(key, amount);*/
					
					// CDRR (Stock) Reports
					if (parentField.equals("stockReportMap")) {
						String propertyField = identifierArray[2];
						if (propertyField.equals("quantityRequiredNewPatients")) {
							String quantityRequiredResupplyIdent = identifier.replace(propertyField, "quantityRequiredResupply");
							Integer quantityRequiredResupply = 0;
							if (PropertyUtils.getNestedProperty(report, quantityRequiredResupplyIdent) != null) {
								quantityRequiredResupply = (Integer) PropertyUtils.getNestedProperty(report, quantityRequiredResupplyIdent);
							}
							Integer totalQuantityRequired = quantityRequiredResupply + valueInt;
							String totalQuantityRequiredIdent = identifier.replace(propertyField, "totalQuantityRequired");
							try {
								PropertyUtils.setNestedProperty(report, totalQuantityRequiredIdent, valueInt);
							} catch (Exception e) {
								e.printStackTrace();
							}
							result = identifier + "=" + valueInt + ";" + totalQuantityRequiredIdent +  "=" + totalQuantityRequired;
						} else {
							result = "0=0;" + identifier +  "=" + valueInt;
						}
						// Regimen report
					} else if (parentField.equals("newEstimatedArtPatients")) {
						//String quantityRequiredResupplyIdent = "artRegimenReport." + childField;
						Integer quantityRequiredResupply = 0;
						/*if (PropertyUtils.getProperty(report, quantityRequiredResupplyIdent) != null) {
							quantityRequiredResupply = (Integer) PropertyUtils.getProperty(report, quantityRequiredResupplyIdent);
						}*/
						
						if (PropertyUtils.getMappedProperty(report, "regimenReportMap", keyForMap) != null) {
							//value = regimenReportMap.get("regimen" + regimenCode);
							quantityRequiredResupply =  (Integer) PropertyUtils.getMappedProperty(report, "regimenReportMap", keyForMap);
						}
						
						totalIdent = "totalEstimatedArtPatients." + childField + "." + keyForMap;
						Integer totalQuantityRequired = quantityRequiredResupply + valueInt;
						
						//String parentObjectName = identifier.replace("." +  identifierArray[len-2] + "." + keyForMap, "");
						//Object parent = PropertyUtils.getNestedProperty(report, parentObjectName);
						
						Object parent = PropertyUtils.getNestedProperty(report, "totalEstimatedArtPatients");
						PropertyUtils.setMappedProperty(parent, "regimenReportMap", keyForMap, totalQuantityRequired);
						//PropertyUtils.setProperty(report, totalIdent, totalQuantityRequired);
						result = identifier + "=" + valueInt + ";" + totalIdent +  "=" + totalQuantityRequired;
					} else if (parentField.equals("totalQuantityRequired")) {
						result = "0=0;" + identifier +  "=" + valueInt;
					}
				}
				try {
					ReportOutput.outputReport(reportName, report, clazz, pathXml, pathExcel, null);
				} catch (FileNotFoundException e) {
					result = identifier + "=" + valueInt + ";" + totalIdent +  "=" + "Error: the Excel file for this report is open. Please close.";
				} catch (IOException e) {
					log.debug(e);
				} catch (WrappedRuntimeException e) {
					log.error(e);
					//e.printStackTrace();
				} catch (TransformerException e) {
					log.error(e);
				}
			} catch (IllegalAccessException e) {
				log.debug(e);
			} catch (InvocationTargetException e) {
				log.debug(e);
			} catch (NoSuchMethodException e) {
				log.debug(e);
			}
			//BeanUtils.setProperty(parent, childField, value);
		} else {
			result = identifier + "=" + "Error: No value entered.";
		}
		return result;
	}

	/**
	 * Updates values in dynamic report and outputs to file.
	 * @param identifier
	 * @param reportName
	 * @param value
	 * @return
	 * @throws FileNotFoundException
	 */
	public static String updateDynamicReport(String identifier, String reportName, String value) throws FileNotFoundException {
		String result = "";
		WebContext exec = WebContextFactory.get();
		String username = null;
		SessionUtil zeprs_session = null;
		Site site = null;
		String siteAbbrev = null;
		try {
			username = exec.getHttpServletRequest().getUserPrincipal().getName();
		} catch (NullPointerException e) {
			// unit testing - it's ok...
			username = "demo";
		}
		HttpSession session = exec.getSession();
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

		String parentField = null;
		String childField = null;

		if (identifier.equals("Save") || identifier.equals("SaveNext")) {

		} else {
			String[] identArray = identifier.split("\\.");
			parentField = identArray[0];
			childField = identArray[1];
		}

		Register report = null;
		String className = "org.rti.zcore.dar.report." + StringManipulation.fixClassname(reportName);
		Class clazz = null;
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

		if (identifier.equals("Save") || identifier.equals("SaveNext") || value != null) {
			Integer valueInt = null;
			report = SessionUtil.getInstance(session).getReports().get(reportName);
			String totalIdent = "";
			String reportFileName = report.getReportFileName();
			String pathXml = Constants.ARCHIVE_PATH + site.getAbbreviation() + "/reports/"+reportFileName+".xml";
			String pathExcel = Constants.ARCHIVE_PATH + site.getAbbreviation() + "/reports/"+reportFileName+".xls";
			String xslFile = Constants.REPORTS_XSL_PATH + Constants.pathSep + reportName + "-dynamic.xsl";
			String bdate = report.getBeginDate().toString();
			String edate = report.getEndDate().toString();
			String siteId = String.valueOf(report.getSiteId());
			String jsessionId = session.getId();
			try {
				if (identifier.equals("Save")) {
					result = "Report saved at " + pathExcel;
				} else if (identifier.equals("SaveNext")) {
					String reportId = null;
					if (reportName.equals("CDRRArtReport")) {
						reportId = "7";
						result = "/dar/ChooseReportAction.do;jsessionid=" + jsessionId + "?bdate=" + bdate + "&edate=" + edate + "&siteId=" + siteId + "&report=" + reportId + "&isCombinedReport=1&dynamicReport=1";
					} else if (reportName.equals("CDRROIReport")) {
						reportId = "6";
						result = "/dar/ChooseReportAction.do;jsessionid=" + jsessionId + "?bdate=" + bdate + "&edate=" + edate + "&siteId=" + siteId + "&report=" + reportId + "&isCombinedReport=1&dynamicReport=1";
					} else {
						result = "/dar/reports/combined/gen.do;jsessionid=" + jsessionId + "?dynamicReport=1";
					}
				} else {
					try {
						valueInt = Integer.valueOf(value);
					} catch (NumberFormatException e) {
						try {
							throw new PersistenceException("This input field requires an integer value (e.g.: 55). You entered : " + value, e, false);
						} catch (PersistenceException e1) {
							return result = identifier + "=" + "Error:" + e1.getMessage();
						}
					}

					if (reportName.equals("MonthlyArtReport")) {
						MonthlyArtReport dynamicReport = (MonthlyArtReport)	report;
						ArrayList<RegimenReport> regimenList = dynamicReport.getRegimenList();
						String code = childField.replace("regimen", "");
						totalIdent = "totalEstimatedArtPatients." + childField;
						Integer totalEstimatedArtPatients = 0;
						for (RegimenReport regimenReport : regimenList) {
							String regimenCode = regimenReport.getCode();
							if (regimenCode.equals(code)) {
								regimenReport.setNewEstimatedArtPatients(valueInt);
								int countInt = regimenReport.getCountInt();
								totalEstimatedArtPatients = countInt + valueInt;
								regimenReport.setTotalEstimatedArtPatients(totalEstimatedArtPatients);
								break;
							}
						}
						result = identifier + "=" + valueInt + ";" + totalIdent +  "=" + totalEstimatedArtPatients;
					} else if (reportName.equals("CDRRArtReport")) {
						CDRRArtReport dynamicReport = (CDRRArtReport) report;
						// CDRR Reports
						if (parentField.equals("quantityRequiredNewPatients")) {
							ArrayList<DrugReport> drugReportList = dynamicReport.getDrugReportList();
							String itemId = childField.replace("drug", "");
							//String quantityRequiredResupplyIdent = "quantityRequiredResupply." + childField;
							Integer quantityRequiredResupply = 0;
							for (DrugReport drugReport : drugReportList) {
								String idStr = drugReport.getId().toString();
								if (idStr.equals(itemId)) {
									drugReport.setQuantityRequiredNewPatients(valueInt);
									totalIdent = "totalQuantityRequired." + childField;
									if (drugReport.getQuantityRequiredResupply() != null) {
										quantityRequiredResupply = drugReport.getQuantityRequiredResupply();
									}
									Integer totalQuantityRequired = quantityRequiredResupply + valueInt;
									//PropertyUtils.setProperty(report, totalIdent, totalQuantityRequired);
									result = identifier + "=" + valueInt + ";" + totalIdent +  "=" + totalQuantityRequired;
									drugReport.setTotalQuantityRequired(totalQuantityRequired);
									break;
								}
							}
							/*if (PropertyUtils.getProperty(report, quantityRequiredResupplyIdent) != null) {
								quantityRequiredResupply = (Integer) PropertyUtils.getProperty(report, quantityRequiredResupplyIdent);
							}*/

						} else if (parentField.equals("newEstimatedArtPatients")) {
							String quantityRequiredResupplyIdent = "artRegimenReport." + childField;
							Integer quantityRequiredResupply = 0;
							if (PropertyUtils.getProperty(report, quantityRequiredResupplyIdent) != null) {
								quantityRequiredResupply = (Integer) PropertyUtils.getProperty(report, quantityRequiredResupplyIdent);
							}
							totalIdent = "totalEstimatedArtPatients." + childField;
							Integer totalQuantityRequired = quantityRequiredResupply + valueInt;
							PropertyUtils.setProperty(report, totalIdent, totalQuantityRequired);
							result = identifier + "=" + valueInt + ";" + totalIdent +  "=" + totalQuantityRequired;
						} else if (parentField.equals("totalQuantityRequired")) {
							ArrayList<DrugReport> drugReportList = dynamicReport.getDrugReportList();
							String itemId = childField.replace("drug", "");
							for (DrugReport drugReport : drugReportList) {
								String idStr = drugReport.getId().toString();
								if (idStr.equals(itemId)) {
									drugReport.setTotalQuantityRequired(valueInt);
									result = "0=0;" + identifier +  "=" + valueInt;
									break;
								}
							}
						}
					}
				}
				try {
					ReportOutput.outputReport(reportName, report, clazz, pathXml, pathExcel, xslFile);
				} catch (FileNotFoundException e) {
					result = identifier + "=" + valueInt + ";" + totalIdent +  "=" + "Error: the Excel file for this report is open. Please close.";
				} catch (IOException e) {
					log.debug(e);
				} catch (WrappedRuntimeException e) {
					log.error(e);
					//e.printStackTrace();
				} catch (TransformerException e) {
					log.error(e);
				}
			} catch (IllegalAccessException e) {
				log.debug(e);
			} catch (InvocationTargetException e) {
				log.debug(e);
			} catch (NoSuchMethodException e) {
				log.debug(e);
			}
			//BeanUtils.setProperty(parent, childField, value);
		} else {
			result = identifier + "=" + "Error: No value entered.";
		}
		return result;
	}

}

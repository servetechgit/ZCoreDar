/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report;

import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryLoader;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.rti.zcore.Constants;
import org.rti.zcore.Register;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.StringManipulation;

public class StockUsageReport extends Register {
	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(StockUsageReport.class);

	@Override
	public void getPatientRegister(Date beginDate, Date endDate, int siteId) {
		Connection conn = null;
		try {
			conn = DatabaseUtils.getZEPRSConnection(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);

			HSSFWorkbook wb =  new HSSFWorkbook();
			HSSFCellStyle boldStyle = wb.createCellStyle();
	        HSSFFont font = wb.createFont();
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        boldStyle.setFont(font);

	        HSSFCellStyle headerStyle = wb.createCellStyle();
	        headerStyle.setWrapText(true);
	        headerStyle.setFont(font);
	        //log.debug("Before getPatientStockMap:" + DateUtils.getTime());
			HashMap<Long, List<StockControl>> stockMap = InventoryDAO.getPatientStockMap(conn, siteId, beginDate, endDate);
	        //log.debug("Before EncountersDAO.getAll:" + DateUtils.getTime());
			// loop through all of the items
			//List<Item> items = EncountersDAO.getAll(conn, Long.valueOf(131), "SQL_RETRIEVE_ALL_ADMIN131", Item.class);
			List<Item> items = null;
	    	Map queries = QueryLoader.instance().load("/" + Constants.SQL_GENERATED_PROPERTIES);
	    	String sql = (String) queries.get("SQL_RETRIEVE_ALL_ADMIN131") + " ORDER BY item.name";
	    	ArrayList values = new ArrayList();
	    	items = DatabaseUtils.getList(conn, Item.class, sql, values);
	        //log.debug("Before looping through items:" + DateUtils.getTime());
			//int j = 0;
			boolean generateReport = false;
			for (Item item : items) {
				Boolean useInReport = item.getUse_in_report();
				Long itemId = item.getId();
				useInReport = Boolean.TRUE;
				if ((useInReport != null) && (useInReport.booleanValue() == Boolean.TRUE)) {
					List<StockControl> patientStockChanges = stockMap.get(itemId);
					if (patientStockChanges == null) {
						patientStockChanges = new ArrayList<StockControl>();
					}
					List<StockControl> stockChanges = InventoryDAO.getStockEncounterChanges(conn, itemId, siteId, beginDate, endDate, null, patientStockChanges);
					int stockChangesSize = stockChanges.size();
					//if ((stockChangesSize > 0) ||  ((stockChangesSize == 0 && (item.getUse_in_report() != null)  && (!item.getUse_in_report().equals(Boolean.FALSE))))) {
					if ((stockChangesSize > 0)) {
						generateReport = true;
						StockReport stockReport = InventoryDAO.generateStockSummary(conn, itemId, beginDate, stockChanges, false);
						// populate the common fields
						//HSSFSheet sheet  = wb.getSheetAt(j);
						String fixedName = StringManipulation.escapeString(item.getName())
						.replace("/", " ").replace("\\", " ").replace(",", "_").replace("[", "").replace("(", "-").replace(")", "-");
						int lenName = fixedName.length();
						String itemIdString = String.valueOf(itemId);
						int lenItemId = itemIdString.length();
						String uniqueName = null;
						if ((lenName + lenItemId) < 31) {
							uniqueName = fixedName + "_" + itemId;
							//log.debug(itemId + " size: " + uniqueName.length());
						} else {
							int offset = (30 - lenItemId) -1;
							if (lenName > offset) {
								uniqueName = fixedName.substring(0, offset) + "_" + itemIdString;
								//log.debug(itemId + " size: " + uniqueName.length());
							} else {
								uniqueName = fixedName + "_" + itemId;
							}
						}
						HSSFSheet sheet = null;
						try {
							sheet = wb.createSheet(uniqueName);
						} catch (IllegalArgumentException e) {
							log.debug("Problem with name : " + uniqueName + " Error: " + e.getMessage());
							//this.setType("error");
							// e.printStackTrace();
						}
						String code = "";
						if (item.getCode() != null) {
							code = " (" + item.getCode() + ")";
						}
						if (sheet != null) {
							//sheet.createRow(0).createCell(0).setCellValue(new HSSFRichTextString(item.getName() + code));
							HSSFHeader header = sheet.getHeader();
							header.setCenter(item.getName() + code);
							/*HSSFCell titleCell = sheet.createRow(0).createCell(0);
					titleCell.setCellStyle(boldStyle);
					titleCell.setCellValue(new HSSFRichTextString(item.getName() + code));*/
							//sheet.createRow(2).createCell(0).setCellValue(new HSSFRichTextString("Beginning Balance"));
							HSSFRow row = sheet.createRow(0);
							row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));

							HSSFCell cell = row.createCell(0);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Beginning \nBalance"));

							//sheet.getRow(0).createCell(1).setCellValue(new HSSFRichTextString("Quantity Received this period"));
							cell = row.createCell(1);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Quantity \nReceived \nthis period"));
							//sheet.getRow(0).createCell(2).setCellValue(new HSSFRichTextString("Quantity dispensed this period"));
							cell = row.createCell(2);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Quantity \ndispensed \nthis period"));
							//sheet.getRow(0).createCell(3).setCellValue(new HSSFRichTextString("Total Issued to Patients"));
							cell = row.createCell(3);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Total Issued \nto Patients"));
							//sheet.getRow(0).createCell(4).setCellValue(new HSSFRichTextString("Positive Adjustments"));
							cell = row.createCell(4);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Positive \nAdjustments"));
							//sheet.getRow(0).createCell(5).setCellValue(new HSSFRichTextString("Negative Adjustments"));
							cell = row.createCell(5);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Negative \nAdjustments"));
							//sheet.getRow(0).createCell(6).setCellValue(new HSSFRichTextString("Ending Balance / Physical Count"));
							cell = row.createCell(6);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Ending Balance \nPhysical Count"));

							sheet.autoSizeColumn((short)0);
							sheet.autoSizeColumn((short)1);
							sheet.autoSizeColumn((short)2);
							sheet.autoSizeColumn((short)3);
							sheet.autoSizeColumn((short)4);
							sheet.autoSizeColumn((short)5);
							sheet.autoSizeColumn((short)6);

							sheet.createRow(1).createCell(0).setCellValue(stockReport.getBalanceBF());
							sheet.getRow(1).createCell(1).setCellValue(stockReport.getAdditionsTotal());
							sheet.getRow(1).createCell(2).setCellValue(stockReport.getDeletionsTotal());
							sheet.getRow(1).createCell(3).setCellValue(stockReport.getTotalDispensed());
							sheet.getRow(1).createCell(4).setCellValue(stockReport.getPosAdjustments());
							sheet.getRow(1).createCell(5).setCellValue(stockReport.getNegAdjustments());
							sheet.getRow(1).createCell(6).setCellValue(stockReport.getOnHand());

							row = sheet.createRow(4);
							row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));

							//sheet.createRow(4).createCell(0).setCellValue(new HSSFRichTextString("Date"));
							cell = row.createCell(0);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Date"));
							//sheet.getRow(4).createCell(1).setCellValue(new HSSFRichTextString("Type of Stock Change"));
							cell = row.createCell(1);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Type of \nStock \nChange"));
							//sheet.getRow(4).createCell(2).setCellValue(new HSSFRichTextString("Expiry Date"));
							cell = row.createCell(2);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Expiry \nDate"));
							//sheet.getRow(4).createCell(3).setCellValue(new HSSFRichTextString("Reference / Notes"));
							cell = row.createCell(3);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Reference/ \n Notes"));
							//sheet.getRow(4).createCell(4).setCellValue(new HSSFRichTextString("Additions"));
							cell = row.createCell(4);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Additions"));
							//sheet.getRow(4).createCell(5).setCellValue(new HSSFRichTextString("Subtractions"));
							cell = row.createCell(5);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Subtractions"));
							//sheet.getRow(4).createCell(6).setCellValue(new HSSFRichTextString("Recorded Balance"));
							cell = row.createCell(6);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Recorded \nBalance"));
							//sheet.getRow(4).createCell(7).setCellValue(new HSSFRichTextString("Calculated Balance"));
							cell = row.createCell(7);
							cell.setCellStyle(headerStyle);
							cell.setCellValue(new HSSFRichTextString("Calculated \nBalance"));

							sheet.autoSizeColumn((short)7);

							int k = 4;

							for (StockControl stockControl : stockChanges) {
								if (stockControl.getDate_of_record() != null) {
									k++;
									String stockChangeTypeString = null;
									Integer posAdjust = null;
									Integer negAdjust = null;
									if (stockControl.getType_of_change() != null) {
										int stockChangeType = stockControl.getType_of_change();
										switch (stockChangeType) {
										case 3263:
											stockChangeTypeString = "Received";
											posAdjust = stockControl.getChange_value();
											break;
										case 3264:
											stockChangeTypeString = "Issued";
											negAdjust = stockControl.getChange_value();
											break;
										case 3265:
											stockChangeTypeString = "Losses";
											negAdjust = stockControl.getChange_value();
											break;
										case 3266:
											stockChangeTypeString = "Pos. Adjust.";
											posAdjust = stockControl.getChange_value();
											break;
										case 3267:
											stockChangeTypeString = "Neg. Adjust.";
											negAdjust = stockControl.getChange_value();
											break;
										case 3279:
											stockChangeTypeString = "Out-of-stock";
											break;

										default:
											break;
										}
									}


									row = sheet.createRow(k);

									if (stockControl.getDate_of_record() != null) {
										Date dateRecord = stockControl.getDate_of_record();
										row.createCell(0).setCellValue(new HSSFRichTextString(dateRecord.toString()));
									} else {
										row.createCell(0).setCellValue(new HSSFRichTextString(""));
									}
									row.createCell(1).setCellValue(new HSSFRichTextString(stockChangeTypeString));
									if (stockControl.getExpiry_date() != null) {
										Date expiryDate = stockControl.getExpiry_date();
										row.createCell(2).setCellValue(new HSSFRichTextString(expiryDate.toString()));
									} else {
										row.createCell(2).setCellValue(new HSSFRichTextString(""));
									}
									row.createCell(3).setCellValue(new HSSFRichTextString(stockControl.getNotes()));
									if (posAdjust != null) {
										row.createCell(4).setCellValue(posAdjust);
									}
									if (negAdjust != null) {
										row.createCell(5).setCellValue(negAdjust);
									}
									if (stockControl.getBalance() != null) {
										row.createCell(6).setCellValue(stockControl.getBalance());
									}
									if (stockControl.getComputedBalance() != null) {
										row.createCell(7).setCellValue(stockControl.getComputedBalance());
									}
								}
							}
						}
					}
				}
				//j++;
			}
			if (generateReport) {
				FileOutputStream stream = new FileOutputStream(this.getReportPath());
				wb.write(stream);
				stream.close();
			} else {
				this.setType("empty");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				log.error(e);
			}
		}
	}

}

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

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.TextFile;


public class CDRRArtSheetPopulater {
	
	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(CDRRArtSheetPopulater.class);

	/**
	 * @param aReport
	 * @param aSsheet
	 * @param i - rowOffset - if template changes, you may need to change the offset.
	 */
	public static void populateCDRRArtSheet(DailyActivityReport aReport, HSSFSheet aSsheet, int i) {
		// fix error in template
		// aSsheet.getRow(i + 39).getCell(3).setCellType(HSSFCell.CELL_TYPE_BLANK);
		// now fill in the report data
		
		String filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "cdrr.txt";
		int balanceBFCellNum = 0;
		int receivedCellNum = 0;
		int totalDispensedCellNum = 0;
		int lossesCellNum = 0;
		int posAdjustmentsCellNum = 0;
		int negAdjustmentsCellNum = 0;
		int balanceCFCellNum = 0;
		int quantity6MonthsExpiredCellNum = 0;
		int expiryDateCellNum = 0;
		int daysOutOfStockCellNum = 0;
		int quantityRequiredResupplyCellNum = 0;
		/*int quantityRequiredNewPatientsCellNum = 0;
		int totalQuantityRequiredCellNum = 0;*/
		
		String sectionName = "";
	    for(String line : new TextFile(filename)) {
	    	// System.out.println(line);
	    	String[] lineArray = line.split("\\|");
	    	// process cell numbers
	    	if (lineArray[0].equals("balanceBF")) {
	    		balanceBFCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("received")) {
	    		receivedCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("totalDispensed")) {
	    		totalDispensedCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("losses")) {
	    		lossesCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("posAdjustments")) {
	    		posAdjustmentsCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("negAdjustments")) {
	    		negAdjustmentsCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("balanceCF")) {
	    		balanceCFCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("quantity6MonthsExpired")) {
	    		quantity6MonthsExpiredCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("expiryDate")) {
	    		expiryDateCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("daysOutOfStock")) {
	    		daysOutOfStockCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("quantityRequiredResupply")) {
	    		quantityRequiredResupplyCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	/*} else if (lineArray[0].equals("quantityRequiredNewPatients")) {
	    		quantityRequiredNewPatientsCellNum = Integer.valueOf(lineArray[1]) - 1;
	    	} else if (lineArray[0].equals("totalQuantityRequired")) {
	    		totalQuantityRequiredCellNum = Integer.valueOf(lineArray[1]) - 1;*/
	    	} else {
	    		if (lineArray[0].startsWith("stock_")) {
	    			if (!sectionName.equals(lineArray[0])) {
			    		sectionName = lineArray[0];
			    		String cellNumStr = lineArray[1];
			    		i = Integer.valueOf(cellNumStr) - 1;
			    		//break;
			    	} else {
			    		//Integer nowInt = Integer.valueOf(rowNum);
				    	String drugName = lineArray[1];
				    	StockReport stockReport = aReport.getStockReportMap().get(drugName);
				    	if (stockReport != null) {
				    		if (stockReport.getBalanceBF() != null) {
								aSsheet.getRow(i).getCell(balanceBFCellNum).setCellValue(stockReport.getBalanceBF());
							}
							if (stockReport.getReceived() != null) {
								log.debug("drugName: " + drugName + " receivedCellNum: " + receivedCellNum + " stockReport.getReceived(): " + stockReport.getReceived());
								aSsheet.getRow(i).getCell(receivedCellNum).setCellValue(stockReport.getReceived());
							}
							if (stockReport.getTotalDispensed() != null) {
								aSsheet.getRow(i).getCell(totalDispensedCellNum).setCellValue(stockReport.getTotalDispensed());
							}
							if (stockReport.getLosses() != null) {
								aSsheet.getRow(i).getCell(lossesCellNum).setCellValue(stockReport.getLosses());
							}
							if ((stockReport.getPosAdjustments() != null) && (stockReport.getNegAdjustments() != null)) {
								String adjustmentValue = stockReport.getPosAdjustments().toString() + " (" + stockReport.getNegAdjustments() + ")";
								aSsheet.getRow(i).getCell(posAdjustmentsCellNum).setCellValue(adjustmentValue);
							}
							if ((stockReport.getPosAdjustments() != null) && (stockReport.getNegAdjustments() == null)) {
								aSsheet.getRow(i).getCell(posAdjustmentsCellNum).setCellValue(stockReport.getPosAdjustments());
							}
							if((stockReport.getPosAdjustments() == null) && (stockReport.getNegAdjustments() != null)) {
								aSsheet.getRow(i).getCell(negAdjustmentsCellNum).setCellValue("(" + stockReport.getNegAdjustments() + ")");
							}
							if (stockReport.getBalanceCF() != null) {
								log.debug("drugName: " + drugName + " onHandCellNum: " + balanceCFCellNum + " stockReport.getBalanceCF(): " + stockReport.getBalanceCF());
								aSsheet.getRow(i).getCell(balanceCFCellNum).setCellValue(stockReport.getBalanceCF());
							}
							if (stockReport.getQuantity6MonthsExpired() != null) {
								log.debug("drugName: " + drugName + " quantity6MonthsExpiredCellNum: " + quantity6MonthsExpiredCellNum + " stockReport.getBalanceCF(): "
								+ stockReport.getBalanceCF() + " stockReport.getQuantity6MonthsExpired(): " + stockReport.getQuantity6MonthsExpired());
								aSsheet.getRow(i).getCell(quantity6MonthsExpiredCellNum).setCellValue(stockReport.getQuantity6MonthsExpired());
							}
							if (stockReport.getExpiryDate() != null) {
								log.debug("drugName: " + drugName + " onHandCellNum: " + balanceCFCellNum + " stockReport.getBalanceCF(): "
								+ stockReport.getBalanceCF() + " stockReport.getExpiryDate(): " + stockReport.getExpiryDate());
								aSsheet.getRow(i).getCell(expiryDateCellNum).setCellValue(stockReport.getExpiryDate());
							}
							if (stockReport.getDaysOutOfStock() != null) {
								aSsheet.getRow(i).getCell(daysOutOfStockCellNum).setCellValue(stockReport.getDaysOutOfStock());
							}
							if (stockReport.getQuantityRequiredResupply() != null) {
								aSsheet.getRow(i).getCell(quantityRequiredResupplyCellNum).setCellValue(stockReport.getQuantityRequiredResupply());
							}
							/*if (stockReport.getQuantityRequiredNewPatients() != null) {
								aSsheet.getRow(i).getCell(quantityRequiredNewPatientsCellNum).setCellValue(stockReport.getQuantityRequiredNewPatients());
							}
							if (stockReport.getTotalQuantityRequired() != null) {
								aSsheet.getRow(i).getCell(totalQuantityRequiredCellNum).setCellValue(stockReport.getTotalQuantityRequired());
							}*/
				    	}
				    	i++;
			    	}
	    		}
	    	}
	    	//Integer artRegimenReportValue = 	
	    	/*if (artRegimenReportValue != null) {
	    		HSSFCell cell = mSsheet.getRow(i + nowInt).getCell(2);
	    		//cell.setCellValue((String) ((artRegimenReportValue == null) ? "":artRegimenReportValue));
	    		cell.setCellValue(artRegimenReportValue);
	    	}
	    	Integer newEstimatedArtPatientsValue = mReport.getNewEstimatedArtPatients().getRegimenReportMap().get("regimen" + drugName);
	    	if (newEstimatedArtPatientsValue != null) {
	    		HSSFCell cell = mSsheet.getRow(i + nowInt).getCell(3);
	    		cell.setCellValue(newEstimatedArtPatientsValue);
	    	}
	    	Integer totalEstimatedArtPatientsValue = mReport.getTotalEstimatedArtPatients().getRegimenReportMap().get("regimen" + drugName);
	    	if (totalEstimatedArtPatientsValue != null) {
	    		HSSFCell cell = mSsheet.getRow(i + nowInt).getCell(5);
	    		cell.setCellValue(newEstimatedArtPatientsValue);
	    	}*/
	    }
	}

	/**
	 *
	 * @param aReport
	 * @param aSsheet
	 * @param currentRow - if you want the list to start at n, set currentRow to n-1.
	 * @param wb
	 * @param isFacilityReport
	 */
	/*public static void populateDynamicCDRRArtSheet(DailyActivityReport aReport, HSSFSheet aSsheet, int currentRow, HSSFWorkbook wb, boolean isFacilityReport) {
		// fix error in template
		//aSsheet.getRow(i + 39).getCell(3).setCellType(HSSFCell.CELL_TYPE_BLANK);
		ArrayList<DrugReport> list = aReport.getDrugReportList();
		//int currentRow = 11;
		int currentItem = 0;
		if (list.size() > 0) {
			if (isFacilityReport) {
				// aSsheet.shiftRows(44, 64, (list.size()), true, true);
			} else {
				aSsheet.shiftRows(43, 66, (list.size()), true, true);
			}
			HSSFCellStyle headerStyle = wb.createCellStyle();
			headerStyle.setFillForegroundColor(HSSFColor.GREY_50_PERCENT.index);
			headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			headerStyle.setBorderTop(HSSFCellStyle.BORDER_THICK);
			headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THICK);

	        HSSFFont font = wb.createFont();
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        font.setFontHeightInPoints((short) 12);
	        headerStyle.setFont(font);
	        HSSFCellStyle rowStyle28 = aSsheet.getRow(28).getCell(0).getCellStyle();
			//aSsheet.getRow(currentRow).setRowStyle(headerStyle);
	        aSsheet.createRow(currentRow).setHeightInPoints(14);
			aSsheet.getRow(currentRow).createCell(0).setCellValue(new HSSFRichTextString("Other Preparations"));
			aSsheet.getRow(currentRow).getCell(0).setCellStyle(rowStyle28);
			aSsheet.addMergedRegion(new CellRangeAddress(
		            43, //first row (0-based)
		            43, //last row  (0-based)
		            0, //first column (0-based)
		            16  //last column  (0-based)
		    ));
		}

        HSSFCellStyle cellStyle42 = aSsheet.getRow(42).getCell(0).getCellStyle();
        HSSFCellStyle cellStyle8 = aSsheet.getRow(27).getCell(8).getCellStyle();
        HSSFCellStyle cellStyle9 = aSsheet.getRow(27).getCell(9).getCellStyle();
        HSSFCellStyle defaultStyle = wb.createCellStyle();
        defaultStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        defaultStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		for (DrugReport report : list) {
			currentRow++;
			currentItem++;
			Item item = report.getItem();
			HSSFRichTextString name = new HSSFRichTextString(report.getName());
			HSSFRichTextString unit = new HSSFRichTextString(item.getUnit());
			aSsheet.createRow(currentRow).setHeightInPoints(16);
			//aSsheet.getRow(currentRow).setRowStyle(defaultStyle);
			aSsheet.getRow(currentRow).createCell(0).setCellValue(name);
			aSsheet.getRow(currentRow).getCell(0).setCellStyle(defaultStyle);
			aSsheet.getRow(currentRow).setHeightInPoints(16);
			aSsheet.getRow(currentRow).createCell(1).setCellValue(unit);
			aSsheet.getRow(currentRow).getCell(1).setCellStyle(defaultStyle);

			aSsheet.getRow(currentRow).createCell(2);
			aSsheet.getRow(currentRow).getCell(2).setCellStyle(defaultStyle);
			if (report.getBalanceBF() != null) {
				aSsheet.getRow(currentRow).getCell(2).setCellValue(report.getBalanceBF());
			}
			aSsheet.getRow(currentRow).createCell(3);
			aSsheet.getRow(currentRow).getCell(3).setCellStyle(defaultStyle);
			if (report.getReceived() != null) {
				aSsheet.getRow(currentRow).getCell(3).setCellValue(report.getReceived());
			}
			aSsheet.getRow(currentRow).createCell(4);
			aSsheet.getRow(currentRow).getCell(4).setCellStyle(defaultStyle);
			if (report.getTotalDispensed() != null) {
				aSsheet.getRow(currentRow).getCell(4).setCellValue(report.getTotalDispensed());
			}
			aSsheet.getRow(currentRow).createCell(5);
			aSsheet.getRow(currentRow).getCell(5).setCellStyle(defaultStyle);
			if (report.getLosses() != null) {
				aSsheet.getRow(currentRow).getCell(5).setCellValue(report.getLosses());
			}
			aSsheet.getRow(currentRow).createCell(6);
			aSsheet.getRow(currentRow).getCell(6).setCellStyle(defaultStyle);
			if (report.getPosAdjustments() != null) {
				aSsheet.getRow(currentRow).getCell(6).setCellValue(report.getPosAdjustments());
			}
			aSsheet.getRow(currentRow).createCell(6);
			aSsheet.getRow(currentRow).getCell(6).setCellStyle(defaultStyle);
			if (report.getNegAdjustments() != null) {
				//aSsheet.getRow(currentRow).getCell(6).setCellValue(report.getNegAdjustments());
				HSSFRichTextString text = new HSSFRichTextString("(" + report.getNegAdjustments().toString() + ")");
				aSsheet.getRow(currentRow).getCell(6).setCellValue(text);
			}
			aSsheet.getRow(currentRow).createCell(7);
			aSsheet.getRow(currentRow).getCell(7).setCellStyle(defaultStyle);
			if (report.getOnHand()!= null) {
				aSsheet.getRow(currentRow).getCell(7).setCellValue(report.getOnHand());
			}

			aSsheet.getRow(currentRow).createCell(8);
			aSsheet.getRow(currentRow).getCell(8).setCellStyle(cellStyle8);
			aSsheet.getRow(currentRow).createCell(9);
			aSsheet.getRow(currentRow).getCell(9).setCellStyle(cellStyle9);
			aSsheet.getRow(currentRow).createCell(10);
			aSsheet.getRow(currentRow).getCell(10).setCellStyle(cellStyle9);
			aSsheet.getRow(currentRow).createCell(11);
			aSsheet.getRow(currentRow).getCell(11).setCellStyle(cellStyle8);

			aSsheet.getRow(currentRow).createCell(12);
			aSsheet.getRow(currentRow).getCell(12).setCellStyle(defaultStyle);
			if (report.getQuantity6MonthsExpired()!= null) {
				aSsheet.getRow(currentRow).getCell(12).setCellValue(report.getQuantity6MonthsExpired());
			}
			aSsheet.getRow(currentRow).createCell(13);
			aSsheet.getRow(currentRow).getCell(13).setCellStyle(defaultStyle);
			if (report.getExpiryDate() != null) {
				aSsheet.getRow(currentRow).getCell(13).setCellValue(report.getExpiryDate());
			}
			aSsheet.getRow(currentRow).createCell(14);
			aSsheet.getRow(currentRow).getCell(14).setCellStyle(defaultStyle);
			if (report.getDaysOutOfStock() != null) {
				aSsheet.getRow(currentRow).getCell(14).setCellValue(report.getDaysOutOfStock());
			}
			aSsheet.getRow(currentRow).createCell(15);
			aSsheet.getRow(currentRow).getCell(15).setCellStyle(defaultStyle);
			if (report.getQuantityRequiredResupply() != null) {
				aSsheet.getRow(currentRow).getCell(15).setCellValue(report.getQuantityRequiredResupply());
			}
			aSsheet.getRow(currentRow).createCell(16);
			aSsheet.getRow(currentRow).getCell(16).setCellStyle(defaultStyle);
			if (report.getQuantityRequiredNewPatients() != null) {
				aSsheet.getRow(currentRow).getCell(16).setCellValue(report.getQuantityRequiredNewPatients());
			}
			//aSsheet.getRow(currentRow).createCell(17);
			//aSsheet.getRow(currentRow).getCell(17).setCellStyle(defaultStyle);
			if (report.getTotalQuantityRequired() != null) {
				aSsheet.getRow(currentRow).getCell(17).setCellValue(report.getTotalQuantityRequired());
			}
		}
	}*/
}

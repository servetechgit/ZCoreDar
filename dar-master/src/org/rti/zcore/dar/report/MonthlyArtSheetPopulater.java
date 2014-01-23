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
import java.util.ArrayList;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.rti.zcore.dar.report.valueobject.RegimenReport;
import org.rti.zcore.dar.utils.TextFile;

public class MonthlyArtSheetPopulater {

	/**
	 * @param mReport
	 * @param mSsheet
	 * @param i - rowOffset - if template changes, you may need to change the offset.
	 */
	public static void populateMonthlyArtSheet(MonthlyArtReport mReport, HSSFSheet mSsheet, int i) {
		String filename = org.rti.zcore.Constants.getPathToCatalinaHome() + "databases" + File.separator  +  "regimens.txt";
	    for(String line : new TextFile(filename)) {
	    	//System.out.println(line);
	    	String[] lineArray = line.split("\\|");
	    	if (lineArray[0].startsWith("regimen_")) {
	    		String rowNum = lineArray[1];
		    	Integer rowInt = Integer.valueOf(rowNum)-1;
		    	String cellNumStr = lineArray[2];
				int cellNum = Integer.valueOf(cellNumStr)-1;
				if (lineArray.length > 3) {
					String regimenName = lineArray[3];
			    	Integer artRegimenReportValue = mReport.getArtRegimenReport().getRegimenReportMap().get("regimen" + regimenName);
			    	if (artRegimenReportValue != null) {
			    		HSSFCell cell = mSsheet.getRow(rowInt).getCell(cellNum);
			    		cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			    		//cell.setCellValue((String) ((artRegimenReportValue == null) ? "":artRegimenReportValue));
			    		cell.setCellValue(artRegimenReportValue);
			    	}
				}
		    	/*Integer newEstimatedArtPatientsValue = mReport.getNewEstimatedArtPatients().getRegimenReportMap().get("regimen" + regimenName);
		    	if (newEstimatedArtPatientsValue != null) {
		    		HSSFCell cell = mSsheet.getRow(i + rowInt).getCell(3);
		    		cell.setCellValue(newEstimatedArtPatientsValue);
		    	}
		    	Integer totalEstimatedArtPatientsValue = mReport.getTotalEstimatedArtPatients().getRegimenReportMap().get("regimen" + regimenName);
		    	if (totalEstimatedArtPatientsValue != null) {
		    		HSSFCell cell = mSsheet.getRow(i + rowInt).getCell(5);
		    		cell.setCellValue(newEstimatedArtPatientsValue);
		    	}*/
	    	}
	    }
	}

	/**
	 * Populates the monthly ART Sheet
	 * If this is the standalone dynamic sheet, set currentRow = 11.
	 * @param mReport
	 * @param mSsheet
	 * @param currentRow - if you want the list to start at n, set currentRow to n-1.
	 */
	public static void populateDynamicMonthlyArtSheet(MonthlyArtReport mReport, HSSFSheet mSsheet, int currentRow) {
		ArrayList<RegimenReport> regimenList = mReport.getRegimenList();
		//if (regimenList.size() > 2) {
			//int shiftRows = regimenList.size() - 2;
		if (regimenList.size() > 0) {
			mSsheet.shiftRows(101, 123, regimenList.size(), true,true);
		}
		//}
		for (RegimenReport regimenReport : regimenList) {
			currentRow++;
			HSSFRichTextString code = new HSSFRichTextString(regimenReport.getCode());
			HSSFRichTextString name = new HSSFRichTextString(regimenReport.getName());
			/*HSSFRow row = mSsheet.createRow(currentRow);
			HSSFCell cell = row.createCell(0);
			cell.setCellValue(code);*/
			mSsheet.createRow(currentRow).createCell(0).setCellValue(code);
			mSsheet.getRow(currentRow).createCell(1).setCellValue(name);
			//mSsheet.getRow(currentRow).getCell(1).setCellValue(name);
			mSsheet.getRow(currentRow).createCell(2).setCellValue(regimenReport.getCountInt());
			mSsheet.getRow(currentRow).createCell(4).setCellValue(regimenReport.getNewEstimatedArtPatients());
			mSsheet.getRow(currentRow).createCell(6).setCellValue(regimenReport.getTotalEstimatedArtPatients());
		}
	}

}

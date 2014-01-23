/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.utils;

import java.io.FileInputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public class PoiUtils {

	/**
	 * This utility is a version of HSSF.main that does not use deprecated methods.
	 * It is helpful in figuring out what row a filed is on when outputting Excel files via POI.
	 * @param pathExcelMaster
	 */
	public static void testExcelOutput(String pathExcelMaster) {

		try
		{
			//HSSF hssf = new HSSF(args[ 0 ]);

			System.out.println("Data dump:\n");
			//HSSFWorkbook wb = hssf.hssfworkbook;
			POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(pathExcelMaster));
			HSSFWorkbook wb =  new HSSFWorkbook(fs);

			for (int k = 0; k < wb.getNumberOfSheets(); k++)
			{
				System.out.println("Sheet " + k);
				HSSFSheet sheet = wb.getSheetAt(k);
				int       rows  = sheet.getPhysicalNumberOfRows();

				for (int r = 0; r < rows; r++)
				{
					//HSSFRow row   = sheet.getPhysicalRowAt(r);
					HSSFRow row   = sheet.getRow(r);
					if (row != null) {
						int     cells = row.getPhysicalNumberOfCells();
						System.out.println("ROW " + row.getRowNum());
						for (int c = 0; c < cells; c++)
						{
							//HSSFCell cell  = row.getPhysicalCellAt(c);
							HSSFCell cell  = row.getCell(c);
							String   value = null;
							if (cell != null) {
								switch (cell.getCellType())
								{

								case HSSFCell.CELL_TYPE_FORMULA :
									value = "FORMULA ";
									value = "FORMULA " + cell.getCellFormula();
									break;

								case HSSFCell.CELL_TYPE_NUMERIC :
									value = "NUMERIC value="
										+ cell.getNumericCellValue();
									break;

								case HSSFCell.CELL_TYPE_STRING :
									//value = "STRING value=" + cell.getStringCellValue();
									HSSFRichTextString str = cell.getRichStringCellValue();
									value = "STRING value=" + str;
									break;

								default :
								}
								//System.out.println("CELL col=" + cell.getCellNum()  + " VALUE=" + value);
								System.out.println("CELL col=" + cell.getColumnIndex()  + " VALUE=" + value);
							}
						}
					}
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}

}

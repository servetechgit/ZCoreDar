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

import java.util.ArrayList;

import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.report.valueobject.DrugReport;

public class CDRROiSheetPopulater {

	/**
	 * @param oReport
	 * @param oSsheet
	 */
	public static void populateCDRRPOiSheet(CDRROIReport oReport, HSSFSheet oSsheet) {

		if (oReport.getBalanceBF().getDiflucan200mg() != null) {
			oSsheet.getRow(13).getCell(2).setCellValue(oReport.getBalanceBF().getDiflucan200mg());
		}
		if (oReport.getReceived().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(3).setCellValue(oReport.getReceived().getDiflucan200mg());
		}
		if (oReport.getTotalDispensed().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(4).setCellValue(oReport.getTotalDispensed().getDiflucan200mg());
		}
		if (oReport.getLosses().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(5).setCellValue(oReport.getLosses().getDiflucan200mg());
		}
		if (oReport.getPosAdjustments().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(6).setCellValue(oReport.getPosAdjustments().getDiflucan200mg());
		}
		if (oReport.getNegAdjustments().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(7).setCellValue(oReport.getNegAdjustments().getDiflucan200mg());
		}
		if (oReport.getOnHand().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(8).setCellValue(oReport.getOnHand().getDiflucan200mg());
		}
		if (oReport.getQuantity6MonthsExpired().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getDiflucan200mg());
		}
		if (oReport.getExpiryDate().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getDiflucan200mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(11).setCellValue(oReport.getDaysOutOfStock().getDiflucan200mg());
		}
		if (oReport.getQuantityRequiredResupply().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getDiflucan200mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getDiflucan200mg());
		}
		if (oReport.getTotalQuantityRequired().getDiflucan200mg() != null) {
		oSsheet.getRow(13).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getDiflucan200mg());
		}

		//getdiflucansuspension
		if (oReport.getBalanceBF().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(2).setCellValue(oReport.getBalanceBF().getDiflucansuspension());
		}
		if (oReport.getReceived().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(3).setCellValue(oReport.getReceived().getDiflucansuspension());
		}
		if (oReport.getTotalDispensed().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(4).setCellValue(oReport.getTotalDispensed().getDiflucansuspension());
		}
		if (oReport.getLosses().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(5).setCellValue(oReport.getLosses().getDiflucansuspension());
		}
		if (oReport.getPosAdjustments().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(6).setCellValue(oReport.getPosAdjustments().getDiflucansuspension());
		}
		if (oReport.getNegAdjustments().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(7).setCellValue(oReport.getNegAdjustments().getDiflucansuspension());
		}
		if (oReport.getOnHand().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(8).setCellValue(oReport.getOnHand().getDiflucansuspension());
		}
		if (oReport.getQuantity6MonthsExpired().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getDiflucansuspension());
		}
		if (oReport.getExpiryDate().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getDiflucansuspension().toString()));
		}
		if (oReport.getDaysOutOfStock().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(11).setCellValue(oReport.getDaysOutOfStock().getDiflucansuspension());
		}
		if (oReport.getQuantityRequiredResupply().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getDiflucansuspension());
		}
		if (oReport.getQuantityRequiredNewPatients().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getDiflucansuspension());
		}
		if (oReport.getTotalQuantityRequired().getDiflucansuspension() != null) {
			oSsheet.getRow(14).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getDiflucansuspension());
		}

		//getdiflucanInfusion
		if (oReport.getBalanceBF().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(2).setCellValue(oReport.getBalanceBF().getDiflucanInfusion());
		}
		if (oReport.getReceived().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(3).setCellValue(oReport.getReceived().getDiflucanInfusion());
		}
		if (oReport.getTotalDispensed().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(4).setCellValue(oReport.getTotalDispensed().getDiflucanInfusion());
		}
		if (oReport.getLosses().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(5).setCellValue(oReport.getLosses().getDiflucanInfusion());
		}
		if (oReport.getPosAdjustments().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(6).setCellValue(oReport.getPosAdjustments().getDiflucanInfusion());
		}
		if (oReport.getNegAdjustments().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(7).setCellValue(oReport.getNegAdjustments().getDiflucanInfusion());
		}
		if (oReport.getOnHand().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(8).setCellValue(oReport.getOnHand().getDiflucanInfusion());
		}
		if (oReport.getQuantity6MonthsExpired().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getDiflucanInfusion());
		}
		if (oReport.getExpiryDate().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getDiflucanInfusion().toString()));
		}
		if (oReport.getDaysOutOfStock().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(11).setCellValue(oReport.getDaysOutOfStock().getDiflucanInfusion());
		}
		if (oReport.getQuantityRequiredResupply().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getDiflucanInfusion());
		}
		if (oReport.getQuantityRequiredNewPatients().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getDiflucanInfusion());
		}
		if (oReport.getTotalQuantityRequired().getDiflucanInfusion() != null) {
			oSsheet.getRow(15).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getDiflucanInfusion());
		}

		//getfluconazole200mg
		if (oReport.getBalanceBF().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(2).setCellValue(oReport.getBalanceBF().getFluconazole200mg());
		}
		if (oReport.getReceived().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(3).setCellValue(oReport.getReceived().getFluconazole200mg());
		}
		if (oReport.getTotalDispensed().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(4).setCellValue(oReport.getTotalDispensed().getFluconazole200mg());
		}
		if (oReport.getLosses().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(5).setCellValue(oReport.getLosses().getFluconazole200mg());
		}
		if (oReport.getPosAdjustments().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(6).setCellValue(oReport.getPosAdjustments().getFluconazole200mg());
		}
		if (oReport.getNegAdjustments().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(7).setCellValue(oReport.getNegAdjustments().getFluconazole200mg());
		}
		if (oReport.getOnHand().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(8).setCellValue(oReport.getOnHand().getFluconazole200mg());
		}
		if (oReport.getQuantity6MonthsExpired().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getFluconazole200mg());
		}
		if (oReport.getExpiryDate().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getFluconazole200mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(11).setCellValue(oReport.getDaysOutOfStock().getFluconazole200mg());
		}
		if (oReport.getQuantityRequiredResupply().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getFluconazole200mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getFluconazole200mg());
		}
		if (oReport.getTotalQuantityRequired().getFluconazole200mg() != null) {
			oSsheet.getRow(16).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getFluconazole200mg());
		}

		//getfluconazole150mg
		if (oReport.getBalanceBF().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(2).setCellValue(oReport.getBalanceBF().getFluconazole150mg());
		}
		if (oReport.getReceived().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(3).setCellValue(oReport.getReceived().getFluconazole150mg());
		}
		if (oReport.getTotalDispensed().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(4).setCellValue(oReport.getTotalDispensed().getFluconazole150mg());
		}
		if (oReport.getLosses().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(5).setCellValue(oReport.getLosses().getFluconazole150mg());
		}
		if (oReport.getPosAdjustments().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(6).setCellValue(oReport.getPosAdjustments().getFluconazole150mg());
		}
		if (oReport.getNegAdjustments().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(7).setCellValue(oReport.getNegAdjustments().getFluconazole150mg());
		}
		if (oReport.getOnHand().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(8).setCellValue(oReport.getOnHand().getFluconazole150mg());
		}
		if (oReport.getQuantity6MonthsExpired().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getFluconazole150mg());
		}
		if (oReport.getExpiryDate().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getFluconazole150mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(11).setCellValue(oReport.getDaysOutOfStock().getFluconazole150mg());
		}
		if (oReport.getQuantityRequiredResupply().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getFluconazole150mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getFluconazole150mg());
		}
		if (oReport.getTotalQuantityRequired().getFluconazole150mg() != null) {
			oSsheet.getRow(17).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getFluconazole150mg());
		}

		//getfluconazole50mg
		if (oReport.getBalanceBF().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(2).setCellValue(oReport.getBalanceBF().getFluconazole50mg());
		}
		if (oReport.getReceived().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(3).setCellValue(oReport.getReceived().getFluconazole50mg());
		}
		if (oReport.getTotalDispensed().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(4).setCellValue(oReport.getTotalDispensed().getFluconazole50mg());
		}
		if (oReport.getLosses().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(5).setCellValue(oReport.getLosses().getFluconazole50mg());
		}
		if (oReport.getPosAdjustments().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(6).setCellValue(oReport.getPosAdjustments().getFluconazole50mg());
		}
		if (oReport.getNegAdjustments().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(7).setCellValue(oReport.getNegAdjustments().getFluconazole50mg());
		}
		if (oReport.getOnHand().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(8).setCellValue(oReport.getOnHand().getFluconazole50mg());
		}
		if (oReport.getQuantity6MonthsExpired().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getFluconazole50mg());
		}
		if (oReport.getExpiryDate().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getFluconazole50mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(11).setCellValue(oReport.getDaysOutOfStock().getFluconazole50mg());
		}
		if (oReport.getQuantityRequiredResupply().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getFluconazole50mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getFluconazole50mg());
		}
		if (oReport.getTotalQuantityRequired().getFluconazole50mg() != null) {
			oSsheet.getRow(18).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getFluconazole50mg());
		}

		//getketaconazole200mg
		if (oReport.getBalanceBF().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(2).setCellValue(oReport.getBalanceBF().getKetaconazole200mg());
		}
		if (oReport.getReceived().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(3).setCellValue(oReport.getReceived().getKetaconazole200mg());
		}
		if (oReport.getTotalDispensed().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(4).setCellValue(oReport.getTotalDispensed().getKetaconazole200mg());
		}
		if (oReport.getLosses().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(5).setCellValue(oReport.getLosses().getKetaconazole200mg());
		}
		if (oReport.getPosAdjustments().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(6).setCellValue(oReport.getPosAdjustments().getKetaconazole200mg());
		}
		if (oReport.getNegAdjustments().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(7).setCellValue(oReport.getNegAdjustments().getKetaconazole200mg());
		}
		if (oReport.getOnHand().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(8).setCellValue(oReport.getOnHand().getKetaconazole200mg());
		}
		if (oReport.getQuantity6MonthsExpired().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getKetaconazole200mg());
		}
		if (oReport.getExpiryDate().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getKetaconazole200mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(11).setCellValue(oReport.getDaysOutOfStock().getKetaconazole200mg());
		}
		if (oReport.getQuantityRequiredResupply().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getKetaconazole200mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getKetaconazole200mg());
		}
		if (oReport.getTotalQuantityRequired().getKetaconazole200mg() != null) {
			oSsheet.getRow(19).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getKetaconazole200mg());
		}

		//getmiconazoleNitrate2OralGel
		if (oReport.getBalanceBF().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(2).setCellValue(oReport.getBalanceBF().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getReceived().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(3).setCellValue(oReport.getReceived().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getTotalDispensed().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(4).setCellValue(oReport.getTotalDispensed().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getLosses().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(5).setCellValue(oReport.getLosses().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getPosAdjustments().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(6).setCellValue(oReport.getPosAdjustments().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getNegAdjustments().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(7).setCellValue(oReport.getNegAdjustments().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getOnHand().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(8).setCellValue(oReport.getOnHand().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getQuantity6MonthsExpired().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getExpiryDate().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getMiconazoleNitrate2OralGel().toString()));
		}
		if (oReport.getDaysOutOfStock().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(11).setCellValue(oReport.getDaysOutOfStock().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getQuantityRequiredResupply().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getQuantityRequiredNewPatients().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getMiconazoleNitrate2OralGel());
		}
		if (oReport.getTotalQuantityRequired().getMiconazoleNitrate2OralGel() != null) {
			oSsheet.getRow(20).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getMiconazoleNitrate2OralGel());
		}

		//getnystatinOralSuspension100000Units
		if (oReport.getBalanceBF().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(2).setCellValue(oReport.getBalanceBF().getNystatinOralSuspension100000Units());
		}
		if (oReport.getReceived().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(3).setCellValue(oReport.getReceived().getNystatinOralSuspension100000Units());
		}
		if (oReport.getTotalDispensed().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(4).setCellValue(oReport.getTotalDispensed().getNystatinOralSuspension100000Units());
		}
		if (oReport.getLosses().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(5).setCellValue(oReport.getLosses().getNystatinOralSuspension100000Units());
		}
		if (oReport.getPosAdjustments().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(6).setCellValue(oReport.getPosAdjustments().getNystatinOralSuspension100000Units());
		}
		if (oReport.getNegAdjustments().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(7).setCellValue(oReport.getNegAdjustments().getNystatinOralSuspension100000Units());
		}
		if (oReport.getOnHand().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(8).setCellValue(oReport.getOnHand().getNystatinOralSuspension100000Units());
		}
		if (oReport.getQuantity6MonthsExpired().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getNystatinOralSuspension100000Units());
		}
		if (oReport.getExpiryDate().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getNystatinOralSuspension100000Units().toString()));
		}
		if (oReport.getDaysOutOfStock().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(11).setCellValue(oReport.getDaysOutOfStock().getNystatinOralSuspension100000Units());
		}
		if (oReport.getQuantityRequiredResupply().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getNystatinOralSuspension100000Units());
		}
		if (oReport.getQuantityRequiredNewPatients().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getNystatinOralSuspension100000Units());
		}
		if (oReport.getTotalQuantityRequired().getNystatinOralSuspension100000Units() != null) {
			oSsheet.getRow(21).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getNystatinOralSuspension100000Units());
		}

		//getamphotericinBInjection
		if (oReport.getBalanceBF().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(2).setCellValue(oReport.getBalanceBF().getAmphotericinBInjection());
		}
		if (oReport.getReceived().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(3).setCellValue(oReport.getReceived().getAmphotericinBInjection());
		}
		if (oReport.getTotalDispensed().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(4).setCellValue(oReport.getTotalDispensed().getAmphotericinBInjection());
		}
		if (oReport.getLosses().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(5).setCellValue(oReport.getLosses().getAmphotericinBInjection());
		}
		if (oReport.getPosAdjustments().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(6).setCellValue(oReport.getPosAdjustments().getAmphotericinBInjection());
		}
		if (oReport.getNegAdjustments().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(7).setCellValue(oReport.getNegAdjustments().getAmphotericinBInjection());
		}
		if (oReport.getOnHand().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(8).setCellValue(oReport.getOnHand().getAmphotericinBInjection());
		}
		if (oReport.getQuantity6MonthsExpired().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getAmphotericinBInjection());
		}
		if (oReport.getExpiryDate().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getAmphotericinBInjection().toString()));
		}
		if (oReport.getDaysOutOfStock().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(11).setCellValue(oReport.getDaysOutOfStock().getAmphotericinBInjection());
		}
		if (oReport.getQuantityRequiredResupply().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getAmphotericinBInjection());
		}
		if (oReport.getQuantityRequiredNewPatients().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getAmphotericinBInjection());
		}
		if (oReport.getTotalQuantityRequired().getAmphotericinBInjection() != null) {
			oSsheet.getRow(22).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getAmphotericinBInjection());
		}

		//getcotrimoxazolesusp240mg_5ml
		if (oReport.getBalanceBF().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(2).setCellValue(oReport.getBalanceBF().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getReceived().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(3).setCellValue(oReport.getReceived().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getTotalDispensed().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(4).setCellValue(oReport.getTotalDispensed().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getLosses().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(5).setCellValue(oReport.getLosses().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getPosAdjustments().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(6).setCellValue(oReport.getPosAdjustments().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getNegAdjustments().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(7).setCellValue(oReport.getNegAdjustments().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getOnHand().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(8).setCellValue(oReport.getOnHand().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getQuantity6MonthsExpired().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getExpiryDate().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getCotrimoxazolesusp240mg_5ml().toString()));
		}
		if (oReport.getDaysOutOfStock().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(11).setCellValue(oReport.getDaysOutOfStock().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getQuantityRequiredResupply().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getQuantityRequiredNewPatients().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getCotrimoxazolesusp240mg_5ml());
		}
		if (oReport.getTotalQuantityRequired().getCotrimoxazolesusp240mg_5ml() != null) {
			oSsheet.getRow(24).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getCotrimoxazolesusp240mg_5ml());
		}

		//getcotrimoxazoleTabs480mg
		if (oReport.getBalanceBF().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(2).setCellValue(oReport.getBalanceBF().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getReceived().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(3).setCellValue(oReport.getReceived().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getTotalDispensed().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(4).setCellValue(oReport.getTotalDispensed().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getLosses().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(5).setCellValue(oReport.getLosses().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getPosAdjustments().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(6).setCellValue(oReport.getPosAdjustments().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getNegAdjustments().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(7).setCellValue(oReport.getNegAdjustments().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getOnHand().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(8).setCellValue(oReport.getOnHand().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getQuantity6MonthsExpired().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getExpiryDate().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getCotrimoxazoleTabs480mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(11).setCellValue(oReport.getDaysOutOfStock().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getQuantityRequiredResupply().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getCotrimoxazoleTabs480mg());
		}
		if (oReport.getTotalQuantityRequired().getCotrimoxazoleTabs480mg() != null) {
			oSsheet.getRow(25).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getCotrimoxazoleTabs480mg());
		}

		//getcotrimoxazoleDS960mg
		if (oReport.getBalanceBF().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(2).setCellValue(oReport.getBalanceBF().getCotrimoxazoleDS960mg());
		}
		if (oReport.getReceived().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(3).setCellValue(oReport.getReceived().getCotrimoxazoleDS960mg());
		}
		if (oReport.getTotalDispensed().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(4).setCellValue(oReport.getTotalDispensed().getCotrimoxazoleDS960mg());
		}
		if (oReport.getLosses().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(5).setCellValue(oReport.getLosses().getCotrimoxazoleDS960mg());
		}
		if (oReport.getPosAdjustments().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(6).setCellValue(oReport.getPosAdjustments().getCotrimoxazoleDS960mg());
		}
		if (oReport.getNegAdjustments().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(7).setCellValue(oReport.getNegAdjustments().getCotrimoxazoleDS960mg());
		}
		if (oReport.getOnHand().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(8).setCellValue(oReport.getOnHand().getCotrimoxazoleDS960mg());
		}
		if (oReport.getQuantity6MonthsExpired().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getCotrimoxazoleDS960mg());
		}
		if (oReport.getExpiryDate().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getCotrimoxazoleDS960mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(11).setCellValue(oReport.getDaysOutOfStock().getCotrimoxazoleDS960mg());
		}
		if (oReport.getQuantityRequiredResupply().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getCotrimoxazoleDS960mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getCotrimoxazoleDS960mg());
		}
		if (oReport.getTotalQuantityRequired().getCotrimoxazoleDS960mg() != null) {
			oSsheet.getRow(26).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getCotrimoxazoleDS960mg());
		}

		//getciprofloxacinTabs500mg
		if (oReport.getBalanceBF().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(2).setCellValue(oReport.getBalanceBF().getCiprofloxacinTabs500mg());
		}
		if (oReport.getReceived().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(3).setCellValue(oReport.getReceived().getCiprofloxacinTabs500mg());
		}
		if (oReport.getTotalDispensed().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(4).setCellValue(oReport.getTotalDispensed().getCiprofloxacinTabs500mg());
		}
		if (oReport.getLosses().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(5).setCellValue(oReport.getLosses().getCiprofloxacinTabs500mg());
		}
		if (oReport.getPosAdjustments().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(6).setCellValue(oReport.getPosAdjustments().getCiprofloxacinTabs500mg());
		}
		if (oReport.getNegAdjustments().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(7).setCellValue(oReport.getNegAdjustments().getCiprofloxacinTabs500mg());
		}
		if (oReport.getOnHand().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(8).setCellValue(oReport.getOnHand().getCiprofloxacinTabs500mg());
		}
		if (oReport.getQuantity6MonthsExpired().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getCiprofloxacinTabs500mg());
		}
		if (oReport.getExpiryDate().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getCiprofloxacinTabs500mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(11).setCellValue(oReport.getDaysOutOfStock().getCiprofloxacinTabs500mg());
		}
		if (oReport.getQuantityRequiredResupply().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getCiprofloxacinTabs500mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getCiprofloxacinTabs500mg());
		}
		if (oReport.getTotalQuantityRequired().getCiprofloxacinTabs500mg() != null) {
			oSsheet.getRow(27).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getCiprofloxacinTabs500mg());
		}

		//getceftriaxoneInj250mgIM
		if (oReport.getBalanceBF().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(2).setCellValue(oReport.getBalanceBF().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getReceived().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(3).setCellValue(oReport.getReceived().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getTotalDispensed().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(4).setCellValue(oReport.getTotalDispensed().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getLosses().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(5).setCellValue(oReport.getLosses().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getPosAdjustments().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(6).setCellValue(oReport.getPosAdjustments().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getNegAdjustments().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(7).setCellValue(oReport.getNegAdjustments().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getOnHand().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(8).setCellValue(oReport.getOnHand().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getQuantity6MonthsExpired().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getExpiryDate().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getCeftriaxoneInj250mgIM().toString()));
		}
		if (oReport.getDaysOutOfStock().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(11).setCellValue(oReport.getDaysOutOfStock().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getQuantityRequiredResupply().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getQuantityRequiredNewPatients().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getCeftriaxoneInj250mgIM());
		}
		if (oReport.getTotalQuantityRequired().getCeftriaxoneInj250mgIM() != null) {
			oSsheet.getRow(28).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getCeftriaxoneInj250mgIM());
		}

		//getaminosidineSulphateliquid
		if (oReport.getBalanceBF().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(2).setCellValue(oReport.getBalanceBF().getAminosidineSulphateliquid());
		}
		if (oReport.getReceived().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(3).setCellValue(oReport.getReceived().getAminosidineSulphateliquid());
		}
		if (oReport.getTotalDispensed().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(4).setCellValue(oReport.getTotalDispensed().getAminosidineSulphateliquid());
		}
		if (oReport.getLosses().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(5).setCellValue(oReport.getLosses().getAminosidineSulphateliquid());
		}
		if (oReport.getPosAdjustments().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(6).setCellValue(oReport.getPosAdjustments().getAminosidineSulphateliquid());
		}
		if (oReport.getNegAdjustments().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(7).setCellValue(oReport.getNegAdjustments().getAminosidineSulphateliquid());
		}
		if (oReport.getOnHand().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(8).setCellValue(oReport.getOnHand().getAminosidineSulphateliquid());
		}
		if (oReport.getQuantity6MonthsExpired().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getAminosidineSulphateliquid());
		}
		if (oReport.getExpiryDate().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getAminosidineSulphateliquid().toString()));
		}
		if (oReport.getDaysOutOfStock().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(11).setCellValue(oReport.getDaysOutOfStock().getAminosidineSulphateliquid());
		}
		if (oReport.getQuantityRequiredResupply().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getAminosidineSulphateliquid());
		}
		if (oReport.getQuantityRequiredNewPatients().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getAminosidineSulphateliquid());
		}
		if (oReport.getTotalQuantityRequired().getAminosidineSulphateliquid() != null) {
			oSsheet.getRow(30).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getAminosidineSulphateliquid());
		}

		//getaminosidineSulphate
		if (oReport.getBalanceBF().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(2).setCellValue(oReport.getBalanceBF().getAminosidineSulphate());
		}
		if (oReport.getReceived().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(3).setCellValue(oReport.getReceived().getAminosidineSulphate());
		}
		if (oReport.getTotalDispensed().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(4).setCellValue(oReport.getTotalDispensed().getAminosidineSulphate());
		}
		if (oReport.getLosses().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(5).setCellValue(oReport.getLosses().getAminosidineSulphate());
		}
		if (oReport.getPosAdjustments().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(6).setCellValue(oReport.getPosAdjustments().getAminosidineSulphate());
		}
		if (oReport.getNegAdjustments().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(7).setCellValue(oReport.getNegAdjustments().getAminosidineSulphate());
		}
		if (oReport.getOnHand().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(8).setCellValue(oReport.getOnHand().getAminosidineSulphate());
		}
		if (oReport.getQuantity6MonthsExpired().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getAminosidineSulphate());
		}
		if (oReport.getExpiryDate().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getAminosidineSulphate().toString()));
		}
		if (oReport.getDaysOutOfStock().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(11).setCellValue(oReport.getDaysOutOfStock().getAminosidineSulphate());
		}
		if (oReport.getQuantityRequiredResupply().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getAminosidineSulphate());
		}
		if (oReport.getQuantityRequiredNewPatients().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getAminosidineSulphate());
		}
		if (oReport.getTotalQuantityRequired().getAminosidineSulphate() != null) {
			oSsheet.getRow(31).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getAminosidineSulphate());
		}

		//getacyclovir200mg
		if (oReport.getBalanceBF().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(2).setCellValue(oReport.getBalanceBF().getAcyclovir200mg());
		}
		if (oReport.getReceived().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(3).setCellValue(oReport.getReceived().getAcyclovir200mg());
		}
		if (oReport.getTotalDispensed().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(4).setCellValue(oReport.getTotalDispensed().getAcyclovir200mg());
		}
		if (oReport.getLosses().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(5).setCellValue(oReport.getLosses().getAcyclovir200mg());
		}
		if (oReport.getPosAdjustments().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(6).setCellValue(oReport.getPosAdjustments().getAcyclovir200mg());
		}
		if (oReport.getNegAdjustments().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(7).setCellValue(oReport.getNegAdjustments().getAcyclovir200mg());
		}
		if (oReport.getOnHand().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(8).setCellValue(oReport.getOnHand().getAcyclovir200mg());
		}
		if (oReport.getQuantity6MonthsExpired().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getAcyclovir200mg());
		}
		if (oReport.getExpiryDate().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getAcyclovir200mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(11).setCellValue(oReport.getDaysOutOfStock().getAcyclovir200mg());
		}
		if (oReport.getQuantityRequiredResupply().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getAcyclovir200mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getAcyclovir200mg());
		}
		if (oReport.getTotalQuantityRequired().getAcyclovir200mg() != null) {
			oSsheet.getRow(33).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getAcyclovir200mg());
		}

		//getacyclovirIVInfusion
		if (oReport.getBalanceBF().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(2).setCellValue(oReport.getBalanceBF().getAcyclovirIVInfusion());
		}
		if (oReport.getReceived().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(3).setCellValue(oReport.getReceived().getAcyclovirIVInfusion());
		}
		if (oReport.getTotalDispensed().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(4).setCellValue(oReport.getTotalDispensed().getAcyclovirIVInfusion());
		}
		if (oReport.getLosses().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(5).setCellValue(oReport.getLosses().getAcyclovirIVInfusion());
		}
		if (oReport.getPosAdjustments().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(6).setCellValue(oReport.getPosAdjustments().getAcyclovirIVInfusion());
		}
		if (oReport.getNegAdjustments().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(7).setCellValue(oReport.getNegAdjustments().getAcyclovirIVInfusion());
		}
		if (oReport.getOnHand().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(8).setCellValue(oReport.getOnHand().getAcyclovirIVInfusion());
		}
		if (oReport.getQuantity6MonthsExpired().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getAcyclovirIVInfusion());
		}
		if (oReport.getExpiryDate().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getAcyclovirIVInfusion().toString()));
		}
		if (oReport.getDaysOutOfStock().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(11).setCellValue(oReport.getDaysOutOfStock().getAcyclovirIVInfusion());
		}
		if (oReport.getQuantityRequiredResupply().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getAcyclovirIVInfusion());
		}
		if (oReport.getQuantityRequiredNewPatients().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getAcyclovirIVInfusion());
		}
		if (oReport.getTotalQuantityRequired().getAcyclovirIVInfusion() != null) {
			oSsheet.getRow(34).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getAcyclovirIVInfusion());
		}

		//getpyridoxine25mg
		if (oReport.getBalanceBF().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(2).setCellValue(oReport.getBalanceBF().getPyridoxine25mg());
		}
		if (oReport.getReceived().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(3).setCellValue(oReport.getReceived().getPyridoxine25mg());
		}
		if (oReport.getTotalDispensed().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(4).setCellValue(oReport.getTotalDispensed().getPyridoxine25mg());
		}
		if (oReport.getLosses().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(5).setCellValue(oReport.getLosses().getPyridoxine25mg());
		}
		if (oReport.getPosAdjustments().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(6).setCellValue(oReport.getPosAdjustments().getPyridoxine25mg());
		}
		if (oReport.getNegAdjustments().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(7).setCellValue(oReport.getNegAdjustments().getPyridoxine25mg());
		}
		if (oReport.getOnHand().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(8).setCellValue(oReport.getOnHand().getPyridoxine25mg());
		}
		if (oReport.getQuantity6MonthsExpired().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(9).setCellValue(oReport.getQuantity6MonthsExpired().getPyridoxine25mg());
		}
		if (oReport.getExpiryDate().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(10).setCellValue(new HSSFRichTextString(oReport.getExpiryDate().getPyridoxine25mg().toString()));
		}
		if (oReport.getDaysOutOfStock().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(11).setCellValue(oReport.getDaysOutOfStock().getPyridoxine25mg());
		}
		if (oReport.getQuantityRequiredResupply().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(12).setCellValue(oReport.getQuantityRequiredResupply().getPyridoxine25mg());
		}
		if (oReport.getQuantityRequiredNewPatients().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(13).setCellValue(oReport.getQuantityRequiredNewPatients().getPyridoxine25mg());
		}
		if (oReport.getTotalQuantityRequired().getPyridoxine25mg() != null) {
			oSsheet.getRow(36).getCell(14).setCellValue(oReport.getTotalQuantityRequired().getPyridoxine25mg());
		}
	}

	public static void populateDynamicCDRRPOiSheet(CDRROIReport oReport, HSSFSheet sheet) {
		ArrayList<DrugReport> list = oReport.getDrugReportList();
		int currentRow = 11;
		for (DrugReport report : list) {
			currentRow++;
			Item item = report.getItem();
			HSSFRichTextString name = new HSSFRichTextString(report.getName());
			HSSFRichTextString unit = new HSSFRichTextString(item.getUnit());
			sheet.createRow(currentRow).createCell(0).setCellValue(name);
			sheet.getRow(currentRow).createCell(1).setCellValue(unit);
			if (report.getBalanceBF() != null) {
				sheet.getRow(currentRow).createCell(3).setCellValue(report.getBalanceBF());
			}
			if (report.getReceived() != null) {
				sheet.getRow(currentRow).createCell(4).setCellValue(report.getReceived());
			}
			if (report.getTotalDispensed() != null) {
				sheet.getRow(currentRow).createCell(5).setCellValue(report.getTotalDispensed());
			}
			if (report.getLosses() != null) {
				sheet.getRow(currentRow).createCell(5).setCellValue(report.getLosses());
			}
			if (report.getPosAdjustments() != null) {
				sheet.getRow(currentRow).createCell(7).setCellValue(report.getPosAdjustments());
			}
			if (report.getNegAdjustments() != null) {
				sheet.getRow(currentRow).createCell(8).setCellValue(report.getNegAdjustments());
			}
			if (report.getOnHand()!= null) {
				sheet.getRow(currentRow).createCell(9).setCellValue(report.getOnHand());
			}
			if (report.getQuantity6MonthsExpired()!= null) {
				sheet.getRow(currentRow).createCell(10).setCellValue(report.getQuantity6MonthsExpired());
			}
			if (report.getExpiryDate() != null) {
				sheet.getRow(currentRow).createCell(11).setCellValue(report.getExpiryDate());
			}
			if (report.getDaysOutOfStock() != null) {
				sheet.getRow(currentRow).createCell(12).setCellValue(report.getDaysOutOfStock());
			}
			if (report.getQuantityRequiredResupply() != null) {
				sheet.getRow(currentRow).createCell(13).setCellValue(report.getQuantityRequiredResupply());
			}
			if (report.getQuantityRequiredNewPatients() != null) {
				sheet.getRow(currentRow).createCell(14).setCellValue(report.getQuantityRequiredNewPatients());
			}
			if (report.getTotalQuantityRequired() != null) {
				sheet.getRow(currentRow).createCell(15).setCellValue(report.getTotalQuantityRequired());
			}
		}

	}

}

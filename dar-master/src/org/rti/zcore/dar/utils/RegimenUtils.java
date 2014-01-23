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

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.RowProcessor;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Constants;
import org.rti.zcore.DropdownItem;
import org.rti.zcore.dar.gen.PatientItem;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.utils.AuditInfoBeanProcessor;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.ZEPRSRowProcessor;

public class RegimenUtils {

	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(RegimenUtils.class);

	/**
	 * Fetches most recent regimen for patient.
	 * @param conn
	 * @param patientId
	 * @return ResultSet
	 * @throws ServletException
	 */
	public static ResultSet getPatientArtRegimen(Connection conn, Long patientId) throws ServletException {
		ResultSet rs = null;
		try {
				String sql = "SELECT encounter.id AS id, regimen.code AS code, regimen.name AS name, regimen.id AS regimenId "
					+ "FROM art_regimen, encounter, regimen  "
					+ "WHERE encounter.id = art_regimen.id "
					+ "AND art_regimen.regimen_1 = regimen.id "
					+ "AND encounter.patient_id = ? "
					+ "ORDER BY encounter.id DESC";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setMaxRows(1);
				ps.setLong(1, patientId);
				rs = ps.executeQuery();
		} catch (Exception ex) {
			log.error(ex);
		}
		return rs;
	}

	/**
	 * Fetch a list of RegimenItem_bridge items.
	 * Stuff into PatientItem - no need to import RegimenItem_bridge since we only really need item_id
	 * @param conn
	 * @param regimenId
	 * @return List<PatientItem>
	 * @throws ServletException
	 * @throws SQLException
	 */
    public static List<PatientItem> getAllItemsForRegimen(Connection conn, Long regimenId) throws  ServletException, SQLException {
        List<PatientItem> items;
        String sql = "SELECT id, item_id " +
        		"FROM regimen_item_bridge " +
        		"WHERE regimen_id = ?";
        Class clazz = PatientItem.class;
        ArrayList values = new ArrayList();
        values.add(regimenId);
        BeanProcessor beanprocessor = new AuditInfoBeanProcessor();
        RowProcessor convert = new ZEPRSRowProcessor(beanprocessor);
        items = DatabaseUtils.getList(conn, clazz, sql, values, convert);
        return items;
    }

    /**
     * Fetch a DropdownItem based on the itemId. Used in populating the items that may be dispensed for a particular regimen.
     * @param conn
     * @param itemId
     * @return
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static DropdownItem getItemForRegimen(Connection conn, Long itemId) throws  ServletException, SQLException, ObjectNotFoundException {
    	DropdownItem item = null;
    	String sql = "select item.id AS dropdownId, item_group.short_name || ': ' || item.name AS dropdownValue " +
    			"FROM item,item_group WHERE item.ITEM_GROUP_ID = item_group.ID " +
    			"AND item.id = ?";
    	ArrayList values = new ArrayList();
    	values.add(itemId);
    	item = (DropdownItem) DatabaseUtils.getBean(conn, DropdownItem.class, sql, values);
    	return item;
    }

    /**
     * Fetch a list of anti fungals/bacterials etc.
     * @param conn
     * @param itemId
     * @return
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static List getOtherDropdownItems(Connection conn) throws  ServletException, SQLException, ObjectNotFoundException {
        List<DropdownItem> items;
        String sql = "select item.id AS dropdownId, item_group.short_name || ': ' || item.name AS dropdownValue " +
    	"FROM item,item_group WHERE item.ITEM_GROUP_ID = item_group.ID " +
    	"AND (ITEM_GROUP_ID > 3 AND ITEM_GROUP_ID < 9) ORDER BY ITEM_GROUP_ID,item.name";
        if ((Constants.DISPLAY_ALL_DRUGS_WHEN_DISPENSING != null) && (Constants.DISPLAY_ALL_DRUGS_WHEN_DISPENSING.equals("1"))) {
        	sql = "select item.id AS dropdownId, item.name AS dropdownValue " +
        	"FROM item,item_group WHERE item.ITEM_GROUP_ID = item_group.ID " +
        	"AND (ITEM_GROUP_ID > 3) ORDER BY ITEM_GROUP_ID,item.name";
        }
    	ArrayList values = new ArrayList();
    	//item = (DropdownItem) DatabaseUtils.getBean(conn, DropdownItem.class, sql, values);
        BeanProcessor beanprocessor = new AuditInfoBeanProcessor();
        RowProcessor convert = new ZEPRSRowProcessor(beanprocessor);
        items = DatabaseUtils.getList(conn, DropdownItem.class, sql, values, convert);
    	return items;
    }

    /**
     * Fetches Paediatric Single drugs (intem_group_id = 3) for display in dispensing dropdown.
     * @param conn
     * @return
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static List getPaediatricSingleDrugItems(Connection conn) throws  ServletException, SQLException, ObjectNotFoundException {
    	List<DropdownItem> items;
    	String sql = "select item.id AS dropdownId, item_group.short_name || ': ' || item.name AS dropdownValue " +
    	"FROM item,item_group WHERE item.ITEM_GROUP_ID = item_group.ID " +
    	"AND ITEM_GROUP_ID = 3 ORDER BY ITEM_GROUP_ID,item.name";
    	ArrayList values = new ArrayList();
    	//item = (DropdownItem) DatabaseUtils.getBean(conn, DropdownItem.class, sql, values);
    	BeanProcessor beanprocessor = new AuditInfoBeanProcessor();
    	RowProcessor convert = new ZEPRSRowProcessor(beanprocessor);
    	items = DatabaseUtils.getList(conn, DropdownItem.class, sql, values, convert);
    	return items;
    }

	/**
	 * Get ART regimen records (regimen code field) for this period/site
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ServletException
	 */
	public static ResultSet getArtRegimens(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {
	
		ResultSet rs = null;
	
		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}
	
		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
				dateRange +
				"ORDER BY created, surname";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
				}
				rs = ps.executeQuery();
			} else {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
				dateRange +
				"AND encounter.site_id = ? " +
				"ORDER BY created, surname";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
					ps.setInt(3, siteID);
				} else {
					ps.setInt(2, siteID);
				}
	
				rs = ps.executeQuery();
			}
		} catch (Exception ex) {
			log.error(ex);
		}
		return rs;
	}

}

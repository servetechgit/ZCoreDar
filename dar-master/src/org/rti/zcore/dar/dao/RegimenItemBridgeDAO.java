/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.RowProcessor;
import org.rti.zcore.dar.gen.RegimenItem_bridge;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.utils.AuditInfoBeanProcessor;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.ZEPRSRowProcessor;
import org.rti.zcore.DropdownItem;

public class RegimenItemBridgeDAO {

	/**
	 * Fetch a list of RegimenItem_bridge items.
	 * @param conn
	 * @param regimenId
	 * @return
	 * @throws ServletException
	 * @throws SQLException
	 */
    public static List<RegimenItem_bridge> getAll(Connection conn, Long regimenId) throws  ServletException, SQLException {
        List<RegimenItem_bridge> items;
        String sql = "SELECT id, regimen_id AS field204, item_id AS field205 " +
        		"FROM regimen_item_bridge " +
        		"WHERE regimen_id = ?";
        Class clazz = RegimenItem_bridge.class;
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
    	ArrayList values = new ArrayList();
    	//item = (DropdownItem) DatabaseUtils.getBean(conn, DropdownItem.class, sql, values);
        BeanProcessor beanprocessor = new AuditInfoBeanProcessor();
        RowProcessor convert = new ZEPRSRowProcessor(beanprocessor);
        items = DatabaseUtils.getList(conn, DropdownItem.class, sql, values, convert);
    	return items;
    }



}

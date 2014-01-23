package org.rti.zcore.dar.report;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.LinkedHashMap;

import org.junit.Assert;
import org.junit.Test;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dar.utils.InventoryUtils;
import org.rti.zcore.servlet.DynasiteConfigServlet;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.encryption.EncryptionUtils;

public class ARTAdultDailyActivityReportTest {
	/**
	 * @see InventoryUtils#populateStockReportMaps(Connection,Date,Date,int, HashMap)
	 * @verifies populate Stock Report Maps and item Map
	 */
	@Test
	public void populateStockReportMaps_shouldPopulateStockReportMapsAndItemMap()
			throws Exception {
		LinkedHashMap<Long, Item> itemMap = null;
        LinkedHashMap<String,StockReport> stockReportMap = new LinkedHashMap<String,StockReport>();
		System.setProperty("catalina.home", "C:\\dar\\");
		DynasiteConfigServlet.loadDynaSiteObjects();
		Connection conn = null;
		try {
            Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            String userPasswords;
            String username = null;
        	String password = null;
        	String bootPassword = null;
        	try {
        		userPasswords = EncryptionUtils.aesDecryptUserPasswords();
        		String userPasswordArray[] = userPasswords.split(":");
        		username = userPasswordArray[0];
        		password = userPasswordArray[1];
        		bootPassword = userPasswordArray[2];
        	} catch (FileNotFoundException e1) {
        		// not using aes
        	}

        	String credentials = ";bootPassword=" + bootPassword + ";username=" + username + ";password=" + password;
            conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs" + credentials);

            Date beginDate = Date.valueOf("2010-01-01");
            Date endDate = DateUtils.getNow();
            int siteId = 9;
            
            itemMap = DailyActivityReport.getItemMapForReport(conn, "CDRRArtReport");
            stockReportMap = InventoryUtils.populateStockReportMaps(conn, beginDate, endDate, siteId, itemMap);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        }
		boolean stockReportMapSize = false;
		if (stockReportMap.size() > 0) {
			stockReportMapSize = true;
		}
		Assert.assertTrue("Items list is not populated", stockReportMapSize);
	}

	/**
	 * @see InventoryUtils#populateItemMap(Connection)
	 * @verifies return map of items
	 */
	@Test
	public void populateItemMap_shouldReturnMapOfItems() throws Exception {
		LinkedHashMap<Long, Item> itemMap = new LinkedHashMap<Long, Item>();
		System.setProperty("catalina.home", "C:\\dar\\");
		DynasiteConfigServlet.loadDynaSiteObjects();
		Connection conn = null;
		try {
            Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            String userPasswords;
            String username = null;
        	String password = null;
        	String bootPassword = null;
        	try {
        		userPasswords = EncryptionUtils.aesDecryptUserPasswords();
        		String userPasswordArray[] = userPasswords.split(":");
        		username = userPasswordArray[0];
        		password = userPasswordArray[1];
        		bootPassword = userPasswordArray[2];
        	} catch (FileNotFoundException e1) {
        		// not using aes
        	}

        	String credentials = ";bootPassword=" + bootPassword + ";username=" + username + ";password=" + password;
            conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs" + credentials);

            itemMap = InventoryUtils.populateItemMap(conn);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        }
		boolean itemMapSize = false;
		
		if (itemMap.size() > 0) {
			itemMapSize = true;
		}
		Assert.assertTrue("Items list is not populated", itemMapSize);
	}
}
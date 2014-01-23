package org.rti.zcore.utils.database.derby;


import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.derby.impl.tools.sysinfo.Main;
import org.junit.Assert;
import org.junit.Test;
import org.openmrs.test.Verifies;

public class DerbyTest {

    /**
     * Commons Logging instance.
     */

    private Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

	/**
	 * @see {@link Derby#displayVersion(Connection)}
	 *
	 */
	@Test
	@Verifies(value = "should return a value", method = "displayVersion(Connection)")
	public void displayVersion_shouldReturnAValue() throws Exception {
		System.setProperty("catalina.home", "C:\\tims\\");
		//Class.forName("org.apache.derby.jdbc.EmbeddedDriver").newInstance();
		String driver = "org.apache.derby.jdbc.EmbeddedDriver";
		// If more than one update is processed, the Derby system will boot more than once. We must create a new Instance each time.
		try {
		    Class.forName(driver).newInstance();
		} catch(java.lang.ClassNotFoundException e) {
		  log.debug(e);
		} catch (InstantiationException e) {
			log.debug(e);
		} catch (IllegalAccessException e) {
			log.debug(e);
		}
		//String path = org.apache.commons.io.FileUtils.readFileToString(new File (zipDirName + File.separator + fileName));
		Connection conn = null;
		String result = null;
		try {
	        //conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			String databaseConnectionUrl = "jdbc:derby:C:\\zephyr\\databases\\zeprs";
			conn = DriverManager.getConnection(databaseConnectionUrl);
			result = Derby.displayVersion(conn);
			log.debug(result);
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		} finally {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		}
	}

	@Test
	@Verifies(value = "should return a value", method = "upgradeDatabase(Connection)")
	public void upgradeDatabase() throws Exception {
		//System.setProperty("catalina.home", "C:\\dar\\");
		//Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
		Class.forName("org.apache.derby.jdbc.EmbeddedDriver").newInstance();
		//Connection conn = null;
		String result = null;
		try {
			//conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");

			String path = "jdbc:derby:C:\\zephyr\\databases\\zeprs";
			new Main();
			Main.main(null);
			result = Derby.updateDatabaseVersion(path);
			log.debug(result);
			/*conn = DriverManager.getConnection(path);
			String version = Derby.displayVersion(conn);
			String versionMessage = " Starting Derby Version: " + version;
			log.debug(versionMessage);
			conn.close();

			String pathShutdown = "jdbc:derby:C:\\zephyr\\databases\\zeprs;shutdown=true";
			try {
				conn = DriverManager.getConnection(pathShutdown);
			} catch (Exception e) {
				log.debug(e);
			}
			conn.close();
			Properties connProps = new Properties();
		    connProps.put("upgrade", "true");
			//String path2 = "jdbc:derby:C:\\zephyr\\databases\\zeprs;upgrade=true";
			conn = DriverManager.getConnection(path, connProps);
			String upgradeExternalDatabaseMessage = " Running updateAdminDatabase for path: " + path;
			log.debug(upgradeExternalDatabaseMessage);
			String newVersion = Derby.displayVersion(conn);
			String newVersionMessage = " After upgrade Derby Version: " + newVersion;
			log.debug(newVersionMessage);
			conn.close();*/
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		} finally {
			/*if (conn != null && !conn.isClosed()) {
				conn.close();
			}*/
		}
	}
}
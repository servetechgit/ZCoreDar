package org.rti.zcore.dar.dao;


import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.TimeZone;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.test.Verifies;
import org.rti.zcore.utils.DateUtils;

public class SiteStatisticsDAOTest {

	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(SiteStatisticsDAOTest.class);

	private Date beginDate = null;
	private Date endDate = null;
	private int siteId = 9;

	@Before
	public void setUp() throws Exception {

		java.util.Calendar c = java.util.Calendar.getInstance();
		c.add(java.util.Calendar.MONTH, -1);
		java.util.Date date1monthpast = c.getTime();
		String DATE_FORMAT = "yyyy-MM-dd";
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
		sdf.setTimeZone(TimeZone.getDefault());
		String date1monthpastStr = sdf.format(date1monthpast);
		java.sql.Date date1monthpastSql =  java.sql.Date.valueOf(date1monthpastStr);
		beginDate = date1monthpastSql;
		endDate = DateUtils.getNow();

	}

	/**
	 * @see {@link SiteStatisticsDAO#getNewClients(Connection,Date,Date,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of new clients", method = "getNewClients(Date,Date,int,Connection)")
	public void getNewClients_shouldReturnCountOfNewClients() throws Exception {

		Connection conn = null;
		Integer newClients = null;

		int siteId = 9;

		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			newClients = SiteStatisticsDAO.getNewClients(conn, beginDate, endDate, siteId);
			log.debug("getNewClients: " + newClients);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned newClients.", newClients);
	}


	/**
	 * @see {@link SiteStatisticsDAO#getFemaleAdults(Connection,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of females", method = "getFemaleAdults(Connection,int)")
	public void getFemaleAdults_shouldReturnCountOfFemales() throws Exception {
		Connection conn = null;
		Integer result = null;

		int siteId = 9;
		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getFemaleAdults(conn, siteId);
			log.debug("getFemaleAdults: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}

	/**
	 * @see {@link SiteStatisticsDAO#getFemaleChildren(Connection,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of female children", method = "getFemaleChildren(Connection,int)")
	public void getFemaleChildren_shouldReturnCountOfFemaleChildren() throws Exception {
		Connection conn = null;
		Integer result = null;

		int siteId = 9;
		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getFemaleChildren(conn, siteId);
			log.debug("getFemaleChildren: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}

	/**
	 * @see {@link SiteStatisticsDAO#getMaleAdults(Connection,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of males", method = "getMaleAdults(Connection,int)")
	public void getMaleAdults_shouldReturnCountOfMales() throws Exception {
		Connection conn = null;
		Integer result = null;

		int siteId = 9;
		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getMaleAdults(conn, siteId);
			log.debug("getMaleAdults: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}

	/**
	 * @see {@link SiteStatisticsDAO#getMaleChildren(Connection,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of male children", method = "getMaleChildren(Connection,int)")
	public void getMaleChildren_shouldReturnCountOfMaleChildren() throws Exception {
		Connection conn = null;
		Integer result = null;

		int siteId = 9;
		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getMaleChildren(conn, siteId);
			log.debug("getMaleChildren: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}


	/**
	 * @see {@link SiteStatisticsDAO#getStatusDefaulters(Connection,Date,Date,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of status defaulter", method = "getStatusDefaulters(Connection,Date,Date,int)")
	public void getStatusDefaulters_shouldReturnCountOfStatusDefaulter() throws Exception {
		Connection conn = null;
		Integer result = null;

		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getStatusDefaulters(conn, beginDate, endDate, siteId);
			log.debug("getStatusDefaulters: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}


	/**
	 * @see {@link SiteStatisticsDAO#getStatusDied(Connection,Date,Date,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of status died", method = "getStatusDied(Connection,Date,Date,int)")
	public void getStatusDied_shouldReturnCountOfStatusDied() throws Exception {
		Connection conn = null;
		Integer result = null;

		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getStatusDied(conn, beginDate, endDate, siteId);
			log.debug("getStatusDied: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}


	/**
	 * @see {@link SiteStatisticsDAO#getStatusOther(Connection,Date,Date,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of status other", method = "getStatusOther(Connection,Date,Date,int)")
	public void getStatusOther_shouldReturnCountOfStatusOther() throws Exception {
		Connection conn = null;
		Integer result = null;

		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getStatusOther(conn, beginDate, endDate, siteId);
			log.debug("getStatusOther: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}


	/**
	 * @see {@link SiteStatisticsDAO#getStatusTransferred(Connection,Date,Date,int)}
	 *
	 */
	@Test
	@Verifies(value = "should return count of status transferred", method = "getStatusTransferred(Connection,Date,Date,int)")
	public void getStatusTransferred_shouldReturnCountOfStatusTransferred() throws Exception {
		Connection conn = null;
		Integer result = null;

		try {
			conn = DriverManager.getConnection("jdbc:derby://localhost/zeprs");
			result = SiteStatisticsDAO.getStatusTransferred(conn, beginDate, endDate, siteId);
			log.debug("getStatusOther: " + result);
		} catch (Exception e) {
			fail("Error: " + e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				fail("Error: " + e);
			}
		}
		assertNotNull("Should have returned result.", result);
	}
}
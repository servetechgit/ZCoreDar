package org.rti.zcore.dar.transfer.access;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;
import org.openmrs.test.Verifies;
import org.rti.zcore.Constants;
import org.rti.zcore.servlet.DynasiteConfigServlet;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.encryption.EncryptionUtils;

public class ImportMshDataTest {
	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(ImportMshDataTest.class);


	/**
	 * @see {@link ImportMshData#getPatientMaster(String)}
	 *
	 */
	@Test
	@Verifies(value = "should return a list", method = "getPatientMaster()")
	public void getPatientMaster_shouldReturnAList() throws Exception {
		System.setProperty("catalina.home", "C:\\dar\\");
		ArrayList<MshPatientMaster> list = null;
		String fileName = Constants.ARCHIVE_PATH + "patients_imported" + File.separator + "tblARTPatientMasterInformation.xml";
		list = ImportMshData.getPatientMaster(fileName);
		Assert.assertNotNull("List is null", list);
	}

	/**
	 * @see {@link ImportMshData#importPatients()}
	 *
	 */
	@Test
	@Verifies(value = "should be not null", method = "importPatients()")
	public void importPatients_shouldBeNotNull() throws Exception {
		System.setProperty("catalina.home", "C:\\dar\\");
		DynasiteConfigServlet.loadDynaSiteObjects();
		int expectedCount = 4546;
		String startTime = DateUtils.getTime();
		//int expectedCount = 2;
		//String fileName = Constants.ARCHIVE_PATH + "patients_imported" + File.separator + "tblARTPatientMasterInformation-test.xml";
		String patientMasterFilename = Constants.ARCHIVE_PATH + "patients_imported" + File.separator + "tblARTPatientMasterInformation.xml";
		String patientTransactionsFilename = Constants.ARCHIVE_PATH + "patients_imported" + File.separator + "tblARTPatientTransactions.xml";
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
			Assert.assertNotNull("conn is null", conn);
			Integer countPatients = null;
			countPatients = ImportMshData.importPatients(conn, patientMasterFilename, patientTransactionsFilename);
			//log.debug("countPatients: " +countPatients );
			String endTime = DateUtils.getTime();
			log.debug("Started: " + startTime + " Ended: " + endTime);
			//Assert.assertEquals("countPatients not equal to expected value", expectedCount, countPatients.intValue());
			String message = "countPatients: " + countPatients;
			log.debug(message);
			Assert.assertNotNull(message, countPatients);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		}
	}
}
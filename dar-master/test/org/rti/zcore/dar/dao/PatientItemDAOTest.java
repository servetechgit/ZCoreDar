package org.rti.zcore.dar.dao;


import static org.junit.Assert.assertNotNull;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

import org.junit.Test;
import org.openmrs.test.Verifies;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.servlet.DynasiteConfigServlet;
import org.rti.zcore.utils.encryption.EncryptionUtils;

public class PatientItemDAOTest {
	/**
	 * @see {@link PatientItemDAO#getPatientItemList(Connection,Long)}
	 *
	 */
	@Test
	@Verifies(value = "should return a list", method = "getPatientItemList(Connection,Long)")
	public void getPatientItemList_shouldReturnAList() throws Exception {
		System.setProperty("catalina.home", "C:\\dar\\");
		DynasiteConfigServlet.loadDynaSiteObjects();
		List items = null;
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
            Long formId = (Long) DynaSiteObjects.getFormNameMap().get("PatientItem");
            String eventUuid = "3ff43199-cd65-4008-ad35-8bba1c28b678";
            Long flowId = Long.valueOf(2);
    		items = PatientItemDAO.getPatientItemList(conn, Long.valueOf(920), eventUuid, flowId, formId);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        }
		assertNotNull("Items list is null", items);
	}
}
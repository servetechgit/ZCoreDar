/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Patient;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.StringManipulation;

/**
 * @author <a href="mailto:ckelley@rti.org">Chris Kelley</a>
 *         Date: Oct 18, 2005
 *         Time: 3:40:51 PM
 */
public class PatientSearchDAO {

    /**
     * Commons Logging instance.
     */

    static Log log = LogFactory.getFactory().getInstance(PatientSearchDAO.class);

    /**
     * provides search results to Home page search using jstl ResultSupport.toResult(rs);
     * displays only the first 25 rows - no paging.
     * @param conn
     * @param site
     * @param searchString
     * @param offset
     * @param maxRows
     * @param searchType - if searchType = "firstSurname", do search on first letters of surname; otherwise, searchtype is "keyword" and perform keyword search.
     * @param filter - display only patients in labour. Uses filterflow sql, below.
     * @param username
     * @return
     * @throws ServletException
     */
    public static List getResults(Connection conn, String site, String searchString, int offset, int maxRows, String searchType, int filter, String username) throws ServletException {

        /*ResultSet rs = null;
        Result results = null;*/
    	List results = null;
		ArrayList values = new ArrayList();
        String sql = "";
    	//String ageCalc = DatabaseCompatability.ageCalc();
    	String ageCalc = "integer(floor({fn TIMESTAMPDIFF(SQL_TSI_YEAR, birthdate, CURRENT_DATE)}))";
        // some names have a "'" in them; also prevent bad chars from messing up the sql.
        String filteredString = StringManipulation.escapeString(searchString);

        sql="SELECT p.id, p.first_name AS firstName,p.surname,\n" +
                "p.district_patient_id AS districtPatientid, p.last_modified_by AS lastModifiedBy, " +
                "p.last_modified AS lastModified, p.site_id AS siteId, p.age_at_first_visit AS ageAtFirstVisit, " +
                "s.site_name AS siteName, " + ageCalc + " AS age, pr.STREET_ADDRESS_1 AS address1, pr.STREET_ADDRESS_2 AS address2,\n" +
                "pr.age_category AS sequenceNumber\n";
        sql = sql + "FROM patient p\n";
        sql = sql + "LEFT JOIN (encounter e) ON (e.patient_id = p.id AND e.form_id=1)\n" +
                "LEFT JOIN (patientregistration pr) ON (pr.id = e.id)\n" +
               // "JOIN (patient_status ps) ON (ps.id = p.id)\n" +
               // "LEFT JOIN (" + Constants.USERINFO_TABLE + " u) ON (u." + Constants.USERINFO_USERNAME +" = ps.last_modified_by)\n" +
                "LEFT JOIN (site s) ON (s.id= p.site_id)\n";

        if (!site.equals("all")) {
            /*sql = sql + "WHERE s.id = " + site + "\n";
            if (filter == 1) {
                sql = sql + filterFlow;
            }*/
            sql = sql + "WHERE p.site_id = ?\n";
            //sql = sql + "WHERE p.site_id = " + site + "\n";
            Long siteId = Long.valueOf(site);
    		values.add(siteId);
        }
        if (searchType.equals("firstSurname") & site.equals("all")) {
            sql = sql + "WHERE ";
        } else if  (searchType.equals("firstSurname") & !site.equals("all")) {
            sql = sql + "AND ";
        }
        if (searchType.equals("firstSurname")) {
            sql = sql + "    p.surname like '" + filteredString + "%' \n";
            sql = sql + "ORDER BY p.surname, p.first_name\n";
        } else {
            if (!filteredString.equals("") & site.equals("all")) {
                sql = sql + "WHERE ";
            } else if (!filteredString.equals("") & !site.equals("all")) {
                sql = sql + "AND ";
            }
            if (!filteredString.equals("")) {
            	 sql = sql + " (LOWER(p.surname) like ?\n" +
                 "    OR LOWER(p.first_name) like ?\n" +
                 "    OR LOWER(p.district_patient_id) like ?)\n";
        		values.add("%" + filteredString + "%");
        		values.add("%" + filteredString + "%");
        		values.add("%" + filteredString + "%");
            }

            if (filteredString.equals("")) {
                sql = sql + "ORDER BY p.last_modified DESC \n";
            } else {
                sql = sql + "ORDER BY p.surname, p.first_name \n";
            }
        }
        //sql = sql +  "LIMIT " + offset + "," + rowCount +";";
		sql = sql + " OFFSET " + offset + " ROWS FETCH NEXT " + maxRows + " ROWS ONLY";

        /*try {
            Statement s = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            s.setMaxRows(200);

            //s.setFetchSize(offset);
            rs = s.executeQuery(sql);
            results = ResultSupport.toResult(rs);
            rs.close();
        }  catch (Exception ex) {
            log.info("Search sql: " + sql);
            log.error(ex);
            throw new ServletException("Cannot retrieve results:", ex);
        }*/

		try {
    		//results = DatabaseUtils.getList(conn, Patient.class, sql, values, 20);
    		results = DatabaseUtils.getList(conn, Patient.class, sql, values);
    	}  catch (SQLException  ex) {
    		log.info("Search sql: " + sql);
    		log.info("SQL State: " + ex.getSQLState());
    		log.info("Error Code: " + ex.getErrorCode());
    		log.error(ex);
    		String mmessage = "SQL State: " + ex.getSQLState() + " Error Code: " + ex.getErrorCode();
    		throw new ServletException("Cannot retrieve results. SQL errors: " + mmessage , ex);
    	}  catch (Exception ex) {
    		log.info("Search sql: " + sql);
    		log.error(ex);
    		throw new ServletException("Cannot retrieve results:", ex);
        }
        return results;
    }
}

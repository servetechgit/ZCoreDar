/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

/*
 * Created on Mar 31, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package org.rti.zcore.dar.report;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Register;
import org.rti.zcore.dao.DemographicsDAO;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.gen.report.PatientRegistrationReport;
import org.rti.zcore.dar.report.valueobject.ScheduledPatient;
import org.rti.zcore.exception.ObjectNotFoundException;

public class DefaultersRegister extends Register {

    /**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(DefaultersRegister.class);

    ArrayList patients = new ArrayList();
    String reportMonth;
    String reportYear;

    /**
     * @return Returns the reportMonth.
     */
    public String getReportMonth() {
        return reportMonth;
    }

    /**
     * @param reportMonth The reportMonth to set.
     */
    public void setReportMonth(String reportMonth) {
        this.reportMonth = reportMonth;
    }

    /**
     * @return Returns the reportYear.
     */
    public String getReportYear() {
        return reportYear;
    }

    /**
     * @param reportYear The reportYear to set.
     */
    public void setReportYear(String reportYear) {
        this.reportYear = reportYear;
    }

    /**
     * @return Returns the siteId from the super class.
     */
    public int getSiteId() {
        return super.getSiteId();
    }

    /**
     * @return Returns the siteName from the super class.
     */
    public String getSiteName() {
        return super.getSiteName();
    }

    /**
     * @return Returns the patients.
     */
    public ArrayList getPatients() {
        return patients;
    }

    /**
     * @param patient The patients to set.
     */
    public void addPatient(ScheduledPatient patient) {
        patients.add(patient);
    }

    public void getPatientRegister(Date beginDate, Date endDate, int siteId) {

        ResultSet rs = null;
        Connection conn = null;
        try {
            conn = ZEPRSUtils.getZEPRSConnection();
        } catch (ServletException e) {
            e.printStackTrace();
        }
        try {
        	// get a list of patients with appointments for the past week
        	// use beginDate = one week ago, endDate = today, preset in ChooseReportAction.

           /* String DATE_FORMAT = "yyyy-MM-dd";
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);

            java.util.Calendar c2 = java.util.Calendar.getInstance();
            c2.add(java.util.Calendar.WEEK_OF_YEAR, -1);
            java.util.Date date1weekpast = c2.getTime();
            sdf.setTimeZone(TimeZone.getDefault());
            String date1weekpastStr = sdf.format(date1weekpast);
            java.sql.Date date1weekpastSql =  java.sql.Date.valueOf(date1weekpastStr);
            java.sql.Date dateNow = DateUtils.getNow();*/

            rs = ZEPRSUtils.getScheduledVisits(beginDate, endDate, siteId, conn);
            // For each patient, load the report class and add this patient to the list
            while (rs.next()) {
                Long patientId = rs.getLong("patient_id");
                Date appointmentDate = rs.getDate("appointment_date");
                ScheduledPatient scheduledPatient = new ScheduledPatient();
                scheduledPatient.setAppointmentDate(appointmentDate);
                scheduledPatient.setPatientId(patientId);
                // Get the demo info
                try {
                	Long encounterId = DemographicsDAO.getDemographicsId(conn, patientId, Long.valueOf(1));
                    PatientRegistrationReport encounter = (PatientRegistrationReport) EncountersDAO.getOneReportById(conn, encounterId, new Long("1"), PatientRegistrationReport.class);
                    scheduledPatient.setPatientRegistration(encounter);
                } catch (ServletException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (ObjectNotFoundException e) {
                    log.error(e);
                    e.printStackTrace();
                } catch (NumberFormatException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
                    log.error(e);
					e.printStackTrace();
				}
				// now check if they had any visits during this time range.
		        ResultSet encounterRS = ZEPRSUtils.getPatientEncounters(patientId, beginDate, endDate, conn);
		        int count = 0;
				while (encounterRS.next()) {
	                Long encounterId = encounterRS.getLong("id");
	                count++;
				}
				if (count == 0) {
	                this.addPatient(scheduledPatient);
				}
            }
            rs.close();
        } catch (ServletException e) {
            log.error(e);
            e.printStackTrace();
        } catch (SQLException e) {
            log.error(e);
            e.printStackTrace();
        }

        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

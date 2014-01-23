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

/**
 * @author ericl
 *         <p/>
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class AppointmentRegister extends Register {

    /**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(AppointmentRegister.class);

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
            // First, get the unique list of patients who visited during the time period in question
        Connection conn = null;
        try {
            conn = ZEPRSUtils.getZEPRSConnection();
        } catch (ServletException e) {
            e.printStackTrace();
        }
        try {
            rs = ZEPRSUtils.getScheduledVisits(beginDate, endDate, siteId, conn);
            // For each patient, load the report class and add this patient to the list
            ArrayList scheduledPatients = new ArrayList();
            while (rs.next()) {
                Long patientId = rs.getLong("patient_id");
                Date appointmentDate = rs.getDate("appointment_date");
                ScheduledPatient scheduledPatient = new ScheduledPatient();
                scheduledPatient.setAppointmentDate(appointmentDate);
                scheduledPatient.setPatientId(patientId);
                scheduledPatient.setDateVisit(appointmentDate);
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
                //this.addPatient(scheduledPatient);
				scheduledPatients.add(scheduledPatient);
            }
            rs.close();
			//Collections.sort(scheduledPatients, new DateVisitOrderComparator());
            patients.addAll(scheduledPatients);
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

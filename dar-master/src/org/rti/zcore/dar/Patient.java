/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar;

import org.rti.zcore.dar.report.PatientStatusReport;

public class Patient extends org.rti.zcore.Patient {
	private String nrcNumber;
    private String obstetricRecordnumber;
    private Long pregnancyId;   // used to distinguish infants born in different pregnancies
    private PatientStatusReport patientStatusreport;


	/**
	 * @return the nrcNumber
	 */
	public String getNrcNumber() {
		return nrcNumber;
	}
	/**
	 * @param nrcNumber the nrcNumber to set
	 */
	public void setNrcNumber(String nrcNumber) {
		this.nrcNumber = nrcNumber;
	}
	/**
	 * @return the obstetricRecordnumber
	 */
	public String getObstetricRecordnumber() {
		return obstetricRecordnumber;
	}
	/**
	 * @param obstetricRecordnumber the obstetricRecordnumber to set
	 */
	public void setObstetricRecordnumber(String obstetricRecordnumber) {
		this.obstetricRecordnumber = obstetricRecordnumber;
	}
	/**
	 * @return the pregnancyId
	 */
	public Long getPregnancyId() {
		return pregnancyId;
	}
	/**
	 * @param pregnancyId the pregnancyId to set
	 */
	public void setPregnancyId(Long pregnancyId) {
		this.pregnancyId = pregnancyId;
	}
    /**
     * @return
     * @hibernate.one-to-one class="org.cidrz.project.zeprs.valueobject.report.PatientStatusReport"
     * cascade="all"
     */

    public PatientStatusReport getPatientStatusreport() {
        return patientStatusreport;
    }

    public void setPatientStatusreport(PatientStatusReport patientStatusreport) {
        this.patientStatusreport = patientStatusreport;
    }

}

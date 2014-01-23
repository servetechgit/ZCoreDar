/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report.valueobject;

import java.sql.Date;
import java.sql.Timestamp;

import org.rti.zcore.Creatable;
import org.rti.zcore.DateVisitOrderable;
import org.rti.zcore.EncounterData;
import org.rti.zcore.dar.gen.Appointment;
import org.rti.zcore.dar.gen.report.PatientRegistrationReport;

public class ScheduledPatient implements Creatable, DateVisitOrderable {

	private Long id;
	private Long patientId;
	private Long encounterId;
    private String clientId;
    private String surname;
    private String firstName;
    private Integer siteId;
    private Date dateVisit;
    private Date appointmentDate;
    private EncounterData encounter;
    private Integer age;
	private Timestamp created;
	private PatientRegistrationReport patientRegistration;
	private Appointment appointment;

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * @return the patientId
	 */
	public Long getPatientId() {
		return patientId;
	}
	/**
	 * @param patientId the patientId to set
	 */
	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}
	/**
	 * @return the encounterId
	 */
	public Long getEncounterId() {
		return encounterId;
	}
	/**
	 * @param encounterId the encounterId to set
	 */
	public void setEncounterId(Long encounterId) {
		this.encounterId = encounterId;
	}
	/**
	 * @return the clientId
	 */
	public String getClientId() {
		return clientId;
	}
	/**
	 * @param clientId the clientId to set
	 */
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	/**
	 * @return the surname
	 */
	public String getSurname() {
		return surname;
	}
	/**
	 * @param surname the surname to set
	 */
	public void setSurname(String surname) {
		this.surname = surname;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the siteId
	 */
	public Integer getSiteId() {
		return siteId;
	}
	/**
	 * @param siteId the siteId to set
	 */
	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}
	/**
	 * @return the dateVisit
	 */
	public Date getDateVisit() {
		return dateVisit;
	}
	/**
	 * @param dateVisit the dateVisit to set
	 */
	public void setDateVisit(Date dateVisit) {
		this.dateVisit = dateVisit;
	}
	/**
	 * @return the encounter
	 */
	public EncounterData getEncounter() {
		return encounter;
	}
	/**
	 * @param encounter the encounter to set
	 */
	public void setEncounter(EncounterData encounter) {
		this.encounter = encounter;
	}
	/**
	 * @return the age
	 */
	public Integer getAge() {
		return age;
	}
	/**
	 * @param age the age to set
	 */
	public void setAge(Integer age) {
		this.age = age;
	}
	/**
	 * @return the created
	 */
	public Timestamp getCreated() {
		return created;
	}
	/**
	 * @param created the created to set
	 */
	public void setCreated(Timestamp created) {
		this.created = created;
	}

	/**
	 * @return the patientRegistration
	 */
	public PatientRegistrationReport getPatientRegistration() {
		return patientRegistration;
	}
	/**
	 * @param patientRegistration the patientRegistration to set
	 */
	public void setPatientRegistration(PatientRegistrationReport patientRegistration) {
		this.patientRegistration = patientRegistration;
	}
	/**
	 * @return the appointment
	 */
	public Appointment getAppointment() {
		return appointment;
	}
	/**
	 * @param appointment the appointment to set
	 */
	public void setAppointment(Appointment appointment) {
		this.appointment = appointment;
	}
	/**
	 * @return the appointmentDate
	 */
	public Date getAppointmentDate() {
		return appointmentDate;
	}
	/**
	 * @param appointmentDate the appointmentDate to set
	 */
	public void setAppointmentDate(Date appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

}


/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.transfer.access;

import java.sql.Timestamp;

import org.rti.zcore.Event;
import org.rti.zcore.impl.SessionSubject;

public class MshPatientMaster {

	private String ArtID;
	private String Firstname;
	private String Surname;
	private String Sex;
	private Integer Age;
	private Integer Pregnant;
	private Timestamp DateTherapyStarted;
	private Float WeightOnStart;	// weight
	private Integer ClientSupportedBy;
	private String OtherDeaseConditions;	//notes
	private String ADRorSideEffects;	//notes
	private Integer ReasonsforChanges;
	private String OtherDrugs;	//notes
	private Integer TypeOfService;
	private Integer DaysToNextAppointment;
	private Timestamp DateOfNextAppointment;	//appointment
	private Integer CurrentStatus;
	private String CurrentRegimen;	// regimen
	private String RegimenStarted;	// regimen
	private Float CurrentWeight;	// weight
	private Integer startBSA;
	private Integer currentBSA;
	private Integer ischild;
	private Integer isadult;
	private Float StartHeight;	// height
	private Float CurrentHeight;	// height
	private Integer Naive;
	private Integer NonNaive;
	private Integer SourceofClient;
	private Integer Cotrimoxazole;
	private Integer TB;
	private Integer NoCotrimoxazole;
	private Integer NoTB;
	private String Address;	// Address

	// Zcore-related fields used for persisting encounters other than PatientRegistration.
	private Long patientId;
	private Long eventId;
	private String patientUuid;
	private String eventUuid;
	private SessionSubject sessionPatient;
	private Event event;

	public String getArtID() {
		return ArtID;
	}
	public void setArtID(String artID) {
		ArtID = artID;
	}
	public String getFirstname() {
		return Firstname;
	}
	public void setFirstname(String firstname) {
		Firstname = firstname;
	}
	public String getSurname() {
		return Surname;
	}
	public void setSurname(String surname) {
		Surname = surname;
	}
	public String getSex() {
		return Sex;
	}
	public void setSex(String sex) {
		Sex = sex;
	}
	public Integer getAge() {
		return Age;
	}
	public void setAge(Integer age) {
		Age = age;
	}
	public Integer getPregnant() {
		return Pregnant;
	}
	public void setPregnant(Integer pregnant) {
		Pregnant = pregnant;
	}
	public Timestamp getDateTherapyStarted() {
		return DateTherapyStarted;
	}
	public void setDateTherapyStarted(Timestamp dateTherapyStarted) {
		DateTherapyStarted = dateTherapyStarted;
	}
	public Float getWeightOnStart() {
		return WeightOnStart;
	}
	public void setWeightOnStart(Float weightOnStart) {
		WeightOnStart = weightOnStart;
	}
	public Integer getClientSupportedBy() {
		return ClientSupportedBy;
	}
	public void setClientSupportedBy(Integer clientSupportedBy) {
		ClientSupportedBy = clientSupportedBy;
	}
	public String getOtherDeaseConditions() {
		return OtherDeaseConditions;
	}
	public void setOtherDeaseConditions(String otherDeaseConditions) {
		OtherDeaseConditions = otherDeaseConditions;
	}
	public String getADRorSideEffects() {
		return ADRorSideEffects;
	}
	public void setADRorSideEffects(String aDRorSideEffects) {
		ADRorSideEffects = aDRorSideEffects;
	}
	public Integer getReasonsforChanges() {
		return ReasonsforChanges;
	}
	public void setReasonsforChanges(Integer reasonsforChanges) {
		ReasonsforChanges = reasonsforChanges;
	}
	public String getOtherDrugs() {
		return OtherDrugs;
	}
	public void setOtherDrugs(String otherDrugs) {
		OtherDrugs = otherDrugs;
	}
	public Integer getTypeOfService() {
		return TypeOfService;
	}
	public void setTypeOfService(Integer typeOfService) {
		TypeOfService = typeOfService;
	}
	public Integer getDaysToNextAppointment() {
		return DaysToNextAppointment;
	}
	public void setDaysToNextAppointment(Integer daysToNextAppointment) {
		DaysToNextAppointment = daysToNextAppointment;
	}
	public Timestamp getDateOfNextAppointment() {
		return DateOfNextAppointment;
	}
	public void setDateOfNextAppointment(Timestamp dateOfNextAppointment) {
		DateOfNextAppointment = dateOfNextAppointment;
	}
	public Integer getCurrentStatus() {
		return CurrentStatus;
	}
	public void setCurrentStatus(Integer currentStatus) {
		CurrentStatus = currentStatus;
	}
	public String getCurrentRegimen() {
		return CurrentRegimen;
	}
	public void setCurrentRegimen(String currentRegimen) {
		CurrentRegimen = currentRegimen;
	}
	public String getRegimenStarted() {
		return RegimenStarted;
	}
	public void setRegimenStarted(String regimenStarted) {
		RegimenStarted = regimenStarted;
	}
	public Float getCurrentWeight() {
		return CurrentWeight;
	}
	public void setCurrentWeight(Float currentWeight) {
		CurrentWeight = currentWeight;
	}
	public Integer getStartBSA() {
		return startBSA;
	}
	public void setStartBSA(Integer startBSA) {
		this.startBSA = startBSA;
	}
	public Integer getCurrentBSA() {
		return currentBSA;
	}
	public void setCurrentBSA(Integer currentBSA) {
		this.currentBSA = currentBSA;
	}
	public Integer getIschild() {
		return ischild;
	}
	public void setIschild(Integer ischild) {
		this.ischild = ischild;
	}
	public Integer getIsadult() {
		return isadult;
	}
	public void setIsadult(Integer isadult) {
		this.isadult = isadult;
	}
	public Float getStartHeight() {
		return StartHeight;
	}
	public void setStartHeight(Float startHeight) {
		StartHeight = startHeight;
	}
	public Float getCurrentHeight() {
		return CurrentHeight;
	}
	public void setCurrentHeight(Float currentHeight) {
		CurrentHeight = currentHeight;
	}
	public Integer getNaive() {
		return Naive;
	}
	public void setNaive(Integer naive) {
		Naive = naive;
	}
	public Integer getNonNaive() {
		return NonNaive;
	}
	public void setNonNaive(Integer nonNaive) {
		NonNaive = nonNaive;
	}
	public Integer getSourceofClient() {
		return SourceofClient;
	}
	public void setSourceofClient(Integer sourceofClient) {
		SourceofClient = sourceofClient;
	}
	public Integer getCotrimoxazole() {
		return Cotrimoxazole;
	}
	public void setCotrimoxazole(Integer cotrimoxazole) {
		Cotrimoxazole = cotrimoxazole;
	}
	public Integer getTB() {
		return TB;
	}
	public void setTB(Integer tB) {
		TB = tB;
	}
	public Integer getNoCotrimoxazole() {
		return NoCotrimoxazole;
	}
	public void setNoCotrimoxazole(Integer noCotrimoxazole) {
		NoCotrimoxazole = noCotrimoxazole;
	}
	public Integer getNoTB() {
		return NoTB;
	}
	public void setNoTB(Integer noTB) {
		NoTB = noTB;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public Long getPatientId() {
		return patientId;
	}
	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}
	public Long getEventId() {
		return eventId;
	}
	public void setEventId(Long eventId) {
		this.eventId = eventId;
	}
	public String getPatientUuid() {
		return patientUuid;
	}
	public void setPatientUuid(String patientUuid) {
		this.patientUuid = patientUuid;
	}
	public String getEventUuid() {
		return eventUuid;
	}
	public void setEventUuid(String eventUuid) {
		this.eventUuid = eventUuid;
	}
	public SessionSubject getSessionPatient() {
		return sessionPatient;
	}
	public void setSessionPatient(SessionSubject sessionPatient) {
		this.sessionPatient = sessionPatient;
	}
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}

}

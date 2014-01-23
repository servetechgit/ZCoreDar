/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.rti.zcore.EncounterData;
import org.rti.zcore.AuditInfo;
import org.rti.zcore.Auditable;

/**
 * Created by IntelliJ IDEA.
 * User: ckelley
 * Date: Jan 24, 2005
 * Time: 8:51:07 AM
 */

/**
 * @hibernate.class table="pregnancy"  lazy="false"
 * mutable="true"
 */

public class Pregnancy implements org.rti.zcore.Identifiable, Auditable {

    private Long id;
    private Long patientId;
    private Date datePregnancyBegin;
    private EncounterData pregnancyBeginEncounter;
    private Date datePregnancyEnd;
    private EncounterData pregnancyEndEncounter;
    private AuditInfo auditInfo;
    private List encounters;
    private List activeProblems;
    private List inActiveProblems;
    private EncounterData labourAdmissionEncounter;
    private Date dateLabourAdmission;
    private List modifiedValues;   // List of values from encounter_value_archive
    private List infants = new ArrayList();   // list of infants and infant records for this pregnancy
    private Map encounterDateMap;   // used in xml record output. Map of importEncounterId:lastModified
    private Long importPregnancyId;


    /**
     * @return
     * @hibernate.id unsaved-value="0"
     * generator-class="identity"
     */
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return
     * @hibernate.property column="patient_id"
     */
    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    /**
     * @return
     * @hibernate.property
     * @hibernate.column name="date_pregnancy_begin"
     */
    public Date getDatePregnancyBegin() {
        return datePregnancyBegin;
    }

    public void setDatePregnancyBegin(Date datePregnancyBegin) {
        this.datePregnancyBegin = datePregnancyBegin;
    }

    /**
     * @return
     * @hibernate.many-to-one column="pregnancy_begin_encounter_id"
     * cascade="none"
     * outer-join="false"
     */

    public EncounterData getPregnancyBeginEncounter() {
        return pregnancyBeginEncounter;
    }

    public void setPregnancyBeginEncounter(EncounterData pregnancyBeginEncounter) {
        this.pregnancyBeginEncounter = pregnancyBeginEncounter;
    }

    /**
     * @return
     * @hibernate.property
     * @hibernate.column name="date_pregnancy_end"
     */
    public Date getDatePregnancyEnd() {
        return datePregnancyEnd;
    }

    public void setDatePregnancyEnd(Date datePregnancyEnd) {
        this.datePregnancyEnd = datePregnancyEnd;
    }

    /**
     * @return
     * @hibernate.many-to-one column="pregnancy_end_encounter_id"
     * cascade="none"
     * outer-join="false"
     */

    public EncounterData getPregnancyEndEncounter() {
        return pregnancyEndEncounter;
    }

    public void setPregnancyEndEncounter(EncounterData pregnancyEndEncounter) {
        this.pregnancyEndEncounter = pregnancyEndEncounter;
    }

    /**
     * @hibernate.component class="org.rti.zcore.AuditInfo"
     */
    public AuditInfo getAuditInfo() {
        if (auditInfo == null) {
            auditInfo = new AuditInfo();
        }
        return auditInfo;
    }

    public void setAuditInfo(AuditInfo auditInfo) {
        this.auditInfo = auditInfo;
    }

    /**
     * @return List of encounters in this pregnancy
     */
    public List getEncounters() {
        return encounters;
    }

    public void setEncounters(List encounters) {
        this.encounters = encounters;
    }

    public List getActiveProblems() {
        return activeProblems;
    }

    public void setActiveProblems(List activeProblems) {
        this.activeProblems = activeProblems;
    }

    public List getInActiveProblems() {
        return inActiveProblems;
    }

    public void setInActiveProblems(List inActiveProblems) {
        this.inActiveProblems = inActiveProblems;
    }

    /**
     * @return Encounter that triggers labour admission
     * @hibernate.many-to-one column="labour_admission_encounter_id"
     * cascade="none"
     * outer-join="false"
     */
    public EncounterData getLabourAdmissionEncounter() {
        return labourAdmissionEncounter;
    }

    public void setLabourAdmissionEncounter(EncounterData labourAdmissionEncounter) {
        this.labourAdmissionEncounter = labourAdmissionEncounter;
    }

    /**
     * @return Date of labour admission
     * @hibernate.property
     * @hibernate.column name="date_labour_admission"
     */
    public Date getDateLabourAdmission() {
        return dateLabourAdmission;
    }

    public void setDateLabourAdmission(Date dateLabourAdmission) {
        this.dateLabourAdmission = dateLabourAdmission;
    }

    public List getModifiedValues() {
        return modifiedValues;
    }

    public void setModifiedValues(List modifiedValues) {
        this.modifiedValues = modifiedValues;
    }

    public List getInfants() {
        return infants;
    }

    public void setInfants(List infants) {
        this.infants = infants;
    }

    public Map getEncounterDateMap() {
        return encounterDateMap;
    }

    public void setEncounterDateMap(Map encounterDateMap) {
        this.encounterDateMap = encounterDateMap;
    }

    /**
     * @return imported pregnancy id
     * @hibernate.property
     * @hibernate.column name="import_pregnancy_id"
     */
    public Long getImportPregnancyId() {
        return importPregnancyId;
    }

    public void setImportPregnancyId(Long importPregnancyId) {
        this.importPregnancyId = importPregnancyId;
    }

}

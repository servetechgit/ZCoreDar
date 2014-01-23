/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.dao;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;

import org.apache.commons.beanutils.ConversionException;
import org.apache.commons.dbutils.QueryLoader;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.BaseEncounter;
import org.rti.zcore.Constants;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Event;
import org.rti.zcore.Form;
import org.rti.zcore.dao.FormDAO;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.struts.action.FormAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.PopulatePatientRecord;
import org.rti.zcore.utils.StringManipulation;

/**
 * Saves a record to its associated form table.
 * Does not save to encounter table.
 * Simplifies some of the Zcore methods used by PopulatePatientRecord.saveForm.
 * @author ckelley
 *
 */
public class DarFormDAO {
    /**
     * Commons Logging instance.
     */
    public static Log log = LogFactory.getFactory().getInstance(DarFormDAO.class);
    
    /**
     * Create data structure to save form data to its table, save data, run form through EncounterProcessor to see if it
     * triggers any outcome exceptions
     * @param conn
     * @param formDef
     * @param formId
     * @param patientId
     * @param formData
     * @param encounterId
     * @param siteId
     * @param username
     * @param sessionSubject
     * @return
     * @throws Exception
     * @throws InstantiationException
     * @throws ClassNotFoundException
     * @throws InvocationTargetException
     * @throws SQLException
     * @throws ServletException
     */
    public static EncounterData saveForm(Connection conn, Form formDef, String formId, Long patientId, Map formData, Long encounterId, Long siteId, String username, SessionSubject sessionSubject) throws Exception, InstantiationException, ClassNotFoundException, InvocationTargetException, SQLException, ServletException {
        // Setup the valueobject
        BaseEncounter formObj = FormAction.setupFormObject(formDef, formId, patientId, formData, sessionSubject);
        // Delegate creation to a BO
        //Map src = formData.getMap();
        EncounterData enc = PopulatePatientRecord.populateEncounterData(formDef, formId, siteId, username, formObj, formData);
        Long currentFlowId = null;
        try {
            currentFlowId = sessionSubject.getCurrentFlowId();
        } catch (NullPointerException e) {
            // assume new patient registration or admin form
            currentFlowId = new Long("9");
        }
        enc.setSessionPatient((SessionSubject) sessionSubject); 	// sessionPatient has the patient's uuid.

        EncounterData vo = null;
		vo = create(conn, enc, username, siteId, formDef, currentFlowId, null);
        return vo;
    }
    
    /**
     * Create record. Create a transaction to ensure data integrity, create/set eventId,
     * creates a TimsSessionSubject stub to store patient,uuid if PatientRegistration form.
     * create the encounter, handle updates to patient status and (if form 1, event)
     * Extended Lab Tests - update extendedLabId in labtest table
     * Update values in patient table
     * Commit transaction
     *
     * @param conn
     * @param formObj - must have created/modified info already initialized
     * @param userName
     * @param siteId
     * @param formDef
     * @param currentFlowId
     * @param formBean null for patient bridge tables.
     */
    public static EncounterData create(Connection conn, BaseEncounter formObj, String userName, Long siteId, Form formDef, Long currentFlowId, Map formBean) throws Exception {

        Map queries = QueryLoader.instance().load("/" + Constants.SQL_PATIENT_PROPERTIES);
        Map genQueries = QueryLoader.instance().load("/" + Constants.SQL_GENERATED_PROPERTIES);
        Long patientId = null;
        Long eventId = null;
        Event event = null;
        String eventUuid = null;
        Long encounterId = null;
        Boolean newEvent = null;
        String formName = StringManipulation.fixClassname(formDef.getName());
        EncounterData formData = (EncounterData) formObj;
        SessionSubject sessionPatient = (SessionSubject) formData.getSessionPatient();
        String patientUuid = null;
        if (sessionPatient != null) {
            patientUuid =  sessionPatient.getUuid();
        }

/*    	if (Constants.DATABASE_TYPE.equals("mssql")) {
			DatabaseUtils.create(conn, "SET IDENTITY_INSERT " + formDef.getName() +  " ON");
		}*/

        conn.setAutoCommit(false);
        //log.debug("commit status: " + conn.getAutoCommit());
        // start the transaction
        String sql = "START TRANSACTION;";
        // ArrayList array = new ArrayList();
        try {
        	 // Don't do this in Derby - not necessary
    		if (Constants.DATABASE_TYPE.equals("mysql")) {
    			DatabaseUtils.create(conn, sql);
    		}
            /**
             * Persist the encounter
             */
            encounterId = createEncounter(conn, genQueries, formData, formDef, userName, siteId, formBean);

            formData.setId(encounterId);
            // todo: the vo's siteId is probably already set. Delete next line?
            formData.setSiteId(siteId);
            formData.setFormName(formName);

            int formId = formDef.getId().intValue();


            /**
             * Commit the transaction
             */
        	if (Constants.DATABASE_TYPE.equals("mysql")) {
	            sql = "COMMIT";
	            DatabaseUtils.create(conn, sql);
	            conn.commit();
        	} else {
            	conn.setAutoCommit(true);
        	}
            //log.debug("Commit status: " + conn.getAutoCommit());
        } catch (Exception e) {
        	if (Constants.DATABASE_TYPE.equals("mysql")) {
        		sql = "ROLLBACK";
        		DatabaseUtils.create(conn, sql);
        	} else {
        		conn.rollback();
        	}
        	log.error("Rolling back transation due to error: " + e);
        	e.printStackTrace();
        	throw new SQLException("Error saving this record.", e.getMessage());
        } finally {
        	if (Constants.DATABASE_TYPE.equals("mssql")) {
    			DatabaseUtils.create(conn, "SET IDENTITY_INSERT " + formDef.getName() +  " OFF");
    		}
        }
        return formData;
    }
    
    /**
     * Persists an encounter. Inserts a new record into its associated form table.
     * Does not persist to the encounter table
     * Does not use IDENTITY_VAL_LOCAL(); instead, gets the MAX(id) of the id field.
     * @param conn
     * @param genQueries
     * @param vo
     * @param formDef
     * @param userName
     * @param siteId
     * @param formBean TODO
     * @return id of new encounter
     * @throws Exception
     */
    public static Long createEncounter(Connection conn, Map genQueries, EncounterData vo, Form formDef, String userName, Long siteId, Map formBean) throws Exception {
        //String encSQL = null;
        /*Timestamp created = new Timestamp(System.currentTimeMillis());
        if (vo.getCreated() != null) {
            created = vo.getCreated();
        }
        String createdBy = userName;
        if (vo.getCreatedBy() != null) {
            createdBy = vo.getCreatedBy();
        }
        Timestamp lastModified = new Timestamp(System.currentTimeMillis());
        if (vo.getLastModified() != null) {
            lastModified = vo.getLastModified();
        }
        String lastModifiedBy = userName;
        if (vo.getLastModifiedBy() != null) {
            lastModifiedBy = vo.getLastModifiedBy();
        }
        Long createdSiteId = siteId;
        if (vo.getCreatedSiteId() != null) {
            createdSiteId = vo.getCreatedSiteId();
        }
        Long currentSiteId = siteId;
        if (vo.getSiteId() != null) {
            currentSiteId = vo.getSiteId();
        }*/
        /*String patientUuid = null;
        SessionSubject sessionPatient = (SessionSubject) vo.getSessionPatient();
        if (sessionPatient != null) {
        	patientUuid = sessionPatient.getUuid();
        } else {
            if (formDef.getFormTypeId() != 5 && formDef.getFormTypeId() != 9 && formDef.getFormTypeId() != 10 && formDef.getFormTypeId() != 11) {	// admin or parent child forms
            	patientUuid = vo.getClientUuid();
            	if (patientUuid == null) {
                	log.debug("sessionPatient is null; unable to provide patientUuid for patient id:" + vo.getPatientId());
            	}
            }
        }*/

        /*encSQL = "INSERT INTO encounter " +
        "(patient_id, form_id, flow_id, date_visit, event_id, last_modified, created, " +
        "last_modified_by, created_by, site_id, created_site_id,import_encounter_id, uuid, event_uuid, client_uuid) " +
        "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";*/

        /*ArrayList encValues = new ArrayList();
        encValues.add(vo.getPatientId());
        encValues.add(vo.getFormId());
        encValues.add(vo.getFlowId());
        encValues.add(vo.getDateVisit());
        encValues.add(vo.getEventId());
        encValues.add(lastModified);
        encValues.add(created);
        encValues.add(lastModifiedBy);
        encValues.add(createdBy);
        encValues.add(currentSiteId);
        encValues.add(createdSiteId);
        if (vo.getReferralId() != null) {
        	encValues.add(vo.getReferralId());
        }
        encValues.add(vo.getImportEncounterId());
        if (vo.getUuid() == null) {
            UUID uuid = UUID.randomUUID();
            String uuidStr = uuid.toString();
            encValues.add(uuidStr);
            vo.setUuid(uuidStr);
        } else {
            encValues.add(vo.getUuid());
        }
        encValues.add(vo.getEventUuid());
        encValues.add(patientUuid);*/

        Long encounterId;
        String sqlCreateEncounter = (String) genQueries.get(Constants.SQL_CREATE + vo.getFormId());
        // e.g.: SQL_CREATE131=INSERT INTO item(id, code, name, item_group_id, unit, pack_size, use_in_report) VALUES (IDENTITY_VAL_LOCAL(),?,?,?,?,?,?)
        // replace IDENTITY_VAL_LOCAL() with ?
        String sql = sqlCreateEncounter.replace("IDENTITY_VAL_LOCAL()", "?");
        
        String table = formDef.getName();
        String selectSql = "select MAX(id)+1 from " + table;
        Long id = null;
		Object result = null;;
		try {
			id = (Long) DatabaseUtils.getScalar(conn, selectSql);
		} catch (SQLException e1) {
			log.debug(e1);
		}
		//if (result != null) {
		if (id == null) {
			id = Long.valueOf(1);
		}
        
        // todo: generate the object creation code along w/ the sql code
        ArrayList formValues = null;

        if (formDef.getFormTypeId() == 6) {
            // assign order value to first item in a patient_bridge table.
        	formValues = FormDAO.prepareValueList(vo, formDef, 1, formBean);
        } else {
        	formValues = FormDAO.prepareValueList(vo, formDef, null, formBean);
        }
        
        formValues.add(0, id);

        // log.debug("values: " + values);
        // Object[] params2 = values.toArray();
        encounterId = null;
        try {
            //encounterId = (Long) createEncounter(conn, encSQL, encValues.toArray(), sqlCreateEncounter, formValues, formName);
            DatabaseUtils.updateThrow(conn, sql, formValues.toArray());
            //vo.setId(encounterId);
        } catch (ConversionException e) {
            log.error(e);
        }

        return encounterId;
    }
    
  
    
}

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

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.BaseEncounter;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.FormField;
import org.rti.zcore.PageItem;
import org.rti.zcore.dao.PatientDAO;
import org.rti.zcore.dao.SessionPatientDAO;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.SessionUtil.AttributeNotFoundException;
import org.rti.zcore.utils.StringManipulation;

public class PersistenceDAOImpl implements org.rti.zcore.dao.PersistenceDAO {

	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(PersistenceDAOImpl.class);
	  /**
     * Provides links to methods that update values in the patient table
     * @param conn
     * @param patientId
     * @param formFieldId
     * @param value
     * @param dateVisit
     * @param encounterId
     * @throws SQLException
     */
    public void updatePatientValues(Connection conn, Long patientId, int formFieldId, int value, Date dateVisit, Long encounterId) throws SQLException {

        switch (formFieldId) {
            case 201:  // Patient Status Changes - Type of change
            	if (value == 3290) {
                    PatientDAO.updateDead(conn, patientId, Boolean.TRUE);
            	} else if (value == 3299) {
                    PatientDAO.updateDead(conn, patientId, Boolean.FALSE);
            	}
                break;
            case 490:  // sex change?
            	PatientDAO.updateSex(conn, patientId, value);
            	break;
            case 159:  // height
            	PatientDAO.updateHeight(conn, patientId, value);
                break;
            case 2279:  // age change?
                updateAgeCategory(conn, patientId, value);
                break;
        }
    }


    /**
     * Updates non-patient values and accommodates other situations where you need to refresh the SessionPatient.
     * @param conn
     * @param formFieldId
     * @param encounter
     * @param value
     * @param session
     * @throws SQLException
     * @throws ServletException
     */
    public void updateValues(Connection conn, int formFieldId, BaseEncounter encounter, Object value, HttpSession session) throws SQLException, ServletException {

    	switch (formFieldId) {
    	case 2244:  // Expiry Date
    		try {
				Date expiryDate = Date.valueOf((String)value);
				StockControl sc = (StockControl) encounter;
				sc.setExpiry_date(expiryDate);
				// check if the expiry date if within the limits. Remove from the roll if it is.
				Long itemId = sc.getItem_id();
				Long siteId = encounter.getSiteId();
    	    	// refreshes the StockAlertList.
				StockControlDAO.prepareStockforAlertList(conn, sc, null, itemId);
			} catch (ObjectNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassCastException e1) {
				log.debug(e1);
			}
    		break;
    	case 201: 	// Patient status type of change

    		if (session != null) {
    			 //clear the session data from the previous patient.
                SessionUtil.getInstance(session).setSessionPatient(null);
                // load the sessionPatient
                try {
    				SessionSubject sessionPatient = SessionPatientDAO.updateSessionPatient(conn, encounter.getPatientId(), encounter.getEventUuid(), session);
    			} catch (AttributeNotFoundException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (ObjectNotFoundException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
    		}

    		break;
    	}
    }

    public void updatePatientValues(Connection conn, EncounterData vo, Form form) throws SQLException {
    	Map voMap = null;
		try {
			voMap = BeanUtils.describe(vo);
		} catch (IllegalAccessException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (InvocationTargetException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (NoSuchMethodException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    	Set<PageItem> pageItems = form.getPageItems();
    	Date dateVisit = vo.getDateVisit();
        Long patientId = vo.getPatientId();
        Long encounterId = vo.getId();
        for (PageItem pageItem : pageItems) {
        	FormField formField = pageItem.getForm_field();
        	if ((!formField.getType().equals("Display") && !pageItem.getInputType().equals("multiselect_enum")) || (formField.getOpenmrs_concept() != null && pageItem.getInputType().equals("display-header"))) {
        		Long formFieldId = formField.getId();
        		String fieldName = StringManipulation.firstCharToLowerCase(formField.getStarSchemaName());
        		String value = (String) voMap.get(fieldName);
        		try {
        			int intValue = new Integer(value);
        			updatePatientValues(conn, patientId, formFieldId.intValue(), intValue, dateVisit, encounterId);
        		} catch (NumberFormatException e) {
        			// skip
        		}
        	}
		}
    }


    /**
     * Updates age_category in patient table.
     * @param conn
     * @param patientId
     * @param sex
     * @throws SQLException
     */
    private static void updateAgeCategory(Connection conn, Long patientId, Integer ageCategory) throws SQLException {
        ArrayList patientValues = new ArrayList();
        patientValues.add(ageCategory);
        patientValues.add(patientId);
        String sql = "UPDATE patient SET age_category=? WHERE id=?";
        DatabaseUtils.updateThrow(conn, sql, patientValues.toArray());
    }
}

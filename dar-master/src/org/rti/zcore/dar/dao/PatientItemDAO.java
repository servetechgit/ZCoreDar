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
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.BaseEncounter;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.Task;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dao.PatientBridgeTableDAO;
import org.rti.zcore.dao.TaskListDAO;
import org.rti.zcore.dar.gen.PatientItem;
import org.rti.zcore.exception.ObjectNotFoundException;

public class PatientItemDAO {

	   /**
     * Commons Logging instance.
     */

    private static Log log = LogFactory.getFactory().getInstance(PatientItemDAO.class);


	/**
	 * Get values for these items without mapping the enumerations to String values
	 * Used for reports.
	 * @param conn
	 * @param encounterForm
	 * @param formId
	 * @param encounterId
	 * @param clazz
	 * @return
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 * @throws IOException
	 */
	public static BaseEncounter getEncounterRawValues(Connection conn, Form encounterForm, String formId, Long encounterId, Class clazz) throws ServletException, SQLException, ObjectNotFoundException, IOException {
		BaseEncounter encounter;
		Map encMap;
		// populate the EncounterData object.
		encounter = (EncounterData) EncountersDAO.getOneById(conn, encounterId);
		// create the List of items.
		List items = EncountersDAO.getAllBridge(conn,Long.valueOf(formId), encounterId, clazz);
		// log.debug("count" + items.size());
		// resolve the values for each object in the list
		encMap = new LinkedHashMap();
		int count = 0;
		for (Iterator iterator = items.iterator(); iterator.hasNext();) {
			count ++;
			PatientItem item = (PatientItem) iterator.next();
			if (item.getDateVisit() != null) {
				encounter.setDateVisit(item.getDateVisit());
			} else {
				log.debug("No date visit" + item.getId());
			}
			if (encMap.get(item.getItem_id()) != null) {
				Integer dispensed = (Integer) encMap.get(item.getItem_id());
				dispensed = dispensed + item.getDispensed();
				encMap.put(item.getItem_id(), dispensed);
			} else {
				encMap.put(item.getItem_id(), item.getDispensed());
			}
		}
		encounter.setItems(items);
		encounter.setEncounterMap(encMap);
		return encounter;
	}

	/**
	 * Gets all Items dispensed to a patients.
	 * Adds dispensed to the itemMap if it is null.
	 * @should return a list for the encounters in the flow.
	 * @param conn
	 * @param patientId
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 */
	public static ArrayList<PatientItem> getPatientItemList(Connection conn, Long patientId, String eventUuid, Long flowId, Long formId) throws IOException, ServletException, SQLException {
		ArrayList items = new ArrayList();
        //Long formId = (Long) DynaSiteObjects.getFormNameMap().get("PatientItem");
		Form encounterForm = ((Form) DynaSiteObjects.getForms().get(new Long(formId)));
		//List<PatientItem> encounters = EncountersDAO.getAllRecordsForForm(conn, patientId, formId, PatientItem.class);
		List<Task> tasks = TaskListDAO.getEncounterTasks(conn, patientId, eventUuid, flowId);
		for (Task task : tasks) {
			try {
				BaseEncounter encounter = PatientBridgeTableDAO.getEncounter(conn, encounterForm, formId, task.getEncounterId(), PatientItem.class);
				List<PatientItem> itemList = encounter.getItems();
				Map itemMap = encounter.getEncounterMap();
				int count = 0;
				for (PatientItem patientItem : itemList) {
					count++;
					if (itemMap.get("PBF" + count + "_number_of_days") == null) {
						itemMap.put("PBF" + count + "_number_of_days", " ");
					}
				}
				if (task.getRecords() == null) {
					ArrayList records = new ArrayList();
					task.setRecords(records);
				}
				task.getRecords().add((EncounterData) encounter);
			} catch (ObjectNotFoundException e) {
				log.debug(e);
			}
			items.add(task);

		}
		return items;
	}

}

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

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.dao.FormDAO;
import org.rti.zcore.dar.gen.Appointment;
import org.rti.zcore.dar.gen.ArtRegimen;
import org.rti.zcore.dar.gen.PatientCondition;
import org.rti.zcore.dar.gen.PatientRegistration;
import org.rti.zcore.dar.utils.DateofVisitReverseOrderComparator;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.utils.DateUtils;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.converters.ConversionException;
import com.thoughtworks.xstream.converters.extended.ISO8601SqlTimestampConverter;

public class ImportMshData {

	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(ImportMshData.class);
    public static final String NL = System.getProperty("line.separator");

	/**
	 * De-serialises PatientMaster table from MSH Access database.
	 * Must export data from Access to XML file.
	 * @param fileName TODO
	 * @return ArrayList<MshPatientMaster>
	 * @throws FileNotFoundException
	 * @throws IOException
	 * @should return a list
	 */
	public static ArrayList<MshPatientMaster> getPatientMaster(String fileName) throws FileNotFoundException, IOException {
		ArrayList<MshPatientMaster> list = null;
		//ArrayList<MshPatientMaster> list = (ArrayList<MshPatientMaster>) XmlUtils.getOne(fileName, null, MshPatientMaster.class);
		XStream xstream = new XStream();
		xstream.alias("MshPatientMaster", MshPatientMaster.class);
		xstream.registerConverter(new ISO8601SqlTimestampConverter());
		xstream.registerConverter(new IntegerConverter());
		FileReader fr = (new FileReader(fileName));
		Reader reader = new BufferedReader(fr);
		try {
			list = (ArrayList<MshPatientMaster>) xstream.fromXML(reader);
		} catch (NumberFormatException e) {
			log.error(e);
		} catch (ConversionException e) {
			log.error(e);
			e.printStackTrace();
		}
		reader.close();
		fr.close();
		return list;
	}

	/**
	 * De-serialises tblARTPatientTransactions table from MSH Access database.
	 * Must export data from Access to XML file.
	 *
	 * @param fileName
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static ArrayList<MshPatientTransaction> getPatientTransactions(String fileName) throws FileNotFoundException, IOException {
		ArrayList<MshPatientTransaction> list = null;
		//ArrayList<MshPatientMaster> list = (ArrayList<MshPatientMaster>) XmlUtils.getOne(fileName, null, MshPatientMaster.class);
		XStream xstream = new XStream();
		xstream.alias("MshPatientTransaction", MshPatientTransaction.class);
		xstream.registerConverter(new ISO8601SqlTimestampConverter());
		xstream.registerConverter(new IntegerConverter());
		FileReader fr = (new FileReader(fileName));
		Reader reader = new BufferedReader(fr);
		try {
			list = (ArrayList<MshPatientTransaction>) xstream.fromXML(reader);
		} catch (NumberFormatException e) {
			log.error(e);
		} catch (ConversionException e) {
			log.error(e);
			e.printStackTrace();
		}
		reader.close();
		fr.close();
		return list;
	}

	/**
	 * Imports patients from XML file created from mshPatientMaster
	 * @param patientMasterFilename TODO
	 * @param patientTransactionsFilename TODO
	 * @throws Exception
	 * @should be not null
	 */
	public static Integer importPatients(Connection conn, String patientMasterFilename, String patientTransactionsFilename) throws Exception {
		Integer countPatients = 0;
		Long siteId = Long.valueOf(24);	// Riruta
		ArrayList<MshPatientMaster> list = null;
		list = ImportMshData.getPatientMaster(patientMasterFilename);
		HashMap<String,ArrayList<MshPatientTransaction>> transMap = new HashMap<String,ArrayList<MshPatientTransaction>>();
		ArrayList<MshPatientTransaction> transactions = null;
		transactions = ImportMshData.getPatientTransactions(patientTransactionsFilename);
		for (MshPatientTransaction mshPatientTransactions : transactions) {
			String ARTID = mshPatientTransactions.getARTID();
			ArrayList<MshPatientTransaction>  patientTransactions = transMap.get(ARTID);
			if (patientTransactions == null) {
				patientTransactions = new ArrayList<MshPatientTransaction>();
			}
			patientTransactions.add(mshPatientTransactions);
			DateofVisitReverseOrderComparator doc = new DateofVisitReverseOrderComparator();
	        Collections.sort(patientTransactions, doc);
			transMap.put(ARTID, patientTransactions);
		}

		for (MshPatientMaster mshPatientMaster : list) {
			if (mshPatientMaster.getSurname() != null) {
				String ARTID = mshPatientMaster.getArtID();
				ArrayList<MshPatientTransaction>  patientTransactions = transMap.get(ARTID);
				EncounterData enc = createPatientRegistration(conn, siteId, mshPatientMaster, patientTransactions);
				mshPatientMaster.setPatientId(enc.getPatientId());
				mshPatientMaster.setPatientUuid(enc.getClientUuid());
				mshPatientMaster.setSessionPatient((SessionSubject) enc.getSessionPatient());
				if (enc.getSessionPatient() == null) {
					// create a SessionSubject to store patient.uuid
					SessionSubject sessionPatient = new SessionSubject();
                	sessionPatient.setUuid(enc.getClientUuid());
                	sessionPatient.setId(enc.getPatientId());
                	mshPatientMaster.setSessionPatient(sessionPatient);
				}
				mshPatientMaster.setEvent(enc.getEvent());
				mshPatientMaster.setEventId(enc.getEventId());
				mshPatientMaster.setEventUuid(enc.getEventUuid());
				createInitialHealthRecord(conn, siteId, mshPatientMaster);
				if (mshPatientMaster.getCurrentHeight() != null) {
					createCurrentHealthRecord(conn, siteId, mshPatientMaster);
				}
				if (mshPatientMaster.getRegimenStarted() != null) {
					createInitialRegimen(conn, siteId, mshPatientMaster);
				}
				if (mshPatientMaster.getCurrentRegimen() != null) {
					createCurrentRegimen(conn, siteId, mshPatientMaster);
				}
				if (mshPatientMaster.getDateOfNextAppointment() != null) {
					createApppointment(conn, siteId, mshPatientMaster);
				}
				countPatients++;
			}
		}
		return countPatients;
	}

	/**
	 * @param conn
	 * @param siteId
	 * @param mshPatientMaster
	 * @param patientTransactions
	 * @throws NumberFormatException
	 * @throws Exception
	 */
	private static EncounterData createPatientRegistration(Connection conn, Long siteId, MshPatientMaster mshPatientMaster, ArrayList<MshPatientTransaction> patientTransactions)
			throws NumberFormatException, Exception {
		Form formDef = null;
		//String formName = className.replace(Constants.getDynasiteFormsPackage() + ".", "");
		Long formId = (Long) DynaSiteObjects.getFormNameMap().get("PatientRegistration");
		formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		// Patient patient = new Patient();
		PatientRegistration pr = new PatientRegistration();
		pr.setPatient_id_number(mshPatientMaster.getArtID());
		pr.setFirstName(mshPatientMaster.getFirstname());
		pr.setForenames(mshPatientMaster.getFirstname());
		pr.setStreet_address_1(mshPatientMaster.getAddress());
		if (mshPatientMaster.getSex().equals("Male")) {
			pr.setSex(2);
		} else {
			pr.setSex(1);
		}
		pr.setSurname(mshPatientMaster.getSurname());
		pr.setAge_at_first_attendence(mshPatientMaster.getAge());
		pr.setSiteId(siteId);
		pr.setCreatedBy("zepadmin");
		//Person is a child when age is <= this number
		//child.age=14
		String childAge = Constants.CHILD_AGE;
		Integer childAgeInt = Integer.valueOf(childAge);
		if (mshPatientMaster.getAge() <= childAgeInt) {
			pr.setAge_category(3284);
		} else {
			pr.setAge_category(3283);
		}

		if (patientTransactions != null) {
			StringBuffer sbuf = new StringBuffer();
			sbuf.append("<p>Imported Transactions:</p>");
			for (MshPatientTransaction mshPatientTransactions : patientTransactions) {
				sbuf.append("<p>");
				String record = mshPatientTransactions.toString();
				sbuf.append(record);
				sbuf.append("</p>");
				sbuf.append(NL);
			}
			String notes = sbuf.toString();
			int len = notes.length();
			int max = 32700 - 30;
			if (len > max) {
				log.debug("Truncating record for patient id: " + mshPatientMaster.getArtID() + " len: " + len);
				String message = "<p>(Record truncated...)</p>";
				String notesTruncated = notes.substring(0, max);
				pr.setNotes(notesTruncated + NL + message);
			} else {
				pr.setNotes(notes);
			}
		}


		/*patient.setPatientRegistration(pr);
		patient.setSiteId(siteId);*/
		pr.setFlowId(formDef.getFlowId());
		pr.setFormId(formId);
		Date dateVisit = DateUtils.toDateSql(mshPatientMaster.getDateTherapyStarted());
		pr.setDateVisit(dateVisit);
		if (dateVisit != null) {
			Timestamp ts = new Timestamp(dateVisit.getTime());
			pr.setCreated(ts);
			pr.setLastModified(ts);
		}

		EncounterData enc = FormDAO.create(conn, pr, pr.getCreatedBy(), pr.getSiteId(), formDef, pr.getFlowId(), null);
		return enc;
	}

	/**
	 * Creates Initial Health Record.
	 * Uses mshPatientMaster.getDateTherapyStarted() for datevisit.
	 * @param conn
	 * @param siteId
	 * @param mshPatientMaster
	 * @return
	 * @throws NumberFormatException
	 * @throws Exception
	 */
	private static EncounterData createInitialHealthRecord(Connection conn, Long siteId, MshPatientMaster mshPatientMaster)
	throws NumberFormatException, Exception {
		Form formDef = null;
		Long formId = (Long) DynaSiteObjects.getFormNameMap().get("PatientCondition");
		formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		PatientCondition formData = new PatientCondition();
		formData.setSiteId(siteId);
		formData.setCreatedBy("zepadmin");
		formData.setFlowId(formDef.getFlowId());
		formData.setFormId(formId);
		formData.setPatientId(mshPatientMaster.getPatientId());
		formData.setSessionPatient(mshPatientMaster.getSessionPatient());
		formData.setEvent(mshPatientMaster.getEvent());
		formData.setEventId(mshPatientMaster.getEventId());
		formData.setEventUuid(mshPatientMaster.getEventUuid());

		Date dateVisit = DateUtils.toDateSql(mshPatientMaster.getDateTherapyStarted());
		formData.setDateVisit(dateVisit);
		formData.setWeight(mshPatientMaster.getWeightOnStart());
		formData.setHeight(mshPatientMaster.getStartHeight());
		if (dateVisit != null) {
			Timestamp ts = new Timestamp(dateVisit.getTime());
			formData.setCreated(ts);
			formData.setLastModified(ts);
		}
		/*StringBuffer sbuf = new StringBuffer();
		formData.setOi_indications(sbuf.toString());*/

		EncounterData enc = FormDAO.create(conn, formData, formData.getCreatedBy(), formData.getSiteId(), formDef, formData.getFlowId(), null);
		return enc;
	}

	/**
	 * Creates Current Health Record.
	 * @param conn
	 * @param siteId
	 * @param mshPatientMaster
	 * @return
	 * @throws NumberFormatException
	 * @throws Exception
	 */
	private static EncounterData createCurrentHealthRecord(Connection conn, Long siteId, MshPatientMaster mshPatientMaster)
	throws NumberFormatException, Exception {
		Form formDef = null;
		Long formId = (Long) DynaSiteObjects.getFormNameMap().get("PatientCondition");
		formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		PatientCondition formData = new PatientCondition();
		formData.setSiteId(siteId);
		formData.setCreatedBy("zepadmin");
		formData.setFlowId(formDef.getFlowId());
		formData.setFormId(formId);
		formData.setPatientId(mshPatientMaster.getPatientId());
		formData.setSessionPatient(mshPatientMaster.getSessionPatient());
		formData.setEvent(mshPatientMaster.getEvent());
		formData.setEventId(mshPatientMaster.getEventId());
		formData.setEventUuid(mshPatientMaster.getEventUuid());

		Integer dateOffset = mshPatientMaster.getDaysToNextAppointment();
		Date dateVisit = null;
		Date initialvisit = DateUtils.toDateSql(mshPatientMaster.getDateTherapyStarted());
		if ((mshPatientMaster.getDateOfNextAppointment() != null) && (dateOffset != null)) {
			Date dateNextAppt = DateUtils.toDateSql(mshPatientMaster.getDateOfNextAppointment());
			String datePastVisitStr = DateUtils.createFutureDate(dateNextAppt, 0-dateOffset);
			Date datePastVisit = Date.valueOf(datePastVisitStr);
			if (datePastVisit.getTime() > initialvisit.getTime()) {
				dateVisit = datePastVisit;
			} else {
				dateVisit = initialvisit;
			}
		} else {
			dateVisit = initialvisit;
		}
		formData.setDateVisit(dateVisit);
		if (dateVisit != null) {
			Timestamp ts = new Timestamp(dateVisit.getTime());
			formData.setCreated(ts);
			formData.setLastModified(ts);
		}
		formData.setWeight(mshPatientMaster.getCurrentWeight());
		formData.setHeight(mshPatientMaster.getCurrentHeight());
		if (mshPatientMaster.getTB() == 1) {
			formData.setTb_status(3297);	//Under treatment
		} else if (mshPatientMaster.getNoTB() == 1) {
			formData.setTb_status(3296);	// None
		}
		StringBuffer sbuf = new StringBuffer();
		if (mshPatientMaster.getCotrimoxazole() == 1) {
			sbuf.append("Taking Cotrimoxazole. ");
		}
		if (mshPatientMaster.getNoCotrimoxazole() == 1) {
			sbuf.append("Not taking Cotrimoxazole. ");
		}
		formData.setOi_indications(sbuf.toString());

		EncounterData enc = FormDAO.create(conn, formData, formData.getCreatedBy(), formData.getSiteId(), formDef, formData.getFlowId(), null);
		return enc;
	}

	private static EncounterData createInitialRegimen(Connection conn, Long siteId, MshPatientMaster mshPatientMaster)
	throws NumberFormatException, Exception {
		Form formDef = null;
		Long formId = (Long) DynaSiteObjects.getFormNameMap().get("ArtRegimen");
		formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		ArtRegimen formData = new ArtRegimen();
		formData.setSiteId(siteId);
		formData.setCreatedBy("zepadmin");
		formData.setFlowId(formDef.getFlowId());
		formData.setFormId(formId);
		formData.setPatientId(mshPatientMaster.getPatientId());
		formData.setSessionPatient(mshPatientMaster.getSessionPatient());
		formData.setEvent(mshPatientMaster.getEvent());
		formData.setEventId(mshPatientMaster.getEventId());
		formData.setEventUuid(mshPatientMaster.getEventUuid());

		Date  dateVisit = DateUtils.toDateSql(mshPatientMaster.getDateTherapyStarted());
		formData.setDateVisit(dateVisit);
		if (dateVisit != null) {
			Timestamp ts = new Timestamp(dateVisit.getTime());
			formData.setCreated(ts);
			formData.setLastModified(ts);
		}
		formData.setDate_started(dateVisit);

		String regimen = mshPatientMaster.getRegimenStarted();
		Integer regimenCode = null;
		boolean importEncounter = true;
		if (regimen.equals("R01")) {
			importEncounter = false;
		} else if (regimen.equals("R02")) {	//1A
			regimenCode = 1;
		} else if (regimen.equals("R03")) {	//R03	2A	3
			regimenCode = 3;
		} else if (regimen.equals("R04")) {	//R04	3A	5
			regimenCode = 5;
		} else if (regimen.equals("R05")) {	//R05	3B	6
			regimenCode = 6;
		} else if (regimen.equals("R06")) {	//R06	4A	7
			regimenCode = 7;
		} else if (regimen.equals("R07")) {	//R07	5A	9
			regimenCode = 9;
		} else if (regimen.equals("R08")) {	//R08	5B	10
			regimenCode = 10;
		} else if (regimen.equals("R09")) {	//R09	6A	11
			regimenCode = 11;
		} else if (regimen.equals("R10")) {	//R10	6B	12
			regimenCode = 12;
		} else if (regimen.equals("R12")) {	//R12	7A	13
			regimenCode = 13;
		} else if (regimen.equals("R21")) {	//R21	PEP 1	21	PEP 1 (AZT/3TC)
			regimenCode = 21;
		} else if (regimen.equals("R23")) {	//R23	PEP 3	24
			regimenCode = 24;
		} else if (regimen.equals("R26")) {	//R26	C1A	36
			regimenCode = 36;
		} else if (regimen.equals("R27")) {	//R27	C2A	40
			regimenCode = 40;
		} else if (regimen.equals("R28")) {	//R28	C3A	44
			regimenCode = 44;
		} else if (regimen.equals("R29")) {	//R29	C3B	45
			regimenCode = 45;
		} else if (regimen.equals("R30")) {	//R30	C4A	48
			regimenCode = 48;
		} else if (regimen.equals("R31")) {	//R31	C4B	49
			regimenCode = 49;
		} else if (regimen.equals("R32")) {	//R32	C4C	50
			regimenCode = 50;
		} else {
			importEncounter = false;
			log.debug("Unable to import regimen for patient id" + mshPatientMaster.getPatientId() + " Regimen: " + regimen);
		}
		formData.setRegimen_1(regimenCode);
		EncounterData enc = null;
		if (importEncounter) {
			enc = FormDAO.create(conn, formData, formData.getCreatedBy(), formData.getSiteId(), formDef, formData.getFlowId(), null);
		}
		return enc;
	}

	private static EncounterData createCurrentRegimen(Connection conn, Long siteId, MshPatientMaster mshPatientMaster)
	throws NumberFormatException, Exception {
		Form formDef = null;
		Long formId = (Long) DynaSiteObjects.getFormNameMap().get("ArtRegimen");
		formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		ArtRegimen formData = new ArtRegimen();
		formData.setSiteId(siteId);
		formData.setCreatedBy("zepadmin");
		formData.setFlowId(formDef.getFlowId());
		formData.setFormId(formId);
		formData.setPatientId(mshPatientMaster.getPatientId());
		formData.setSessionPatient(mshPatientMaster.getSessionPatient());
		formData.setEvent(mshPatientMaster.getEvent());
		formData.setEventId(mshPatientMaster.getEventId());
		formData.setEventUuid(mshPatientMaster.getEventUuid());

		Integer dateOffset = mshPatientMaster.getDaysToNextAppointment();
		Date dateVisit = null;
		Date initialvisit = DateUtils.toDateSql(mshPatientMaster.getDateTherapyStarted());
		if ((mshPatientMaster.getDateOfNextAppointment() != null) && (dateOffset != null)) {
			Date dateNextAppt = DateUtils.toDateSql(mshPatientMaster.getDateOfNextAppointment());
			String datePastVisitStr = DateUtils.createFutureDate(dateNextAppt, 0-dateOffset);
			Date datePastVisit = Date.valueOf(datePastVisitStr);
			if (datePastVisit.getTime() > initialvisit.getTime()) {
				dateVisit = datePastVisit;
			} else {
				dateVisit = initialvisit;
			}
		} else {
			dateVisit = initialvisit;
		}
		formData.setDateVisit(dateVisit);
		if (dateVisit != null) {
			Timestamp ts = new Timestamp(dateVisit.getTime());
			formData.setCreated(ts);
			formData.setLastModified(ts);
		}
		formData.setDate_started(dateVisit);
		String regimen = mshPatientMaster.getCurrentRegimen();
		Integer regimenCode = null;
		boolean importEncounter = true;
		if (regimen.equals("R01")) {
			importEncounter = false;
		} else if (regimen.equals("R02")) {	//1A
			regimenCode = 1;
		} else if (regimen.equals("R03")) {	//R03	2A	3
			regimenCode = 3;
		} else if (regimen.equals("R04")) {	//R04	3A	5
			regimenCode = 5;
		} else if (regimen.equals("R05")) {	//R05	3B	6
			regimenCode = 6;
		} else if (regimen.equals("R06")) {	//R06	4A	7
			regimenCode = 7;
		} else if (regimen.equals("R07")) {	//R07	5A	9
			regimenCode = 9;
		} else if (regimen.equals("R08")) {	//R08	5B	10
			regimenCode = 10;
		} else if (regimen.equals("R09")) {	//R09	6A	11
			regimenCode = 11;
		} else if (regimen.equals("R10")) {	//R10	6B	12
			regimenCode = 12;
		} else if (regimen.equals("R12")) {	//R12	7A	13
			regimenCode = 13;
		} else if (regimen.equals("R12")) {	//R12	7A	13
			regimenCode = 13;
		} else if (regimen.equals("R13")) {	//R13	7B	14	7B (TDF/FTC/EFV)
			regimenCode = 14;
		} else if (regimen.equals("R21")) {	//R21	PEP 1	21	PEP 1 (AZT/3TC)
			regimenCode = 21;
		} else if (regimen.equals("R23")) {	//R23	PEP 3	24
			regimenCode = 24;
		} else if (regimen.equals("R26")) {	//R26	C1A	36
			regimenCode = 36;
		} else if (regimen.equals("R27")) {	//R27	C2A	40
			regimenCode = 40;
		} else if (regimen.equals("R28")) {	//R28	C3A	44
			regimenCode = 44;
		} else if (regimen.equals("R29")) {	//R29	C3B	45
			regimenCode = 45;
		} else if (regimen.equals("R30")) {	//R30	C4A	48
			regimenCode = 48;
		} else if (regimen.equals("R31")) {	//R31	C4B	49
			regimenCode = 49;
		} else if (regimen.equals("R32")) {	//R32	C4C	50
			regimenCode = 50;
		} else {
			importEncounter = false;
			log.debug("Unable to import regimen for patient id" + mshPatientMaster.getPatientId() + " Regimen: " + regimen);
		}
		formData.setRegimen_1(regimenCode);
		if ((mshPatientMaster.getReasonsforChanges() != null) && (!mshPatientMaster.getReasonsforChanges().equals(""))) {
			Integer reasonForChange = mshPatientMaster.getReasonsforChanges();
			String reason = null;
			switch (reasonForChange) {
			case 1:
				reason = "Anemia";
				break;
			case 2:
				reason = "TB";
				break;
			case 3:
				reason = "Pregnancy";
				break;
			case 4:
				reason = "Neuropathy";
				break;
			case 5:
				reason = "Rash";
				break;
			case 6:
				reason = "Lipodistrophy";
				break;
			case 7:
				reason = "fluconazole treatment";
				break;
			case 8:
				reason = "treatment failure";
				break;
			case 9:
				reason = "Guideline change";
				break;

			default:
				break;
			}
			formData.setRegimen_change_reason(reason);
		}
		EncounterData enc = null;
		if (importEncounter) {
			enc = FormDAO.create(conn, formData, formData.getCreatedBy(), formData.getSiteId(), formDef, formData.getFlowId(), null);
		}
		return enc;
	}

	private static EncounterData createApppointment(Connection conn, Long siteId, MshPatientMaster mshPatientMaster)
	throws NumberFormatException, Exception {
		Form formDef = null;
		Long formId = (Long) DynaSiteObjects.getFormNameMap().get("Appointment");
		formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		Appointment formData = new Appointment();
		formData.setSiteId(siteId);
		formData.setCreatedBy("zepadmin");
		formData.setFlowId(formDef.getFlowId());
		formData.setFormId(formId);
		formData.setPatientId(mshPatientMaster.getPatientId());
		formData.setSessionPatient(mshPatientMaster.getSessionPatient());
		formData.setEvent(mshPatientMaster.getEvent());
		formData.setEventId(mshPatientMaster.getEventId());
		formData.setEventUuid(mshPatientMaster.getEventUuid());

		Integer dateOffset = mshPatientMaster.getDaysToNextAppointment();
		Date dateVisit = null;
		Date initialvisit = DateUtils.toDateSql(mshPatientMaster.getDateTherapyStarted());
		Date dateNextAppt = DateUtils.toDateSql(mshPatientMaster.getDateOfNextAppointment());
		if ((dateNextAppt != null) && (dateOffset != null)) {
			String datePastVisitStr = DateUtils.createFutureDate(dateNextAppt, 0-dateOffset);
			Date datePastVisit = Date.valueOf(datePastVisitStr);
			if (datePastVisit.getTime() > initialvisit.getTime()) {
				dateVisit = datePastVisit;
			} else {
				dateVisit = initialvisit;
			}
		} else {
			dateVisit = initialvisit;
		}
		formData.setDateVisit(dateVisit);
		if (dateVisit != null) {
			Timestamp ts = new Timestamp(dateVisit.getTime());
			formData.setCreated(ts);
			formData.setLastModified(ts);
		}
		formData.setAppointment_date(dateNextAppt);
		EncounterData enc = null;
		if (dateNextAppt != null) {
			enc = FormDAO.create(conn, formData, formData.getCreatedBy(), formData.getSiteId(), formDef, formData.getFlowId(), null);
		}
		return enc;
	}
}

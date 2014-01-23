/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.DynaActionForm;
import org.apache.struts.action.DynaActionFormClass;
import org.apache.struts.config.FormBeanConfig;
import org.apache.struts.config.ModuleConfig;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.FieldEnumeration;
import org.rti.zcore.Form;
import org.rti.zcore.FormField;
import org.rti.zcore.PageItem;
import org.rti.zcore.Site;
import org.rti.zcore.dao.SessionPatientDAO;
import org.rti.zcore.dar.gen.PatientRegistration;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.remote.PatientId;
import org.rti.zcore.sync.Publisher;
import org.rti.zcore.sync.utils.PubSubUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.PatientRecordUtils;
import org.rti.zcore.utils.PopulatePatientRecord;

public class TestPatientUtils {

    /**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(TestPatientUtils.class);

	/**
	     * Creates a test patient
	     * @param conn
	     * @param siteId
	     * @param patientType - basic: Patient up to prob/labour visit
	     * @param username
	     * @return
	     * @throws Exception
	     * @throws SQLException
	     */
	    public static EncounterData populate(Connection conn, Long siteId, String patientType, String username) throws Exception, SQLException {
	    	Long patientId = null;
	    	Long eventId = null;
	    	Long flowId = null;
	    	Long encounterId = null;
	    	SessionSubject sessionPatient = null;


	        //DynaActionForm dynaForm = null;
	        String firstName = null;
	        //Site site = SessionUtil.getInstance(site).getClientSettings().getSite();
	        //Long siteId = siteId.getId();
	        boolean longEGA = false;
	        boolean noPrevs = false;
	        /*if (patientType.equals("partograph")) {
	            firstName = "Parto";
	        } else if (patientType.equals("labour")) {
	            firstName = "Labour";*/
	       // } else {
	            firstName = "Basic";
	            longEGA = false;  // change to true of you want a long ega to test system-generated problems.
	        //}
	            ArrayList<String> recordTypes = new ArrayList<String>();
	        if (Constants.RECORD_EXPORT_FORMAT.equals("openmrs")) {
	        	//recordTypes.add("initialvisit");

	        } else {
	        	if (patientType.equals("AF1B")) {
	        		firstName = "AF1B";
	        		recordTypes.add("RegimenAF1B");
	        	} else if (patientType.equals("AF1C")) {
	        		firstName = "AF1C";
	        		recordTypes.add("RegimenAF1C");
	        	} else if (patientType.equals("AF2A")) {
	        		firstName = "AF2A";
	        		recordTypes.add("RegimenAF2A");
	        	} else if (patientType.equals("AF2B")) {
	        		firstName = "AF2B";
	        		recordTypes.add("RegimenAF2B");
	        	} else if (patientType.equals("AF2C")) {
	        		firstName = "AF2C";
	        		recordTypes.add("RegimenAF2C");
	        	} else if (patientType.equals("AF1A")) {
	        		firstName = "AF1A";
	        		recordTypes.add("RegimenAF1A");
	        	} else if (patientType.equals("child")) {
	        		firstName = "CF1A";
	        		recordTypes.add("RegimenCF1A");
	        	} else {
	        		firstName = "AF1A";
	        		recordTypes.add("RegimenAF1A");
	        	}
	        }
	        // create new patient
	        //dynaForm = createPatient(cfg, firstName, siteId);
	        Map formData = null;
	        formData = TestPatientUtils.createPatient(conn, firstName, siteId, false);
	        /*if (patientType.equals("child")) {
	        	firstName = "CF1A";
		        formData = TestPatientUtils.createPatient(conn, firstName, siteId, true);
		        recordTypes.add("RegimenCF1A");
	        } else {
	        	//firstName = "AF1A";
		        formData = TestPatientUtils.createPatient(conn, firstName, siteId, false);
		        //recordTypes.add("RegimenAF1A");
	        }*/
	         // Create initial dateVisit field to store the earliest dateVisit value.
	        Date dateVisit = (Date) formData.get("date_visit");

	        Long formId = new Long("1");
	        Form formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        EncounterData patReg = null;
	        try {
	            patReg = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        } catch (Exception e) {
	            log.error(e);
	            e.printStackTrace();
	        }
	        patientId = patReg.getPatientId();
	        sessionPatient = (SessionSubject) SessionPatientDAO.getSessionPatient(conn, patientId, patReg.getEventUuid(), null);

	        if (recordTypes.contains("RegimenAF1A")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "6");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        if (recordTypes.contains("RegimenCF1A")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "48");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        if (recordTypes.contains("RegimenAF1B")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "5");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        if (recordTypes.contains("RegimenAF1C")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "389");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        if (recordTypes.contains("RegimenAF2A")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "390");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        if (recordTypes.contains("RegimenAF2B")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "225");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        if (recordTypes.contains("RegimenAF2C")) {
	        	// create case report request
	        	formId = new Long("137");
	        	formData = TestPatientUtils.fillFormData(formId);
	        	formData.put("date_started", dateVisit.toString());
	        	formData.put("regimen_1", "391");
	        	formDef = (Form) DynaSiteObjects.getForms().get(formId);
	        	try {
	        		EncounterData record = PopulatePatientRecord.saveForm(conn, formDef, formId.toString(), patientId, formData, encounterId, siteId, username, sessionPatient);
	        	} catch (Exception e) {
	        		log.error(e);
	        	}
	        }
	        return patReg;
	    }

	/**
	 * Creates PatientRegistration DynaActionForm object for creating test patients.
	 * @param conn TODO
	 * @param modCfg
	 * @param firstName
	 * @param siteId
	 * @return
	 */
	public static DynaActionForm createPatient(Connection conn, ModuleConfig modCfg, String firstName, Long siteId) {
	    FormBeanConfig formBeanConfig = modCfg.findFormBeanConfig("PatientRegistration");
	    DynaActionForm dynaForm = null;
	    DynaActionFormClass dynaClass = DynaActionFormClass.createDynaActionFormClass(formBeanConfig);
	    try {
	        dynaForm = (DynaActionForm) dynaClass.newInstance();
	    } catch (IllegalAccessException e) {
	        e.printStackTrace();
	    } catch (InstantiationException e) {
	        e.printStackTrace();
	    }

	    // create random number
	    Random generator = new Random();

	    int first = generator.nextInt(100000);
	    int sur = generator.nextInt(10000);
	    int addNum = generator.nextInt(10000);
	    int age = generator.nextInt(40) + 13;
	    String birthDate = DateUtils.generateBirthdate(age).toString();
	    String countryIdDate = birthDate.replace("-", "").substring(2);
	    String countryId = countryIdDate + "-" + "1" + "111" + "-"  + "0" + "8" + "0";
	    PatientRegistration registration = new PatientRegistration();
	    registration.setSurname("Patient" + sur);
	    if (firstName != null) {
	       registration.setForenames(firstName + first);
	    } else {
	       registration.setForenames("Test" + first);
	    }
	    registration.setCountry_id_number(countryId);
	    registration.setAge_at_first_attendence(Integer.valueOf(String.valueOf(age)));
	    //registration.setField19(addNum + " Park Place");
	    registration.setBirth_date(java.sql.Date.valueOf(birthDate));
	    registration.setSex(Integer.valueOf(1));
	    registration.setAddress_1(age + " Maple street");
	    // create the zeprsId
	    Publisher publisher = null;
	    Integer siteInstanceId = 0;
	    try {
	    	publisher = PubSubUtils.getPublisher();
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	    if (publisher != null) {
	        siteInstanceId = publisher.getSiteInstanceId();
	    }

	    String districtId = "1000";

	    Site site = (Site) DynaSiteObjects.getClinicMap().get(siteId);
	    String zepSiteId = site.getSiteAlphaId();
	    String zePatientId = PatientId.setPatientId(conn, districtId, zepSiteId + siteInstanceId);
	    String zeprsId = PatientRecordUtils.createZeprsId(districtId, zepSiteId + siteInstanceId, zePatientId);
	    registration.setPatient_id_number(zeprsId);
	    //registration.setField13("5040");
	    //registration.setField1511(site.getSiteAlphaId().substring(0, 3));

	    Map regMap = new HashMap();

	    try {
	        regMap = BeanUtils.describe(registration);
	    } catch (IllegalAccessException e) {
	        e.printStackTrace();
	    } catch (InvocationTargetException e) {
	        e.printStackTrace();
	    } catch (NoSuchMethodException e) {
	        e.printStackTrace();
	    }

	    Set dynaSet = dynaForm.getMap().entrySet();
	    for (Iterator iterator = dynaSet.iterator(); iterator.hasNext();) {
	        Map.Entry entry = (Map.Entry) iterator.next();
	        String key = (String) entry.getKey();
	        dynaForm.set(key, regMap.get(key));
	    }

	    dynaForm.set("date_visit", DateUtils.getNow().toString());
	    return dynaForm;
	}

	/**
	 *
	 * @param conn
	 * @param firstName
	 * @param siteId
	 * @param child
	 * @return
	 */
	public static Map createPatient(Connection conn, String firstName, Long siteId, boolean child) {

		Publisher publisher;
		Integer siteInstanceId = 0;
		try {
			publisher = PubSubUtils.getPublisher();
			siteInstanceId = publisher.getSiteInstanceId();
		} catch (IOException e1) {
			log.debug(e1);
		}
		// create random number
		Random generator = new Random();

		int first = generator.nextInt(100000);
		int sur = generator.nextInt(10000);
		int addNum = generator.nextInt(10000);
		int age = 0;
		String childAgeStr = Constants.CHILD_AGE;
		Integer childAge = 14;
		if (childAgeStr != null) {
			childAge = Integer.valueOf(childAgeStr);
		}
		if (child) {
			age = generator.nextInt(childAge);
		} else {
			age = generator.nextInt(40) + 15;
		}
		String birthDate = DateUtils.generateBirthdate(age).toString();
		String countryIdDate = birthDate.replace("-", "").substring(2);
		String countryId = countryIdDate + "-" + "1" + "111" + "-"  + "0" + "8" + "0";
		PatientRegistration registration = new PatientRegistration();
		registration.setSurname("Patient" + sur + "-" + siteInstanceId);
		if (firstName != null) {
			if (child) {
				registration.setForenames("Child" + first);
			} else {
				registration.setForenames(firstName + first);
			}
		} else {
			registration.setForenames("Test" + first);
		}
		registration.setCountry_id_number(countryId);
		registration.setAge_at_first_attendence(age);
		if (childAgeStr != null) {
			if (age > childAge) {
				registration.setAge_category(3283);
			} else {
				registration.setAge_category(3284);
			}
		}
		//registration.setField19(addNum + " Park Place");
		registration.setBirth_date(java.sql.Date.valueOf(birthDate));
		registration.setSex(Integer.valueOf(1));
		registration.setAddress_1(age + " Maple street");
		// create the zeprsId
		String districtId = "1000";

		Site site = (Site) DynaSiteObjects.getClinicMap().get(siteId);
		String zepSiteId = site.getSiteAlphaId();
		String zePatientId = PatientId.setPatientId(conn, districtId, zepSiteId + siteInstanceId);
		String zeprsId = PatientRecordUtils.createZeprsId(districtId, zepSiteId + siteInstanceId, zePatientId);
		registration.setPatient_id_number(zeprsId);
		registration.setDateVisit(DateUtils.getNow());
		//registration.setField13("5040");
		//registration.setField1511(site.getSiteAlphaId().substring(0, 3));

		Map regMap = new HashMap();

		try {
			regMap = BeanUtils.describe(registration);
			//BeanUtils.copyProperties(regMap, registration);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}

		Map formData = new HashMap();

		Form form = (Form) DynaSiteObjects.getForms().get(new Long("1"));
		Set<PageItem> pageItems = form.getPageItems();
		for (PageItem pageItem : pageItems) {
			if (pageItem.getForm_field().isEnabled()) {
				String key = pageItem.getForm_field().getIdentifier();
				formData.put(key, regMap.get(key));
			}
		}
		formData.put("date_visit", DateUtils.getNow());

		/*Set dynaSet = dynaForm.getMap().entrySet();
		for (Iterator iterator = dynaSet.iterator(); iterator.hasNext();) {
			Map.Entry entry = (Map.Entry) iterator.next();
			String key = (String) entry.getKey();
			dynaForm.set(key, regMap.get(key));
		}

		dynaForm.set("date_visit", DateUtils.getNow().toString());*/
		return formData;
	}

	/**
	 * populates map with random data.
	 */
	public static Map fillFormData(Long formId) {
	    Form form = (Form) DynaSiteObjects.getForms().get(formId);
	    Map dynaForm = TestPatientUtils.fillData(form);
	    return dynaForm;
	}

	public static DynaActionForm createProblem(ModuleConfig modCfg) {
	    Long formId = new Long("65");
	    DynaActionForm dynaForm = null;
	    String now = DateUtils.getNow().toString();
	    dynaForm = TestPatientUtils.createDynaForm(modCfg, formId.toString());
	    // phase
	    dynaForm.set("field1487", "2755");
	    // temperature_266
	    dynaForm.set("field1250", "1");
	    // contractions_1250
	    dynaForm.set("field1251", now);
	    // cervix_dilatation325
	    dynaForm.set("field325", "4");
	    // true_labor
	    dynaForm.set("field325", "1");
	    // disposition_labor
	    dynaForm.set("field1266", "2697");
	    // type_of_labour
	    dynaForm.set("field1755", "2837");
	    return dynaForm;
	}

	/**
	 * Used for testing the app - creating test patients.
	 * Takes either the id field of the form or the form's classname.
	 * @param modCfg
	 * @param formId
	 * @return
	 */
	public static DynaActionForm createDynaForm(ModuleConfig modCfg, String formId) {
		String formName = null;
		try {
			Long formIdLong = Long.valueOf(formId);
	        formName = DynaSiteObjects.getFormIdClassNameMap().get(formIdLong);
		} catch (NumberFormatException e1) {
	        formName = DynaSiteObjects.getFormIdClassNameMap().get(formId);
		}
	    //FormBeanConfig formCfg = modCfg.findFormBeanConfig("form" + formId);
	    FormBeanConfig formCfg = modCfg.findFormBeanConfig(formName);
	    DynaActionFormClass dynaClass = DynaActionFormClass.createDynaActionFormClass(formCfg);
	    DynaActionForm dynaForm = null;
	    try {
	        dynaForm = (DynaActionForm) dynaClass.newInstance();
	    } catch (IllegalAccessException e) {
	        e.printStackTrace();
	    } catch (InstantiationException e) {
	        e.printStackTrace();
	    }
	    dynaForm.set("date_visit", DateUtils.getNow().toString());
	    return dynaForm;
	}

	public static Map fillData(Form form) {
	    /*String formName = DynaSiteObjects.getFormIdClassNameMap().get(formId);
	    //FormBeanConfig formCfg = modCfg.findFormBeanConfig("form" + formId.intValue());
	    FormBeanConfig formCfg = modCfg.findFormBeanConfig(formName);
	    DynaActionFormClass dynaClass = DynaActionFormClass.createDynaActionFormClass(formCfg);
	    DynaActionForm dynaForm = null;
	    try {
	        dynaForm = (DynaActionForm) dynaClass.newInstance();
	    } catch (IllegalAccessException e) {
	        e.printStackTrace();
	    } catch (InstantiationException e) {
	        e.printStackTrace();
	    }*/

		Map dynaForm = new HashMap();
	    Set pageItems = form.getPageItems();
	    String value = null;
	    for (Iterator iterator = pageItems.iterator(); iterator.hasNext();) {
	        // create random number
	        Random generator = new Random();
	        /*int first = generator.nextInt(100000);
	        int sur = generator.nextInt(10000);
	        int addNum = generator.nextInt(10000);
	        int age = generator.nextInt(60) + 13;*/
	        int six = generator.nextInt(6) + 1;
	        int floatRan = generator.nextInt(100);
	        int textRan = generator.nextInt(100000);
	        int yesno = generator.nextInt(2);

	        PageItem pageItem = (PageItem) iterator.next();
	        FormField formField = pageItem.getForm_field();
	        if (formField.isEnabled()) {
	            if (!formField.getType().equals("Display")) {
	                value = "";
	                int min = 0;
	                int max = 0;
	                if (formField.getMinValue() != null) {
	                    if (formField.getMinValue().intValue() > 0) {
	                        min = formField.getMinValue().intValue();
	                    }
	                }
	                if (formField.getMaxValue() != null) {
	                    if (formField.getMaxValue().intValue() > 0) {
	                        max = formField.getMaxValue().intValue();
	                    }
	                }
	                if (formField.getType().equals("Boolean")) {
	                    value = "0";
	                } else if (formField.getType().equals("Long")) {
	                    if (pageItem.getInputType().equals("prevPregnanciesLink")) {
	                        // skip
	                    } else {
	                        value = String.valueOf(six);
	                    }
	                } else if (formField.getType().equals("enum")) {
	                    Set fieldEnums = formField.getEnumerations();
	                    int size = fieldEnums.size();
	                    int intVal = generator.nextInt(size);
	                    Object[] enumArray = fieldEnums.toArray();
	                    FieldEnumeration fieldEnum = (FieldEnumeration) enumArray[intVal];
	                    value = fieldEnum.getId().toString();
	                } else if (formField.getType().equals("Enum")) {
	                    Set fieldEnums = formField.getEnumerations();
	                    if (fieldEnums.size() > 0) {
	                    	int size = fieldEnums.size();
	                        int intVal = generator.nextInt(size);
	                        Object[] enumArray = fieldEnums.toArray();
	                        FieldEnumeration fieldEnum = null;
	                        if (!pageItem.getInputType().equals("checkbox_dwr")) {
	                            fieldEnum = (FieldEnumeration) enumArray[intVal];
	                            value = fieldEnum.getId().toString();
	                        } else {
	                        	int intVal2 = generator.nextInt(2);
	                        	if (intVal2 == 0) {
	                    			value = null;
	                    		} else {
	                        		value = String.valueOf(intVal2);
	                    		}
	                        }
	                    } else {
	                        if (pageItem.getInputType().equals("checkbox_dwr")) {
	                        	int intVal3 = generator.nextInt(2);
	                        	if (intVal3 == 0) {
	                    			value = null;
	                    		} else {
	                        		value = String.valueOf(intVal3);
	                    		}
	                        }
	                    }
	                } else if (formField.getType().equals("Float")) {
	                    if (formField.getMinValue() != null) {
	                        if (min > 0) {
	                            int intVal = generator.nextInt(max - min) + min;
	                            value = String.valueOf(intVal);
	                        } else if (max > 0) {
	                            int intVal = generator.nextInt(max - min) + min;
	                            value = String.valueOf(intVal);
	                        } else {
	                            value = String.valueOf(floatRan);
	                        }
	                    } else {
	                        value = String.valueOf(floatRan);
	                    }
	                } else if (formField.getType().equals("Date")) {
	                    value = DateUtils.getNow().toString();
	                } else if (formField.getType().equals("Text")) {
	                	if (pageItem.getInputType().equals("dropdown")) {
	                		value = null;
	                	} else if (pageItem.getInputType().equals("dropdown-add-one")) {
	                		value = null;
	                	} else {
	                        value = "test value" + textRan;
	                	}
	                } else if (formField.getType().equals("Time")) {
	                    value = DateUtils.getTime();
	                } else if (formField.getType().equals("sex")) {
	                    value = "1";
	                } else if (formField.getType().equals("Yes/No")) {
	                    value = String.valueOf(yesno);
	                } else if (formField.getType().equals("Year")) {
	                    if (formField.getMinValue() != null) {
	                        if (min > 0) {
	                            max = new Integer(DateUtils.getYear()).intValue();
	                            int intVal = generator.nextInt(max - min) + min;
	                            value = String.valueOf(intVal);
	                        } else {
	                            value = String.valueOf(floatRan);
	                        }
	                    }
	                } else if (formField.getType().startsWith("Integer")) {
	                	if (pageItem.getInputType().equals("checkbox")) {
	                		int intVal = generator.nextInt(2);
	                		if (intVal == 0) {
	                			value = null;
	                		} else {
	                    		value = String.valueOf(intVal);
	                		}
	                	} else if (pageItem.getInputType().equals("dropdown")) {
	                		value = null;
	                	} else if (pageItem.getInputType().equals("dropdown-add-one")) {
	                		value = null;
	                	} else {
	                		if (formField.getMinValue() != null) {
	                			if (min > 0) {
	                				int intVal = generator.nextInt(max - min) + min;
	                				value = String.valueOf(intVal);
	                			} else if (max > 0) {
	                				int intVal = generator.nextInt(max - min) + min;
	                				value = String.valueOf(intVal);
	                			} else {
	                				value = String.valueOf(floatRan);
	                			}
	                		} else {
	                			value = String.valueOf(floatRan);
	                		}
	                	}
	                } else {
	                	if (pageItem.getInputType().equals("dropdown")) {
	                		value = null;
	                	} else if (pageItem.getInputType().equals("dropdown-add-one")) {
	                		value = null;
	                	} else {
	                        value = "test value" + textRan;
	                	}
	                }
	                //dynaForm.set(formField.getIdentifier(), value);
	                dynaForm.put(formField.getIdentifier(), value);
	            }
	        }
	    }

	    dynaForm.put("date_visit", DateUtils.getNow().toString());
	    return dynaForm;
	}

	/**
	 * Used when testing export of patient records to xml
	 * Usage: String zeprsId = PopulatePatientRecord.createTestPatientId(zepSiteId, registration);
	 * @param zepSiteId
	 * @param registration
	 * @return String zeprs id
	 */
	public static String createTestPatientId(Connection conn, String zepSiteId, PatientRegistration registration) {
	    // create a new patient id - this is for testing only
	    String zePatientId = PatientId.setPatientId(conn, "5040", zepSiteId);
	    String zepDistrictId = "5040";
	    String zeprsId = PatientRecordUtils.createZeprsId(zepDistrictId, zepSiteId, zePatientId);
	    registration.setPatient_id_number(zeprsId);
	    registration.setSurname(registration.getSurname() + "Test");
	    return zeprsId;
	}

	/**
	 * Create a new country id - this is for testing only
	 * @param age
	 * @return
	 */
	public static String createTestCountryId(String birthDate) {
	    String countryIdDate = birthDate.replace("-", "").substring(2);
	    String countryId = countryIdDate + "-" + "1" + "111" + "-"  + "0" + "8" + "0";
		return countryId;
	}

	/**
	* Generates a random number that can be used for an age.
	* @return
	*/
	public static int createTestAge() {
		Random generator = new Random();
		int age = generator.nextInt(40) + 13;
		return age;
	}

}

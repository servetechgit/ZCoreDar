/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.remote;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.ClientSettings;
import org.rti.zcore.Constants;
import org.rti.zcore.DropdownItem;
import org.rti.zcore.Drugs;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.FieldEnumeration;
import org.rti.zcore.Form;
import org.rti.zcore.FormField;
import org.rti.zcore.PageItem;
import org.rti.zcore.Site;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.exception.PersistenceException;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.WidgetUtils;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

public class StockEncounter {


	   /**
     * Commons Logging instance.
     */
    public static Log log = LogFactory.getFactory().getInstance(StockEncounter.class);

    /**
     * This is only for editing patient dispensary items
     * @param inputType
     * @param value
     * @param pageItemId
     * @param formId
     * @param encounterId
     * @param widgetType  - "Form" or "Chart"
     * @param bridgeId - if the record is a patient bridge table
     * @return updated value
     */
    public static String update(String inputType, String value, Long pageItemId, Long formId, Long encounterId, String widgetType, Long displayField, Long bridgeId, String currentFieldNameIdentifier) {
        String result = "";
        WebContext exec = WebContextFactory.get();
        String username = null;
        try {
            username = exec.getHttpServletRequest().getUserPrincipal().getName();
        } catch (NullPointerException e) {
            // unit testing - it's ok...
            username = "demo";
        }
        Connection conn = null;
        HttpSession session = null;
        try {
            conn = DatabaseUtils.getZEPRSConnection(username);
            SessionUtil zeprsSession = null;
            try {
                session = exec.getSession();
                zeprsSession = (SessionUtil) session.getAttribute("zeprs_session");
            } catch (Exception e) {
                // unit testing - it's ok...
            }
            Long patientId = null;
            Long eventId = null;
            Long siteId = null;
            String documentId = null;

            if (displayField == null) {
                displayField = encounterId;
            }

            PageItem pageItem = (PageItem) DynaSiteObjects.getPageItems().get(pageItemId);
            FormField formField = pageItem.getForm_field();
            Long formFieldId = formField.getId();

            if (widgetType.equals("Form")) {
                documentId = String.valueOf(formFieldId);
            } else if (widgetType.equals("Chart")) {
                documentId = String.valueOf(encounterId) + "." + String.valueOf(formFieldId);
            }
            if (pageItemId == 3861) {
                documentId = String.valueOf(encounterId) + "." + String.valueOf(displayField);
            }

            Form encounterForm = (Form) DynaSiteObjects.getForms().get(formId);
            if (encounterForm.getFormTypeId() == 6) {	// patient bridge table form
            	documentId = currentFieldNameIdentifier + String.valueOf(formFieldId);
            }

            SessionSubject sessionPatient = null;  // sessionPatient used for rule processing in EncountersDAO.update
            if (zeprsSession != null) {
            	try {
                    sessionPatient = (SessionSubject) zeprsSession.getSessionPatient();
                    patientId = zeprsSession.getSessionPatient().getId();
                    eventId = zeprsSession.getSessionPatient().getCurrentEventId();
                    ClientSettings clientSettings = zeprsSession.getClientSettings();
                    siteId = clientSettings.getSiteId();
                } catch (SessionUtil.AttributeNotFoundException e) {
                	log.error("inputType: " + inputType + " value: " + value + " pageItemId: " + pageItemId + " formId: " + formId + " encounterId: " + encounterId);
                    return documentId + "=" + "Error: your session may have expired. Please refresh this page or login again.";
                } catch (NullPointerException e) {
                    // it's ok - testing
                    patientId = new Long("44");
                    eventId = new Long("38");
                    siteId = new Long("1");
                }
            } else {
            	log.error("inputType: " + inputType + " value: " + value + " pageItemId: " + pageItemId + " formId: " + formId + " encounterId: " + encounterId);
                return documentId + "=" + "Error: your session may have expired. Please refresh this page or login again.";
            }

            Form form = (Form) DynaSiteObjects.getForms().get(formId);

            EncounterData encounter = null;
            String className = Constants.getDynasiteFormsPackage() + "." + StringManipulation.fixClassname(form.getName());
        	Class clazz = null;
        	try {
        		clazz = Class.forName(className);
        	} catch (ClassNotFoundException e) {
        		log.error(e);
        	}
        	try {
        		encounter = (EncounterData) clazz.newInstance();
        	} catch (InstantiationException e) {
        		log.error(e);
        	} catch (IllegalAccessException e) {
        		log.error(e);
        	}

        	try {
            	encounter = (EncounterData) EncountersDAO.getOne(conn, encounterId, "SQL_RETRIEVEID" + formId, clazz);
        	} catch (IOException e) {
        		log.error(e);
        	} catch (ServletException e) {
        		log.error(e);
        	} catch (SQLException e) {
        		log.error(e);
        	} catch (ObjectNotFoundException e) {
        		log.error(e);
        	}

        	// extra validation for stock.

        	Long itemId = null;
        	String dataType = formField.getType();
        	Integer intValue = null;
        	if (dataType.equals("Integer")) {
        		try {
        			intValue = Integer.valueOf(value);
        		} catch (NumberFormatException e) {
        			try {
						throw new PersistenceException("This input field requires an integer value (e.g.: 55). You entered : " + value, e, false);
					} catch (PersistenceException e1) {
						result = documentId + "=" + "Error:" + e.getMessage();
					}
        		}
        	}

        	if (formField.getIdentifier().equals("dispensed")) {
        		String itemIdStr = null;
        		String dispensedStr = null;
        		Long originallyDispensed = null;
    			try {
    				itemIdStr = BeanUtils.getProperty(encounter, "item_id");
    				dispensedStr = BeanUtils.getProperty(encounter, "dispensed");
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
            	if (itemIdStr != null) {
            		itemId = Long.valueOf(itemIdStr);
    				originallyDispensed = Long.valueOf(dispensedStr);
            		if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
            			HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
            			StockReport stockReport = balanceMap.get(itemId);
            			if (stockReport != null) {
            				Integer balance = stockReport.getBalanceBF();
            				if (balance <= 0) {
                                result = documentId + "=Error: This item is out of stock. Cannot proceed with this update. Current balance: " + balance;
            					return result;
            				} else if ((balance + originallyDispensed) - intValue < 0) {	// add the originallyDispensed value back to the balanace, and then subtract the new dispensed value.
            					result = documentId + "=Error: This update would create a negative stock balanace Please reduce the amount dispensed. Current balance: " + balance;
            					return result;
            				}
            			}
            		}
            	}
        	} else if (formField.getIdentifier().equals("item_id")) {
                result = documentId + "=Error: You may not change the stock item. Either delete this record or set the Quantity dispensed for this item to zero (0) and create a new record (Dispensing link -> \"Create New Dispensing record\" link)." ;
                return result;
        	}

            Timestamp lastModified = null;
            if (value != null) {
            		try {
            			EncountersDAO.update(conn, value, pageItemId, formId, encounterId, siteId, username, patientId, eventId, sessionPatient, lastModified, bridgeId, currentFieldNameIdentifier, null, session);
            			if (formField.getIdentifier().equals("dispensed")) {
            				if ((itemId != null) && (DynaSiteObjects.getStatusMap().get("balanceMap") != null)) {
            					HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
            					StockReport stockReport = balanceMap.get(itemId);
            					if (stockReport != null) {
            						if (intValue != null) {
            		    	    		StockControl tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId, null);
            	    	    			Integer currentBalance = tempStockControl.getBalance();
            							//Integer currentBalance = balanceBF - intValue;
            							stockReport.setBalanceBF(currentBalance);
            							stockReport.setOnHand(currentBalance);
            							balanceMap.put(itemId, stockReport);
            						}
            					}
            				}
            			}
            		} catch (SQLException e) {
            			log.error(e);
            		} catch (ServletException e) {
            			log.error(e);
            		} catch (PersistenceException e) {
            			result = documentId + "=" + "Error:" + e.getMessage();
            		} catch (ObjectNotFoundException e) {
            			log.error(e);
					} catch (ClassNotFoundException e) {
						log.error(e);
					} catch (IOException e) {
						result = documentId + "=" + "Error:" + e.getMessage();
						log.error(e);
					}

                if (result.equals("")) {
                	if (value.equals("")) {
                		result = documentId + "=" + value;
                	} else {
                		if (inputType.equals("select") || inputType.equals("select-dwr") || inputType.equals("multiselect_item"))
                        {
                            FieldEnumeration fieldEnum = (FieldEnumeration) DynaSiteObjects.getFieldEnumerations().get(Long.valueOf(value));
                            switch (formFieldId.intValue()) {
                                default:
                                    result = documentId + "=" + fieldEnum.getEnumeration();
                                    break;
                            }
                        } else if (inputType.equals("lab_results")) {
                            FieldEnumeration fieldEnum = (FieldEnumeration) DynaSiteObjects.getFieldEnumerations().get(Long.valueOf(value));
                            result = documentId + "=" + fieldEnum.getEnumeration();
                        } else if (inputType.equals("currentMedicine")) {
                            // Drugs drug = DrugsDAO.getOne(Long.valueOf(value));
                            Drugs drug = null;
                            try {
                                drug = (Drugs) DynaSiteObjects.getDrugMap().get(Long.valueOf(value));
                                result = documentId + "=" + drug.getName();
                            } catch (NumberFormatException e) {
                                e.printStackTrace();
                            }
                            if (drug == null) {
                                result = documentId + "=" + value;
                            }
                        } else if (inputType.equals("Yes/No")) {
                            if (value.equals("1")) {
                                value = "Yes";
                            } else if (value.equals("0")) {
                                value = "No";
                            }
                            result = documentId + "=" + value;
                        } else if (inputType.equals("checkbox")) {
                            if (value.equals("true")) {
                                value = "Yes";
                            } else if (value.equals("1")) {
                                value = "Yes";
                            } else if (value.equals("on")) {
                                value = "Yes";
                            } else if (value.equals("false")) {
                                value = "";
                            } else if (value.equals("0")) {
                                value = "";
                            } else if (value.equals("off")) {
                                value = "";
                            }
                            result = documentId + "=" + value;
                        } else if (inputType.equals("checkbox_dwr")) {
                            if (value.equals("true")) {
                                value = "Yes";
                            } else if (value.equals("on")) {
                                value = "Yes";
                            } else if (value.equals("false")) {
                                value = "";
                            } else if (value.equals("off")) {
                                value = "";
                            }
                            result = documentId + "=" + value;
                        } else if (inputType.equals("sex")) {
                            if (value.equals("1")) {
                                value = "Female";
                            } else if (value.equals("2")) {
                                value = "Male";
                            }
                            result = documentId + "=" + value;
                        } else if (inputType.equals("ega")) {
                            int valueInt = new Integer(value);
                            int days = valueInt % 7;
                            int weeks = valueInt / 7;
                            value = weeks + ", " + days + "/7";
                            result = documentId + "=" + value;
                        } else if (pageItem.getInputType().equals("sites") || pageItem.getInputType().equals("sites_not_selected")) {
                            Long thisSite = new Long(value);
                            Site site = (Site) DynaSiteObjects.getClinicMap().get(thisSite);
                            value = site.getName();
                            result = documentId + "=" + value;
                        } else if (inputType.equals("text") & displayField.intValue() != formFieldId.intValue()) {
                            // used in Lab form chart to share two fields in one cell.
                            /*if (displayField != 0) {
                                documentId = String.valueOf(encounterId) + "." + String.valueOf(displayField);
                            }*/
                            result = documentId + "=" + value;
                        //} else if (inputType.equals("dropdown") & currentFieldNameIdentifier != null) {
                        } else if (inputType.equals("dropdown") || inputType.equals("dropdown-add-one") || inputType.equals("dropdown_site")) {
                        	//Integer id = Integer.valueOf(value);
                        	String uuidValue = null;
            	            Integer id = null;
            	            if (pageItem.getFkIdentifier() != null && pageItem.getFkIdentifier().equals("uuid")) {
            	            	uuidValue = value;
            	            } else {
            		            id = Integer.valueOf(value);
            	            }
            	            DropdownItem item = null;
    						try {
    							item = WidgetUtils.getDropdownItem(conn, pageItem.getDropdownTable(), pageItem.getDropdownColumn(), id, null, pageItem.getFkIdentifier(), uuidValue);
    						} catch (ObjectNotFoundException e) {
    							log.debug("value for Dropdown item not found:" + e);
    						} catch (SQLException e) {
    							log.debug("value for Dropdown item not found:" + e);
    						}
            	            if (item != null) {
            	            	value = item.getDropdownValue();
                                result = documentId + "=" + value;
            	            } else {
            	            	value = "Unable to fetch updated value.";
                                result = documentId + "=" + value;
            	            }
                        } else {
                        	result = documentId + "=" + value;
                        }
                	}
                }
            } else {
                result = documentId + "=" + "Error: No value entered.";
            }
        } catch (ServletException e) {
            log.error(e);
        } catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                    conn = null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

}

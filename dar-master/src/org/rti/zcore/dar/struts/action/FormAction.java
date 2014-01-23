/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action;

import java.io.IOException;
import java.security.Principal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.validator.DynaValidatorForm;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.EncounterData;
import org.rti.zcore.Form;
import org.rti.zcore.Site;
import org.rti.zcore.Task;
import org.rti.zcore.dao.EncountersDAO;
import org.rti.zcore.dao.PatientDAO;
import org.rti.zcore.dao.SessionPatientDAO;
import org.rti.zcore.dar.dao.DarFormDAO;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.dao.StockControlDAO;
import org.rti.zcore.dar.gen.Appointment;
import org.rti.zcore.dar.gen.Item;
import org.rti.zcore.dar.gen.StockControl;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.dynasite.dao.UserDAO;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.impl.BaseSessionSubject;
import org.rti.zcore.impl.SessionSubject;
import org.rti.zcore.struts.action.generic.BasePatientAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.PopulatePatientRecord;
import org.rti.zcore.utils.SessionUtil;
import org.rti.zcore.utils.StringManipulation;
import org.rti.zcore.utils.security.AuthManager;
import org.rti.zcore.utils.security.UserUnauthorizedException;
import org.rti.zcore.utils.struts.StrutsUtils;

public class FormAction extends BasePatientAction {
	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(FormAction.class);

	/**
	 * Create record from form.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 * @throws Exception
	 */
	public ActionForward doExecute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		// Extract attributes we will need
		HttpSession session = request.getSession();
		Principal user = request.getUserPrincipal();
		String username = user.getName();
		DynaValidatorForm dynaForm = null;
		int formId = 0;
		String formName = mapping.getParameter().trim();
		Long formIdL = (Long) DynaSiteObjects.getFormNameMap().get(formName);
		formId = formIdL.intValue();
		ActionMessages errors = new ActionMessages();

		SessionSubject sessionPatient = null;
		Long patientId = null;
		String eventUuid = null;

		dynaForm = (DynaValidatorForm) form;
		Site site = SessionUtil.getInstance(session).getClientSettings().getSite();
		Long siteId = site.getId();

		// Get a form and flow from the formDef; add them to the encounter
		Form formDef = (Form) DynaSiteObjects.getForms().get(new Long(formId));
		Long formTypeId = formDef.getFormTypeId();
		//FormType formType = formDef.getFormType();
		EncounterData vo = null;
		Connection conn = null;
		try {
			conn = DatabaseUtils.getZEPRSConnection(username);
			if (formDef.isRequireReauth()) {
				try {
					AuthManager.confirmIdentity(conn, request, user.getName(), request.getParameter("password"));
				} catch (UserUnauthorizedException e) {
					errors.add("errors", new ActionMessage("errors.userunauthorized"));
					saveErrors(request, errors);
					try {
						String forwardName = (String) DynaSiteObjects.getFormNames().get(formName);
						if (forwardName == null) {
							return mapping.getInputForward();
						} else {
							if (forwardName.equals("demographics")) {
								return mapping.getInputForward();
							} else {
								return mapping.findForward(forwardName + "Error");
							}
						}
					} catch (Exception e1) {
						return mapping.getInputForward();
					}
				}
			}

			if (formName.equals("PatientRegistration")) {
				//ActionMessages errors = new ActionMessages();
				// check if there is a duplicate id
	        	Object item = dynaForm.get("patient_id_number");
	        	if (item != null) {
	        		String zeprsId = (String) item;
	        		Boolean status = PatientDAO.checkPatientId(conn, zeprsId);
	        		if (status == Boolean.FALSE) {
	                    errors.add("errors", new ActionMessage("errors.duplicateId", zeprsId));
	        		}
	        	}
			}

			if (formName.equals("UserInfo")) {
				//ActionMessages errors = new ActionMessages();
				// check if password at least 8 chars
	        	Object item = dynaForm.get("password");
	        	if (item != null) {
	        		String password = (String) item;
	        		if (password.length() < 8) {
                        errors.add("errors", new ActionMessage("errors.password"));
	        		}
	        	}

	        	// Check for duplicate username
	        	if ( dynaForm.get("username") != null) {
	        		String searchUsername = (String) dynaForm.get("username");
	        		Object userObject;
					try {
						userObject = UserDAO.getUser(conn, searchUsername);
						errors.add("errors", new ActionMessage("errors.duplicate.username", searchUsername));
					} catch (ObjectNotFoundException e) {
						// It's ok - there should not be a user.
					}
	        	}
			}

			//resolve the patientId - it has been either pushed via the request or gathered from the sessionPatient
			if (! formName.equals("PatientRegistration") && formTypeId != 5  && formTypeId != 9) {
				sessionPatient = (SessionSubject) SessionUtil.getInstance(session).getSessionPatient();
				patientId = sessionPatient.getId();
			}

			Long encounterId = null;
			try {
				encounterId = (Long) dynaForm.get("id");
			} catch (IllegalArgumentException e) {
				if (request.getParameter("id") != null) {
					if (!request.getParameter("id").equals("")) {
						encounterId = Long.valueOf(request.getParameter("id"));
					}
				}
			}

			Map dynaMap = dynaForm.getMap();
			Set encSet = dynaMap.entrySet();
			boolean emptyForm = true;
			//boolean futureDateVisit = false;
			for (Iterator iterator = encSet.iterator(); iterator.hasNext();) {
				Map.Entry entry = (Map.Entry) iterator.next();
				String key = (String) entry.getKey();
				String value = null;
				try {
					value = (String) entry.getValue();
				} catch (ClassCastException e) {
					if (entry.getValue().getClass().equals("Integer.class")) {
						Integer valueInt = (Integer) entry.getValue();
						value = valueInt.toString();
					}
				}

				if ((key.equals("date_visit")) || (key.equals("date_of_record"))) {
					Date dateVisit = Date.valueOf(value);
					Date now = DateUtils.getNow();
					if (dateVisit.getTime() > now.getTime()) {
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(Constants.DATE_FORMAT_EXCEL_SHORT);
                        sdf.setTimeZone(TimeZone.getDefault());
                        Date valueDate = Date.valueOf(value);
                        String formattedDate = sdf.format(valueDate.getTime());
						errors.add("errors", new ActionMessage("errors.invalid.dateVisit.future", formattedDate));
						saveErrors(request, errors);
					}
				} else {
					if (!value.equals("")) {
						emptyForm = false;
					}
				}
			}

			if (emptyForm) {
				if (formId == 132) {
					errors.add("errors", new ActionMessage("errors.dispensing.emptyForm"));
				} else {
					errors.add("errors", new ActionMessage("errors.emptyForm"));
				}
				saveErrors(request, errors);
			}

    		if (errors.size() > 0) {
    			saveErrors(request, errors);
                try {
                    String specialFormName = (String) DynaSiteObjects.getFormNames().get("form" + formId);
                    if (specialFormName == null) {
                        return mapping.getInputForward();
                    } else {
                        if (specialFormName.equals("demographics")) {
                            return mapping.getInputForward();
                        } else {
                            return mapping.findForward(formName + "Error");
                        }
                    }
                } catch (Exception e1) {
                    return mapping.getInputForward();
                }
    		}

			if (formId == 132) {	// Patient Dispensary
        		//ActionMessages errors = new ActionMessages();
        		// loop through the bridge table records
        		int recordsPerEncounter = formDef.getRecordsPerEncounter();
        		for (int j = 1; j < recordsPerEncounter; j++) {
            		String itemIdFieldName = "PBF" + j + "_item_id";
            		String quantityDispensedFieldName = "PBF" + j + "_dispensed";
            		// get the item_id
            		Long itemId = null;
            		Integer quantityDispensed = 0;
    				if (!dynaForm.getMap().get(itemIdFieldName).equals("")) {
    	        		itemId = Long.valueOf((String)dynaForm.getMap().get(itemIdFieldName));
    				}
    				if (!dynaForm.getMap().get(quantityDispensedFieldName).equals("")) {
    					quantityDispensed = Integer.valueOf((String)dynaForm.getMap().get(quantityDispensedFieldName));
    				}
    				Integer currentBalance = 0;
    				Integer possiblebalance = 0;
    				if (itemId != null) {
    					if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
    						HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
    						StockReport stockReport = balanceMap.get(itemId);
    						//tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId, siteId.intValue());
            				if (stockReport != null) {
                				currentBalance = stockReport.getBalanceBF();
            				}
            				possiblebalance = currentBalance - quantityDispensed;
        	        		dynaForm.getMap().put("balance", possiblebalance);
    					}
        				processBalanceMessages(conn, errors, itemId, currentBalance, possiblebalance, true);
    				}
                }
        		if (errors.size() > 0) {
        			saveErrors(request, errors);
                    try {
                        String specialFormName = (String) DynaSiteObjects.getFormNames().get("form" + formId);
                        if (specialFormName == null) {
                            return mapping.getInputForward();
                        } else {
                            if (specialFormName.equals("demographics")) {
                                return mapping.getInputForward();
                            } else {
                                return mapping.findForward(formName + "Error");
                            }
                        }
                    } catch (Exception e1) {
                        return mapping.getInputForward();
                    }
        		}
        	}

			if (formId == 161) {  // stock_control
				Integer value = 0;
				Integer balance = 0;
				Integer tempStockControlBalance = 0;
				Long itemId = null;
				// get the item_id
				if (!dynaForm.getMap().get("item_id").equals("")) {
					itemId = Long.valueOf((String)dynaForm.getMap().get("item_id"));
				}

				if (DynaSiteObjects.getStatusMap().get("balanceMap") != null) {
					HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
					StockReport stockReport = balanceMap.get(itemId);
					//tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId, siteId.intValue());
					if (stockReport != null) {
						tempStockControlBalance = stockReport.getBalanceBF();
    				}
				}
				// set the last_patient_item_id hidden field
				//dynaForm.getMap().put("last_patient_item_id", tempStockControl.getLast_patient_item_id());
				// change the current stock balance based on the fields in this submission
				if (!dynaForm.getMap().get("type_of_change").equals("")) {
					Integer typeOfStock = Integer.valueOf((String)dynaForm.getMap().get("type_of_change"));
					if (!dynaForm.getMap().get("change_value").equals("")) {
						value = Integer.valueOf((String)dynaForm.getMap().get("change_value"));
					}
					switch (typeOfStock) {
					// Received
					case 3263:
						balance = tempStockControlBalance + value;
						break;
						// Issued
					case 3264:
						balance = tempStockControlBalance - value;
						break;
						// Losses
					case 3265:
						balance = tempStockControlBalance - value;
						break;
						// Pos. Adjust.
					case 3266:
						balance = tempStockControlBalance + value;
						break;
						// Neg. Adjust
					case 3267:
						balance = tempStockControlBalance - value;
						break;
					default:
						balance = value;
						break;
					}
				} else {
					balance = value;
				}

				processBalanceMessages(conn, errors, itemId, tempStockControlBalance, balance, false);

				if (errors.size() > 0) {
        			saveErrors(request, errors);
                    try {
                        String specialFormName = (String) DynaSiteObjects.getFormNames().get("form" + formId);
                        if (specialFormName == null) {
                            return mapping.getInputForward();
                        } else {
                            if (specialFormName.equals("demographics")) {
                                return mapping.getInputForward();
                            } else {
                                return mapping.findForward(formName + "Error");
                            }
                        }
                    } catch (Exception e1) {
                        return mapping.getInputForward();
                    }
        		}

				// set the balance hidden field
				dynaForm.getMap().put("balance", balance);

				// reset the lowStockItems
				/*if (Constants.LOW_STOCK_WARNING_QUANTITY != null) {
					List<Task> lowStockItems = null;
					if (DynaSiteObjects.getStatusMap().get("lowStockItems") != null) {
						lowStockItems = (List<Task>) DynaSiteObjects.getStatusMap().get("lowStockItems");
					}
					if (lowStockItems != null) {
						int i = 0;
						int itemToRemove = 0;
						for (Task lowStockTask : lowStockItems) {
							i++;
							Long lowStockItemId = lowStockTask.getId();
							if (itemId.intValue() == lowStockItemId.intValue()) {
								itemToRemove = i;
								break;
							}
						}
						if (itemToRemove > 0) {
							lowStockItems.remove(i-1);
						}
					}
				}*/
			}

			// We need to calculate tempStockControl's balance field a couple of times.
			StockControl tempStockControl = null;
			Map formData = dynaForm.getMap();
			try {
				if (formId == 128 || formId == 129 || formId == 130 || formId == 131 || formId == 181 ) {
					vo = DarFormDAO.saveForm(conn, formDef, String.valueOf(formId), patientId, formData, encounterId, siteId, username, sessionPatient);
				} else {
					vo = PopulatePatientRecord.saveForm(conn, formDef, String.valueOf(formId), patientId, formData, encounterId, siteId, username, sessionPatient);
				}
				if (formId == 161) {
					StockControl sc = (StockControl) vo;
					Long itemId = sc.getItem_id();
	    			StockControlDAO.prepareStockforAlertList(conn, sc, null, itemId);
				}
	            if (formId == 132) {	// Patient Dispensary
	    	    	// we're processing this item here because we don't really need to do it in EncounterProcessor,
	    	    	// but we do need the id of the recently-saved record.
	    	    	// loop through the bridge table records
	    	    	int recordsPerEncounter = formDef.getRecordsPerEncounter();
	    	    	for (int j = 1; j < recordsPerEncounter; j++) {
	    	    		String itemIdFieldName = "PBF" + j + "_item_id";
	    	    		String quantityDispensedFieldName = "PBF" + j + "_dispensed";
	    	    		// get the item_id
	    	    		Long itemId = null;
	    	    		Integer quantityDispensed = null;
	    	    		if (!formData.get(itemIdFieldName).equals("")) {
	    	    			itemId = Long.valueOf((String)formData.get(itemIdFieldName));
	    	    		}
	    	    		if (!formData.get(quantityDispensedFieldName).equals("")) {
	    	    			quantityDispensed = Integer.valueOf((String)formData.get(quantityDispensedFieldName));
	    	    		}
	    	    		if (itemId != null) {
	    	    			//if (tempStockControl == null) {
		    	    		tempStockControl = InventoryDAO.getCurrentStockBalance(conn, itemId, null);
	    	    			//}
	    	    			Integer currentBalance = tempStockControl.getBalance();

	    	    			HashMap<Long,StockReport> balanceMap = (HashMap<Long, StockReport>) DynaSiteObjects.getStatusMap().get("balanceMap");
	    	    			StockReport stockReport = balanceMap.get(itemId);
	    	    			if (stockReport != null) {
	    	    				stockReport.setBalanceBF(currentBalance);
	    	    				stockReport.setOnHand(currentBalance);
	    	    				balanceMap.put(itemId, stockReport);
	    	    			}
	    					Integer lowStockWarning = Integer.valueOf(Constants.LOW_STOCK_WARNING_QUANTITY);
	    	    			//Integer possiblebalance = currentBalance - quantityDispensed;
	    	    			if (currentBalance <=0) {
	    	    				// first check if the most recent record for this item is an out-of-stock warning = 3279
	    	    				try {
	    	    					StockControl outOfStock = InventoryDAO.getMostRecentOutOfStock(conn, itemId, null);
	    	    					// if record exists, we're ok
	    	    				} catch (ObjectNotFoundException e) {
	    	    					try {
	    	    						Date visitDateD = null;
	    	    						if (formData != null) {
	    	    							//String formName = StringManipulation.fixClassname(formDef.getName());
	    	    							visitDateD = DateUtils.getVisitDate(formData, formName);
	    	    						} else {
	    	    							visitDateD = DateUtils.getNow();
	    	    						}
	    	    						InventoryDAO.createOutOfStockRecord(conn, formDef, String.valueOf(formId), patientId, siteId, username, sessionPatient, vo, itemId, quantityDispensed, visitDateD);
	    	    					} catch (Exception e2) {
	    	    						log.error(e2);
	    	    					}
	    	    				}
	    	    			}
	    	    		}
	    	    	}
	    	    	// refreshes the StockAlertList.
	            	StockControlDAO.setStockAlertList(conn, null);
	    	    }
			} catch (Exception e) {
				log.debug("formData: " + formData);
				log.error("Error saving record - formId: " + formId + ", patientId: " + patientId + ", encounterId: "
						+ encounterId + ", siteId: " + siteId + ", username: " + username + " Error: " + e);
				if (sessionPatient == null) {
					log.error("Error saving record - null sessionPatient");
				}
				e.printStackTrace();
				if (!conn.isClosed()) {
					conn.close();
					conn = null;
				}
				request.setAttribute("exception", e);
				return mapping.findForward("error");
			}

			String menuItemText = null;
			if (formName.equals("MenuItem")) {
				menuItemText  = StringManipulation.escapeString(dynaForm.get("textLink").toString());
				menuItemText = StringManipulation.fixFirstDigit(menuItemText);
				dynaForm.set("templateKey", Constants.MENUITEM_PROPERTY_PREFIX + "." +  menuItemText);
			}

			//Forms that don't require patient(including admin forms) don't need the session refreshed since they aren't patient oriented
			// Submitting the PatientRegistration form does need the TimsSessionSubject initialised.
			if (formDef.isRequirePatient() == true || formName.equals("PatientRegistration") || formName.equals("PerpetratorDemographics")){
				try {
					SessionPatientDAO.updateSessionPatient(conn, vo.getPatientId(), vo.getEventUuid(), session);
					// re-initialize a few vars
					sessionPatient = (SessionSubject) SessionUtil.getInstance(session).getSessionPatient();
					eventUuid = sessionPatient.getCurrentEventUuid();
					patientId = sessionPatient.getId();
				} catch (ObjectNotFoundException e) {
					// clear out session patient - it's null
					SessionUtil.getInstance(session).setSessionPatient(null);
				}
			}
			// Reset form
			form.reset(mapping, request);
			StrutsUtils.removeFormBean(mapping, request);
		} catch (ServletException e) {
			log.error(e);
		} finally {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		}

		/**
		 * Forwards section - send user to the next form
		 */

		return createForward(request, mapping, patientId, eventUuid, dynaForm, session, formId, vo);
	}

	/**
	 * Adds error messages to ActionMessages for low/out of stock situations.
	 * @param conn
	 * @param errors
	 * @param itemId
	 * @param currentBalance
	 * @param possiblebalance
	 * @param dispensing -  If dispensing, system will test for outofstock and display a different outofstock message;
	 * otherwise, it's the stock control form.
	 * @throws ClassNotFoundException
	 * @throws IOException
	 * @throws ServletException
	 * @throws SQLException
	 * @throws ObjectNotFoundException
	 * @throws NumberFormatException
	 */
	private void processBalanceMessages(Connection conn, ActionMessages errors, Long itemId, Integer currentBalance,
			Integer possiblebalance, boolean dispensing) throws ClassNotFoundException, IOException, ServletException, SQLException,
			ObjectNotFoundException, NumberFormatException {
		if (dispensing == true && currentBalance <= 0) {
			// Issue the outOfStock error message.
			Class clazz = Class.forName("org.rti.zcore.dar.gen.Item");
			Item stockItem = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN131", clazz);
			String detailName = stockItem.getName();
			//request.setAttribute("exception", "Out of stock for " + detailName);
		    //return mapping.findForward("error");
		    errors.add("errors", new ActionMessage("errors.outOfStock",detailName));
		    // must allow currentBalance to be 0 for stock control.
		    // if currentBalance = 0 for dispensing, it would have been true for the previous condition and already thrown the error..
		} else if ((currentBalance >= 0) && (possiblebalance < 0)) {
			// if we're not out of stock already but committing this transaction uses more stock than we have, issue a warning.
			Class clazz = Class.forName("org.rti.zcore.dar.gen.Item");
			Item stockItem = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN131", clazz);
			String detailName = stockItem.getName();
			if (dispensing == true) {
			    errors.add("errors", new ActionMessage("errors.negativeStock.dispensing",detailName, currentBalance));
			} else {
				if (currentBalance == 0) {
				    errors.add("errors", new ActionMessage("errors.negativeStock.stockControl.zero",detailName, currentBalance));
				} else {
				    errors.add("errors", new ActionMessage("errors.negativeStock.stockControl",detailName, currentBalance));
				}
			}
		} else {
			if (Constants.LOW_STOCK_WARNING_QUANTITY != null) {
				// The stockCountThreshold is calculated from the most recent stock received record balance * (threshold/100).
				// It is not calculated from the currentBalance (current stock on-hand).
				Float threshold = Float.valueOf(Constants.LOW_STOCK_WARNING_QUANTITY);
				// find the most recent stock receipt for this item.
				String sql = "SELECT id, balance AS balance, last_patient_item_id as last_patient_item_id, expiry_date AS expiry_date FROM stock_control WHERE item_id = ? AND type_of_change = 3263 ORDER BY id DESC";
				ArrayList values = new ArrayList();
				values.add(itemId);
				List records = null;
				Class clazz = Class.forName("org.rti.zcore.dar.gen.StockControl");
				records = DatabaseUtils.getList(conn, clazz, sql, values, 1);
				StockControl record = null;
				if (records.size() > 0) {
					record = (StockControl) records.get(0);
					if (record.getBalance() != null) {
						Float stockCountThreshold = record.getBalance().floatValue() * (threshold/100);
						if (possiblebalance <= stockCountThreshold) {
							List<Task> lowStockItems = null;
				            if (DynaSiteObjects.getStatusMap().get("lowStockItems") != null) {
				            	lowStockItems = (List<Task>) DynaSiteObjects.getStatusMap().get("lowStockItems");
				            } else {
				            	lowStockItems = new ArrayList<Task>();
				            }
				            Class itemClazz = Class.forName("org.rti.zcore.dar.gen.Item");
				            Item stockItem = (Item) EncountersDAO.getOne(conn, itemId, "SQL_RETRIEVE_ONE_ADMIN131", itemClazz);
				            String detailName = stockItem.getName();
				            String taskName = null;
				            Task task = new Task(null,null, null, null, null, 1, "Task");
				            task.setActive(true);
				            task.setId(itemId);
				            if (possiblebalance == 0) {
				            	taskName = "<span class=\"error\">Out of Stock Warning</span> for " + detailName + ". On-hand: " + possiblebalance;
				            	task.setLabel(taskName);
					            task.setMessageType("outOfStock");
				            } else {
				            	taskName = "Low Stock Warning for " + detailName + ". On-hand: " + possiblebalance;
				            	task.setLabel(taskName);
					            task.setMessageType("lowStock");
				            }
				            int i = 0;
				            int itemToRemove = 0;
				            if (lowStockItems.size()>0) {
				            	for (Task lowStockTask : lowStockItems) {
					            	i++;
					            	Long lowStockItemId = lowStockTask.getId();
					            	if (itemId.intValue() == lowStockItemId.intValue()) {
					            		itemToRemove = i;
					            		break;
					            	}
					            }
					            if (itemToRemove > 0) {
					            	lowStockItems.remove(i-1);
					            }
				            }
				            lowStockItems.add(task);
				            DynaSiteObjects.getStatusMap().put("lowStockItems",lowStockItems);
						}
					}
				}
			}
		}
	}

	/**
	 * Check formId to see what is the next form to be served.
	 *
	 * @param request
	 * @param mapping
	 * @param patientId
	 * @param eventUuid
	 * @param dynaForm
	 * @param session
	 * @param formId
	 * @param vo Useful when you need to pass the encounterId in the url parameters
	 * @return the next page/form
	 */
	private ActionForward createForward(HttpServletRequest request, ActionMapping mapping, Long patientId, String eventUuid, DynaValidatorForm dynaForm, HttpSession session, int formId, EncounterData vo) {
		BaseSessionSubject sessionPatient = null;
		Principal user = request.getUserPrincipal();
		String username = user.getName();
		String formName = mapping.getParameter().trim();
		Connection conn = null;
		Form nextForm = new Form();
		
		Integer maxRows = 0;
		if (request.getParameter("maxRows") != null) {
			maxRows = Integer.decode(request.getParameter("maxRows"));
		} else if (request.getAttribute("maxRows") != null) {
			maxRows = Integer.decode(request.getAttribute("maxRows").toString());
		} else {
			switch (formId) {
			case 128:
				maxRows = 0;
				break;
			case 129:
				maxRows = 0;
				break;
			case 130:
				maxRows = 0;
				break;
			case 131:
				maxRows = 0;
				break;
			case 181:
				maxRows = 0;
				break;

			default:
				maxRows = 20;
				break;
			}
		}
		
		try {
			conn = DatabaseUtils.getZEPRSConnection(username);
			try {
				sessionPatient = SessionUtil.getInstance(session).getSessionPatient();
			} catch (SessionUtil.AttributeNotFoundException e) {
				//log.error("Unable to get TimsSessionSubject");
			}

			Form form = (Form) DynaSiteObjects.getForms().get(Long.valueOf(formId));
			Long formTypeId = form.getFormTypeId();

			// part of reload prevention scheme:
			resetToken(request);
			dynaForm.reset(mapping, request);
			StrutsUtils.removeFormBean(mapping, request);

			ActionForward forwardForm = null;
    		String forwardString = null;
			switch (formId) {
    		case 1: 	// Patient Registration
    			forwardString = "/ArtRegimen/new.do?patientId=" + patientId.toString();
    			break;
    		case 137: // ART Regimen
    			forwardString = "/PatientItem/new.do?patientId=" + patientId.toString();
    			break;
    		case 132: // Dispensary
	    		//forwardString = "/patientTask.do?flowId=" + flowId.toString();
    			forwardString = "/Appointment/new.do?patientId=" + patientId.toString();
				//forwardString = "/chart.do?patientId=" + patientId.toString() + "&formId=" + formId;
    			break;
    		/*case 136:
				forwardString = "/chart.do?patientId=" + patientId.toString() + "&formId=" + formId;
    			break;*/
    		case 136: // PatientCondition
    			forwardString = "/PatientCondition/new.do?patientId=" + patientId.toString();
    			break;
    		case 179: // Appt
    			if (Constants.APPOINTMENT_COUNT_THRESHOLD != null) {
    				Appointment appt = (Appointment) vo;
    				Date apptDate = appt.getAppointment_date();
    				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(org.rti.zcore.Constants.DATE_FORMAT_SHORT);
    		    	sdf.setTimeZone(TimeZone.getDefault());
    		    	String apptDateStr = sdf.format(appt.getAppointment_date().getTime());

    				ResultSet rs = null;
    				Integer countAppts = 0;
    				String warningMessage = "";
    				try {
    					String sql = "SELECT COUNT(encounter.id) AS countAppts " +
    					"FROM encounter, appointment " +
    					"WHERE appointment.id=encounter.id " +
    					"AND appointment_date = ? ";
    					PreparedStatement ps = conn.prepareStatement(sql);
    					ps.setDate(1, apptDate);
    					rs = ps.executeQuery();
    					while (rs.next()) {
    						countAppts = rs.getInt("countAppts");
    					}
    				} catch (Exception ex) {
    					log.error(ex);
    				}
    				Integer apptCountThreshold = Integer.valueOf(Constants.APPOINTMENT_COUNT_THRESHOLD);
    				if (countAppts != null && countAppts > 0) {
    					Integer warningThreshold = apptCountThreshold - 10;
    					if ((countAppts >= warningThreshold) && (countAppts < apptCountThreshold)) {
    						warningMessage = "Warning: Approaching Threshold of " + apptCountThreshold + " Appointments";
    					} else if (countAppts >= apptCountThreshold) {
    						warningMessage = "Warning: Passed Threshold of " + apptCountThreshold + " Appointments.";
    					}
        				forwardString = "/Appointment/new.do?patientId=" + patientId.toString() + "&warningMessage=" + warningMessage + "&countAppts=" + countAppts + "&apptDate=" + apptDateStr;
    				} else {
        				forwardString = "/Appointment/new.do?patientId=" + patientId.toString() + "&countAppts=" + countAppts + "&apptDate=" + apptDateStr;
    				}
    			} else {
    				forwardString = "/Appointment/new.do?patientId=" + patientId.toString();
    			}
    			break;
    		case 180: // Appt
    			forwardString = "/PatientStatus_changes/new.do?patientId=" + patientId.toString();
    			break;

    		default:
    			switch (formTypeId.intValue()) {
    			case 5: 	// admin
    				forwardString = "/admin/records/list.do?formId=" + formId + "&maxRows=" + maxRows;
    				break;
    			case 7: // charts
    				forwardString = "/chart.do?id=" + formId;
    				break;
    			case 8: // lists
        			forwardString = "/recordList.do?formId="+ formId +"&patientId=" + patientId.toString();
    				break;
    			default:
    				if (sessionPatient != null) {
    					Long flowId = sessionPatient.getCurrentFlowId();
        				forwardString = "/patientTask.do?flowId=" + flowId.toString();
    				} else {
        				forwardString = "/home.do";
    				}
    			break;
    			}
    		break;
    		}
    		forwardForm = new ActionForward(forwardString);
    		forwardForm.setRedirect(true);
    		return forwardForm;
		} catch (ServletException e) {
			log.error(e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.error(e);
			}
		}

		return (new ActionForward(mapping.getInput()));
	}

}

/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.servlet;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.UnavailableException;

import org.apache.commons.dbcp.SQLNestedException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.config.ModuleConfig;
import org.rti.zcore.Constants;
import org.rti.zcore.DynaSiteObjects;
import org.rti.zcore.Form;
import org.rti.zcore.dar.dao.InventoryDAO;
import org.rti.zcore.dar.dao.StockControlDAO;
import org.rti.zcore.dar.report.valueobject.StockReport;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.FormUtils;
import org.rti.zcore.utils.GenerateStrutsConfig;


/**
 * Extension of ActionServlet that places forms and other webapp objects into Application memory
 */
public class DynasiteConfigServlet extends ActionServlet {
    public static Log log = LogFactory.getFactory().getInstance(DynasiteConfigServlet.class);

/*    *//**
     * Custom init to modify the XML config files before normal processing by the
     * superclass.
     *
     * @throws ServletException


    /**
     * <p>Initialize this servlet.  Most of the processing has been factored into
     * support methods so that you can override particular functionality at a
     * fairly granular level.</p>
     *
     * @exception ServletException if we cannot configure ourselves correctly
     */
    public void init() throws ServletException {


        // Wraps the entire initialization in a try/catch to better handle
        // unexpected exceptions and errors to provide better feedback
        // to the developer
        try {
            initInternal();
            initOther();
            initServlet();
    		// Test that the server is up
    		Connection conn = null;
			try {
				conn = DatabaseUtils.getZEPRSCatchableConnection("zepadmin");
			} catch (SQLNestedException e) {
				log.debug("Sleeping");
    			Thread.sleep(5000);
				try {
					conn = DatabaseUtils.getZEPRSCatchableConnection("zepadmin");

				} catch (SQLNestedException e1) {
					log.debug("Sleeping");
	    			Thread.sleep(10000);
	    			if (conn == null) {
	        			// wait
	    				log.debug("Sleeping");
	        			Thread.sleep(5000);
	        		}
	        		// if it is still not ready, let's wait a tad longer
	        		if (conn == null) {
	        			// wait
	        			log.debug("It's taking a bit long to access the database.");
	        			Thread.sleep(5000);
	        		}
				}
			} finally {
				try {
					if (conn != null)
					conn.close();
				} catch (SQLException e3) {
					// TODO Auto-generated catch block
					e3.printStackTrace();
				}
			}


			/*if ((Constants.UPDATES_DYNASITE != null) && (Constants.UPDATES_DYNASITE.equals("true"))) {
				log.debug("Processing Database Updates");
				try {
					UpdateDatabase.execute();
				} catch (SQLException e) {
					log.error("ApplicationUpdate SQL error" + e);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
				log.debug("Finished processing Applicaton Updates");
			}*/

            // ZEPRS DynaSiteObjects
			log.debug("Processing DynaSiteObjects");
			DynasiteConfigServlet.loadDynaSiteObjects();
			Boolean dev = DynaSiteObjects.getDev();

            // uncomment to load Jmdns
            // loadJmdns();

            getServletContext().setAttribute(Globals.ACTION_SERVLET_KEY, this);
            initModuleConfigFactory();
            // Initialize modules as needed
            ModuleConfig moduleConfig = initModuleConfig("", config);
            initModuleMessageResources(moduleConfig);
            initModuleDataSources(moduleConfig);
            try {
				initModulePlugIns(moduleConfig);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				log.debug("Error loading struts config files. Re-generating config files.");
				new GenerateStrutsConfig().init(dev);
				e.printStackTrace();
			}
            moduleConfig.freeze();

            Enumeration names = getServletConfig().getInitParameterNames();
            while (names.hasMoreElements()) {
                String name = (String) names.nextElement();
                if (!name.startsWith("config/")) {
                    continue;
                }
                String prefix = name.substring(6);
                moduleConfig = initModuleConfig
                    (prefix, getServletConfig().getInitParameter(name));
                initModuleMessageResources(moduleConfig);
                initModuleDataSources(moduleConfig);
                initModulePlugIns(moduleConfig);
                moduleConfig.freeze();
            }

            this.initModulePrefixes(this.getServletContext());

            this.destroyConfigDigester();
        } catch (UnavailableException ex) {
            throw ex;
        } catch (Throwable t) {

            // The follow error message is not retrieved from internal message
            // resources as they may not have been able to have been
            // initialized
            log.error("Unable to initialize Struts ActionServlet due to an "
                + "unexpected exception or error thrown, so marking the "
                + "servlet as unavailable. Look at the stack trace...", t);
            t.printStackTrace();
            //throw new UnavailableException(t.getMessage());

        }
    }

/*

    *//**
     * Iterates through the forms from the database and makes mods to XML files.
     *//*
    private void loadMemory() throws ServletException {
        //log.debug("Loading objects in memory from DynasiteConfigServlet.");

        // field enums are used by getForms, so let's do it first.
        DynaSiteObjects.getFieldEnumerationsByField();
        //log.info("DynaSiteObjects.getFieldEnumerationsByField");
        // so are the rules
        DynaSiteObjects.getRules();
        //log.info("DynaSiteObjects.getRules");
        Boolean isDev = true;
        String localDevPath = Constants.getProperties("source",Constants.DEV_PROPERTIES);
        log.debug("Constants.pathToCatalinaHome: " + Constants.pathToCatalinaHome);
        String deployedPath = Constants.pathToCatalinaHome + "\\webapps\\" + Constants.APP_NAME + "\\WEB-INF\\";
        if (localDevPath.equals(deployedPath)) {
        	isDev = false;
        	log.debug(Constants.APP_TITLE + " installed in server config, not for source code dev - dev = false.");
        } else {
            log.debug(Constants.APP_TITLE + " installed in source code dev config - dev = true.");
        }
        DynaSiteObjects.setDev(isDev);
        log.debug("Begin processing Dynasite form changes");
        DynasiteChangesList.processFormChanges(isDev);
        //log.debug("Schema changes are currently disabled.");
        log.debug("End processing Dynasite form changes");
        // re-initialise the forms
        DynaSiteObjects.setForms(null);
        DynaSiteObjects.getForms();
        if (DynaSiteObjects.getForms().size() < 1) {
            log.fatal("Forms did not build.");
            throw new ServletException();
        }
        try {
            DynaSiteObjects.getDrugs();
            //log.info("DynaSiteObjects.getDrugs");
            DynaSiteObjects.getClinics();
            //log.info("DynaSiteObjects.getClinics");
            DynaSiteObjects.getClinicMap();
            DynaSiteObjects.getClinicKeyAlphaMap();
            //log.info("DynaSiteObjects.getClinicMap");
            DynaSiteObjects.getSiteList();
            //log.info("DynaSiteObjects.getSiteList");
            DynaSiteObjects.getDistricts();
            DynaSiteObjects.getDistrictsMap();
            DynaSiteObjects.getFlows();
            //log.info("DynaSiteObjects.getFlows");
            //DynaSiteObjects.getPartoFields();
            //log.info("DynaSiteObjects.getPartoFields");
            //DynaSiteObjects.getPartoTables();
            //log.info("DynaSiteObjects.getPartoTables");
            DynaSiteObjects.getPageItems();
            //log.info("DynaSiteObjects.getPageItems");
            DynaSiteObjects.getFormSections();
            //log.info("DynaSiteObjects.getFormSections");
            DynaSiteObjects.getCollapsingSections();
            //log.info("DynaSiteObjects.getCollapsingSections");
            DynaSiteObjects.getFormDependencies();
            //log.info("DynaSiteObjects.getFormDependencies");
            DynaSiteObjects.getCollapsingDependencies();
            //log.info("DynaSiteObjects.getCollapsingDependencies");
            DynaSiteObjects.getFieldToPageItem();
            // log.info("DynaSiteObjects.getFieldToPageItem");
            DynaSiteObjects.getActivefields();   // used for querybuilder
            DynaSiteObjects.getTasksForFlow();
            DynaSiteObjects.getRulesToForms();
            DynaSiteObjects.getRuleMap();
            DynaSiteObjects.getAllPregnanciesRules();
            DynaSiteObjects.getFormIdToClassNames();
            StockControlDAO.setExpiredStockItems();
        } catch (Exception e) {
            log.debug("Error loading DynaSiteObjects" + e);
            e.printStackTrace();
        }
    }*/

	/**
	 * Iterates through the forms from the database and makes mods to XML files.
	 * Once it is done, it loads these forms into DynaSiteObjects.
	 */
	public static void loadDynaSiteObjects() throws ServletException {
		org.rti.zcore.servlet.DynasiteConfigServlet.loadDynaSiteObjects();
		log.debug("Loading extras for DAR");
		Set formList = DynaSiteObjects.getForms().entrySet();
        for (Iterator iterator = formList.iterator(); iterator.hasNext();) {
            Map.Entry entry = (Map.Entry) iterator.next();
            Form form = (Form) entry.getValue();
            if (form.isEnabled() == true) {
        		if (form.getRecordsPerEncounter() != null && form.getRecordsPerEncounter() > 0) {
                	if (form.getResizedForPatientBridge()== null) {
                		try {
							FormUtils.createBridgeTablePageItems(form);
						} catch (IllegalAccessException e) {
							log.debug(e);
						} catch (InstantiationException e) {
							log.debug(e);
						} catch (InvocationTargetException e) {
							log.debug(e);
						} catch (NoSuchMethodException e) {
							log.debug(e);
						}
                	}
                }
            }
        }
		Connection conn = null;
    	try {
			conn = DatabaseUtils.getZEPRSConnection(Constants.DATABASE_ADMIN_USERNAME);
			try {
	            HashMap<Long,StockReport> balanceMap = InventoryDAO.getBalanceMap(conn, null, null,null);
	            DynaSiteObjects.getStatusMap().put("balanceMap", balanceMap);
	            StockControlDAO.setExpiredStockItems(conn);
	            StockControlDAO.setLowStockTasks(conn);
	            StockControlDAO.setStockAlertList(conn, null);
	        } catch (Exception e) {
	            log.debug("Error loading DynaSiteObjects: " + e);
	            e.printStackTrace();
	        }
		} catch (ServletException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}
}

/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.struts.action;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.security.Principal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.StringTokenizer;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.tools.ant.Project;
import org.rti.zcore.Constants;
import org.rti.zcore.struts.action.generic.BaseAction;
import org.rti.zcore.utils.DatabaseUtils;
import org.rti.zcore.utils.DateUtils;
import org.rti.zcore.utils.FileUtils;
import org.rti.zcore.utils.Zip;

/**
 * Backs up database and zips the file.
 */
public class ExportStockUpdate extends BaseAction {
    /**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(ExportStockUpdate.class);

    protected ActionForward doExecute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	HttpSession session = request.getSession();
        Principal userPrincipal = request.getUserPrincipal();
        String username = userPrincipal.getName();
        
        String message = "";
		Connection conn = null;
		conn = DatabaseUtils.getAdminConnection();
		String backupDirectory = Constants.BACKUP_DIR;
		String tempBackupDirectory = Constants.BACKUP_TEMP_DIR;
		File tempDir = new File(tempBackupDirectory);
		if (!tempDir.exists()) {
			tempDir.mkdir();
		}
		String timestamp = DateUtils.getNowFileFormat();
		
		String updateBackupDirectory = tempBackupDirectory + "update_" + timestamp + File.separator;
		File updateDir = new File(updateBackupDirectory);
		if (!updateDir.exists()) {
			updateDir.mkdir();
		}
		PreparedStatement ps=null;

		String columnDelimiter = null;
		String characterdelimiter = null;
		String schemaName = "APP";
        
		String additionalAppTables = null;
		try {
			additionalAppTables = Constants.BACKUP_ADDITIONAL_APP_TABLES;
		} catch (NoSuchFieldError e) {
			// don't have it yet...
		}

		if (additionalAppTables != null) {
			for (StringTokenizer stringTokenizer = new StringTokenizer(additionalAppTables, ","); stringTokenizer.hasMoreTokens();) {
	            String value = stringTokenizer.nextToken();
	            value.trim();
	            ps=conn.prepareStatement("CALL SYSCS_UTIL.SYSCS_EXPORT_TABLE (?,?,?,?,?,?)");
				ps.setString(1,schemaName);
				ps.setString(2,value);
				ps.setString(3,updateBackupDirectory + value + ".csv");
				ps.setString(4,columnDelimiter);
				ps.setString(5,characterdelimiter);
				ps.setString(6,null);
				ps.execute();
				ps.close();
			}
		}
		conn.close();
		
		int i = 0;
		// now zip up the files in the temp dir
		if (additionalAppTables != null) {
			for (StringTokenizer stringTokenizer = new StringTokenizer(additionalAppTables, ","); stringTokenizer.hasMoreTokens();) {
				i++;
				String tableName = stringTokenizer.nextToken();
				tableName.trim();
				String fileName = tableName + ".csv";
				String target = updateBackupDirectory +  tableName + "_" + timestamp + ".zip";
				ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(target));
				Zip.addFile(updateBackupDirectory, fileName, zos);
				zos.close();
			}
		}
		
		// Create a manifest
		StringBuffer sb = new StringBuffer();
		int numTasks = 4 + i;
		String introText = "shutdownNetworkServer:Upgrade 1 of " + numTasks + " - Shut down the network server.:\n" + 
				"startNetworkServerInsecureMode:Upgrade 2 of " + numTasks + " - Re-starts the DAR database in non-secure mode for upgrade.:\n" + 
				"backupCurrentDatabase :Upgrade 3 of " + numTasks + " - Backs up the database. Please be patient; this will take a minute or two.:\n";				
		int numIntroTasks = 3;
		sb.append(introText);
		//"importCsvData :Upgrade 4 of 5 - Updates the ITEM table in app schema.:ITEM_02082012_110400.zip,APP,ITEM,0,\n" + 
		int j = numIntroTasks;
		if (additionalAppTables != null) {
			for (StringTokenizer stringTokenizer = new StringTokenizer(additionalAppTables, ","); stringTokenizer.hasMoreTokens();) {
				j++;
				String tableName = stringTokenizer.nextToken();
				tableName.trim();
				String fileName = tableName + "_" + timestamp + ".zip";
				String output = "importCsvData :Upgrade " + j + " of " + numTasks + " - Updates the " + tableName + 
						" table in app schema.:" + fileName + ",APP," + tableName + ",0,\n";
				sb.append(output);
			}
		}
		String endText = "startNetworkServer:Upgrade " + (j+1) + " of " + numTasks + " - Re-starts the DAR database.:\n" + 
		"end:Upgrade complete. Close and re-open the DAR.:\n";
		sb.append(endText);
		String manifestPathname = updateBackupDirectory + "manifest.txt";
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(manifestPathname));
			String outText = sb.toString();
			out.write(outText);
			out.close();
		}
		catch (IOException e)
		{
			log.debug(e);
		}
		
		// now bundle them all up.

		String source = tempBackupDirectory;
		String includes = "update_" + timestamp + File.separator + ",update_" + timestamp + File.separator + "*.zip," + "update_" + timestamp + File.separator + "manifest.txt";
		String target = backupDirectory + "update_" + timestamp + ".zip";
		//Zip.zip(source, target, includes);
		org.apache.tools.ant.taskdefs.Zip zip = new org.apache.tools.ant.taskdefs.Zip();
    	zip.setDestFile(new File(target));
    	zip.setBasedir(new File(source));
    	zip.setIncludes(includes);
    	zip.setExcludes("update_" + timestamp + File.separator +"*.csv");
    	zip.setProject(new Project());
    	zip.execute();

		// delete the files in the temp dir
		FileUtils.cleanDir(updateBackupDirectory, false);
		FileUtils.cleanDir(tempBackupDirectory, false);
		
        request.setAttribute("message", "Update files exported to " + target);
        return mapping.findForward(SUCCESS_FORWARD);
    }

}

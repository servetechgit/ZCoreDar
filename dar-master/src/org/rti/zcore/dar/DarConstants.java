/*
 *    Copyright 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Constants;

/**
 * Settings for Zcore implementations
 * Edit the file at Constants.APP_PROPERTIES and Constants.DEV_PROPERTIES_FILEPATH for your local installation.
 *
 * @author <a href="mailto:ckelley@rti.org">Chris Kelley</a>
 *         Date: Jan 31, 2012
 */
public class DarConstants {

    /**
     * Commons Logging instance.
     */

    public static Log log = LogFactory.getFactory().getInstance(DarConstants.class);

    public static String pathToCatalinaHome;
    public static final String pathSep = File.separator;
    public static String DAR_PROPERTIES = null;
    public static final String COMBINED_REPORT_FILENAME = Constants.getProperties("combined.report.filename",DarConstants.getDAR_PROPERTIES());

	/**
	 * @return the dAR_PROPERTIES
	 */
	public static String getDAR_PROPERTIES() {
		if (DAR_PROPERTIES == null) {
			DAR_PROPERTIES = "resources" + pathSep + "dar.properties";
		}
		return DAR_PROPERTIES;
	}
	/**
	 * @param dAR_PROPERTIES the dAR_PROPERTIES to set
	 */
	public static void setDAR_PROPERTIES(String dAR_PROPERTIES) {
		DAR_PROPERTIES = dAR_PROPERTIES;
	}

}

/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

/*
 * Created on Mar 31, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package org.rti.zcore.dar.report;

import java.io.IOException;
import java.sql.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Register;
import org.rti.zcore.dar.gen.report.UserInfoReport;
import org.rti.zcore.utils.XmlUtils;

/**
 * @author ericl
 *         <p/>
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public abstract class ZEPRSRegister {

    /**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(Register.class);

    protected int siteId;
    protected String siteName;
    protected Date beginDate;
    protected Date endDate;
    protected String type;
    protected String reportFileName;	// used when persisting reports
    protected UserInfoReport reportCreator;
    protected Date reportDate;
    protected String reportPath;	// use for display of path in report


    ZEPRSRegister() {

        getSiteInfo();
    }

    /**
     * @return Returns the siteId.
     */
    public int getSiteId() {
        return siteId;
    }

    /**
     * @param siteId The siteId to set.
     */
    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }

    /**
     * @return Returns the siteName.
     */
    public String getSiteName() {
        return siteName;
    }

    /**
     * @param siteName The siteName to set.
     */
    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getReportFileName() {
		return reportFileName;
	}

	public void setReportFileName(String reportFileName) {
		this.reportFileName = reportFileName;
	}

	public abstract void getPatientRegister(Date beginDate, Date endDate, int siteId);

    private void getSiteInfo() {
         this.setSiteId(siteId);
    }

    public Register loadClass(String className) throws IOException {
        // ZEPRSReport report = null;
        String path = org.rti.zcore.Constants.REPORTS_XML_PATH + className + "Report.xml";
        // report = (ZEPRSReport)
        Register report = (Register) XmlUtils.getOne(path, null, null);
        return report;
    }

	public UserInfoReport getReportCreator() {
		return reportCreator;
	}

	public void setReportCreator(UserInfoReport reportCreator) {
		this.reportCreator = reportCreator;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * @return the reportPath
	 */
	public String getReportPath() {
		return reportPath;
	}

	/**
	 * @param reportPath the reportPath to set
	 */
	public void setReportPath(String reportPath) {
		this.reportPath = reportPath;
	}
}

/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Register;
import org.rti.zcore.dar.dao.SiteStatisticsDAO;
import org.rti.zcore.dar.report.valueobject.RegimenReport;
import org.rti.zcore.dar.report.valueobject.SiteStatistics;
import org.rti.zcore.utils.DatabaseUtils;

public class SiteStatisticsReport  extends Register {
	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(SiteStatisticsReport.class);
	private String reportMonth;
	private String reportYear;
	private String type;

	private SiteStatistics stats;

	@Override
	public void getPatientRegister(Date beginDate, Date endDate, int siteId) {
		Connection conn = null;
		try {
			conn = DatabaseUtils.getZEPRSConnection(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);
			stats = new SiteStatistics();
			Integer newClients = SiteStatisticsDAO.getNewClients(conn, beginDate, endDate, siteId);
			stats.setNewClients(newClients);
			Integer femaleAdults = SiteStatisticsDAO.getFemaleAdults(conn, siteId);
			stats.setFemaleAdults(femaleAdults);
			Integer femaleChildren = SiteStatisticsDAO.getFemaleChildren(conn, siteId);
			stats.setFemaleChildren(femaleChildren);
			stats.setFemales(femaleAdults + femaleChildren);
			Integer maleAdults = SiteStatisticsDAO.getMaleAdults(conn, siteId);
			stats.setMaleAdults(maleAdults);
			Integer maleChildren = SiteStatisticsDAO.getMaleChildren(conn, siteId);
			stats.setMaleChildren(maleChildren);
			stats.setMales(maleAdults + maleChildren);
			stats.setAdults(maleAdults + femaleAdults);
			stats.setChildren(maleChildren + femaleChildren);
			stats.setAllClients(maleAdults + femaleAdults +maleChildren + femaleChildren);
			Integer statusDied = SiteStatisticsDAO.getStatusDied(conn, beginDate, endDate, siteId);
			stats.setStatusDied(statusDied);
			Integer statusTransferred = SiteStatisticsDAO.getStatusTransferred(conn, beginDate, endDate, siteId);
			stats.setStatusTransferred(statusTransferred);
			Integer statusDefaulters = SiteStatisticsDAO.getStatusDefaulters(conn, beginDate, endDate, siteId);
			stats.setStatusDefaulters(statusDefaulters);
			Integer statusOther = SiteStatisticsDAO.getStatusOther(conn, beginDate, endDate, siteId);
			stats.setStatusOther(statusOther);
			Integer activeArvClients = SiteStatisticsDAO.getActiveArvClients(conn, beginDate, endDate, siteId);
			stats.setActiveArvClients(activeArvClients);
			ArrayList<RegimenReport> regimens = SiteStatisticsDAO.getRegimens(conn, beginDate, endDate, siteId);
			stats.setRegimens(regimens);
			Integer oiPatients = SiteStatisticsDAO.getOIPatients(conn, beginDate, endDate, siteId);
			stats.setOiPatients(oiPatients);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				log.error(e);
			}
		}

	}

	/**
	 * @return the stats
	 */
	public SiteStatistics getStats() {
		return stats;
	}

	/**
	 * @param stats the stats to set
	 */
	public void setStats(SiteStatistics stats) {
		this.stats = stats;
	}
}

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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Register;
import org.rti.zcore.dar.gen.report.ArtRegimenReport;
import org.rti.zcore.utils.DatabaseUtils;

public class RegimenChangeReport extends Register {


	/**
	 * Commons Logging instance.
	 */
	private static Log log = LogFactory.getFactory().getInstance(RegimenChangeReport.class);

	private List<ArtRegimenReport> regimens;

	@Override
	public void getPatientRegister(Date beginDate, Date endDate, int siteId) {
		ResultSet rs = null;
		Connection conn = null;

		try {
			regimens = new ArrayList<ArtRegimenReport>();
			conn = DatabaseUtils.getZEPRSConnection(org.rti.zcore.Constants.DATABASE_ADMIN_USERNAME);
			rs = getArtRegimens(conn, siteId, beginDate, endDate);
			while (rs.next()) {

				/*Integer age = rs.getInt("age");
				String code = rs.getString("code");*/

				//Long encounterId = rs.getLong("id");
				Long patientId = rs.getLong("patient_id");
				//String districtPatientId = rs.getString("district_patient_id");
				String firstName = rs.getString("first_name");
				String surname = rs.getString("surname");
				/*Date dateVisit = rs.getDate("date_visit");
				int currentSiteId = rs.getInt("site_id");
				String createdBy = rs.getString("created_by");
				Timestamp created = rs.getTimestamp("created");*/

				Date dateStarted = rs.getDate("date_started");
				String regimenChangeReason = rs.getString("regimen_change_reason");
				String regimenName = rs.getString("regimen_name");
				String regimenCode = rs.getString("code");

				ArtRegimenReport regimen = new ArtRegimenReport();
				regimen.setDate_started(dateStarted);
				//regimen.setDate_startedR(dateStarted.toString());
				regimen.setRegimen_change_reasonR(regimenChangeReason);
				regimen.setSurname(surname);
				regimen.setFirstName(firstName);
				regimen.setPatientId(patientId);
				regimen.setRegimen_1R(regimenName + "(" + regimenCode + ")");
				regimens.add(regimen);
			}
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
	 * Get ART regimen records (regimen code field) for this period/site
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ServletException
	 */
	protected static ResultSet getArtRegimens(Connection conn, int siteID, Date beginDate, Date endDate) throws ServletException {

		ResultSet rs = null;

		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}

		try {
			if (siteID == 0) {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created, " +
				"regimen.name AS regimen_name, date_started, regimen_change_reason " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
				dateRange +
				"ORDER BY created, surname";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
				}
				rs = ps.executeQuery();
			} else {
				String sql = "SELECT encounter.id AS id, date_visit, patient_id, district_patient_id, " +
				"first_name, surname, encounter.site_id, age_at_first_visit, encounter.created_by AS created_by, " +
				"regimen.code AS code, age_at_first_visit AS age, encounter.created, " +
				"regimen.name AS regimen_name, date_started, regimen_change_reason " +
				"FROM art_regimen, encounter, regimen, patient  " +
				"WHERE encounter.id = art_regimen.id " +
				"AND art_regimen.regimen_1 = regimen.id " +
				"AND encounter.patient_id = patient.id " +
				dateRange +
				"AND encounter.site_id = ? " +
				"ORDER BY date_started DESC";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
					ps.setInt(3, siteID);
				} else {
					ps.setInt(2, siteID);
				}

				rs = ps.executeQuery();
			}
		} catch (Exception ex) {
			log.error(ex);
		}

		return rs;
	}

	/**
	 * @return the regimens
	 */
	public List<ArtRegimenReport> getRegimens() {
		return regimens;
	}

	/**
	 * @param regimens the regimens to set
	 */
	public void setRegimens(List<ArtRegimenReport> regimens) {
		this.regimens = regimens;
	}

}

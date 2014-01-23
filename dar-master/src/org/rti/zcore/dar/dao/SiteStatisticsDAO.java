/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.art.RegimenUtils;
import org.rti.zcore.dar.report.MonthlyArtReport;
import org.rti.zcore.dar.report.valueobject.RegimenReport;
import org.rti.zcore.utils.DatabaseUtils;

public class SiteStatisticsDAO {

	/**
	 * Commons Logging instance.
	 */

	private static Log log = LogFactory.getFactory().getInstance(SiteStatisticsDAO.class);

	/**
	 * Counts new patients using patient reg records.
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @throws SQLException
	 * @should return count of new clients
	 */
	public static Integer getNewClients(Connection conn, Date beginDate, Date endDate, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patientregistration p where e.id = p.id and date_visit >= ? and date_visit <=?";
		} else {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patientregistration p where e.id = p.id and date_visit >= ? and date_visit <=? and site_id = ?";
		}
		ArrayList values = new ArrayList();
		values.add(beginDate);
		values.add(endDate);
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer newClients = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return newClients;
	}

	/**
	 *
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @param conn
	 * @return
	 * @throws SQLException
	 * @should return count of males
	 */
	public static Integer getMaleAdults(Connection conn, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(p.id) from patient p where sex = 2 and age_category = 3283";
		} else {
			sql = "Select count(p.id) from patient p where sex = 2 and age_category = 3283 and site_id = ?";
		}
		ArrayList values = new ArrayList();
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer newClients = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return newClients;
	}

	/**
	 *
	 * @param conn
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of females
	 */
	public static Integer getFemaleAdults(Connection conn, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(p.id) from patient p where sex = 1 and age_category = 3283";
		} else {
			sql = "Select count(p.id) from patient p where sex = 1 and age_category = 3283 and site_id = ?";
		}
		ArrayList values = new ArrayList();
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer newClients = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return newClients;
	}

	/**
	 *
	 * @param conn
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of male children
	 */
	public static Integer getMaleChildren(Connection conn, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(p.id) from patient p where sex = 2 and age_category = 3284";
		} else {
			sql = "Select count(p.id) from patient p where sex = 2 and age_category = 3284 and site_id = ?";
		}
		ArrayList values = new ArrayList();
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer newClients = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return newClients;
	}

	/**
	 *
	 * @param conn
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of female children
	 */
	public static Integer getFemaleChildren(Connection conn, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(p.id) from patient p where sex = 1 and age_category = 3284";
		} else {
			sql = "Select count(p.id) from patient p where sex = 1 and age_category = 3284 and site_id = ?";
		}
		ArrayList values = new ArrayList();
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer newClients = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return newClients;
	}

	/**
	 *
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of status died
	 */
	public static Integer getStatusDied(Connection conn, Date beginDate, Date endDate, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3290 and date_visit >= ? and date_visit <=?";
		} else {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3290 and date_visit >= ? and date_visit <=? and site_id = ?";
		}
		ArrayList values = new ArrayList();
		values.add(beginDate);
		values.add(endDate);
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer result = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return result;
	}

	/**
	 *
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of status transferred
	 */
	public static Integer getStatusTransferred(Connection conn, Date beginDate, Date endDate, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3289 and date_visit >= ? and date_visit <=?";
		} else {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3289 and date_visit >= ? and date_visit <=? and site_id = ?";
		}
		ArrayList values = new ArrayList();
		values.add(beginDate);
		values.add(endDate);
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer result = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return result;
	}

	/**
	 *
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of status defaulter
	 */
	public static Integer getStatusDefaulters(Connection conn, Date beginDate, Date endDate, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3288 and date_visit >= ? and date_visit <=?";
		} else {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3288 and date_visit >= ? and date_visit <=? and site_id = ?";
		}
		ArrayList values = new ArrayList();
		values.add(beginDate);
		values.add(endDate);
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer result = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return result;
	}

	/**
	 *
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @return
	 * @throws SQLException
	 * @should return count of status other
	 */
	public static Integer getStatusOther(Connection conn, Date beginDate, Date endDate, int siteId) throws SQLException {
		String sql = null;
		if (siteId == 0) {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3291 and date_visit >= ? and date_visit <=?";
		} else {
			sql = "Select count(DISTINCT e.patient_id) from encounter e, patient_status_changes p where e.id = p.id and type_of_change = 3291 and date_visit >= ? and date_visit <=? and site_id = ?";
		}
		ArrayList values = new ArrayList();
		values.add(beginDate);
		values.add(endDate);
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer result = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return result;
	}

	public static Integer getActiveArvClients(Connection conn, Date beginDate, Date endDate, int siteId) throws SQLException {

		java.util.Calendar c = java.util.Calendar.getInstance();
		c.add(java.util.Calendar.MONTH, -3);
		java.util.Date date1monthpast = c.getTime();
		String DATE_FORMAT = "yyyy-MM-dd";
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(DATE_FORMAT);
		sdf.setTimeZone(TimeZone.getDefault());
		String date1monthpastStr = sdf.format(date1monthpast);
		java.sql.Date date3monthpastSql =  java.sql.Date.valueOf(date1monthpastStr);

		String sql = null;
		if (siteId == 0) {
			sql = "Select count(DISTINCT e.patient_id) from encounter e where form_id = 132 and date_visit >= ? and date_visit <=?";
		} else {
			sql = "Select count(DISTINCT e.patient_id) from encounter e where form_id = 132 and date_visit >= ? and date_visit <=? and site_id = ?";
		}
		ArrayList values = new ArrayList();
		values.add(date3monthpastSql);
		values.add(endDate);
		if (siteId != 0) {
			values.add(siteId);
		}
		Integer result = (Integer) DatabaseUtils.getScalar(conn, sql, values);
		return result;
	}

	/**
	 *
	 * @param conn
	 * @param beginDate
	 * @param endDate
	 * @param siteId
	 * @return
	 */
	public static ArrayList<RegimenReport> getRegimens(Connection conn, Date beginDate, Date endDate, int siteId) {
		ArrayList<RegimenReport> list = new ArrayList<RegimenReport>();
		HashMap<String,RegimenReport> map = new HashMap<String,RegimenReport>();
		ResultSet rs = null;
		long total = 0;
		//HashMap<String,ArrayList<Long>> patientRegimenMap = new HashMap<String,ArrayList<Long>>();
		HashMap<Long,String> patientRegimenMap = new HashMap<Long,String>();

		try {
			rs = MonthlyArtReport.getArtRegimens(conn, siteId, beginDate, endDate, "DESC");
			while (rs.next()) {
				total++;
				Integer age = rs.getInt("age");
				String code = rs.getString("code");
				String name = rs.getString("name");
				Integer sex = rs.getInt("sex");
				Long patientId = rs.getLong("patient_id");
				//ArrayList<Long> patientsForRegimen = patientRegimenMap.get(code);
				String patientsForRegimen = patientRegimenMap.get(patientId);
				boolean newRegimen = false;
				boolean addToPatientList = true;
				if (patientsForRegimen == null) {
					//patientsForRegimen = new ArrayList<Long>();
					//patientsForRegimen.add(patientId);
					//patientRegimenMap.put(code, patientsForRegimen);
					patientRegimenMap.put(patientId, code);
					newRegimen = true;
				} else {
					addToPatientList = false;
					//log.debug("Already have regimen: " + code + " newRegimen: " + newRegimen + " patientId: " + patientId);
				}
				/*if (newRegimen == false) {
					for (Long currentPatientId : patientsForRegimen) {
						log.debug("code: " + code + " patient: " + patientId + " currentPatientId: " + currentPatientId);
						if (patientId.longValue() == currentPatientId.longValue()) {
							addToPatientList = false;
						}
					}
					if (addToPatientList == true) {
						log.debug("Adding to list: code: " + code + " patient: " + patientId);
						patientsForRegimen.add(patientId);
						patientRegimenMap.put(code, patientsForRegimen);
					}
				}*/

				if (addToPatientList) {
					//log.debug("Adding regimen: " + code + " newRegimen: " + newRegimen + " patientId: " + patientId);
					RegimenReport regimenReport = map.get(code);
					if (regimenReport == null) {
						regimenReport = new RegimenReport();
						regimenReport.setCode(code);
						regimenReport.setName(name);
						map.put(code, regimenReport);
					}

					double count = regimenReport.getCount();
					count ++;
					regimenReport.setCount(count);
					double div = count/total;
					double percentage = div * 100;
					double percentageRnd = Math.round(percentage*100);
					double percentageDo = percentageRnd/100;
					regimenReport.setPercentage(percentageDo);

					int totalAdults = regimenReport.getTotalAdults();
					int totalChildren = regimenReport.getTotalChildren();
					int totalMale = regimenReport.getTotalMale();
					int totalFemale = regimenReport.getTotalFemale();

					if (age != null && age > 14) {
						totalAdults++;
						regimenReport.setTotalAdults(totalAdults);
					}
					if (age != null && age <= 14) {
						totalChildren++;
						regimenReport.setTotalChildren(totalChildren);
					}

					if (sex != null) {
						if (sex == 1) {
							totalFemale++;
							regimenReport.setTotalFemale(totalFemale);
						} else if (sex == 2) {
							totalMale++;
							regimenReport.setTotalMale(totalMale);
						}
					}
				}
			}

			Set<Entry<String,RegimenReport>> set = map.entrySet();
			for (Entry<String, RegimenReport> entry : set) {
				RegimenReport report = entry.getValue();
				list.add(report);
			}

			Collections.sort(list, new SiteStatisticsDAO().new CodeComparator());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public class CodeComparator implements Comparator {
	    public int compare(Object o, Object o1) {
	        try {
	        	RegimenReport e, e1;
	            e = (RegimenReport) o;
	            e1 = (RegimenReport) o1;
	            if (e.getCode().compareTo(e1.getCode())> 0) {
	                return 1;
	            } else if (e.getCode().compareTo(e1.getCode()) < 0) {
	                return -1;
	            }
	        } catch (ClassCastException ex) {
	            return 0;
	        }
	        return 0;
	    }
	}

	/**
	 *
	 * @param conn
	 * @param siteID
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ServletException
	 * @throws SQLException
	 */
	public static int getOIPatients(Connection conn, Date beginDate, Date endDate, int siteID) throws ServletException, SQLException {

		int count = 0;
		ResultSet rs = null;

		String dateRange = "AND date_visit >= ? AND date_visit <= ? ";
		if (endDate == null) {
			dateRange = "AND date_visit = ?";
		}

		try {
			if (siteID == 0) {
				String sql = "SELECT DISTINCT patient_id " +
				"FROM encounter e, patient_item pi, item i " +
				"WHERE e.id = pi.encounter_id " +
				"AND pi.item_id = i.id " +
				"AND (i.item_group_id != 1 OR i.item_group_id != 2  OR i.item_group_id != 3) " +
				dateRange;
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setDate(1, beginDate);
				if (endDate != null) {
					ps.setDate(2, endDate);
				}
				rs = ps.executeQuery();
			} else {
				String sql = "SELECT DISTINCT patient_id " +
				"FROM encounter e, patient_item pi, item i " +
				"WHERE e.id = pi.encounter_id " +
				"AND pi.item_id = i.id " +
				"AND (i.item_group_id != 1 OR i.item_group_id != 2  OR i.item_group_id != 3) " +
				dateRange +
				"AND e.site_id = ? ";
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

		while (rs.next()) {
			Long patientId = rs.getLong("patient_id");
			Long regimenId = null;
			ResultSet artRs = RegimenUtils.getPatientArtRegimen(conn, patientId);
    		while (artRs.next()) {
    			regimenId = artRs.getLong("regimenId");
    		}
    		artRs.close();
    		if (regimenId == null) {
    			count++;
    		}
		}
		rs.close();

		return count;
	}

}

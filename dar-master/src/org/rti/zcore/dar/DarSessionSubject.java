/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.rti.zcore.Identifiable;
import org.rti.zcore.impl.BaseSessionSubject;
import org.rti.zcore.impl.SessionSubject;

public class DarSessionSubject extends SessionSubject implements Identifiable, BaseSessionSubject  {

    /**
     * Commons Logging instance.
     */
    private transient Log log = LogFactory.getFactory().getInstance(this.getClass().getName());

    private Boolean child;	// Is the subject a child? Uses DAR's adult/child selector.

	/**
	 * @return the child
	 */
	public Boolean getChild() {
		return child;
	}

	/**
	 * @param child the child to set
	 */
	public void setChild(Boolean child) {
		this.child = child;
	}

	/**
	 * initialises SessionPatient.
	 * @param conn
	 */
	public void init(Connection conn) {

		ResultSet rs = null;
		try {
				String sql = "SELECT age_category  "
					+ "FROM patient  "
					+ "WHERE patient.id = ? ";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setMaxRows(1);
				ps.setLong(1, this.getId());
				rs = ps.executeQuery();
		} catch (Exception ex) {
			log.error(ex);
		}

		try {
			while (rs.next()) {
				Integer ageCategory = rs.getInt("age_category");
				if (ageCategory != null && ageCategory == 3284) {
					this.setChild(true);
				}
			}
			rs.close();
		} catch (SQLException e) {
			log.debug(e);
		}
	}

	/**
	 * @return the child
	 */
	/*public Boolean getChild() {
		if (child == null) {
			ResultSet rs = null;
			try {
					String sql = "SELECT age_category  "
						+ "FROM patient  "
						+ "WHERE patient.id = ? ";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setMaxRows(1);
					ps.setLong(1, patientId);
					rs = ps.executeQuery();
			} catch (Exception ex) {
				log.error(ex);
			}
			return rs;



			ResultSet artRs = RegimenUtils.getPatientArtRegimen(conn, patientId);
    		while (artRs.next()) {
    			String code = artRs.getString("code");
    			String name = artRs.getString("name");
    			Long regimenId = artRs.getLong("regimenId");
    			sessionPatient.setRegimenCode(code);
    			sessionPatient.setRegimenName(name);
    			sessionPatient.setRegimenId(regimenId);
    		}
    		artRs.close();
		}
		return child;
	}

	*//**
	 * @param child the child to set
	 *//*
	public void setChild(Boolean child) {
		this.child = child;
	}*/


}

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

import java.sql.Date;

public class SessionSubject extends org.rti.zcore.impl.SessionSubject {
    private Date datePregnancyBegin;
    private Date datePregnancyEnd;
    private Long currentPregnancyId;
    private String regimenCode;
    private String regimenName;
    private Long regimenId;
    private boolean motherHivPositive;

	/**
	 * @return the datePregnancyBegin
	 */
	public Date getDatePregnancyBegin() {
		return datePregnancyBegin;
	}
	/**
	 * @param datePregnancyBegin the datePregnancyBegin to set
	 */
	public void setDatePregnancyBegin(Date datePregnancyBegin) {
		this.datePregnancyBegin = datePregnancyBegin;
	}
	/**
	 * @return the datePregnancyEnd
	 */
	public Date getDatePregnancyEnd() {
		return datePregnancyEnd;
	}
	/**
	 * @param datePregnancyEnd the datePregnancyEnd to set
	 */
	public void setDatePregnancyEnd(Date datePregnancyEnd) {
		this.datePregnancyEnd = datePregnancyEnd;
	}
	/**
	 * @return the currentPregnancyId
	 */
	public Long getCurrentPregnancyId() {
		return currentPregnancyId;
	}
	/**
	 * @param currentPregnancyId the currentPregnancyId to set
	 */
	public void setCurrentPregnancyId(Long currentPregnancyId) {
		this.currentPregnancyId = currentPregnancyId;
	}
	/**
	 * @return the regimenCode
	 */
	public String getRegimenCode() {
		return regimenCode;
	}
	/**
	 * @param regimenCode the regimenCode to set
	 */
	public void setRegimenCode(String regimenCode) {
		this.regimenCode = regimenCode;
	}
	/**
	 * @return the regimenName
	 */
	public String getRegimenName() {
		return regimenName;
	}
	/**
	 * @param regimenName the regimenName to set
	 */
	public void setRegimenName(String regimenName) {
		this.regimenName = regimenName;
	}
	/**
	 * @return the regimenId
	 */
	public Long getRegimenId() {
		return regimenId;
	}
	/**
	 * @param regimenId the regimenId to set
	 */
	public void setRegimenId(Long regimenId) {
		this.regimenId = regimenId;
	}
	/**
	 * @return the motherHivPositive
	 */
	public boolean isMotherHivPositive() {
		return motherHivPositive;
	}
	/**
	 * @param motherHivPositive the motherHivPositive to set
	 */
	public void setMotherHivPositive(boolean motherHivPositive) {
		this.motherHivPositive = motherHivPositive;
	}

}

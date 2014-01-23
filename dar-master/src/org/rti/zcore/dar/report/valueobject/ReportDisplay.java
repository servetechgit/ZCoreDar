/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.report.valueobject;

public class ReportDisplay {
	
	private String rowType;
	private String title;
	private Integer value;
	private String code;
	private String title2;
	private Integer newEstimatedArtPatients;
	private Integer totalEstimatedArtPatients;
	private String alternateCode;

	public ReportDisplay() {
		super();
	}
	
	
	public ReportDisplay(String rowType, String title, Integer value,
			String code, String title2, Integer newEstimatedArtPatients,
			Integer totalEstimatedArtPatients, String oldCode) {
		super();
		this.rowType = rowType;
		this.title = title;
		this.value = value;
		this.code = code;
		this.title2 = title2;
		this.newEstimatedArtPatients = newEstimatedArtPatients;
		this.totalEstimatedArtPatients = totalEstimatedArtPatients;
		this.alternateCode = oldCode;
	}


	/**
	 * @return the rowType
	 */
	public String getRowType() {
		return rowType;
	}
	/**
	 * @param rowType the rowType to set
	 */
	public void setRowType(String rowType) {
		this.rowType = rowType;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}
	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the title2
	 */
	public String getTitle2() {
		return title2;
	}

	/**
	 * @param title2 the title2 to set
	 */
	public void setTitle2(String title2) {
		this.title2 = title2;
	}

	/**
	 * @return the value
	 */
	public Integer getValue() {
		return value;
	}

	/**
	 * @param value the value to set
	 */
	public void setValue(Integer value) {
		this.value = value;
	}

	/**
	 * @return the newEstimatedArtPatients
	 */
	public Integer getNewEstimatedArtPatients() {
		return newEstimatedArtPatients;
	}

	/**
	 * @param newEstimatedArtPatients the newEstimatedArtPatients to set
	 */
	public void setNewEstimatedArtPatients(Integer newEstimatedArtPatients) {
		this.newEstimatedArtPatients = newEstimatedArtPatients;
	}

	/**
	 * @return the totalEstimatedArtPatients
	 */
	public Integer getTotalEstimatedArtPatients() {
		return totalEstimatedArtPatients;
	}

	/**
	 * @param totalEstimatedArtPatients the totalEstimatedArtPatients to set
	 */
	public void setTotalEstimatedArtPatients(Integer totalEstimatedArtPatients) {
		this.totalEstimatedArtPatients = totalEstimatedArtPatients;
	}


	/**
	 * @return the alternateCode
	 */
	public String getAlternateCode() {
		return alternateCode;
	}


	/**
	 * @param alternateCode the alternateCode to set
	 */
	public void setAlternateCode(String alternateCode) {
		this.alternateCode = alternateCode;
	}

}

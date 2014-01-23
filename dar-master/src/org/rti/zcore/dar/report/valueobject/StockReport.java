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

import java.sql.Date;

public class StockReport {

	private Long id;
	private String reportMonth;
	private String reportYear;
	private String type;
	private Integer balanceBF;
	private Integer received;
	private Integer onHand;
	private Integer totalDispensed;
	private Integer losses;
	private Integer posAdjustments;
	private Integer negAdjustments;
	private Integer balanceCF;
	private Integer quantity6MonthsExpired;
	private Date expiryDate;
	private Integer daysOutOfStock;
	private Integer quantityRequiredResupply;
	private Integer quantityRequiredNewPatients;
	private Integer totalQuantityRequired;
	private Integer additionsTotal;	// received + Pos. Adjust.
	private Integer deletionsTotal;	// issued + loss + Neg. Adjust.
	private String name;	// name of this stock item
	private String units;
	private Long item_group_id;
	private Boolean expired;	// is it expiring in the next x months?
	private String displayCategory;

	/**
	 * @return the reportMonth
	 */
	public String getReportMonth() {
		return reportMonth;
	}
	/**
	 * @param reportMonth the reportMonth to set
	 */
	public void setReportMonth(String reportMonth) {
		this.reportMonth = reportMonth;
	}
	/**
	 * @return the reportYear
	 */
	public String getReportYear() {
		return reportYear;
	}
	/**
	 * @param reportYear the reportYear to set
	 */
	public void setReportYear(String reportYear) {
		this.reportYear = reportYear;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the balanceBF
	 */
	public Integer getBalanceBF() {
		return balanceBF;
	}
	/**
	 * @param balanceBF the balanceBF to set
	 */
	public void setBalanceBF(Integer balanceBF) {
		this.balanceBF = balanceBF;
	}
	/**
	 * @return the received
	 */
	public Integer getReceived() {
		return received;
	}
	/**
	 * @param received the received to set
	 */
	public void setReceived(Integer received) {
		this.received = received;
	}
	/**
	 * @return the onHand
	 */
	public Integer getOnHand() {
		return onHand;
	}
	/**
	 * @param onHand the onHand to set
	 */
	public void setOnHand(Integer onHand) {
		this.onHand = onHand;
	}
	/**
	 * @return the totalDispensed
	 */
	public Integer getTotalDispensed() {
		return totalDispensed;
	}
	/**
	 * @param totalDispensed the totalDispensed to set
	 */
	public void setTotalDispensed(Integer totalDispensed) {
		this.totalDispensed = totalDispensed;
	}
	/**
	 * @return the losses
	 */
	public Integer getLosses() {
		return losses;
	}
	/**
	 * @param losses the losses to set
	 */
	public void setLosses(Integer losses) {
		this.losses = losses;
	}
	/**
	 * @return the posAdjustments
	 */
	public Integer getPosAdjustments() {
		return posAdjustments;
	}
	/**
	 * @param posAdjustments the posAdjustments to set
	 */
	public void setPosAdjustments(Integer posAdjustments) {
		this.posAdjustments = posAdjustments;
	}
	/**
	 * @return the negAdjustments
	 */
	public Integer getNegAdjustments() {
		return negAdjustments;
	}
	/**
	 * @param negAdjustments the negAdjustments to set
	 */
	public void setNegAdjustments(Integer negAdjustments) {
		this.negAdjustments = negAdjustments;
	}
	/**
	 * @return the balanceCF
	 */
	public Integer getBalanceCF() {
		return balanceCF;
	}
	/**
	 * @param balanceCF the balanceCF to set
	 */
	public void setBalanceCF(Integer balanceCF) {
		this.balanceCF = balanceCF;
	}
	/**
	 * @return the quantity6MonthsExpired
	 */
	public Integer getQuantity6MonthsExpired() {
		return quantity6MonthsExpired;
	}
	/**
	 * @param quantity6MonthsExpired the quantity6MonthsExpired to set
	 */
	public void setQuantity6MonthsExpired(Integer quantity6MonthsExpired) {
		this.quantity6MonthsExpired = quantity6MonthsExpired;
	}
	/**
	 * @return the expiryDate
	 */
	public Date getExpiryDate() {
		return expiryDate;
	}
	/**
	 * @param expiryDate the expiryDate to set
	 */
	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}
	/**
	 * @return the daysOutOfStock
	 */
	public Integer getDaysOutOfStock() {
		return daysOutOfStock;
	}
	/**
	 * @param daysOutOfStock the daysOutOfStock to set
	 */
	public void setDaysOutOfStock(Integer daysOutOfStock) {
		this.daysOutOfStock = daysOutOfStock;
	}
	/**
	 * @return the quantityRequiredResupply
	 */
	public Integer getQuantityRequiredResupply() {
		return quantityRequiredResupply;
	}
	/**
	 * @param quantityRequiredResupply the quantityRequiredResupply to set
	 */
	public void setQuantityRequiredResupply(Integer quantityRequiredResupply) {
		this.quantityRequiredResupply = quantityRequiredResupply;
	}
	/**
	 * @return the quantityRequiredNewPatients
	 */
	public Integer getQuantityRequiredNewPatients() {
		return quantityRequiredNewPatients;
	}
	/**
	 * @param quantityRequiredNewPatients the quantityRequiredNewPatients to set
	 */
	public void setQuantityRequiredNewPatients(Integer quantityRequiredNewPatients) {
		this.quantityRequiredNewPatients = quantityRequiredNewPatients;
	}
	/**
	 * @return the totalQuantityRequired
	 */
	public Integer getTotalQuantityRequired() {
		return totalQuantityRequired;
	}
	/**
	 * @param totalQuantityRequired the totalQuantityRequired to set
	 */
	public void setTotalQuantityRequired(Integer totalQuantityRequired) {
		this.totalQuantityRequired = totalQuantityRequired;
	}
	/**
	 * @return the additionsTotal
	 */
	public Integer getAdditionsTotal() {
		return additionsTotal;
	}
	/**
	 * @param additionsTotal the additionsTotal to set
	 */
	public void setAdditionsTotal(Integer additionsTotal) {
		this.additionsTotal = additionsTotal;
	}
	/**
	 * @return the deletionsTotal
	 */
	public Integer getDeletionsTotal() {
		return deletionsTotal;
	}
	/**
	 * @param deletionsTotal the deletionsTotal to set
	 */
	public void setDeletionsTotal(Integer deletionsTotal) {
		this.deletionsTotal = deletionsTotal;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the expired
	 */
	public Boolean getExpired() {
		return expired;
	}
	/**
	 * @param expired the expired to set
	 */
	public void setExpired(Boolean expired) {
		this.expired = expired;
	}
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * @return the units
	 */
	public String getUnits() {
		return units;
	}
	/**
	 * @param units the units to set
	 */
	public void setUnits(String units) {
		this.units = units;
	}
	/**
	 * @return the item_group_id
	 */
	public Long getItem_group_id() {
		return item_group_id;
	}
	/**
	 * @param item_group_id the item_group_id to set
	 */
	public void setItem_group_id(Long item_group_id) {
		this.item_group_id = item_group_id;
	}
	/**
	 * @return the displayCategory
	 */
	public String getDisplayCategory() {
		return displayCategory;
	}
	/**
	 * @param displayCategory the displayCategory to set
	 */
	public void setDisplayCategory(String displayCategory) {
		this.displayCategory = displayCategory;
	}



}

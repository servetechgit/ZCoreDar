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

import org.rti.zcore.dar.gen.Item;

public class DrugReport {

	private Long id;
	private Long group;
	private String name;
	private Item item;
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

	public Integer getBalanceBF() {
		return balanceBF;
	}
	public void setBalanceBF(Integer balanceBF) {
		this.balanceBF = balanceBF;
	}
	public Integer getReceived() {
		return received;
	}
	public void setReceived(Integer received) {
		this.received = received;
	}
	public Integer getOnHand() {
		return onHand;
	}
	public void setOnHand(Integer onHand) {
		this.onHand = onHand;
	}
	public Integer getTotalDispensed() {
		return totalDispensed;
	}
	public void setTotalDispensed(Integer totalDispensed) {
		this.totalDispensed = totalDispensed;
	}
	public Integer getLosses() {
		return losses;
	}
	public void setLosses(Integer losses) {
		this.losses = losses;
	}
	public Integer getPosAdjustments() {
		return posAdjustments;
	}
	public void setPosAdjustments(Integer posAdjustments) {
		this.posAdjustments = posAdjustments;
	}
	public Integer getNegAdjustments() {
		return negAdjustments;
	}
	public void setNegAdjustments(Integer negAdjustments) {
		this.negAdjustments = negAdjustments;
	}
	public Integer getBalanceCF() {
		return balanceCF;
	}
	public void setBalanceCF(Integer balanceCF) {
		this.balanceCF = balanceCF;
	}
	public Integer getQuantity6MonthsExpired() {
		return quantity6MonthsExpired;
	}
	public void setQuantity6MonthsExpired(Integer quantity6MonthsExpired) {
		this.quantity6MonthsExpired = quantity6MonthsExpired;
	}
	public Date getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}
	public Integer getDaysOutOfStock() {
		return daysOutOfStock;
	}
	public void setDaysOutOfStock(Integer daysOutOfStock) {
		this.daysOutOfStock = daysOutOfStock;
	}
	public Integer getQuantityRequiredResupply() {
		return quantityRequiredResupply;
	}
	public void setQuantityRequiredResupply(Integer quantityRequiredResupply) {
		this.quantityRequiredResupply = quantityRequiredResupply;
	}
	public Integer getQuantityRequiredNewPatients() {
		return quantityRequiredNewPatients;
	}
	public void setQuantityRequiredNewPatients(Integer quantityRequiredNewPatients) {
		this.quantityRequiredNewPatients = quantityRequiredNewPatients;
	}
	public Integer getTotalQuantityRequired() {
		return totalQuantityRequired;
	}
	public void setTotalQuantityRequired(Integer totalQuantityRequired) {
		this.totalQuantityRequired = totalQuantityRequired;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getGroup() {
		return group;
	}
	public void setGroup(Long group) {
		this.group = group;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
}

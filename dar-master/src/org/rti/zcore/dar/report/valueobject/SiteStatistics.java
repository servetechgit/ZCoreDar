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

import java.util.ArrayList;

public class SiteStatistics {

	private Integer newClients;
	private Integer males;
	private Integer females;
	private Integer maleAdults;
	private Integer femaleAdults;
	private Integer maleChildren;
	private Integer femaleChildren;
	private Integer adults;
	private Integer children;
	private Integer allClients;
	private Integer statusDied;
	private Integer statusTransferred;
	private Integer statusDefaulters;
	private Integer statusOther;
	private Integer activeArvClients;
	private ArrayList<RegimenReport> regimens;
	private Integer oiPatients;

	/**
	 * @return the newClients
	 */
	public Integer getNewClients() {
		return newClients;
	}
	/**
	 * @param newClients the newClients to set
	 */
	public void setNewClients(Integer newClients) {
		this.newClients = newClients;
	}
	/**
	 * @return the males
	 */
	public Integer getMales() {
		return males;
	}
	/**
	 * @param males the males to set
	 */
	public void setMales(Integer males) {
		this.males = males;
	}
	/**
	 * @return the females
	 */
	public Integer getFemales() {
		return females;
	}
	/**
	 * @param females the females to set
	 */
	public void setFemales(Integer females) {
		this.females = females;
	}
	/**
	 * @return the children
	 */
	public Integer getChildren() {
		return children;
	}
	/**
	 * @param children the children to set
	 */
	public void setChildren(Integer children) {
		this.children = children;
	}
	/**
	 * @return the statusDied
	 */
	public Integer getStatusDied() {
		return statusDied;
	}
	/**
	 * @param statusDied the statusDied to set
	 */
	public void setStatusDied(Integer statusDied) {
		this.statusDied = statusDied;
	}
	/**
	 * @return the statusTransferred
	 */
	public Integer getStatusTransferred() {
		return statusTransferred;
	}
	/**
	 * @param statusTransferred the statusTransferred to set
	 */
	public void setStatusTransferred(Integer statusTransferred) {
		this.statusTransferred = statusTransferred;
	}
	/**
	 * @return the statusDefaulters
	 */
	public Integer getStatusDefaulters() {
		return statusDefaulters;
	}
	/**
	 * @param statusDefaulters the statusDefaulters to set
	 */
	public void setStatusDefaulters(Integer statusDefaulters) {
		this.statusDefaulters = statusDefaulters;
	}
	/**
	 * @return the statusOther
	 */
	public Integer getStatusOther() {
		return statusOther;
	}
	/**
	 * @param statusOther the statusOther to set
	 */
	public void setStatusOther(Integer statusOther) {
		this.statusOther = statusOther;
	}
	/**
	 * @return the activeArvClients
	 */
	public Integer getActiveArvClients() {
		return activeArvClients;
	}
	/**
	 * @param activeArvClients the activeArvClients to set
	 */
	public void setActiveArvClients(Integer activeArvClients) {
		this.activeArvClients = activeArvClients;
	}
	/**
	 * @return the maleAdults
	 */
	public Integer getMaleAdults() {
		return maleAdults;
	}
	/**
	 * @param maleAdults the maleAdults to set
	 */
	public void setMaleAdults(Integer maleAdults) {
		this.maleAdults = maleAdults;
	}
	/**
	 * @return the femaleAdults
	 */
	public Integer getFemaleAdults() {
		return femaleAdults;
	}
	/**
	 * @param femaleAdults the femaleAdults to set
	 */
	public void setFemaleAdults(Integer femaleAdults) {
		this.femaleAdults = femaleAdults;
	}
	/**
	 * @return the maleChildren
	 */
	public Integer getMaleChildren() {
		return maleChildren;
	}
	/**
	 * @param maleChildren the maleChildren to set
	 */
	public void setMaleChildren(Integer maleChildren) {
		this.maleChildren = maleChildren;
	}
	/**
	 * @return the femaleChildren
	 */
	public Integer getFemaleChildren() {
		return femaleChildren;
	}
	/**
	 * @param femaleChildren the femaleChildren to set
	 */
	public void setFemaleChildren(Integer femaleChildren) {
		this.femaleChildren = femaleChildren;
	}
	/**
	 * @return the adults
	 */
	public Integer getAdults() {
		return adults;
	}
	/**
	 * @param adults the adults to set
	 */
	public void setAdults(Integer adults) {
		this.adults = adults;
	}
	/**
	 * @return the allClients
	 */
	public Integer getAllClients() {
		return allClients;
	}
	/**
	 * @param allClients the allClients to set
	 */
	public void setAllClients(Integer allClients) {
		this.allClients = allClients;
	}
	public ArrayList<RegimenReport> getRegimens() {
		return regimens;
	}
	public void setRegimens(ArrayList<RegimenReport> regimens) {
		this.regimens = regimens;
	}
	public Integer getOiPatients() {
		return oiPatients;
	}
	public void setOiPatients(Integer oiPatients) {
		this.oiPatients = oiPatients;
	}

}

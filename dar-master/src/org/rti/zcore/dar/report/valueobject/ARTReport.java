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

import java.util.HashMap;
import java.util.SortedSet;
import java.util.TreeSet;

import org.rti.zcore.utils.sort.CreatedComparator;

/**
 * Holds values such as totals and SortedSets of ARTPatients for reports
 * @author ckelley
 *
 */
public class ARTReport {

	private int totalAdults;
	private int totalChildren;
	private int totalAdultsDispensed;
	private int totalChildrenDispensed;
	private int totalMalesNew;
	private int totalMalesRevisit;
	private int totalFemalesNew;
	private int totalFemalesRevisit;
	private int totalAdultsNew;
	private int totalAdultsRevisit;
	private int totalChildrenNew;
	private int totalChildrenRevisit;
	private HashMap<String, Integer> regimenReportMap  = new HashMap<String, Integer>();
	//private HashMap<Long, String> patientArvMap;
	private SortedSet<ARTPatient> adults;
	private SortedSet<ARTPatient> children;
	private SortedSet<ARTPatient> allPatients;


	/**
	 * @return the totalAdults
	 */
	public int getTotalAdults() {
		return totalAdults;
	}
	/**
	 * @param totalAdults the totalAdults to set
	 */
	public void setTotalAdults(int totalAdults) {
		this.totalAdults = totalAdults;
	}
	/**
	 * @return the totalChildren
	 */
	public int getTotalChildren() {
		return totalChildren;
	}
	/**
	 * @param totalChildren the totalChildren to set
	 */
	public void setTotalChildren(int totalChildren) {
		this.totalChildren = totalChildren;
	}
	
	/**
	 * @return the totalAdultsDispensed
	 */
	public int getTotalAdultsDispensed() {
		return totalAdultsDispensed;
	}
	/**
	 * @param totalAdultsDispensed the totalAdultsDispensed to set
	 */
	public void setTotalAdultsDispensed(int totalAdultsDispensed) {
		this.totalAdultsDispensed = totalAdultsDispensed;
	}
	/**
	 * @return the totalChildrenDispensed
	 */
	public int getTotalChildrenDispensed() {
		return totalChildrenDispensed;
	}
	/**
	 * @param totalChildrenDispensed the totalChildrenDispensed to set
	 */
	public void setTotalChildrenDispensed(int totalChildrenDispensed) {
		this.totalChildrenDispensed = totalChildrenDispensed;
	}

	/**
	 * @return the regimenReportMap
	 */
	public HashMap<String, Integer> getRegimenReportMap() {
		return regimenReportMap;
	}
	/**
	 * @param regimenReportMap the regimenReportMap to set
	 */
	public void setRegimenReportMap(HashMap<String, Integer> regimenReportMap) {
		this.regimenReportMap = regimenReportMap;
	}
	/**
	 * @return the totalMalesNew
	 */
	public int getTotalMalesNew() {
		return totalMalesNew;
	}
	/**
	 * @param totalMalesNew the totalMalesNew to set
	 */
	public void setTotalMalesNew(int totalMalesNew) {
		this.totalMalesNew = totalMalesNew;
	}
	/**
	 * @return the totalMalesRevisit
	 */
	public int getTotalMalesRevisit() {
		return totalMalesRevisit;
	}
	/**
	 * @param totalMalesRevisit the totalMalesRevisit to set
	 */
	public void setTotalMalesRevisit(int totalMalesRevisit) {
		this.totalMalesRevisit = totalMalesRevisit;
	}
	/**
	 * @return the totalFemalesNew
	 */
	public int getTotalFemalesNew() {
		return totalFemalesNew;
	}
	/**
	 * @param totalFemalesNew the totalFemalesNew to set
	 */
	public void setTotalFemalesNew(int totalFemalesNew) {
		this.totalFemalesNew = totalFemalesNew;
	}
	/**
	 * @return the totalFemalesRevisit
	 */
	public int getTotalFemalesRevisit() {
		return totalFemalesRevisit;
	}
	/**
	 * @param totalFemalesRevisit the totalFemalesRevisit to set
	 */
	public void setTotalFemalesRevisit(int totalFemalesRevisit) {
		this.totalFemalesRevisit = totalFemalesRevisit;
	}
	/**
	 * @return the adults
	 */
	public SortedSet<ARTPatient> getAdults() {
		return adults;
	}
	/**
	 * @param adults the adults to set
	 */
	public void setAdults(SortedSet<ARTPatient> adults) {
		this.adults = adults;
	}
	/**
	 * @return the children
	 */
	public SortedSet<ARTPatient> getChildren() {
		return children;
	}
	/**
	 * @param children the children to set
	 */
	public void setChildren(SortedSet<ARTPatient> children) {
		this.children = children;
	}
	/**
	 * @return the allPatients
	 */
	public SortedSet<ARTPatient> getAllPatients() {
		if (allPatients == null) {
			allPatients = new TreeSet<ARTPatient>(new CreatedComparator());
			allPatients.addAll(adults);
			allPatients.addAll(children);
		}
		return allPatients;
	}
	/**
	 * @param allPatients the allPatients to set
	 */
	public void setAllPatients(SortedSet<ARTPatient> allPatients) {
		this.allPatients = allPatients;
	}
	/**
	 * @return the totalAdultsNew
	 */
	public int getTotalAdultsNew() {
		return totalAdultsNew;
	}
	/**
	 * @param totalAdultsNew the totalAdultsNew to set
	 */
	public void setTotalAdultsNew(int totalAdultsNew) {
		this.totalAdultsNew = totalAdultsNew;
	}
	/**
	 * @return the totalAdultsRevisit
	 */
	public int getTotalAdultsRevisit() {
		return totalAdultsRevisit;
	}
	/**
	 * @param totalAdultsRevisit the totalAdultsRevisit to set
	 */
	public void setTotalAdultsRevisit(int totalAdultsRevisit) {
		this.totalAdultsRevisit = totalAdultsRevisit;
	}
	/**
	 * @return the totalChildrenNew
	 */
	public int getTotalChildrenNew() {
		return totalChildrenNew;
	}
	/**
	 * @param totalChildrenNew the totalChildrenNew to set
	 */
	public void setTotalChildrenNew(int totalChildrenNew) {
		this.totalChildrenNew = totalChildrenNew;
	}
	/**
	 * @return the totalChildrenRevisit
	 */
	public int getTotalChildrenRevisit() {
		return totalChildrenRevisit;
	}
	/**
	 * @param totalChildrenRevisit the totalChildrenRevisit to set
	 */
	public void setTotalChildrenRevisit(int totalChildrenRevisit) {
		this.totalChildrenRevisit = totalChildrenRevisit;
	}

}

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

import org.rti.zcore.EncounterData;
import org.rti.zcore.dar.gen.PatientItem;

public class OIARTAdultPatient extends ARTPatient {

    private Integer cotrimoxazoleDS960mg;
    private Integer cotrimoxazoleTabs480mg;
    private Integer cotrimoxazolesusp240mg_5ml;
	/**
	 * @return the cotrimoxazoleDS960mg
	 */
	public Integer getCotrimoxazoleDS960mg() {
		return cotrimoxazoleDS960mg;
	}
	/**
	 * @param cotrimoxazoleDS960mg the cotrimoxazoleDS960mg to set
	 */
	public void setCotrimoxazoleDS960mg(Integer cotrimoxazoleDS960mg) {
		this.cotrimoxazoleDS960mg = cotrimoxazoleDS960mg;
	}
	/**
	 * @return the cotrimoxazoleTabs480mg
	 */
	public Integer getCotrimoxazoleTabs480mg() {
		return cotrimoxazoleTabs480mg;
	}
	/**
	 * @param cotrimoxazoleTabs480mg the cotrimoxazoleTabs480mg to set
	 */
	public void setCotrimoxazoleTabs480mg(Integer cotrimoxazoleTabs480mg) {
		this.cotrimoxazoleTabs480mg = cotrimoxazoleTabs480mg;
	}
	/**
	 * @return the cotrimoxazolesusp240mg_5ml
	 */
	public Integer getCotrimoxazolesusp240mg_5ml() {
		return cotrimoxazolesusp240mg_5ml;
	}
	/**
	 * @param cotrimoxazolesusp240mg_5ml the cotrimoxazolesusp240mg_5ml to set
	 */
	public void setCotrimoxazolesusp240mg_5ml(Integer cotrimoxazolesusp240mg_5ml) {
		this.cotrimoxazolesusp240mg_5ml = cotrimoxazolesusp240mg_5ml;
	}



}


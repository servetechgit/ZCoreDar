/*
 *    Copyright 2003 - 2012 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.utils;

public class HealthCalcUtils {

	/**
	 * Caclulates BMI using the formula bmi = weight/Math.pow(height/100, 2);
	 * @param weight
	 * @param height
	 * @should return a double
	 * @return bmi, rounded
	 */
	public static Float bmiCalc(Float weight, Float height) {
		Double bmi = null;
		bmi = weight/Math.pow(height/100, 2);
		Float bmiRounded = Float.valueOf(Math.round(bmi*100))/100;
		return bmiRounded;
	}
}

package org.rti.zcore.dar.utils;

import org.junit.Assert;
import org.junit.Test;
import org.openmrs.test.Verifies;



public class HealthCalcUtilsTest {

	/**
	 * @see {@link HealthCalcUtils#bmiCalc(Float,Float)}
	 *
	 */
	@Test
	@Verifies(value = "should return a double", method = "bmiCalc(Float,Float)")
	public void bmiCalc_shouldReturnADouble() throws Exception {
		Float weight = Float.valueOf("65.4");
		Float height = Float.valueOf("178");
		Float bmi = HealthCalcUtils.bmiCalc(weight, height);
		//TODO auto-generated
		Assert.assertNotNull("BMI is null", bmi);
	}

}
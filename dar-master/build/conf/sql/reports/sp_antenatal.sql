DELIMITER $$

DROP PROCEDURE IF EXISTS `zeports`.`sp_antenatal` $$
CREATE PROCEDURE `sp_antenatal`(IN in_patient_id BIGINT(20), OUT out_lmp_date DATE, OUT out_dating_method VARCHAR(50), OUT out_initial_uterus_size_weeks INTEGER(11), OUT out_first_ega_weeks INTEGER(11), OUT out_planned_pregnancy TINYINT(1), OUT out_contraception_prior_to_preg TINYINT(1), OUT out_ega_quickening INTEGER(11), OUT out_anc_visits_cnt INTEGER(11), OUT out_bp_systolic_visits VARCHAR(255), OUT out_bp_diastolic_visits VARCHAR(255), OUT out_height_first_visit INTEGER(11), OUT out_v_weight_gained FLOAT, OUT out_v_sp VARCHAR(255), OUT out_folate VARCHAR(255), OUT out_iron VARCHAR(255), OUT out_deworming VARCHAR(255))
BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_num INT DEFAULT 0;
    DECLARE v_date_visit DATE default NULL;
    
	DECLARE v_lmp_date DATE default NULL;
	DECLARE v_initial_uterus_size_weeks INTEGER(11) DEFAULT NULL;
	DECLARE v_dating_method VARCHAR(50) DEFAULT NULL;
	DECLARE v_first_ega_weeks INTEGER(11) DEFAULT NULL;	
	DECLARE v_planned_pregnancy TINYINT(1) DEFAULT 0;
    DECLARE v_contraception_prior_to_preg TINYINT(1) DEFAULT 0;
	DECLARE v_ega_quickening INTEGER(11) DEFAULT NULL;
	DECLARE v_anc_visits_cnt INTEGER(11) DEFAULT NULL;
	DECLARE v_height_first_visit INTEGER(11) DEFAULT NULL;
	DECLARE v_weight_first_visit FLOAT DEFAULT NULL;
	DECLARE v_weight FLOAT DEFAULT NULL;
	DECLARE v_weight_gained FLOAT DEFAULT NULL;
	DECLARE v_bp_systolic_visits VARCHAR(255) DEFAULT NULL;
	DECLARE v_bp_diastolic_visits VARCHAR(255) DEFAULT NULL;
	DECLARE v_bp_systolic_first_visit VARCHAR(255) DEFAULT NULL;
	DECLARE v_bp_diastolic_first_visits VARCHAR(255) DEFAULT NULL;
	DECLARE v_sp VARCHAR(255) DEFAULT NULL;
	DECLARE v_folate VARCHAR(255) DEFAULT NULL;
	DECLARE v_iron VARCHAR(255) DEFAULT NULL;
	DECLARE v_deworming VARCHAR(255) DEFAULT NULL;	
	
	DECLARE v_lmp_date_this DATE default NULL;
	DECLARE v_initial_uterus_size_weeks_this INTEGER(11) DEFAULT NULL;
	DECLARE v_dating_method_this VARCHAR(50) DEFAULT NULL;
	DECLARE v_first_ega_weeks_this INTEGER(11) DEFAULT NULL;	
	DECLARE v_planned_pregnancy_this TINYINT(1) DEFAULT 0;
    DECLARE v_contraception_prior_to_preg_this TINYINT(1) DEFAULT 0;
	DECLARE v_ega_quickening_this INTEGER(11) DEFAULT NULL;
	DECLARE v_height_first_visit_this INTEGER(11) DEFAULT NULL;
	DECLARE v_weight_first_visit_this FLOAT DEFAULT NULL;
	DECLARE v_weight_this FLOAT DEFAULT NULL;
	DECLARE v_weight_gained_this FLOAT DEFAULT NULL;
	DECLARE v_bp_systolic_visits_this VARCHAR(255) DEFAULT NULL;
	DECLARE v_bp_diastolic_visits_this VARCHAR(255) DEFAULT NULL;	
	DECLARE v_sp_this VARCHAR(255) DEFAULT NULL;
	DECLARE v_sp_date VARCHAR(255) DEFAULT NULL;
	DECLARE v_folate_this VARCHAR(255) DEFAULT NULL;
	DECLARE v_folate_date VARCHAR(255) DEFAULT NULL;
	DECLARE v_iron_this VARCHAR(255) DEFAULT NULL;
	DECLARE v_iron_date VARCHAR(255) DEFAULT NULL;
	DECLARE v_deworming_this VARCHAR(255) DEFAULT NULL;	
	DECLARE v_deworming_date VARCHAR(255) DEFAULT NULL;	

	DECLARE pregDateCursor CURSOR FOR
	SELECT date_visit, lmp_127_calculated, uterus_size_in_days_188, dating_method,
    ega_129, planned_preg_135, contracept_practiced_136,
    quickening_130
    FROM zeprs.pregnancydating p
	LEFT JOIN zeprs.encounter e on e.id = p.id
	WHERE e.patient_id = in_patient_id
    ORDER BY date_visit ASC;
    
    DECLARE routineAnteCursor CURSOR FOR
	SELECT date_visit, fe1.enumeration AS bp_systolic, fe2.enumeration AS bp_diastolic,
    weight_228, fe3.enumeration AS sp, folate, iron, deworming
    FROM zeprs.routineante r
	LEFT JOIN zeprs.encounter e on e.id = r.id
	LEFT JOIN admin.field_enumeration fe1 on fe1.id = r.bp_systolic_224
	LEFT JOIN admin.field_enumeration fe2 on fe2.id = r.bp_diastolic_225
	LEFT JOIN admin.field_enumeration fe3 on fe3.id = r.malaria_sp_dosage
	WHERE e.patient_id = in_patient_id
    ORDER BY date_visit ASC;
    
    DECLARE initialAnteCursor CURSOR FOR
	SELECT date_visit, fe1.enumeration AS bp_systolic, fe2.enumeration AS bp_diastolic, weight_228, height_159
    FROM zeprs.initialvisit i
	LEFT JOIN zeprs.encounter e on e.id = i.id
	LEFT JOIN admin.field_enumeration fe1 on fe1.id = i.bp_systolic_224
	LEFT JOIN admin.field_enumeration fe2 on fe2.id = i.bp_diastolic_225
	WHERE e.patient_id = in_patient_id
    ORDER BY date_visit ASC;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;	

	OPEN pregDateCursor;		
		pregDateLoop:LOOP
		FETCH pregDateCursor
        INTO v_date_visit, v_lmp_date_this, v_initial_uterus_size_weeks_this, v_dating_method_this,
        v_first_ega_weeks_this, v_planned_pregnancy_this, v_contraception_prior_to_preg_this,
        v_ega_quickening_this;
          	         	
			IF v_done=1 THEN
				LEAVE pregDateLoop;
			END IF;	
			
			SET v_num = v_num + 1;
			SET out_lmp_date = v_lmp_date_this;
			
            SET out_planned_pregnancy = v_planned_pregnancy_this;
            SET out_contraception_prior_to_preg = v_contraception_prior_to_preg_this;
            SET out_ega_quickening = v_ega_quickening_this;	
            
            IF v_num = 1 THEN 	
            	SET out_initial_uterus_size_weeks = v_initial_uterus_size_weeks_this/7;
            	SET out_first_ega_weeks = v_first_ega_weeks_this/7;
			END IF;
            
            CASE v_dating_method_this
			     WHEN 2805
			     THEN SET out_dating_method = "LMP";
			     WHEN 2806
			     THEN SET out_dating_method = "Uterine size";
		         WHEN 2807
			     THEN SET out_dating_method = "Ultrasound";
			
			     ELSE SET out_dating_method = NULL;
            END CASE;
      			
		END LOOP pregDateLoop;
	CLOSE pregDateCursor;	
	SET v_done=0;
	SET v_num=0;
	
	OPEN initialAnteCursor;		
		initialAnteLoop:LOOP
		FETCH initialAnteCursor
        INTO v_date_visit, v_bp_systolic_visits_this, v_bp_diastolic_visits_this,
        v_weight_this, v_height_first_visit_this;
          	         	
			IF v_done=1 THEN
				LEAVE initialAnteLoop;
			END IF;	
			
			SET v_num = v_num + 1;	
			SET out_height_first_visit = v_height_first_visit_this;
			SET v_weight_first_visit = v_weight_this;	     		
      		SET v_bp_systolic_visits = CONCAT("SBP: ", v_bp_systolic_visits_this);
            SET v_bp_diastolic_visits = CONCAT("DBP: ", v_bp_diastolic_visits_this);
		END LOOP initialAnteLoop;
	CLOSE initialAnteCursor;	
	SET v_done=0;
	SET v_num=0;
	
	OPEN routineAnteCursor;		
		routineAnteLoop:LOOP
		FETCH routineAnteCursor
        INTO v_date_visit, v_bp_systolic_visits_this, v_bp_diastolic_visits_this,
        v_weight_this, v_sp_this, v_folate_this, v_iron_this, v_deworming_this;
          	         	
			IF v_done=1 THEN
				LEAVE routineAnteLoop;
			END IF;	
			
			SET v_num = v_num + 1;	
			SET v_weight = v_weight_this;
						
            IF v_weight_first_visit IS NULL THEN
               SET v_weight_first_visit = v_weight_this;
            END IF;
            
            		
			IF v_bp_systolic_visits IS NULL THEN 	
            	SET v_bp_systolic_visits = CONCAT("SBP: ", v_bp_systolic_visits_this);
                ELSE
                SET v_bp_systolic_visits = CONCAT_WS(",", v_bp_systolic_visits, v_bp_systolic_visits_this);
			END IF;	

            IF v_bp_diastolic_visits IS NULL THEN
                SET v_bp_diastolic_visits = CONCAT("DBP: ", v_bp_diastolic_visits_this);
                ELSE
                SET v_bp_diastolic_visits = CONCAT_WS(", ", v_bp_diastolic_visits, v_bp_diastolic_visits_this);
			END IF;	

            IF v_sp_this IS NOT NULL THEN
            SET v_sp_date = CONCAT_WS(":", v_date_visit, v_sp_this);
            SET v_sp = CONCAT_WS(", ", v_sp, v_sp_date);
            END IF;	
            
            IF v_folate_this = 1 THEN
            SET v_folate_date = CONCAT_WS(":", v_date_visit,  "Yes");
            SET v_folate = CONCAT_WS(", ", v_folate, v_date_visit);
            END IF;	
            
            IF v_iron_this = 1 THEN
            SET v_iron_date = CONCAT_WS(":", v_date_visit,  "Yes");
            SET v_iron = CONCAT_WS(", ", v_iron, v_date_visit);
            END IF;	
            
            IF v_deworming_this = 1 THEN
            SET v_deworming_date = CONCAT_WS(":", v_date_visit, "Yes");
            SET v_deworming = CONCAT_WS(", ", v_deworming, v_date_visit);
            END IF;	
                  			
		END LOOP routineAnteLoop;
	CLOSE routineAnteCursor;	
	SET v_done=0;
	SET out_anc_visits_cnt = v_num;
	SET v_num=0;
	
	SET out_bp_systolic_visits = v_bp_systolic_visits;
	SET out_bp_diastolic_visits = v_bp_diastolic_visits;	
	SET out_v_weight_gained = FORMAT(v_weight - v_weight_first_visit, 2);
	SET out_v_sp = v_sp;
	SET out_folate = v_folate;
	SET out_iron= v_iron;
	SET out_deworming = v_deworming;
	
END $$

DELIMITER ;
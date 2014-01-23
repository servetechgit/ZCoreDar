DELIMITER $$

DROP PROCEDURE IF EXISTS `zeports`.`sp_med_surg_history` $$
CREATE PROCEDURE `sp_med_surg_history`(in_patient_id BIGINT(20), OUT out_diabetes TINYINT(4), OUT out_chronic_htn TINYINT(4),
OUT out_tuberculosis TINYINT(4), OUT out_hiv_diag TINYINT(4), OUT out_syphilis TINYINT(4), OUT out_malaria_curr_preg TINYINT(4))
BEGIN
  DECLARE v_done INT DEFAULT 0;
	DECLARE v_diabetes TINYINT(1) DEFAULT 0;
	DECLARE v_chronic_htn TINYINT(1) DEFAULT 0;
	DECLARE v_tuberculosis TINYINT(1) DEFAULT 0;
	DECLARE v_hiv_diag TINYINT(1) DEFAULT 0;
	DECLARE v_syphilis TINYINT(1) DEFAULT 0;
	DECLARE v_malaria_curr_preg TINYINT(1) DEFAULT 0;
  DECLARE v_diabetes_this TINYINT(1) DEFAULT 0;
	DECLARE v_chronic_htn_this TINYINT(1) DEFAULT 0;
	DECLARE v_tuberculosis_this TINYINT(1) DEFAULT 0;
	DECLARE v_hiv_diag_this TINYINT(1) DEFAULT 0;
	DECLARE v_syphilis_this TINYINT(1) DEFAULT 0;
	DECLARE v_malaria_curr_preg_this TINYINT(1) DEFAULT 0;

	DECLARE thisCursor CURSOR FOR
	SELECT diabetes_72, hypertension_74, tuberculosis_78, hiv, syphilis_94, malaria_85
    FROM zeprs.medSurgHist m
	LEFT JOIN zeprs.encounter e on e.id = m.id
	WHERE e.patient_id = in_patient_id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;	

	OPEN thisCursor;		
		thisLoop:LOOP
		FETCH thisCursor
        INTO v_diabetes_this, v_chronic_htn_this, v_tuberculosis_this, v_hiv_diag_this, v_syphilis_this, v_malaria_curr_preg_this;
          	
			IF v_done=1 THEN
				LEAVE thisLoop;
			END IF;	
			
			IF v_diabetes_this = 1 THEN 	
            	SET v_diabetes = 1;	
			END IF;
      IF v_chronic_htn_this = 1 THEN 	
            	SET v_chronic_htn = 1;	
			END IF;
      IF v_tuberculosis_this = 1 THEN 	
            	SET v_tuberculosis = 1;	
			END IF;
      IF v_hiv_diag_this = 1 THEN 	
            	SET v_hiv_diag = 1;	
			END IF;
      IF v_syphilis_this = 1 THEN 	
            	SET v_syphilis = 1;	
			END IF;
      IF v_malaria_curr_preg_this = 1 THEN 	
            	SET v_malaria_curr_preg = 1;	
			END IF;
			
		END LOOP thisLoop;
	CLOSE thisCursor;

	SET v_done=0;
	SET out_diabetes = v_diabetes;	
	SET out_chronic_htn = v_chronic_htn;
	SET out_tuberculosis = v_tuberculosis;
  SET out_hiv_diag = v_hiv_diag;
	SET out_syphilis = v_syphilis;
	SET out_malaria_curr_preg = v_malaria_curr_preg;
	
	SET v_done=0;
END $$

DELIMITER ;
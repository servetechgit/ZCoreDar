DELIMITER $$

DROP PROCEDURE IF EXISTS `zeports`.`sp_build_history` $$
CREATE PROCEDURE `sp_build_history`()
BEGIN

	DECLARE v_done INT DEFAULT 0;
	DECLARE v_patientId bigint(20);
	DECLARE v_pregs integer(11);
	DECLARE v_pregsFull integer(11);
	DECLARE v_pregsPreterm integer(11);
	DECLARE v_pregsInfantWeight varchar(200);
	DECLARE v_pregsStillbirth integer(11);
	DECLARE v_pregsNnd integer(11);
	DECLARE v_pregs_deathReason varchar(255);
	DECLARE v_pregs_cs integer(11);
	DECLARE v_abruption TINYINT(4);
	DECLARE v_eclampsia TINYINT(4);
	DECLARE v_pph TINYINT(4);
	DECLARE v_diabetes TINYINT(1) DEFAULT 0;
	DECLARE v_chronic_htn TINYINT(1) DEFAULT 0;
	DECLARE v_tuberculosis TINYINT(1) DEFAULT 0;
	DECLARE v_hiv_diag TINYINT(1) DEFAULT 0;
	DECLARE v_syphilis TINYINT(1) DEFAULT 0;
	DECLARE v_malaria_curr_preg TINYINT(1) DEFAULT 0;
	
	DECLARE v_lmp_date DATE default NULL;	
	DECLARE v_dating_method VARCHAR(50) DEFAULT NULL;
	DECLARE v_initial_uterus_size_weeks INTEGER(11) DEFAULT NULL;
	DECLARE v_first_ega_weeks INTEGER(11) DEFAULT NULL;	
	DECLARE v_planned_pregnancy TINYINT(1) DEFAULT 0;
	DECLARE v_contraception_prior_to_preg TINYINT(1) DEFAULT 0;
	DECLARE v_ega_quickening INTEGER(11) DEFAULT NULL;
	DECLARE v_anc_visits_cnt INTEGER(11) DEFAULT NULL;
	DECLARE v_bp_systolic_visits VARCHAR(255) DEFAULT NULL;
	DECLARE v_bp_diastolic_visits VARCHAR(255) DEFAULT NULL;	
	DECLARE v_height_first_visit INTEGER(11) DEFAULT NULL;
	DECLARE v_weight_gained FLOAT DEFAULT NULL;
	
	DECLARE v_sp VARCHAR(255) DEFAULT NULL;
	DECLARE v_folate VARCHAR(255) DEFAULT NULL;
	DECLARE v_iron VARCHAR(255) DEFAULT NULL;
	DECLARE v_deworming VARCHAR(255) DEFAULT NULL;
		
	DECLARE patient_cur CURSOR FOR
	SELECT patient_id
	FROM demographics;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;
	
	TRUNCATE history;
	TRUNCATE antenatal;
	
	START TRANSACTION;

    OPEN patient_cur;
	FETCH patient_cur INTO v_patientId;
	pat_loop:LOOP
                 IF v_done=1 THEN
	             	LEAVE pat_loop;
                 END IF;	
	CALL sp_pregs_cnt(v_patientId, v_pregs, v_pregsFull,v_pregsPreterm,
    v_pregsInfantWeight, v_pregsStillbirth, v_pregsNnd, v_pregs_deathReason,
    v_pregs_cs, v_abruption, v_eclampsia, v_pph);

   CALL sp_med_surg_history(v_patientId, v_diabetes, v_chronic_htn, v_tuberculosis, v_hiv_diag,
   v_syphilis, v_malaria_curr_preg);
   
   CALL sp_antenatal(v_patientId, v_lmp_date, v_dating_method, v_initial_uterus_size_weeks,
   v_first_ega_weeks,v_planned_pregnancy, v_contraception_prior_to_preg,
   v_ega_quickening, v_anc_visits_cnt, v_bp_systolic_visits, v_bp_diastolic_visits,
   v_height_first_visit, v_weight_gained, v_sp, v_folate, v_iron, v_deworming );
	
   INSERT INTO history (patient_id, pregs_prev, pregs_full_term,
   pregs_preterm,pregs_infant_weights, pregs_stillbirth, pregs_nnd,
   pregs_death_reason, pregs_cs, abruption, eclampsia, pph,
   diabetes, chronic_htn, tuberculosis, hiv_diag, syphilis, malaria_curr_preg )
   
   VALUES (v_patientId, v_pregs, v_pregsFull, v_pregsPreterm,
   LEFT(v_pregsInfantWeight,200), v_pregsStillbirth, v_pregsNnd,
   LEFT(v_pregs_deathReason,255), v_pregs_cs, v_abruption, v_eclampsia, v_pph,
   v_diabetes, v_chronic_htn, v_tuberculosis, v_hiv_diag,
   v_syphilis, v_malaria_curr_preg);
   
   INSERT INTO antenatal (patient_id, lmp_date, dating_method,
   initial_uterus_size_weeks, first_ega_weeks,planned_pregnancy, contraception_prior_to_preg,
	ega_quickening, anc_visits_cnt, bp_systolic_visits, bp_diastolic_visits,
   height_first_visit, weight_gained, sp, folate, iron, deworming )
   
   VALUES (v_patientId, v_lmp_date, v_dating_method, v_initial_uterus_size_weeks,
   v_first_ega_weeks,v_planned_pregnancy, v_contraception_prior_to_preg,
   v_ega_quickening, v_anc_visits_cnt, v_bp_systolic_visits, v_bp_diastolic_visits,
   v_height_first_visit, v_weight_gained, v_sp, v_folate, v_iron, v_deworming) ;
   	
	FETCH patient_cur INTO v_patientId;
	END LOOP pat_loop;
	
	CLOSE patient_cur;
	
	COMMIT;
	
	select * from history;
	FLUSH TABLES;
END $$

DELIMITER ;
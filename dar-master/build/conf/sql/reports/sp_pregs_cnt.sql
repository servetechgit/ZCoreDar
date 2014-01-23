DELIMITER $$

DROP PROCEDURE IF EXISTS `zeports`.`sp_pregs_cnt` $$
CREATE PROCEDURE `sp_pregs_cnt`(IN in_patient_id BIGINT(20), OUT out_pregs INTEGER(11), OUT out_pregs_full INTEGER(11), OUT out_pregs_preterm INTEGER(11), OUT out_pregs_infant_weight VARCHAR(200), OUT out_pregs_stillbirth INTEGER(11), OUT out_pregs_nnd INTEGER(11), OUT out_pregs_death_reason VARCHAR(200), OUT out_pregs_cs INTEGER(11), OUT out_abruption INTEGER(11), OUT out_eclampsia TINYINT(4), OUT out_pph TINYINT(4))
BEGIN
    DECLARE v_done INT DEFAULT 0;
	DECLARE v_pregs integer(11) DEFAULT 0;
	DECLARE v_pregs_full integer(11) DEFAULT 0;
	DECLARE v_pregs_preterm integer(11) DEFAULT 0;
	DECLARE v_month_of_delivery integer(11) DEFAULT 0;
	DECLARE v_year_of_delivery integer(11) DEFAULT 0;
	DECLARE v_pregs_infant_weight1 FLOAT;
	DECLARE v_pregs_infant_weight2 FLOAT;
	DECLARE v_pregs_infant_weight3 FLOAT;
	DECLARE v_pregs_infant_wt_date VARCHAR(10);
	DECLARE v_pregs_infant_weights VARCHAR(30);
	DECLARE v_pregs_infant_wt_this VARCHAR(200);
	DECLARE v_pregs_infant_wt_total VARCHAR(200);
	DECLARE v_pregs_stillbirth integer(11) DEFAULT 0;
	DECLARE v_pregs_nnd integer(11) DEFAULT 0;
	DECLARE v_id integer(11) DEFAULT 0;
	DECLARE v_pregnancy_course integer(11) DEFAULT 0;	
	DECLARE v_outcome_of_pregnancy integer(11) DEFAULT 0;
    DECLARE v_pregs_death_reason VARCHAR(200);
    DECLARE v_pregs_death_reason_this VARCHAR(200);	
    DECLARE v_pregs_death_reason_this_sum VARCHAR(200);
    DECLARE v_other_cause_death VARCHAR(200);
    DECLARE v_mode_of_delivery integer(11) DEFAULT 0;
    DECLARE v_pregs_cs integer(11) DEFAULT 0;
    DECLARE v_abruption TINYINT(4) DEFAULT 0;
    DECLARE v_abruption_this integer(11)  DEFAULT 0;	
   	DECLARE v_eclampsia TINYINT(4) DEFAULT 0;
   	DECLARE v_eclampsia_this TINYINT(1) DEFAULT 0;
	DECLARE v_pph TINYINT(4) DEFAULT 0;
	DECLARE v_pph_this TINYINT(1) DEFAULT 0;

	DECLARE preg_cur CURSOR FOR
	SELECT pregnancy_course_52, outcome_of_pregnancy_53, fe.enumeration AS pregs_death_reason,
    other_cause_death_55, mode_of_delivery_447, indication_CS_forcepts_60,
    month_of_delivery, year_of_delivery_51,
    FORMAT(birth_weight_infant1_65,2), FORMAT(birth_weight_infant_2_1244,2),
    FORMAT(birth_weight_infant_3_1245,2),
    eclampsia, pph
    FROM zeprs.prevpregnancies p
	LEFT JOIN zeprs.encounter e on e.id = p.id
	LEFT JOIN admin.field_enumeration fe on fe.id = p.if_died_before_5_years_54
	WHERE e.patient_id = in_patient_id
	ORDER BY year_of_delivery_51 DESC;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;	

	OPEN preg_cur;		
		preg_loop:LOOP
		FETCH preg_cur
        INTO v_pregnancy_course, v_outcome_of_pregnancy, v_pregs_death_reason_this,
        v_other_cause_death, v_mode_of_delivery, v_abruption_this,
        v_month_of_delivery, v_year_of_delivery,
        v_pregs_infant_weight1, v_pregs_infant_weight2, v_pregs_infant_weight3,
        v_eclampsia_this, v_pph_this;
          	
			IF v_done=1 THEN
				LEAVE preg_loop;
			END IF;	
			
			SET v_pregs = v_pregs + 1;
			
			CASE v_pregnancy_course
			     WHEN 20
			     THEN SET v_pregs_full = v_pregs_full + 1;
			     WHEN 554
			     THEN SET v_pregs_preterm = v_pregs_preterm + 1;
			     ELSE SET v_pregs_preterm=v_pregs_preterm;
            END CASE;
            
            CASE v_outcome_of_pregnancy
			     WHEN 555
			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;
			     WHEN 1083
			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;
		         WHEN 1411
			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;
		         WHEN 1647
			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;
			     
			     WHEN 1977
			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;
			     WHEN 2087
			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;
			     WHEN 2183
			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;
			     WHEN 2256
			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;
			     WHEN 2310
			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;
			     WHEN 2361
			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;
			     
			     ELSE SET v_pregs_stillbirth = v_pregs_stillbirth;
            END CASE;
            

			SET v_pregs_infant_wt_date = CONCAT_WS("/", v_month_of_delivery, v_year_of_delivery);
            SET v_pregs_infant_weights = CONCAT_WS(", ", v_pregs_infant_weight1, v_pregs_infant_weight2, v_pregs_infant_weight3);
            SET v_pregs_infant_wt_this = CONCAT_WS(":", v_pregs_infant_wt_date, v_pregs_infant_weights);
            IF v_pregs_infant_weights !="" THEN 	
            	SET v_pregs_infant_wt_total = CONCAT_WS("; ", v_pregs_infant_wt_total, v_pregs_infant_wt_this);	
			END IF;
			IF v_other_cause_death !="" THEN 	
            	SET v_pregs_death_reason_this_sum = CONCAT_WS("-", v_pregs_death_reason_this, v_other_cause_death);	
            	ELSE SET v_pregs_death_reason_this_sum = v_pregs_death_reason_this;	
			END IF;
			IF v_pregs_death_reason_this IS NOT NULL THEN
      			SET v_pregs_death_reason = CONCAT_WS("; ", v_pregs_death_reason, CONCAT_WS(":", v_pregs_infant_wt_date, v_pregs_death_reason_this_sum));
			END IF;
			IF v_mode_of_delivery = 792 THEN 	
            	SET v_pregs_cs = v_pregs_cs + 1;	
			END IF;
            IF v_abruption_this = 2400 THEN 	
            	SET v_abruption = 1;	
			END IF;
			IF v_eclampsia_this = 1 THEN 	
            	SET v_eclampsia = 1;	
			END IF;
			IF v_pph_this = 1 THEN 	
            	SET v_pph = 1;	
			END IF;
			
		END LOOP preg_loop;
	CLOSE preg_cur;
	SET v_done=0;
	SET out_pregs_infant_weight = v_pregs_infant_wt_total;	
	SET out_pregs = v_pregs;
	SET out_pregs_full = v_pregs_full;
    SET out_pregs_preterm = v_pregs_preterm;
	SET out_pregs_stillbirth = v_pregs_stillbirth;
	SET out_pregs_nnd = v_pregs_nnd;
	SET out_pregs_death_reason = v_pregs_death_reason;
	SET out_pregs_cs = v_pregs_cs;
	SET out_abruption = v_abruption;
	SET out_eclampsia = v_eclampsia;
	SET out_pph = v_pph;
	SET v_done=0;
END $$

DELIMITER ;
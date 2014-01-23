DELIMITER $$

DROP PROCEDURE IF EXISTS `zeports`.`sp_drugs_labs` $$
CREATE PROCEDURE `sp_drugs_labs`(IN in_patient_id BIGINT(20), OUT out_tt_card VARCHAR(255), OUT out_itn TINYINT(1), OUT out_rpr_done VARCHAR(255), OUT out_rpr_result VARCHAR(255), OUT out_rprTreatment VARCHAR(255), OUT out_rprComments VARCHAR(255), OUT out_hb1 VARCHAR(255), OUT out_hb2 VARCHAR(255), OUT out_lab_other VARCHAR(255), OUT out_hiv_test VARCHAR(255))
BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_num INT DEFAULT 0;
    DECLARE v_date_visit DATE default NULL;
    
    DECLARE v_tt_card  VARCHAR(255) DEFAULT NULL;
	DECLARE v_tt1_date DATE default NULL;
	DECLARE v_tt2_date DATE default NULL;
	DECLARE v_tt3_date DATE default NULL;
	DECLARE v_tt4_date DATE default NULL;
	DECLARE v_tt5_date DATE default NULL;
	DECLARE v_itn TINYINT(1) DEFAULT 0;
		
	DECLARE v_rpr_done VARCHAR(255) DEFAULT NULL;
	DECLARE v_rpr_date DATE DEFAULT NULL;
	DECLARE v_rprResult VARCHAR(50) DEFAULT NULL;
	DECLARE v_rprTreatmentDate DATE DEFAULT NULL;
    DECLARE v_rprTreatment VARCHAR(255) DEFAULT NULL;	
	DECLARE v_rprDrug VARCHAR(50) DEFAULT NULL;
    DECLARE v_rprDosage FLOAT DEFAULT NULL;
    DECLARE v_rprComments VARCHAR(255) DEFAULT NULL;
    
    DECLARE v_rpr_done_this VARCHAR(255) DEFAULT NULL;
    DECLARE v_rpr_date_this DATE DEFAULT NULL;
	DECLARE v_rprResult_this VARCHAR(50) DEFAULT NULL;
	DECLARE v_rprTreatmentDate_this DATE DEFAULT NULL;	
	DECLARE v_rprTreatment_this VARCHAR(255) DEFAULT NULL;
	DECLARE v_rprDrug_this VARCHAR(50) DEFAULT NULL;
    DECLARE v_rprDosage_this FLOAT DEFAULT NULL;
    DECLARE v_rprComments_this VARCHAR(255) DEFAULT NULL;
    

    DECLARE v_datelabrequest DATE DEFAULT NULL;
    DECLARE v_labType VARCHAR(50) DEFAULT NULL;
    DECLARE v_datelabresults DATE DEFAULT NULL;
    DECLARE v_labResults VARCHAR(50) DEFAULT NULL;
    DECLARE v_resultsnumeric FLOAT DEFAULT NULL;
    DECLARE v_labResultsOther VARCHAR(255) DEFAULT NULL;
    
    DECLARE v_datelabrequest_this DATE DEFAULT NULL;
    DECLARE v_labType_this VARCHAR(50) DEFAULT NULL;
    DECLARE v_datelabresults_this DATE DEFAULT NULL;
    DECLARE v_labResults_this VARCHAR(50) DEFAULT NULL;
    DECLARE v_resultsnumeric_this FLOAT DEFAULT NULL;
    DECLARE v_labResultsOther_this VARCHAR(255) DEFAULT NULL;
    DECLARE v_labResultsConcat VARCHAR(50) DEFAULT NULL;

    DECLARE v_hiv_test  VARCHAR(255) DEFAULT NULL;
    DECLARE v_hiv_testdate_this DATE DEFAULT NULL;
    DECLARE v_hiv_result_this VARCHAR(50) DEFAULT NULL;
	
	DECLARE safemotherhoodCursor CURSOR FOR
	SELECT date_visit, tt1_110, tt2_111, tt3_112, tt4_113, tt5_114, patient_sleep_ITN
    FROM zeprs.safemotherhoodcare s
	LEFT JOIN zeprs.encounter e on e.id = s.id
	WHERE e.patient_id = in_patient_id
    ORDER BY date_visit ASC;
    
    DECLARE rprCursor CURSOR FOR
	SELECT date_visit, rpr_date, fe1.enumeration AS rprResult, rpr_treatment_date,
    fe2.enumeration AS rprDrug, rpr_dosage, rpr_comments
    FROM zeprs.rpr r
	LEFT JOIN zeprs.encounter e on e.id = r.id
	LEFT JOIN admin.field_enumeration fe1 on fe1.id = r.rpr_result
	LEFT JOIN admin.field_enumeration fe2 on fe2.id = r.rpr_drug
	WHERE e.patient_id = in_patient_id
    ORDER BY rpr_date ASC;
    
    DECLARE labCursor CURSOR FOR
	SELECT date_visit, datelabrequest, fe1.enumeration AS labType, datelabresults,
    fe2.enumeration AS labResults, resultsnumeric
    FROM zeprs.labtest l
	LEFT JOIN zeprs.encounter e on e.id = l.id
	LEFT JOIN admin.field_enumeration fe1 on fe1.id = l.labtype
	LEFT JOIN admin.field_enumeration fe2 on fe2.id = l.results
	WHERE e.patient_id = in_patient_id
    ORDER BY datelabrequest ASC;
    
    DECLARE hivCursor CURSOR FOR
	SELECT date_visit, testdate, fe1.enumeration AS result
    FROM zeprs.smcounselingvisit c
	LEFT JOIN zeprs.encounter e on e.id = c.id
	LEFT JOIN admin.field_enumeration fe1 on fe1.id = c.hiv_test_result
	WHERE e.patient_id = in_patient_id
    ORDER BY testdate ASC;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;	

	OPEN safemotherhoodCursor;		
		safemotherhoodLoop:LOOP
		FETCH safemotherhoodCursor
        INTO v_date_visit, v_rpr_date, v_tt2_date, v_tt3_date, v_tt4_date, v_tt5_date,
        v_itn;
        IF v_done=1 THEN
		   LEAVE safemotherhoodLoop;
		END IF;				
		END LOOP safemotherhoodLoop;
	SET out_tt_card = CONCAT_WS(", ", v_tt1_date, v_tt2_date, v_tt3_date, v_tt4_date, v_tt5_date);	
	SET out_itn = v_itn;
	CLOSE safemotherhoodCursor;		
	SET v_done=0;
	
	OPEN rprCursor;		
		rprLoop:LOOP
		FETCH rprCursor
        INTO v_date_visit, v_rpr_date_this, v_rprResult_this, v_rprTreatmentDate_this,
        v_rprDrug_this, v_rprDosage_this, v_rprComments_this;
        IF v_done=1 THEN
		   LEAVE rprLoop;
		END IF;			

        SET v_rpr_done_this = CONCAT_WS(":", v_rpr_date_this,v_rprResult_this);
        SET v_rpr_done = CONCAT_WS(",",v_rpr_done, v_rpr_done_this);
        SET v_rprResult = CONCAT_WS(",",v_rprResult, v_rprResult_this);	
        
        SET v_rprComments = CONCAT_WS(",", v_rprComments,CONCAT_WS(":", v_rpr_date_this,v_rprComments_this));
        SET v_rprTreatment_this = CONCAT_WS(":", v_rprTreatmentDate_this,CONCAT(v_rprDrug_this, ", dosage - ", v_rprDosage_this));
        SET v_rprTreatment = CONCAT_WS(",", v_rprTreatment,v_rprTreatment_this);
        
		END LOOP rprLoop;
        SET out_rpr_done = v_rpr_done;
        SET out_rpr_result = v_rprResult;
        SET out_rprComments = v_rprComments;
        SET out_rprTreatment = v_rprTreatment;
	CLOSE rprCursor;		
	SET v_done=0;
	
	OPEN labCursor;		
		labLoop:LOOP
		FETCH labCursor
        INTO v_date_visit, v_datelabrequest_this, v_labType_this, v_datelabresults_this,
        v_labResults_this, v_resultsnumeric_this;
        IF v_done=1 THEN
		   LEAVE labLoop;
		END IF;	

        IF v_labResults_this IS NOT NULL THEN
           SET v_labResults = v_labResults_this;
        ELSE
           SET v_labResults = v_resultsnumeric_this;
        END IF;	

        IF v_labType_this = "Hb - 1st screen" THEN
           SET out_hb1 = CONCAT_WS(":", v_datelabresults_this, 	v_resultsnumeric_this);
        ELSEIF v_labType_this = "Hb - 2nd screen" THEN
           SET out_hb2 = CONCAT_WS(":", v_datelabresults_this, 	v_resultsnumeric_this);
        ELSE
           SET v_labResultsOther_this = CONCAT_WS(":", v_datelabresults_this, 	CONCAT_WS("-",v_labType_this, v_labResults));
           SET v_labResultsOther = CONCAT_WS(",", v_labResultsOther, v_labResultsOther_this);
        END IF;

		END LOOP labLoop;
        SET out_lab_other = v_labResultsOther;
	CLOSE labCursor;		
	SET v_done=0;

    OPEN hivCursor;		
		hivLoop:LOOP
		FETCH hivCursor
        INTO v_date_visit, v_hiv_testdate_this, v_hiv_result_this;
        IF v_done=1 THEN
		   LEAVE hivLoop;
		END IF;	
        SET v_hiv_test = CONCAT_WS(",", v_hiv_test, CONCAT_WS(":",v_hiv_testdate_this, v_hiv_result_this));

		END LOOP hivLoop;
        SET out_hiv_test = v_hiv_test;
	CLOSE hivCursor;		
	SET v_done=0;
		
END $$

DELIMITER ;
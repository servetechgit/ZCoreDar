DELIMITER $$

DROP PROCEDURE IF EXISTS `zeports`.`sp_copy_demographics` $$
CREATE PROCEDURE `sp_copy_demographics`()
INSERT INTO demographics
	SELECT en.id AS id,
	pr.surname_6 AS surname,
	pr.forenames_7 AS forenames,
	c.name AS sex,
	pr.nrc_no_9 AS nrc_no,
	pr.obstetric_record_number_1134 AS bluebook_no,
	pr.firm AS firm,
	pr.district_pat_13 AS district_id,
	pr.new_patient_site_id AS new_pa_site_id,
	pr.patient_id_number AS zeprsId,
	pr.age_at_first_attendence_1135 AS age_at_first_attendence,
	pr.birth_date_17 AS birth_date,
	b.enumeration AS education_status,
	pr.residential_19 AS address1, pr.residential_20 AS address2,
	pr.date_of_resi_21 AS residence_changed,
	a.enumeration AS marital_status,
	d.enumeration AS occupation,
	pr.occupation_other AS occupation_other,
	pr.nearby_place_worship_39 AS nearby_place_worship,
	f.enumeration AS religion,
	pr.religion_other_1240 AS religion_other,
	pr.surname_p_father_24 AS surname_p_father,
	pr.forenames_p_father_25 AS forenames_p_father,
	pr.surname_husband_26 AS surname_husband,
	pr.forenames_husband_27 AS forenames_husband,
	e.enumeration AS occupation_husband,
	pr.tel_no_husband_32 AS tel_no_husband,
	pr.surname_guardian_33 AS surname_guardian,
	pr.forenames_guardian_34 AS forenames_guardian,
	pr.surname_emerg_contact_35 AS surname_emerg_contact,
	pr.forenames_emerg_contact_36 AS forenames_emerg_contact,
	pr.address_emerg_contact_37 AS address_emerg_contact,
	pr.tel_no_emerg_contact_38 AS tel_no_emerg_contact,
	pa.parent_id AS parent_id,
	en.patient_id AS patient_id,
	en.site_id AS site_id,
	en.date_visit AS dateVisit,
	en.created AS created,
	en.last_modified AS lastModified
	FROM zeprs.patientregistration pr
	LEFT JOIN zeprs.encounter en ON en.id = pr.id
	LEFT JOIN zeprs.patient pa ON pa.id = en.patient_id
	LEFT JOIN  admin.field_enumeration a ON a.id = pr.marital_stat_10
	LEFT JOIN  admin.field_enumeration b ON b.id = pr.education_st_11
	LEFT JOIN  admin.sex c ON c.id = pr.sex_490
	LEFT JOIN  admin.field_enumeration d ON d.id = pr.occupation_12
	LEFT JOIN  admin.field_enumeration e ON e.id = pr.occupation_husband_28
	LEFT JOIN  admin.field_enumeration f ON f.id = pr.religion_1239 $$

DELIMITER ;
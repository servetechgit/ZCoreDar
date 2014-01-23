SET FOREIGN_KEY_CHECKS = 0;

-- MySQL dump 10.9
--
-- Host: localhost    Database: zeports
-- ------------------------------------------------------
-- Server version	5.0.16-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;

--
-- Table structure for table `demographics`
--

DROP TABLE IF EXISTS `demographics`;
CREATE TABLE `demographics` (
  `id` bigint(20) NOT NULL default '0',
  `surname` varchar(255) default NULL,
  `forenames` varchar(255) default NULL,
  `sex` varchar(10) default NULL,
  `nrc_no` varchar(255) default NULL,
  `bluebook_no` varchar(255) default NULL,
  `firm` varchar(255) default NULL,
  `district_id` varchar(255) default NULL,
  `new_patient_site_id` varchar(255) default NULL,
  `zeprsId` varchar(255) default NULL,
  `age_at_first_attendence` int(11) default NULL,
  `birth_date` date default NULL,
  `education_status` varchar(50) default NULL,
  `address1` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `residence_changed` date default NULL,
  `marital_status` varchar(20) default NULL,
  `occupation` varchar(30) default NULL,
  `occupation_other` varchar(255) default NULL,
  `nearby_place_worship` varchar(255) default NULL,
  `religion` varchar(30) default NULL,
  `religion_other` text,
  `surname_p_father` varchar(255) default NULL,
  `forenames_p_father` varchar(255) default NULL,
  `surname_husband` varchar(255) default NULL,
  `forenames_husband` varchar(255) default NULL,
  `occupation_husband` varchar(30) default NULL,
  `tel_no_husband` varchar(255) default NULL,
  `surname_guardian` varchar(255) default NULL,
  `forenames_guardian` varchar(255) default NULL,
  `surname_emerg_contact` varchar(255) default NULL,
  `forenames_emerg_contact` varchar(255) default NULL,
  `address_emerg_contact` varchar(255) default NULL,
  `tel_no_emerg_contact` varchar(255) default NULL,
  `parent_id` bigint(20) default NULL,
  `patient_id` bigint(20) default NULL,
  `site_id` bigint(20) default NULL,
  `date_visit` date default NULL,
  `created` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `INX_patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `patient_id` bigint(20) NOT NULL,
  `pregs_prev` int(11) default NULL,
  `pregs_full_term` int(11) default NULL,
  `pregs_preterm` int(11) default NULL,
  `pregs_infant_weights` varchar(200) default NULL,
  `pregs_stillbirth` int(11) default NULL,
  `pregs_nnd` int(11) default NULL,
  `pregs_death_reason` varchar(255) default NULL,
  `pregs_cs` tinyint(4) default NULL,
  `abruption` tinyint(4) default NULL,
  `eclampsia` tinyint(4) default NULL,
  `pph` tinyint(4) default NULL,
  `gestational_diabetes` tinyint(4) default NULL,
  `diabetes` tinyint(4) default NULL,
  `chronic_htn` tinyint(4) default NULL,
  `tuberculosis` tinyint(4) default NULL,
  `hiv_diag` tinyint(4) default NULL,
  `syphilis` tinyint(4) default NULL,
  `hepatitis_b_carrier` tinyint(4) default NULL,
  PRIMARY KEY  (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- MySQL dump 10.9
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	5.0.16-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
CREATE TABLE `columns_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Table_name` char(64) collate utf8_bin NOT NULL default '',
  `Column_name` char(64) collate utf8_bin NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') character set utf8 NOT NULL default '',
  PRIMARY KEY  (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column privileges';

--
-- Dumping data for table `columns_priv`
--


/*!40000 ALTER TABLE `columns_priv` DISABLE KEYS */;
LOCK TABLES `columns_priv` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `columns_priv` ENABLE KEYS */;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
CREATE TABLE `db` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_view_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Show_view_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Create_routine_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Alter_routine_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Execute_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  PRIMARY KEY  (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database privileges';

--
-- Dumping data for table `db`
--


/*!40000 ALTER TABLE `db` DISABLE KEYS */;
LOCK TABLES `db` WRITE;
INSERT INTO `db` VALUES ('localhost','zeprs','zeprs_web_user','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N'),('localhost','zeprsdemo','zeprs_demo_user','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N'),('%','proto','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','proto','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost.localdomain','proto','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','spring','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','spring','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost.localdomain','spring','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','mydb','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','mydb','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost.localdomain','mydb','test','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y');
UNLOCK TABLES;
/*!40000 ALTER TABLE `db` ENABLE KEYS */;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
CREATE TABLE `func` (
  `name` char(64) collate utf8_bin NOT NULL default '',
  `ret` tinyint(1) NOT NULL default '0',
  `dl` char(128) collate utf8_bin NOT NULL default '',
  `type` enum('function','aggregate') character set utf8 NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User defined functions';

--
-- Dumping data for table `func`
--


/*!40000 ALTER TABLE `func` DISABLE KEYS */;
LOCK TABLES `func` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `func` ENABLE KEYS */;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned default NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY  (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help categories';

--
-- Dumping data for table `help_category`
--


/*!40000 ALTER TABLE `help_category` DISABLE KEYS */;
LOCK TABLES `help_category` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_category` ENABLE KEYS */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY  (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help keywords';

--
-- Dumping data for table `help_keyword`
--


/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
LOCK TABLES `help_keyword` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`help_keyword_id`,`help_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='keyword-topic relation';

--
-- Dumping data for table `help_relation`
--


/*!40000 ALTER TABLE `help_relation` DISABLE KEYS */;
LOCK TABLES `help_relation` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_relation` ENABLE KEYS */;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY  (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help topics';

--
-- Dumping data for table `help_topic`
--


/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
LOCK TABLES `help_topic` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
CREATE TABLE `host` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_view_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Show_view_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Create_routine_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Alter_routine_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Execute_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  PRIMARY KEY  (`Host`,`Db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Host privileges;  Merged with database privileges';

--
-- Dumping data for table `host`
--


/*!40000 ALTER TABLE `host` DISABLE KEYS */;
LOCK TABLES `host` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `host` ENABLE KEYS */;

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
CREATE TABLE `proc` (
  `db` char(64) character set utf8 collate utf8_bin NOT NULL default '',
  `name` char(64) NOT NULL default '',
  `type` enum('FUNCTION','PROCEDURE') NOT NULL,
  `specific_name` char(64) NOT NULL default '',
  `language` enum('SQL') NOT NULL default 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL default 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL default 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL default 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` char(64) NOT NULL default '',
  `body` longblob NOT NULL,
  `definer` char(77) character set utf8 collate utf8_bin NOT NULL default '',
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL default '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE') NOT NULL default '',
  `comment` char(64) character set utf8 collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`db`,`name`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stored Procedures';

--
-- Dumping data for table `proc`
--


/*!40000 ALTER TABLE `proc` DISABLE KEYS */;
LOCK TABLES `proc` WRITE;
INSERT INTO `proc` VALUES ('zeprs','HelloWorld','PROCEDURE','HelloWorld','SQL','CONTAINS_SQL','NO','DEFINER','','','BEGIN\n     SELECT \"Hello World!\";\nEND','root@localhost','2006-05-29 18:13:18','2006-05-29 18:13:18','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeprs','prevproc','PROCEDURE','prevproc','SQL','CONTAINS_SQL','NO','DEFINER','','','BEGIN\n	DECLARE done INT DEFAULT 0;\n	DECLARE patientId bigint(20);\n	DECLARE pregs integer(11);\n	DECLARE pregsFull integer(11);\n	DECLARE cur1 CURSOR FOR\n	SELECT patient_id\n	FROM demographics;\n	\n	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;\n	\n	OPEN cur1;\n	FETCH cur1 INTO patientId;\n	pat_loop:LOOP\n    IF done=1 THEN\n		LEAVE pat_loop;\n	END IF;	\n	CALL pregs_cnt(patientId, pregs);\n	CALL pregs_full(patientId, pregsFull);\n	INSERT INTO history (patient_id, pregs_prev, pregs_full_term) VALUES (patientId,pregs, pregsFull);	\n	FETCH cur1 INTO patientId;\n	END LOOP pat_loop;\n	CLOSE cur1;\nEND','root@localhost','2006-05-29 19:55:45','2006-05-29 19:55:45','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeprs','pregs_cnt','PROCEDURE','pregs_cnt','SQL','CONTAINS_SQL','NO','DEFINER','in_patient_id BIGINT(20), OUT out_pregs INTEGER(11)','','BEGIN\n     DECLARE pregs integer(11);\n     SELECT COUNT(p.id) INTO pregs from prevpregnancies p\n     LEFT JOIN encounter e on e.id = p.id\n     WHERE e.patient_id = in_patient_id;\n     \n     SET out_pregs = pregs;\nEND','root@localhost','2006-05-29 19:17:51','2006-05-29 19:17:51','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeprs','sp_delete_history','PROCEDURE','sp_delete_history','SQL','CONTAINS_SQL','NO','DEFINER','','','BEGIN\n     delete from history;\nEND','root@localhost','2006-05-29 19:39:27','2006-05-29 19:39:27','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeprs','pregs_full','PROCEDURE','pregs_full','SQL','CONTAINS_SQL','NO','DEFINER','in_patient_id BIGINT(20), OUT out_pregs INTEGER(11)','','BEGIN\n     DECLARE pregs integer(11);\n     SELECT COUNT(p.id) INTO pregs from prevpregnancies p\n     LEFT JOIN encounter e on e.id = p.id\n     WHERE p.pregnancy_course_52 = 20\n     AND e.patient_id = in_patient_id;\n     \n     SET out_pregs = pregs;\nEND','root@localhost','2006-05-29 19:53:14','2006-05-29 19:53:14','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeports','sp_delete_history','PROCEDURE','sp_delete_history','SQL','CONTAINS_SQL','NO','DEFINER','','','BEGIN\n     delete from history;\nEND','root@localhost','2006-05-31 14:13:10','2006-05-31 14:13:10','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeports','sp_copy_demographics','PROCEDURE','sp_copy_demographics','SQL','CONTAINS_SQL','NO','DEFINER','','','INSERT INTO demographics\n	SELECT en.id AS id,\n	pr.surname_6 AS surname,\n	pr.forenames_7 AS forenames,\n	c.name AS sex,\n	pr.nrc_no_9 AS nrc_no,\n	pr.obstetric_record_number_1134 AS bluebook_no,\n	pr.firm AS firm,\n	pr.district_pat_13 AS district_id,\n	pr.new_patient_site_id AS new_pa_site_id,\n	pr.patient_id_number AS zeprsId,\n	pr.age_at_first_attendence_1135 AS age_at_first_attendence,\n	pr.birth_date_17 AS birth_date,\n	b.enumeration AS education_status,\n	pr.residential_19 AS address1, pr.residential_20 AS address2,\n	pr.date_of_resi_21 AS residence_changed,\n	a.enumeration AS marital_status,\n	d.enumeration AS occupation,\n	pr.occupation_other AS occupation_other,\n	pr.nearby_place_worship_39 AS nearby_place_worship,\n	f.enumeration AS religion,\n	pr.religion_other_1240 AS religion_other,\n	pr.surname_p_father_24 AS surname_p_father,\n	pr.forenames_p_father_25 AS forenames_p_father,\n	pr.surname_husband_26 AS surname_husband,\n	pr.forenames_husband_27 AS forenames_husband,\n	e.enumeration AS occupation_husband,\n	pr.tel_no_husband_32 AS tel_no_husband,\n	pr.surname_guardian_33 AS surname_guardian,\n	pr.forenames_guardian_34 AS forenames_guardian,\n	pr.surname_emerg_contact_35 AS surname_emerg_contact,\n	pr.forenames_emerg_contact_36 AS forenames_emerg_contact,\n	pr.address_emerg_contact_37 AS address_emerg_contact,\n	pr.tel_no_emerg_contact_38 AS tel_no_emerg_contact,\n	pa.parent_id AS parent_id,\n	en.patient_id AS patient_id,\n	en.site_id AS site_id,\n	en.date_visit AS dateVisit,\n	en.created AS created,\n	en.last_modified AS lastModified\n	FROM zeprs.patientregistration pr\n	LEFT JOIN zeprs.encounter en ON en.id = pr.id\n	LEFT JOIN zeprs.patient pa ON pa.id = en.patient_id\n	LEFT JOIN  admin.field_enumeration a ON a.id = pr.marital_stat_10\n	LEFT JOIN  admin.field_enumeration b ON b.id = pr.education_st_11\n	LEFT JOIN  admin.sex c ON c.id = pr.sex_490\n	LEFT JOIN  admin.field_enumeration d ON d.id = pr.occupation_12\n	LEFT JOIN  admin.field_enumeration e ON e.id = pr.occupation_husband_28\n	LEFT JOIN  admin.field_enumeration f ON f.id = pr.religion_1239','root@localhost','2006-05-30 10:57:13','2006-05-30 10:57:13','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeports','sp_build_history','PROCEDURE','sp_build_history','SQL','CONTAINS_SQL','NO','DEFINER','','','BEGIN\n    \n	DECLARE v_done INT DEFAULT 0;\n	DECLARE v_patientId bigint(20);\n	DECLARE v_pregs integer(11);\n	DECLARE v_pregsFull integer(11);\n	DECLARE v_pregsPreterm integer(11);\n	DECLARE v_pregsInfantWeight varchar(200);\n	DECLARE v_pregsStillbirth integer(11);\n	DECLARE v_pregsNnd integer(11);\n	DECLARE v_pregs_deathReason varchar(255);\n	DECLARE v_pregs_cs integer(11);\n	DECLARE v_abruption TINYINT(4);\n	DECLARE v_eclampsia TINYINT(4);\n	DECLARE v_pph TINYINT(4);\n	DECLARE v_gestational_diabetes TINYINT(4);\n	DECLARE v_diabetes TINYINT(4);\n	DECLARE v_chronic_htn TINYINT(4);\n	DECLARE v_tuberculosis TINYINT(4);\n	DECLARE v_hiv_diag TINYINT(4);\n	DECLARE v_syphilis TINYINT(4);\n	DECLARE v_hepatitis_b_carrier TINYINT(4);\n	\n	\n	DECLARE patient_cur CURSOR FOR\n	SELECT patient_id\n	FROM demographics;\n	\n	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;\n	\n	TRUNCATE history;\n	\n	START TRANSACTION;\n\n    OPEN patient_cur;\n	FETCH patient_cur INTO v_patientId;\n	pat_loop:LOOP\n                 IF v_done=1 THEN\n	             	LEAVE pat_loop;\n                 END IF;	\n	             CALL sp_pregs_cnt(v_patientId, v_pregs, v_pregsFull,\n                 v_pregsPreterm, v_pregsInfantWeight, v_pregsStillbirth,\n                 v_pregsNnd, v_pregs_deathReason, v_pregs_cs,\n                 v_abruption, v_eclampsia, v_pph,\n   v_gestational_diabetes, v_diabetes, v_chronic_htn, v_tuberculosis, v_hiv_diag,\n   v_syphilis, v_hepatitis_b_carrier);\n	\n   INSERT INTO history (patient_id, pregs_prev, pregs_full_term,\n   pregs_preterm,pregs_infant_weights, pregs_stillbirth, pregs_nnd,\n   pregs_death_reason, pregs_cs, abruption, eclampsia, pph, gestational_diabetes,\n   diabetes, chronic_htn, tuberculosis, hiv_diag, syphilis, hepatitis_b_carrier )\n   \n   VALUES (v_patientId, v_pregs, v_pregsFull, v_pregsPreterm,\n   LEFT(v_pregsInfantWeight,200), v_pregsStillbirth, v_pregsNnd,\n   LEFT(v_pregs_deathReason,255), v_pregs_cs, v_abruption, v_eclampsia, v_pph,\n   v_gestational_diabetes, v_diabetes, v_chronic_htn, v_tuberculosis, v_hiv_diag,\n   v_syphilis, v_hepatitis_b_carrier) ;	\n\n	       FETCH patient_cur INTO v_patientId;\n	END LOOP pat_loop;\n	\n	CLOSE patient_cur;\n	\n	COMMIT;\n	\n	select * from history;\n	FLUSH TABLES;\nEND','root@localhost','2006-06-01 20:04:42','2006-06-01 20:04:42','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER',''),('zeports','sp_pregs_cnt','PROCEDURE','sp_pregs_cnt','SQL','CONTAINS_SQL','NO','DEFINER','in_patient_id BIGINT(20), OUT out_pregs INTEGER(11), OUT out_pregs_full INTEGER(11), OUT out_pregs_preterm INTEGER(11), OUT out_pregs_infant_weight VARCHAR(200), OUT out_pregs_stillbirth INTEGER(11), OUT out_pregs_nnd INTEGER(11), OUT out_pregs_death_reason VARCHAR(200), OUT out_pregs_cs INTEGER(11), OUT out_abruption INTEGER(11), OUT out_eclampsia TINYINT(4), OUT out_pph TINYINT(4), OUT out_gestational_diabetes TINYINT(4), OUT out_diabetes TINYINT(4), OUT out_chronic_htn TINYINT(4), OUT out_tuberculosis TINYINT(4), OUT out_hiv_diag TINYINT(4), OUT out_syphilis TINYINT(4), OUT out_hepatitis_b_carrier TINYINT(4)','','BEGIN\n    DECLARE v_done INT DEFAULT 0;\n	DECLARE v_pregs integer(11) DEFAULT 0;\n	DECLARE v_pregs_full integer(11) DEFAULT 0;\n	DECLARE v_pregs_preterm integer(11) DEFAULT 0;\n	DECLARE v_month_of_delivery integer(11) DEFAULT 0;\n	DECLARE v_year_of_delivery integer(11) DEFAULT 0;\n	DECLARE v_pregs_infant_weight1 FLOAT;\n	DECLARE v_pregs_infant_weight2 FLOAT;\n	DECLARE v_pregs_infant_weight3 FLOAT;\n	DECLARE v_pregs_infant_wt_date VARCHAR(10);\n	DECLARE v_pregs_infant_weights VARCHAR(30);\n	DECLARE v_pregs_infant_wt_this VARCHAR(200);\n	DECLARE v_pregs_infant_wt_total VARCHAR(200);\n	DECLARE v_pregs_stillbirth integer(11) DEFAULT 0;\n	DECLARE v_pregs_nnd integer(11) DEFAULT 0;\n	DECLARE v_id integer(11) DEFAULT 0;\n	DECLARE v_pregnancy_course integer(11) DEFAULT 0;	\n	DECLARE v_outcome_of_pregnancy integer(11) DEFAULT 0;\n    DECLARE v_pregs_death_reason VARCHAR(200);\n    DECLARE v_pregs_death_reason_this VARCHAR(200);	\n    DECLARE v_pregs_death_reason_this_sum VARCHAR(200);\n    DECLARE v_other_cause_death VARCHAR(200);\n    DECLARE v_mode_of_delivery integer(11) DEFAULT 0;\n    DECLARE v_pregs_cs integer(11) DEFAULT 0;\n    DECLARE v_abruption TINYINT(4) DEFAULT 0;\n    DECLARE v_abruption_this integer(11)  DEFAULT 0;	\n   	DECLARE v_eclampsia TINYINT(4) DEFAULT 0;\n   	DECLARE v_eclampsia_this TINYINT(1) DEFAULT 0;\n	DECLARE v_pph TINYINT(4) DEFAULT 0;\n	DECLARE v_pph_this TINYINT(1) DEFAULT 0;\n	\n	DECLARE v_gestational_diabetes TINYINT(4) DEFAULT 0;\n	DECLARE v_diabetes TINYINT(4) DEFAULT 0;\n	DECLARE v_chronic_htn TINYINT(4) DEFAULT 0;\n	DECLARE v_tuberculosis TINYINT(4) DEFAULT 0;\n	DECLARE v_hiv_diag TINYINT(4) DEFAULT 0;\n	DECLARE v_syphilis TINYINT(4) DEFAULT 0;\n	DECLARE v_hepatitis_b_carrier TINYINT(4) DEFAULT 0;\n    \n	DECLARE preg_cur CURSOR FOR\n	SELECT pregnancy_course_52, outcome_of_pregnancy_53, fe.enumeration AS pregs_death_reason,\n    other_cause_death_55, mode_of_delivery_447, indication_CS_forcepts_60,\n    month_of_delivery, year_of_delivery_51,\n    FORMAT(birth_weight_infant1_65,2), FORMAT(birth_weight_infant_2_1244,2),\n    FORMAT(birth_weight_infant_3_1245,2),\n    eclampsia, pph\n    FROM zeprs.prevpregnancies p\n	LEFT JOIN zeprs.encounter e on e.id = p.id\n	LEFT JOIN admin.field_enumeration fe on fe.id = p.if_died_before_5_years_54\n	WHERE e.patient_id = in_patient_id\n	ORDER BY year_of_delivery_51 DESC;\n	\n	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;	\n\n	OPEN preg_cur;		\n		preg_loop:LOOP\n		FETCH preg_cur\n        INTO v_pregnancy_course, v_outcome_of_pregnancy, v_pregs_death_reason_this,\n        v_other_cause_death, v_mode_of_delivery, v_abruption_this,\n        v_month_of_delivery, v_year_of_delivery,\n        v_pregs_infant_weight1, v_pregs_infant_weight2, v_pregs_infant_weight3,\n        v_eclampsia_this, v_pph_this;\n          	\n			IF v_done=1 THEN\n				LEAVE preg_loop;\n			END IF;	\n			\n			SET v_pregs = v_pregs + 1;\n			\n			CASE v_pregnancy_course\n			     WHEN 20\n			     THEN SET v_pregs_full = v_pregs_full + 1;\n			     WHEN 554\n			     THEN SET v_pregs_preterm = v_pregs_preterm + 1;\n			     ELSE SET v_pregs_preterm=v_pregs_preterm;\n            END CASE;\n            \n            CASE v_outcome_of_pregnancy\n			     WHEN 555\n			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;\n			     WHEN 1083\n			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;\n		         WHEN 1411\n			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;\n		         WHEN 1647\n			     THEN SET v_pregs_stillbirth = v_pregs_stillbirth + 1;\n			     \n			     WHEN 1977\n			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;\n			     WHEN 2087\n			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;\n			     WHEN 2183\n			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;\n			     WHEN 2256\n			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;\n			     WHEN 2310\n			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;\n			     WHEN 2361\n			     THEN SET v_pregs_nnd = v_pregs_nnd + 1;\n			     \n			     ELSE SET v_pregs_stillbirth = v_pregs_stillbirth;\n            END CASE;\n            \n\n			SET v_pregs_infant_wt_date = CONCAT_WS(\"/\", v_month_of_delivery, v_year_of_delivery);\n            SET v_pregs_infant_weights = CONCAT_WS(\", \", v_pregs_infant_weight1, v_pregs_infant_weight2, v_pregs_infant_weight3);\n            SET v_pregs_infant_wt_this = CONCAT_WS(\":\", v_pregs_infant_wt_date, v_pregs_infant_weights);\n            IF v_pregs_infant_weights !=\"\" THEN 	\n            	SET v_pregs_infant_wt_total = CONCAT_WS(\"; \", v_pregs_infant_wt_total, v_pregs_infant_wt_this);	\n			END IF;\n			IF v_other_cause_death !=\"\" THEN 	\n            	SET v_pregs_death_reason_this_sum = CONCAT_WS(\"-\", v_pregs_death_reason_this, v_other_cause_death);	\n            	ELSE SET v_pregs_death_reason_this_sum = v_pregs_death_reason_this;	\n			END IF;\n			IF v_pregs_death_reason_this IS NOT NULL THEN\n      			SET v_pregs_death_reason = CONCAT_WS(\"; \", v_pregs_death_reason, CONCAT_WS(\":\", v_pregs_infant_wt_date, v_pregs_death_reason_this_sum));\n			END IF;\n			IF v_mode_of_delivery = 792 THEN 	\n            	SET v_pregs_cs = v_pregs_cs + 1;	\n			END IF;\n            IF v_abruption_this = 2400 THEN 	\n            	SET v_abruption = 1;	\n			END IF;\n			IF v_eclampsia_this = 1 THEN 	\n            	SET v_eclampsia = 1;	\n			END IF;\n			IF v_pph_this = 1 THEN 	\n            	SET v_pph = 1;	\n			END IF;\n			\n		END LOOP preg_loop;\n	CLOSE preg_cur;\n	SET v_done=0;\n	SET out_pregs_infant_weight = v_pregs_infant_wt_total;	\n	SET out_pregs = v_pregs;\n	SET out_pregs_full = v_pregs_full;\n    SET out_pregs_preterm = v_pregs_preterm;\n	SET out_pregs_stillbirth = v_pregs_stillbirth;\n	SET out_pregs_nnd = v_pregs_nnd;\n	SET out_pregs_death_reason = v_pregs_death_reason;\n	SET out_pregs_cs = v_pregs_cs;\n	SET out_abruption = v_abruption;\n	SET out_eclampsia = v_eclampsia;\n	SET out_pph = v_pph;\n	SET v_done=0;\nEND','root@localhost','2006-06-01 20:20:18','2006-06-01 20:20:18','STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER','');
UNLOCK TABLES;
/*!40000 ALTER TABLE `proc` ENABLE KEYS */;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
CREATE TABLE `procs_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Routine_name` char(64) collate utf8_bin NOT NULL default '',
  `Routine_type` enum('FUNCTION','PROCEDURE') collate utf8_bin NOT NULL,
  `Grantor` char(77) collate utf8_bin NOT NULL default '',
  `Proc_priv` set('Execute','Alter Routine','Grant') character set utf8 NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Procedure privileges';

--
-- Dumping data for table `procs_priv`
--


/*!40000 ALTER TABLE `procs_priv` DISABLE KEYS */;
LOCK TABLES `procs_priv` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `procs_priv` ENABLE KEYS */;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
CREATE TABLE `tables_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Table_name` char(64) collate utf8_bin NOT NULL default '',
  `Grantor` char(77) collate utf8_bin NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view') character set utf8 NOT NULL default '',
  `Column_priv` set('Select','Insert','Update','References') character set utf8 NOT NULL default '',
  PRIMARY KEY  (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table privileges';

--
-- Dumping data for table `tables_priv`
--


/*!40000 ALTER TABLE `tables_priv` DISABLE KEYS */;
LOCK TABLES `tables_priv` WRITE;
INSERT INTO `tables_priv` VALUES ('localhost','zeprs','zeprs_web_user','encounter_value','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','rule_definition_param','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','field_enumeration','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','page_item','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','client_setting','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','mail','zeprs_web_user','accountuser','root@localhost','2005-12-13 15:17:30','Select',''),('localhost','userdata','zeprs_web_user','address','root@localhost','2005-12-13 15:17:30','Select',''),('localhost','zeprs','zeprs_web_user','patient_status','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','patientregistration','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','newborneval','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','encounter','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','patient','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','zeprs','zeprs_web_user','ultrasoundfetuseval','root@localhost','2005-12-13 15:17:30','Delete',''),('localhost','admin','zeprs_web_user','form','root@localhost','2006-02-08 21:01:11','Select',''),('localhost','zeprsdemo','zeprs_demo_user','encounter_value','root@localhost','2006-02-09 11:48:13','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','rule_definition_param','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','field_enumeration','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','page_item','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','client_setting','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','mail','zeprs_demo_user','accountuser','root@localhost','2006-02-09 11:48:14','Select',''),('localhost','userdata','zeprs_demo_user','address','root@localhost','2006-02-09 11:48:14','Select',''),('localhost','zeprsdemo','zeprs_demo_user','patient_status','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','patientregistration','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','newborneval','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','encounter','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','patient','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','zeprsdemo','zeprs_demo_user','ultrasoundfetuseval','root@localhost','2006-02-09 11:48:14','Delete',''),('localhost','admin','zeprs_demo_user','form','root@localhost','2006-02-09 11:48:14','Select','');
UNLOCK TABLES;
/*!40000 ALTER TABLE `tables_priv` ENABLE KEYS */;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL auto_increment,
  `Use_leap_seconds` enum('Y','N') NOT NULL default 'N',
  PRIMARY KEY  (`Time_zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zones';

--
-- Dumping data for table `time_zone`
--


/*!40000 ALTER TABLE `time_zone` DISABLE KEYS */;
LOCK TABLES `time_zone` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone` ENABLE KEYS */;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY  (`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Leap seconds information for time zones';

--
-- Dumping data for table `time_zone_leap_second`
--


/*!40000 ALTER TABLE `time_zone_leap_second` DISABLE KEYS */;
LOCK TABLES `time_zone_leap_second` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_leap_second` ENABLE KEYS */;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone names';

--
-- Dumping data for table `time_zone_name`
--


/*!40000 ALTER TABLE `time_zone_name` DISABLE KEYS */;
LOCK TABLES `time_zone_name` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_name` ENABLE KEYS */;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`Time_zone_id`,`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transitions';

--
-- Dumping data for table `time_zone_transition`
--


/*!40000 ALTER TABLE `time_zone_transition` DISABLE KEYS */;
LOCK TABLES `time_zone_transition` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_transition` ENABLE KEYS */;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL default '0',
  `Is_DST` tinyint(3) unsigned NOT NULL default '0',
  `Abbreviation` char(8) NOT NULL default '',
  PRIMARY KEY  (`Time_zone_id`,`Transition_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transition types';

--
-- Dumping data for table `time_zone_transition_type`
--


/*!40000 ALTER TABLE `time_zone_transition_type` DISABLE KEYS */;
LOCK TABLES `time_zone_transition_type` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `time_zone_transition_type` ENABLE KEYS */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Password` char(41) character set latin1 collate latin1_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Reload_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Shutdown_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Process_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `File_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Show_db_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Super_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Execute_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Repl_slave_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Repl_client_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_view_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Show_view_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Create_routine_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Alter_routine_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `Create_user_priv` enum('N','Y') collate utf8_bin NOT NULL default 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') character set utf8 NOT NULL default '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int(11) unsigned NOT NULL default '0',
  `max_updates` int(11) unsigned NOT NULL default '0',
  `max_connections` int(11) unsigned NOT NULL default '0',
  `max_user_connections` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Host`,`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and global privileges';

--
-- Dumping data for table `user`
--


/*!40000 ALTER TABLE `user` DISABLE KEYS */;
LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES ('localhost','root','*806E3E04A7C1F5DF544D3451E43E0663B82B27C6','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),('localhost','zeprs_web_user','*ECE0031EC70D5C3BDF44A52599AA4A8A2024C666','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','zeprs_demo_user','*BE7FF3AEDF3AD523EF390BE21414D55211FEFDB2','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('%','test','*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','test','*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost.localdomain','test','*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','app','*5BCB3E6AC345B435C7C2E6B7949A04CE6F6563D3','Y','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- MySQL dump 10.9
--
-- Host: localhost    Database: mail
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
-- Table structure for table `account_permissions`
--

DROP TABLE IF EXISTS `account_permissions`;
CREATE TABLE `account_permissions` (
  `pa_id` int(11) NOT NULL auto_increment,
  `pa_role_name_fk` int(11) NOT NULL default '0',
  `pa_username_fk` varchar(50) NOT NULL default '',
  `pa_ap_id_fk` int(11) NOT NULL default '0',
  PRIMARY KEY  (`pa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account_permissions`
--


/*!40000 ALTER TABLE `account_permissions` DISABLE KEYS */;
LOCK TABLES `account_permissions` WRITE;
INSERT INTO `account_permissions` VALUES (1,3,'cekelley01',2),(2,3,'',2),(3,3,'luser',2),(4,3,'demo',2),(5,3,'reports',2),(6,3,'clinic',2),(7,3,'zepadmin',2),(8,3,'pchansa',2),(9,3,'viewall',2);
UNLOCK TABLES;
/*!40000 ALTER TABLE `account_permissions` ENABLE KEYS */;

--
-- Table structure for table `accountuser`
--

DROP TABLE IF EXISTS `accountuser`;
CREATE TABLE `accountuser` (
  `username` varchar(50) NOT NULL default '',
  `password` varchar(50) NOT NULL default '',
  `prefix` varchar(50) NOT NULL default '',
  `domain_name` varchar(255) NOT NULL default '',
  `date_created` datetime NOT NULL default '2003-10-01 00:00:00',
  `date_passwd_changed` datetime NOT NULL default '0000-00-00 00:00:00',
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accountuser`
--


/*!40000 ALTER TABLE `accountuser` DISABLE KEYS */;
LOCK TABLES `accountuser` WRITE;
INSERT INTO `accountuser` VALUES ('','','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('cekelley01','*2D5FFCDE030104DEC52860DD8ABFC51023842EBF','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('clerk','*104BF372A8811A740A05CFD8D5A28C5919D09EC0','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('clinic','*0F83D5EC03A7EB58E5587C8804B3326542D77372','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('demo','*41BDDCB1E7FDB4CC929E949E0F5A5FBDB57E4EEA','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('hfusco','*08A5E049C7CA2A950CA1D9C997B5D85FD851615C','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('luser','','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('pchansa','*A74AE98EB6F97C5D1C4EF5AA43498AAE4CC2489F','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('reports','*7B2C7A6C42D4BFB4DE368A3343EE4605D4B23D8F','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('test1','','','','2003-10-01 00:00:00','0000-00-00 00:00:00'),('useradmin','*2C81EE70249C448EE49707C596D8AAF04D27E9C6','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('viewall','*ABDD0E349B19A5F259E90979A66553345B6010ED','','','2003-10-30 09:19:47','2003-10-30 09:19:47'),('zepadmin','*CCF40CD10EBDA66C9EFDB58ADD8E913A58606AAD','','','2003-10-30 09:19:47','2003-10-30 09:19:47');
UNLOCK TABLES;
/*!40000 ALTER TABLE `accountuser` ENABLE KEYS */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `firstname` varchar(50) NOT NULL default '',
  `nickname` varchar(50) NOT NULL default '',
  `lastname` varchar(50) NOT NULL default '',
  `email` varchar(50) NOT NULL default '',
  `label` varchar(50) NOT NULL default '',
  `owner` varchar(50) NOT NULL default '',
  `ad_phone` varchar(15) NOT NULL default '',
  `ad_mobile` varchar(15) NOT NULL default '',
  `ad_clinic_id_fk` int(11) NOT NULL default '0',
  `ad_sex` char(1) NOT NULL default '',
  `ad_marital_status_fk` int(11) NOT NULL default '0',
  `ad_job_title_fk` char(2) NOT NULL default '',
  `ad_reg_card` varchar(15) NOT NULL default '',
  `ad_MOH_file_num` varchar(15) NOT NULL default '',
  `ad_MC_num` varchar(15) NOT NULL default '',
  `ad_permissions_fk` char(2) NOT NULL default '3',
  `ad_man_num` varchar(30) NOT NULL default '',
  `ad_hobbies` varchar(200) NOT NULL default '',
  `ad_NCert_num` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--


/*!40000 ALTER TABLE `address` DISABLE KEYS */;
LOCK TABLES `address` WRITE;
INSERT INTO `address` VALUES ('Test','','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('Chris','cekelley01','Kelley','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('Clinic','clinic','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('Demo','demo','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('Local','luser','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('Chansa','pchansa','Patrick','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('Report','reports','Viewer','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('View','viewall','All','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking',''),('ZEPRS Admin','zepadmin','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
UNLOCK TABLES;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
CREATE TABLE `applications` (
  `ap_id` int(11) NOT NULL auto_increment,
  `ap_name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ap_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `applications`
--


/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
LOCK TABLES `applications` WRITE;
INSERT INTO `applications` VALUES (1,'referral'),(2,'zeprs');
UNLOCK TABLES;
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
CREATE TABLE `facilities` (
  `fa_clinic_id` int(100) NOT NULL auto_increment,
  `fa_institution` varchar(100) NOT NULL default '',
  `fa_description` varchar(100) NOT NULL default '',
  `fa_abreviation` varchar(10) NOT NULL default '',
  `fa_VOIP_phone` int(15) NOT NULL default '0',
  `fa_analogue_phone` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`fa_clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facilities`
--


/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
LOCK TABLES `facilities` WRITE;
INSERT INTO `facilities` VALUES (1,'Airport','Clinic not part of ZEPRS network','APT',555,'1111'),(2,'Bauleni','Clinic','BAU',5550,'22222'),(3,'Center for Infectious Disease Research Zambia','Research unit.','CIDRZ',555,'2222'),(4,'Central Board of Health','Health administrative unit.','CBoH',55550,'222'),(5,'Chainama','Clinic','CHH',55550,'2222'),(6,'Chainda','Clinic','CAD',5555,'22222'),(7,'Chawama','Clinic','CWM',11110,'2222'),(8,'Chazanga','Clinic','CZG',11110,'22222'),(9,'Chelstone','Clinic','CHL',222220,'2222'),(10,'Chilenje','Clinic','CLJ',0,''),(11,'Chipata','Clinic','CPT',0,''),(12,'Civic Centre','Clinic','CVC',0,''),(13,'George','Clinic','GOG',0,''),(14,'Kabwata','Clinic','KBT',0,''),(15,'Kalingalinga','Clinic','KAL',0,''),(16,'Kamwala','Clinic','KML',0,''),(17,'Kanyama','Clinic','KNY',0,''),(18,'Kaunda Square','Clinic','KSQ',0,''),(19,'Lilayi','Clinic','LLY',0,''),(20,'Lusaka Urban District Health Management Team','Health administrative unit.','LUDHMT',0,''),(21,'Makeni','Clinic','MKN',0,''),(22,'Mandevu','Clinic','MDV',0,''),(23,'Matero Main','Clinic','MTM',0,''),(24,'Matero Reference','Clinic','MTR',0,''),(25,'Mtendere','Clinic','MTD',0,''),(26,'Ng\'ombe','Clinic','NGO',0,''),(27,'Prison Chimbokaila (Kabwata Prisons)','Clinic not part of ZEPRS network','KBP',0,''),(28,'Prison Kamwala','Clinic not part of ZEPRS network','KMP',0,''),(29,'Railway','Clinic','RAI',0,''),(30,'  State Lodge','Clinic','STL',0,''),(31,'University Teaching Hospital Antenatal Clinic','UTH Clinic','UTHANC',0,''),(32,'University Teaching Hospital Neonatal Intensive Care Unit','UTH Clinic','UTHNICU',0,''),(33,'University Teaching Hospital Obstetrics Labour Ward','UTH Clinic','UTHOBW',0,''),(34,'University Teaching Hospital Paediatrics Nursery','UTH Clinic','UTHNUR',0,''),(35,'Zambia Electronic Perinatal Record System','ZEPRS System administrative unit.','ZEPRS',0,''),(36,'University of Alabama at Birmingham','Research Partner with CIDRZ','UAB',0,''),(37,'Research Triangle Institute','Project Developer','RTI',0,''),(38,'UTH-A BLOCK','UTH clinic','UTH-A BLOC',0,''),(39,'UTH-B BLOCK','UTH clinic','UTH-B BLOC',0,''),(40,'UTH-C BLOCK','UTH clinic','UTH-C BLOC',0,''),(41,'UTH-D BLOCK','UTH clinic','UTH-D BLOC',0,''),(42,'UTH-HIS','UTH clinic','UTH-HIS',0,''),(43,'UTH-PHASE V','UTH clinic','UTH-PHASE',0,'');
UNLOCK TABLES;
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;

--
-- Table structure for table `job_title`
--

DROP TABLE IF EXISTS `job_title`;
CREATE TABLE `job_title` (
  `jt_job_title_pk` int(11) NOT NULL auto_increment,
  `jt_job_title_name` varchar(100) NOT NULL default '',
  `jt_sort_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`jt_job_title_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job_title`
--


/*!40000 ALTER TABLE `job_title` DISABLE KEYS */;
LOCK TABLES `job_title` WRITE;
INSERT INTO `job_title` VALUES (1,'Registerred Nurse',5),(2,'Enrolled Nurse',6),(3,'User',8),(4,'Trainer',7),(5,'Doctor',1),(6,'Sister In Charge',2),(7,'Registerred Midwife',3),(8,'Enrolled Midwife',4),(9,'Registry Clerks',9),(10,'Nursing Assistant',10),(11,'HIS-Clerk',11);
UNLOCK TABLES;
/*!40000 ALTER TABLE `job_title` ENABLE KEYS */;

--
-- Table structure for table `marital_status`
--

DROP TABLE IF EXISTS `marital_status`;
CREATE TABLE `marital_status` (
  `ms_marital_status_pk` int(11) NOT NULL auto_increment,
  `ms_marital_status_name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`ms_marital_status_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `marital_status`
--


/*!40000 ALTER TABLE `marital_status` DISABLE KEYS */;
LOCK TABLES `marital_status` WRITE;
INSERT INTO `marital_status` VALUES (1,'Single'),(2,'Married'),(3,'Divorced'),(4,'Separated'),(5,'Widowed');
UNLOCK TABLES;
/*!40000 ALTER TABLE `marital_status` ENABLE KEYS */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `pe_permissions_pk` int(11) NOT NULL auto_increment,
  `pe_role_name` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`pe_permissions_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissions`
--


/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
LOCK TABLES `permissions` WRITE;
INSERT INTO `permissions` VALUES (1,'Administrator'),(2,'Editor'),(3,'User'),(4,'Trainer'),(5,'Account disabled');
UNLOCK TABLES;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


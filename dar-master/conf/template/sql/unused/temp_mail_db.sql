drop database mail;
create database mail;
use mail;

DROP TABLE IF EXISTS accountuser;
CREATE TABLE accountuser (
  username varchar(50) binary NOT NULL default '',
  password varchar(30) binary NOT NULL default '',
  prefix varchar(50) NOT NULL default '',
  domain_name varchar(255) NOT NULL default '',
  date_created datetime NOT NULL default '2003-10-01 00:00:00',
  date_passwd_changed datetime NOT NULL default '0000-00-00 00:00:00',
  UNIQUE KEY username (username)
)

insert into accountuser values ('cekelley01',password('cekelley01'));
insert into accountuser values ('',password(''));
insert into accountuser values ('luser',password(''));
insert into accountuser values ('demo',password('demo11'));
insert into accountuser values ('clerk',password('clerk'));



update accountuser set password = password('demo11') where username='demo';


INSERT INTO accountuser VALUES ('cekelley01',password('cekelley01'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('',password(''),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('luser',password(''),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('demo',password('demo11'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('reports',password('reports11'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('clinic',password('clinic11'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('zepadmin',password('zepadmin11'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('viewall',password('viewall'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('pchansa',password('pchansa'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('mkatema',password('mkatema'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('chisambom',password('chisambom'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('jisitali',password('jisitali'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('cchishala',password('cchishala'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('amujajati',password('amujajati'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('smiti',password('smiti'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('smuwowo',password('smuwowo'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('rsiabbwalo',password('rsiabbwalo'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('omwiinde',password('omwiinde'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('clerk',password('clerk01'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('hfusco',password('hfusco'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');
INSERT INTO accountuser VALUES ('useradmin',password('useradmin01'),'','','2003-10-30 09:19:47','2003-10-30 09:19:47');

drop database userdata;
create database userdata;

DROP TABLE IF EXISTS account_permissions;
CREATE TABLE account_permissions (
  pa_id int(11) NOT NULL auto_increment,
  pa_role_name_fk int(11) NOT NULL default '0',
  pa_username_fk varchar(50) NOT NULL default '',
  pa_ap_id_fk int(11) NOT NULL default '0',
  PRIMARY KEY  (pa_id)
);

INSERT INTO account_permissions VALUES (1,3,'cekelley01',2);
INSERT INTO account_permissions VALUES (2,3,'',2);
INSERT INTO account_permissions VALUES (3,3,'luser',2);
INSERT INTO account_permissions VALUES (4,3,'demo',2);
INSERT INTO account_permissions VALUES (5,3,'reports',2);
INSERT INTO account_permissions VALUES (6,3,'clinic',2);
INSERT INTO account_permissions VALUES (7,3,'zepadmin',2);
INSERT INTO account_permissions VALUES (8,3,'pchansa',2);
INSERT INTO account_permissions VALUES (9,3,'viewall',2);

DROP TABLE IF EXISTS address;
CREATE TABLE address (
  firstname varchar(50) NOT NULL default '',
  nickname varchar(50) NOT NULL default '',
  lastname varchar(50) NOT NULL default '',
  email varchar(50) binary NOT NULL default '',
  label varchar(50) binary NOT NULL default '',
  owner varchar(50) binary NOT NULL default '',
  ad_phone varchar(15) NOT NULL default '',
  ad_mobile varchar(15) NOT NULL default '',
  ad_clinic_id_fk int(11) NOT NULL default '0',
  ad_sex char(1) NOT NULL default '',
  ad_marital_status_fk int(11) NOT NULL default '0',
  ad_job_title_fk char(2) NOT NULL default '',
  ad_reg_card varchar(15) NOT NULL default '',
  ad_MOH_file_num varchar(15) NOT NULL default '',
  ad_MC_num varchar(15) NOT NULL default '',
  ad_permissions_fk char(2) NOT NULL default '3',
  ad_man_num varchar(30) NOT NULL default '',
  ad_hobbies varchar(200) NOT NULL default '',
  ad_NCert_num varchar(30) NOT NULL default '',
  PRIMARY KEY  (nickname)
);

INSERT INTO address VALUES ('Chris','cekelley01','Kelley','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Test','','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Local','luser','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Demo','demo','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Report','reports','Viewer','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Clinic','clinic','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('ZEPRS Admin','zepadmin','User','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('View','viewall','All','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Chansa','pchansa','Patrick','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO address VALUES ('Clerk','clerk','Jane','cekelley01@zeprs.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO userdata.address VALUES ('Fusco','hfusco','Harmony','hfusco@cidrz.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO userdata.address VALUES ('User','useradmin','Admin','useradmin@cidrz.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');

CREATE INDEX NICKINDEX ON userdata.address (nickname(50)) ;

DROP TABLE IF EXISTS applications;
CREATE TABLE applications (
  ap_id int(11) NOT NULL auto_increment,
  ap_name varchar(50) NOT NULL default '',
  PRIMARY KEY  (ap_id)
);

INSERT INTO applications VALUES (1,'referral');
INSERT INTO applications VALUES (2,'zeprs');

DROP TABLE IF EXISTS facilities;
CREATE TABLE facilities (
  fa_clinic_id int(100) NOT NULL auto_increment,
  fa_institution varchar(100) NOT NULL default '',
  fa_description varchar(100) NOT NULL default '',
  fa_abreviation varchar(10) NOT NULL default '',
  fa_VOIP_phone int(15) NOT NULL default '0',
  fa_analogue_phone varchar(15) NOT NULL default '',
  PRIMARY KEY  (fa_clinic_id)
);

INSERT INTO facilities VALUES (1,'Airport','Clinic not part of ZEPRS network','APT',555,'1111'),(2,'Bauleni','Clinic','BAU',5550,'22222'),(3,'Center for Infectious Disease Research Zambia','Research unit.','CIDRZ',555,'2222'),(4,'Central Board of Health','Health administrative unit.','CBoH',55550,'222'),(5,'Chainama','Clinic','CHH',55550,'2222'),(6,'Chainda','Clinic','CAD',5555,'22222'),(7,'Chawama','Clinic','CWM',11110,'2222'),(8,'Chazanga','Clinic','CZG',11110,'22222'),(9,'Chelstone','Clinic','CHL',222220,'2222'),(10,'Chilenje','Clinic','CLJ',0,''),(11,'Chipata','Clinic','CPT',0,''),(12,'Civic Centre','Clinic','CVC',0,''),(13,'George','Clinic','GOG',0,''),(14,'Kabwata','Clinic','KBT',0,''),(15,'Kalingalinga','Clinic','KAL',0,''),(16,'Kamwala','Clinic','KML',0,''),(17,'Kanyama','Clinic','KNY',0,''),(18,'Kaunda Square','Clinic','KSQ',0,''),(19,'Lilayi','Clinic','LLY',0,''),(20,'Lusaka Urban District Health Management Team','Health administrative unit.','LUDHMT',0,''),(21,'Makeni','Clinic','MKN',0,''),(22,'Mandevu','Clinic','MDV',0,''),(23,'Matero Main','Clinic','MTM',0,''),(24,'Matero Reference','Clinic','MTR',0,''),(25,'Mtendere','Clinic','MTD',0,''),(26,'Ng\'ombe','Clinic','NGO',0,''),(27,'Prison Chimbokaila (Kabwata Prisons)','Clinic not part of ZEPRS network','KBP',0,''),(28,'Prison Kamwala','Clinic not part of ZEPRS network','KMP',0,''),(29,'Railway','Clinic','RAI',0,''),(30,'  State Lodge','Clinic','STL',0,''),(31,'University Teaching Hospital Antenatal Clinic','UTH Clinic','UTHANC',0,''),(32,'University Teaching Hospital Neonatal Intensive Care Unit','UTH Clinic','UTHNICU',0,''),(33,'University Teaching Hospital Obstetrics Labour Ward','UTH Clinic','UTHOBW',0,''),(34,'University Teaching Hospital Paediatrics Nursery','UTH Clinic','UTHNUR',0,''),(35,'Zambia Electronic Perinatal Record System','ZEPRS System administrative unit.','ZEPRS',0,''),(36,'University of Alabama at Birmingham','Research Partner with CIDRZ','UAB',0,''),(37,'Research Triangle Institute','Project Developer','RTI',0,''),(38,'UTH-A BLOCK','UTH clinic','UTH-A BLOC',0,''),(39,'UTH-B BLOCK','UTH clinic','UTH-B BLOC',0,''),(40,'UTH-C BLOCK','UTH clinic','UTH-C BLOC',0,''),(41,'UTH-D BLOCK','UTH clinic','UTH-D BLOC',0,''),(42,'UTH-HIS','UTH clinic','UTH-HIS',0,''),(43,'UTH-PHASE V','UTH clinic','UTH-PHASE',0,'');

DROP TABLE IF EXISTS job_title;
CREATE TABLE job_title (
  jt_job_title_pk int(11) NOT NULL auto_increment,
  jt_job_title_name varchar(100) NOT NULL default '',
  jt_sort_order int(11) NOT NULL default '0',
  PRIMARY KEY  (jt_job_title_pk)
);

INSERT INTO job_title VALUES (1,'Registerred Nurse',5),(2,'Enrolled Nurse',6),(3,'User',8),(4,'Trainer',7),(5,'Doctor',1),(6,'Sister In Charge',2),(7,'Registerred Midwife',3),(8,'Enrolled Midwife',4),(9,'Registry Clerks',9),(10,'Nursing Assistant',10),(11,'HIS-Clerk',11);

DROP TABLE IF EXISTS marital_status;
CREATE TABLE marital_status (
  ms_marital_status_pk int(11) NOT NULL auto_increment,
  ms_marital_status_name varchar(50) NOT NULL default '',
  PRIMARY KEY  (ms_marital_status_pk)
);

INSERT INTO marital_status VALUES (1,'Single'),(2,'Married'),(3,'Divorced'),(4,'Separated'),(5,'Widowed');

DROP TABLE IF EXISTS permissions;
CREATE TABLE permissions (
  pe_permissions_pk int(11) NOT NULL auto_increment,
  pe_role_name varchar(20) NOT NULL default '',
  PRIMARY KEY  (pe_permissions_pk)
);
INSERT INTO permissions VALUES (1,'Administrator'),(2,'Editor'),(3,'User'),(4,'Trainer'),(5,'Account disabled');


INSERT INTO accountuser VALUES ('biuser',password('biuser'),'','','2007-08-17 10:27:00','2007-08-17 10:27:00');
INSERT INTO userdata.address VALUES ('biuser','biuser','biuser','biuser@rti.org','','global','250856','096 929049',31,'M',5,'1','140528/24/1','','','3','003351','reading  gardening  cooking','');
INSERT INTO zeprs.user_group_membership SET id='test11', group_id=5;



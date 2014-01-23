SET FOREIGN_KEY_CHECKS = 0;
USE userdata;
DELETE FROM account_permissions;
DELETE FROM address;
DELETE FROM applications;
DELETE FROM facilities;
DELETE FROM job_title;
DELETE FROM marital_status;
DELETE FROM permissions;

INSERT INTO address VALUES ('ZEPRS Admin','zepadmin','User','','','global','','',31,'M',5,'1','','','','3','003351','','');
INSERT INTO address VALUES ('Local','luser','User','','','global','','',31,'M',5,'1','','','','3','003351','','');
INSERT INTO address VALUES ('Report','reports','Viewer','','','global','','',31,'M',5,'1','','','','3','003351','','');
INSERT INTO address VALUES ('Clinic','clinic','User','','','global','','',31,'M',5,'1','','','','3','003351','','');
INSERT INTO address VALUES ('View','viewall','All','','','global','','',31,'M',5,'1','','','','3','003351','','');
INSERT INTO address VALUES ('User','useradmin','Admin','useradmin@cidrz.org','','global','','',31,'M',5,'1','','','','3','003351','','');
INSERT INTO address VALUES ('Clerk','clerk','Jane','','','global','','',31,'M',5,'1','','','','3','003351','','');

SET FOREIGN_KEY_CHECKS = 1;
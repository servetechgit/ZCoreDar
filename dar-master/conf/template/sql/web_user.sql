// updated 3/16/2006 cek

GRANT SELECT,INSERT,UPDATE ON zeprs.* TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter_value TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.rule_definition_param TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.field_enumeration TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.page_item TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON mail.accountuser TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON userdata.address TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient_status TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patientregistration TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newborneval TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.ultrasoundfetuseval TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newbornrecord TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';


GRANT SELECT ON admin.form TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';

GRANT SELECT,INSERT,UPDATE ON zeprsdemo.* TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter_value TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.rule_definition_param TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.field_enumeration TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.page_item TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON mail.accountuser TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON userdata.address TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient_status TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON admin.form TO 'zeprs_demo_user'@'localhost' IDENTIFIED BY 'A99wKbzN'

for zeprs server, set root password:

SET PASSWORD FOR root@localhost=PASSWORD('zamL$af');

GRANT SELECT,INSERT,UPDATE ON zeprs.* TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter_value TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.rule_definition_param TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.field_enumeration TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.page_item TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON mail.accountuser TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON userdata.* TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient_status TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patientregistration TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newborneval TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.ultrasoundfetuseval TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newbornrecord TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';

GRANT SELECT ON admin.form TO 'zeprs_web_user'@'zsr01.zeprs.org' IDENTIFIED BY '0UpaxVKr';

rimu password:
SET PASSWORD FOR root@localhost=PASSWORD('36avaU68');

remote access - used to update db when loading new builds:
GRANT ALL ON zeprs.* TO rti IDENTIFIED BY 'L9ADILnm';
GRANT ALL ON zeprs.* TO 'rti'@'localhost' IDENTIFIED BY 'L9ADILnm';

GRANT ALL ON zeprs.* TO 'zeprsAdmin'@'localhost' IDENTIFIED BY 'L9ADILnm';
GRANT ALL ON admin.* TO 'zeprsAdmin'@'localhost' IDENTIFIED BY 'L9ADILnm';

*** double-check these ***
GRANT SELECT,LOCK TABLES ON mail.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'L9ADILnm';
GRANT SELECT,LOCK TABLES ON userdata.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'L9ADILnm';
GRANT SELECT,LOCK TABLES ON zeprs.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'L9ADILnm';

*** do not use this on lusaka server  ***
*** GRANT SELECT,LOCK TABLES ON admin.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'L9ADILnm';

command to access the rti server remotely
mysql -u rti -p -h 66.199.240.18

update accountuser set password=PASSWORD("demo11") where username="demo";

GRANT SELECT,INSERT,UPDATE ON zeprs.* TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter_value TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.rule_definition_param TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.field_enumeration TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.page_item TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON mail.accountuser TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON userdata.address TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient_status TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patientregistration TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newborneval TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.ultrasoundfetuseval TO 'zeprs_web_user'@'blastforge2.com' IDENTIFIED BY '0UpaxVKr';
GRANT ALL ON admin.* TO 'root'@'blastforge2.com' IDENTIFIED BY '36avaU68';

GRANT SELECT,INSERT,UPDATE ON zeprsdemo.* TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter_value TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.rule_definition_param TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.field_enumeration TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.page_item TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON mail.accountuser TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON userdata.address TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient_status TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';

GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON admin.form TO 'zeprs_demo_user'@'blastforge2.com' IDENTIFIED BY 'A99wKbzN'


GRANT SELECT,INSERT,UPDATE ON zeprs.* TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter_value TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.rule_definition_param TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.field_enumeration TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.page_item TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON mail.accountuser TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON userdata.* TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient_status TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patientregistration TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newborneval TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.ultrasoundfetuseval TO 'zeprs_web_user'@'zsr01' IDENTIFIED BY '0UpaxVKr';

GRANT ALL ON zeprs.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'HCc5wXEd';
GRANT ALL ON admin.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'HCc5wXEd';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP  ON zeprs.* TO 'root'@'zsr01.zeprs.org' IDENTIFIED BY 'zamL$af';


GRANT ALL ON zeprsdemo.* TO 'root'@'192.168.20.6' IDENTIFIED BY 'zamL$af';
GRANT ALL ON zeprsdemo.* TO 'zeprsAdmin'@'zsr01.zeprs.org' IDENTIFIED BY 'HCc5wXEd';

this didn't work:
GRANT SELECT,INSERT,UPDATE ON zeprsdemo.* TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter_value TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.rule_definition_param TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.field_enumeration TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.page_item TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON mail.accountuser TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON userdata.address TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient_status TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientRegistration TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newbornEval TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON admin.form TO 'zeprs_demo_user'@'zsr01' IDENTIFIED BY 'A99wKbzN';

These did:
GRANT SELECT,INSERT,UPDATE ON zeprsdemo.* TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter_value TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.rule_definition_param TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.field_enumeration TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.page_item TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON mail.accountuser TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON userdata.address TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient_status TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientRegistration TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newbornEval TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON admin.form TO 'zeprs_demo_user'@'zsr01.zeprs.org' IDENTIFIED BY 'A99wKbzN';


GRANT ALL PRIVILEGES ON *.* TO 'root'@'zsr01.zeprs.org' IDENTIFIED BY '36avaU68';

GRANT SELECT,LOCK TABLES ON zeprs.* TO 'zeprsReport'@'*' IDENTIFIED BY 'm38KBi2n';
GRANT LOCK TABLES ON *.* TO 'zeprsReport'@'%' IDENTIFIED BY 'm38KBi2n';
GRANT LOCK TABLES ON *.* TO 'zeprsReport'@'%'; 
GRANT SELECT ON zeprsdemo.* TO 'zeprsReport'@'%' IDENTIFIED BY 'm38KBi2n'; 
show grants for zeprsReport;
 FLUSH PRIVILEGES;
 
 
 mysql> show grants for zeprsReport;
 +-----------------------------------------------------------------------------------------+
 | Grants for zeprsReport@%                                                                |
 +-----------------------------------------------------------------------------------------+
 | GRANT LOCK TABLES ON *.* TO 'zeprsReport'@'%' IDENTIFIED BY PASSWORD '6a389d387f176a88' |
 | GRANT SELECT ON `zeprs`.* TO 'zeprsReport'@'%'                                          |
 | GRANT SELECT ON `admin`.* TO 'zeprsReport'@'%'                                          |
 +-----------------------------------------------------------------------------------------+
 3 rows in set (0.00 sec)

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '36avaU68';


GRANT SELECT,INSERT,UPDATE ON zeprsdemo.* TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter_value TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.rule_definition_param TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.field_enumeration TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.page_item TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON mail.accountuser TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON userdata.address TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.client_setting TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient_status TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientRegistration TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newbornEval TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patientregistration TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.newborneval TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.encounter TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.patient TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT DELETE ON zeprsdemo.ultrasoundfetuseval TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';
GRANT SELECT ON admin.form TO 'zeprs_demo_user'@'192.168.20.6' IDENTIFIED BY 'A99wKbzN';


GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.20.6' IDENTIFIED BY 'zamL$af';


GRANT SELECT,INSERT,UPDATE ON zeprs.* TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter_value TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.rule_definition_param TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.field_enumeration TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.page_item TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON mail.accountuser TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON userdata.* TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient_status TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patientregistration TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newborneval TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.ultrasoundfetuseval TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';

GRANT SELECT ON admin.form TO 'zeprs_web_user'@'192.168.20.6' IDENTIFIED BY '0UpaxVKr';

GRANT ALL ON zeprs.* TO 'zeprsAdmin'@'192.168.20.6' IDENTIFIED BY 'HCc5wXEd';
GRANT ALL ON admin.* TO 'zeprsAdmin'@'192.168.20.6' IDENTIFIED BY 'HCc5wXEd';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP  ON zeprs.* TO 'root'@'192.168.20.6' IDENTIFIED BY 'zamL$af';


GRANT ALL ON zeprsdemo.* TO 'root'@'192.168.20.6' IDENTIFIED BY 'zamL$af';
GRANT ALL ON zeprsdemo.* TO 'zeprsAdmin'@'192.168.20.6' IDENTIFIED BY 'HCc5wXEd';

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP  ON zeprs.* TO 'root'@'192.168.20.6' IDENTIFIED BY 'zamL$af';

GRANT SELECT,INSERT,UPDATE ON zeprs.* TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.rule_definition_param TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.field_enumeration TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.page_item TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON mail.accountuser TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON userdata.* TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.client_setting TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient_status TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patientregistration TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.newborneval TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.encounter TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.patient TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON zeprs.ultrasoundfetuseval TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON admin.form TO 'zeprs_web_user'@'192.168.20.66' IDENTIFIED BY '0UpaxVKr';
GRANT ALL ON zeprs.* TO 'zeprsAdmin'@'192.168.20.66' IDENTIFIED BY 'HCc5wXEd';
GRANT ALL ON admin.* TO 'zeprsAdmin'@'192.168.20.66' IDENTIFIED BY 'HCc5wXEd';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP  ON zeprs.* TO 'root'@'192.168.20.66' IDENTIFIED BY 'zamL$af';
GRANT ALL ON zeprsdemo.* TO 'root'@'192.168.20.66' IDENTIFIED BY 'zamL$af';
GRANT ALL ON zeprsdemo.* TO 'zeprsAdmin'@'192.168.20.66' IDENTIFIED BY 'HCc5wXEd';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.20.66' IDENTIFIED BY 'zamL$af';

// zeports database
GRANT SELECT,INSERT,UPDATE, CREATE, DROP, INDEX  ON zeports.* TO 'zeprsReport'@'%' IDENTIFIED BY 'm38KBi2n';
GRANT EXECUTE ON procedure sp_create_hiv_report_table TO 'zeprsReport'@'%' IDENTIFIED BY 'm38KBi2n';
GRANT EXECUTE ON procedure sp_ega TO 'zeprsReport'@'%' IDENTIFIED BY 'm38KBi2n';
GRANT EXECUTE ON procedure sp_pregnancy_dating TO 'zeprsReport'@'%' IDENTIFIED BY 'm38KBi2n';

GRANT SELECT,INSERT,UPDATE, CREATE, DROP, INDEX  ON zeports.* TO 'zeprsReportAdmin'@'localhost' IDENTIFIED BY 'm38KBi2n';
GRANT EXECUTE ON procedure sp_create_hiv_report_table TO 'zeprsReportAdmin'@'localhost' IDENTIFIED BY 'm38KBi2n';
GRANT EXECUTE ON procedure sp_ega TO 'zeprsReportAdmin'@'localhost' IDENTIFIED BY 'm38KBi2n';
GRANT EXECUTE ON procedure sp_pregnancy_dating TO 'zeprsReportAdmin'@'localhost' IDENTIFIED BY 'm38KBi2n';

// additions






--
-- Setup database permissions
--

GRANT SELECT, INSERT, UPDATE ON `zeprs`.* TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON `admin`.`form` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON `mail`.`accountuser` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`client_setting` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT SELECT ON `userdata`.`address` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`encounter` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`encounter_value_archive` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`newborneval` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`page_item` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`field_enumeration` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`rule_definition_param` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`patientregistration` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`patient_status` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`patient` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';
GRANT DELETE ON `zeprs`.`ultrasoundfetuseval` TO 'zeprs_web_user'@'localhost' IDENTIFIED BY '0UpaxVKr';

GRANT ALL ON zeprs.* TO 'zeprsAdmin'@'localhost' IDENTIFIED BY 'L9ADILnm';
GRANT ALL ON admin.* TO 'zeprsAdmin'@'localhost' IDENTIFIED BY 'L9ADILnm';

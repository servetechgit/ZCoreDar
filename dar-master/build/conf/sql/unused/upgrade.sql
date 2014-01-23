CREATE TABLE form_field_bridge_tmp (
  form_id bigint(20) NOT NULL default '0',
  field_id bigint(20) NOT NULL default '0',
  display_hint_id bigint(20) default '0'
) TYPE=InnoDB;

insert into form_field_bridge_tmp (form_id,field_id,display_hint_id)
select form_id, field_id, display_hint_id
from form_field_bridge, form_field
where form_field_bridge.field_id = form_field.id

SET FOREIGN_KEY_CHECKS = 0;
alter table form_field drop display_hint_id;
SET FOREIGN_KEY_CHECKS = 1;


--
-- Table structure for table `page_item`
--

DROP TABLE IF EXISTS page_item;
CREATE TABLE page_item (
  id bigint(20) NOT NULL,
  item_id bigint(20) NOT NULL,
  display_order int(11) default NULL,
  input_type varchar(255) NOT NULL default '',
  use_table tinyint(1) default NULL,
  column_number int(11) default NULL,
  last_modified datetime default NULL,
  created datetime default NULL,
  last_modified_by varchar(255) default NULL,
  created_by varchar(255) default NULL,
  size int(11) default NULL,
  maxlength int(11) default NULL,
  rows int(11) default NULL,
  cols int(11) default NULL,
  visible tinyint(1) default NULL,
  visible_enum_id_trigger varchar(255) default NULL,
  visible_dependencies varchar(255) default NULL
) TYPE=InnoDB;

insert into page_item (id,item_id,display_order,input_type,use_table,column_number,
last_modified,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,visible_dependencies)
select display_hint.id,form_field.id,form_field.display_order,input_type,use_table,column_number,
display_hint.last_modified,display_hint.created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,visible_dependencies
from display_hint, form_field
where form_field.display_hint_id = display_hint.id;


DROP TABLE IF EXISTS form_field_bridge_tmp;
CREATE TABLE form_field_bridge_tmp (
  form_id bigint(20) NOT NULL default '0' ,
  page_item_id bigint(20) NOT NULL default '0'
) TYPE=InnoDB;

insert into form_field_bridge_tmp (form_id, page_item_id)
select page_item_id,form_id  from form_field_bridge
order by page_item_id, form_id


select DISTINCT encounter_value.id, encounter_value.encounter_id, encounter_value.field_id, encounter_value.value,page_item.id AS page_id
from  encounter_value, page_item
where page_item.form_field_id = encounter_value.field_id

select encounter_value.id, encounter_value.encounter_id, encounter_value.field_id, encounter_value.value,page_item.id AS page_id
from  encounter_value
LEFT JOIN page_item
ON page_item.form_field_id = encounter_value.field_id

select DISTINCT encounter_value.id, encounter_value.encounter_id, encounter_value.field_id, encounter_value.value,form_field_bridge.page_item_id AS page_id
from  encounter_value, page_item, form_field_bridge
where page_item.form_field_id = encounter_value.field_id
AND page_item.id = form_field_bridge.page_item_id



DROP TABLE IF EXISTS encounter_value_tmp;
CREATE TABLE encounter_value_tmp (
  id bigint(20) NOT NULL,
  encounter_id bigint(20) default NULL,
  field_id bigint(20) default NULL,
  page_item_id bigint(20) default NULL,
  value varchar(255) NOT NULL default ''
) TYPE=InnoDB;

insert into  encounter_value_tmp
select DISTINCT encounter_value.id, encounter_value.encounter_id, encounter_value.field_id, page_item.id AS page_item_id, encounter_value.value
from  encounter_value, page_item
where page_item.form_field_id = encounter_value.field_id


DROP TABLE IF EXISTS page_item_tmp;
CREATE TABLE page_item_tmp (
  id bigint(20) NOT NULL ,
  form_field_id bigint(20) default NULL,
  display_order int(11) default NULL,
  input_type varchar(255) NOT NULL default '',
  use_table tinyint(1) default NULL,
  column_number int(11) default NULL,
  last_modified datetime default NULL,
  created datetime default NULL,
  last_modified_by varchar(255) default NULL,
  created_by varchar(255) default NULL,
  size int(11) default NULL,
  maxlength int(11) default NULL,
  rows int(11) default NULL,
  cols int(11) default NULL,
  visible tinyint(1) default NULL,
  visible_enum_id_trigger varchar(255) default NULL,
  visible_dependencies varchar(255) default NULL
) TYPE=InnoDB;

insert into page_item_tmp
select * from page_item
where id= 1631 and form_field_id=129

insert into page_item_tmp
select * from page_item
where id= 1150 and form_field_id=224

insert into page_item_tmp
select * from page_item
where id= 1447 and form_field_id=225

insert into page_item_tmp
select * from page_item
where id= 1469 and form_field_id=228

insert into page_item_tmp
select * from page_item
where id= 1471 and form_field_id=232

insert into page_item_tmp
select * from page_item
where id= 1472 and form_field_id=235

insert into page_item_tmp
select * from page_item
where id= 1470 and form_field_id=242

insert into page_item_tmp
select * from page_item
where id= 1463 and form_field_id=243

insert into page_item_tmp
select * from page_item
where id= 1464 and form_field_id=244

insert into page_item
select * from page_item_tmp;
TRUNCATE TABLE page_item_tmp;

// To view the shared fields and their forms

select form_field.id, form_field.label,form.label 
from  form_field, page_item, form, form_field_bridge
where form_field.id = page_item.form_field_id
AND  form_field_bridge.page_item_id = page_item.id
AND  form_field_bridge.form_id = form.id
AND  form_field.shared=1
order by form_field.label


alter table form
add flow_id BIGINT;

update form,flow_bridge
set form.flow_id = flow_bridge.flow_id
where form.id = flow_bridge.form_id

alter table flow_bridge
add flow_order BIGINT;

alter table form
add flow_order BIGINT;

create table flow_bridge_tmp (
   flow_id BIGINT not null,
   form_id BIGINT not null
);

insert into flow_bridge_tmp
select form.flow_id, form.id
from form

select id from page_item
where input_type = 'radio';

update page_item
set input_type = 'select'
where  input_type = 'radio';

// To update flow_bridge
update flow_bridge, form
set flow_bridge.flow_id = form.flow_id
where form.id = flow_bridge.form_id

// To view flows
select flow.name AS 'Flow name', form.label AS 'Form label', form.id AS 'Form ID', form.flow_order AS 'Order in Flow'
from flow, form
where form.flow_id = flow.id
order by flow.name, flow_order

update page_item,form_field_bridge
set page_item.form = form_field_bridge.form_id
where page_item.id = form_field_bridge.id

alter table page_item
add form_id BIGINT;

update page_item
set maxlength = 7
where id=1717;

update form
set flow_id=3 where flow_id=4

update form
set flow_id=4 where flow_id=10

update form
set flow_id=5 where flow_id=11

update form
set flow_id=6 where flow_id=12

SET FOREIGN_KEY_CHECKS = 0;
update flow
set id=3 where id=4

update flow
set id=4 where id=10;
update flow
set id=5 where id=11;
update flow
set id=6 where id=12 ;

SELECT *
FROM encounter_value v, encounter_record r
where v.patient_id=r.patient_id
ORDER BY v.created

SELECT *
FROM encounter_value v, encounter_record r,page_item p,form_field f
where v.encounter_id = r.id
AND v.page_item_id = p.id
AND p.form_field_id = f.id
and r.patient_id=1
and (f.id=129 OR f.id = 224 OR f.id = 225 OR f.id = 228 OR f.id = 232 OR f.id = 235 OR f.id = 242 OR f.id = 243 OR f.id = 244)
ORDER BY r.created DESC

 String sql = "SELECT {r.*} \n" +
"FROM encounter_value v, encounter_record {r},page_item p,form_field f\n" +
"where v.encounter_id = {r}.id\n" +
"AND v.page_item_id = p.id\n" +
"AND p.form_field_id = f.id\n" +
"and {r}.patient_id="+patientId+"\n" +
"and (f.id=129 OR f.id = 224 OR f.id = 225 OR f.id = 228 OR f.id = 232 OR f.id = 235 OR f.id = 242 OR f.id = 243 OR f.id = 244)\n" +
"ORDER BY r.created DESC";

 v.id, v.value
SELECT v.id, v.value, r.created, r.id AS 'record id', f.id AS fieldID
FROM encounter_value v, encounter_record r,page_item p,form_field f
where v.encounter_id = r.id
AND v.page_item_id = p.id
AND p.form_field_id = f.id
and r.patient_id=1
and (f.id=129 OR f.id = 224 OR f.id = 225 OR f.id = 228 OR f.id = 232 OR f.id = 235 OR f.id = 242 OR f.id = 243 OR f.id = 244)
ORDER BY r.created DESC

SELECT v.id, v.value, r.created, r.id AS 'record id', f.id AS fieldID
FROM encounter_value v, encounter_record r,page_item p,form_field f
where v.encounter_id = r.id
AND v.page_item_id = p.id
AND p.form_field_id = f.id
and (f.id=129 OR f.id = 224 OR f.id = 225 OR f.id = 228 OR f.id = 232 OR f.id = 235 OR f.id = 242 OR f.id = 243 OR f.id = 244)
and v.value !=''
ORDER BY r.created DESC

*** run this to update the zeprs server ***

alter table encounter_record
add flow_id BIGINT;

update encounter_record, form
set encounter_record.flow_id = form.flow_id
where encounter_record.form_id = form.id

Alter TABLE encounter_value ADD patient_id BIGINT;
Alter TABLE encounter_value ADD form_id BIGINT;
Alter TABLE encounter_value ADD last_modified DATETIME;
Alter TABLE encounter_value ADD created DATETIME;
Alter TABLE encounter_value ADD last_modified_by VARCHAR(255);
Alter TABLE encounter_value ADD created_by VARCHAR(255);

Be sure to run /migrate

update encounter_value,encounter_record set encounter_value.site_id = encounter_record.site_id where encounter_record.id = encounter_value.encounter_id

Alter TABLE encounter_record ADD visit_date DATETIME;

update encounter_record set encounter_record.visit_date = encounter_record.created

Alter TABLE form_field ADD star_schema_name varchar(255);
Alter TABLE form_field ADD encounter_record_property varchar(255);
Alter TABLE encounter_record ADD encounter_record_property varchar(255);

alter table comment add outcome_id BIGINT;
alter table comment add encounter_id BIGINT;

field changes:
Changed field 286 - "referral to uth" - a shared field. disabled field 591, need to change any fields that are 591 to use shared field 286.

*******************

update encounter_value
set patient_id
field_id
last_modified
created
last_modified_by
created_by
WHERE encounter_value.encounter_id =

SELECT *
FROM `encounter_value`
WHERE (field_id=129 OR field_id = 224 OR field_id = 225 OR field_id = 228 OR field_id = 232 OR field_id = 235 OR field_id = 242 OR field_id = 243 OR field_id = 244)
AND patient_id = 2


update form_field set form_field.star_schema_name = CONCAT_WS('_',LEFT(LOWER(REPLACE(form_field.label,' ','_')),12),form_field.id);
SELECT CONCAT_WS('_',LEFT(LOWER(form_field.label),10),form_field.id)
FROM `form_field`

SELECT CONCAT_WS('_',LEFT(LOWER(REPLACE(form_field.label,' ','_')),12),form_field.id)
FROM `form_field`

SELECT visit_date AS 'Date of Visit', site_name AS 'Site', Concat_WS(", ",p.surname,p.first_name) AS 'Patient Name', label AS 'Field', value AS Value FROM encounter_value ev, site s, patient p, form_field WHERE ev.site_id = s.id AND ev.patient_id = p.id AND ev.field_id = form_field.id AND field_id=126 AND value!='' ORDER BY site_name, patient_id DESC


Date of Visit,Site,Patient Name, Field, Value

SELECT visit_date, site_name, Concat_WS(", ",p.surname,p.first_name) AS 'patient_name', label, value FROM encounter_value ev, site s, patient p, form_field WHERE ev.site_id = s.id AND ev.patient_id = p.id AND ev.field_id = form_field.id AND field_id=126 AND value!='' ORDER BY site_name, patient_id DESC

SELECT visit_date, site_name, Concat_WS(", ",p.surname,p.first_name) AS 'patient_name', label, value
FROM encounter_value ev, site s, patient p, form_field
WHERE ev.site_id = s.id
AND ev.patient_id = p.id
AND ev.field_id = form_field.id
AND (field_id=129 OR  field_id=224 OR  field_id=225 OR  field_id=228 OR  field_id=232 OR  field_id=235 OR  field_id=242 OR  field_id=243 OR field_id=244)
AND value!=''
ORDER BY site_name, patient_id, field_id DESC


mysql> alter table patient
    -> add parent_id int(8);

select star_schema_name from form_field, page_item where form_field.id = page_item.form_field_id AND is_enabled=1 AND form_id=23 ORDER BY page_item.display_order;    


 alter table patient add sex int(8);
 alter table patient add age_at_admission int(8);
 alter table patient add birthdate int(8);

alter table form
add patient_status_property varchar(255);

alter table form
add patient_lab_property varchar(255);

alter table encounter_record
add pregnancy_id int(8);

alter table patient_status
add current_pregnancy_id int(8);
add current_pregnancy_encounter_id int(8);

alter table form
add form_type_id int(8);

UPDATE `form_field` SET form.form_type_id = 1

alter table encounter_value
add pregnancy_id int(8);

update page_item p, form_field f
set p.visible=true
where form_id = 68
and p.form_field_id = f.id
and f.type != 'Date'
and p.input_type != 'textarea'

update page_item p
set p.visible=false
where form_id = 68
and p.input_type = 'display-tbl-begin'
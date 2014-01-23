update form set require_patient = 0 where label = "Patient Registration and Identification";

--set up Yes/No choices as enumerations
insert into field_enumeration (field_id, enumeration)
select id, 'Yes' from form_field where type = 'radio-yn';
insert into field_enumeration (field_id, enumeration)
select id, 'No' from form_field where type = 'radio-yn';

--set up NR enumerations
insert into field_enumeration (field_id, enumeration)
select id, 'R' from form_field where type = 'radio-nr';
insert into field_enumeration (field_id, enumeration)
select id, 'NR' from form_field where type = 'radio-nr';

--set up HIV enumerations
insert into field_enumeration (field_id, enumeration)
select id, 'R' from form_field where type = 'radio-hiv';
insert into field_enumeration (field_id, enumeration)
select id, 'NR' from form_field where type = 'radio-hiv';
insert into field_enumeration (field_id, enumeration)
select id, 'HIV' from form_field where type = 'radio-hiv';

-- give all fields a default display hint
insert into display_hint (id, input_type, use_table)
select id, 'text', 0 from form_field;

--now link them
update form_field set display_hint_id = id;

--now make the enums use select as a default
replace into display_hint (id, input_type)
select distinct(field_id), 'select' from field_enumeration;

--handle radio buttons for enumerations
replace into display_hint (id, input_type)
select distinct(form_field.id), 'radio' from form_field, field_enumeration
where form_field.id = field_enumeration.field_id
and lower(type) like '%radio%';

--handle checkboxes for enumerations
replace into display_hint (id, input_type)
select distinct(form_field.id), 'checkbox' from form_field, field_enumeration
where form_field.id = field_enumeration.field_id
and lower(type) like '%checkbox%';

--handle textareas for non-enumerations
replace into display_hint (id, input_type)
select distinct(id), 'textarea' from form_field where lower(type) like '%textarea%';


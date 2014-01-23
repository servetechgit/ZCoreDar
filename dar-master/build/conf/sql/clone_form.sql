**
** ways to clone a form
**

first, create the new form using the web gui. make a note of the form id and the id of the form you're cloning.
in this case, the new form is 59, and the form id i'm cloning is 8.

since i've made schema changes, use the last version - it has updated fields.

also - here's a simple sql command go delete unwanted pageItems:

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2283;

** clone the page items
insert into page_item
select '',form_field_id,display_order,input_type,use_table,column_number,last_modified,
   created ,
   last_modified_by,
   created_by,
   size,
   maxlength,
   rows,
   cols,
   visible,
   visible_enum_id_trigger,
   visible_dependencies,
   59
   from page_item where form_id=8

insert into page_item
select '',form_field_id,display_order,input_type,use_table,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,60
from page_item where form_id=14

insert into page_item
select '',form_field_id,display_order,input_type,use_table,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,61
from page_item where form_id=15

insert into page_item
select '',form_field_id,display_order,input_type,use_table,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,62
from page_item where form_id=16

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=57

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=57

*** pre-set visible to 0, because all of these fields' visibility will be controlled by a section header link ***

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=59

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=60

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=61

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=62

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,65,colspan
from page_item where form_id=58

insert into page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,66,colspan
from page_item where form_id=19

insert into page_item
select '',form_field_id,26+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,66,colspan
from page_item where form_id=21

insert into page_item
select '',form_field_id,52+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,66,colspan
from page_item where form_id=22

insert into page_item
select '',form_field_id,1+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,67,colspan
from page_item where form_id=14

insert into page_item
select '',form_field_id,7+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,67,colspan
from page_item where form_id=15

insert into page_item
select '',form_field_id,14+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,68,colspan
from page_item where form_id=26

insert into page_item
select '',form_field_id,29+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,0,visible_enum_id_trigger,
visible_dependencies,68,colspan
from page_item where form_id=27

insert into page_item
select '',form_field_id,43+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,28,colspan
from page_item where form_id=31

// create the problem/antepartum visit form
insert into zeprs.page_item
select '',form_field_id,43+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,69,colspan
from zeprs.page_item where form_id= 65

2275(62) - 2351(102)
insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,69,colspan
from zeprs.page_item where form_id= 65
AND display_order < 62
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,69,colspan
from zeprs.page_item where form_id= 65
AND display_order > 101
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,70,colspan
from zeprs.page_item where form_id= 3
order by display_order

insert into zeprs.page_item
select '',form_field_id,33+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,70,colspan
from zeprs.page_item where form_id= 5
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,74,colspan
from zeprs.page_item where form_id= 63
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,76,colspan
from zeprs.page_item where form_id= 38
order by display_order

insert into zeprs.page_item
select '',form_field_id,14+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,76,colspan
from zeprs.page_item where form_id= 24
order by display_order

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2923;

insert into zeprs.page_item
select '',form_field_id,14+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,76,colspan
from zeprs.page_item where form_id= 37
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger,
visible_dependencies,77,colspan
from zeprs.page_item where form_id= 6
order by display_order

insert into zeprs.page_item
select '',form_field_id,31+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,10,colspan
from zeprs.page_item
where form_id= 65
and (display_order = 3
or display_order = 4
or display_order = 11
or display_order = 12
or display_order = 30
or display_order = 27
or display_order = 7
or display_order = 8
or display_order = 26
or display_order = 15
or display_order = 16
or display_order = 18
or display_order = 29
or display_order = 31
or display_order = 13
or display_order = 14
or display_order = 32
or display_order = 33
or display_order = 34)
order by display_order

insert into zeprs.page_item
select '',form_field_id,53+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,1,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,10,colspan
from zeprs.page_item
where form_id= 65
and display_order != 153
and (display_order = 137
or display_order =131
or display_order =132
or display_order >138
)
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,1,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,78,colspan
from zeprs.page_item
where form_id= 65
and ((display_order >2 AND display_order < 26)
or display_order = 34
)
order by display_order

insert into zeprs.page_item
select '',form_field_id,23+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,1,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,78,colspan
from zeprs.page_item
where form_id= 65
and display_order = 26
order by display_order

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
where form_id = 78
and (display_order = 2
or display_order = 3
or display_order = 6
or display_order = 7
or display_order = 20)

insert into zeprs.page_item
select '',form_field_id,19+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,1,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,78,colspan
from zeprs.page_item
where form_id= 65
and ((display_order >49 AND display_order < 84)
)
order by display_order

insert into zeprs.page_item
select '',form_field_id,53+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,78,colspan
from zeprs.page_item
where form_id= 65
and display_order != 143
and display_order != 154
and (display_order = 131
or display_order = 132)
or ((display_order >138 AND display_order < 158)
)
order by display_order

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
where form_id = 78
and display_order = 71

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
where form_id = 78
and display_order = 60

insert into zeprs.page_item
select '',form_field_id,73+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,23,colspan
from zeprs.page_item
where form_id= 24
order by display_order

-- Deleting unused fields/page_items
SELECT *
FROM `page_item` p, `form_field` f
WHERE p.form_field_id=f.id
AND f.is_enabled=0

SET FOREIGN_KEY_CHECKS = 0;
DELETE p,f FROM `page_item` p, `form_field` f
WHERE p.form_field_id=f.id
AND f.is_enabled=0

-- then see if there are any leftover

SELECT *
FROM `form_field` f
WHERE f.is_enabled=0

SET FOREIGN_KEY_CHECKS = 0;
DELETE f FROM `form_field` f
WHERE f.is_enabled=0

SELECT p.form_id
FROM `page_item` p, `form_field` f
WHERE p.form_field_id=f.id
AND f.is_enabled=0

SELECT p.form_id
FROM `page_item` p, `form_field` f
WHERE p.form_field_id=f.id
AND f.label LIKE '%LMP%';

-- shared field cleanup

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2335;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2334;

-- find fields not assigned to any form:

SELECT id, label FROM form_field WHERE id NOT IN (SELECT form_field_id FROM page_item)

-- now delete them:

delete f FROM form_field f WHERE id NOT IN (SELECT form_field_id FROM page_item)

-- find fields that are only in enabled forms:

SELECT id, label, is_enabled FROM form_field WHERE id IN (SELECT form_field_id FROM page_item, form WHERE form.id=page_item.form_id AND form.is_enabled=1) ORDER BY label

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=3194;

-- cealn up initial phys visit
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2935;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2936;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2937;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2938;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2939;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2941;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2988;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=3326;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2940;

// new col - site_id

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,site_id,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,84,colspan
from zeprs.page_item
where form_id= 23
and display_order > 22
order by display_order

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM `page_item`
WHERE id=2283;

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,site_id,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,85,colspan
from zeprs.page_item
where form_id= 78
order by display_order

insert into zeprs.page_item
select '',form_field_id,display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,site_id,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,86,colspan
from zeprs.page_item
where form_id= 32
order by display_order

insert into zeprs.page_item
select '',form_field_id,30+display_order,input_type,close_row,column_number,last_modified,
created,last_modified_by,created_by,site_id,size,maxlength,rows,cols,visible,visible_enum_id_trigger1,
visible_dependencies1,visible_enum_id_trigger2,visible_dependencies2,selected_enum,76,colspan
from zeprs.page_item
where form_id= 37
order by display_order
 -- update stock_control set QUANTITY_REMAINING = BALANCE;
 update stock_control set BALANCE = QUANTITY_REMAINING;
 select MAX(id)+1 from ADMIN.FORM_FIELD;
 ALTER TABLE ADMIN.FORM_FIELD ALTER COLUMN id RESTART WITH 2283;
 select MAX(id)+1 from ADMIN.PAGE_ITEM;
 ALTER TABLE ADMIN.PAGE_ITEM ALTER COLUMN id RESTART WITH 4598;
 -- load new admin db.
 ALTER TABLE patient_item add column balance int;
 ALTER TABLE item add column low_balance_quantity int;


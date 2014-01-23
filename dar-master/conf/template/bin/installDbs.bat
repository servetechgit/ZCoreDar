echo Create a new database in mysql named zeprs. This database will contain patient records
mysql -u root -p zeprs<zeprs_install.sql

echo Create a new database in mysql called admin. This database is used for administering the zeprs aplication.
mysql -u root -p admin<admin_install.sql

echo Create a new database in mysql called mail. This database is used to store username/passwords
mysql -u root -p mail<mail_install.sql

echo Create a new database in mysql called userdata. This database is used for administering the zeprs aplication.
mysql -u root -p userdata<userdata_install.sql

echo Now run the following script to assign permissions to the databases
mysql -u root -p mysql<db_install.sql


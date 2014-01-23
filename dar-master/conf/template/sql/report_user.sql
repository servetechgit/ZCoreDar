Creates a select-only report user

GRANT SELECT ON zeprs.* 
TO 'zeprsReport'@'%'
IDENTIFIED BY 'm38KBi2n';

GRANT SELECT ON admin.* 
TO 'zeprsReport'@'%'
IDENTIFIED BY 'm38KBi2n';

To connect: 
mysql -u zeprsReport -p zeprs -h 192.168.20.7

To get a dump of the database:
mysqldump -u zeprsReport -pm38KBi2n zeprs -h 192.168.20.7>zeprs.sql
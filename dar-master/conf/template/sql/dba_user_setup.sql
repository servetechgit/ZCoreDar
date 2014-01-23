use mysql;

# -----------------------------------------------------------------------
# zeprs_dba user to create tables - root privs
# -----------------------------------------------------------------------
# delete from user where user='zeprs_dba';
# delete from db where user='zeprs_dba';
# delete from tables_priv where user='zeprs_dba';
# delete from columns_priv where user='zeprs_dba';
GRANT ALL PRIVILEGES ON zeprs.* TO 'zeprs_dba'@'localhost' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mail.* TO 'zeprs_dba'@'localhost' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON userdata.* TO 'zeprs_dba'@'localhost' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mr.* TO 'zeprs_dba'@'localhost' IDENTIFIED BY 'bl!ng*23';

GRANT ALL PRIVILEGES ON zeprs.* TO 'zeprs_dba'@'localhost.localdomain' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mail.* TO 'zeprs_dba'@'localhost.localdomain' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON userdata.* TO 'zeprs_dba'@'localhost.localdomain' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mr.* TO 'zeprs_dba'@'localhost.localdomain' IDENTIFIED BY 'bl!ng*23';

GRANT ALL PRIVILEGES ON zeprs.* TO 'zeprs_dba'@'fw.vetula.com' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mail.* TO 'zeprs_dba'@'fw.vetula.com' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON userdata.* TO 'zeprs_dba'@'fw.vetula.com' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mr.* TO 'zeprs_dba'@'fw.vetula.com' IDENTIFIED BY 'bl!ng*23';

GRANT ALL PRIVILEGES ON zeprs.* TO 'zeprs_dba'@'%.zeprs.org' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mail.* TO 'zeprs_dba'@'%.zeprs.org' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON userdata.* TO 'zeprs_dba'@'%.zeprs.org' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mr.* TO 'zeprs_dba'@'%.zeprs.org' IDENTIFIED BY 'bl!ng*23';

GRANT ALL PRIVILEGES ON zeprs.* TO 'zeprs_dba'@'zsr01.zeprs.org' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mail.* TO 'zeprs_dba'@'zsr01.zeprs.org' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON userdata.* TO 'zeprs_dba'@'zsr01.zeprs.org' IDENTIFIED BY 'bl!ng*23';
GRANT SELECT ON mr.* TO 'zeprs_dba'@'zsr01.zeprs.org' IDENTIFIED BY 'bl!ng*23';
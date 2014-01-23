#!/bin/bash
# This is a script to install the ZEPRS app
#
# This script needs to run as root
# cd to the unzipped distribution directory.
# if the distro was zeprs_64.zip, cd to zeprs_64 and run this script.
# you'll need to chmod u+x update_lusaka.sh first.
# then run  ./update_lusaka.sh

echo "This script is for the Lusaka server."

TOMCATDIR="/usr/local/tomcat"
TOMCATSVC="tomcat"
echo "Tomcat dir is: $TOMCATDIR"
echo "Tomcat service is: $TOMCATSVC"

echo "Stopping tomcat"
service $TOMCATSVC stop

Today="`date +%Y%m%d%H%M%S`"
echo "Today is $Today"

echo "Database backup"
mysqldump -h 192.168.20.5 -u zeprsAdmin -pHCc5wXEd --opt zeprs > /home/staff/zeprs/backups/zeprs_$Today.sql
mysqldump -h 192.168.20.5 -u zeprsAdmin -pHCc5wXEd --opt admin > /home/staff/zeprs/backups/admin_$Today.sql

echo "Update database"
# mysql -h 192.168.20.5 -u zeprsAdmin -pCAREFUL zeprs < zeprs_install.sql
mysql -h 192.168.20.5 -u zeprsAdmin -pHCc5wXEd admin < admin_install.sql

echo "Cleaning up the old zeprs apps"
rm -rf $TOMCATDIR/webapps/zeprs
rm -rf $TOMCATDIR/webapps/zeprs.war
rm -rf $TOMCATDIR/work/Catalina/localhost/zeprs

cp zeprs.war $TOMCATDIR/webapps
# chown tomcat.tomcat $TOMCATDIR/webapps/zeprs.war

echo "Starting tomcat"
service $TOMCATSVC start

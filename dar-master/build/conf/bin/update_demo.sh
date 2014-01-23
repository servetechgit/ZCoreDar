#!/bin/bash
# This is a script to install the ZEPRS app
#
# This script needs to run as root
# cd to the unzipped distribution directory.
# if the distro was zeprs_64.zip, cd to zeprs_64 and run this script.
# you'll need to chmod u+x update_demo.sh first.
# then run  ./update_demo.sh

echo "This script is for the Demo server."

TOMCATDIR="/usr/local/tomcat"
TOMCATSVC="tomcat"
echo "Tomcat dir is: $TOMCATDIR"
echo "Tomcat service is: $TOMCATSVC"

echo "Stopping tomcat"
service $TOMCATSVC stop

Today="`date +%Y%m%d%H%M%S`"
echo "Today is $Today"

echo "Database backup"
mysqldump -u rti -pL9ADILnm --opt zeprs > /home/rti/zeprs/backups/zeprs_$Today.sql
mysqldump -u zeprsAdmin -pL9ADILnm --opt admin > /home/rti/zeprs/backups/admin_$Today.sql

# echo "Update database"
# mysql -u rti -pL9ADILnm  zeprs < zeprs_install.sql
mysql -u zeprsAdmin -pL9ADILnm admin < admin_install.sql

echo "Cleaning up the old zeprs apps"
rm -rf $TOMCATDIR/webapps/zeprs
rm -rf $TOMCATDIR/webapps/zeprs.war
rm -rf $TOMCATDIR/work/Catalina/localhost/zeprs

cp zeprs.war $TOMCATDIR/webapps
chown tomcat.tomcat $TOMCATDIR/webapps/zeprs.war

echo "Starting tomcat"
service $TOMCATSVC start

REM This is a script to install the ZEPRS app on the test server
REM
REM cd to the unzipped distribution directory.
REM if the distro was zeprs_64.zip, cd to zeprs_64 and run this script - ./update_test.bat

echo "This script is for the Test server."
echo Tomcat dir is: %CATALINA_HOME%

echo "Update database"
mysql -u root zeprs < zeprs_install.sql
mysql -u root admin < admin_install.sql

echo Cleaning up the old zeprs apps.
del /q %CATALINA_HOME%\webapps\zeprs.war
RD /s %CATALINA_HOME%\webapps\zeprs
RD /s %CATALINA_HOME%\work\Catalina\localhost\zeprs

copy /y zeprs.war %CATALINA_HOME%\webapps

echo "Starting tomcat"
%CATALINA_HOME%\bin\startup.bat
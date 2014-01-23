@echo off
echo Stopping tomcat. This will launch a new window (minimized) called "Stopping Tomcat."
echo You may close it once it returns to the command prompt.
echo.
REM Windows does not have a wait command, so we ping instead...
@C:\WINDOWS\system32\ping 127.0.0.1 -n 2 -w 1000 > nul
@C:\WINDOWS\system32\ping 127.0.0.1 -n 3 -w 1000> nul

echo This script will fail if your tomcat installation is not at C:\jakarta-tomcat-5.5.4
@C:\WINDOWS\system32\ping 127.0.0.1 -n 2 -w 1000 > nul
@C:\WINDOWS\system32\ping 127.0.0.1 -n 3 -w 1000> nul

start "Stopping Tomcat" /MIN C:\jakarta-tomcat-5.5.4\bin\shutdown.bat
echo Please wait for about 10 seconds for tomcat to stop.

@C:\WINDOWS\system32\ping 127.0.0.1 -n 2 -w 1000 > nul
@C:\WINDOWS\system32\ping 127.0.0.1 -n 5 -w 1000> nul

echo.
echo This delay enables tomcat to release its work files so that we can delete them.
echo.
@C:\WINDOWS\system32\ping 127.0.0.1 -n 2 -w 1000 > nul
@C:\WINDOWS\system32\ping 127.0.0.1 -n 5 -w 1000> nul

echo Deleting up the old zeprs war and work files
echo.
echo It's OK if it cannot find the files.
echo.
rmdir /s/q C:\jakarta-tomcat-5.5.4\work\Catalina\localhost\zeprs
rmdir /s/q C:\jakarta-tomcat-5.5.4\webapps\zeprs
del /q C:\jakarta-tomcat-5.5.4\webapps\zeprs.war
echo Loading the new database
mysql -u root -p36avaU68 zeprs <zeprs_install.sql
echo.
echo Copying the new zeprs war file
copy zeprs.war C:\jakarta-tomcat-5.5.4\webapps\zeprs.war
echo.
echo We're almost done. Please close the "Stopping tomcat" window after Tomcat starts.
echo This window will close automatically.
echo.
@C:\WINDOWS\system32\ping 127.0.0.1 -n 2 -w 1000 > nul
@C:\WINDOWS\system32\ping 127.0.0.1 -n 5 -w 1000> nul
echo Starting tomcat
C:\jakarta-tomcat-5.5.4\bin\startup.bat
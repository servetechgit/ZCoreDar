mysql -h 192.168.20.253 -u root -p36avaU68 admin < admin_install.sql
export ANT_HOME=/usr/local/apache-ant-1.6.5
export PATH=$ANT_HOME/bin:$PATH
ant -lib /usr/local/tomcat55/server/lib kal

/*
 *    Copyright 2003, 2004, 2005, 2006 Research Triangle Institute
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 */

package org.rti.zcore.dar.utils;

import java.net.ConnectException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.jsp.jstl.sql.Result;
import javax.servlet.jsp.jstl.sql.ResultSupport;
import javax.sql.DataSource;

import org.apache.commons.dbutils.BasicRowProcessor;
import org.apache.commons.dbutils.BeanProcessor;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.RowProcessor;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.config.DataSourceConfig;
import org.rti.zcore.exception.ObjectNotFoundException;
import org.rti.zcore.utils.AuditInfoBeanProcessor;
import org.rti.zcore.utils.ZEPRSBeanProcessor;
import org.rti.zcore.utils.ZEPRSQueryRunner;
import org.rti.zcore.utils.ZEPRSRowProcessor;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

/**
 * Created by IntelliJ IDEA.
 * User: ckelley
 * Date: May 26, 2005
 * Time: 1:19:39 PM
 */
public class DatabaseUtils {

    /**
     * Commons Logging instance.
     */
    private static Log log = LogFactory.getFactory().getInstance(DatabaseUtils.class);

    /**
     * @param username
     * @return A Connection to the database
     * @throws javax.servlet.ServletException
     */
    public static Connection getZEPRSConnection(String username) throws ServletException {

        Connection conn = null;
        try {
            Context initCtx = new InitialContext();
            DataSource ds = null;
            if (username != null && username.equals("demo")) {
                ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/demoDB");
            } else {
                ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/zeprsDB");
            }

            try {
                conn = ds.getConnection();
            } catch (SQLException e1) {
                log.error(e1);
                e1.printStackTrace();
            }
        } catch (Exception e) {
            log.error(e);
        }
        // log.debug("using zeprs conn");
        return conn;
    }

    /**
     * Gets a connection and passes exceptions you may catch
     * @param username
     * @return
     * @throws NamingException
     * @throws SQLException, ConnectException
     */
    public static Connection getZEPRSCatchableConnection(String username) throws NamingException, SQLException, ConnectException {
    	Connection conn = null;
    		Context initCtx = new InitialContext();
    		DataSource ds = null;
    		if (username != null && username.equals("demo")) {
    			ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/demoDB");
    		} else {
    			ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/zeprsDB");
    		}
            conn = ds.getConnection();
    	return conn;
    }

    /**
     * @param username
     * @return A Connection to the database for root tasks such as deleting records.
     */
    public static Connection getSpecialRootConnection(String username) {

        Connection conn = null;
        try {
            Context initCtx = new InitialContext();
            DataSource ds = null;
            if (username != null && username.equals("demo")) {
                ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/demoDB");
            } else {
                //ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/zeprsDBadmin");
                //ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/adminDB");
                ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/zeprsDB");
            }

            try {
                conn = ds.getConnection();
            } catch (SQLException e1) {
                log.error(e1);
            }
        } catch (Exception e) {
            log.error(e);
        }
        // log.debug("using zeprs conn");
        return conn;
    }

    /**
     * Gets a connection to the admin db.
     * @return Connection.
     */
    public static Connection getAdminConnection() {

        Connection conn = null;
        try {
            Context initCtx = new InitialContext();
            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/zeprsDB");
            try {
                conn = ds.getConnection();
            } catch (SQLException e1) {
                log.error(e1);
            }
        } catch (NamingException e) {
        }
        return conn;
    }

    /**
     * Opens connection to remote database
     *
     * @param ipAddress
     * @param db
     * @param username
     * @param password
     * @return
     * @throws SQLException
     */
    public static Connection getRemoteConnection(String ipAddress, String db, String username, String password) throws SQLException {

        Connection conn;
        conn = DriverManager.getConnection("jdbc:mysql://" + ipAddress + "/" + db + "?user=" + username + " &password=" + password + "");
        return conn;
    }

    /**
     * @return A Connection to the database
     * @throws javax.servlet.ServletException
     */
    public static DataSource getZEPRSDataSource() throws ServletException {
        DataSource dataSource = null;
        try {
            Context initCtx = new InitialContext();
            dataSource = (DataSource) initCtx.lookup("java:comp/env/jdbc/zeprsDB");

            //  make sure it's a c3p0 PooledDataSource
            /*if (dataSource instanceof PooledDataSource) {
                try {
                    PooledDataSource pds = (PooledDataSource) dataSource;
                    int total = pds.getNumBusyConnectionsDefaultUser();
                    int warnLimit = total = 2;
                    if (total > warnLimit) {
                        log.error("The pool is pretty full: " + pds.getNumBusyConnectionsDefaultUser() + "connections out of a total of " + pds.getNumConnectionsDefaultUser() + ".");
                    }
                } catch (SQLException e) {
                    log.error("Error getting PooledDataSource in DatabaseUtils.getZEPRSDataSource: " + e);
                }
            } else {
                log.error("Not a c3p0 PooledDataSource!");
            }*/

            /* DataSource unpooled = DataSources.unpooledDataSource("jdbc:postgresql://localhost/test",
                                      "swaldman",
                                      "test");
             DataSource pooled = DataSources.pooledDataSource( unpooled );*/
            /*Context init = new InitialContext();
            Context ctx = null;
            ctx = (Context) init.lookup("java:comp/env");
            dataSource = (DataSource) ctx.lookup("jdbc/zeprsDB");*/
        } catch (NamingException e) {
            //log.debug("Creating a manual connection - we must be doing a unit test.");
            // unit testing...
            MysqlDataSource ds = new MysqlDataSource();
            ds.setServerName("localhost");
            ds.setDatabaseName("zeprs");
            ds.setUser("zeprs_web_user");
            ds.setPassword("0UpaxVKr");
            dataSource = ds;

        } catch (Exception ex) {
            throw new ServletException("Cannot retrieve java:comp/env/jdbc/zeprsDB", ex);
        }
        //  log.debug("using ZEPRS dataSource");
        return dataSource;
    }

    /**
     * @return A Connection to the admin_test database
     * @throws javax.servlet.ServletException
     */
    public static DataSource getAdminUnitTestDatasource() throws ServletException {
        DataSource dataSource = null;
        try {
            // unit testing...
            MysqlDataSource ds = new MysqlDataSource();
            //ds.setDriverClass("com.mysql.jdbc.Driver");
            ds.setServerName("jdbc:mysql://localhost/admin_test");
            ds.setUser("root");
            ds.setPassword("36avaU68");
            dataSource = ds;
        } catch (Exception ex) {
            throw new ServletException("Cannot retrieve jdbc:mysql://localhost/admin_test", ex);
        }
        return dataSource;
    }

    /**
     * @return A Connection to the admin_test database
     * @throws javax.servlet.ServletException
     */
    public static DataSource getAdminDatasource() throws ServletException {
    	DataSource dataSource = null;
    	try {
    		// unit testing...
    		MysqlDataSource ds = new MysqlDataSource();
    		//ds.setDriverClass("com.mysql.jdbc.Driver");
    		ds.setServerName("localhost");
    		ds.setDatabaseName("admin");
    		ds.setUser("root");
    		ds.setPassword("36avaU68");
    		dataSource = ds;
    	} catch (Exception ex) {
    		throw new ServletException("Cannot retrieve jdbc:mysql://localhost/admin", ex);
    	}
    	return dataSource;
    }

    public static DataSource createConnectionPool() {
        DataSource dataSource = null;
        /*
     // uncomment after adding c3po lib to project
     ComboPooledDataSource cpds = new ComboPooledDataSource();
      try {
          cpds.setDriverClass("com.mysql.jdbc.Driver");
      } catch (PropertyVetoException e1) {
          log.error(e1);
      }
      //loads the jdbc driver
      cpds.setJdbcUrl("jdbc:mysql://localhost/zeprs");
      cpds.setIdentityToken("zeprsDB");
      cpds.setUser("zeprs_web_user");
      cpds.setPassword("0UpaxVKr");
      // the settings below are optional -- c3p0 can work with defaults
      cpds.setMinPoolSize(5);
      cpds.setAcquireIncrement(1);
      cpds.setMaxPoolSize(30);
      dataSource = cpds;*/
        return dataSource;
    }

    public static DataSourceConfig getJtaDataSource() {
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.addProperty("driverClassName", "com.mysql.jdbc.Driver");
        dsc.addProperty("name", "jdbc/zeprsDB");
        dsc.addProperty("url", "jdbc:mysql://localhost/zeprs");
        dsc.addProperty("username", "zeprs_web_user");
        dsc.addProperty("password", "0UpaxVKr");
        return dsc;
    }


    /**
     * Returns an array
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object getObject(Connection conn, String sql, ArrayList values) throws ServletException, SQLException {
        ResultSetHandler h = new ArrayHandler();
        //DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner();
        Object[] result = (Object[]) run.query(conn, sql, values.toArray(), h);
        return result;
    }

    /**
     * Get a single value
     * String idSql = "SELECT LAST_INSERT_ID() AS id;";
     * unused
     *
     * @param sql
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object getScalar(String sql) throws ServletException, SQLException {
        ResultSetHandler h = new ScalarHandler();
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner(dataSource);
        Object result = run.query(sql, h);
        return result;
    }

    /**
     * Get a single value
     * String idSql = "SELECT LAST_INSERT_ID() AS id;";
     *
     * @param sql
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object getScalar(Connection conn, String sql) throws ServletException, SQLException {
        ResultSetHandler h = new ScalarHandler();
        //DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner();
        Object result = run.query(conn, sql, h);
        return result;
    }

    /**
     * Fetch a single value; Support for adding value array
     * unused
     *
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object getScalar(String sql, ArrayList values) throws ServletException, SQLException {
        ResultSetHandler h = new ScalarHandler();
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner(dataSource);
        Object result = run.query(sql, values.toArray(), h);
        return result;
    }

    /**
     * Fetch a single value; Support for adding value array
     *
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws SQLException
     */
    public static Object getScalar(Connection conn, String sql, ArrayList values) throws SQLException {
        ResultSetHandler h = new ScalarHandler();
        QueryRunner run = new QueryRunner();
        Object result = run.query(conn, sql, values.toArray(), h);
        return result;
    }


    /**
     * Return the first resultset row stuffed into a bean
     *
     * @param clazz
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object getBean(Class clazz, String sql, ArrayList values) throws ServletException, SQLException, ObjectNotFoundException {
        // DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner(getZEPRSDataSource());
        ResultSetHandler h = new BeanHandler(clazz);
        // return the results in a new object generated by the BeanHandler.
        Object result = null;
        //  try {
        try {
            result = run.query(sql, values.toArray(), h);
        } catch (SQLException e) {
            log.error("SQL - params: " + values + "Error: " + e);
        }
        // log.info("Getting the bean " + clazz.toString());
        /* } catch (SQLException e) {
            log.error("SQL - params: " + values + "Error: " + e);
        }*/
        if (result == null) {
            throw new ObjectNotFoundException();
        }

        return result;
    }

    /**
     * Return the first resultset row stuffed into a bean
     * Be aware that getBean initialises null Objects such as Integer to 0. If you don't like that, use getZEPRSBean instead.
     *
     * @param clazz
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object getBean(Connection conn, Class clazz, String sql, ArrayList values) throws ServletException, SQLException, ObjectNotFoundException {

        QueryRunner run = new QueryRunner();
        ResultSetHandler h = new BeanHandler(clazz);
        // return the results in a new object generated by the BeanHandler.
        Object result = null;
        try {
            result = run.query(conn, sql,h, values.toArray());
        } catch (SQLException e) {
            log.error("SQL - params: " + values + "Error: " + e);
        }

        if (result == null) {
            throw new ObjectNotFoundException();
        }

        return result;
    }

    /**
     * Fetches in object and does a better job at populating the bean than getBean, which initialises null Objects
     * such as Integer to 0. getZEPRSBean lets nulls stay null.
     *
     * @param conn
     * @param clazz
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static Object getZEPRSBean(Connection conn, Class clazz, String sql, ArrayList values) throws ServletException, SQLException, ObjectNotFoundException {
        QueryRunner run = new QueryRunner();
        ResultSetHandler h = new BeanHandler(clazz, new ZEPRSRowProcessor(new ZEPRSBeanProcessor()));
        // return the results in a new object generated by the BeanHandler.
        Object result = null;
        try {
            result = run.query(conn, sql, values.toArray(), h);
            // log.info("Getting the bean " + clazz.toString());
        } catch (SQLException e) {
            //log.error(e);
            e.printStackTrace();
        }
        if (result == null) {
            throw new ObjectNotFoundException();
        }

        return result;
    }

    /**
     * Stuffs AuditInfo
     * @param conn
     * @param clazz
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     * @throws ObjectNotFoundException
     */
    public static Object getZEPRSAuditInfoBean(Connection conn, Class clazz, String sql, ArrayList values) throws ServletException, SQLException, ObjectNotFoundException {
    	QueryRunner run = new QueryRunner();
    	BeanProcessor beanprocessor = new AuditInfoBeanProcessor();
        RowProcessor convert = new ZEPRSRowProcessor(beanprocessor);
    	ResultSetHandler h = new BeanHandler(clazz, convert);
    	// return the results in a new object generated by the BeanHandler.
    	Object result = null;
    	try {
    		result = run.query(conn, sql, values.toArray(), h);
    		// log.info("Getting the bean " + clazz.toString());
    	} catch (SQLException e) {
    		//log.error(e);
    		e.printStackTrace();
    	}
    	if (result == null) {
    		throw new ObjectNotFoundException();
    	}

    	return result;
    }

    /**
     * @param conn
     * @param sql
     * @param params
     * @return
     * @throws Exception
     */
    public static int update(Connection conn, java.lang.String sql, java.lang.Object[] params) throws java.lang.Exception {
        QueryRunner run = new QueryRunner();
        int result = run.update(conn, sql, params);
        return result;
    }

    /**
     * for batch updates
     * unused
     *
     * @param sql
     * @param params
     * @return
     * @throws Exception
     */
    public static int[] update(java.lang.String sql, java.lang.Object[][] params) throws java.lang.Exception {
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner(dataSource);
        int[] result = run.batch(sql, params);
        return result;
    }

    /**
     * for multiple sql statement - returns LAST_INSERT_ID
     *
     * unused
     *
     * @param sql
     * @param params
     * @return
     * @throws Exception
     */
    public static Object create(java.lang.String sql, java.lang.String sql2, java.lang.Object[] params) throws java.lang.Exception {
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        Connection conn = dataSource.getConnection();
        // conn.setAutoCommit(true);
        ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
        // QueryRunner run = new QueryRunner(dataSource);
        run.update(conn, sql);
        run.update(conn, sql2, params);
        // now get the id
        ResultSetHandler h = new ScalarHandler();
        Object result = (Object) run.query(conn, "SELECT LAST_INSERT_ID();", h);
        conn.close();
        conn = null;
        return result;
    }

    /**
     * Runs two sql insert statements w/ 1 param
     * @param conn
     * @param sql
     * @param sql2
     * @param params
     * @return generated id
     * @throws Exception
     */
    public static Object create(Connection conn, java.lang.String sql, java.lang.String sql2, java.lang.Object[] params) throws java.lang.Exception {
        DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        // conn.setAutoCommit(true);
        ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
        run.update(conn, sql);
        //run.update(conn, sql2, params);
        Long result = run.updateWithGeneratedKeys(conn, sql, params);
        // now get the id
        /*ResultSetHandler h = new ScalarHandler();
        Object result = run.query(conn, "SELECT LAST_INSERT_ID();", h);*/
        return result;
    }

    /**
     * Runs two sql insert statements w/ 2 params
     * @param conn
     * @param sql
     * @param sql2
     * @param params
     * @return generated id from form table insert
     * @throws Exception
     */
    public static Object create(Connection conn, String sql, Object[] params1, String sql2, Object[] params2) throws java.lang.Exception {
    	DataSource dataSource = null;
    	//dataSource = DatabaseUtils.getZEPRSDataSource();
    	// conn.setAutoCommit(true);
    	ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
    	run.update(conn, sql, params1);
    	//run.update(conn, sql2, params);
    	Long result = run.updateWithGeneratedKeys(conn, sql2, params2);
    	// now get the id
    	/*ResultSetHandler h = new ScalarHandler();
        Object result = run.query(conn, "SELECT LAST_INSERT_ID();", h);*/
    	return result;
    }

    /**
     * Runs two sql insert statements w/ 2 params
     * @param conn
     * @param sql
     * @param sql2
     * @param params
     * @return generated id from encounter insert
     * @throws Exception
     */
    public static Object createEncounter(Connection conn, String sql, Object[] params1, String sql2, Object[] params2) throws java.lang.Exception {
    	DataSource dataSource = null;
    	ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
    	Long result = run.updateWithGeneratedKeys(conn, sql, params1);
    	run.updateWithGeneratedKeys(conn, sql2, params2);
    	return result;
    }

    /**
     * mostly used for transactions
     *
     * @param conn
     * @param sql
     * @throws Exception
     */
    public static void create(Connection conn, java.lang.String sql) throws java.lang.Exception {
        DataSource dataSource = null;
        ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
        run.update(conn, sql);
    }

    /**
     * Fetch a simple list of values
     *
     * @param clazz
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static List getList(Class clazz, String sql, ArrayList values) throws ServletException, SQLException {
        DataSource dataSource = null;
        try {
            dataSource = DatabaseUtils.getZEPRSDataSource();
        } catch (ServletException e) {
            log.error(e);
        }
        QueryRunner run = null;
        try {
            run = new QueryRunner(dataSource);
        } catch (Exception e) {
            log.error(e);
        }
        // ResultSetHandler h = new BeanListHandler(clazz);
        ResultSetHandler h = new BeanListHandler(clazz, new BasicRowProcessor(new ZEPRSBeanProcessor()));
        // ResultSetHandler h = new BeanListHandler(clazz,new BasicRowProcessor(new BasicColumnProcessor()));
        // return the results in a new object generated by the BeanHandler.
        List list = null;
        try {
            list = (List) run.query(sql, values.toArray(), h);
        } catch (SQLException e) {
            log.error(e);
        }
        return list;
    }

    /**
     * Fetch a simple list of values
     *
     * @param clazz
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static List getList(Connection conn, Class clazz, String sql, ArrayList values) throws ServletException, SQLException {
        QueryRunner run = null;
        try {
            // run = new QueryRunner(dataSource);
            run = new QueryRunner();
        } catch (Exception e) {
            log.error(e);
        }
        ResultSetHandler h = new BeanListHandler(clazz, new BasicRowProcessor(new ZEPRSBeanProcessor()));
        // return the results in a new object generated by the BeanHandler.
        List list = null;
        try {
            list = (List) run.query(conn, sql, values.toArray(), h);
        } catch (SQLException e) {
            log.error(e);
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch a simple list of values. Emulates MySQL LIMIT
     * @param conn
     * @param clazz
     * @param sql
     * @param values
     * @param maxRows
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static List getList(Connection conn, Class clazz, String sql, ArrayList values, Integer maxRows) throws ServletException, SQLException {
    	ZEPRSQueryRunner run = null;
    	try {
    		run = new ZEPRSQueryRunner();
    	} catch (Exception e) {
    		log.error(e);
    	}
    	ResultSetHandler h = new BeanListHandler(clazz, new BasicRowProcessor(new ZEPRSBeanProcessor()));
    	// return the results in a new object generated by the BeanHandler.
    	List list = null;
    	try {
    		list = (List) run.query(conn, sql, values.toArray(), h, maxRows);
    	} catch (SQLException e) {
    		log.error(e);
    		e.printStackTrace();
    	}
    	return list;
    }


    /**
     * For classes w/ nested objects such as AuditInfo
     *
     * @param clazz
     * @param sql
     * @param values
     * @param convert
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static List getList(Class clazz, String sql, ArrayList values, RowProcessor convert) throws ServletException, SQLException {
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner(dataSource);
        ResultSetHandler h = new BeanListHandler(clazz, convert);
// return the results in a new object generated by the BeanHandler.
        List list = (List) run.query(sql, values.toArray(), h);
        return list;

    }

    /**
     * For classes w/ nested objects such as AuditInfo. Takes a connection (reports)
     *
     * @param clazz
     * @param sql
     * @param values
     * @param convert
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static List getList(Connection conn, Class clazz, String sql, ArrayList values, RowProcessor convert) throws ServletException, SQLException {
        //DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner();
        ResultSetHandler h = new BeanListHandler(clazz, convert);
        // return the results in a new object generated by the BeanHandler.
        List list = (List) run.query(conn, sql, values.toArray(), h);
        return list;

    }

    /**
     * Fetch a list of maps (Skaneateles)
     * unused
     *
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static List getMapList(Connection conn, String sql, ArrayList values) throws ServletException, SQLException {
        //DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner();
        ResultSetHandler h = new MapListHandler();
// return the results in a new object generated by the BeanHandler.
        List list = (List) run.query(conn, sql, values.toArray(), h);
        return list;
    }

    /**
     * puts results set in key value pair into Map
     * unused
     *
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Map getArrayList(String sql, ArrayList values) throws ServletException, SQLException {
        ResultSetHandler h = new ArrayListHandler();
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner(dataSource);
        List result = (List) run.query(sql, values.toArray(), h);
        Map map = new HashMap();
        for (int i = 0; i < result.size(); i++) {
            Object[] keyVal = (Object[]) result.get(i);
            map.put(keyVal[1], keyVal[0]);

        }
        return map;
    }

    /**
     * puts results set in key value pair into Map
     *
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Map getArrayList(Connection conn, String sql, ArrayList values) throws ServletException, SQLException {
        ResultSetHandler h = new ArrayListHandler();
        // DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        QueryRunner run = new QueryRunner();
        List result = (List) run.query(conn, sql, values.toArray(), h);
        Map map = new HashMap();
        for (int i = 0; i < result.size(); i++) {
            Object[] keyVal = (Object[]) result.get(i);
            map.put(keyVal[1], keyVal[0]);
        }
        return map;
    }

    /**
     * returns autogenerated id field after performing insert
     *
     * @param sql
     * @param values
     * @return
     * @throws ServletException
     * @throws SQLException
     */
    public static Object create(String sql, java.lang.Object[] values) throws ServletException, SQLException {
        DataSource dataSource = null;
        dataSource = DatabaseUtils.getZEPRSDataSource();
        Connection conn = dataSource.getConnection();
        // conn.setAutoCommit(true);
        ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
        // First do the insert
        try {
            run.update(conn, sql, values);
        } catch (SQLException e) {
            String message = e.getMessage();
            log.error("SQL message: " + message + " Error: " + e);
            /*if (message.startsWith("Lock wait timeout exceeded; try restarting transaction") == true) {
                // run.close(conn);
                run = null;
                String poolMessage = null;
                try {
                    poolMessage = PoolBuddy.checkPool();
                } catch (NamingException e1) {
                    log.error(e);
                }
                log.error("Connection closed. Pool status: " + poolMessage + " Restarting. Error: " + e);
                run = new ZEPRSQueryRunner(dataSource);
                try {
                    run.wait(1000);
                } catch (InterruptedException e1) {
                    log.error(e1);
                }
                try {
                    run.update(conn, sql, values);
                } catch (SQLException e1) {
                    log.error("Failed after second attempt. Error: " + e);
                }
            }*/

        }
        // now get the id
        ResultSetHandler h = new ScalarHandler();
        Object result = (Object) run.query(conn, "SELECT LAST_INSERT_ID();", h);
        conn.close();
        conn = null;
        return result;
    }

    /**
     * returns autogenerated id field after performing insert
     *
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws SQLException
     */
    public static Object create(Connection conn, String sql, java.lang.Object[] values) throws SQLException {
        DataSource dataSource = null;
        ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
        // First do the insert
        //try {
        Long result = run.updateWithGeneratedKeys(conn, sql, values);
        /*} catch (SQLException e) {
            String message = e.getMessage();
            log.error("SQL message: " + message + " Error: " + e);
        }*/
        // now get the id
        /*ResultSetHandler h = new ScalarHandler();
        Object result = run.query(conn, "SELECT LAST_INSERT_ID();", h);*/
        return result;
    }

    /**
     * returns autogenerated id field after performing insert
     * Same as create but throws the error instead of logging it.
     * Consider throwing a persistence exception when catching the SQLException.
     *
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws SQLException
     */
    public static Object createThrow(Connection conn, String sql, java.lang.Object[] values) throws SQLException {
    	DataSource dataSource = null;
    	ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
    	// First do the insert
    	Long result = run.updateWithGeneratedKeys(conn, sql, values);
    	// now get the id
    	/*ResultSetHandler h = new ScalarHandler();
    	Object result = run.query(conn, "SELECT LAST_INSERT_ID()", h);*/
    	return result;
    }

    /**
     *
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws SQLException
     */
    public static int updateThrow(Connection conn, String sql, java.lang.Object[] values) throws SQLException {
    	DataSource dataSource = null;
    	ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
    	int result = run.update(conn, sql, values);
    	return result;
    }

    /**
     * Returns generated key
     * @param conn
     * @param sql
     * @param values
     * @return
     * @throws SQLException
     */
    public static Long createGeneratedThrow(Connection conn, String sql, java.lang.Object[] values) throws SQLException {
    	DataSource dataSource = null;
    	ZEPRSQueryRunner run = new ZEPRSQueryRunner(dataSource);
    	// First do the insert
    	Long result = run.updateWithGeneratedKeys(conn, sql, values);
    	return result;
    }


    public static void save(Connection conn, String sql, java.lang.Object[] values) throws ServletException, SQLException {
        //DataSource dataSource = null;
        //dataSource = DatabaseUtils.getZEPRSDataSource();
        //Connection conn = dataSource.getConnection();
        // conn.setAutoCommit(true);
        QueryRunner run = new QueryRunner();
        // First do the insert
        run.update(conn, sql, values);
    }

    /**
     * Runs sql query and returns Result - see jstl docs on how to process Result.
     *
     * @param conn
     * @param sql
     * @return Result
     * @throws ServletException
     */
    public static Result executeQuery(Connection conn, String sql) throws Exception {

        ResultSet rs = null;
        Result results = null;
        try {
            Statement s = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            rs = s.executeQuery(sql);
            results = ResultSupport.toResult(rs);
            rs.close();
        } catch (Exception ex) {
            log.info("Sql: " + sql);
            log.error(ex);
            throw new ServletException("Cannot retrieve results:", ex);
        }
        return results;
    }

    /**
     * Execute an update
     *
     * @param conn
     * @param sql
     * @return status (usually 1)
     * @throws Exception
     */
    public static int executeQueryUpdate(Connection conn, String sql) throws Exception {

        int result;
        try {
            Statement s = conn.createStatement();
            result = s.executeUpdate(sql);
            s.close();
        } catch (Exception ex) {
            log.info("Sql: " + sql);
            log.error(ex);
            throw new ServletException("Cannot retrieve results:", ex);
        }
        return result;
    }

    /**
     * Execute sql batch file with line-break-separated statements
     * @param conn
     * @param statements
     * @return
     * @throws Exception
     */
    public static int[] executeQueryBatch(Connection conn, String statements) throws Exception {

        int[] updateCounts;
        try {
            Statement s = conn.createStatement();
            String[] sqlArray = statements.split("\n");
            for (int i = 0; i < sqlArray.length; i++) {
                String sql = sqlArray[i];
                s.addBatch(sql);
            }
            updateCounts = s.executeBatch();
            s.clearBatch();
            s.close();
        } catch (Exception ex) {
            log.info("Sql: " + statements);
            log.error(ex);
            throw new ServletException("Cannot retrieve results:", ex);
        }
        return updateCounts;
    }

    /**
     * @param conn
     * @param batchFileName
     * @return
     * @throws Exception
     * @deprecated - does not work; use instead:
     *             Process p = Runtime.getRuntime().exec(sql);
     *             resultUpdate = p.waitFor();
     */
    public static int executeQueryBatchFile(Connection conn, String batchFileName) throws Exception {

        int result = 0;
        try {
            Statement s = conn.createStatement();
            String sql = "LOAD DATA INFILE '" + batchFileName + "'";
            result = s.executeUpdate(sql);
            s.close();
        } catch (Exception ex) {
            log.info("Batchfile name: " + batchFileName);
            log.error(ex);
            throw new ServletException("Cannot retrieve results:", ex);
        }
        return result;
    }
}
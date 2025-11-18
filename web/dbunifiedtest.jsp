<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<html>
<head>
    <title>PostgreSQL数据库统一测试</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .success { color: green; }
        .error { color: red; }
        .info { color: blue; }
        .warning { color: orange; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .step { margin: 20px 0; padding: 15px; border: 1px solid #ccc; border-radius: 5px; }
        h3 { margin-top: 20px; }
        .test-section { 
            border: 2px solid #333; 
            margin: 20px 0; 
            padding: 15px; 
            border-radius: 5px; 
            background-color: #f9f9f9;
        }
        .test-section h2 {
            margin-top: 0;
            color: #333;
        }
    </style>
</head>
<body>
<h1>PostgreSQL数据库统一测试</h1>

<%
    // 数据库连接参数，请根据实际情况修改
    String hostUrl = "jdbc:postgresql://localhost:5432/";
    String testDbName = "testdb";
    String testTableName = "test_table";
%>

<!-- 第一部分：基础连接测试 -->
<div class="test-section">
    <h2>测试 1: 基础数据库连接 (JNDI方式)</h2>
<%
    Connection conn = null;
    try {
        out.println("<div class='step'>");
        out.println("<h3>步骤 1.1: 获取JNDI数据源</h3>");
        
        // 通过JNDI获取数据源
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/TestDB");
        out.println("<p class='info'>成功获取JNDI数据源!</p>");
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 1.2: 建立数据库连接</h3>");
        
        // 建立数据库连接
        conn = ds.getConnection();
        
        if (conn != null && !conn.isClosed()) {
            out.println("<p class='success'>数据库连接成功!</p>");
            
            // 执行简单查询
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT version()");
            
            if (rs.next()) {
                out.println("<h3>数据库版本信息:</h3>");
                out.println("<p>" + rs.getString(1) + "</p>");
            }
            
            rs.close();
            stmt.close();
        } else {
            out.println("<p class='error'>数据库连接失败!</p>");
        }
    } catch (Exception e) {
        out.println("<p class='error'>连接出错: " + e.getMessage() + "</p>");
        out.println("<p>请检查以下配置:</p>");
        out.println("<ul>");
        out.println("<li>数据库服务是否启动</li>");
        out.println("<li>JNDI资源配置是否正确</li>");
        out.println("<li>数据库用户名和密码是否正确</li>");
        out.println("<li>PostgreSQL JDBC驱动是否正确放置在[WEB-INF/lib](file:///E:/Java_web_jsp/web/WEB-INF/lib)目录中</li>");
        out.println("</ul>");
        // 记录异常信息到页面输出（在实际应用中应使用日志框架）
        out.println("<p>异常详情: " + e.getClass().getName() + ": " + e.getMessage() + "</p>");
    } finally {
        if (conn != null) {
            try {
                if (!conn.isClosed()) {
                    conn.close();
                    out.println("<p class='info'>数据库连接已关闭</p>");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>关闭连接时出错: " + e.getMessage() + "</p>");
            }
        }
    }
%>
</div>

<!-- 第二部分：数据库操作测试 -->
<div class="test-section">
    <h2>测试 2: 数据库操作测试</h2>
<%
    conn = null;
    try {
        out.println("<div class='step'>");
        out.println("<h3>步骤 2.1: 获取JNDI数据源</h3>");
        
        // 通过JNDI获取数据源
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/TestDB");
        out.println("<p class='info'>成功获取JNDI数据源!</p>");
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 2.2: 创建和操作测试表</h3>");
        
        // 建立数据库连接
        conn = ds.getConnection();
        
        Statement stmt = conn.createStatement();
        
        // 删除可能存在的测试表
        try {
            stmt.executeUpdate("DROP TABLE IF EXISTS " + testTableName);
            out.println("<p class='info'>已删除可能存在的同名表: " + testTableName + "</p>");
        } catch (SQLException e) {
            out.println("<p class='warning'>删除现有表时出错（可能不存在）: " + e.getMessage() + "</p>");
        }
        
        // 创建测试表
        String createTableSQL = "CREATE TABLE " + testTableName + " (" +
                "id SERIAL PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "email VARCHAR(100), " +
                "age INTEGER, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";
        stmt.executeUpdate(createTableSQL);
        out.println("<p class='success'>成功创建表: " + testTableName + "</p>");
        
        // 插入测试数据
        String insertSQL1 = "INSERT INTO " + testTableName + " (name, email, age) VALUES ('张三', 'zhangsan@example.com', 25)";
        String insertSQL2 = "INSERT INTO " + testTableName + " (name, email, age) VALUES ('李四', 'lisi@example.com', 30)";
        String insertSQL3 = "INSERT INTO " + testTableName + " (name, email, age) VALUES ('王五', 'wangwu@example.com', 28)";
        
        stmt.executeUpdate(insertSQL1);
        stmt.executeUpdate(insertSQL2);
        stmt.executeUpdate(insertSQL3);
        
        out.println("<p class='success'>成功插入3条测试数据到表: " + testTableName + "</p>");
        
        // 查询数据
        String selectSQL = "SELECT * FROM " + testTableName + " ORDER BY id";
        ResultSet rs = stmt.executeQuery(selectSQL);
        
        out.println("<p class='success'>查询数据成功:</p>");
        out.println("<table>");
        out.println("<tr><th>ID</th><th>姓名</th><th>邮箱</th><th>年龄</th><th>创建时间</th></tr>");
        
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("email") + "</td>");
            out.println("<td>" + rs.getInt("age") + "</td>");
            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        rs.close();
        
        // 删除特定数据
        String deleteSQL = "DELETE FROM " + testTableName + " WHERE name = '李四'";
        int deletedRows = stmt.executeUpdate(deleteSQL);
        
        out.println("<p class='success'>成功删除 " + deletedRows + " 条数据</p>");
        
        // 再次查询以显示删除后的结果
        rs = stmt.executeQuery(selectSQL);
        
        out.println("<p>删除后的数据:</p>");
        out.println("<table>");
        out.println("<tr><th>ID</th><th>姓名</th><th>邮箱</th><th>年龄</th><th>创建时间</th></tr>");
        
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("email") + "</td>");
            out.println("<td>" + rs.getInt("age") + "</td>");
            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        rs.close();
        
        // 删除表
        stmt.executeUpdate("DROP TABLE " + testTableName);
        out.println("<p class='success'>成功删除表: " + testTableName + "</p>");
        
        stmt.close();
        conn.close();
        
        out.println("</div>");
        
        out.println("<h3>测试完成!</h3>");
        out.println("<p class='success'>数据库操作测试成功完成，测试表已清理干净。</p>");
        
    } catch (Exception e) {
        out.println("<p class='error'>操作出错: " + e.getMessage() + "</p>");
        // 记录异常信息到页面输出（在实际应用中应使用日志框架）
        out.println("<p>异常详情: " + e.getClass().getName() + ": " + e.getMessage() + "</p>");
        
        // 清理连接
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException se) {
            // 记录异常信息到页面输出（在实际应用中应使用日志框架）
            out.println("<p>清理连接时出错: " + se.getClass().getName() + ": " + se.getMessage() + "</p>");
        }
    }
%>
</div>

<!-- 第三部分：完整数据库生命周期测试 -->
<div class="test-section">
    <h2>测试 3: 完整数据库生命周期测试</h2>
<%
    conn = null;
    Connection testDbConn = null;
    // 使用不同的数据库名称进行测试
    String testDatabaseName = "testdb_lifecycle";
    
    try {
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.1: 连接到PostgreSQL服务器</h3>");
        
        // 通过JNDI获取数据源（用于连接到主数据库）
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/TestDB");
        out.println("<p class='info'>成功获取JNDI数据源!</p>");
        
        // 建立到PostgreSQL服务器的连接（连接到配置的testdb数据库）
        conn = ds.getConnection();
        if (conn != null) {
            out.println("<p class='success'>成功连接到PostgreSQL服务器!</p>");
        }
        
        // 创建Statement对象
        Statement stmt = conn.createStatement();
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.2: 创建测试数据库</h3>");
        
        // 删除可能存在的同名数据库
        try {
            stmt.executeUpdate("DROP DATABASE IF EXISTS " + testDatabaseName);
            out.println("<p class='info'>已删除可能存在的同名数据库: " + testDatabaseName + "</p>");
        } catch (SQLException e) {
            out.println("<p class='warning'>删除现有数据库时出错（可能不存在）: " + e.getMessage() + "</p>");
        }
        
        // 创建新的测试数据库
        stmt.executeUpdate("CREATE DATABASE " + testDatabaseName);
        out.println("<p class='success'>成功创建数据库: " + testDatabaseName + "</p>");
        
        stmt.close();
        conn.close();
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.3: 连接到新创建的数据库并创建表</h3>");
        
        // 注意：对于新创建的数据库，我们需要使用直接连接方式
        // 因为JNDI数据源配置的是testdb数据库
        String testDbUrl = hostUrl + testDatabaseName;
        String adminUser = "postgres";
        String adminPassword = "123456";
        
        // 加载PostgreSQL JDBC驱动
        Class.forName("org.postgresql.Driver");
        
        // 连接到新创建的数据库
        testDbConn = DriverManager.getConnection(testDbUrl, adminUser, adminPassword);
        if (testDbConn != null) {
            out.println("<p class='success'>成功连接到新创建的数据库: " + testDatabaseName + "</p>");
        }
        
        Statement testDbStmt = testDbConn.createStatement();
        
        // 创建测试表
        String createTableSQL = "CREATE TABLE " + testTableName + " (" +
                "id SERIAL PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "email VARCHAR(100), " +
                "age INTEGER, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";
        testDbStmt.executeUpdate(createTableSQL);
        out.println("<p class='success'>成功创建表: " + testTableName + "</p>");
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.4: 插入测试数据</h3>");
        
        // 插入测试数据
        String insertSQL1 = "INSERT INTO " + testTableName + " (name, email, age) VALUES ('张三', 'zhangsan@example.com', 25)";
        String insertSQL2 = "INSERT INTO " + testTableName + " (name, email, age) VALUES ('李四', 'lisi@example.com', 30)";
        String insertSQL3 = "INSERT INTO " + testTableName + " (name, email, age) VALUES ('王五', 'wangwu@example.com', 28)";
        
        testDbStmt.executeUpdate(insertSQL1);
        testDbStmt.executeUpdate(insertSQL2);
        testDbStmt.executeUpdate(insertSQL3);
        
        out.println("<p class='success'>成功插入3条测试数据到表: " + testTableName + "</p>");
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.5: 查询数据</h3>");
        
        // 查询数据
        String selectSQL = "SELECT * FROM " + testTableName + " ORDER BY id";
        ResultSet rs = testDbStmt.executeQuery(selectSQL);
        
        out.println("<p class='success'>查询数据成功:</p>");
        out.println("<table>");
        out.println("<tr><th>ID</th><th>姓名</th><th>邮箱</th><th>年龄</th><th>创建时间</th></tr>");
        
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("email") + "</td>");
            out.println("<td>" + rs.getInt("age") + "</td>");
            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        rs.close();
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.6: 删除数据</h3>");
        
        // 删除特定数据
        String deleteSQL = "DELETE FROM " + testTableName + " WHERE name = '李四'";
        int deletedRows = testDbStmt.executeUpdate(deleteSQL);
        
        out.println("<p class='success'>成功删除 " + deletedRows + " 条数据</p>");
        
        // 再次查询以显示删除后的结果
        rs = testDbStmt.executeQuery(selectSQL);
        
        out.println("<p>删除后的数据:</p>");
        out.println("<table>");
        out.println("<tr><th>ID</th><th>姓名</th><th>邮箱</th><th>年龄</th><th>创建时间</th></tr>");
        
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("email") + "</td>");
            out.println("<td>" + rs.getInt("age") + "</td>");
            out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        
        rs.close();
        
        out.println("</div>");
        
        out.println("<div class='step'>");
        out.println("<h3>步骤 3.7: 删除表和数据库</h3>");
        
        // 删除表
        testDbStmt.executeUpdate("DROP TABLE " + testTableName);
        out.println("<p class='success'>成功删除表: " + testTableName + "</p>");
        
        testDbStmt.close();
        testDbConn.close();
        
        // 重新连接到主数据库以删除测试数据库
        conn = ds.getConnection();
        Statement finalStmt = conn.createStatement();
        finalStmt.executeUpdate("DROP DATABASE " + testDatabaseName);
        out.println("<p class='success'>成功删除数据库: " + testDatabaseName + "</p>");
        
        finalStmt.close();
        conn.close();
        
        out.println("</div>");
        
        out.println("<h3>测试完成!</h3>");
        out.println("<p class='success'>所有步骤都已成功执行，数据库和表已清理干净。</p>");
        
    } catch (Exception e) {
        out.println("<p class='error'>操作出错: " + e.getMessage() + "</p>");
        // 记录异常信息到页面输出（在实际应用中应使用日志框架）
        out.println("<p>异常详情: " + e.getClass().getName() + ": " + e.getMessage() + "</p>");
        
        // 清理连接
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
            if (testDbConn != null && !testDbConn.isClosed()) {
                testDbConn.close();
            }
        } catch (SQLException se) {
            // 记录异常信息到页面输出（在实际应用中应使用日志框架）
            out.println("<p>清理连接时出错: " + se.getClass().getName() + ": " + se.getMessage() + "</p>");
        }
    }
%>
</div>

<h3>统一测试完成!</h3>
<p class="success">所有测试都已成功执行。您可以根据需要选择运行其中任何一个测试部分。</p>

<h3>使用说明:</h3>
<ul>
    <li>请确保PostgreSQL服务正在运行</li>
    <li>确保用户名和密码正确（当前使用的是 postgres/123456）</li>
    <li>每个测试部分都是独立的，可以单独运行</li>
    <li>所有创建的对象在测试结束后都会被自动清理</li>
    <li>本页面使用JNDI数据源方式连接数据库，配置信息在META-INF/context.xml中</li>
</ul>

</body>
</html>
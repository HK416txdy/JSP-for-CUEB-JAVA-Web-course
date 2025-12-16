<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" import="javax.sql.DataSource, java.sql.Connection, java.sql.Statement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <title>数据库表列表</title>
</head>
<body>
<%
DataSource ds = (DataSource) application.getAttribute("dataSource");
if (ds == null) {
    out.println("<h3>错误：上下文中找不到 DataSource。请检查监听器是否已正确初始化。</h3>");
} else {
    try (Connection conn = ds.getConnection();
         Statement stmt = conn.createStatement()) {
        // List tables in the current database (public schema)
        ResultSet rs = stmt.executeQuery("SELECT table_name FROM information_schema.tables WHERE table_schema='public' ORDER BY table_name;");
        out.println("<h3>数据库（public 模式）中的表：</h3>");
        out.println("<ul>");
        int count = 0;
        while (rs.next()) {
            String tableName = rs.getString(1);
            out.println("<li>" + tableName + "</li>");
            count++;
        }
        out.println("</ul>");
        out.println("<p>共计：" + count + " 张表。</p>");
    } catch (Exception e) {
        out.println("<h3>查询数据库出错：</h3>");
        out.println("<pre>" + e.getMessage() + "</pre>");
    }
}
%>
</body>
</html>

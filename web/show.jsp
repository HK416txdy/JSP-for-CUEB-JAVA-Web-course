<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // 设置请求编码为UTF-8，防止中文乱码
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>Show Page</title>
</head>
<body>
    <h2>提交的内容</h2>
    <p>姓名(sname): <%= request.getParameter("sname") != null ? request.getParameter("sname") : "" %></p>
    <p>年龄(age): <%= request.getParameter("age") != null ? request.getParameter("age") : "" %></p>
    
    <h3>所有提交的参数:</h3>
    <ul>
        <% 
            Enumeration<String> paramNames = request.getParameterNames();
            while(paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
        %>
        <li><strong><%= paramName %>:</strong> <%= paramValue %></li>
        <% } %>
    </ul>
    
    <a href="first.jsp">返回首页</a>
</body>
</html>
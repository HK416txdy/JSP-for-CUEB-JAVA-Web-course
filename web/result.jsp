<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>素数查找结果</title>
</head>
<body>
<h2>素数查找结果</h2>

<% if ((Boolean) request.getAttribute("success")) { %>
<p>
    在 <%= request.getAttribute("numA") %> 和 <%= request.getAttribute("numB") %> 之间的所有素数:
</p>

<%
    @SuppressWarnings("unchecked")
    List<Long> primes = (List<Long>) request.getAttribute("primes");
    if (primes.isEmpty()) {
%>
<p>在指定范围内没有找到素数</p>
<%
} else {
%>
<p>共找到 <%= primes.size() %> 个素数:</p>
<ul>
    <%
        for (Long prime : primes) {
    %>
    <li><%= prime %></li>
    <%
        }
    %>
</ul>
<%
    }
%>
<% } else { %>
<p style="color: red;">错误：<%= request.getAttribute("error") %></p>
<% } %>

<br>
<a href="index.jsp">重新查找</a>
</body>
</html>
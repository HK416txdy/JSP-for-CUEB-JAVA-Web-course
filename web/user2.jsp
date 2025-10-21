<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息 - Session方式</title>
</head>
<body>
<h2>用户信息提交 (Session方式)</h2>
<%
    request.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("userName");
    if (userName != null && !userName.isEmpty()) {
        session.setAttribute("userName", userName);
    }
%>

<form method="post" action="user2.jsp">
    <label for="userName">用户名:</label>
    <input type="text" id="userName" name="userName" value="<%= userName != null ? userName : "" %>"/>
    <input type="submit" value="提交"/>
</form>

<% if (userName != null && !userName.isEmpty()) { %>
    <h3>提交的用户信息:</h3>
    <jsp:include page="userName.jsp"/>
<% } %>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 设置请求编码为UTF-8，防止中文乱码
    request.setCharacterEncoding("UTF-8");
    
    // 获取从first.jsp传递过来的参数
    String targetUrl = request.getParameter("targetUrl");
    String inputName = request.getParameter("inputName");
    String inputValue = request.getParameter("inputValue");
    
    // 判断是否是从first.jsp跳转而来
    boolean isFromFirst = targetUrl != null && inputName != null && inputValue != null;
%>
<html>
<head>
    <title>Input Page</title>
</head>
<body>
    <h2>输入页面</h2>
    <form action="show.jsp" method="post" id="inputForm">
        <%-- 第一个输入框 --%>
        <label for="sname">姓名(sname):</label>
        <input type="text" id="sname" name="sname" value="<%= isFromFirst && "sname".equals(inputName) ? inputValue : (request.getParameter("sname") != null ? request.getParameter("sname") : "") %>"><br><br>
        
        <%-- 第二个输入框 --%>
        <label for="age">年龄(age):</label>
        <input type="text" id="age" name="age" value="<%= request.getParameter("age") != null ? request.getParameter("age") : "" %>"><br><br>
        
        <input type="submit" value="提交">
    </form>

    <% if (isFromFirst) { %>
        <script>
            // 自动提交表单到show.jsp
            document.getElementById("inputForm").submit();
        </script>
    <% } %>
</body>
</html>
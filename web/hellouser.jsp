<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 设置请求编码以防止中文乱码
    request.setCharacterEncoding("UTF-8");
    
    // 获取用户名参数
    String username = request.getParameter("username");
    
    // 检查是否是表单提交（通过hidden字段判断）
    String formSubmitted = request.getParameter("formSubmitted");
    
    // 如果表单已提交但没有提供用户名参数，则转发到错误处理页面
    if ("true".equals(formSubmitted) && (username == null || username.trim().isEmpty())) {
        request.setAttribute("errorMessage", "未提供用户名参数");
        request.getRequestDispatcher("errorHandler.jsp").forward(request, response);
        return;
    }
    
    // 如果表单已提交且提供了用户名，则显示欢迎信息
    if ("true".equals(formSubmitted)) {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello User</title>
</head>
<body>
    <h1>Hello, <%= username %>!</h1>
    <p>欢迎访问我们的网站！</p>
    <a href="hellouser.jsp">重新输入</a>
</body>
</html>
<%
        return;
    }
    
    // 如果是首次访问，则显示输入表单
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello User</title>
</head>
<body>
    <h1>用户登录</h1>
    <form method="get" action="hellouser.jsp">
        <input type="hidden" name="formSubmitted" value="true">
        <label for="username">请输入您的用户名:</label>
        <input type="text" id="username" name="username" required>
        <input type="submit" value="提交">
    </form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.system.model.Exam" %>
<%@ page import="com.system.dao.ExamDAO" %>
<%@ page import="com.system.model.User" %>
<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("username");
    User user = (User) session.getAttribute("user");
    if (username == null || user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试信息查询系统 - 考试列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        h1 {
            color: #333;
        }
        
        .user-info {
            color: #666;
        }
        
        .logout-btn {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
        }
        
        .logout-btn:hover {
            background-color: #c82333;
        }
        
        .admin-link {
            background-color: #28a745;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
        }
        
        .admin-link:hover {
            background-color: #218838;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
        
        .no-exams {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 20px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>考试信息查询系统</h1>
            <div class="user-info">
                当前用户: <%= username %> 
                <% if (user.isAdmin()) { %>
                    | <a href="<%= request.getContextPath() %>/admin.jsp" class="admin-link">管理员面板</a>
                <% } %>
                | <a href="<%= request.getContextPath() %>/logout.jsp" class="logout-btn">退出登录</a>
            </div>
        </div>
        
        <h2>我的考试安排</h2>
        
        <%
            try {
                ExamDAO examDAO = new ExamDAO();
                List<Exam> exams = examDAO.getAllExams();
                
                if (exams.isEmpty()) {
                    // 没有考试记录
                    out.println("<div class='no-exams'>暂无考试安排</div>");
                } else {
                    // 显示考试表格
        %>
                    <table>
                        <thead>
                            <tr>
                                <th>考试ID</th>
                                <th>考试时间</th>
                                <th>考试地点</th>
                                <th>考试科目</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Exam exam : exams) {
                        %>
                            <tr>
                                <td><%= exam.getExamName() %></td>
                                <td><%= exam.getExamTime() != null ? exam.getExamTime().toString() : "" %></td>
                                <td><%= exam.getClassroom() %></td>
                                <td><%= exam.getSubject() %></td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='no-exams'>查询考试信息时发生错误</div>");
            }
        %>
        
        <a href="<%= request.getContextPath() %>/login.jsp" class="back-link">返回登录页面</a>
    </div>
</body>
</html>
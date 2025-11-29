<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.system.model.Exam" %>
<%@ page import="com.system.dao.ExamDAO" %>
<%@ page import="com.system.model.User" %>
<%
    // 检查用户是否已登录并且是管理员
    String username = (String) session.getAttribute("username");
    User user = (User) session.getAttribute("user");
    
    if (username == null || user == null || !user.isAdmin()) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    ExamDAO examDAO = new ExamDAO();
    
    // 处理添加考试请求
    if ("add".equals(request.getParameter("action"))) {
        String examId = request.getParameter("examId");
        String examName = request.getParameter("examName");
        String examLocation = request.getParameter("examLocation");
        String examDate = request.getParameter("examDate");
        String examTime = request.getParameter("examTime");
        String examMajor = request.getParameter("examMajor");
        
        if (examId != null && !examId.isEmpty()) {
            Exam exam = new Exam();
            exam.setExamName(examId); // 使用ID作为考试名称
            exam.setClassroom(examLocation);
            exam.setSubject(examMajor);
            
            // 组合日期和时间
            if (examDate != null && !examDate.isEmpty() && examTime != null && !examTime.isEmpty()) {
                java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(examDate + " " + examTime);
                exam.setExamTime(timestamp);
            }
            
            if (examDAO.addExam(exam)) {
                request.setAttribute("message", "考试添加成功！");
            } else {
                request.setAttribute("error", "考试添加失败！");
            }
        }
    }
    
    // 处理删除考试请求
    if ("delete".equals(request.getParameter("action"))) {
        String examId = request.getParameter("examId");
        if (examId != null && !examId.isEmpty()) {
            if (examDAO.deleteExam(examId)) {
                request.setAttribute("message", "考试删除成功！");
            } else {
                request.setAttribute("error", "考试删除失败！");
            }
        }
    }
    
    // 获取所有考试信息
    List<Exam> exams = examDAO.getAllExams();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试信息管理系统 - 管理员面板</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
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
        
        .form-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .btn:hover {
            background-color: #0056b3;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
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
        
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .action-cell {
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>考试信息管理系统</h1>
            <div class="user-info">
                当前用户: <%= username %> (管理员) | 
                <a href="<%= request.getContextPath() %>/logout.jsp" class="logout-btn">退出登录</a>
            </div>
        </div>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message success"><%= request.getAttribute("message") %></div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div class="form-section">
            <h2>添加新考试</h2>
            <form method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="examId">考试ID:</label>
                    <input type="text" id="examId" name="examId" required>
                </div>
                <div class="form-group">
                    <label for="examLocation">考试地点:</label>
                    <input type="text" id="examLocation" name="examLocation">
                </div>
                <div class="form-group">
                    <label for="examDate">考试日期 (YYYY-MM-DD):</label>
                    <input type="date" id="examDate" name="examDate">
                </div>
                <div class="form-group">
                    <label for="examTime">考试时间 (HH:MM:SS):</label>
                    <input type="time" id="examTime" name="examTime">
                </div>
                <div class="form-group">
                    <label for="examMajor">考试科目:</label>
                    <input type="text" id="examMajor" name="examMajor">
                </div>
                <button type="submit" class="btn">添加考试</button>
            </form>
        </div>
        
        <h2>考试列表</h2>
        
        <%
            if (exams.isEmpty()) {
                out.println("<div class='no-exams'>暂无考试安排</div>");
            } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>考试ID</th>
                        <th>考试时间</th>
                        <th>考试地点</th>
                        <th>考试科目</th>
                        <th>操作</th>
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
                        <td class="action-cell">
                            <form method="post" style="display: inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="examId" value="<%= exam.getExamName() %>">
                                <button type="submit" class="btn btn-danger" 
                                        onclick="return confirm('确定要删除考试 <%= exam.getExamName() %> 吗？')">删除</button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        <%
            }
        %>
    </div>
</body>
</html>
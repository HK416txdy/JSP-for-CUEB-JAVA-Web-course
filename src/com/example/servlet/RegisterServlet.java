package com.example.servlet;

import com.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置请求和响应的字符编码为UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        // 获取表单数据
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int age = Integer.parseInt(request.getParameter("age"));
        
        // 创建用户对象
        com.example.model.User user = new com.example.model.User(username, email, password, age);
        
        // 将用户对象存储到request属性中
        request.setAttribute("user", user);
        
        // 转发到结果页面
        request.getRequestDispatcher("/userResult.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
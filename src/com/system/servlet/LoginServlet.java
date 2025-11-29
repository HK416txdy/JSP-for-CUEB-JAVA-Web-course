package com.system.servlet;

import com.system.dao.UserDAO;
import com.system.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置请求和响应编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("尝试登录 - 用户名: " + username + ", 密码: " + password);
        
        // 验证用户凭据
        UserDAO userDAO = new UserDAO();
        
        User user = userDAO.validateUser(username, password);
        
        if (user != null) {
            System.out.println("登录成功: " + username);
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/examList.jsp");
        } else {
            System.out.println("登录失败: 用户名或密码错误");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
        }
    }
}
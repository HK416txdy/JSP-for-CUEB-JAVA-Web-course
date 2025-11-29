package com.system.dao;

import com.system.model.User;
import com.system.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDAO {
    
    public User validateUser(String username, String password) {
        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("数据库连接成功");
            
            // 查询用户
            String sql = "SELECT * FROM USERS WHERE userName = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            System.out.println("执行SQL查询: " + sql);
            System.out.println("参数: username=" + username + ", password=" + password);
            
            ResultSet rs = pstmt.executeQuery();
            
            User user = null;
            if (rs.next()) {
                user = new User();
                user.setUserName(rs.getString("userName"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setMajor(rs.getString("major"));
                user.setRole(rs.getString("role")); // 获取用户角色
                System.out.println("找到用户: " + user.getUserName());
            } else {
                System.out.println("未找到匹配的用户");
                // 检查数据库中实际存在的用户
                checkAllUsers(conn);
            }
            
            // 关闭资源
            rs.close();
            pstmt.close();
            
            return user;
        } catch (Exception e) {
            System.err.println("验证用户时发生异常: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    private void checkAllUsers(Connection conn) {
        try {
            System.out.println("检查数据库中的所有用户:");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM USERS");
            
            while (rs.next()) {
                System.out.println("数据库用户 - Username: " + rs.getString("userName") + 
                                 ", Password: " + rs.getString("password") +
                                 ", Name: " + rs.getString("name") +
                                 ", Major: " + rs.getString("major") +
                                 ", Role: " + rs.getString("role"));
            }
            
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.err.println("检查用户时发生异常: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
package com.system.model;

public class User {
    private String userName;
    private String password;
    private String name;
    private String major;
    private String role; // 添加角色属性，用于区分普通用户和管理员
    
    public User() {}
    
    public User(String userName, String password, String name, String major) {
        this.userName = userName;
        this.password = password;
        this.name = name;
        this.major = major;
    }
    
    public User(String userName, String password, String name, String major, String role) {
        this.userName = userName;
        this.password = password;
        this.name = name;
        this.major = major;
        this.role = role;
    }
    
    // Getter and Setter methods
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getMajor() {
        return major;
    }
    
    public void setMajor(String major) {
        this.major = major;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    // 判断用户是否为管理员
    public boolean isAdmin() {
        return "admin".equals(role);
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", major='" + major + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
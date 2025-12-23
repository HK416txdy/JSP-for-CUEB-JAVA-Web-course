package com.example;

import com.example.model.User;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello World!");
        // 简单测试User类
        User user = new User("test", "test@example.com", "password", 25);
        System.out.println(user.toString());
    }
}
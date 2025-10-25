# Java Web JSP 应用程序

这是一个使用useBean实现的用户注册系统，具有以下功能：
1. 用户注册表单（index.jsp）
2. 使用JavaBean存储用户信息（User.java）
3. 显示注册信息（result.jsp）

## 功能说明

### index.jsp
- 提供用户注册表单
- 包含用户名、密码字段
- 安全问题选择下拉菜单
- 安全问题答案输入框
- 使用UTF-8编码解决中文乱码问题

### User.java
- JavaBean类，用于存储用户信息
- 包含用户名、密码、安全问题和安全答案等属性
- 包含所有必要的getter和setter方法
- 位于com.example.beans包中

### result.jsp
- 使用`<jsp:useBean>`标签实例化User对象
- 使用`<jsp:setProperty>`设置所有属性值
- 使用`<jsp:getProperty>`显示用户注册信息
- 显示完整的注册信息（包括密码和安全问题答案）
- 使用UTF-8编码解决中文乱码问题
- 提供返回注册页面的链接

## 如何运行

1. 编译User.java (注意Java版本兼容性):
   ```
   javac --release 17 -d WEB-INF/classes src/User.java
   ```
   
   注意：如果Tomcat版本较旧，可能需要使用更低的Java版本进行编译，例如使用 `--release 8` 或 `--release 11` 参数。

2. 将编译后的User.class复制到web目录下的WEB-INF/classes:
   ```
   copy WEB-INF/classes/com/example/beans/User.class web/WEB-INF/classes/com/example/beans/
   ```

3. 部署web目录到Tomcat服务器或使用IDE内置服务器运行

## 常见问题解决

### Java版本兼容性问题
如果遇到类似以下错误：
```
java.lang.UnsupportedClassVersionError: User has been compiled by a more recent version of the Java Runtime
```

这表示编译Java类时使用的Java版本高于Tomcat支持的版本。解决办法是使用`--release`参数指定目标Java版本重新编译：
```
javac --release <目标版本> -d WEB-INF/classes src/User.java
```

常用的Java版本对应的数字：
- Java 8: --release 8
- Java 11: --release 11
- Java 17: --release 17
- Java 21: --release 21

### User cannot be resolved to a type
如果遇到类似以下错误：
```
User cannot be resolved to a type
```

这表示JSP页面无法找到User类。确保：
1. User.java文件有正确的包声明（如：package com.example.beans;）
2. 类文件被放置在正确的目录结构中（WEB-INF/classes/com/example/beans/User.class）
3. JSP页面中的useBean标签使用完整的类名（如：class="com.example.beans.User"）

### 中文乱码问题
如果页面显示中文乱码，确保：
1. 在JSP页面顶部添加：`<%@ page contentType="text/html;charset=UTF-8" language="java" %>`
2. 在处理表单的JSP页面中添加：`request.setCharacterEncoding("UTF-8");`
3. 在HTML的<head>部分添加：`<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">`

## 安全注意事项

这是一个教学示例项目，所有信息都会完整显示，包括密码和安全问题答案。在实际生产环境中，不应该这样处理敏感信息。
#
## 数据库配置
课程老师使用JNDI数据源方式连接MySQL数据库,请注意你使用的数据库以及配置方式
本项目使用JNDI数据源方式连接PostgreSQL数据库，配置信息位于`web/META-INF/context.xml`文件中：

```xml
<Resource name="jdbc/TestDB" 
          auth="Container" 
          type="javax.sql.DataSource"
          maxTotal="20" 
          maxIdle="10" 
          maxWaitMillis="10000"
          username="postgres" 
          password="123456" 
          driverClassName="org.postgresql.Driver"
          url="jdbc:postgresql://localhost:5432/testdb"/>
```

### JNDI方式优势：

1. **连接池管理**：自动管理数据库连接，提高性能
2. **配置集中化**：数据库配置独立于应用程序代码
3. **资源监控**：便于监控和管理数据库连接使用情况
4. **安全性**：数据库凭证集中管理，避免硬编码

### 配置步骤：

1. 确保PostgreSQL JDBC驱动已放置在`web/WEB-INF/lib/`目录下
2. 修改`context.xml`中的数据库连接参数（URL、用户名、密码）
3. 确保Tomcat服务器已启动PostgreSQL服务
4. 部署应用后访问`dbunifiedtest.jsp`进行测试

## 注意事项

- 商品图片应放在web/images/目录下
- 当前版本为演示版本，没有连接真实数据库，商品信息存储在内存中
- 结算功能仅为演示，实际使用需连接支付系统
- 数据库测试功能仅供开发和部署验证使用
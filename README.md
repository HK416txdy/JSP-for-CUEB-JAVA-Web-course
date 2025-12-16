# 项目说明（中文）

这是一个小型的 Java Web 示例应用，展示如何在 ServletContextListener 中初始化 JDBC DataSource 并在 JSP 中使用它进行数据库查询。

我添加的内容：
- `src/SimpleDriverDataSource.java` - 一个基于 DriverManager 的最小化 DataSource 实现。
- `src/AppContextListener.java` - 一个 ServletContextListener，会读取 `/WEB-INF/db.properties`，加载 JDBC 驱动，创建 DataSource，并将其以属性 `dataSource` 存入 Servlet 上下文。
- `web/index.jsp` - 从应用上下文读取 `dataSource` 并列出连接的数据库（public schema）中的表。
- `web/WEB-INF/db.properties` - 默认数据库连接配置（Postgres，数据库：postgres，用户名：postgres，密码：123456）。
- `web/WEB-INF/web.xml` - 注册监听器并将 `index.jsp` 设为欢迎页。

运行前的重要准备步骤：

1. 将 PostgreSQL JDBC 驱动 JAR（例如 `postgresql-42.6.0.jar`）加入到项目的 `lib/` 或者放到你的 Servlet 容器的类路径（例如 Tomcat 的 `lib/`）。

2. 确保 PostgreSQL 服务正在运行，并确保可以使用用户 `postgres`（密码 `123456`）连接到 `postgres` 数据库。示例：可以在 `psql` 中使用该用户直接连接 `postgres` 并创建示例表。
   示例 SQL（在 psql 中执行）：

```sql
-- 连接到 postgres 数据库（默认存在）
\c postgres
-- 示例表：
CREATE TABLE sample(id serial PRIMARY KEY, name text);
INSERT INTO sample(name) VALUES('Alice'), ('Bob');
```

3. 将 webapp 部署到你的 Servlet 容器（Tomcat、Jetty 等），然后在浏览器打开 `http://localhost:8080/`（根据容器端口调整）查看 `index.jsp` 的输出。

注意事项：
- 当前提供的 `SimpleDriverDataSource` 是非常简单的实现（基于 DriverManager），不包含连接池或复杂的错误处理，不适合生产环境。
- 如果你需要连接池，建议使用 HikariCP、Tomcat JDBC Pool 或由应用服务器提供的连接池。
- 关于驱动放置：若容器中多个应用共享驱动，建议将驱动放到 Tomcat 的全局 `lib`；若仅应用内使用，则放到 `WEB-INF/lib`。避免同时在全局和 webapp 内重复存在相同驱动以防类加载冲突。
- `web/WEB-INF/db.properties` 可用于覆盖默认的连接字符串/用户名/密码，便于不同环境下配置而无需改代码。

后续建议（可选）：
- 若需我帮你把监听器改为优先通过 JNDI (`java:comp/env/jdbc/...`) 获取容器管理的 DataSource（推荐用于容器管理连接池），我可以直接修改 `src/AppContextListener.java` 并说明如何在 `META-INF/context.xml` 或 Tomcat 配置中声明资源。

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;
import java.io.InputStream;
import java.util.Properties;

/**
 * 应用上下文监听器：
 * - 在应用启动时读取 /WEB-INF/db.properties（如存在），加载 JDBC 驱动，
 *   创建 DataSource 并把它放到 ServletContext 属性 "dataSource" 中供全局使用。
 * - 在应用停止时可以在 contextDestroyed 中释放资源（例如关闭连接池）。
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Properties props = new Properties();
        try (InputStream in = sce.getServletContext().getResourceAsStream("/WEB-INF/db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (Exception e) {
            sce.getServletContext().log("无法加载 db.properties，使用默认配置", e);
        }

        // 默认配置（当 properties 文件缺失时使用）
        String driver = props.getProperty("driver", "org.postgresql.Driver");
        // 默认连接到 'postgres' 数据库，并在连接时设置客户端编码为 UTF-8
        String url = props.getProperty("url", "jdbc:postgresql://localhost:5432/postgres?options=-c%20client_encoding%3DUTF8");
        String user = props.getProperty("username", "postgres");
        String pass = props.getProperty("password", "123456");

        // 加载 JDBC 驱动
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("找不到 Postgres JDBC 驱动: " + driver, e);
        }

        DataSource ds = new SimpleDriverDataSource(url, user, pass);
        sce.getServletContext().setAttribute("dataSource", ds);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 无需清理（当前的 SimpleDriverDataSource 无需关闭），
    }
}

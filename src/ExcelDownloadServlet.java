import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/download-excel")
public class ExcelDownloadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型为Excel
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        // 设置响应头，指定文件名
        response.setHeader("Content-Disposition", "attachment; filename=sample.xlsx");

        // 创建示例数据
        List<String[]> data = new ArrayList<>();
        data.add(new String[]{"姓名", "年龄", "城市"});
        data.add(new String[]{"张三", "25", "北京"});
        data.add(new String[]{"李四", "30", "上海"});
        data.add(new String[]{"王五", "28", "广州"});

        // 生成CSV格式的Excel文件内容
        StringBuilder csvContent = new StringBuilder();
        for (String[] row : data) {
            csvContent.append(String.join(",", row)).append("\n");
        }

        // 将内容写入响应输出流
        OutputStream outputStream = response.getOutputStream();
        outputStream.write(csvContent.toString().getBytes("UTF-8"));
        outputStream.flush();
        outputStream.close();
    }
}
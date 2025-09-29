import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

public class PrimeNumberFinder extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        // 获取参数
        String numAStr = request.getParameter("numA");
        String numBStr = request.getParameter("numB");
        
        try {
            long numA = Long.parseLong(numAStr);
            long numB = Long.parseLong(numBStr);
            
            // 确保numA <= numB
            if (numA > numB) {
                long temp = numA;
                numA = numB;
                numB = temp;
            }
            
            // 查找素数
            List<Long> primes = findPrimes(numA, numB);
            
            // 设置结果
            request.setAttribute("success", true);
            request.setAttribute("numA", numA);
            request.setAttribute("numB", numB);
            request.setAttribute("primes", primes);
            
        } catch (NumberFormatException e) {
            request.setAttribute("success", false);
            request.setAttribute("error", "请输入有效的整数");
        }
        
        // 转发到结果页面
        try {
            request.getRequestDispatcher("/result.jsp").forward(request, response);
        } catch (Exception e) {
            throw new IOException("转发失败", e);
        }
    }
    
    /**
     * 查找指定范围内的所有素数（使用埃拉托斯特尼筛法）
     * @param start 起始数字
     * @param end 结束数字
     * @return 素数列表
     */
    private List<Long> findPrimes(long start, long end) {
        List<Long> primes = new ArrayList<>();
        
        // 处理特殊情况
        if (end < 2) {
            return primes;
        }
        
        // 确保起始值至少为2
        start = Math.max(2, start);
        
        // 使用埃拉托斯特尼筛法
        boolean[] isPrime = sieveOfEratosthenes(end);
        
        // 收集范围内的素数
        for (long i = start; i <= end; i++) {
            if (isPrime[(int) i]) {
                primes.add(i);
            }
        }
        return primes;
    }
    
    /**
     * 埃拉托斯特尼筛法生成素数表
     * 即:先寻找2及其所有倍数,将其标记,再继续寻找下一个没有被标记的数的倍数,继续标记...
     * @param max 最大数值
     * @return 布尔数组，索引i为true表示i是素数
     */
    private boolean[] sieveOfEratosthenes(long max) {
        // 我们限制最大值以避免内存问题
        int size = (int) Math.min(max, Integer.MAX_VALUE - 1);
        boolean[] isPrime = new boolean[size + 1];
        
        // 初始化，默认所有数都是素数
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false; // 0和1不是素数
        
        // 埃拉托斯特尼筛法
        for (int i = 2; i * i <= size; i++) {
            if (isPrime[i]) {
                // 标记i的所有倍数为非素数
                for (int j = i * i; j <= size; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        
        return isPrime;
    }
}
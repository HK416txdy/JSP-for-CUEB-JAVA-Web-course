package src;

import java.util.*;

public class ProductDAO {
    private static List<Product> products = new ArrayList<>();

    static {
        products.add(new Product(1, "笔记本电脑", "高性能笔记本电脑，适合办公和娱乐", 5999.00, "laptop.jpg"));
        products.add(new Product(2, "智能手机", "最新款智能手机，拍照清晰", 3999.00, "phone.jpg"));
        products.add(new Product(3, "平板电脑", "轻薄便携，适合阅读和娱乐", 2999.00, "tablet.jpg"));
        products.add(new Product(4, "蓝牙耳机", "无线蓝牙耳机，音质出色", 299.00, "headphones.jpg"));
        products.add(new Product(5, "智能手表", "健康监测，运动追踪", 1599.00, "watch.jpg"));
        products.add(new Product(6, "游戏机", "次世代游戏主机，4K游戏体验", 2999.00, "console.jpg"));
    }

    public static List<Product> getAllProducts() {
        return new ArrayList<>(products);
    }

    public static Product getProductById(int id) {
        for (Product product : products) {
            if (product.getId() == id) {
                return product;
            }
        }
        return null;
    }
}
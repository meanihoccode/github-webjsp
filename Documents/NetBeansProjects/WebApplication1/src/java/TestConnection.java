import java.sql.*;
import dao.DBConfig;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Class.forName(DBConfig.driver);
            Connection conn = DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
            System.out.println("✅ Kết nối thành công!");
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Kết nối thất bại:");
            e.printStackTrace(); // Hiện lỗi để xử lý
        }
    }
}

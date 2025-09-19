

package dao;
import controller.*;
import dao.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

public class UserDAO {
    public static Connection openConnection() {
        Connection conn = null;

        try {
            System.out.println("Hello from DBConfig.driver " + DBConfig.driver);
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
            System.out.println("connected successfully");
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return conn;
    }

    public static User handleLogin(String username, String password) {
        try ( Connection c = openConnection()) {
            String select = String.format("select * from users where username = '%s' and password = '%s'", username, password);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("gender"), rs.getString("birthday"));
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public static boolean isExistUsername(String username) {
        String sql = String.format("SELECT * FROM users WHERE username = '%s'", username);

        try (Connection c = openConnection()) {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true; // Tồn tại username
            }
            return false; // Không có username nào khớp
        } catch (Exception ex) {
            ex.printStackTrace();
            return true; 
        }
    }
        public static boolean insertUser(User user) {

            try (Connection c = openConnection()) {
                 String insert = String.format("INSERT INTO USERS(username,password) VALUES ('%s', '%s');", user.getUsername(), user.getPassword());
                 PreparedStatement ps = c.prepareStatement(insert);
                 int row = ps.executeUpdate(insert);
                 return row >=1 ?true : false;
            } catch (Exception ex) {
                ex.printStackTrace();
                return true; 
            }
        }
}

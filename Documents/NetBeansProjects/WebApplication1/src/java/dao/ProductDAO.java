/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.UserDAO.openConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Comment;
import model.Message;
import model.Product;
import model.User;

/**
 *
 * @author User
 */
public class ProductDAO {

    public static Connection openConnection() {
        Connection conn = null;
        try {
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
    }

    public static ArrayList<Product> getProductList(String sortBy, String order, String filter, int page) {
        try ( Connection c = openConnection()) {
            if (sortBy == null) {
                sortBy = "id";
            }
            if (sortBy != null && !sortBy.equals("sale_rate")) {
                sortBy = "products." + sortBy;
            }
        
            if (order == null) {
                order = "asc";
            }
            if (filter == null) {
                filter = "";
            }
            int pageSize = 6; //6 sp 1 trang
            int start = (page-1) * pageSize;
            String select = String.format(
                "SELECT products.id, products.title, products.description, products.price, products.compare_at_price, products.quantity,\n"
              + "MIN(product_images.image_url) AS image_url,\n"
              + "(products.compare_at_price - products.price) / products.compare_at_price AS sale_rate\n"
              + "FROM products \n"
              + "JOIN product_images ON products.id = product_images.product_id\n"
              + "%s\n"
              + "GROUP BY products.id, products.title, products.description, products.price, products.compare_at_price, products.quantity\n"
              + "ORDER BY %s %s\n"
              + "LIMIT %d\n"
              + "OFFSET %d",
              filter, sortBy, order, pageSize, start);




            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<Product> arr = new ArrayList<>();
            
            while (rs.next()) {
                ArrayList<String> images = new ArrayList<>();
                images.add(rs.getString("image_url"));
                Product product = new Product(rs.getInt("id"), rs.getString("title"), rs.getString("description"),
                        rs.getInt("price"), rs.getInt("compare_at_price"), rs.getInt("quantity"));
                product.setImages(images);
                arr.add(product);
            }
            return arr;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static Product getProductById(int id) {
        try ( Connection c = openConnection()) {
            String select = String.format("select * from products where id = %d", id);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product(rs.getInt("id"), rs.getString("title"), rs.getString("description"),
                        rs.getInt("price"), rs.getInt("compare_at_price"), rs.getInt("quantity"));
                ArrayList<String> images = getImagesByProductId(id);
                product.setImages(images);
                ArrayList<Comment> cmts = getCommentsByProduct(product);
                product.setComment(cmts);
                return product;
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    public static ArrayList<String> getImagesByProductId(int productId) {
        try ( Connection c = openConnection()) {
            String select = String.format("select image_url from java_web.product_images\n"
                    + " where product_id = %d", productId);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<String> arr = new ArrayList<>();
            while (rs.next()) {
                arr.add(rs.getString("image_url"));
            }
            return arr;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public static int getTotalCounts(String filter) {
        try ( Connection c = openConnection()) {
            String select = String.format("select count(*) as cnt from products %s", filter);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                
                return rs.getInt("cnt");
            }
            return 1;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 1;
    }
    
    public static boolean createComment(int userId, int productId, String content) {
        try (Connection c = openConnection()) {
             String insert = String.format("INSERT INTO comments\n"
                     + " VALUES (null,'%d', '%d','%s',now());",userId,productId,content );
             PreparedStatement ps = c.prepareStatement(insert);
             int row = ps.executeUpdate(insert);
             return row >=1 ?true : false;
        } catch (Exception ex) {
            ex.printStackTrace();
            return true; 
        }
    }
    
    public static ArrayList<Comment> getCommentsByProduct(Product product) {
        try ( Connection c = openConnection()) {
            String select = String.format(
                "SELECT comments.*, users.user_id, users.username, users.first_name, users.last_name " +
                "FROM comments " +
                "JOIN users ON users.user_id = comments.user_id " +
                "WHERE product_id = %d " +
                "ORDER BY comments.id DESC", product.getId());

            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<Comment> cmts = new ArrayList<>();
            while (rs.next()) {
                User user = new User(rs.getString("username"),rs.getString("first_name"),rs.getString("last_name"));
                Comment comment = new Comment (rs.getInt("id"),user,product,rs.getString("content"));
                cmts.add(comment);
            }
            return cmts;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
        public static boolean createMessage(int userId, String content) {
            try (Connection c = openConnection()) {
                 String insert = String.format("INSERT INTO messages\n"
                         + " VALUES (null,'%d', '%s');",userId,content );
                 PreparedStatement ps = c.prepareStatement(insert);
                 int row = ps.executeUpdate(insert);
                 return row >=1 ?true : false;
            } catch (Exception ex) {
                ex.printStackTrace();
                return true; 
            }
        }
    public static ArrayList<Message> getMessage() {
        try ( Connection c = openConnection()) {
            String select = String.format(
                "SELECT M.*, U.username, U.first_name, U.last_name\n"
                + "FROM messages as M\n"
                + "join users as U\n"
                + "on M.sender_id = U.user_id order by id desc;");

            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            ArrayList<Message> arr = new ArrayList<>();
            while (rs.next()) {
                User user = new User(rs.getString("username"),rs.getString("first_name"),rs.getString("last_name"));
                Message msg = new Message (rs.getInt("id"),user,rs.getString("content"));
                arr.add(msg);
            }
            return arr;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}

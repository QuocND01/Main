/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBContext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Long Ho
 */
public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123456";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=NEOBookShop;trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); //tải driver JDBC cho SQL Server.
            connection = DriverManager.getConnection(url, user, pass); //tạo kết nối với cơ sở dữ liệu sử dụng thông tin đã cung cấp.
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex); //Ghi một log ở mức nghiêm trọng (SEVERE) với chi tiết ngoại lệ (ex). null ở đây bỏ qua phần thông báo chi tiết, chỉ ghi lỗi.
        }
    }
    
    public Connection getConnection(){
        return connection;
    }
    public static void main(String[] args) {
        try{
            System.out.println(new DBContext().getConnection());
        }catch (Exception e){
            
        }
    }
}

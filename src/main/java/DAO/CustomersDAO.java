/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.Customers;
import DBContext.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Admin
 */
public class CustomersDAO extends DBContext {
    
    // Lấy danh sách tất cả khách hàng
    public ArrayList<Customers> getAllCustomers() {
        ArrayList<Customers> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customers cus = new Customers();
                cus.setCustomerID(rs.getString("CustomerID"));
                cus.setCustomerName(rs.getString("CustomerName"));
                cus.setCustomerEmail(rs.getString("CustomerEmail"));
                cus.setCustomerPNB(rs.getString("CustomerPNB"));
                cus.setCustomerAddress(rs.getString("CustomerAddress"));
                cus.setUsername(rs.getString("Username"));
                cus.setPassword(rs.getString("Password"));
                cus.setStatus(rs.getString("Status"));
                list.add(cus);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin chi tiết khách hàng theo ID
    public Customers getCustomerById(String id) {
        Customers cus = null;
        String sql = "SELECT * FROM Customers WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                cus = new Customers();
                cus.setCustomerID(rs.getString("CustomerID"));
                cus.setCustomerName(rs.getString("CustomerName"));
                cus.setCustomerEmail(rs.getString("CustomerEmail"));
                cus.setCustomerPNB(rs.getString("CustomerPNB"));
                cus.setCustomerAddress(rs.getString("CustomerAddress"));
                cus.setUsername(rs.getString("Username"));
                cus.setPassword(rs.getString("Password"));
                cus.setStatus(rs.getString("Status"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cus;
    }

    // Khóa tài khoản khách hàng (Locked)
    public void lockCustomer(String id) {
        String sql = "UPDATE Customers SET Status = 'Locked' WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Mở khóa tài khoản khách hàng (Active)
    public void unlockCustomer(String id) {
        String sql = "UPDATE Customers SET Status = 'Active' WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

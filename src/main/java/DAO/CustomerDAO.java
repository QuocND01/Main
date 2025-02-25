/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Customer;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
public class CustomerDAO extends DBContext {

    public Customer getCustomerByID(String customerID) {
        String query = "SELECT * FROM Customers WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customerID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getString("CustomerID"),
                            rs.getString("CustomerName"),
                            rs.getString("CustomerEmail"),
                            rs.getString("CustomerPNB"),
                            rs.getString("CustomerAddress"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customer checkCustomerExist(String username) {
        String sql = "SELECT * FROM [dbo].[Customers] WHERE [Username] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Customer acc = new Customer(
                        rs.getString("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getString("CustomerEmail"),
                        rs.getString("CustomerPNB"),
                        rs.getString("CustomerAddress"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Status")
                );
                return acc;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createCustomer(Customer acc) {
        String sql = "INSERT INTO Customers VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, acc.getCustomerID());
            st.setString(2, acc.getCustomerName());
            st.setString(3, acc.getCustomerEmail());
            st.setString(4, acc.getCustomerPNB());
            st.setString(5, acc.getCustomerAddress());
            st.setString(6, acc.getUsername());
            st.setString(7, acc.getPassword());
            st.setString(8, acc.getStatus());
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getNextCustomerID() {
        String maxID = "C000"; // ID mặc định nếu không có dữ liệu
        String query = "SELECT MAX(CustomerID) FROM Customers";

        try ( PreparedStatement ps = connection.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            if (rs.next() && rs.getString(1) != null) {
                maxID = rs.getString(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Tăng ID lên 1 (C001, C002, C003,...)
        return generateNextID(maxID);
    }

    // 
    private String generateNextID(String maxID) {
        // Lấy phần số từ ID (bỏ "C")
        int num = Integer.parseInt(maxID.substring(1));
        num++; // Tăng lên 1

        // Định dạng lại ID (C001, C002, ...)
        return String.format("C%03d", num);
    }

    // Hàm cập nhật thông tin của Customer
    public boolean updateCustomer(Customer customer) {
        String updateQuery = "UPDATE Customers SET CustomerName = ?, CustomerEmail = ?, CustomerPNB = ?, CustomerAddress = ? WHERE CustomerID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(updateQuery)) {
             ps.setString(1, customer.getCustomerName());
        ps.setString(2, customer.getCustomerEmail());
        ps.setString(3, customer.getCustomerPNB());
        ps.setString(4, customer.getCustomerAddress());
        ps.setString(5, customer.getCustomerID()); // Chỉ cập nhật theo CustomerID

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // Trả về true nếu ít nhất 1 bản ghi đã được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Trả về false nếu không có bản ghi nào được cập nhật
    }

}

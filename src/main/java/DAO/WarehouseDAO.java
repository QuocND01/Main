/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Warehouse;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
public class WarehouseDAO extends DBContext {

    public List<Warehouse> getAllWarehouseItems() {
        List<Warehouse> list = new ArrayList<>();
        String sql = "SELECT w.StockID, w.BookID, b.BookName, w.StaffID, w.Stock, b.Quantity "
                + "FROM Warehouse w JOIN Books b ON w.BookID = b.BookID";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Warehouse(
                        rs.getString(1), // StockID
                        rs.getString(2), // BookID
                        rs.getString(3), // BookName
                        rs.getString(4), // StaffID
                        rs.getInt(5), // Stock
                        rs.getInt(6) // Quantity
                ));
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void importBook(String bookID, int importQuantity, String staffID) {
        String stockID = generateNewStockID();  // Tạo StockID mới

        String sql1 = "UPDATE Books SET Quantity = Quantity + ? WHERE BookID = ?";
        String sql2 = "INSERT INTO Warehouse (StockID, BookID, StaffID, Stock) VALUES (?, ?, ?, ?)";

        try {
            // Cập nhật số lượng sách trong bảng Books
            PreparedStatement st1 = connection.prepareStatement(sql1);
            st1.setInt(1, importQuantity);
            st1.setString(2, bookID);
            st1.executeUpdate();
            st1.close();

            // Chèn một bản ghi mới vào Warehouse để ghi lại lần nhập sách
            PreparedStatement st2 = connection.prepareStatement(sql2);
            st2.setString(1, stockID);  // StockID mới
            st2.setString(2, bookID);   // BookID
            st2.setString(3, staffID);  // StaffID
            st2.setInt(4, importQuantity);  // Số lượng nhập vào
            st2.executeUpdate();
            st2.close();
            //Test input data
            System.out.println("StockID: " + stockID);
            System.out.println("BookID: " + bookID);
            System.out.println("StaffID: " + staffID);
            System.out.println("Import Quantity: " + importQuantity);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Take ID from database and return the highest stockID without 'W'
    public String generateNewStockID() {

        String sql = "SELECT MAX(TRY_CONVERT(INT, SUBSTRING(StockID, 2, LEN(StockID) - 1))) FROM Warehouse WHERE StockID LIKE 'W%'";

        String newStockID = "W1"; // Mặc định nếu không có dữ liệu

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next() && rs.getObject(1) != null) { // Kiểm tra NULL
                int maxID = rs.getInt(1);
                newStockID = "W" + (maxID + 1); // Tạo StockID mới
            }

            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return newStockID;
    }

}

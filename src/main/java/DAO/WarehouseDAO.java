/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Warehouse;
import java.sql.Date;

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

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT * FROM Warehouse";
        try (
                 PreparedStatement st = connection.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                warehouses.add(new Warehouse(
                        rs.getString("StockID"),
                        rs.getString("StaffID"),
                        rs.getString("SupplierName"),
                        rs.getDate("ImportDate"),
                        rs.getLong("TotalCost")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouses;
    }

    public void addNewRestock(String stockID, String staffID, String supplierName, Date importDate, double totalCost) {
        String sql = "INSERT INTO warehouse (StockID, StaffID, SupplierName, ImportDate, TotalCost) VALUES (?, ?, ?, ?, ?)";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            // Thiết lập các tham số cho PreparedStatement
            st.setString(1, stockID);          // StockID
            st.setString(2, staffID);          // StaffID
            st.setString(3, supplierName);     // SupplierName
            st.setDate(4, new java.sql.Date(importDate.getTime()));  // ImportDate (Chuyển từ java.util.Date sang java.sql.Date)
            st.setDouble(5, totalCost);        // TotalCost

            // Thực thi câu lệnh SQL để chèn dữ liệu vào cơ sở dữ liệu
            st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public String getNextWarehouseID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(StockID, 2, LEN(StockID)) AS INT)) FROM Warehouse";
        String nextID = "W1";  // Giá trị mặc định

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                int maxID = rs.getInt(1);
                nextID = "W" + (maxID + 1);  // Tăng ID lên 1 và gán vào nextID
            }

            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextID;
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.WarehouseDetails;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
public class WarehouseDetailsDAO extends DBContext {

    public List<WarehouseDetails> getWarehouseDetailsByID(String stockID) {
        List<WarehouseDetails> list = new ArrayList<>();
        String sql = "SELECT "
                + "    s.StaffName, "
                + "    w.SupplierName, "
                + "    w.ImportDate, "
                + "    b.BookName, "
                + "    b.BookPrice, "
                + "    wd.WarehouseDetailsID, "
                + "    wd.BookID, "
                + "    wd.Stock, "
                + "    wd.ImportBookValue, "
                + "    wd.StockID, "
                + "    w.TotalCost "
                + "FROM warehousedetails wd "
                + "JOIN warehouse w ON wd.StockID = w.StockID "
                + "JOIN Staffs s ON w.StaffID = s.StaffID "
                + "JOIN Books b ON wd.BookID = b.BookID "
                + "WHERE wd.StockID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, stockID); // Gán tham số vào truy vấn SQL
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    list.add(new WarehouseDetails(
                            rs.getString("WarehouseDetailsID"),
                            rs.getString("BookID"),
                            rs.getString("BookName"), // Thêm thông tin tên sách
                            rs.getDouble("BookPrice"), // Thêm thông tin giá sách
                            rs.getInt("Stock"),
                            rs.getDouble("ImportBookValue"),
                            rs.getString("StockID"),
                            rs.getString("StaffName"), // Thêm thông tin nhân viên nhập kho
                            rs.getString("SupplierName"),
                            rs.getDate("ImportDate"),
                            rs.getDouble("TotalCost")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getNextWarehouseDetailID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(WarehouseDetailsID, 3, LEN(WarehouseDetailsID)) AS INT)) \n"
                + "FROM WarehouseDetails\n"
                + "WHERE WarehouseDetailsID LIKE 'WD%'";
        String nextID = "WD1";  // Giá trị mặc định

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                int maxID = rs.getInt(1);
                if (maxID == 0) {
                    nextID = "WD1";  // Nếu không có ID nào, gán mặc định là WD1
                } else {
                    nextID = "WD" + (maxID + 1);  // Tăng ID lên 1 và gán vào nextID
                }
            }

            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextID;
    }

    public void addNewWarehouseDetails(String warehouseDetailID, String bookID, int importQuantities, double importBookValues, String stockID) {
        String sql = "INSERT INTO WarehouseDetails (WarehouseDetailsID, BookID, Stock, ImportBookValue, StockID) VALUES (?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            // Thiết lập các tham số cho câu lệnh SQL
            System.out.println("WWWWWWWWWWWWWW");
            System.out.println(warehouseDetailID);
            System.out.println(bookID);
            System.out.println(importQuantities);
            System.out.println(importBookValues);
            System.out.println(stockID);
            //
            ps.setString(1, warehouseDetailID); // WarehouseDetailsID
            ps.setString(2, bookID); // BookID
            ps.setInt(3, importQuantities); // Stock
            ps.setDouble(4, importBookValues); // ImportBookValue
            ps.setString(5, stockID); // StockID

            // Thực hiện câu lệnh SQL
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}

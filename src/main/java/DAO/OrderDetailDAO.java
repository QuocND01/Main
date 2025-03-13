/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Books;
import Model.Deliveryunits;
import Model.OrderDetails;
import Model.Orders;
import Model.Vouchers;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Long Ho
 */
public class OrderDetailDAO extends DBContext {

    public List<OrderDetails> getOrderDetailsByOrderID(String orderID) {
        List<OrderDetails> detailsList = new ArrayList<>();
        String query = "SELECT * FROM orderdetails WHERE orderID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetails detail = new OrderDetails();
                detail.setOrderID(rs.getString("orderID"));
                detail.setBookID(rs.getString("bookID"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));
                detailsList.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detailsList;
    }

    public List<Books> getBooksByOrderID(String orderID) {
        List<Books> booksList = new ArrayList<>();
        String query = "SELECT b.bookID, b.BookName, b.[image] FROM books b\n"
                + "JOIN orderdetails od ON b.bookID = od.bookID \n"
                + "WHERE od.orderID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Books book = new Books();
                book.setBookID(rs.getString("bookID"));
                book.setBookName(rs.getString("BookName"));
                book.setImage(rs.getString("image"));
                booksList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booksList;
    }

    public Deliveryunits getUnitInfo(String unitID) {
        Deliveryunits unit = null;
        String query = "SELECT * FROM Deliveryunits WHERE UnitID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, unitID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                unit = new Deliveryunits();
                unit.setUnitID(rs.getString("unitID"));
                unit.setUnitName(rs.getString("unitName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return unit;
    }

    public Orders getOrderInfo(String orderID) {
        Orders order = null;
        String query = "SELECT * FROM orders WHERE orderID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Orders();
                order.setOrderID(rs.getString("orderID"));
                order.setOrderDate(rs.getDate("orderDate"));
                order.setValue(rs.getDouble("value"));
                order.setUnitID(rs.getString("unitID"));
                order.setVoucherID(rs.getString("voucherID"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setOrderCompleteDate(rs.getDate("orderCompleteDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public Vouchers getVoucherInfo(String voucherID) {
        Vouchers voucher = null;
        if (voucherID == null || voucherID.isEmpty()) {
            return null;
        }

        String query = "SELECT * FROM Vouchers WHERE VoucherID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, voucherID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                voucher = new Vouchers();
                voucher.setVoucherID(rs.getString("VoucherID"));
                voucher.setVoucher(rs.getString("Voucher"));
                voucher.setValue(rs.getInt("Value"));
                voucher.setStatus(rs.getString("Status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return voucher;
    }
    
    // Create a new order detail
    public boolean createOrderDetail(OrderDetails orderDetail) {
        // Query to get the max OrderDetailID
        String getMaxOrderDetailIDSQL = "SELECT MAX(CAST(SUBSTRING(orderDetailID, 3, LEN(orderDetailID)) AS INT)) FROM OrderDetails";
        // Insert SQL
        String insertSQL = "INSERT INTO OrderDetails (orderDetailID, orderID, bookID, quantity, price) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement getMaxSt = connection.prepareStatement(getMaxOrderDetailIDSQL);
             PreparedStatement insertSt = connection.prepareStatement(insertSQL)) {
            
            // Get the current max ID
            ResultSet rs = getMaxSt.executeQuery();
            int newIDNumber = 1; // Default if database has no order details
            
            if (rs.next() && rs.getInt(1) > 0) {
                newIDNumber = rs.getInt(1) + 1; // Increment ID by 1
            }
            
            String newOrderDetailID = "OD" + newIDNumber; // Create new ID
            
            // Set values for INSERT
            insertSt.setString(1, newOrderDetailID);
            insertSt.setString(2, orderDetail.getOrderID());
            insertSt.setString(3, orderDetail.getBookID());
            insertSt.setInt(4, orderDetail.getQuantity());
            insertSt.setDouble(5, orderDetail.getPrice());
            
            int rowsInserted = insertSt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static void main(String[] args) {
        OrderDetailDAO order = new OrderDetailDAO();

        Orders o = order.getOrderInfo("O1");
        System.out.println(o);
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Customers;
import Model.OrderDetails;
import Model.Orders;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Long Ho
 */
public class OrderDAO extends DBContext {

    // Lấy danh sách đơn hàng theo CustomerID
    public ArrayList<Orders> getOrdersByCustomer(String customerID) {
        ArrayList<Orders> orderList = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE CustomerID = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, customerID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Orders order = new Orders(
                        rs.getString("OrderID"),
                        rs.getString("CustomerID"),
                        rs.getString("StaffID"),
                        rs.getDate("OrderDate"),
                        rs.getString("VoucherID"),
                        rs.getDouble("Value"),
                        rs.getString("UnitID"),
                        rs.getDate("OrderCompleteDate"),
                        rs.getString("OrderStatus")
                );
                orderList.add(order);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<OrderDetails> getOrderDetailsByOrderID(String orderID) {
        ArrayList<OrderDetails> orderDetails = new ArrayList<>();
        String sql = "SELECT od.OrderID, od.BookID, b.BookName, od.Quantity, od.Price\n"
                + "FROM OrderDetails od \n"
                + "JOIN Books b ON od.BookID = b.BookID \n"
                + "WHERE od.OrderID = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, orderID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                OrderDetails orderDetail = new OrderDetails(
                        rs.getString("OrderID"),
                        rs.getString("BookID"),
                        rs.getString("BookName"),
                        rs.getInt("Quantity"),
                        rs.getDouble("Price")
                );
                orderDetails.add(orderDetail);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public List<Map<String, Object>> getNewOrders() {
        List<Map<String, Object>> orders = new ArrayList<>();
        String sql = "SELECT o.OrderID, c.CustomerName, o.OrderDate, o.Value, o.OrderStatus,\n"
                + "STRING_AGG(b.BookName, ', ') AS BookNames,\n"
                + "STRING_AGG(CAST(od.Quantity AS NVARCHAR), ', ') AS Quantities\n"
                + "FROM Orders o\n"
                + "JOIN Customers c ON o.CustomerID = c.CustomerID \n"
                + "JOIN OrderDetails od ON o.OrderID = od.OrderID\n"
                + "JOIN Books b ON od.BookID = b.BookID\n"
                + "WHERE o.OrderStatus = 'Not Approved' \n"
                + "GROUP BY o.OrderID, c.CustomerName, o.OrderDate, o.Value, o.OrderStatus";

        try ( PreparedStatement st = connection.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("OrderID", rs.getString("OrderID"));
                order.put("CustomerName", rs.getString("CustomerName"));
                order.put("OrderDate", rs.getDate("OrderDate"));
                order.put("Value", rs.getDouble("Value"));
                order.put("OrderStatus", rs.getString("OrderStatus"));
                order.put("BookNames", rs.getString("BookNames"));
                order.put("Quantities", rs.getString("Quantities"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean cancelOrder(String orderID) {
        String sql = "UPDATE Orders SET OrderStatus = 'Cancelled' WHERE OrderID = ? AND OrderStatus != 'Completed'";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, orderID);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Map<String, Object> getOrderDetail(String orderID) {
        Map<String, Object> orderDetail = new HashMap<>();
        List<Map<String, Object>> books = new ArrayList<>();

        String sql = "SELECT o.OrderID, o.OrderDate, o.Value, o.OrderStatus, o.OrderCompleteDate,\n"
                + "c.CustomerName, c.CustomerEmail, c.CustomerPNB, c.CustomerAddress,c.Username,\n"
                + "COALESCE(d.UnitName, 'Không có đơn vị vận chuyển') AS DeliveryUnitName,\n"
                + "b.BookID, b.BookName, b.[Image], od.Quantity, od.Price\n"
                + "FROM Orders o\n"
                + "LEFT JOIN Customers c ON o.CustomerID = c.CustomerID\n"
                + "LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID\n"
                + "LEFT JOIN Books b ON od.BookID = b.BookID\n"
                + "LEFT JOIN Staffs s ON o.StaffID = s.StaffID\n"
                + "LEFT JOIN Deliveryunits d ON o.UnitID = d.UnitID\n"
                + "WHERE o.OrderID = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, orderID);
            try ( ResultSet rs = st.executeQuery()) {
                if (!rs.next()) {
                    return null; // Không có đơn hàng
                }
                // Lấy thông tin đơn hàng chỉ một lần
                orderDetail.put("OrderID", rs.getString(1));
                orderDetail.put("OrderDate", rs.getDate(2));
                orderDetail.put("Value", rs.getDouble(3));
                orderDetail.put("OrderStatus", rs.getString(4));
                orderDetail.put("OrderCompleteDate", rs.getDate(5));
                orderDetail.put("CustomerName", rs.getString(6));
                orderDetail.put("CustomerEmail", rs.getString(7));
                orderDetail.put("CustomerPNB", rs.getString(8));
                orderDetail.put("CustomerAddress", rs.getString(9));
                orderDetail.put("Username", rs.getString(10));
                orderDetail.put("DeliveryUnitName", rs.getString(11));

                // Lấy danh sách sách
                do {
                    Map<String, Object> bookData = new HashMap<>();
                    bookData.put("BookID", rs.getString(12));
                    bookData.put("BookName", rs.getString(13));
                    bookData.put("Image", rs.getString(14));
                    bookData.put("Quantity", rs.getInt(15));
                    bookData.put("Price", rs.getDouble(16));
                    books.add(bookData);
                } while (rs.next());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        orderDetail.put("books", books);
        return orderDetail;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(String orderID, String newStatus) {
        String sql = "UPDATE Orders SET OrderStatus = ?, orderCompleteDate = ? WHERE OrderID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newStatus);
            st.setDate(2, new java.sql.Date(System.currentTimeMillis())); // Ngày hoàn thành
            st.setString(3, orderID);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Map<String, Object>> getBooksByOrderID(String orderID) {
        List<Map<String, Object>> books = new ArrayList<>();
        String sql = "SELECT b.BookID, b.BookName, b.[Image], o.Quantity, b.Price\n"
                + "FROM OrderDetails o\n"
                + "JOIN Books b ON o.BookID = b.BookID\n"
                + "WHERE o.OrderID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> book = new HashMap<>();
                book.put("BookID", rs.getString("BookID"));
                book.put("bookTitle", rs.getString("BookName"));
                book.put("image", rs.getString("Image"));
                book.put("quantity", rs.getInt("Quantity"));
                book.put("price", rs.getDouble("Price"));
                books.add(book);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public static void main(String[] args) {

    }

}

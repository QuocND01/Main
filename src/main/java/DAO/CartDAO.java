package DAO;

import DBContext.DBContext;
import Model.Cart;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CartDAO extends DBContext {

    // Lấy giỏ hàng của khách hàng theo CustomerID
    public ArrayList<Cart> getCartByCustomer(String customerID) {
        ArrayList<Cart> cartList = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE CustomerID = ? ORDER BY CAST(SUBSTRING(CartID, 3, LEN(CartID) - 2) AS INT) DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, customerID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart(
                        rs.getString("CartID"),
                        rs.getString("CustomerID"),
                        rs.getString("BookID"),
                        rs.getInt("Quantity")
                );
                cartList.add(cart);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    // Thêm sách vào giỏ hàng
    public void addToCart(String customerID, String bookID) {
        String sqlGetMaxID = "SELECT MAX(CAST(SUBSTRING(CartID, 3, LEN(CartID) - 2) AS INT)) FROM Cart";
        String sqlInsert = "INSERT INTO Cart (CartID, CustomerID, BookID, Quantity) VALUES (?, ?, ?, 1)";
        String sqlCheck = "SELECT Quantity FROM Cart WHERE CustomerID = ? AND BookID = ?";
        String sqlUpdate = "UPDATE Cart SET Quantity = Quantity + 1 WHERE CustomerID = ? AND BookID = ?";

        try {
            connection.setAutoCommit(false);

            // Lấy số lớn nhất của CartID
            int newCartNumber = 1;
            try ( PreparedStatement getMaxStmt = connection.prepareStatement(sqlGetMaxID);  ResultSet rs = getMaxStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) != 0) {
                    newCartNumber = rs.getInt(1) + 1; // Tăng giá trị số lên 1
                }
            }
            String newCartID = "CT" + newCartNumber; // Tạo CartID mới (VD: CT6)

            // Kiểm tra sản phẩm đã có trong giỏ chưa
            try ( PreparedStatement checkStmt = connection.prepareStatement(sqlCheck)) {
                checkStmt.setString(1, customerID);
                checkStmt.setString(2, bookID);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Nếu đã có, cập nhật số lượng
                    try ( PreparedStatement updateStmt = connection.prepareStatement(sqlUpdate)) {
                        updateStmt.setString(1, customerID);
                        updateStmt.setString(2, bookID);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // Nếu chưa có, chèn mới với CartID
                    try ( PreparedStatement insertStmt = connection.prepareStatement(sqlInsert)) {
                        insertStmt.setString(1, newCartID);
                        insertStmt.setString(2, customerID);
                        insertStmt.setString(3, bookID);
                        insertStmt.executeUpdate();
                    }
                }
            }

            connection.commit(); // Lưu thay đổi
        } catch (SQLException e) {
            try {
                connection.rollback(); // Hoàn tác nếu lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Cập nhật số lượng sách trong giỏ hàng
    public void updateQuantity(String customerID, String bookID, int quantity) {
        if (quantity <= 0) {
            removeFromCart(customerID, bookID);
        } else {
            String sql = "UPDATE Cart SET Quantity = ? WHERE CustomerID = ? AND BookID = ?";
            try ( PreparedStatement st = connection.prepareStatement(sql)) {
                st.setInt(1, quantity);
                st.setString(2, customerID);
                st.setString(3, bookID);
                st.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Xóa một sách khỏi giỏ hàng
    public void removeFromCart(String customerID, String bookID) {
        String sql = "DELETE FROM Cart WHERE CustomerID = ? AND BookID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, customerID);
            st.setString(2, bookID);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa toàn bộ giỏ hàng của một khách hàng
    public boolean clearCart(String customerID) {
        String sql = "DELETE FROM Cart WHERE customerID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, customerID);
            int rowsDeleted = st.executeUpdate();
            return rowsDeleted > 0; // Returns true if at least one row was deleted
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

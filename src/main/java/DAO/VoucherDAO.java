package DAO;

import DBContext.DBContext;
import Model.Vouchers;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.ArrayList;

/**
 *
 * @author QuocNHMCE182015
 */
public class VoucherDAO extends DBContext {

    // Lấy danh sách tất cả voucher theo thứ tự tăng dần
    public ArrayList<Vouchers> getAllVouchers() {
        ArrayList<Vouchers> voucherList = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers ORDER BY CAST(SUBSTRING(voucherID, 2, LEN(voucherID)) AS INT) ASC";

        try ( PreparedStatement st = connection.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Vouchers voucher = new Vouchers(
                        rs.getString("voucherID"),
                        rs.getString("voucher"),
                        rs.getInt("value"),
                        rs.getString("status")
                );
                voucherList.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return voucherList;
    }

    // Lấy thông tin voucher theo ID
    public Vouchers getVoucherByID(String voucherID) {
        String sql = "SELECT * FROM Vouchers WHERE voucherID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, voucherID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Vouchers(
                        rs.getString("voucherID"),
                        rs.getString("voucher"),
                        rs.getInt("value"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra mã voucher hợp lệ
    public Vouchers getVoucherByCode(String code) {
        String sql = "SELECT * FROM Vouchers WHERE voucher = ? AND status = 'Active'";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, code);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Vouchers(
                        rs.getString("voucherID"),
                        rs.getString("voucher"),
                        rs.getInt("value"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm voucher mới
    public void addVoucher(Vouchers voucher) {
        String sqlGetMaxID = "SELECT MAX(CAST(SUBSTRING(voucherID, 2, LEN(voucherID)) AS INT)) FROM Vouchers";
        String sqlInsert = "INSERT INTO Vouchers (voucherID, voucher, value, status) VALUES (?, ?, ?, ?)";

        int maxID = 0;

        try ( PreparedStatement st1 = connection.prepareStatement(sqlGetMaxID);  ResultSet rs = st1.executeQuery()) {
            if (rs.next() && rs.getObject(1) != null) { // Kiểm tra nếu có dữ liệu
                maxID = rs.getInt(1); // Lấy số lớn nhất từ voucherID hiện tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String newVoucherID = "V" + (maxID + 1); // Nếu chưa có voucher nào, maxID = 0 -> "V1"

        try ( PreparedStatement st2 = connection.prepareStatement(sqlInsert)) {
            st2.setString(1, newVoucherID);
            st2.setString(2, voucher.getVoucher());
            st2.setInt(3, voucher.getValue());
            st2.setString(4, voucher.getStatus());
            st2.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Kiểm tra xem voucher có tham chiếu tới bảng khác không
    private boolean hasReferences(String voucherID) {
        // Giả sử Orders là bảng có khóa ngoại đến Vouchers
        // Thay thế bằng các bảng thực tế trong hệ thống của bạn
        String sql = "SELECT COUNT(*) FROM Orders WHERE voucherID = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, voucherID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu COUNT > 0, tức là có tham chiếu
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thay đổi trạng thái voucher thành Inactive thay vì xóa
    public boolean updateVoucherStatus(String voucherID, String newStatus) {
        String sql = "UPDATE Vouchers SET status = ? WHERE voucherID = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newStatus);
            st.setString(2, voucherID);
            int rowsAffected = st.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa voucher theo ID không cập nhật lại ID sau khi xóa
    public boolean deleteVoucher(String voucherID) {
        // Kiểm tra xem voucher có tham chiếu tới bảng khác không
        if (hasReferences(voucherID)) {
            System.out.println("❌ Không thể xóa voucher vì đang được sử dụng trong bảng khác!");
            return false;
        }

        // Xóa voucher mà không cập nhật ID của các voucher khác
        String sqlDelete = "DELETE FROM Vouchers WHERE voucherID = ?";

        try ( PreparedStatement st = connection.prepareStatement(sqlDelete)) {
            st.setString(1, voucherID);
            int rowsAffected = st.executeUpdate();

            // Nếu có ít nhất 1 voucher bị xóa thì trả về true
            return rowsAffected > 0;
        } catch (SQLException e) {
            if (e.getSQLState().startsWith("23")) { // Mã lỗi khóa ngoại (constraint violation)
                System.out.println("❌ Không thể xóa voucher vì đang được sử dụng trong bảng khác!");
            }
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra xem voucher đã tồn tại hay chưa
    public boolean isVoucherExists(String voucherName) {
        String sql = "SELECT COUNT(*) FROM Vouchers WHERE voucher = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, voucherName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("🔍 Kiểm tra voucher: " + voucherName + " | Kết quả: " + count);
                return rs.getInt(1) > 0; // Nếu COUNT > 0, tức là đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Deliveryunits;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author QuocNHMCE182015
 */
public class DeliveryunitDAO extends DBContext {

    // Lấy danh sách tất cả đơn vị vận chuyển (chỉ lấy những đơn vị đang Active)
    public ArrayList<Deliveryunits> getAllDeliveryUnits() {
        ArrayList<Deliveryunits> unitList = new ArrayList<>();
        String sql = "SELECT * FROM Deliveryunits ORDER BY CAST(SUBSTRING(unitID, 3, LEN(unitID) - 2) AS INT) ASC";

        try ( PreparedStatement st = connection.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Deliveryunits unit = new Deliveryunits(
                        rs.getString("unitID"),
                        rs.getString("unitName"),
                        rs.getString("status")
                );
                unitList.add(unit);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return unitList;
    }

    // Lấy thông tin đơn vị vận chuyển theo ID
    public Deliveryunits getDeliveryUnitByID(String unitID) {
        String sql = "SELECT * FROM Deliveryunits WHERE unitID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Deliveryunits(
                        rs.getString("unitID"),
                        rs.getString("unitName"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm đơn vị vận chuyển mới
    public void addDeliveryUnit(String unitName) {
        String sql = "INSERT INTO Deliveryunits (unitID, unitName, status) VALUES (?, ?, ?)";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            String newID = generateNewUnitID();
            st.setString(1, newID);
            st.setString(2, unitName);
            st.setString(3, "Active"); // Set default status as Active
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin đơn vị vận chuyển
    public void updateDeliveryUnit(String unitID, String unitName) {
        String sql = "UPDATE Deliveryunits SET unitName = ? WHERE unitID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitName);
            st.setString(2, unitID);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // "Soft delete" - Thay đổi status thành Inactive thay vì xóa
    public boolean deactivateDeliveryUnit(String unitID) {
        String sql = "UPDATE Deliveryunits SET status = 'Inactive' WHERE unitID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitID);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Hàm tạo ID mới
    private String generateNewUnitID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(unitID, 3, LEN(unitID) - 2) AS INT)) FROM Deliveryunits";
        try ( PreparedStatement st = connection.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                int maxID = rs.getInt(1);
                return "SM" + (maxID + 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "SM1"; // Trường hợp không có dữ liệu
    }

    public ArrayList<Deliveryunits> getActiveDeliveryUnits() {
        ArrayList<Deliveryunits> list = new ArrayList<>();
        String query = "SELECT * FROM deliveryunits WHERE status = 'active'";

        try ( PreparedStatement ps = connection.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Deliveryunits unit = new Deliveryunits(
                        rs.getString("unitID"),
                        rs.getString("unitName"),
                        rs.getString("status")
                );
                list.add(unit);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}

package DAO;

import DBContext.DBContext;
import Model.Deliveryunits;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DeliveryunitDAO extends DBContext {

    // Get all active delivery units
    public ArrayList<Deliveryunits> getAllDeliveryUnits() {
        ArrayList<Deliveryunits> unitList = new ArrayList<>();
        String sql = "SELECT * FROM Deliveryunits WHERE unitStatus = 'Active' ORDER BY CAST(SUBSTRING(unitID, 3, LEN(unitID) - 2) AS INT) DESC";

        try ( PreparedStatement st = connection.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Deliveryunits unit = new Deliveryunits(
                        rs.getString("unitID"),
                        rs.getString("unitName"),
                        rs.getDouble("unitFee"),
                        rs.getString("unitSpeed"),
                        rs.getString("unitStatus")
                );
                unitList.add(unit);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return unitList;
    }

    // Get delivery unit by ID
    public Deliveryunits getDeliveryUnitByID(String unitID) {
        String sql = "SELECT * FROM Deliveryunits WHERE unitID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Deliveryunits(
                        rs.getString("unitID"),
                        rs.getString("unitName"),
                        rs.getDouble("unitFee"),
                        rs.getString("unitSpeed"),
                        rs.getString("unitStatus")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Check if unit name exists and is active
    public boolean isUnitNameExistsAndActive(String unitName) {
        String sql = "SELECT COUNT(*) FROM Deliveryunits WHERE unitName = ? AND unitStatus = 'Active'";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add new delivery unit
    public boolean addDeliveryUnit(String unitName, double unitFee, String unitSpeed) {
        // Check if unit name already exists
        if (isUnitNameExistsAndActive(unitName)) {
            return false;
        }

        String sql = "INSERT INTO Deliveryunits (unitID, unitName, unitFee, unitSpeed, unitStatus) VALUES (?, ?, ?, ?, ?)";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            String newID = generateNewUnitID();
            st.setString(1, newID);
            st.setString(2, unitName);
            st.setDouble(3, unitFee);
            st.setString(4, unitSpeed);
            st.setString(5, "Active");
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update delivery unit
    public boolean updateDeliveryUnit(String unitID, String unitName, double unitFee, String unitSpeed) {
        // Get current unit info
        Deliveryunits currentUnit = getDeliveryUnitByID(unitID);

        // If name hasn't changed, no need to check for duplicates
        if (currentUnit != null && currentUnit.getUnitName().equals(unitName)) {
            String sql = "UPDATE Deliveryunits SET unitFee = ?, unitSpeed = ? WHERE unitID = ?";
            try ( PreparedStatement st = connection.prepareStatement(sql)) {
                st.setDouble(1, unitFee);
                st.setString(2, unitSpeed);
                st.setString(3, unitID);
                st.executeUpdate();
                return true;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }

        // Check if new name exists
        if (isUnitNameExistsAndActive(unitName)) {
            return false;
        }

        // Update with new name
        String sql = "UPDATE Deliveryunits SET unitName = ?, unitFee = ?, unitSpeed = ? WHERE unitID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitName);
            st.setDouble(2, unitFee);
            st.setString(3, unitSpeed);
            st.setString(4, unitID);
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Deactivate delivery unit
    public boolean deactivateDeliveryUnit(String unitID) {
        String sql = "UPDATE Deliveryunits SET unitStatus = 'Inactive' WHERE unitID = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, unitID);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Generate new unit ID
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
        return "SM1";
    }

}

package DAO;

import DBContext.DBContext;
import Model.Customers;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerDAO extends DBContext {

    public Customers getCustomerByID(String customerID) {
        String query = "SELECT * FROM Customers WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customerID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customers(
                            rs.getString("CustomerID"),
                            rs.getString("CustomerName"),
                            rs.getString("CustomerEmail"),
                            rs.getString("CustomerPNB"),
                            rs.getString("CustomerAddress"),
                            rs.getString("CustomerUsername"),
                            rs.getString("CustomerPassword"),
                            rs.getString("CustomerStatus")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customers checkCustomerExist(String username) {
        String sql = "SELECT * FROM [dbo].[Customers] WHERE [CustomerUsername] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Customers acc = new Customers(
                        rs.getString("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getString("CustomerEmail"),
                        rs.getString("CustomerPNB"),
                        rs.getString("CustomerAddress"),
                        rs.getString("CustomerUsername"),
                        rs.getString("CustomerPassword"),
                        rs.getString("CustomerStatus")
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

    public void createCustomer(Customers acc) {
        String sql = "INSERT INTO Customers VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, acc.getCustomerID());
            st.setString(2, acc.getCustomerName());
            st.setString(3, acc.getCustomerEmail());
            st.setString(4, acc.getCustomerPNB());
            st.setString(5, acc.getCustomerAddress());
            st.setString(6, acc.getCustomerUsername());
            st.setString(7, acc.getCustomerPassword());
            st.setString(8, acc.getCustomerStatus());
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getNextCustomerID() {
        String maxID = "C0"; // ID mặc định nếu không có dữ liệu
        String query = "SELECT MAX(CustomerID) FROM Customers";

        try ( PreparedStatement ps = connection.prepareStatement(query);  ResultSet rs = ps.executeQuery()) {

            if (rs.next() && rs.getString(1) != null) {
                maxID = rs.getString(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generateNextID(maxID);
    }

    private String generateNextID(String maxID) {
        // Lấy phần số từ ID (bỏ "C")
        int num = Integer.parseInt(maxID.substring(1));
        num++; // Tăng lên 1

        // Định dạng lại ID (C1, C2, C3, ...)
        return "C" + num;
    }

    public boolean updateCustomer(Customers customer) {
        String updateQuery = "UPDATE Customers SET CustomerName = ?, CustomerEmail = ?, CustomerPNB = ?, CustomerAddress = ? WHERE CustomerID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(updateQuery)) {
            ps.setString(1, customer.getCustomerName());
            ps.setString(2, customer.getCustomerEmail());
            ps.setString(3, customer.getCustomerPNB());
            ps.setString(4, customer.getCustomerAddress());
            ps.setString(5, customer.getCustomerID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Customers> getAllCustomers() {
        ArrayList<Customers> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers WHERE CustomerStatus = 'Active'";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customers cus = new Customers();
                cus.setCustomerID(rs.getString("CustomerID"));
                cus.setCustomerName(rs.getString("CustomerName"));
                cus.setCustomerEmail(rs.getString("CustomerEmail"));
                cus.setCustomerPNB(rs.getString("CustomerPNB"));
                cus.setCustomerAddress(rs.getString("CustomerAddress"));
                cus.setCustomerUsername(rs.getString("CustomerUsername"));
                cus.setCustomerPassword(rs.getString("CustomerPassword"));
                cus.setCustomerStatus(rs.getString("CustomerStatus"));
                list.add(cus);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customers getCustomerById(String id) {
        Customers cus = null;
        String sql = "SELECT * FROM Customers WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                cus = new Customers();
                cus.setCustomerID(rs.getString("CustomerID"));
                cus.setCustomerName(rs.getString("CustomerName"));
                cus.setCustomerEmail(rs.getString("CustomerEmail"));
                cus.setCustomerPNB(rs.getString("CustomerPNB"));
                cus.setCustomerAddress(rs.getString("CustomerAddress"));
                cus.setCustomerUsername(rs.getString("CustomerUsername"));
                cus.setCustomerPassword(rs.getString("CustomerPassword"));
                cus.setCustomerStatus(rs.getString("CustomerStatus"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cus;
    }

    public void lockCustomer(String id) {
        String sql = "UPDATE Customers SET CustomerStatus = 'Locked' WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unlockCustomer(String id) {
        String sql = "UPDATE Customers SET CustomerStatus = 'Active' WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCustomer(String id) {
        String sql = "UPDATE Customers SET CustomerStatus = 'Unactive' WHERE CustomerID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
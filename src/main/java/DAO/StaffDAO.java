/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Customers;
import Model.Staffs;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Long Ho
 */
public class StaffDAO extends DBContext{
    public StaffDAO() {
        super();
    }
    
    public Object checkAccount(String username, String password) {
    String sql = "SELECT * FROM ( " +
                 "    SELECT " +
                 "       StaffID AS UserID, " +
                 "       Username, " +
                 "       [Password], " +
                 "       [Role], " +
                 "       StaffName AS Name, " +
                 "       StaffAddress AS Address, " +
                 "       StaffPNB AS Phone, " +
                 "       'Staff' AS UserType, " +
                 "       [Status] " +
                 "    FROM Staffs " +
                 "    WHERE Username = ? AND [Password] = ? AND [Status] = 'Active' " +
                 "    UNION " +
                 "    SELECT " +
                 "       CustomerID AS UserID, " +
                 "       Username, " +
                 "       [Password], " +
                 "       NULL AS [Role], " +
                 "       CustomerName AS Name, " +
                 "       CustomerAddress AS Address, " +
                 "       CustomerPNB AS Phone, " +
                 "       'Customer' AS UserType, " +
                 "       [Status] " +
                 "    FROM Customers " +
                 "    WHERE Username = ? AND [Password] = ? AND [Status] = 'Active' " +
                 ") AS CombinedAccount";
    
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, username);
        st.setString(2, password);
        st.setString(3, username);
        st.setString(4, password);
        
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            String userType = rs.getString("UserType"); 
            String userID = rs.getString("UserID");
            String uname = rs.getString("Username");
            String pass = rs.getString("Password");
            String name = rs.getString("Name");
            String address = rs.getString("Address");
            int phone = rs.getInt("Phone");
            
            if ("Staff".equalsIgnoreCase(userType)) {
                Staffs staff = new Staffs();
                staff.setStaffID(userID);
                staff.setUsername(uname);
                staff.setPassword(pass);
                staff.setRole(rs.getString("Role"));
                staff.setStaffName(name);
                staff.setStaffAddress(address);
                staff.setStaffPNB(phone);
                staff.setStatus("Active");
                rs.close();
                st.close();
                return staff;
            } else {  // Customers
                Customers customer = new Customers();
                customer.setCustomerID(userID);
                customer.setUsername(uname);
                customer.setPassword(pass);
                customer.setCustomerName(name);
                customer.setCustomerAddress(address);
                customer.setCustomerPNB(phone);
                customer.setStatus("Active");
                rs.close();
                st.close();
                return customer;
            }
        }
        rs.close();
        st.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return null;
}
    
    public List<Staffs> getAllStaffAccounts() {
    List<Staffs> list = new ArrayList<>();
    String sql = "SELECT StaffID, Username, [Password], [Role], StaffName, StaffAddress, StaffPNB, StaffEmail, [Status] " +
                 "FROM Staffs " +
                 "WHERE [Role] <> 'Admin'";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            Staffs staff = new Staffs();
            staff.setStaffID(rs.getString("StaffID"));
            staff.setUsername(rs.getString("Username"));
            staff.setPassword(rs.getString("Password"));
            staff.setRole(rs.getString("Role"));
            staff.setStaffName(rs.getString("StaffName"));
            staff.setStaffAddress(rs.getString("StaffAddress"));
            staff.setStaffPNB(rs.getInt("StaffPNB"));
            staff.setStaffEmail(rs.getString("StaffEmail"));
            staff.setStatus(rs.getString("Status"));
            list.add(staff);
        }
        rs.close();
        ps.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}
    
    public Staffs getStaffByID(String staffID) {
        Staffs staff = null;
        try {
            String sql = "SELECT * FROM Staffs WHERE StaffID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, staffID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                staff = new Staffs(
                    rs.getString("StaffID"),
                    rs.getString("StaffName"),
                    rs.getString("StaffEmail"),
                    rs.getInt("StaffPNB"),
                    rs.getString("StaffAddress"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Role"),
                    rs.getString("Status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }
    
    public boolean isUniqueStaffAccount(String staffID, String username, String email) {
        boolean isUnique = true;
        String sql = "SELECT StaffID, Username, StaffEmail FROM Staffs WHERE StaffID = ? OR Username = ? OR StaffEmail = ? " +
                     "UNION " +
                     "SELECT CustomerID AS StaffID, Username, CustomerEmail AS StaffEmail FROM Customers WHERE Username = ? OR CustomerEmail = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, staffID);
            ps.setString(2, username);
            ps.setString(3, email);
            ps.setString(4, username);
            ps.setString(5, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                isUnique = false;
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            isUnique = false;
        }
        return isUnique;
    }
    
    public boolean addStaff(Staffs staff) {
        if (!isUniqueStaffAccount(staff.getStaffID(), staff.getUsername(), staff.getStaffEmail())) {
            return false;
        }
        
        boolean success = false;
        String sql = "INSERT INTO Staffs (StaffID, Username, [Password], [Role], StaffName, StaffEmail, StaffAddress, StaffPNB, [Status]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getStaffID());
            ps.setString(2, staff.getUsername());
            ps.setString(3, staff.getPassword());
            ps.setString(4, staff.getRole());
            ps.setString(5, staff.getStaffName());
            ps.setString(6, staff.getStaffEmail());
            ps.setString(7, staff.getStaffAddress());
            ps.setInt(8, staff.getStaffPNB());
            ps.setString(9, staff.getStatus());
            int rows = ps.executeUpdate();
            if(rows > 0){
                success = true;
            }
            ps.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return success;
    }
    
    public boolean blockStaffAccount(String staffID) {
    boolean success = false;
    String sql = "UPDATE Staffs SET [Status] = 'Inactive' WHERE StaffID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, staffID);
        int rows = ps.executeUpdate();
        if(rows > 0){
            success = true;
        }
        ps.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return success;
}
    
    public boolean updateStaff(Staffs staff) {
    boolean success = false;
    String sql = "UPDATE Staffs SET Username = ?, [Password] = ?, StaffName = ?, StaffEmail = ?, StaffAddress = ?, StaffPNB = ?, [Status] = ? " +
                 "WHERE StaffID = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, staff.getUsername());
        ps.setString(2, staff.getPassword());
        ps.setString(3, staff.getStaffName());
        ps.setString(4, staff.getStaffEmail());
        ps.setString(5, staff.getStaffAddress());
        ps.setInt(6, staff.getStaffPNB());
        ps.setString(7, staff.getStatus());
        ps.setString(8, staff.getStaffID());
        int rows = ps.executeUpdate();
        if (rows > 0) {
            success = true;
        }
        ps.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return success;
}
    
    public static void main(String[] args) {
        StaffDAO staffDAO = new StaffDAO();

        Staffs staffDetail = staffDAO.getStaffByID("S001");
    }
    }


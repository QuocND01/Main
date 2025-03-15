/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Categorys;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author QuocNDCE181301
 */
public class CategoryDAO extends DBContext.DBContext {

    public ArrayList<Categorys> getAllCategorys() {
        ArrayList<Categorys> list = new ArrayList<>();
        String sql = "SELECT * FROM Categorys";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categorys(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }
        return list;
    }
    
    public void insertCategory(Categorys cate) {
        String sql = "INSERT INTO Categorys VALUES (?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cate.getCategoryID());
            st.setString(2, cate.getCategoryName());
            st.setString(3, "Active");
            st.executeUpdate();
            st.close();
        } catch (SQLException ex) {
        }
    }

    public void deleteCategory(String CategoryID) {
        String sql = "UPDATE Categorys SET [Status] = ? WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "Unactive");
            st.setString(2, CategoryID);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }

    public int getrow() {
        String sql = "SELECT COUNT(*) FROM Categorys";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String a = rs.getString(1);
                int b = Integer.parseInt(a);
                return b;
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }
        return 0;
    }

    public void updateCategory(Categorys cate) {
        String sql = "UPDATE Categorys SET CategoryName = ?\n"
                + "                WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cate.getCategoryName());
            st.setString(2, cate.getCategoryID());
            st.executeUpdate();
            st.close();

        } catch (SQLException e) {
        }
    }

    
    public Categorys getCategoryByID(String CategoryID) {
        String sql = "	SELECT * FROM Categorys WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, CategoryID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return (new Categorys(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return null;
    }
    
    public ArrayList<Categorys> searchCategory(String search) {
        ArrayList<Categorys> list = new ArrayList<>();
        String sql = "	SELECT * FROM Categorys WHERE [CategoryName] like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + search.trim() + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categorys(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return list;
    }
    public static void main(String[] args) {
        CategoryDAO d = new CategoryDAO();
        d.deleteCategory("CT11");

    }
}

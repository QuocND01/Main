/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Categories;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author QuocNDCE181301
 */
public class CategoryDAO extends DBContext.DBContext {

    public ArrayList<Categories> getAllCategorys() {
        ArrayList<Categories> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories Where CategoryStatus = 'Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categories(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }
        return list;
    }
    
    public void insertCategory(Categories cate) {
        String sql = "INSERT INTO Categories VALUES (?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cate.getCategoryID());
            st.setString(2, cate.getCategoryName());
            st.setString(3, cate.getCategoryDescription());
            st.setString(4, "Active");
            st.executeUpdate();
            st.close();
        } catch (SQLException ex) {
        }
    }

    public void deleteCategory(String CategoryID) {
        String sql = "UPDATE Categories SET [CategoryStatus] = ? WHERE CategoryID = ? AND CategoryStatus = 'Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "Inactive");
            st.setString(2, CategoryID);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }

    public int getrow() {
        String sql = "SELECT COUNT(*) FROM Categories";
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

    public void updateCategory(Categories cate) {
        String sql = "UPDATE Categories SET CategoryName = ?, CategoryDescription = ? \n"
                + "                WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cate.getCategoryName());
            st.setString(2, cate.getCategoryDescription());
            st.setString(3, cate.getCategoryID());
            st.executeUpdate();
            st.close();

        } catch (SQLException e) {
        }
    }

    
    public Categories getCategoryByID(String CategoryID) {
        String sql = "	SELECT * FROM Categories WHERE CategoryID = ? AND CategoryStatus = 'Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, CategoryID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return (new Categories(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return null;
    }
    
    public ArrayList<Categories> searchCategory(String search) {
        ArrayList<Categories> list = new ArrayList<>();
        String sql = "	SELECT * FROM Categories WHERE [CategoryName] like ? AND CategoryStatus = 'Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + search.trim() + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categories(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return list;
    }
    public static void main(String[] args) {
        CategoryDAO d = new CategoryDAO();
        ArrayList <Categories> ca = new ArrayList<>();
        ca=d.getAllCategorys();
        for (Categories categories : ca) {
            System.out.println(categories.toString());
        }

    }
}

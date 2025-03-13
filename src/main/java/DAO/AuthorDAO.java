/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Authors;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author QuocNDCE181301
 */
public class AuthorDAO extends DBContext.DBContext{

    public AuthorDAO() {
        super();
    }
     public ArrayList<Authors> getAllAuthor() {
        ArrayList<Authors> list = new ArrayList<>();
        String sql = "SELECT * FROM Authors";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Authors(
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
     
     
     public void addAuthor(Authors author) {
        String sql = "INSERT INTO Authors VALUES (?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, author.getAuthorID());
            st.setString(2, author.getAuthorName());
            st.setString(3, "Active");
            st.executeUpdate();
            st.close();
        } catch (SQLException ex) {
        }
    }
     
     
     public int getrow() {
        String sql = "SELECT COUNT(*) FROM Authors";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String a =  rs.getString(1);
                int b = Integer.parseInt(a);
                return b;
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }
        return 0;
    }
     
     
     public static void main(String[] args) {
        AuthorDAO dao = new AuthorDAO();
                ArrayList <Authors> list = new ArrayList<>();
                list = dao.getAllAuthor();
                for (Authors a : list) {
                    System.out.println(a.getAuthorID());
        }
                
//        int id = dao.getrow();
//         System.out.println(id);
    }
     public void updateAuthor(Authors author) {
        String sql = "UPDATE Authors SET authorName=?, status=? WHERE authorID=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, author.getAuthorName());
            st.setString(2, author.getStatus());
            st.setString(3, author.getAuthorID());
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteAuthor(String authorID) {
        String sql = "UPDATE Authors SET status = 'Inactive' WHERE authorID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, authorID);
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getNextAuthorID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(authorID, 2, LEN(authorID)) AS INT)) FROM Authors";
        String nextID = "A1";  // Giá trị mặc định

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                int maxID = rs.getInt(1);
                nextID = "A" + (maxID + 1);  // Tăng ID lên 1 và gán vào nextID
            }

            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextID;
    }
}

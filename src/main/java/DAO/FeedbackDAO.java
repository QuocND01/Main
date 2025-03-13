/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBContext.DBContext;
import Model.Feedbacks;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Long Ho
 */
public class FeedbackDAO extends DBContext {

    public List<Map<String, Object>> getFeedbackByBookId(String bookId) {
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        String sql = "SELECT f.FeedbackID, f.Star, f.Detail, c.CustomerName "
                + "FROM Feedback f "
                + "JOIN Customers c ON f.CustomerID = c.CustomerID "
                + "WHERE f.BookID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> feedback = new HashMap<>();
                feedback.put("FeedbackID", rs.getInt("FeedbackID"));
                feedback.put("Star", rs.getInt("Star"));
                feedback.put("Detail", rs.getString("Detail"));
                feedback.put("CustomerName", rs.getString("CustomerName"));
                feedbackList.add(feedback);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

    public int generateNewFeedbackID() {
        String sql = "SELECT MAX(FeedbackID) FROM Feedback";
        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }

    public boolean insertFeedback(String customerID, String bookID, int star, String detail) {
        int newID = generateNewFeedbackID();
        String sql = "INSERT INTO Feedback (FeedbackID, CustomerID, BookID, Star, Detail) VALUES (?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newID);
            ps.setString(2, customerID);
            ps.setString(3, bookID);
            ps.setInt(4, star);
            ps.setString(5, detail);

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0; // Trả về true nếu insert thành công

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Nếu lỗi, trả về false
    }

    public boolean isFeedbackExist(String customerID, String bookID) {
        String sql = "SELECT COUNT(*) FROM Feedback WHERE CustomerID = ? AND BookID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerID);
            ps.setString(2, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu số lượng > 0 tức là đã có feedback
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Feedbacks getFeedback(String customerID, String bookID) {
        String sql = "SELECT * FROM Feedback WHERE CustomerID = ? AND BookID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerID);
            ps.setString(2, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Feedbacks(
                        rs.getInt("FeedbackID"),
                        rs.getString("CustomerID"),
                        rs.getString("BookID"),
                        rs.getInt("Star"),
                        rs.getString("Detail")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateFeedback(int feedbackID, int star, String detail) {
    String sql = "UPDATE Feedback SET Star = ?, Detail = ? WHERE FeedbackID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, star);
        ps.setString(2, detail);
        ps.setInt(3, feedbackID);
        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0; // ✅ Trả về true nếu update thành công
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public boolean deleteFeedback(String customerID, String bookID) {
    String sql = "DELETE FROM Feedback WHERE CustomerID = ? AND BookID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, customerID);
        ps.setString(2, bookID);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

}

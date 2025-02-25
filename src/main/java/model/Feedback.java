/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Feedback {
    private int feedbackId;
    private String customerId;
    private String bookId;
    private int star;
    private String detail;

    public Feedback() {
    }

    public Feedback(int feedbackId, String customerId, String bookId, int star, String detail) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.bookId = bookId;
        this.star = star;
        this.detail = detail;
    }

    // Getters và Setters

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
    

    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackId=" + feedbackId +
                ", customerId='" + customerId + '\'' +
                ", bookId='" + bookId + '\'' +
                ", star=" + star +
                ", detail='" + detail + '\'' +
                '}';
    }
}


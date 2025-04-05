/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Long Ho
 */
public class Feedbacks {
    private int feedbackID;
    private String customerID;
    private String bookID;
    private int star;
    private String feedbackDetail;

    public Feedbacks() {
    }

    public Feedbacks(int feedbackID, String customerID, String bookID, int star, String feedbackDetail) {
        this.feedbackID = feedbackID;
        this.customerID = customerID;
        this.bookID = bookID;
        this.star = star;
        this.feedbackDetail = feedbackDetail;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getFeedbackDetail() {
        return feedbackDetail;
    }

    public void setFeedbackDetail(String feedbackDetail) {
        this.feedbackDetail = feedbackDetail;
    }

    @Override
    public String toString() {
        return "Feedbacks{" + "feedbackID=" + feedbackID + ", customerID=" + customerID + ", bookID=" + bookID + ", star=" + star + ", feedbackDetail=" + feedbackDetail + '}';
    }

}

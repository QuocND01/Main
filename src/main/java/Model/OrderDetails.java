/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Long Ho
 */
public class OrderDetails {
    private String orderDetailID;
    private String orderID;
    private String bookID;
    private int quantity;
    private double price;

    public OrderDetails() {
    }

    public OrderDetails(String orderDetailID, String orderID, String bookID, int quantity, double price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.bookID = bookID;
        this.quantity = quantity;
        this.price = price;
    }

    public String getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(String orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "OrderDetails{" + "orderDetailID=" + orderDetailID + ", orderID=" + orderID + ", bookID=" + bookID + ", quantity=" + quantity + ", price=" + price + '}';
    }

    
    
    
}

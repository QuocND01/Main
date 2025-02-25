/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
import java.math.BigDecimal;

public class Orders_Details {
    private String orderDetailId;
    private String orderId;
    private String bookId;
    private int quantity;
    private BigDecimal price;

    public Orders_Details() {
    }

    public Orders_Details(String orderDetailId, String orderId, String bookId, int quantity, BigDecimal price) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters và Setters

    public String getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(String orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    

    @Override
    public String toString() {
        return "OrderDetail{" +
                "orderDetailId='" + orderDetailId + '\'' +
                ", orderId='" + orderId + '\'' +
                ", bookId='" + bookId + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
}


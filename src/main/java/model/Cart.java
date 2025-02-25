/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Cart {
    private String cartId;
    private String customerId;
    private String bookId;
    private String voucherId;
    private int quantity;

    public Cart() {
    }

    public Cart(String cartId, String customerId, String bookId, String voucherId, int quantity) {
        this.cartId = cartId;
        this.customerId = customerId;
        this.bookId = bookId;
        this.voucherId = voucherId;
        this.quantity = quantity;
    }

    // Getters và Setters

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
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

    public String getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(String voucherId) {
        this.voucherId = voucherId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    

    @Override
    public String toString() {
        return "Cart{" +
                "cartId='" + cartId + '\'' +
                ", customerId='" + customerId + '\'' +
                ", bookId='" + bookId + '\'' +
                ", voucherId='" + voucherId + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}


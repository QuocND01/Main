/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Warehouse {
    private String stockId;
    private String bookId;
    private String staffId;
    private int quantity;

    public Warehouse() {
    }

    public Warehouse(String stockId, String bookId, String staffId, int quantity) {
        this.stockId = stockId;
        this.bookId = bookId;
        this.staffId = staffId;
        this.quantity = quantity;
    }

    // Getters và Setters

    public String getStockId() {
        return stockId;
    }

    public void setStockId(String stockId) {
        this.stockId = stockId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    

    @Override
    public String toString() {
        return "Warehouse{" +
                "stockId='" + stockId + '\'' +
                ", bookId='" + bookId + '\'' +
                ", staffId='" + staffId + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}


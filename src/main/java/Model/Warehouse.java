/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
public class Warehouse {

    private String StockID;
    private String BookID;
    private String bookName;
    private String StaffID;
    private int Stock;
    private int Quantity;

    public Warehouse(String StockID, String BookID, String bookName, String StaffID, int Stock, int Quantity) {
        this.StockID = StockID;
        this.bookName = bookName;
        this.BookID = BookID;
        this.StaffID = StaffID;
        this.Stock = Stock;
        this.Quantity = Quantity;
    }

    public String getStockID() {
        return StockID;
    }

    public void setStockID(String StockID) {
        this.StockID = StockID;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getBookID() {
        return BookID;
    }

    public void setBookID(String BookID) {
        this.BookID = BookID;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int Stock) {
        this.Stock = Stock;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

}

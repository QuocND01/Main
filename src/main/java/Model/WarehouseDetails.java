/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
public class WarehouseDetails {

    private String warehouseDetailsID;
    private String bookID;
    private String bookName; // Tên sách
    private double bookPrice; // Giá sách
    private int stock;
    private double importBookValue;
    private String stockID;
    private String staffName; // Tên nhân viên nhập kho
    private String supplierName;
    private Date importDate;

    public WarehouseDetails(String warehouseDetailsID, String bookID, String bookName, double bookPrice, int stock, double importBookValue, String stockID, String staffName, String supplierName, Date importDate, double totalCost) {
        this.warehouseDetailsID = warehouseDetailsID;
        this.bookID = bookID;
        this.bookName = bookName;
        this.bookPrice = bookPrice;
        this.stock = stock;
        this.importBookValue = importBookValue;
        this.stockID = stockID;
        this.staffName = staffName;
        this.supplierName = supplierName;
        this.importDate = importDate;
        this.totalCost = totalCost;
    }
    private double totalCost; // Tổng chi phí nhập hàng

    public String getWarehouseDetailsID() {
        return warehouseDetailsID;
    }

    public void setWarehouseDetailsID(String warehouseDetailsID) {
        this.warehouseDetailsID = warehouseDetailsID;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getImportBookValue() {
        return importBookValue;
    }

    public void setImportBookValue(double importBookValue) {
        this.importBookValue = importBookValue;
    }

    public String getStockID() {
        return stockID;
    }

    public void setStockID(String stockID) {
        this.stockID = stockID;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    

}

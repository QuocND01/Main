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
public class Warehouse {
private String StockID;
    private String StaffID;
    private String SupplierName;
    private Date ImportDate;
    private long TotalCost;

    public Warehouse(String StockID, String StaffID, String SupplierName, Date ImportDate, long TotalCost) {
        this.StockID = StockID;
        this.StaffID = StaffID;
        this.SupplierName = SupplierName;
        this.ImportDate = ImportDate;
        this.TotalCost = TotalCost;
    }

    public String getStockID() {
        return StockID;
    }

    public void setStockID(String StockID) {
        this.StockID = StockID;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }

    public String getSupplierName() {
        return SupplierName;
    }

    public void setSupplierName(String SupplierName) {
        this.SupplierName = SupplierName;
    }

    public Date getImportDate() {
        return ImportDate;
    }

    public void setImportDate(Date ImportDate) {
        this.ImportDate = ImportDate;
    }

    public double getTotalCost() {
        return TotalCost;
    }

    public void setTotalCost(long TotalCost) {
        this.TotalCost = TotalCost;
    }

}

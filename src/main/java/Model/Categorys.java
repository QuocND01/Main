/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author QuocNDCE181301
 */
public class Categorys {
    private String CategoryID;
    private String CategoryName;
    private String Status;

    public Categorys() {
    }

    public Categorys(String CategoryID, String CategoryName, String Status) {
        this.CategoryID = CategoryID;
        this.CategoryName = CategoryName;
        this.Status = Status;
    }

    public String getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(String CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Categorys{" + "CategoryID=" + CategoryID + ", CategoryName=" + CategoryName + ", Status=" + Status + '}';
    }

    
    
}

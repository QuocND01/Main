/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author NDQ
 */
public class Books {

    private String BookID;
    private String BookName;
    private String SupplierName;
    private String Author;
    private String YearOfPublication;
    private String Weight;
    private String Size;
    private String NumberOfPages;
    private String Form;
    private String Describe;
    private String Image;
    private String Price;
    private String Stock;
    private String CategoryID;
    private String Status;

    public Books() {
    }

    public Books(String BookID, String BookName, String SupplierName, String Author, String YearOfPublication, String Weight, String Size, String NumberOfPages, String Form, String Discribe, String Image, String Price, String Stock, String CategoryID, String Status) {
        this.BookID = BookID;
        this.BookName = BookName;
        this.SupplierName = SupplierName;
        this.Author = Author;
        this.YearOfPublication = YearOfPublication;
        this.Weight = Weight;
        this.Size = Size;
        this.NumberOfPages = NumberOfPages;
        this.Form = Form;
        this.Describe = Discribe;
        this.Image = Image;
        this.Price = Price;
        this.Stock = Stock;
        this.CategoryID = CategoryID;
        this.Status = Status;
    }

    public String getBookID() {
        return BookID;
    }

    public void setBookID(String BookID) {
        this.BookID = BookID;
    }

    public String getBookName() {
        return BookName;
    }

    public void setBookName(String BookName) {
        this.BookName = BookName;
    }

    public String getSupplierName() {
        return SupplierName;
    }

    public void setSupplierName(String SupplierName) {
        this.SupplierName = SupplierName;
    }

    public String getAuthor() {
        return Author;
    }

    public void setAuthor(String Author) {
        this.Author = Author;
    }

    public String getYearOfPublication() {
        return YearOfPublication;
    }

    public void setYearOfPublication(String YearOfPublication) {
        this.YearOfPublication = YearOfPublication;
    }

    public String getWeight() {
        return Weight;
    }

    public void setWeight(String Weight) {
        this.Weight = Weight;
    }

    public String getSize() {
        return Size;
    }

    public void setSize(String Size) {
        this.Size = Size;
    }

    public String getNumberOfPages() {
        return NumberOfPages;
    }

    public void setNumberOfPages(String NumberOfPages) {
        this.NumberOfPages = NumberOfPages;
    }

    public String getForm() {
        return Form;
    }

    public void setForm(String Form) {
        this.Form = Form;
    }

    public String getDescribe() {
        return Describe;
    }

    public void setDescribe(String Discribe) {
        this.Describe = Discribe;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getPrice() {
        return Price;
    }

    public void setPrice(String Price) {
        this.Price = Price;
    }

    public String getStock() {
        return Stock;
    }

    public void setStock(String Stock) {
        this.Stock = Stock;
    }

    public String getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(String CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Books{" + "BookID=" + BookID + ", BookName=" + BookName + ", SupplierName=" + SupplierName + ", Author=" + Author + ", YearOfPublication=" + YearOfPublication + ", Weight=" + Weight + ", Size=" + Size + ", NumberOfPages=" + NumberOfPages + ", Form=" + Form + ", Describe=" + Describe + ", Image=" + Image + ", Price=" + Price + ", Stock=" + Stock + ", CategoryID=" + CategoryID + ", Status=" + Status + '}';
    }

    
    
}

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

    private String bookID;
    private String bookName;
    private String bookSupplierName;
    private String authorID;
    private String yearOfPublication;
    private double weight;
    private String size;
    private int numberOfPages;
    private String form;
    private String bookDescribe;
    private String image;
    private double bookPrice;
    private int bookQuantity;
    private String categoryID;
    private String bookStatus;

    public Books() {
    }

    public Books(String bookID, String bookName, String bookSupplierName, String authorID, String yearOfPublication, double weight, String size, int numberOfPages, String form, String bookDescribe, String image, double bookPrice, int bookQuantity, String categoryID, String bookStatus) {
        this.bookID = bookID;
        this.bookName = bookName;
        this.bookSupplierName = bookSupplierName;
        this.authorID = authorID;
        this.yearOfPublication = yearOfPublication;
        this.weight = weight;
        this.size = size;
        this.numberOfPages = numberOfPages;
        this.form = form;
        this.bookDescribe = bookDescribe;
        this.image = image;
        this.bookPrice = bookPrice;
        this.bookQuantity = bookQuantity;
        this.categoryID = categoryID;
        this.bookStatus = bookStatus;
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

    public String getBookSupplierName() {
        return bookSupplierName;
    }

    public void setBookSupplierName(String bookSupplierName) {
        this.bookSupplierName = bookSupplierName;
    }

    public String getAuthorID() {
        return authorID;
    }

    public void setAuthorID(String authorID) {
        this.authorID = authorID;
    }

    public String getYearOfPublication() {
        return yearOfPublication;
    }

    public void setYearOfPublication(String yearOfPublication) {
        this.yearOfPublication = yearOfPublication;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getNumberOfPages() {
        return numberOfPages;
    }

    public void setNumberOfPages(int numberOfPages) {
        this.numberOfPages = numberOfPages;
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public String getBookDescribe() {
        return bookDescribe;
    }

    public void setBookDescribe(String bookDescribe) {
        this.bookDescribe = bookDescribe;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public int getBookQuantity() {
        return bookQuantity;
    }

    public void setBookQuantity(int bookQuantity) {
        this.bookQuantity = bookQuantity;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getBookStatus() {
        return bookStatus;
    }

    public void setBookStatus(String bookStatus) {
        this.bookStatus = bookStatus;
    }

    @Override
    public String toString() {
        return "Books{" + "bookID=" + bookID + ", bookName=" + bookName + ", bookSupplierName=" + bookSupplierName + ", authorID=" + authorID + ", yearOfPublication=" + yearOfPublication + ", weight=" + weight + ", size=" + size + ", numberOfPages=" + numberOfPages + ", form=" + form + ", bookDescribe=" + bookDescribe + ", image=" + image + ", bookPrice=" + bookPrice + ", bookQuantity=" + bookQuantity + ", categoryID=" + categoryID + ", bookStatus=" + bookStatus + '}';
    }

    

    
}

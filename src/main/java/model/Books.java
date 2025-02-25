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
import java.util.Date;

public class Books {
    private String bookId;
    private String bookName;
    private String supplierName;
    private String author;
    private Date yearOfPublication;
    private BigDecimal weight;
    private String size;
    private int numberOfPages;
    private String form;
    private String describe;
    private String image;
    private BigDecimal price;
    private int stock;
    private int categoryId;
    private String status;

    public Books() {
    }

    public Books(String bookId, String bookName, String supplierName, String author, Date yearOfPublication, BigDecimal weight,
                String size, int numberOfPages, String form, String describe, String image, BigDecimal price,
                int stock, int categoryId, String status) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.supplierName = supplierName;
        this.author = author;
        this.yearOfPublication = yearOfPublication;
        this.weight = weight;
        this.size = size;
        this.numberOfPages = numberOfPages;
        this.form = form;
        this.describe = describe;
        this.image = image;
        this.price = price;
        this.stock = stock;
        this.categoryId = categoryId;
        this.status = status;
    }

    // Getters và Setters

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getYearOfPublication() {
        return yearOfPublication;
    }

    public void setYearOfPublication(Date yearOfPublication) {
        this.yearOfPublication = yearOfPublication;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
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

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    @Override
    public String toString() {
        return "Book{" +
                "bookId='" + bookId + '\'' +
                ", bookName='" + bookName + '\'' +
                ", supplierName='" + supplierName + '\'' +
                ", author='" + author + '\'' +
                ", yearOfPublication=" + yearOfPublication +
                ", weight=" + weight +
                ", size='" + size + '\'' +
                ", numberOfPages=" + numberOfPages +
                ", form='" + form + '\'' +
                ", describe='" + describe + '\'' +
                ", image='" + image + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", categoryId=" + categoryId +
                ", status='" + status + '\'' +
                '}';
    }
}


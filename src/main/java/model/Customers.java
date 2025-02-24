/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Customers {
    
    private String CustomerID;
    private String CustomerName;
    private String CustomerEmail;
    private String CustomerPNB;
    private String CustomerAddress;
    private String Username;
    private String Password;
    private String Status;

    public Customers() {
    }

    public Customers(String CustomerID, String CustomerName, String CustomerEmail, String CustomerPNB, String CustomerAddress, String Username, String Password, String Status) {
        this.CustomerID = CustomerID;
        this.CustomerName = CustomerName;
        this.CustomerEmail = CustomerEmail;
        this.CustomerPNB = CustomerPNB;
        this.CustomerAddress = CustomerAddress;
        this.Username = Username;
        this.Password = Password;
        this.Status = Status;
    }

    public String getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(String CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String CustomerName) {
        this.CustomerName = CustomerName;
    }

    public String getCustomerEmail() {
        return CustomerEmail;
    }

    public void setCustomerEmail(String CustomerEmail) {
        this.CustomerEmail = CustomerEmail;
    }

    public String getCustomerPNB() {
        return CustomerPNB;
    }

    public void setCustomerPNB(String CustomerPNB) {
        this.CustomerPNB = CustomerPNB;
    }

    public String getCustomerAddress() {
        return CustomerAddress;
    }

    public void setCustomerAddress(String CustomerAddress) {
        this.CustomerAddress = CustomerAddress;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Customers{" + "CustomerID=" + CustomerID + ", CustomerName=" + CustomerName + ", CustomerEmail=" + CustomerEmail + ", CustomerPNB=" + CustomerPNB + ", CustomerAddress=" + CustomerAddress + ", Username=" + Username + ", Password=" + Password + ", Status=" + Status + '}';
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


/**
 *
 * @author Long Ho
 */
public class Customers {
    private String customerID;
    private String customerName;
    private String customerEmail;
    private String customerPNB;
    private String customerAddress;
    private String username;
    private String password;
    private String status;

    public Customers() {
    }

    public String getCustomerID() {
        return customerID;
    }

    public Customers(String customerID, String customerName, String customerEmail, String customerPNB, String customerAddress, String username, String password, String status) {
        this.customerID = customerID;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPNB = customerPNB;
        this.customerAddress = customerAddress;
        this.username = username;
        this.password = password;
        this.status = status;
    }
    

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPNB() {
        return customerPNB;
    }

    public void setCustomerPNB(String customerPNB) {
        this.customerPNB = customerPNB;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Customers{" + "customerID=" + customerID + ", customerName=" + customerName + ", customerEmail=" + customerEmail + ", customerPNB=" + customerPNB + ", customerAddress=" + customerAddress + ", username=" + username + ", password=" + password + ", status=" + status + '}';
    }

    
    
    
}

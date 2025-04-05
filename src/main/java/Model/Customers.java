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
    private String customerUsername;
    private String customerPassword;
    private String customerStatus;

    public Customers() {
    }

    public Customers(String customerID, String customerName, String customerEmail, String customerPNB, String customerAddress, String customerUsername, String customerPassword, String customerStatus) {
        this.customerID = customerID;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPNB = customerPNB;
        this.customerAddress = customerAddress;
        this.customerUsername = customerUsername;
        this.customerPassword = customerPassword;
        this.customerStatus = customerStatus;
    }

    public String getCustomerID() {
        return customerID;
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

    public String getCustomerUsername() {
        return customerUsername;
    }

    public void setCustomerUsername(String customerUsername) {
        this.customerUsername = customerUsername;
    }

    public String getCustomerPassword() {
        return customerPassword;
    }

    public void setCustomerPassword(String customerPassword) {
        this.customerPassword = customerPassword;
    }

    public String getCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(String customerStatus) {
        this.customerStatus = customerStatus;
    }

    @Override
    public String toString() {
        return "Customers{" + "customerID=" + customerID + ", customerName=" + customerName + ", customerEmail=" + customerEmail + ", customerPNB=" + customerPNB + ", customerAddress=" + customerAddress + ", customerUsername=" + customerUsername + ", customerPassword=" + customerPassword + ", customerStatus=" + customerStatus + '}';
    }

    
}

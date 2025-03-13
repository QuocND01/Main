/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Long Ho
 */
public class Orders {
    private String orderID;
    private String customerID;
    private String staffID;
    private Date orderDate;
    private String voucherID;
    private double value;
    private String unitID;
    private Date orderCompleteDate; 
    private String orderStatus;

    public Orders() {
    }

    public Orders(String orderID, String customerID, String staffID, Date orderDate, String voucherID, double value, String unitID, Date orderCompleteDate, String orderStatus) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.staffID = staffID;
        this.orderDate = orderDate;
        this.voucherID = voucherID;
        this.value = value;
        this.unitID = unitID;
        this.orderCompleteDate = orderCompleteDate;
        this.orderStatus = orderStatus;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public String getUnitID() {
        return unitID;
    }

    public void setUnitID(String unitID) {
        this.unitID = unitID;
    }

    public Date getOrderCompleteDate() {
        return orderCompleteDate;
    }

    public void setOrderCompleteDate(Date orderCompleteDate) {
        this.orderCompleteDate = orderCompleteDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "Orders{" + "orderID=" + orderID + ", customerID=" + customerID + ", staffID=" + staffID + ", orderDate=" + orderDate + ", voucherID=" + voucherID + ", value=" + value + ", unitID=" + unitID + ", orderCompleteDate=" + orderCompleteDate + ", orderStatus=" + orderStatus + '}';
    }

    
}

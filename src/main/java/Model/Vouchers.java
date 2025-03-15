/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Long Ho
 */
public class Vouchers {
    private String voucherID;
    private String voucherName;
    private int value;
    private String status;

    public Vouchers() {
    }

    public Vouchers(String voucherID, String voucherName, int value, String status) {
        this.voucherID = voucherID;
        this.voucherName = voucherName;
        this.value = value;
        this.status = status;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Vouchers{" + "voucherID=" + voucherID + ", voucherName=" + voucherName + ", value=" + value + ", status=" + status + '}';
    }

    
}

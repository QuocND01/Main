/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author QuocNHMCE182015
 */
public class Vouchers {
    private String voucherID;
    private String voucherName;
    private int voucherValue;
    private String voucherStatus;

    public Vouchers() {
    }

    public Vouchers(String voucherID, String voucherName, int voucherValue, String voucherStatus) {
        this.voucherID = voucherID;
        this.voucherName = voucherName;
        this.voucherValue = voucherValue;
        this.voucherStatus = voucherStatus;
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

    public int getVoucherValue() {
        return voucherValue;
    }

    public void setVoucherValue(int voucherValue) {
        this.voucherValue = voucherValue;
    }

    public String getVoucherStatus() {
        return voucherStatus;
    }

    public void setVoucherStatus(String voucherStatus) {
        this.voucherStatus = voucherStatus;
    }

    @Override
    public String toString() {
        return "Vouchers{" + "voucherID=" + voucherID + ", voucherName=" + voucherName + ", voucherValue=" + voucherValue + ", voucherStatus=" + voucherStatus + '}';
    }

}

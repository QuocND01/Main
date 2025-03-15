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
    private String voucher;
    private int value;
    private String status;

    public Vouchers() {
    }

    public Vouchers(String voucherID, String voucher, int value, String status) {
        this.voucherID = voucherID;
        this.voucher = voucher;
        this.value = value;
        this.status = status;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
    }

    public String getVoucher() {
        return voucher;
    }

    public void setVoucher(String voucher) {
        this.voucher = voucher;
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
        return "Vouchers{" + "voucherID=" + voucherID + ", voucher=" + voucher + ", value=" + value + ", status=" + status + '}';
    }
    
}

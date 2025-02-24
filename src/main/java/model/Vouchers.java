/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Vouchers {
    
    private String Voucher_ID;
    private String Voucher;
    private int Value;
    private String Status;

    public Vouchers() {
    }

    public Vouchers(String Voucher_ID, String Voucher, int Value, String Status) {
        this.Voucher_ID = Voucher_ID;
        this.Voucher = Voucher;
        this.Value = Value;
        this.Status = Status;
    }

    public String getVoucher_ID() {
        return Voucher_ID;
    }

    public void setVoucher_ID(String Voucher_ID) {
        this.Voucher_ID = Voucher_ID;
    }

    public String getVoucher() {
        return Voucher;
    }

    public void setVoucher(String Voucher) {
        this.Voucher = Voucher;
    }

    public int getValue() {
        return Value;
    }

    public void setValue(int Value) {
        this.Value = Value;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Vouchers{" + "Voucher_ID=" + Voucher_ID + ", Voucher=" + Voucher + ", Value=" + Value + ", Status=" + Status + '}';
    }
    
    
}

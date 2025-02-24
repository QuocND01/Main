/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Long Ho
 */
public class Staffs {
    private String StaffID;
    private String StaffName;
    private String StaffEmail;
    private int StaffPNB;
    private String StaffAddress;
    private String Username;
    private String Password;
    private String Role;
    private String Status;

    public Staffs() {
    }

    public Staffs(String StaffID, String StaffName, String StaffEmail, int StaffPNB, String StaffAddress, String Username, String Password, String Role, String Status) {
        this.StaffID = StaffID;
        this.StaffName = StaffName;
        this.StaffEmail = StaffEmail;
        this.StaffPNB = StaffPNB;
        this.StaffAddress = StaffAddress;
        this.Username = Username;
        this.Password = Password;
        this.Role = Role;
        this.Status = Status;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }

    public String getStaffName() {
        return StaffName;
    }

    public void setStaffName(String StaffName) {
        this.StaffName = StaffName;
    }

    public String getStaffEmail() {
        return StaffEmail;
    }

    public void setStaffEmail(String StaffEmail) {
        this.StaffEmail = StaffEmail;
    }

    public int getStaffPNB() {
        return StaffPNB;
    }

    public void setStaffPNB(int StaffPNB) {
        this.StaffPNB = StaffPNB;
    }

    public String getStaffAddress() {
        return StaffAddress;
    }

    public void setStaffAddress(String StaffAddress) {
        this.StaffAddress = StaffAddress;
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

    public String getRole() {
        return Role;
    }

    public void setRole(String Role) {
        this.Role = Role;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Staff{" + "StaffID=" + StaffID + ", StaffName=" + StaffName + ", StaffEmail=" + StaffEmail + ", StaffPNB=" + StaffPNB + ", StaffAddress=" + StaffAddress + ", Username=" + Username + ", Password=" + Password + ", Role=" + Role + ", Status=" + Status + '}';
    }
    
    
}

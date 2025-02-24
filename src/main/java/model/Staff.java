/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Staff {
    
    private String Staff_ID;
    private String Staff_name;
    private String Staff_email;
    private String Staff_PNB;
    private String Staff_address;
    private String Username;
    private String Password;
    private String Role;
    private String Status;

    public Staff() {
    }

    public Staff(String Staff_ID, String Staff_name, String Staff_email, String Staff_PNB, String Staff_address, String Username, String Password, String Role, String Status) {
        this.Staff_ID = Staff_ID;
        this.Staff_name = Staff_name;
        this.Staff_email = Staff_email;
        this.Staff_PNB = Staff_PNB;
        this.Staff_address = Staff_address;
        this.Username = Username;
        this.Password = Password;
        this.Role = Role;
        this.Status = Status;
    }

    public String getStaff_ID() {
        return Staff_ID;
    }

    public void setStaff_ID(String Staff_ID) {
        this.Staff_ID = Staff_ID;
    }

    public String getStaff_name() {
        return Staff_name;
    }

    public void setStaff_name(String Staff_name) {
        this.Staff_name = Staff_name;
    }

    public String getStaff_email() {
        return Staff_email;
    }

    public void setStaff_email(String Staff_email) {
        this.Staff_email = Staff_email;
    }

    public String getStaff_PNB() {
        return Staff_PNB;
    }

    public void setStaff_PNB(String Staff_PNB) {
        this.Staff_PNB = Staff_PNB;
    }

    public String getStaff_address() {
        return Staff_address;
    }

    public void setStaff_address(String Staff_address) {
        this.Staff_address = Staff_address;
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
        return "Staff{" + "Staff_ID=" + Staff_ID + ", Staff_name=" + Staff_name + ", Staff_email=" + Staff_email + ", Staff_PNB=" + Staff_PNB + ", Staff_address=" + Staff_address + ", Username=" + Username + ", Password=" + Password + ", Role=" + Role + ", Status=" + Status + '}';
    }
    
    
}

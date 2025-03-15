/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Long Ho
 */
public class Deliveryunits {
    private String unitID;
    private String unitName;
    private String status;

    public Deliveryunits() {
    }

    public Deliveryunits(String unitID, String unitName, String status) {
        this.unitID = unitID;
        this.unitName = unitName;
        this.status = status;
    }

    public String getUnitID() {
        return unitID;
    }

    public void setUnitID(String unitID) {
        this.unitID = unitID;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Deliveryunits{" + "unitID=" + unitID + ", unitName=" + unitName + ", status=" + status + '}';
    }

    
}

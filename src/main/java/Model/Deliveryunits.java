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
    private double unitFee;
    private String unitSpeed;
    private String unitStatus;

    public Deliveryunits() {
    }

    public Deliveryunits(String unitID, String unitName, double unitFee, String unitSpeed, String unitStatus) {
        this.unitID = unitID;
        this.unitName = unitName;
        this.unitFee = unitFee;
        this.unitSpeed = unitSpeed;
        this.unitStatus = unitStatus;
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

    public double getUnitFee() {
        return unitFee;
    }

    public void setUnitFee(double unitFee) {
        this.unitFee = unitFee;
    }

    public String getUnitSpeed() {
        return unitSpeed;
    }

    public void setUnitSpeed(String unitSpeed) {
        this.unitSpeed = unitSpeed;
    }

    public String getUnitStatus() {
        return unitStatus;
    }

    public void setUnitStatus(String unitStatus) {
        this.unitStatus = unitStatus;
    }

    @Override
    public String toString() {
        return "Deliveryunits{" + "unitID=" + unitID + ", unitName=" + unitName + ", unitFee=" + unitFee + ", unitSpeed=" + unitSpeed + ", unitStatus=" + unitStatus + '}';
    }

    
}

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

    public Deliveryunits() {
    }

    public Deliveryunits(String unitID, String unitName) {
        this.unitID = unitID;
        this.unitName = unitName;
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

    @Override
    public String toString() {
        return "Deliveryunits{" + "unitID=" + unitID + ", unitName=" + unitName + '}';
    }
    
    
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author QuocNDCE181301
 */
public class Authors {
    private String AuthorID;
    private String AuthorName;
    private String Status;

    public Authors() {
    }

    public Authors(String AuthorID, String AuthorName, String Status) {
        this.AuthorID = AuthorID;
        this.AuthorName = AuthorName;
        this.Status = Status;
    }

    public String getAuthorID() {
        return AuthorID;
    }

    public void setAuthorID(String AuthorID) {
        this.AuthorID = AuthorID;
    }

    public String getAuthorName() {
        return AuthorName;
    }

    public void setAuthorName(String AuthorName) {
        this.AuthorName = AuthorName;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Authors{" + "AuthorID=" + AuthorID + ", AuthorName=" + AuthorName + ", Status=" + Status + '}';
    }
    
}

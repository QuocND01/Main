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
    private String authorID;
    private String authorName;
    private String authorStatus;

    public Authors() {
    }

    public Authors(String authorID, String authorName, String authorStatus) {
        this.authorID = authorID;
        this.authorName = authorName;
        this.authorStatus = authorStatus;
    }

    public String getAuthorID() {
        return authorID;
    }

    public void setAuthorID(String authorID) {
        this.authorID = authorID;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorStatus() {
        return authorStatus;
    }

    public void setAuthorStatus(String authorStatus) {
        this.authorStatus = authorStatus;
    }

    @Override
    public String toString() {
        return "Authors{" + "authorID=" + authorID + ", authorName=" + authorName + ", authorStatus=" + authorStatus + '}';
    }

    
}

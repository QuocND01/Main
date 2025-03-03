/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Categorys;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author QuocNDCE181301
 */
public class CategoryDAO extends DBContext.DBContext {

    public ArrayList<Categorys> getAllCategorys() {
        ArrayList<Categorys> list = new ArrayList<>();
        String sql = "SELECT * FROM Categorys";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categorys(
                        rs.getString(1),
                        rs.getString(2)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }
        return list;
    }

    public static void main(String[] args) {
        CategoryDAO d = new CategoryDAO();
        ArrayList<Categorys> list = d.getAllCategorys();
        for (Categorys o : list) {
            System.out.println(o);
        }

    }
}

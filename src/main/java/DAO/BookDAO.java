/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Books;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author QuocNDCE181301
 */
public class BookDAO extends DBContext.DBContext {

    int bookid = 0;

    public BookDAO() {
        super();
    }

    public ArrayList<Books> getAllBook() {
        ArrayList<Books> list = new ArrayList<>();
        String sql = "SELECT * FROM Books";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return list;
    }

    public ArrayList<Books> getBookByCategory(String CategoryName) {
        ArrayList<Books> list = new ArrayList<>();
        String sql = "	SELECT * FROM Books WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, CategoryName);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return list;
    }

    public Books getBookByBookID(String BookID) {
        String sql = "	SELECT * FROM Books WHERE BookID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, BookID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return (new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return null;
    }
    
    public Books getBookByBookName(String BookName) {
        String sql = "	SELECT * FROM Books WHERE BookName = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, BookName);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return (new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return null;
    }

    public ArrayList<Books> getListOfNewBooks() {

        ArrayList<Books> list = new ArrayList<>();
        String sql = "SELECT top 10 * FROM Books ORDER BY YearOfPublication DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
        }

        return list;
    }

    public void insertBook(Books book) {
        String sql = "INSERT INTO Books VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, book.getBookID());
            st.setString(2, book.getBookName());
            st.setString(3, book.getSupplierName());
            st.setString(4, book.getAuthor());
            st.setString(5, book.getYearOfPublication());
            st.setDouble(6, Double.parseDouble(book.getWeight()));
            st.setString(7, book.getSize());
            st.setInt(8, Integer.parseInt(book.getNumberOfPages()));
            st.setString(9, book.getForm());
            st.setString(10, book.getDescribe());
            st.setString(11, book.getImage());
            st.setDouble(12, Double.parseDouble(book.getPrice()));
            st.setInt(13, Integer.parseInt(book.getStock()));
            st.setInt(14, Integer.parseInt(book.getCategoryID()));
            st.setString(15, "Active");
            st.executeUpdate();
            st.close();
        } catch (SQLException ex) {
        }
    }

    public void deleteBook(String BookID) {
        String sql = "UPDATE Books SET [Status] = ? WHERE BookID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "Unactive");
            st.setString(2, BookID);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }
    
    public int getrow() {
        String sql = "SELECT COUNT(*) FROM Books";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String a =  rs.getString(1);
                int b = Integer.parseInt(a);
                return b;
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }
        return 0;
    }

    public void updateBook(Books book) {
        String sql = "UPDATE Books SET BookName = ?,\n" +
"                 SupplierName = ?,\n" +
"                 Author = ?,\n" +
"                 YearOfPublication = ?,\n" +
"                 Weight = ?,\n" +
"                 Size  = ?,\n" +
"                 NumberOfPages = ?,\n" +
"                 Form = ?,\n" +
"                 Describe = ?,\n" +
"                 Image = ?,\n" +
"                 Price = ?,\n" +
"                 Stock = ?,\n" +
"                 CategoryID  = ?,\n" +
"                 Status  = ?\n" +
"                WHERE BookID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, book.getBookName());
            st.setString(2, book.getSupplierName());
            st.setString(3, book.getAuthor());
            st.setString(4, book.getYearOfPublication());
            st.setDouble(5, Double.parseDouble(book.getWeight()));
            st.setString(6, book.getSize());
            st.setInt(7, Integer.parseInt(book.getNumberOfPages()));
            st.setString(8, book.getForm());
            st.setString(9, book.getDescribe());
            st.setString(10, book.getImage());
            st.setDouble(11, Double.parseDouble(book.getPrice()));
            st.setInt(12, Integer.parseInt(book.getStock()));
            st.setInt(13, Integer.parseInt(book.getCategoryID()));
            st.setString(14, "Active");
            st.setString(15, book.getBookID());
            st.executeUpdate();
            st.close();

        } catch (SQLException e) {
        }
    }

    public void updateQuantity(Books book, int newquantity) {
        String sql = "UPDATE Books\n"
                + "   SET [Quantity] = ? \n"
                + " WHERE [BookID] = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, newquantity);
            st.setString(2, book.getBookID());
            st.executeUpdate();
            st.close();

        } catch (SQLException e) {
        }
    }

    public ArrayList<Books> searchBook(String search) {
        ArrayList<Books> list = new ArrayList<>();
        String sql = "	SELECT * FROM Books WHERE [BookName] like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + search.trim() + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return list;
    }

    public Books getListHotBook(String BookID) {
        String sql = "	SELECT * FROM Books WHERE BookID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, BookID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return (new Books(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14),
                        rs.getString(15)));
            }
            st.close();
            rs.close();
        } catch (SQLException e) {
        }

        return null;
    }

    public static void main(String[] args) {
        BookDAO dao = new BookDAO();
        dao.deleteBook("B21");
                ArrayList <Books> list = new ArrayList<>();
                list = dao.getAllBook();
                for (Books books : list) {
                    System.out.println(books.toString());
        }
                

    }
}

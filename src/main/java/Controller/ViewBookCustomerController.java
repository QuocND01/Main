/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CategoryDAO;
import Model.Authors;
import Model.Books;
import Model.Categorys;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author QuocNDCE181301
 */
@WebServlet(name = "ViewBookCustomerController", urlPatterns = {"/ViewBookCustomerController"})
public class ViewBookCustomerController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookDAO b = new BookDAO();
        AuthorDAO a = new AuthorDAO();
        CategoryDAO c = new CategoryDAO();
        ArrayList<Books> l = b.getAllBook();
        ArrayList<Categorys> catagory = c.getAllCategorys();
        ArrayList<Authors> author = a.getAllAuthor();
        session.setAttribute("l", l);
        session.setAttribute("category", catagory);
        session.setAttribute("author", author);
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    }

}

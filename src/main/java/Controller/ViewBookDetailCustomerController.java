/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookDAO;
import DAO.CategoryDAO;
import Model.Books;
import Model.Categorys;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author QuocNDCE181301
 */
@WebServlet(name = "ViewBookDetailCustomerController", urlPatterns = {"/viewBookDetailCustomerController"})
public class ViewBookDetailCustomerController extends HttpServlet {

    
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
        String BookID = request.getParameter("BookID");
        BookDAO b = new BookDAO();
         CategoryDAO c = new CategoryDAO();
         ArrayList<Categorys> cata = new ArrayList<Categorys>();
        Books book = b.getBookByBookID(BookID);
        cata = c.getAllCategorys();
        request.setAttribute("detailBook", book);
        request.setAttribute("cata", cata);
        request.getRequestDispatcher("ViewBookDetailCustomer.jsp").forward(request, response);
    }

    

}

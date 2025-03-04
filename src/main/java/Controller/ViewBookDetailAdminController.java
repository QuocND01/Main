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
@WebServlet(name = "ViewBookDetailAdminController", urlPatterns = {"/viewBookDetailAdminController"})
public class ViewBookDetailAdminController extends HttpServlet {

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        String BookID = request.getParameter("BookID");
        BookDAO b = new BookDAO();
        CategoryDAO c = new CategoryDAO();
        ArrayList<Categorys> cata = new ArrayList<Categorys>();
        Books book = b.getBookByBookID(BookID);
        cata = c.getAllCategorys();
        request.setAttribute("detailBook", book);
        request.setAttribute("cata", cata);
        request.getRequestDispatcher("ViewBookDetailAdmin.jsp").forward(request, response);
    }
}

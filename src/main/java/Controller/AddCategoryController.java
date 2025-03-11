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
import java.io.PrintWriter;
import java.time.LocalDate;
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
@WebServlet(name = "AddCategoryController", urlPatterns = {"/addCategory"})
public class AddCategoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   

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
        CategoryDAO cate = new CategoryDAO();
        int id = cate.getrow();
        String ID = "CT";
        ID += id+1;
        session.setAttribute("ID",ID);
        request.getRequestDispatcher("InsertCategoryView.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String error = "";
        boolean emptyError = false;
        boolean existedError = false;
        String CategoryName = request.getParameter("CategoryName");
        if (CategoryName.trim().isEmpty() || CategoryName == null) {
            error = "Category name is required";
            emptyError = true;
        }
        if (emptyError == false) {
            try {
                CategoryDAO cate = new CategoryDAO();
                ArrayList<Categorys> list = new ArrayList<>();
                list = cate.getAllCategorys();
                for (Categorys c : list) {
                    if (c.getCategoryName().equalsIgnoreCase(CategoryName)) {
                        existedError = true;
                        break;
                    }
                }
                if (existedError == false) {
                    int categoryID = cate.getrow() + 1;
                    Categorys c = new Categorys("CT" + categoryID, CategoryName, "Active");
                    cate.insertCategory(c);
                    request.getRequestDispatcher("viewCategory").forward(request, response);
                } else {
                    session.setAttribute("error", CategoryName + " has existed!");
                    request.getRequestDispatcher("InsertCategoryView.jsp").forward(request, response);
                }

            } catch (ClassCastException e) {
            }
        } else {
            session.setAttribute("error", error);
            request.getRequestDispatcher("InsertCategoryView.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

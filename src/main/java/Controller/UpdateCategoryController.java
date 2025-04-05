/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CategoryDAO;
import Model.Categories;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author QuocNDCE181301
 */
@WebServlet(name = "UpdateCategoryController", urlPatterns = {"/updateCategory"})
public class UpdateCategoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateCategoryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCategoryController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        String CateID = request.getParameter("categoryID");
        CategoryDAO cateDAO = new CategoryDAO();
        Categories category = new Categories();
        category = cateDAO.getCategoryByID(CateID);
        if (category != null) {
            session.setAttribute("category", category);
            request.getRequestDispatcher("UpdateCategoryView.jsp").forward(request, response);
        }
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
         session.setAttribute("errorCategoryName", null);
        session.setAttribute("errorCategoryDescription", null);
        session.setAttribute("errorExist", null);
        CategoryDAO catedao = new CategoryDAO();
        boolean emptyError = false;
        String CategoryID = request.getParameter("CategoryID");
        String CategoryName = request.getParameter("CategoryName");
        String CategoryDescription = request.getParameter("CategoryDescription");

        if (CategoryName == null || CategoryName.trim().isEmpty()|| CategoryName.length()>50 || !CategoryName.matches("^[a-zA-Z ]+$")) {
            session.setAttribute("errorCategoryName", "Category name is required only letters and cannot more than 50 chacracters");
            emptyError = true;
        }
        
        if (CategoryDescription == null || CategoryDescription.trim().isEmpty()|| CategoryDescription.length() > 255|| !CategoryDescription.matches("^[a-zA-Z0-9 ]+$")){
            session.setAttribute("errorCategoryDescription", "Category description is required, only letters and number and cannot more than 255 characters");
            emptyError = true;
        }

        if (emptyError == false) {

            try {
                Categories c = new Categories(CategoryID, CategoryName,CategoryDescription, "Active");
                catedao.updateCategory(c);
                response.sendRedirect("viewCategory");
            } catch (IOException e) {
            }
        } else {
            request.getRequestDispatcher("UpdateCategoryView.jsp").forward(request, response);
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

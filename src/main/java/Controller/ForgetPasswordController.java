/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Long Ho
 */
@WebServlet(name="ForgetPasswordController", urlPatterns={"/forgetpassword"})
public class ForgetPasswordController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgetPasswordController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgetPasswordController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email").trim();
    String phone = request.getParameter("phone").trim();
    String newPassword = request.getParameter("newPassword").trim();
    String confirmPassword = request.getParameter("confirmPassword").trim();

    if (!newPassword.equals(confirmPassword)) {
        request.setAttribute("errorMessage", "Confirmation password does not match!");
        request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
        return;
    }

    StaffDAO dao = new StaffDAO();
    boolean userExists = dao.checkEmailAndPhone(email, phone);

    if (userExists) {
        boolean success = dao.updatePassword(email, phone, newPassword);
        if (success) {
            request.setAttribute("successMessage", "Password updated successfully!");
            request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "An error occurred, please try again!");
            request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
        }
    } else {
        request.setAttribute("errorMessage", "Invalid email or phone number!");
        request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
    }
    }
    
        

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

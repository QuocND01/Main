/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.FeedbackDAO;
import Model.Feedbacks;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Long Ho
 */
@WebServlet(name="WriteFeedbackController", urlPatterns={"/write-feedback"})
public class WriteFeedbackController extends HttpServlet {
   
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
            out.println("<title>Servlet WriteFeedbackController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WriteFeedbackController at " + request.getContextPath () + "</h1>");
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
        String bookID = request.getParameter("bookID");
        String orderID = request.getParameter("orderID");

        if (bookID == null || orderID == null) {
            response.sendRedirect("feedback-page?orderID=" + orderID);
            return;
        }

        request.setAttribute("bookID", bookID);
        request.setAttribute("orderID", orderID);
        request.getRequestDispatcher("WriteFeedback.jsp").forward(request, response);
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
        try {
    HttpSession session = request.getSession();
    String customerID = (String) session.getAttribute("customerID");  // Lấy từ session, không lấy từ request
    
    if (customerID == null) {
        response.sendRedirect("LoginForm.jsp");
        return;
    }

    String bookID = request.getParameter("bookID");
    String orderID = request.getParameter("orderID");
    String starStr = request.getParameter("star");
    String detail = request.getParameter("detail");

    if (bookID == null || orderID == null || detail == null || 
        detail.trim().isEmpty() || starStr == null || starStr.trim().isEmpty()) {
        
        response.sendRedirect("write-feedback?bookID=" + bookID + "&orderID=" + orderID + "&error=missing_data");
        return;
    }

    int star = Integer.parseInt(starStr);
    if (star <= 0 || star > 5) {
        response.sendRedirect("write-feedback?bookID=" + bookID + "&orderID=" + orderID + "&error=invalid_star");
        return;
    }

    FeedbackDAO feedbackDAO = new FeedbackDAO();
    boolean success = feedbackDAO.insertFeedback(customerID, bookID, star, detail);

    if (success) {
        response.sendRedirect("feedback-page?orderID=" + orderID + "&success=feedback_added");
    } else {
        request.setAttribute("errorMessage", "Failed to submit feedback.");
        request.getRequestDispatcher("WriteFeedback.jsp").forward(request, response);
    }
} catch (NumberFormatException e) {
    response.sendRedirect("write-feedback?bookID=" + request.getParameter("bookID") + 
                          "&orderID=" + request.getParameter("orderID") + "&error=invalid_star_format");
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

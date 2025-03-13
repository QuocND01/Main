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

/**
 *
 * @author Long Ho
 */
@WebServlet(name="UpdateFeedbackController", urlPatterns={"/update-feedback"})
public class UpdateFeedbackController extends HttpServlet {
   private FeedbackDAO feedbackDAO;

    @Override
    public void init() throws ServletException {
        feedbackDAO = new FeedbackDAO();
    }
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
            out.println("<title>Servlet UpdateFeedbackController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateFeedbackController at " + request.getContextPath () + "</h1>");
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
        String customerID = (String) request.getSession().getAttribute("customerID");
        String bookID = request.getParameter("bookID");

        if (customerID == null || bookID == null) {
            response.sendRedirect("feedback-page?error=invalid_request");
            return;
        }

        Feedbacks feedback = feedbackDAO.getFeedback(customerID, bookID);
        if (feedback == null) {
            response.sendRedirect("feedback-page?error=feedback_not_found");
            return;
        }

        request.setAttribute("feedback", feedback);
        request.getRequestDispatcher("UpdateFeedback.jsp").forward(request, response);
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
        String feedbackIDStr = request.getParameter("feedbackID");
        String starStr = request.getParameter("star");
        String detail = request.getParameter("detail");
        String orderID = request.getParameter("orderID"); 

        // Kiểm tra dữ liệu đầu vào
        if (feedbackIDStr == null || feedbackIDStr.trim().isEmpty() || 
            starStr == null || starStr.trim().isEmpty() || 
            detail == null || detail.trim().isEmpty() ||
            orderID == null || orderID.trim().isEmpty()) { 
            response.sendRedirect("update-feedback?error=missing_data");
            return;
        }

        int feedbackID = Integer.parseInt(feedbackIDStr);
        int star = Integer.parseInt(starStr);

        if (star < 1 || star > 5) {
            response.sendRedirect("update-feedback?error=invalid_star");
            return;
        }

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        boolean success = feedbackDAO.updateFeedback(feedbackID, star, detail);

        if (success) {
            response.sendRedirect("feedback-page?orderID=" + orderID + "&success=feedback_updated"); // ✅ Điều hướng đúng
        } else {
            request.setAttribute("errorMessage", "Failed to update feedback.");
            request.getRequestDispatcher("UpdateFeedback.jsp").forward(request, response);
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("update-feedback?error=invalid_input");
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

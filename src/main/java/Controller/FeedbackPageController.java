/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FeedbackDAO;
import DAO.OrderDAO;
import Model.OrderDetails;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Long Ho
 */
@WebServlet(name = "FeedbackPageController", urlPatterns = {"/feedback-page"})
public class FeedbackPageController extends HttpServlet {

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
            out.println("<title>Servlet FeedbackPageController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackPageController at " + request.getContextPath() + "</h1>");
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
        String customerID = (String) session.getAttribute("customerID");

        if (customerID == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        // ✅ Nếu orderID bị null hoặc rỗng, lấy từ session (nếu có)
        String orderID = request.getParameter("orderID");
        if (orderID == null || orderID.isEmpty()) {
            orderID = (String) session.getAttribute("lastOrderID");
        }

        // ✅ Nếu vẫn null, quay về ViewOrders.jsp
        if (orderID == null || orderID.isEmpty()) {
            response.sendRedirect("ViewOrders.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Map<String, Object>> books = orderDAO.getBooksByOrderID(orderID);

        if (books == null || books.isEmpty()) {
            response.sendRedirect("ViewOrders.jsp");
            return;
        }

        // ✅ Lưu orderID vào session để sử dụng lại khi cần
        session.setAttribute("lastOrderID", orderID);

        // Tạo một Map để lưu trạng thái feedback của từng sách
        Map<String, Boolean> feedbackStatusMap = new HashMap<>();
        for (Map<String, Object> book : books) {
            String bookID = (String) book.get("BookID");
            boolean hasFeedback = feedbackDAO.isFeedbackExist(customerID, bookID);
            feedbackStatusMap.put(bookID, hasFeedback);
        }

        // Đặt dữ liệu vào request để sử dụng trong JSP
        request.setAttribute("orderID", orderID);
        request.setAttribute("books", books);
        request.setAttribute("feedbackStatusMap", feedbackStatusMap);
        request.getRequestDispatcher("FeedbackPage.jsp").forward(request, response);
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
        doGet(request, response);
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

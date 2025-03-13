/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 *
 * @author Long Ho
 */
@WebServlet(name="ChangeStatusOrderByAdminOrStaffController", urlPatterns={"/change-status-order"})
public class ChangeStatusOrderByAdminOrStaffController extends HttpServlet {
   private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
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
            out.println("<title>Servlet ChangeStatusOrderByAdminOrStaffController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeStatusOrderByAdminOrStaffController at " + request.getContextPath () + "</h1>");
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
        String orderID = request.getParameter("orderID");
        if (orderID == null || orderID.isEmpty()) {
            response.sendRedirect("ViewNewOrder.jsp");
            return;
        }

        Map<String, Object> orderDetail = orderDAO.getOrderDetail(orderID);
        if (orderDetail == null) {
            response.sendRedirect("ViewNewOrder.jsp");
            return;
        }

        request.setAttribute("orderDetail", orderDetail);
        request.getRequestDispatcher("ChangeStatusOrder.jsp").forward(request, response);
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
        String orderID = request.getParameter("orderID");
        String newStatus = request.getParameter("orderStatus");

        if (orderID == null || newStatus == null || orderID.isEmpty() || newStatus.isEmpty()) {
            request.setAttribute("error", "Thông tin không hợp lệ!");
            request.getRequestDispatcher("ChangeStatusOrder.jsp").forward(request, response);
            return;
        }

        boolean success = orderDAO.updateOrderStatus(orderID, newStatus);
        if (success) {
            response.sendRedirect("view-new-order");
        } else {
            request.setAttribute("error", "Cập nhật trạng thái thất bại!");
            request.getRequestDispatcher("ChangeStatusOrder.jsp").forward(request, response);
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

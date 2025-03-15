/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookDAO;
import DAO.OrderDAO;
import Model.OrderDetails;
import Model.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Long Ho
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class ViewOrderController extends HttpServlet {

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
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
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

    OrderDAO orderDAO = new OrderDAO();
    ArrayList<Orders> orders = orderDAO.getOrdersByCustomer(customerID);
    HashMap<String, ArrayList<OrderDetails>> orderDetailsMap = new HashMap<>();
    HashMap<String, String> bookNamesMap = new HashMap<>();

    for (Orders order : orders) {
        ArrayList<OrderDetails> orderDetails = orderDAO.getOrderDetailsByOrderID(order.getOrderID());
        orderDetailsMap.put(order.getOrderID(), orderDetails);
        
        for (OrderDetails detail : orderDetails) {
            bookNamesMap.put(detail.getBookID(), orderDAO.getBookNameByID(detail.getBookID()));
        }
    }

    request.setAttribute("orders", orders);
    request.setAttribute("orderDetailsMap", orderDetailsMap);
    request.setAttribute("bookNamesMap", bookNamesMap);

    String message = (String) session.getAttribute("message");
    if (message != null) {
        request.setAttribute("message", message);
        session.removeAttribute("message");
    }

    request.getRequestDispatcher("ViewOrders.jsp").forward(request, response);

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
        processRequest(request, response);
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

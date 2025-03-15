/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.Customers;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
@WebServlet(name="UpdateCusProfile", urlPatterns={"/UpdateCusProfile"})
public class UpdateCusProfile extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateCusProfile</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCusProfile at " + request.getContextPath () + "</h1>");
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
        // processRequest(request, response);
        CustomerDAO customerDAO = new CustomerDAO();
        // Lấy thông tin từ request
        String customerID = request.getParameter("CustomerID"); // ID không thay đổi
        String customerName = request.getParameter("CustomerName");
        String customerEmail = request.getParameter("CustomerEmail");
        String customerPNB = request.getParameter("CustomerPNB");
        String customerAddress = request.getParameter("CustomerAddress");

        // Tạo đối tượng Customer với thông tin mới
        Customers customer = new Customers();
        customer.setCustomerID(customerID);
        customer.setCustomerName(customerName);
        customer.setCustomerEmail(customerEmail);
        customer.setCustomerPNB(customerPNB);
        customer.setCustomerAddress(customerAddress);

        // Gọi DAO để cập nhật thông tin
        boolean success = customerDAO.updateCustomer(customer);

        if (success) {
            request.setAttribute("message", "Customer updated successfully!");
        } else {
            request.setAttribute("message", "Error updating customer.");
        }

        // Lấy lại thông tin mới từ database và hiển thị
        request.setAttribute("customer", customerDAO.getCustomerByID(customerID));
        request.getRequestDispatcher("CustomerProfile.jsp").forward(request, response);
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

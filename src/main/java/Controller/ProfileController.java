/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CustomerDAO;
import DBContext.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
@WebServlet(name="ProfileController", urlPatterns={"/ProfileController"})
public class ProfileController extends HttpServlet {
   
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
            out.println("<title>Servlet ProfileController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath () + "</h1>");
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
        // Lấy CustomerID từ session, nếu không có thì sử dụng ID mẫu "C002"
        HttpSession session = request.getSession();
        String customerID = (String) session.getAttribute("customerID");

        // Nếu không có customerID trong session, sử dụng ID mẫu "C002"
        if (customerID == null || customerID.isEmpty()) {
            customerID = "C2";  // ID mẫu
        }

        // Tạo đối tượng CustomerDAO để lấy dữ liệu từ cơ sở dữ liệu
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByID(customerID);

        // Đưa đối tượng customer vào request để chuyển tới JSP
        if (customer != null) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("CustomerProfile.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy khách hàng, chuyển hướng tới thông báo không tìm thấy
            request.setAttribute("message", "Customer not found!");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
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
        //processRequest(request, response);
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

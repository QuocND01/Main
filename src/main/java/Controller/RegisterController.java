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
import jakarta.servlet.http.HttpSession;
import static jdk.internal.agent.Agent.error;
import Model.Customers;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
@WebServlet(name="RegisterController", urlPatterns={"/RegisterController"})
public class RegisterController extends HttpServlet {
   
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
            out.println("<title>Servlet RegisterController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession();
        
        // Xóa thông báo lỗi cũ
        session.removeAttribute("errorName");
        session.removeAttribute("errorPassword");
        session.removeAttribute("errorConfirm");
        session.removeAttribute("errorCusName");
        session.removeAttribute("errorAddress");
        session.removeAttribute("errorPNB");
        session.removeAttribute("successMessage");
        // Điều hướng về trang đăng ký
        response.sendRedirect("RegisterPage.jsp");
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
        
        HttpSession session = request.getSession();
        boolean error = false;
        // Xóa thông báo lỗi cũ
        session.removeAttribute("errorName");
        session.removeAttribute("errorPassword");
        session.removeAttribute("errorConfirm");
        session.removeAttribute("errorCusName");
        session.removeAttribute("errorAddress");
        session.removeAttribute("errorPNB");
        session.removeAttribute("successMessage");

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm");
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPNB = request.getParameter("customerPNB");
        String customerAddress = request.getParameter("customerAddress");

        try {
            int n = Integer.parseInt(customerPNB);
        } catch (NumberFormatException e) {
            error = true;
        }

        // Xác thực dữ liệu
        boolean hasError = false;

        if (username == null || username.trim().isEmpty() || username.length() < 5 || username.length() > 10) {
            session.setAttribute("errorName", "Username is required and must have more than 4 character");
            hasError = true;
        }

        if (password == null || password.length() < 8) {
            session.setAttribute("errorPassword", "Password must be at least 8 characters long.");
            hasError = true;
        }

        if (!password.equals(confirmPassword)) {
            session.setAttribute("errorConfirm", "Passwords do not match.");
            hasError = true;
        }

        if (customerName == null || customerName.trim().isEmpty()) {
            session.setAttribute("errorCusName", "Your name is required.");
            hasError = true;
        }

        if (customerAddress == null || customerAddress.trim().isEmpty()) {
            session.setAttribute("errorAddress", "Address is required.");
            hasError = true;
        }

        if (customerPNB == null || customerPNB.trim().isEmpty() || customerPNB.length() != 10 || error) {
            session.setAttribute("errorPNB", "PNB is required, must be number and must have 10 digit");
            hasError = true;
        }
        
        if (hasError) {
            request.getRequestDispatcher("RegisterPage.jsp").forward(request, response);
        } else {
        // Kiểm tra nếu tài khoản đã tồn tại
        CustomerDAO customerDAO = new CustomerDAO();
        if (customerDAO.checkCustomerExist(username) != null) {
            session.setAttribute("errorName", "Username already exists.");
            response.sendRedirect("RegisterPage.jsp");
            return;
        }
        
        String newCustomerID = customerDAO.getNextCustomerID();

        // Tạo tài khoản mới
        // Tạo đối tượng Customer mới với ID vừa tạo
        Customers newCustomer = new Customers(newCustomerID, customerName, customerEmail, customerPNB, 
                                            customerAddress, username, password, "Active");
        customerDAO.createCustomer(newCustomer);
        session.setAttribute("successMessage", "Customer created successfully! You can now log in.");
        response.sendRedirect("ok.jsp");
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

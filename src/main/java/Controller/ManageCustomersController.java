/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import Model.Customers;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 *
 * @author QuocNHMCE182015
 */
@WebServlet(name = "ManageCustomersController", urlPatterns = {"/ManageCustomersController"})
public class ManageCustomersController extends HttpServlet {

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
            out.println("<title>Servlet ManageCustomersController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageCustomersController at " + request.getContextPath() + "</h1>");
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
        CustomerDAO dao = new CustomerDAO();
        String action = request.getParameter("action");

        // Default action is to view customer list
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                // Get all customers and display the list
                ArrayList<Customers> customersList = dao.getAllCustomers();
                request.setAttribute("customersList", customersList);
                request.getRequestDispatcher("ManageCustomers.jsp").forward(request, response);
                break;

            case "details":
                // Get customer details by ID
                String customerId = request.getParameter("id");
                Customers customer = dao.getCustomerById(customerId);

                if (customer != null) {
                    // Return customer data as JSON for the popup
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.println("{");
                    out.println("\"customerID\": \"" + customer.getCustomerID() + "\",");
                    out.println("\"customerName\": \"" + customer.getCustomerName() + "\",");
                    out.println("\"customerEmail\": \"" + customer.getCustomerEmail() + "\",");
                    out.println("\"customerPNB\": \"" + customer.getCustomerPNB() + "\",");
                    out.println("\"customerAddress\": \"" + customer.getCustomerAddress() + "\",");
                    out.println("\"username\": \"" + customer.getUsername() + "\",");
                    out.println("\"status\": \"" + customer.getStatus() + "\"");
                    out.println("}");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                break;

            default:
                response.sendRedirect("ManageCustomersController");
                break;
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
        String action = request.getParameter("action");

        if (action != null && action.equals("delete")) {
            // Delete customer (set status to Unactive)
            String customerId = request.getParameter("id");
            CustomerDAO dao = new CustomerDAO();
            dao.deleteCustomer(customerId);

            // Set success message and redirect back to customer list
            request.getSession().setAttribute("successMessage", "Customer has been successfully deleted.");
            response.sendRedirect("ManageCustomersController");
        } else {
            processRequest(request, response);
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

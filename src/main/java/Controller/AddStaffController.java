/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.StaffDAO;
import Model.Staffs;
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
@WebServlet(name="AddStaffController", urlPatterns={"/addstaff"})
public class AddStaffController extends HttpServlet {
   
    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
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
            out.println("<title>Servlet AddStaffController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddStaffController at " + request.getContextPath () + "</h1>");
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
        String staffID = request.getParameter("staffID");
        String staffName = request.getParameter("staffName");
        String staffEmail = request.getParameter("staffEmail");
        String staffPNBStr = request.getParameter("staffPNB");
        String staffAddress = request.getParameter("staffAddress");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        // Parse phone number
        int staffPNB = 0;
        try {
            staffPNB = Integer.parseInt(staffPNBStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        
        Staffs staff = new Staffs();
        staff.setStaffID(staffID);
        staff.setUsername(username);
        staff.setPassword(password);
        staff.setRole(role);
        staff.setStaffName(staffName);
        staff.setStaffEmail(staffEmail);
        staff.setStaffAddress(staffAddress);
        staff.setStaffPNB(staffPNBStr);
        staff.setStatus(status);

        boolean added = staffDAO.addStaff(staff);

        if(added){

            response.sendRedirect(request.getContextPath() + "/viewstaff");
        } else {
            request.setAttribute("errorMessage", "Failed to add staff. The Staff ID, Username, or Email might already exist. Please try again.");
            request.getRequestDispatcher("AddStaff.jsp").forward(request, response);
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.WarehouseDAO;
import Model.Warehouse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
@WebServlet(name = "ViewWarehouseController", urlPatterns = {"/ViewWarehouseController"})
public class ViewWarehouseController extends HttpServlet {

    private WarehouseDAO warehouseDAO;

    @Override
    public void init() throws ServletException {
        warehouseDAO = new WarehouseDAO(); // Khởi tạo DAO khi servlet chạy
    }

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
            out.println("<title>Servlet ViewWarehouseController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewWarehouseController at " + request.getContextPath() + "</h1>");
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
        try {
            List<Warehouse> warehouseList = warehouseDAO.getAllWarehouseItems();
            request.setAttribute("warehouseList", warehouseList);
            request.getRequestDispatcher("Warehouse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Can't not get warehouse information!");
            request.getRequestDispatcher("Warehouse.jsp").forward(request, response);
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
        
        String bookID = request.getParameter("bookID");
        int stock = Integer.parseInt(request.getParameter("stock"));  // Số lượng sách trong kho
        String staffID = request.getParameter("staffID");  // Lấy staffID từ session
        // Test input data
            System.out.println("BookID: " + bookID);
            System.out.println("StaffID: " + staffID);
            System.out.println("Import Quantity: " + stock);
            
        // Kiểm tra thông tin hợp lệ (có thể tùy chỉnh thêm)
        if (bookID != null && stock != 0) {
            // Gọi phương thức importBook để nhập sách vào Warehouse và cập nhật số lượng sách
            warehouseDAO.importBook( bookID, stock, staffID);
            
            
            
            // Reload and move to Warehouse.jsp
            List<Warehouse> warehouseList = warehouseDAO.getAllWarehouseItems();
            request.setAttribute("warehouseList", warehouseList);
            request.getRequestDispatcher("Warehouse.jsp").forward(request, response);
            
        } else {
            // Nếu có lỗi (ví dụ: thiếu tham số), gửi thông báo lỗi
            request.setAttribute("error", "Thông tin không hợp lệ.");
            request.getRequestDispatcher("Warehouse.jsp").forward(request, response);
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

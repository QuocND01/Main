/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.WarehouseDAO;
import DAO.WarehouseDetailsDAO;
import Model.Warehouse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
@WebServlet(name = "ImportWarehouse", urlPatterns = {"/ImportWarehouseController"})
public class ImportWarehouseController extends HttpServlet {

    private WarehouseDetailsDAO warehouseDetailDAO = new WarehouseDetailsDAO();
    private WarehouseDAO warehouseDAO = new WarehouseDAO();

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
            out.println("<title>Servlet ImportWarehouse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportWarehouse at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String supplierName = request.getParameter("supplierName");
        String stockID = warehouseDAO.getNextWarehouseID();
        HttpSession session = request.getSession();
        long currentTimeMillis = System.currentTimeMillis();

        // Chuyển mili giây thành java.sql.Date
        Date importDate = new Date(currentTimeMillis);
        String staffID = "S1";

        // Lấy các mảng dữ liệu từ form
        String[] bookIDs = request.getParameterValues("bookID[]");
        String[] importQuantities = request.getParameterValues("importQuantity[]");
        String[] importBookValues = request.getParameterValues("importBookValue[]");

        // Kiểm tra nếu có dữ liệu hợp lệ
        if (supplierName != null && bookIDs != null && importQuantities != null && importBookValues != null) {
            double totalCost = 0; // Khởi tạo biến để tính tổng giá trị
            
            for (int i = 0; i < bookIDs.length; i++) {
                
                int importQuantity = Integer.parseInt(importQuantities[i]);
                double importBookValue = Double.parseDouble(importBookValues[i]);

                // Tính tổng giá trị cho từng sách
                double totalBookValue = importQuantity * importBookValue;
                totalCost += totalBookValue; // Cộng dồn vào tổng giá trị
            }
            warehouseDAO.addNewRestock(stockID, staffID, supplierName, importDate, totalCost);
            // Duyệt qua từng dòng dữ liệu và tính tổng giá trị
            
            for (int i = 0; i < bookIDs.length; i++) {
                String bookID = bookIDs[i];
                int importQuantity = Integer.parseInt(importQuantities[i]);
                double importBookValue = Double.parseDouble(importBookValues[i]);

                // Tính tổng giá trị cho từng sách
//                double totalBookValue = importQuantity * importBookValue;
//                totalCost += totalBookValue; // Cộng dồn vào tổng giá trị

                String warehouseDetailID = warehouseDetailDAO.getNextWarehouseDetailID();

                System.out.println("========");
                System.out.println("WarehouseDetailID: " + warehouseDetailID);
                System.out.println("BookID: " + bookID);
                System.out.println("ImportQuantity: " + importQuantity);
                System.out.println("ImportBookValue: " + importBookValue);
                System.out.println("StockID: " + stockID);
                
                warehouseDetailDAO.addNewWarehouseDetails(warehouseDetailID, bookID, importQuantity, importBookValue, stockID);
                
            }

            

            // Chuyển hướng đến trang WarehouseList.jsp
            WarehouseDAO dao = new WarehouseDAO();

            List<Warehouse> warehouseList = dao.getAllWarehouses();

            request.setAttribute("warehouseList", warehouseList);
            request.getRequestDispatcher("ViewWarehouse.jsp").forward(request, response);
        } else {
            // Nếu không có dữ liệu hợp lệ, chuyển hướng về trang nhập liệu
            response.sendRedirect("importWarehouse.jsp");
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

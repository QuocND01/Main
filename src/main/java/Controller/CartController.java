/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BookDAO;
import DAO.CartDAO;
import Model.Books;
import Model.Cart;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author QuocNHMCE182015
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
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
    private CartDAO cartDAO = new CartDAO();
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customerID = (String) session.getAttribute("customerID");

        if (customerID == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Bạn cần đăng nhập trước!\"}");
            return;
        }

        String action = request.getParameter("action");
        String bookID = request.getParameter("bookId");

        if ("add".equals(action)) {
            cartDAO.addToCart(customerID, bookID);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
        } else if ("remove".equals(action)) {
            cartDAO.removeFromCart(customerID, bookID);
            response.sendRedirect("Cart.jsp");
        } else if ("update".equals(action)) {
            String bookId = request.getParameter("bookId");
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));

            // Cập nhật số lượng sách trong giỏ hàng
            cartDAO.updateQuantity(customerID, bookId, newQuantity);

            // Lấy thông tin sách để tính lại tổng giá từng sản phẩm
            Books book = bookDAO.getBookByBookID(bookId);
            double newTotal = newQuantity * Double.parseDouble(book.getPrice());

            // Tính tổng giá trị giỏ hàng
            ArrayList<Cart> updatedCartList = cartDAO.getCartByCustomer(customerID);
            double totalPrice = 0;
            for (Cart cart : updatedCartList) {
                Books cartBook = bookDAO.getBookByBookID(cart.getBookID());
                totalPrice += cart.getQuantity() * Double.parseDouble(cartBook.getPrice());
            }
            
            session.setAttribute("totalPrice", totalPrice);
            
            // Trả về JSON chứa tổng giá mới
            response.setContentType("application/json");
            response.getWriter().write("{\"newTotal\": " + newTotal + ", \"totalPrice\": " + totalPrice + "}");
            return;
        } else if ("clear".equals(action)) {
            cartDAO.clearCart(customerID);
            response.sendRedirect("Cart.jsp");
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

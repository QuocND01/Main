/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AuthorDAO;
import Model.Authors;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Tran Phuc Vinh - CE182381
 */
@WebServlet(name = "AuthorController", urlPatterns = {"/AuthorController"})
public class AuthorController extends HttpServlet {

    private AuthorDAO authorDAO;

    @Override
    public void init() throws ServletException {
        authorDAO = new AuthorDAO(); // Khởi tạo DAO khi servlet chạy
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
            out.println("<title>Servlet ViewAuthorController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewAuthorController at " + request.getContextPath() + "</h1>");
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
            List<Authors> authorsList = authorDAO.getAllAuthor();
            request.setAttribute("authorsList", authorsList);
            request.getRequestDispatcher("ViewAuthors.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Can't not get authors information!");
            request.getRequestDispatcher("ViewAuthors.jsp").forward(request, response);
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

        try {
            if ("add".equals(action)) {
                String authorID = authorDAO.getNextAuthorID();
                String authorName = request.getParameter("authorName");
                System.out.println(authorID + authorName);
                System.out.println("=================");

                // Thêm tác giả
                authorDAO.addAuthor(new Authors(authorID, authorName,"Active"));

                // Thiết lập thông báo thành công
                request.setAttribute("message", "Author added successfully.");
            } else if ("update".equals(action)) {
                String authorID = request.getParameter("authorID");
                String authorName = request.getParameter("authorName");
                String status = request.getParameter("status");

                // Cập nhật tác giả
                authorDAO.updateAuthor(new Authors(authorID, authorName, status));

                // Thiết lập thông báo thành công
                request.setAttribute("message", "Author updated successfully.");
            } else if ("delete".equals(action)) {
                String authorID = request.getParameter("authorID");

                // Xóa tác giả
                authorDAO.deleteAuthor(authorID);

                // Thiết lập thông báo thành công
                request.setAttribute("message", "Author deleted successfully.");
            }

            // Reload authors list
            List<Authors> authorsList = authorDAO.getAllAuthor();
            request.setAttribute("authorsList", authorsList);

            // Forward to the view page (ensure it is only done once)
            request.getRequestDispatcher("ViewAuthors.jsp").forward(request, response);

        } catch (Exception e) {
            // Xử lý lỗi và thiết lập thông báo lỗi
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("ViewAuthors.jsp").forward(request, response); // Ensure forward here in case of error
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

package Controller;

import DAO.VoucherDAO;
import Model.Vouchers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 *
 * @author QuocNHMCE182015
 */
@WebServlet(name = "VoucherController", urlPatterns = {"/VoucherController"})
public class VoucherController extends HttpServlet {

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
            out.println("<title>Servlet VoucherController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VoucherController at " + request.getContextPath() + "</h1>");
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
    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        voucherDAO = new VoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String message = null;
        String messageType = null;

        if ("deactivate".equals(action)) {
            String voucherID = request.getParameter("voucherID");
            boolean updated = voucherDAO.updateVoucherStatus(voucherID, "Inactive");

            if (updated) {
                message = "Voucher deactivated successfully!";
                messageType = "success";
            } else {
                message = "Cannot deactivate voucher! An error occurred.";
                messageType = "danger";
            }
        }

        ArrayList<Vouchers> list = voucherDAO.getAllVouchers();
        request.setAttribute("voucherList", list);

        if (message != null) {
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
        }

        request.getRequestDispatcher("Voucher.jsp").forward(request, response);
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
        String voucherName = request.getParameter("voucherName");
        int value = Integer.parseInt(request.getParameter("value"));
        String status = request.getParameter("status");

        VoucherDAO voucherDAO = new VoucherDAO();

        // Check for AJAX or regular form submission
        String requestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(requestedWith);

        // Kiểm tra giá trị value trong khoảng 0 - 100
        if (value < 0 || value > 100) {
            if (isAjax) {
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("invalid_value");
            } else {
                request.setAttribute("errorMessage", "Value must be between 0 and 100!");
                request.getRequestDispatcher("Voucher.jsp").forward(request, response);
            }
            return;
        }

        // Kiểm tra trùng tên voucher
        if (voucherDAO.isVoucherExists(voucherName)) {
            if (isAjax) {
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("error");
            } else {
                request.setAttribute("errorMessage", "Voucher bị trùng!");
                request.getRequestDispatcher("Voucher.jsp").forward(request, response);
            }
            return;
        }

        // Nếu hợp lệ, thêm voucher mới
        Vouchers newVoucher = new Vouchers(null, voucherName, value, status);
        voucherDAO.addVoucher(newVoucher);

        if (isAjax) {
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("success");
        } else {
            request.setAttribute("message", "Voucher added successfully!");
            request.setAttribute("messageType", "success");
            request.getRequestDispatcher("Voucher.jsp").forward(request, response);
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

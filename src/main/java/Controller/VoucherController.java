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

        // Check for post redirect first - this takes priority
        boolean isPostRedirect = "true".equals(request.getParameter("postRedirect"));
        if (isPostRedirect) {
            message = "Voucher added successfully!";
            messageType = "success";
        } // Only process deactivation if not a post-redirect AND action is deactivate
        else if ("deactivate".equals(action)) {
            String voucherID = request.getParameter("voucherID");
            boolean updated = voucherDAO.updateVoucherStatus(voucherID, "Inactive");

            if (updated) {
                message = "Voucher deleted successfully!";
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String voucherName = request.getParameter("voucherName");
        int voucherValue = Integer.parseInt(request.getParameter("value"));
        String voucherStatus = "Active";

        VoucherDAO voucherDAO = new VoucherDAO();

        // Check for AJAX or regular form submission
        String requestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(requestedWith);

        // Kiểm tra giá trị value trong khoảng 1 - 100
        if (voucherValue < 1 || voucherValue > 100) {
            if (isAjax) {
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("invalid_value");
            } else {
                request.setAttribute("errorMessage", "Value must be between 1 and 100!");
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
        Vouchers newVoucher = new Vouchers(null, voucherName, voucherValue, voucherStatus);
        voucherDAO.addVoucher(newVoucher);

        if (isAjax) {
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("success");
        } else {
            // For non-AJAX submissions, redirect to GET with a success flag
            response.sendRedirect("VoucherController?postRedirect=true");
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

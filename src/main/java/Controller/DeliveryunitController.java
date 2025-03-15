package Controller;

import DAO.DeliveryunitDAO;
import Model.Deliveryunits;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 *
 * @author QuocNHMCE182015
 */
@WebServlet(name = "DeliveryunitController", urlPatterns = {"/DeliveryunitController"})
public class DeliveryunitController extends HttpServlet {

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
            out.println("<title>Servlet DeliveryunitController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeliveryunitController at " + request.getContextPath() + "</h1>");
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
        DeliveryunitDAO dao = new DeliveryunitDAO();
        ArrayList<Deliveryunits> unitList = dao.getAllDeliveryUnits();
        request.setAttribute("unitList", unitList);
        request.getRequestDispatcher("Deliveryunit.jsp").forward(request, response);
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
        DeliveryunitDAO dao = new DeliveryunitDAO();

        if ("add".equals(action)) {
            String unitName = request.getParameter("unitName");
            dao.addDeliveryUnit(unitName);
            request.setAttribute("message", "Added delivery unit successfully!");
        } else if ("update".equals(action)) {
            String unitID = request.getParameter("unitID");
            String unitName = request.getParameter("unitName");
            dao.updateDeliveryUnit(unitID, unitName);
            request.setAttribute("message", "Updated delivery unit successfully!");
        } else if ("delete".equals(action)) {
            String unitID = request.getParameter("unitID");
            boolean success = dao.deactivateDeliveryUnit(unitID);

            if (success) {
                request.setAttribute("message", "Delivery unit status changed to Inactive successfully!");
            } else {
                request.setAttribute("error", "Failed to change delivery unit status!");
            }
        }

        doGet(request, response);
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

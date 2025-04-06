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

@WebServlet(name = "DeliveryunitController", urlPatterns = {"/DeliveryunitController"})
public class DeliveryunitController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DeliveryunitDAO dao = new DeliveryunitDAO();
        ArrayList<Deliveryunits> unitList = dao.getAllDeliveryUnits();
        request.setAttribute("unitList", unitList);
        request.getRequestDispatcher("Deliveryunit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        DeliveryunitDAO dao = new DeliveryunitDAO();

        if ("add".equals(action)) {
            String unitName = request.getParameter("unitName");
            double unitFee = Double.parseDouble(request.getParameter("unitFee"));
            String unitSpeed = request.getParameter("unitSpeed");

            boolean success = dao.addDeliveryUnit(unitName, unitFee, unitSpeed);

            if (success) {
                request.setAttribute("message", "Added delivery unit successfully!");
            } else {
                request.setAttribute("error", "Failed to add! An active delivery unit with this name already exists.");
            }
        } else if ("update".equals(action)) {
            String unitID = request.getParameter("unitID");
            String unitName = request.getParameter("unitName");
            double unitFee = Double.parseDouble(request.getParameter("unitFee"));
            String unitSpeed = request.getParameter("unitSpeed");

            boolean success = dao.updateDeliveryUnit(unitID, unitName, unitFee, unitSpeed);

            if (success) {
                request.setAttribute("message", "Updated delivery unit successfully!");
            } else {
                request.setAttribute("error", "Failed to update! An active delivery unit with this name already exists.");
            }
        } else if ("delete".equals(action)) {
            String unitID = request.getParameter("unitID");
            boolean success = dao.deactivateDeliveryUnit(unitID);

            if (success) {
                request.setAttribute("message", "Delivery unit deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to change delivery unit status!");
            }
        }

        doGet(request, response);
    }
}

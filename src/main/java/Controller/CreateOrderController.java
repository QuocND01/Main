package Controller;

import DAO.BookDAO;
import DAO.CartDAO;
import DAO.CustomerDAO;
import DAO.DeliveryunitDAO;
import DAO.OrderDAO;
import DAO.OrderDetailDAO;
import DAO.VoucherDAO;
import Model.Books;
import Model.Cart;
import Model.Customers;
import Model.Deliveryunits;
import Model.OrderDetails;
import Model.Orders;
import Model.Vouchers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CreateOrderController", urlPatterns = {"/CreateOrderController"})
public class CreateOrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateOrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateOrderController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customerID = (String) session.getAttribute("customerID");

        if (customerID == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        // Clear any previous order creation data when first entering the page
        String fromPage = request.getParameter("from");
        if (fromPage == null || !fromPage.equals("samePage")) {
            clearOrderCreationData(session);
        }

        // Get all necessary data and prepare for the JSP
        prepareOrderData(request, customerID);

        request.getRequestDispatcher("CreateOrder.jsp").forward(request, response);
    }

    private void clearOrderCreationData(HttpSession session) {
        // Clear all order creation related data from session
        session.removeAttribute("totalPrice");
        session.removeAttribute("totalPriceAfterDiscount");
        session.removeAttribute("totalPriceAfterDiscountAndDelivery");
        session.removeAttribute("discount");
        session.removeAttribute("selectedUnit");
        session.removeAttribute("deliveryFee");
        session.removeAttribute("voucherCode");
    }

    private void prepareOrderData(HttpServletRequest request, String customerID) {
        HttpSession session = request.getSession();
        CustomerDAO customerDAO = new CustomerDAO();
        DeliveryunitDAO deliveryunitDAO = new DeliveryunitDAO();
        CartDAO cartDAO = new CartDAO();
        BookDAO bookDAO = new BookDAO();

        // Get customer information
        Customers customer = customerDAO.getCustomerByID(customerID);

        // Get cart items
        ArrayList<Cart> cartList = cartDAO.getCartByCustomer(customerID);

        // Calculate total price and prepare cart items with book details
        double totalPrice = 0;
        ArrayList<Map<String, Object>> cartItems = new ArrayList<>();

        for (Cart cart : cartList) {
            Books book = bookDAO.getBookByBookID(cart.getBookID());
            // Updated to use bookPrice directly from the model
            double totalItemPrice = book.getBookPrice() * cart.getCartBookQuantity();
            totalPrice += totalItemPrice;

            Map<String, Object> item = new HashMap<>();
            item.put("cart", cart);
            item.put("book", book);
            item.put("totalItemPrice", totalItemPrice);

            cartItems.add(item);
        }

        // Get only active delivery units
        ArrayList<Deliveryunits> deliveryUnits = deliveryunitDAO.getAllDeliveryUnits();

        // Handle discount calculation
        String voucherCode = (String) session.getAttribute("voucherCode");
        double discount = 0;
        if (session.getAttribute("discount") != null) {
            discount = (double) session.getAttribute("discount");
        }
        double totalPriceAfterDiscount = totalPrice * (1 - discount / 100.0);

        // Handle delivery unit selection and fee calculation
        Deliveryunits selectedUnit = (Deliveryunits) session.getAttribute("selectedUnit");
        double deliveryFee = 0;

        if (selectedUnit != null) {
            deliveryFee = selectedUnit.getUnitFee();
        }

        // Calculate final total price with delivery fee
        double totalPriceAfterDiscountAndDelivery = totalPriceAfterDiscount + deliveryFee;

        // Set attributes for the JSP
        request.setAttribute("customer", customer);
        request.setAttribute("deliveryUnits", deliveryUnits);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("totalPriceAfterDiscount", totalPriceAfterDiscount);
        request.setAttribute("totalPriceAfterDiscountAndDelivery", totalPriceAfterDiscountAndDelivery);
        request.setAttribute("orderDate", new Date());
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartList", cartList);
        request.setAttribute("selectedUnit", selectedUnit);
        request.setAttribute("deliveryFee", deliveryFee);
        request.setAttribute("discount", discount);
        request.setAttribute("voucherCode", voucherCode);

        // Store prices in session for future use
        session.setAttribute("totalPrice", totalPrice);
        session.setAttribute("totalPriceAfterDiscount", totalPriceAfterDiscount);
        session.setAttribute("totalPriceAfterDiscountAndDelivery", totalPriceAfterDiscountAndDelivery);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String customerID = (String) session.getAttribute("customerID");

        if (customerID == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        if ("selectDelivery".equals(action)) {
            String unitID = request.getParameter("unitID");

            // If unitID is empty (user selected the "Select a delivery unit" option)
            if (unitID == null || unitID.isEmpty()) {
                // Remove any previously selected delivery unit
                session.removeAttribute("selectedUnit");
                session.removeAttribute("deliveryFee");

                // Recalculate total price without delivery fee
                double totalPriceAfterDiscount = (double) session.getAttribute("totalPriceAfterDiscount");
                session.setAttribute("totalPriceAfterDiscountAndDelivery", totalPriceAfterDiscount);
            } else {
                // Process normally
                processDeliverySelection(request, session);
            }

            String voucherCode = (String) session.getAttribute("voucherCode");
            request.setAttribute("voucherCode", voucherCode);
            request.setAttribute("from", "samePage");
            doGet(request, response);
            return;
        }

        if ("applyVoucher".equals(action)) {
            processVoucher(request, session, customerID);
            // Preserve delivery selection if it exists
            if (request.getParameter("unitID") != null && !request.getParameter("unitID").isEmpty()) {
                processDeliverySelection(request, session);
            }
            request.setAttribute("from", "samePage");
            doGet(request, response);
            return;
        }

        if ("finishOrder".equals(action)) {
            // Check if delivery unit is selected
            Deliveryunits selectedUnit = (Deliveryunits) session.getAttribute("selectedUnit");
            if (selectedUnit == null) {
                request.setAttribute("errorMessage", "Please select a delivery unit before placing your order!");
                request.setAttribute("from", "samePage");
                doGet(request, response);
                return;
            }

            boolean orderCreated = createOrder(request, session, customerID);

            if (orderCreated) {
                // Clear order creation data after successful order
                clearOrderCreationData(session);
                // Set success message and redirect to homepage
                session.setAttribute("cartMessage", "Order placed successfully! Your order is being processed.");
                response.sendRedirect("ViewBookCustomerController");
                return;
            }
        }

        // If we reach here, there was an error
        request.setAttribute("from", "samePage");
        doGet(request, response);
    }

    private void processDeliverySelection(HttpServletRequest request, HttpSession session) {
        String unitID = request.getParameter("unitID");
        DeliveryunitDAO deliveryunitDAO = new DeliveryunitDAO();

        if (unitID != null && !unitID.isEmpty()) {
            Deliveryunits selectedUnit = null;
            ArrayList<Deliveryunits> deliveryUnits = deliveryunitDAO.getAllDeliveryUnits();

            for (Deliveryunits unit : deliveryUnits) {
                if (unit.getUnitID().equals(unitID)) {
                    selectedUnit = unit;
                    break;
                }
            }

            if (selectedUnit != null) {
                double deliveryFee = selectedUnit.getUnitFee();
                double totalPriceAfterDiscount = (double) session.getAttribute("totalPriceAfterDiscount");
                double totalPriceAfterDiscountAndDelivery = totalPriceAfterDiscount + deliveryFee;

                session.setAttribute("selectedUnit", selectedUnit);
                session.setAttribute("deliveryFee", deliveryFee);
                session.setAttribute("totalPriceAfterDiscountAndDelivery", totalPriceAfterDiscountAndDelivery);
            } else {
                // If an invalid unit ID was passed, clear the selection
                session.removeAttribute("selectedUnit");
                session.removeAttribute("deliveryFee");
            }
        } else {
            // If no unit ID was passed, clear the selection
            session.removeAttribute("selectedUnit");
            session.removeAttribute("deliveryFee");
        }
    }

    private void processVoucher(HttpServletRequest request, HttpSession session, String customerID) {
        String voucherCode = request.getParameter("voucherCode");
        double totalPrice = (double) session.getAttribute("totalPrice");
        double deliveryFee = 0;

        if (session.getAttribute("deliveryFee") != null) {
            deliveryFee = (double) session.getAttribute("deliveryFee");
        }

        if (voucherCode != null && !voucherCode.isEmpty()) {
            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers voucher = voucherDAO.getVoucherByCode(voucherCode);

            if (voucher != null && "active".equalsIgnoreCase(voucher.getVoucherStatus())) {
                int discount = voucher.getVoucherValue(); // Discount value %
                double totalPriceAfterDiscount = totalPrice * (1 - discount / 100.0);
                double totalPriceAfterDiscountAndDelivery = totalPriceAfterDiscount + deliveryFee;

                session.setAttribute("discount", (double) discount);
                session.setAttribute("totalPriceAfterDiscount", totalPriceAfterDiscount);
                session.setAttribute("totalPriceAfterDiscountAndDelivery", totalPriceAfterDiscountAndDelivery);
                session.setAttribute("voucherCode", voucherCode);
            } else {
                request.setAttribute("errorMessageVoucher", "Voucher is invalid or inactive!");
                // Still need to set totalPriceAfterDiscount even if voucher is invalid
                session.setAttribute("discount", 0.0);
                session.setAttribute("totalPriceAfterDiscount", totalPrice);
                session.setAttribute("totalPriceAfterDiscountAndDelivery", totalPrice + deliveryFee);
                session.removeAttribute("voucherCode");
            }
        } else {
            // No voucher code provided, clear voucher data
            session.setAttribute("discount", 0.0);
            session.setAttribute("totalPriceAfterDiscount", totalPrice);
            session.setAttribute("totalPriceAfterDiscountAndDelivery", totalPrice + deliveryFee);
            session.removeAttribute("voucherCode");
        }
    }

    private boolean createOrder(HttpServletRequest request, HttpSession session, String customerID) {
        String voucherCode = (String) session.getAttribute("voucherCode");
        Deliveryunits selectedUnit = (Deliveryunits) session.getAttribute("selectedUnit");

        if (selectedUnit == null) {
            request.setAttribute("errorMessage", "Please select a delivery unit before placing your order!");
            return false;
        }

        String unitID = selectedUnit.getUnitID();
        double totalPrice = (double) session.getAttribute("totalPrice");
        double finalPrice = (double) session.getAttribute("totalPriceAfterDiscountAndDelivery");

        // Get voucher ID if applicable
        String voucherID = null;
        if (voucherCode != null && !voucherCode.isEmpty()) {
            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers voucher = voucherDAO.getVoucherByCode(voucherCode);
            if (voucher != null && "active".equalsIgnoreCase(voucher.getVoucherStatus())) {
                voucherID = voucher.getVoucherID();
            }
        }

        // Create the order
        Orders newOrder = new Orders(
                null, customerID, null, new java.sql.Date(new Date().getTime()),
                voucherID,
                finalPrice,
                unitID, null, "Not Approved"
        );

        OrderDAO orderDAO = new OrderDAO();
        String newOrderID = orderDAO.createOrder(newOrder);

        if (newOrderID != null) {
            // Process order details
            CartDAO cartDAO = new CartDAO();
            BookDAO bookDAO = new BookDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            ArrayList<Cart> cartItems = cartDAO.getCartByCustomer(customerID);

            boolean allDetailsSaved = true;

            for (Cart item : cartItems) {
                Books book = bookDAO.getBookByBookID(item.getBookID());
                double itemPrice = book.getBookPrice();

                OrderDetails orderDetail = new OrderDetails(
                        null, newOrderID, item.getBookID(), item.getCartBookQuantity(), itemPrice
                );

                boolean detailSaved = orderDetailDAO.createOrderDetail(orderDetail);
                boolean stockUpdated = bookDAO.updateBookStock(item.getBookID(), item.getCartBookQuantity());

                if (!detailSaved || !stockUpdated) {
                    allDetailsSaved = false;
                }
            }

            if (allDetailsSaved) {
                // Clear the cart
                cartDAO.clearCart(customerID);
                return true;
            } else {
                request.setAttribute("errorMessage", "Error saving order details or updating stock!");
                return false;
            }
        } else {
            request.setAttribute("errorMessage", "Error creating order!");
            return false;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

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
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date; // Add this import

@WebServlet(name = "CreateOrderController", urlPatterns = {"/CreateOrderController"})
public class CreateOrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
        double totalPrice = (double) session.getAttribute("totalPrice");

        if (customerID == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        DeliveryunitDAO deliveryunitDAO = new DeliveryunitDAO();
        Customers customer = customerDAO.getCustomerByID(customerID);

        // Get only active delivery units
        ArrayList<Deliveryunits> deliveryUnits = deliveryunitDAO.getActiveDeliveryUnits();

        request.setAttribute("customer", customer);
        request.setAttribute("deliveryUnits", deliveryUnits);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("orderDate", new Date());
        request.getRequestDispatcher("CreateOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String customerID = (String) session.getAttribute("customerID");
        double totalPrice = (double) session.getAttribute("totalPrice");

        if (customerID == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        if ("applyVoucher".equals(action)) {
            String voucherCode = request.getParameter("voucherCode");
            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers voucher = voucherDAO.getVoucherByCode(voucherCode);

            if (voucher != null && "active".equalsIgnoreCase(voucher.getStatus())) {
                int discount = voucher.getValue(); // Discount value %
                double discountedPrice = totalPrice * (1 - discount / 100.0);
                request.setAttribute("discount", discount);
                request.setAttribute("newTotalPrice", discountedPrice);
                request.setAttribute("voucherCode", voucherCode);
            } else {
                request.setAttribute("errorMessageVoucher", "Voucher is invalid or inactive!");
            }

            doGet(request, response);
            return;
        }

        if ("finishOrder".equals(action)) {
            String voucherCode = request.getParameter("voucherCode");
            String unitID = request.getParameter("unitID");

            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers voucher = voucherDAO.getVoucherByCode(voucherCode);

            // Check if voucher is active
            int discount = 0;
            if (voucher != null && "active".equalsIgnoreCase(voucher.getStatus())) {
                discount = voucher.getValue();
            }

            double finalPrice = totalPrice * (1 - discount / 100.0);

            Orders newOrder = new Orders(
                    null, customerID, null, new java.sql.Date(new Date().getTime()),
                    (voucher != null && "active".equalsIgnoreCase(voucher.getStatus())) ? voucher.getVoucherID() : null,
                    finalPrice,
                    unitID, null, "Pending"
            );

            OrderDAO orderDAO = new OrderDAO();
            String newOrderID = orderDAO.createOrder(newOrder);

            if (newOrderID != null) {
                // Use the returned orderID directly
                String orderID = newOrderID;

                // Get cart items and create order details for each item
                CartDAO cartDAO = new CartDAO();
                BookDAO bookDAO = new BookDAO();
                OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
                ArrayList<Cart> cartItems = cartDAO.getCartByCustomer(customerID);

                boolean allDetailsSaved = true;

                for (Cart item : cartItems) {
                    // Get book details
                    Books book = bookDAO.getBookByBookID(item.getBookID());
                    double itemPrice = Double.parseDouble(book.getPrice());

                    // Create order detail
                    OrderDetails orderDetail = new OrderDetails(
                            null, orderID, item.getBookID(), item.getQuantity(), itemPrice // Changed to double instead of String
                    );

                    // Save order detail
                    boolean detailSaved = orderDetailDAO.createOrderDetail(orderDetail);

                    // Update book stock
                    boolean stockUpdated = bookDAO.updateBookStock(item.getBookID(), item.getQuantity());

                    if (!detailSaved || !stockUpdated) {
                        allDetailsSaved = false;
                    }
                }

                if (allDetailsSaved) {
                    // Clear the cart
                    cartDAO.clearCart(customerID);

                    // Set success message and redirect to homepage
                    session.setAttribute("cartMessage", "Order placed successfully! Your order is being processed.");

                    // Redirect to homepage
                    response.sendRedirect("ViewBookCustomerController");
                    return;
                } else {
                    request.setAttribute("errorMessage", "Error saving order details or updating stock!");
                }
            } else {
                request.setAttribute("errorMessage", "Error retrieving order information!");
            }
        } else {
            request.setAttribute("errorMessage", "Order error!");
        }
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

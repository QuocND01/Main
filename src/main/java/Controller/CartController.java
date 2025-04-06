package Controller;

import DAO.BookDAO;
import DAO.CartDAO;
import Model.Books;
import Model.Cart;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET requests - display the cart
        HttpSession session = request.getSession();
        String customerID = (String) session.getAttribute("customerID");

        if (customerID == null) {
            response.sendRedirect("LoginForm.jsp");
            return;
        }

        // Get cart items
        ArrayList<Cart> cartList = cartDAO.getCartByCustomer(customerID);
        request.setAttribute("cartList", cartList);

        // Calculate totals and prepare cart item details
        double totalPrice = 0;
        ArrayList<Books> bookDetailsList = new ArrayList<>();

        for (Cart cart : cartList) {
            Books book = bookDAO.getBookByBookID(cart.getBookID());
            bookDetailsList.add(book);
            // Using updated model properties
            double totalItemPrice = book.getBookPrice() * cart.getCartBookQuantity();
            totalPrice += totalItemPrice;
        }

        request.setAttribute("bookDetailsList", bookDetailsList);
        session.setAttribute("totalPrice", totalPrice);

        // Forward to the JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("Cart.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customerID = (String) session.getAttribute("customerID");

        if (customerID == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"You need to login before!\"}");
            return;
        }

        String action = request.getParameter("action");
        String bookID = request.getParameter("bookId");

        if ("add".equals(action)) {
            // Check if the product is already in the cart
            boolean isInCart = false;
            ArrayList<Cart> cartList = cartDAO.getCartByCustomer(customerID);
            for (Cart item : cartList) {
                if (item.getBookID().equals(bookID)) {
                    isInCart = true;
                    break;
                }
            }

            if (isInCart) {
                // Product already in cart, send appropriate message
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Product is already in your cart.\", \"isInCart\": true}");
            } else {
                // Product not in cart, add it
                cartDAO.addToCart(customerID, bookID);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"isInCart\": false}");
            }
        } else if ("remove".equals(action)) {
            cartDAO.removeFromCart(customerID, bookID);
            response.sendRedirect("CartController");
        } else if ("update".equals(action)) {
            String bookId = request.getParameter("bookId");
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));

            // Update book quantity in the cart
            cartDAO.updateQuantity(customerID, bookId, newQuantity);

            // Get book information to recalculate the total price for each product
            Books book = bookDAO.getBookByBookID(bookId);
            double newTotal = newQuantity * book.getBookPrice();

            // Calculate the total cart value
            ArrayList<Cart> updatedCartList = cartDAO.getCartByCustomer(customerID);
            double totalPrice = 0;
            for (Cart cart : updatedCartList) {
                Books cartBook = bookDAO.getBookByBookID(cart.getBookID());
                totalPrice += cart.getCartBookQuantity() * cartBook.getBookPrice();
            }

            session.setAttribute("totalPrice", totalPrice);

            // Return JSON containing the new total price
            response.setContentType("application/json");
            response.getWriter().write("{\"newTotal\": " + newTotal + ", \"totalPrice\": " + totalPrice + "}");
            return;
        } else if ("clear".equals(action)) {
            cartDAO.clearCart(customerID);
            response.sendRedirect("CartController");
        }
    }
}

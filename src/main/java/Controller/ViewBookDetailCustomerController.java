package Controller;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CategoryDAO;
import DAO.FeedbackDAO;
import Model.Authors;
import Model.Books;
import Model.Cart;
import Model.Categories;
import Model.Feedbacks;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author QuocNDCE181301
 */
@WebServlet(name = "ViewBookDetailCustomerController", urlPatterns = {"/viewBookDetailCustomerController"})
public class ViewBookDetailCustomerController extends HttpServlet {

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
        String bookID = request.getParameter("BookID");
        
        // Initialize DAOs
        BookDAO bookDAO = new BookDAO();
        AuthorDAO authorDAO = new AuthorDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        
        // Get book details and related data
        Books book = bookDAO.getBookByBookID(bookID);
        ArrayList<Categories> categories = categoryDAO.getAllCategorys();
        ArrayList<Authors> authors = authorDAO.getAllAuthor();
        List<Map<String, Object>> feedbackList = feedbackDAO.getFeedbackByBookId(bookID);

        // Check if the book is already in cart
        boolean isInCart = false;
        HttpSession session = request.getSession();
        ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart-list");
        if (cartList != null) {
            for (Cart item : cartList) {
                if (item.getBookID().equals(bookID)) {
                    isInCart = true;
                    break;
                }
            }
        }

        // Set attributes for JSP
        request.setAttribute("isInCart", isInCart);
        request.setAttribute("book", book);
        request.setAttribute("categories", categories);
        request.setAttribute("authors", authors);
        request.setAttribute("feedbackList", feedbackList);
        
        // Forward to JSP
        request.getRequestDispatcher("ViewBookDetailCustomer.jsp").forward(request, response);
    }
}
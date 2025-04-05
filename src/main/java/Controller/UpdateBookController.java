/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CategoryDAO;
import Model.Authors;
import Model.Books;
import Model.Categories;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author QuocNDCE181301
 */
@WebServlet(name = "UpdateBookController", urlPatterns = {"/updateBookController"})
public class UpdateBookController extends HttpServlet {

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
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        HttpSession session = request.getSession();
        String bookID = request.getParameter("BookID");
        BookDAO book = new BookDAO();
        CategoryDAO cate = new CategoryDAO();
        AuthorDAO author = new AuthorDAO();
        ArrayList<Categories> catelist = new ArrayList<>();
        ArrayList<Authors> authorlist = new ArrayList<>();
        catelist = cate.getAllCategorys();
        authorlist = author.getAllAuthor();
        Books b = book.getBookByBookID(bookID);
        if (b != null) {
            session.setAttribute("book", b);
            session.setAttribute("categories", catelist);
            session.setAttribute("author", authorlist);
            request.getRequestDispatcher("UpdateBookView.jsp").forward(request, response);
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
    protected void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("errorName", null);
        session.setAttribute("errorSupplierName", null);
        session.setAttribute("errorAuthor", null);
        session.setAttribute("errorYearOfPublication", null);
        session.setAttribute("errorWeight", null);
        session.setAttribute("errorSize", null);
        session.setAttribute("errorNumberOfPages", null);
        session.setAttribute("errorForm", null);
        session.setAttribute("errorDescribe", null);
        session.setAttribute("errorImage", null);
        session.setAttribute("errorPrice", null);
        session.setAttribute("errorQuantity", null);
        session.setAttribute("errorCategoryID", null);

        boolean hasError = false;
        boolean erroryear = false, errorweight = false, errornumber = false, errorprice = false, errorquantity = false;
        int year = 0, number = 0, quantity = 0;
        double weight = 0.0, price = 0.0;
        int yearnow = LocalDate.now().getYear();

        String BookID = request.getParameter("BookID");
        String BookName = request.getParameter("BookName");
        String SupplierName = request.getParameter("SupplierName");
        String Author = request.getParameter("Author");
        String YearOfPublication = request.getParameter("YearOfPublication");
        String Weight = request.getParameter("Weight");
        String Size = request.getParameter("Size");
        String NumberOfPages = request.getParameter("NumberOfPages");
        String Form = request.getParameter("Form");
        String Describe = request.getParameter("Describe");
        String Image = request.getParameter("Image");
        String Price = request.getParameter("Price");
        String Quantity = request.getParameter("Quantity");
        String CategoryID = request.getParameter("CategoryID");

        try {
            year = Integer.parseInt(YearOfPublication);
            if (year > yearnow) {
                erroryear = true;
            }
        } catch (NumberFormatException e) {
            erroryear = true;
        }

        try {
            weight = Double.parseDouble(Weight);
            if (weight <= 0) {
                errorweight = true;
            }
        } catch (NumberFormatException e) {
            errorweight = true;
        }

        try {
            number = Integer.parseInt(NumberOfPages);
            if (number <= 0) {
                errornumber = true;
            }
        } catch (NumberFormatException e) {
            errornumber = true;
        }

        try {
            price = Double.parseDouble(Price);
            if (price <= 0) {
                errorprice = true;
            }
        } catch (NumberFormatException e) {
            errorprice = true;
        }

        try {
            quantity = Integer.parseInt(Quantity);
            if (quantity < 0) {
                errorquantity = true;
            }
        } catch (NumberFormatException e) {
            errorquantity = true;
        }

        if (BookName == null || BookName.trim().isEmpty()||BookName.length()>50) {
            session.setAttribute("errorName", "BookName is required and cannot more than 50 characters");
            hasError = true;
        }

        if (SupplierName == null || SupplierName.trim().isEmpty() || !SupplierName.matches("[a-zA-Z0-9 ]+")|| SupplierName.length()>50) {
            session.setAttribute("errorSupplierName", "SupplierName is required and cannot contain special characters and not more than 50 character");
            hasError = true;
        }

        if (Author == null || Author.trim().isEmpty() || !Author.matches("[a-zA-Z0-9 ]+") || Author.length()>50) {
            session.setAttribute("errorAuthor", "Author is required and cannot contain special characters or more than 50");
            hasError = true;
        }

        if (YearOfPublication == null || YearOfPublication.trim().isEmpty() || erroryear|| YearOfPublication.length()>4) {
            session.setAttribute("errorYearOfPublication", "Year must be a valid number, must be 4 digit number and less than " + yearnow);
            hasError = true;
        }

        if (Weight == null || Weight.trim().isEmpty() || errorweight) {
            session.setAttribute("errorWeight", "Weight is required and must be greater than 0");
            hasError = true;
        }

        if (Size == null || Size.trim().isEmpty() || Size.length()>50) {
            session.setAttribute("errorSize", "Size is required and cannot more than 50 character");
            hasError = true;
        }

        if (NumberOfPages == null || NumberOfPages.trim().isEmpty() || errornumber) {
            session.setAttribute("errorNumberOfPages", "Number of Pages must be a positive integer");
            hasError = true;
        }

        if (Form == null || Form.trim().isEmpty() || Form.length()>50) {
            session.setAttribute("errorForm", "Form is required and cannot more than 50 characters");
            hasError = true;
        }

        if (CategoryID == null || CategoryID.trim().isEmpty()) {
            session.setAttribute("errorCategoryID", "Category is required");
            hasError = true;
        }

        if (Describe == null || Describe.trim().isEmpty()) {
            session.setAttribute("errorDescribe", "Describe is required");
            hasError = true;
        }

        if (Image == null || Image.trim().isEmpty() || !Image.toLowerCase().endsWith(".jpg")) {
            session.setAttribute("errorImage", "Image is required and must end with .jpg");
            hasError = true;
        }

        if (Price == null || Price.trim().isEmpty() || errorprice) {
            session.setAttribute("errorPrice", "Price is required and must be greater than 0");
            hasError = true;
        }

        if (Quantity == null || Quantity.trim().isEmpty() || errorquantity) {
            session.setAttribute("errorQuantity", "Quantity must be a non-negative integer");
            hasError = true;
        }

        if (hasError == false) {

            try {
                String authorID = "";
                boolean existauthor = false;
                BookDAO book = new BookDAO();
                AuthorDAO author = new AuthorDAO();
                int authorid = author.getrow() + 1;
                ArrayList<Authors> authorlist = new ArrayList<>();
                authorlist = author.getAllAuthor();
                for (Authors au : authorlist) {
                    if (au.getAuthorName().equalsIgnoreCase(Author)) {
                        authorID = au.getAuthorID();
                        existauthor = true;
                        break;
                    }
                }
                if (existauthor == false) {
                    Authors aut = new Authors("A" + authorid, Author, "Active");
                    author.addAuthor(aut);
                    authorID = "A" + authorid;
                }
                    Books b = new Books(BookID, BookName, SupplierName, authorID, YearOfPublication, weight, Size, number, Form, Describe, Image, price, quantity, CategoryID, "Active");
                book.updateBook(b);
                response.sendRedirect("viewBookAdminController");
            } catch (IOException e) {
            }
        } else {
            request.getRequestDispatcher("UpdateBookView.jsp").forward(request, response);
        }

    }
}

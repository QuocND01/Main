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
import Model.Categorys;
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
        ArrayList<Categorys> catelist = new ArrayList<>();
        ArrayList<Authors> authorlist = new ArrayList<>();
        catelist = cate.getAllCategorys();
        authorlist = author.getAllAuthor();
        Books b = book.getBookByBookID(bookID);
        if (b != null) {
            session.setAttribute("book", b);
            session.setAttribute("cate", catelist);
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
        int year = 0;
        Double weight = 0.0;
        int number = 0;
        Double price = 0.0;
        int quantity = 0;
        boolean erroryear = false;
        boolean errorweight = false;
        boolean errornumber = false;
        boolean errorprice = false;
        boolean errorquantity = false;
        boolean hasError = false;
        String error = "";
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
        int yearnow = LocalDate.now().getYear();

        try {
            year = Integer.parseInt(YearOfPublication);
        } catch (NumberFormatException e) {
            erroryear = true;
        }
        try {
            weight = Double.parseDouble(Weight);
        } catch (NumberFormatException e) {
            errorweight = true;
        }
        try {
            number = Integer.parseInt(NumberOfPages);
        } catch (NumberFormatException e) {
            errornumber = true;
        }
        try {
            price = Double.parseDouble(Price);
        } catch (NumberFormatException e) {
            errorprice = true;
        }
        try {
            quantity = Integer.parseInt(Quantity);
        } catch (NumberFormatException e) {
            errorquantity = true;
        }
        if (BookName.trim().isEmpty() || BookName == null) {
            error = "BookName is required";
            hasError = true;
        }
        if (SupplierName.trim().isEmpty() || SupplierName == null) {
            error = "SupplierName is required";
            hasError = true;
        }
        if (Author.trim().isEmpty() || Author == null) {
            error = "Author is required";
            hasError = true;
        }
        if (YearOfPublication.trim().isEmpty() || YearOfPublication == null || year > yearnow || erroryear) {
            error = "Year Of Publication is required must be number and smaller than " + yearnow;
            hasError = true;
        }
        if (Weight.trim().isEmpty() || Weight == null || weight <= 0 || errorweight) {
            error = "Weight is required and must bigger than 0 ";
            hasError = true;
        }
        if (Size.trim().isEmpty() || Size == null) {
            error = "Size is required";
            hasError = true;
        }
        if (NumberOfPages.trim().isEmpty() || NumberOfPages == null || number <= 0 || errornumber) {
            error = "Number Of Pages is required and must be bigger than 0";
            hasError = true;
        }
        if (Form.trim().isEmpty() || Form == null) {
            error = "Form is required";
            hasError = true;
        }
        if (CategoryID.trim().isEmpty() || CategoryID == null) {
            error = "Category is required";
            hasError = true;
        }
        if (Describe.trim().isEmpty() || Describe == null) {
            error = "Describe is required";
            hasError = true;
        }
        if (Image.trim().isEmpty() || Image == null) {
            error = "Image is required";
            hasError = true;
        }
        if (Price.trim().isEmpty() || Price == null || price <= 0 || errorprice) {
            error = "Price is required and must bigger than 0";
            hasError = true;
        }
        if (quantity < 0 || errorquantity) {
            error = "Quantity is required and must be a positive number";
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
                Books b = new Books(BookID, BookName, SupplierName, authorID, YearOfPublication, Weight, Size, NumberOfPages, Form, Describe, Image, Price, Quantity, CategoryID, "Active");
                book.updateBook(b);
                response.sendRedirect("viewBookAdminController");
            } catch (IOException e) {
            }
        } else {
            session.setAttribute("errorBook", error);
            request.getRequestDispatcher("UpdateBookView.jsp").forward(request, response);
        }

    }
}

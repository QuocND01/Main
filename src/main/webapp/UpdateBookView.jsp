<%-- 
    Document   : UpdateBookView
    Created on : Feb 22, 2025, 2:11:27 PM
    Author     : QuocNDCE181301
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Book</title>
        <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f3f4f6;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
                color: #333;
            }

            .form-container {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                width: 100%;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .form-container:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            }

            h2 {
                text-align: center;
                color: #FF69B4;
                margin-bottom: 20px;
                font-size: 24px;
                font-weight: 700;
            }

            label {
                font-weight: 600;
                color: #4b5563;
                margin-bottom: 6px;
                display: block;
            }

            input[type="text"],
            input[type="number"],
            input[type="date"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                margin-bottom: 15px;
                font-size: 14px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            input[type="date"]:focus {
                border-color: #3b82f6;
                box-shadow: 0 0 5px rgba(59, 130, 246, 0.3);
                outline: none;
            }

            input[readonly] {
                background-color: #e5e7eb;
                cursor: not-allowed;
            }

            .btn-submit {
                background-color: #FF69B4;
                color: #ffffff;
                border: none;
                padding: 12px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.2s;
                width: 100%;
                text-align: center;
            }

            .btn-submit:hover {
                background-color: #2563eb;
                transform: translateY(-2px);
            }

            .btn-submit:active {
                transform: translateY(0);
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Update Book</h2>
            <form action="updateBookController" method="post">
                <c:set var="b" value="${sessionScope.book}"/>

                <label for="BookID">Book ID</label>
                <input type="text" id="BookID" name="BookID" value="${b.bookID}" readonly>

                <label for="BookName">Book Name</label>
                <input type="text" id="BookName" name="BookName" value="${b.bookName}" required>

                <label for="SupplierName">Supplier Name</label>
                <input type="text" id="SupplierName" name="SupplierName" value="${b.supplierName}" required>

                <label for="Author">Author</label>
                <input type="text" id="Author" name="Author" value="${b.author}" required>

                <label for="YearOfPublication">Year Of Publication</label>
                <input type="text" id="YearOfPublication" name="YearOfPublication" value="${b.yearOfPublication}" required>

                <label for="Weight">Weight</label>
                <input type="text" id="Weight" name="Weight" value="${b.weight}" required>

                <label for="Size">Size</label>
                <input type="text" id="Size" name="Size" value="${b.size}" required>

                <label for="NumberOfPages">Number Of Pages</label>
                <input type="text" id="NumberOfPages" name="NumberOfPages" value="${b.numberOfPages}" required>

                <label for="Form">Form</label>
                <input type="text" id="Form" name="Form" value="${b.form}" required>

                <label for="Describe">Describe</label>
                <input type="text" id="Describe" name="Describe" value="${b.describe}" required>

                <label for="Image">Image</label>
                <input type="text" id="Image" name="Image" value="${b.image}" required>

                <label for="Price">Price</label>
                <input type="text" id="Price" name="Price" value="${b.price}" required>

                <label for="Stock">Stock</label>
                <input type="text" id="Stock" name="Stock" value="${b.stock}" required>

                <label for="CategoryID">Category</label>
                <select id="CategoryID" name="CategoryID">
                    <option value="1" ${b.categoryID == 1 ? 'selected' : ''}>Classic Literature</option>
                    <option value="2" ${b.categoryID == 2 ? 'selected' : ''}>Non-Fiction</option>
                    <option value="3" ${b.categoryID == 3 ? 'selected' : ''}>Fantasy</option>
                    <option value="4" ${b.categoryID == 4 ? 'selected' : ''}>Self-Help</option>
                    <option value="5" ${b.categoryID == 5 ? 'selected' : ''}>Science</option>
                    <option value="6" ${b.categoryID == 6 ? 'selected' : ''}>History</option>
                    <option value="7" ${b.categoryID == 7 ? 'selected' : ''}>Finance</option>
                    <option value="8" ${b.categoryID == 8 ? 'selected' : ''}>Psychology</option>
                    <option value="9" ${b.categoryID == 9 ? 'selected' : ''}>Dystopian Fiction</option>

                </select>

                <button type="submit" class="btn-submit">Update Book</button>
                <c:if test="${not empty sessionScope.errorBook}">
                    <p>${sessionScope.errorBook}</p>
                </c:if>
            </form>
        </div>
    </body>
</html>


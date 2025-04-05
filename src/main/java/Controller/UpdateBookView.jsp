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
                <c:if test="${not empty sessionScope.errorName}">
                    <p>${sessionScope.errorName}</p>
                </c:if>
                <input type="text" id="BookName" name="BookName" value="${b.bookName}" required>

                <label for="SupplierName">Supplier Name</label>
                <c:if test="${not empty sessionScope.errorSupplierName}">
                    <p>${sessionScope.errorSupplierName}</p>
                </c:if>
                <input type="text" id="SupplierName" name="SupplierName" value="${b.bookSupplierName}" required>

                <label for="Author">Author</label>
                <c:if test="${not empty sessionScope.errorAuthor}">
                    <p>${sessionScope.errorAuthor}</p>
                </c:if>
                <c:forEach items="${author}" var="a">
                    <c:if test = "${a.authorID == b.authorID}">
                        <input type="text" id="Author" name="Author" value="${a.authorName}">
                    </c:if>
                </c:forEach>

                <label for="YearOfPublication">Year Of Publication</label>
                <c:if test="${not empty sessionScope.errorYearOfPublication}">
                    <p>${sessionScope.errorYearOfPublication}</p>
                </c:if>
                <input type="text" id="YearOfPublication" name="YearOfPublication" value="${b.yearOfPublication}" required>

                <label for="Weight">Weight</label>
                <c:if test="${not empty sessionScope.errorWeight}">
                    <p>${sessionScope.errorWeight}</p>
                </c:if>
                <input type="text" id="Weight" name="Weight" value="${b.weight}" required>

                <label for="Size">Size</label>
                <c:if test="${not empty sessionScope.errorSize}">
                    <p>${sessionScope.errorSize}</p>
                </c:if>
                <input type="text" id="Size" name="Size" value="${b.size}" required>

                <label for="NumberOfPages">Number Of Pages</label>
                <c:if test="${not empty sessionScope.errorNumberOfPages}">
                    <p>${sessionScope.errorNumberOfPages}</p>
                </c:if>
                <input type="text" id="NumberOfPages" name="NumberOfPages" value="${b.numberOfPages}" required>

                <label for="Form">Form</label>
                <c:if test="${not empty sessionScope.errorForm}">
                    <p>${sessionScope.errorForm}</p>
                </c:if>
                <input type="text" id="Form" name="Form" value="${b.form}" required>

                <label for="Describe">Describe</label>
                <c:if test="${not empty sessionScope.errorDescribe}">
                    <p>${sessionScope.errorDescribe}</p>
                </c:if>
                <input type="text" id="Describe" name="Describe" value="${b.bookDescribe}" required>

                <label for="Image">Image</label>
                <c:if test="${not empty sessionScope.errorImage}">
                    <p>${sessionScope.errorImage}</p>
                </c:if>
                <input type="text" id="Image" name="Image" value="${b.image}" required>

                <label for="Price">Price</label>
                <c:if test="${not empty sessionScope.errorPrice}">
                    <p>${sessionScope.errorPrice}</p>
                </c:if>
                <input type="text" id="Price" name="Price" value="${b.bookPrice}" required>

                <label for="Quantity">Quantity</label>
                <c:if test="${not empty sessionScope.errorQuantity}">
                    <p>${sessionScope.errorQuantity}</p>
                </c:if>
                <input type="text" id="Quantity" name="Quantity" value="${b.bookQuantity}" required>

                <label for="CategoryID">Category</label>
                <c:if test="${not empty sessionScope.errorCategoryID}">
                    <p>${sessionScope.errorCategoryID}</p>
                </c:if>
               
                <select id="CategoryID" name="CategoryID">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryID}" ${b.categoryID == category.categoryID ? 'selected' : ''}>
                            ${category.categoryName}
                        </option>
                    </c:forEach>
                </select>

                <button type="submit" class="btn-submit">Update Book</button>
                <c:if test="${not empty sessionScope.errorBook}">
                    <p>${sessionScope.errorBook}</p>
                </c:if>
            </form>
        </div>
    </body>
</html>


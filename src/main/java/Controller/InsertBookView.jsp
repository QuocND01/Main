<%-- 
    Document   : InsertBookView
    Created on : Feb 21, 2025, 6:06:05 PM
    Author     : QuocNDCE181301
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert Book</title>
        <style>
            /* General Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body Styling */
            body {
                background: url('<c:url value="/img/banner-image-bg.jpg"/>');
                font-family: 'Roboto', sans-serif;
                background-color: #f4f4f9;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            /* Form Container */
            .form-container {
                background-color: #ffffff;
                border-radius: 15px;
                max-width: 600px;
                width: 100%;
                padding: 40px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
                animation: slideIn 0.5s ease-out;
            }

            .form-container:hover {
                transform: translateY(-5px);
            }

            /* Title Styling */
            h2 {
                text-align: center;
                color: #444;
                font-size: 28px;
                margin-bottom: 20px;
                font-weight: 600;
            }

            /* Label Styling */
            label {
                display: block;
                font-weight: 500;
                margin-bottom: 5px;
                color: #555;
            }

            /* Input Fields Styling */
            input[type="text"],
            input[type="date"],
            input[type="number"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                transition: border-color 0.3s;
                font-size: 16px;
                background-color: #fafafa;
            }

            input[type="text"]:focus,
            input[type="date"]:focus,
            input[type="number"]:focus {
                border-color: #7a42f4;
                outline: none;
                background-color: #fff;
            }

            /* Submit Button Styling */
            input[type="submit"] {
                background-color: #ff6f91;
                color: white;
                border: none;
                padding: 14px;
                font-size: 16px;
                border-radius: 8px;
                cursor: pointer;
                text-transform: uppercase;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.2s;
                width: 100%;
            }

            input[type="submit"]:hover {
                background-color: #5a31d4;
                transform: translateY(-3px);
            }

            /* Error Message Styling */
            p {
                color: #ff4d4d;
                font-size: 14px;
                text-align: center;
                margin-bottom: 15px;
            }

            /* Animation for Form */
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Insert Book</h2>
            <form action="addBookController" method="post">
                <label for="BookID">Book ID</label>
                <input type="text" id="BookID" name="BookID" value="${b.bookID}" readonly>

                <label for="BookName">Book Name</label>
                <c:if test="${not empty sessionScope.errorName}">
                    <p>${sessionScope.errorName}</p>
                </c:if>
                <input type="text" id="BookName" name="BookName" >

                <label for="SupplierName">Supplier Name</label>
                <c:if test="${not empty sessionScope.errorSupplierName}">
                    <p>${sessionScope.errorSupplierName}</p>
                </c:if>
                <input type="text" id="SupplierName" name="SupplierName" >

                <label for="Author">Author</label>
                <c:if test="${not empty sessionScope.errorAuthor}">
                    <p>${sessionScope.errorAuthor}</p>
                </c:if>
                <input type="text" id="Author" name="Author" >

                <label for="YearOfPublication">Year Of Publication</label>
                <c:if test="${not empty sessionScope.errorYearOfPublication}">
                    <p>${sessionScope.errorYearOfPublication}</p>
                </c:if>
                <input type="text" id="YearOfPublication" name="YearOfPublication" >

                <label for="Weight">Weight</label>
                <c:if test="${not empty sessionScope.errorWeight}">
                    <p>${sessionScope.errorWeight}</p>
                </c:if>
                <input type="text" id="Weight" name="Weight" >

                <label for="Size">Size</label>
                <c:if test="${not empty sessionScope.errorSize}">
                    <p>${sessionScope.errorSize}</p>
                </c:if>
                <input type="text" id="Size" name="Size" >

                <label for="NumberOfPages">Number Of Pages</label>
                <c:if test="${not empty sessionScope.errorNumberOfPages}">
                    <p>${sessionScope.errorNumberOfPages}</p>
                </c:if>
                <input type="text" id="NumberOfPages" name="NumberOfPages" >

                <label for="Form">Form</label>
                <c:if test="${not empty sessionScope.errorForm}">
                    <p>${sessionScope.errorForm}</p>
                </c:if>
                <input type="text" id="Form" name="Form" >

                <label for="Describe">Description</label>
                <c:if test="${not empty sessionScope.errorDescribe}">
                    <p>${sessionScope.errorDescribe}</p>
                </c:if>
                <input type="text" id="Describe" name="Describe" >

                <label for="Image">Image URL</label>
                <c:if test="${not empty sessionScope.errorImage}">
                    <p>${sessionScope.errorImage}</p>
                </c:if>
                <input type="text" id="Image" name="Image" >

                <label for="Price">Price</label>
                <c:if test="${not empty sessionScope.errorPrice}">
                    <p>${sessionScope.errorPrice}</p>
                </c:if>
                <input type="text" id="Price" name="Price" >

                <label for="Quantity">Quantity</label>
                <c:if test="${not empty sessionScope.errorQuantity}">
                    <p>${sessionScope.errorQuantity}</p>
                </c:if>
                <input type="text" id="Quantity" name="Quantity" >

                <label for="CategoryID">CategoryID</label>
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
                <input type="submit" value="Insert Book">
            </form>
        </div>
    </body>
</html>


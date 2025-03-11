<%-- 
    Document   : InsertCategory
    Created on : Mar 7, 2025, 2:57:38 PM
    Author     : QuocNDCE181301
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert Category</title>
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
            <h2>Insert Category</h2>
            <form action="addCategory" method="post">
                 <c:set var="c" value="${sessionScope.ID}"/>
                <label for="ID">Category ID</label>
                <input type="text" id="ID" name="ID" value="${c}" readonly>
                <label for="CategoryName">Category Name</label>
                <input type="text" id="CategoryName" name="CategoryName" required>
                <input type="submit" value="Insert Category">
                <c:if test="${not empty sessionScope.error}">
                    <p>${sessionScope.error}</p>
                </c:if>
            </form>
        </div>
    </body>
</html>



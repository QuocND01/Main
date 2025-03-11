<%-- 
    Document   : UpdateCategoryView
    Created on : Mar 11, 2025, 10:35:48 AM
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
            <h2>Update Category</h2>
            <c:set var="c" value="${category}"/>
            <form action="updateCategory" method="post">
                <label for="CategoryID">Category ID</label>
                <input type="text" id="CategoryID" name="CategoryID" value="${c.categoryID}" readonly>

                <label for="CategoryName">Category Name</label>
                <input type="text" id="CategoryName" name="CategoryName" value="${c.categoryName}" required>

                <button type="submit" class="btn-submit">Update Category</button>
                <c:if test="${not empty sessionScope.error}">
                    <p>${sessionScope.error}</p>
                </c:if>
            </form>
        </div>
    </body>
</html>

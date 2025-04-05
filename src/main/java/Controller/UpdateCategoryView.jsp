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
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <title>Update Book</title>
        <style>
            /* Reset CSS */
            body {  
                
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7fc;
                margin: 0;
                padding: 20px;
                color: #555;
            }
            .header {
                position: fixed;
                top: 0;
                left: 250px;
                width: calc(100% - 250px);
                height: 110px;
                background: #e91e63;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
                z-index: 1000;
            }
            .sidebar {

                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                height: 100vh;
                background: #343a40;
                padding-top: 20px;

            }
            .sidebar a {
                display: block;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
            }
            .sidebar a:hover {
                background: #495057;
            }
            .content {
                text-align: center;
                padding: 20px;
                flex: 1;
                color: white;
            }

            .logo img {
                width: 70px;
                height: auto;
                border-radius: 5px;
            }

            .form-container {
                margin-left: 600px;
                margin-top: 200px;
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
            /* Footer */
            .footer {
                background-color: #f8f8f8;
                padding: 20px 0;
                font-size: 14px;
                color: #666;
                text-align: center;
                border-top: 1px solid #e0e0e0;
                margin-top:200px;
            }

            .footer-top {
                margin-bottom: 10px;
            }

            .footer-top p {
                color: #888;
                font-size: 12px;
                margin-bottom: 5px;
            }

            .country-links a {
                color: #007bff;
                margin: 0 5px;
                text-decoration: none;
                font-size: 12px;
            }

            .country-links a:hover {
                text-decoration: underline;
            }

            .footer-middle {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 10px;
            }

            .policy-links a {
                color: #007bff;
                margin: 0 10px;
                text-decoration: none;
                font-size: 14px;
            }

            .policy-links a:hover {
                text-decoration: underline;
            }

            .registration-icons img {
                height: 40px;
                margin: 0 10px;
            }

            .footer-bottom {
                color: #888;
                font-size: 12px;
                line-height: 1.5;
            }

            .footer-bottom a {
                color: #007bff;
                text-decoration: none;
            }

            .footer-bottom a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <c:set var="role" value="${sessionScope.role}" />
    <div class="sidebar" id="mySidebar">
        <div class="logo">
            <a href="viewBookAdminController">
                <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo" height="40">
            </a>
        </div>
        <a href="view-new-order">All Orders</a>
        <a href="ManageCustomersController">Manage Customers</a>
        <a href="VoucherController">Manage Vouchers</a>
        <a href="DeliveryunitController">Manage Delivery Units</a>
        <a href="viewCategory">Categories</a>
        <a href="WarehouseController">View Warehouse</a>
        <a href="AuthorController">View Authors</a>
        <c:if test="${role == 'Admin'}">
            <a href="viewstaff">All Staff</a>
            <a href="InsertBookView.jsp">Insert Book</a>
        </c:if>

        <a href="logout" class="btn btn-danger w-100">Logout</a>

    </div>

    <!-- Header -->
    <div class="header">

        <div class="content">
            <h1>Dashboard</h1>           
        </div>
        </div>
        <body>
            <div class="form-container">
                <h2>Update Category</h2>
                <c:set var="c" value="${category}"/>
                <form action="updateCategory" method="post">
                    <label for="CategoryID">Category ID</label>
                    <input type="text" id="CategoryID" name="CategoryID" value="${c.categoryID}" readonly>

                    <label for="CategoryName">Category Name</label>
                    <input type="text" id="CategoryName" name="CategoryName" value="${c.categoryName}" required>

                    <label for="CategoryDescription">Category Description</label>
                    <input type="text" id="CategoryDescription" name="CategoryDescription" value="${c.categoryDescription}" required>

                    <button type="submit" class="btn-submit">Update Category</button>
                    <c:if test="${not empty sessionScope.error}">
                        <p>${sessionScope.error}</p>
                    </c:if>
                </form>
            </div>
        </body>
        <div class="footer">
                    <div class="footer-top">
                        <p>© 2024 FPT Book Store. All rights reserved.</p>
                        <div class="country-links">
                            <a href="#">Singapore</a> | <a href="#">Indonesia</a> | <a href="#">Thailand</a> | 
                            <a href="#">Malaysia</a> | <a href="#">Vietnam</a> | <a href="#">Philippines</a> | 
                            <a href="#">Brazil</a> | <a href="#">Mexico</a> | <a href="#">Colombia</a> | 
                            <a href="#">Chile</a> | <a href="#">Taiwan</a>
                        </div>
                    </div>
                    <div class="footer-middle">
                        <div class="policy-links">
                            <a href="#">Privacy Policy</a> | 
                            <a href="#">Terms of Service</a> | 
                            <a href="#">Shipping Policy</a> | 
                            <a href="#">Return and Refund Policy</a>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>Address: Area 6, An Binh Ward, Ninh Kieu District, Can Tho City, Can Tho 920000, Can Tho.</p>
                        <p>Support Hotline: 0947791848 - Email: <a href="mailto:KhanhLNCE181093@fpt.edu.vn">KhanhLNCE181093@fpt.edu.vn</a></p>
                        <p>Business Registration Number: 0106773786 issued by Group 4 SE1807 on February 10, 2024.</p>
                    </div>
                </div>
</html>

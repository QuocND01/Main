<%-- 
    Document   : ViewWarehouse
    Created on : Mar 30, 2025, 2:10:55 PM
    Author     : Tran Phuc Vinh - CE182381
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            /* Custom Styling */
            body {
                display: flex;
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

            .content {
                margin-left: 250px;
                margin-top: 60px;
                padding: 20px;
                flex: 1;
                color: white;
            }

            .logo img {
                width: 70px;
                height: auto;
                border-radius: 5px;
            }





            .container {
                left: 250px;
                background-color: #fff;
                padding: 5px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 3000px;
                margin-top: 10px;
                margin: 250px;
                margin-right: 10px;
            }
            h1 {
                text-align: center;
                color: white;
                margin-bottom: 30px;
                font-size: 36px;
                font-weight: bold;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
            }
            table th, table td {
                padding: 12px 15px;
                text-align: center;
                font-size: 14px;
                border-bottom: 1px solid #e0e0e0;
            }
            table thead th {
                background-color: #3c40c6;
                color: #fff;
                text-transform: uppercase;
            }

            .table {
                width: 100%;
                table-layout: fixed;
            }
            .btn-restock {
                background-color: #007bff; /* Màu nền xanh dương */
                color: #fff; /* Màu chữ trắng */
                padding: 12px 30px; /* Khoảng cách trong nút */
                border-radius: 30px; /* Đường viền tròn */
                text-decoration: none; /* Loại bỏ gạch chân */
                font-size: 16px; /* Cỡ chữ */
                font-weight: bold; /* Làm chữ đậm */
                margin-bottom: 20px;
                display: inline-block;
                text-align: center;
                box-shadow: 0 4px 6px rgba(0, 123, 255, 0.3); /* Đổ bóng nhẹ */
                transition: background-color 0.3s, transform 0.2s; /* Hiệu ứng thay đổi màu nền và phóng to khi hover */
            }

            .btn-restock:hover {
                background-color: #0056b3; /* Màu nền khi hover */
                transform: translateY(-2px); /* Đẩy nút lên khi hover */
            }

            .btn-restock:active {
                background-color: #004085; /* Màu nền khi nhấn */
                transform: translateY(1px); /* Nhấn xuống khi click */
            }


        </style>
    </head>
    <body>
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
            <a href="ViewWarehouseController">View Warehouse</a>
            <a href="AuthorController">View Authors</a>
            <a href="WarehouseController" method="get">View Warehouse</a>

            <a href="logout" class="btn btn-danger w-100">Logout</a>
            <c:if test="${role == 'Admin'}">
                <a href="viewstaff">All Staff</a>
                <a href="InsertBookView.jsp">Insert Book</a>
            </c:if>
        </div>

        <!-- Header -->
        <div class="header">

            <div class="content">
                <h1>Dashboard</h1>           
            </div>
            <form class="d-flex" method="get" action="searchBookAdmin">
                <input type="text" class="form-control me-2" placeholder="Enter to search" name="search">
                <button class="btn btn-light" type="submit">Search</button>
            </form>
        </div>
        <div class="container mt-4">
            <h2 class="text-center">Warehouse List</h2>
            <button class="btn btn-restock" onclick="window.location.href='RestockWarehouse.jsp'">New Restock</button>

            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>

                        <th>Supplier Name</th>
                        <th>Import Date</th>
                        <th>Total Cost</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="w" items="${warehouseList}">
                        <tr>

                            <td>${w.supplierName}</td>
                            <td>${w.importDate}</td>
                            <td><fmt:formatNumber value="${w.totalCost}" type="number" groupingUsed="true" /></td>
                            <td>
                                <a href="WarehouseDetailsController?stockID=${w.stockID}" class="btn btn-info btn-sm">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </body>
</html>

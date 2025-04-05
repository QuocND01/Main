<%-- 
    Document   : ViewCategory
    Created on : Mar 7, 2025, 2:34:52 PM
    Author     : QuocNDCE181301
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <style>
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
            color: white;
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

        /* Header Styling */
        h1 {
            text-align: center;
            color: white; /* Pink accent color */
            font-weight: 700;
            margin-bottom: 30px;
        }

        /* Back Button */
        .btn-back {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #8CC103; /* Green background */
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }

        .btn-back:hover {
            background-color: #76a303; /* Darker green on hover */
            transform: translateY(-3px); /* Lift effect on hover */
        }

        /* Table Styling */
        .table {
            margin-left: 226px;
            width: max-content;
            border-collapse: collapse;
            background-color: #ffffff; /* White background */
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Soft shadow */
            overflow: hidden;
        }

        thead {
            background-color: #e91e63; /* Pink header background */
            color: #fff; /* White text for header */
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #f0f0f0; /* Light border between rows */
        }

        th {
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
        }

        td {
            font-size: 14px;
            color: #555;
        }

        /* Hover Effect for Table Rows */
        tbody tr:hover {
            background-color: #f1f1f1; /* Light gray background on hover */
        }

        /* Button Styling */
        .btn {
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        .btn-delete {
            background-color: #ff4757; /* Red background */
            color: #fff;
        }

        .btn-delete:hover {
            background-color: #e84118; /* Darker red on hover */
            transform: translateY(-3px); /* Lift effect on hover */
        }

        .btn-detail {
            background-color: #3498db; /* Blue background */
            color: #fff;
        }
        .btn-detail:hover{
            background-color: #2980b9;
            transform: translateY(-3px);
        }


        .btn-update {
            background-color: #f39c12; /* Orange */
            color: #fff;
        }
        .btn-update:hover {
            background-color: #e67e22;
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            th, td {
                font-size: 12px; /* Smaller font size on mobile */
            }

            .btn-back {
                padding: 8px 16px; /* Smaller button on mobile */
            }
        }
        .search-container {
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 20px; /* Bo góc tròn */
            background-color: #ff69b4; /* Màu nền của thanh tìm kiếm */
            box-shadow: 4px 4px 10px #d4554c, -4px -4px 10px #ffffff; /* Hiệu ứng nổi nhẹ hơn Hiệu ứng nổi (neumorphism) */
            max-width: 300px; /* Độ rộng tối đa của thanh */
            margin: 20px auto; /* Căn giữa với khoảng cách phía trên */
            color: #FFFFFF;

        }
        /* Style for the search input placeholder */
        .search-container input::placeholder {
            color: white; /* Change placeholder text to white */
            opacity: 1;   /* Make sure the color is fully visible */
        }

        .search-container input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 16px;
            color: #FFFFFF; /* Màu chữ nhạt */
            flex: 1;
            padding: 5px;
            margin-left: 10px;
            font-weight: bold;
            font-weight: 700;
        }

        .search-container button {
            background-color: #ff69b4; /* Màu hồng đậm cho nút tìm kiếm */
            background: none;
            border: none;
            cursor: pointer;
            color: #FFFFFF;
            font-size: 20px;
            outline: none;
        }

        .search-container button:hover {
            background-color: #ff1493; /* Màu hồng đậm hơn khi hover */
        }

        

        .btn-add {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db; /* Màu xanh */
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }

        .btn-add:hover {
            background-color: #2980b9; /* Màu xanh đậm hơn khi hover */
            transform: translateY(-3px);
        }

        .add-category-container {
            
            margin-top: 10px;
            margin-bottom: 10px;
            margin-left: 250px; /* Tạo khoảng cách với bảng */
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
    <body>
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
                <h1>Category Management</h1>           
            </div>

        </div>




        <div class="content">

        </div>
        <div class="add-category-container">
            <a href="addCategory" class="btn-add">Add Category</a>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>

                    <th>Category ID</th>
                    <th>Category Name</th>
                    <th>Category Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${category}">

                    <tr>
                        <td>${c.categoryID}</td>
                        <td>${c.categoryName}</td>
                        <td>${c.categoryDescription}</td>
                        <td class="actions">
                            <a class="btn btn-update" href="updateCategory?categoryID=${c.categoryID}">Update</a>
                            <a class="btn btn-delete" href="deleteCategory?categoryID=${c.categoryID}">Delete</a>
                        </td>
                    </tr>


                </c:forEach>
            </tbody>
        </table>
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


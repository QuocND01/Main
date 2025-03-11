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
        <title>JSP Page</title>
    </head>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', Arial, sans-serif;
        }

        body {
            background-color: #f9f9f9; /* Light background */
            color: #333;
            padding: 20px;
            line-height: 1.6;
        }

        /* Header Styling */
        h1 {
            text-align: center;
            color: #e91e63; /* Pink accent color */
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
            width: 100%;
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

        .btn-add {
            display: inline-block;
            margin: 10px 20px 20px 2000px;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn-add:hover {
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
            
            .logo img {
                width: 120px;
                height: auto;
                border-radius: 5px;
            }
    </style>
    <body>
        <div class="logo">
                <a href="viewBookAdminController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>
        <form method="get" action="searchCategory">
                <div class="search-container">
                    <input type="text" placeholder="Enter to search" name="search">
                    <button><i class="fa fa-search"></i></button>
                </div>
            </form>

        <div class="content">
            <h1>Categories List</h1>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Category ID</th>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${category}">
                    <c:if test="${c.status != 'Unactive'}">
                        <tr>
                            <td>${c.categoryID}</td>
                            <td>${c.categoryName}</td>
                            <td class="actions">
                                <a class="btn btn-update" href="updateCategory?categoryID=${c.categoryID}">Update</a>
                                <a class="btn btn-delete" href="deleteCategory?categoryID=${c.categoryID}">Delete</a>
                            </td>
                        </tr>
                    </c:if>

                </c:forEach>
            </tbody>
        </table>
    </body>
</html>


<%-- 
    Document   : ViewBookDetailCustomer
    Created on : Feb 21, 2025, 4:03:20 PM
    Author     : QuocNDCE181301
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book Detail - Modern Design</title>
        <style>
            /* Reset Styling */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f9f9fb; /* Light background for a clean look */
                color: #333;
                line-height: 1.6;
                padding: 20px;
                overflow-x: hidden;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Header Styling */
            .header {
                position: relative;
                width: 100%;
                height: 200px; /* Adjust height as needed */
                overflow: hidden;
            }
            .header video {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                min-width: 100%;
                min-height: 100%;
                width: auto;
                height: auto;
                z-index: -1;
                object-fit: cover; /* Ensure the video covers the header area */
            }

            .header-content {
                position: relative;
                z-index: 1;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 30px;
                color: white;
            }
            .logo img {
                width: 150px;
                border-radius: 5px;
            }

            .back-button {
                background-color: #ff6f91; /* Soft pink for the button */
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                text-transform: uppercase;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
            }

            .back-button:hover {
                background-color: #ff3f71; /* Darker pink on hover */
                transform: translateY(-3px);
            }

            /* Card Styling */
            .card {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                display: flex;
                flex-direction: row;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
            }

            .img-big-wrap {
                flex: 1;
                text-align: center;
                padding: 20px;
            }

            .img-big-wrap img {
                width: 100%;
                max-width: 400px;
                border-radius: 10px;
            }

            .card-body {
                flex: 1.5;
                padding: 30px;
            }

            .title {
                font-size: 30px;
                color: #222;
                margin-bottom: 15px;
            }

            .price {
                font-size: 26px;
                font-weight: bold;
                color: #e60000; /* Red color for the price */
                margin: 10px 0;
            }
            .cate{
                color: #000; /* Black color for description */
                font-size: 16px;
                line-height: 1.6;
            }

            .stock {
                font-size: 16px;
                color: #28a745; /* Green color for stock */
                font-weight: bold;
                margin-bottom: 15px;
            }

            .item-property dt {
                font-weight: bold;
                color: #444;
                margin-top: 10px;
            }

            .item-property dd p {
                color: #000; /* Black color for description */
                font-size: 16px;
                line-height: 1.6;
            }

            /* CSS cho trường số lượng (Quantity) */
            .quantity-input {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ddd;
                width: 80px; /* Tăng độ rộng */
                text-align: center; /* Căn giữa số lượng */
                font-size: 14px;
                margin-right: 15px; /* Khoảng cách giữa input và nút */
                transition: border-color 0.3s;
            }

            .quantity-input:focus {
                border-color: #ff6f91; /* Đổi màu viền khi focus */
                outline: none;
            }

            /* CSS cho nút Add to Cart */
            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background-color: #ff6f91; /* Màu nền nút hồng */
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 8px;
                font-size: 16px;
                text-transform: uppercase;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                font-weight: bold;
            }

            .btn i {
                margin-right: 8px; /* Khoảng cách giữa icon và text */
            }

            .btn:hover {
                background-color: #ff3f71; /* Màu hồng đậm khi hover */
                transform: translateY(-3px); /* Hiệu ứng di chuyển lên khi hover */
            }

            /* Footer */
            .footer {
                background-color: #f8f8f8;
                padding: 20px 0;
                font-size: 14px;
                color: #666;
                text-align: center;
                border-top: 1px solid #e0e0e0;
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
            
            .buy-group{
                margin-top: 350px;
            }
        </style>
    </head>
    <body>

        <!-- Header Section with Video -->
        <div class="header">
            <video autoplay muted loop>
                <source src="<c:url value='/vid/vid_2.mp4'/>" type="video/mp4">
                Your browser does not support the video tag.
            </video>
            <div class="header-content">
                <div class="logo">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Book Store Logo">
                </div>
                <button class="back-button" onclick="history.back()">Back</button>
            </div>
        </div>

        <!-- Book Detail Section -->
        <div class="container">
            <div class="card">
                <div class="img-big-wrap">
                    <a href="#"><img src="${detailBook.image}" alt="${detailBook.bookName}"></a>
                </div>
                <div class="card-body">
                    <h1 class="title">${detailBook.bookName}</h1>
                    <p class="price">US $${detailBook.price}</p>
                     <c:forEach items="${author}" var="a">
                                <c:if test = "${a.authorID == detailBook.authorID}">
                                    <p>Author: ${a.authorName}</p>
                                </c:if>
                            </c:forEach>
                    <c:forEach items="${cata}" var="c">
                                <c:if test = "${c.categoryID == detailBook.categoryID}">
                                    <p>Category: ${c.categoryName}</p>
                                </c:if>
                            </c:forEach>
                    <p class="stock">In Stock: ${detailBook.quantity}</p>
                    <dl class="item-property">
                        <dt>Description</dt>
                        <dd><p>${detailBook.describe}</p></dd>
                    </dl>
                    
                    <!-- Form to Add to Cart with Quantity -->
                    <div class="buy-group">
                        <hr>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="bookId" value="${detailBook.bookID}">

                        <!-- Input số lượng (Quantity) -->
                        <label for="quantity" style="font-weight: bold;">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1" max="${detailBook.quantity}" class="quantity-input">

                        <!-- Nút Add to Cart với biểu tượng giỏ hàng -->
                        <button type="submit" class="btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                    </form>
                    </div>
                    
                </div>
            </div>
        </div>

        <!-- Footer Section -->
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

        <!-- Font Awesome for Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    </body>
</html>


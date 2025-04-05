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
            a {
                text-decoration: none;
                color: #007bff;
                transition: color 0.3s;
            }
            a:hover {
                color: #0056b3;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Header */
            .header {
                background-image: url('<c:url value="/img/header_img2.jpg"/>');
                background-size: cover;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                padding: 5px 15px;
                height: 75px; /* Fixed height as requested */
                display: flex;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .logo{
                height: 75px;
                width: 75px;
            }
            .logo img {
                height: 100%;
                width: 100%;
            }
            .logsign {
                margin-left: auto;
                display: flex;
                gap: 20px;
            }

            .logsign a {
                padding: 8px 16px;
                font-size: 20px;
                font-weight: bold;
                font-weight: 900;
                color: #77CCFF;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
            }

            .logsign a:hover {
                background-color: #ff1493;
                transform: translateY(-3px);
                box-shadow: 0 8px 15px rgba(255, 20, 147, 0.4);
            }

            /* User dropdown menu */
            .user-dropdown {
                position: relative;
                display: inline-block;
            }

            .user-dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: #f9f9f9;
                min-width: 180px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                border-radius: 5px;
            }

            .user-dropdown-content a {
                display: block;
                padding: 8px 16px;
                font-size: 20px;
                font-weight: bold;
                font-weight: 900;
                color: #77CCFF;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
            }

            .user-dropdown-content a:hover {
                background-color: #ff1493;
                transform: translateY(-3px);
                box-shadow: 0 8px 15px rgba(255, 20, 147, 0.4);
            }

            .user-dropdown:hover .user-dropdown-content {
                display: block;
            }

            .user-icon {
                display: flex;
                align-items: center;
                gap: 5px;
                cursor: pointer;
            }

            .user-icon i {
                font-size: 20px;
            }

            body {
                padding-top: 75px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f9f9fb;
                color: #333;
                line-height: 1.6;
                overflow-x: hidden;
            }

            .container {
                max-width: 1200px;
                margin: auto;
            }

            /* Card Styling */
            .card {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                display: flex;
                flex-direction: row;
                margin-bottom: 40px;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
            }

            /* Book Image Section */
            .img-big-wrap {
                flex: 1;
                text-align: center;
                padding: 30px;
                display: flex;
                align-items: start;
                justify-content: center;
                background-color: #fafafa;
            }

            .img-big-wrap img {
                width: 100%;
                max-width: 350px;
                height: auto;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s;
            }

            .img-big-wrap img:hover {
                transform: scale(1.03);
            }

            /* Book Details Section */
            .card-body {
                flex: 1.5;
                padding: 40px;
                padding-top: 10px;
                display: flex;
                flex-direction: column;
            }

            .title {
                font-size: 28px;
                color: #222;
                margin-bottom: 15px;
                font-weight: 700;
                line-height: 1.3;
            }

            .price {
                font-size: 24px;
                font-weight: bold;
                color: #e60000;
                margin: 10px 0 15px 0;
            }

            .card-body p {
                margin-bottom: 10px;
                font-size: 16px;
                color: #444;
            }

            .stock {
                font-size: 16px;
                color: #28a745;
                font-weight: bold;
                padding: 5px 0;
                border-bottom: 1px solid #eee;
            }

            .item-property dt {
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
                font-size: 18px;
            }

            .item-property dd p {
                color: #555;
                font-size: 16px;
                line-height: 1.7;
                margin-bottom: 15px;
            }

            /* Buy Group Section */
            .buy-group {
                margin-top: 10px;
                border-top: 1px solid #eee;
            }

            /* Cart Messages */
            .in-cart-message {
                color: #28a745;
                font-weight: bold;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
            }

            .in-cart-message i {
                margin-right: 8px;
                font-size: 18px;
            }

            /* Buttons */
            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background-color: #ff6f91;
                color: white;
                border: none;
                padding: 14px 24px;
                border-radius: 8px;
                font-size: 16px;
                text-transform: uppercase;
                text-decoration: none;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: bold;
                letter-spacing: 0.5px;
            }

            .btn i {
                margin-right: 10px;
                font-size: 18px;
            }

            .btn:hover {
                background-color: #ff3f71;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(255, 111, 145, 0.4);
            }

            .view-cart-btn {
                background-color: #17a2b8;
                padding: 14px 24px;
                transition: all 0.3s ease;
            }

            .view-cart-btn:hover {
                background-color: #138496;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(23, 162, 184, 0.4);
                text-decoration: none;
                color: white;
            }

            /* Cart Notification */
            .cart-notification {
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: #4CAF50;
                color: white;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
                font-size: 16px;
                z-index: 1000;
                animation: fadeInOut 3s;
                display: flex;
                align-items: center;
            }

            .cart-notification.error {
                background: #f44336;
            }

            @keyframes fadeInOut {
                0% {
                    opacity: 0;
                    transform: translateY(20px);
                }
                10% {
                    opacity: 1;
                    transform: translateY(0);
                }
                90% {
                    opacity: 1;
                }
                100% {
                    opacity: 0;
                    transform: translateY(20px);
                }
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .card {
                    flex-direction: column;
                }

                .img-big-wrap {
                    padding: 20px;
                }

                .card-body {
                    padding: 25px;
                }

                .buy-group {
                    margin-top: 20px;
                }
            }

            /* --- FEEDBACK SECTION --- */
            .feedback-section {
                margin-top: 40px;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            }

            .feedback-item {
                border-bottom: 1px solid #ddd;
                padding: 15px 0;
                transition: background-color 0.3s;
            }

            .feedback-item:hover {
                background-color: #f1f1f1;
            }

            .customer-name {
                font-weight: bold;
                font-size: 16px;
                color: #222;
            }

            .stars {
                color: #FFD700;
                font-size: 18px;
            }

            .stars .active {
                color: #ffcc00; /* Vàng cho sao đã chọn */
            }

            .stars .inactive {
                color: #ccc; /* Xám cho sao chưa chọn */
            }

            .feedback-content {
                margin-top: 5px;
                font-size: 14px;
                color: #444;
            }

            /* Footer */
            .footer {
                background-color: #f8f8f8;
                padding: 20px 0;
                font-size: 14px;
                color: #666;
                text-align: center;
                border-top: 1px solid #e0e0e0;
                margin-top: 40px;
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
            .book-inline-details {
                flex-wrap: wrap;
                gap: 15px;
                border-bottom: 1px solid #eee;
            }

            .book-inline-details .detail-item {
                display: flex;
                align-items: center;
                padding: 5px;
            }

            .book-inline-details .detail-label {
                font-weight: bold;
                color: #333;
                margin-right: 5px;
            }

            .book-inline-details .detail-value {
                color: #555;
            }
        </style>
    </head>
    <body>
        <!-- Header Section -->
        <div class="header">
            <div class="logo">
                <a href="ViewBookCustomerController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>

            <!-- Check login status -->
            <% if (session.getAttribute("account") != null) { %>
            <!-- Display when user is logged in -->
            <div class="logsign">
                <!-- Cart Icon -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="CartController"><i class="fas fa-shopping-cart"></i></a>
                    </div>
                </div>

                <!-- Orders Icon -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="OrderController"><i class="fas fa-box"></i></a>
                    </div>
                </div>

                <!-- User Account Dropdown -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="#"><i class="fas fa-user-circle"></i></a>
                    </div>
                    <div class="user-dropdown-content">
                        <a href="ManageAccountController">My Account</a>
                        <a href="logout">Logout</a>
                    </div>
                </div>
            </div>
            <% } else { %>
            <!-- Display when user is not logged in -->
            <div class="logsign">
                <a href="./LoginForm.jsp" class="login">Log in</a>
                <a href="./RegisterPage.jsp" class="signin">Sign up</a>
            </div>
            <% } %>
        </div>

        <!-- Book Detail Section -->
        <div class="container">
            <div class="card">
                <div class="img-big-wrap">
                    <a href="#"><img src="${book.image}" alt="${book.bookName}"></a>
                </div>
                <div class="card-body">
                    <h1 class="title">${book.bookName}</h1>
                    <p class="price">US $${book.bookPrice}</p>

                    <!-- Display author name -->
                    <c:forEach items="${authors}" var="author">
                        <c:if test="${author.authorID == book.authorID}">
                            <p>Author: ${author.authorName}</p>
                        </c:if>
                    </c:forEach>

                    <!-- Display category name -->
                    <c:forEach items="${categories}" var="category">
                        <c:if test="${category.categoryID == book.categoryID}">
                            <p>Category: ${category.categoryName}</p>
                        </c:if>
                    </c:forEach>

                    <p class="stock">In Stock: ${book.bookQuantity}</p>

                    <!-- Book details -->
                    <dl class="item-property">
                        <dt>Description</dt>
                        <dd><p>${book.bookDescribe}</p></dd>
                    </dl>

                    <!-- Inline book details -->
                    <div class="book-inline-details">
                        <div class="detail-item">
                            <span class="detail-label">Publication Year:</span>
                            <span class="detail-value">${book.yearOfPublication}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Pages:</span>
                            <span class="detail-value">${book.numberOfPages}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Weight:</span>
                            <span class="detail-value">${book.weight} g</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Size:</span>
                            <span class="detail-value">${book.size}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Format:</span>
                            <span class="detail-value">${book.form}</span>
                        </div>
                    </div>

                    <!-- Add to Cart Button -->
                    <div class="buy-group">
                        <c:choose>
                            <c:when test="${isInCart == true}">
                                <p class="in-cart-message"><i class="fas fa-check-circle"></i> This book is already in your cart</p>
                                <a href="${pageContext.request.contextPath}/Cart.jsp" class="btn view-cart-btn">
                                    <i class="fas fa-shopping-cart"></i> View Cart
                                </a>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn" onclick="addToCart('${book.bookID}')">
                                    <i class="fas fa-shopping-cart"></i> Add to Cart
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>       
                </div>
            </div>
        </div>

        <!-- Feedback Section -->
        <div class="container">
            <div class="feedback-section">
                <h2>Customer Feedback</h2>

                <c:choose>
                    <c:when test="${empty feedbackList}">
                        <p>No feedback available for this book.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="feedback" items="${feedbackList}">
                            <div class="feedback-item">
                                <p class="customer-name">Customer Name: ${feedback.customerName}</p>

                                <!-- Display star rating -->
                                <div class="stars">
                                    <c:forEach var="i" begin="1" end="5">
                                        <i class="fas fa-star ${i <= feedback.star ? 'active' : 'inactive'}"></i>
                                    </c:forEach>
                                </div>

                                <p class="feedback-content">${feedback.feedbackDetail}</p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
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

        <!-- JavaScript for cart functionality -->
        <script>
            // Cart notification function
            function showNotification(message) {
                let notification = document.createElement("div");
                notification.className = "cart-notification";

                // Add error class for error messages
                if (message.includes("❌") || message.includes("Error") || message.includes("Lỗi")) {
                    notification.classList.add("error");
                }

                notification.innerText = message;
                document.body.appendChild(notification);

                // Remove after animation completes
                setTimeout(() => {
                    notification.remove();
                }, 5000);
            }

            // Add to cart function
            function addToCart(bookID) {
                fetch("CartController", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                    },
                    body: "action=add&bookId=" + encodeURIComponent(bookID),
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                if (data.isInCart) {
                                    showNotification("ℹ️ Product is already in your cart.");
                                } else {
                                    showNotification("✔ Product has been added to cart!");
                                    setTimeout(() => {
                                        location.reload();
                                    }, 3000);
                                }
                            } else {
                                showNotification("❌ Error: " + data.message);
                            }
                        })
                        .catch(error => {
                            console.error("Error:", error);
                            showNotification("❌ Connection error!");
                        });
            }

            // Check for cart message on page load
            document.addEventListener('DOMContentLoaded', function () {
            <% if (session.getAttribute("cartMessage") != null) {%>
                showNotification("<%= session.getAttribute("cartMessage")%>");
            <% session.removeAttribute("cartMessage"); %>
            <% }%>
            });
        </script>
    </body>
</html>


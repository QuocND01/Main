<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Customer Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Arial, sans-serif;
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
                background-color: #f0f2f5;
                color: var(--dark);
                line-height: 1.6;
            }

            .card {
                max-width: 600px;
                margin: auto;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            .notification {
                position: fixed;
                top: 15px;
                right: 15px;
                z-index: 1050;
                padding: 15px;
                border-radius: 5px;
                font-size: 16px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                min-width: 300px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                transition: opacity 0.5s ease-in-out;
            }

            .notification.success {
                background-color: #28a745;
                color: white;
            }

            .notification.error {
                background-color: #dc3545;
                color: white;
            }

            .notification .close-btn {
                background: none;
                border: none;
                color: white;
                font-size: 18px;
                cursor: pointer;
                margin-left: 10px;
            }

            .form-control[readonly] {
                background-color: #e9ecef;
            }

            .btn {
                width: 100%;
            }

            .btn-group {
                display: flex;
                gap: 10px;
            }

        </style>
        <script>
            function toggleEditMode(enable) {
                document.querySelectorAll(".form-control").forEach(input => {
                    if (input.name !== "CustomerID" && input.name !== "Username" && input.name !== "Status") {
                        input.readOnly = !enable;
                    }
                });
                document.getElementById("editBtn").style.display = enable ? "none" : "block";
                document.getElementById("updateBtn").style.display = enable ? "block" : "none";
                document.getElementById("cancelBtn").style.display = enable ? "block" : "none";
            }

            function closeNotification() {
                let notification = document.getElementById('notification');
                notification.style.opacity = '0';
                setTimeout(() => {
                    notification.style.display = 'none';
                }, 500);
            }
        </script>
    </head>
    <body class="container mt-5">
        
        <!-- Header Section -->
        <div class="header">
            <div class="logo">
                <a href="ViewBookCustomerController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>
            <form method="post" class="logsign">
                <!-- Cart Dropdown -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="CartController"><i class="fas fa-shopping-cart"></i></a>
                    </div>
                </div>

                <!-- Orders Dropdown -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="OrderController"><i class="fas fa-box"></i></a>
                    </div>
                </div>

                <!-- User Account Dropdown (unchanged) -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="#"><i class="fas fa-user-circle"></i></a>
                    </div>
                    <div class="user-dropdown-content">
                        <a href="ManageAccountController">My Account</a>
                        <a href="logout">Logout</a>
                    </div>
                </div>
            </form>
        </div>
                
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) {%>
        <div id="notification" class="notification success">
            <span><%= message%></span>
            <button class="close-btn" onclick="closeNotification()">×</button>
        </div>
        <% }%>

        <div class="card p-4">
            <h3 class="text-center mb-3">Customer Profile</h3>

            <c:choose>
                <c:when test="${not empty customer}">
                    <form action="UpdateCusProfile" method="post">
                        <input type="hidden" name="CustomerID" value="${customer.customerID}">
                        <input type="hidden" name="Status" value="${customer.status}">

                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="CustomerName" value="${customer.customerName}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="CustomerEmail" value="${customer.customerEmail}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" class="form-control" name="CustomerPNB" value="${customer.customerPNB}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" class="form-control" name="CustomerAddress" value="${customer.customerAddress}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="Username" value="${customer.username}" readonly>
                        </div>

                        <div class="btn-group mt-3">
                            <button type="button" id="editBtn" class="btn btn-primary" onclick="toggleEditMode(true)">Edit</button>
                            <button type="submit" id="updateBtn" class="btn btn-success" style="display: none;">Update</button>
                            <button type="button" id="cancelBtn" class="btn btn-secondary" style="display: none;" onclick="toggleEditMode(false)">Cancel</button>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <h4 class="text-center text-danger">Customer not found!</h4>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Order</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            /* Keep the original header styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Header - unchanged as requested */
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
                text-decoration: none;
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

            .user-icon a::after {
                content: attr(title);
                position: absolute;
                bottom: -25px;
                left: 50%;
                transform: translateX(-50%);
                padding: 5px 10px;
                background-color: #333;
                color: white;
                border-radius: 4px;
                font-size: 12px;
                white-space: nowrap;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.3s, visibility 0.3s;
            }

            .user-icon a:hover::after {
                opacity: 1;
                visibility: visible;
            }

            /* Main layout with reduced padding */
            body {
                padding-top: 85px;
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                color: #333;
                line-height: 1.6;
            }

            /* More compact container with reduced gaps */
            .cart-container {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                max-width: 1200px;
                margin: 15px auto;
                padding: 0 10px;
            }

            /* Updated heading styles with main color */
            h2 {
                text-align: center;
                color: #e91e63;
                margin: 15px 0 20px;
                font-size: 28px;
                font-weight: 700;
                position: relative;
                padding-bottom: 10px;
            }

            h2::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background: #e91e63;
                border-radius: 3px;
            }

            h2 i {
                margin-right: 10px;
                color: #e91e63;
            }

            h3 {
                color: #e91e63;
                font-size: 20px;
                padding-bottom: 8px;
                margin-top: 0;
                margin-bottom: 12px;
                border-bottom: 2px solid #f0f0f0;
                position: relative;
            }

            h3::after {
                content: "";
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 50px;
                height: 2px;
                background-color: #e91e63;
            }

            /* More compact card styling */
            .cart-items, .container {
                background-color: #F5F5F5;
                border-radius: 10px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
                padding: 15px;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .cart-items:hover, .container:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .cart-items {
                flex: 2;
                min-width: 300px;
            }

            .container {
                flex: 1;
                min-width: 300px;
            }

            /* Table styling with reduced padding */
            .table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 10px;
                border: none;
                overflow: hidden;
            }

            .table th {
                background-color: #fdf0f5;
                color: #e91e63;
                font-weight: 600;
                padding: 10px 8px;
                text-align: left;
                border: none;
                border-bottom: 2px solid #fce4ec;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .table td {
                padding: 10px 8px;
                border: none;
                border-bottom: 1px solid #fce4ec;
                vertical-align: middle;
            }

            .table tr:last-child td {
                border-bottom: none;
            }

            .table tr:hover {
                background-color: #fdf0f5;
            }

            .table img {
                border: 1px solid #fce4ec;
                border-radius: 6px;
                object-fit: cover;
                transition: transform 0.3s;
                box-shadow: 0 2px 5px rgba(233, 30, 99, 0.1);
            }

            .table img:hover {
                transform: scale(1.1);
            }

            /* Customer information table */
            .customer-table {
                width: 100%;
                margin-bottom: 15px;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(233, 30, 99, 0.05);
            }

            .customer-table th {
                text-align: left;
                width: 40%;
                padding: 10px 12px;
                background-color: #fdf0f5;
                border-bottom: 1px solid #fce4ec;
                color: #e91e63;
                font-weight: 600;
            }

            .customer-table td {
                padding: 10px 12px;
                border-bottom: 1px solid #fce4ec;
                color: #333;
            }

            .customer-table tr:last-child th,
            .customer-table tr:last-child td {
                border-bottom: none;
            }

            /* Delivery table */
            .delivery-table {
                width: 100%;
                margin: 10px 0;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(233, 30, 99, 0.05);
            }

            .delivery-table th {
                text-align: left;
                width: 40%;
                padding: 10px 12px;
                background-color: #fdf0f5;
                border-bottom: 1px solid #fce4ec;
                color: #e91e63;
                font-weight: 600;
            }

            .delivery-table td {
                padding: 10px 12px;
                border-bottom: 1px solid #fce4ec;
            }

            .delivery-table tr:last-child th,
            .delivery-table tr:last-child td {
                border-bottom: none;
            }

            /* Improved quantity input */
            .quantity-container {
                display: flex;
                justify-content: left;
                align-items: center;
            }

            input[type="number"] {
                width: 60px;
                padding: 8px;
                border: 1px solid #fce4ec;
                border-radius: 5px;
                text-align: center;
                font-size: 14px;
                background-color: #fff;
                color: #333;
                box-shadow: inset 0 1px 3px rgba(233, 30, 99, 0.05);
            }

            /* Enhanced price display */
            .price-summary {
                margin: 15px 0;
                padding: 12px;
                background-color: #fdf0f5;
                border-radius: 8px;
                border-left: 3px solid #e91e63;
            }

            .total-price {
                font-size: 16px;
                font-weight: 500;
                color: #333;
                display: flex;
                justify-content: space-between;
                padding: 3px 0;
            }

            .total-price span {
                font-weight: 700;
                color: #e91e63;
            }

            /* Voucher form */
            .voucher-form {
                display: flex;
                gap: 10px;
                margin: 15px 0;
                padding: 12px;
                background-color: #fdf0f5;
                border-radius: 8px;
                align-items: center;
                flex-wrap: wrap;
                border: 1px solid #fce4ec;
            }

            .voucher-form label {
                font-weight: 600;
                color: #e91e63;
                font-size: 14px;
            }

            .voucher-form input[type="text"] {
                flex: 1;
                padding: 8px 12px;
                border: 1px solid #fce4ec;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .voucher-form input[type="text"]:focus {
                border-color: #e91e63;
                box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
                outline: none;
            }

            .voucher-form button {
                background-color: #e91e63;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.2s;
            }

            .voucher-form button:hover {
                background-color: #c2185b;
                transform: translateY(-2px);
            }

            /* Delivery selection */
            .delivery-selection {
                margin: 15px 0;
            }

            .delivery-selection label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #e91e63;
                font-size: 14px;
            }

            .delivery-selection select {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #fce4ec;
                border-radius: 6px;
                background-color: white;
                margin-bottom: 10px;
                font-size: 14px;
                color: #333;
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23e91e63' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 12px center;
                background-size: 14px;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .delivery-selection select:focus {
                border-color: #e91e63;
                box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
                outline: none;
            }

            .delivery-selection button {
                background-color: #e91e63;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.2s;
                width: 100%;
            }

            .delivery-selection button:hover {
                background-color: #c2185b;
                transform: translateY(-2px);
            }

            /* Button styling */
            .button-container {
                margin: 15px 0;
                text-align: center;
            }

            .order-button {
                background-color: #e91e63;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                font-size: 15px;
                transition: all 0.3s ease;
                width: 100%;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 4px 12px rgba(233, 30, 99, 0.3);
            }

            .order-button:hover {
                background-color: #c2185b;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(233, 30, 99, 0.4);
            }

            .order-button-disabled {
                background-color: #f8bbd0;
                color: #666666;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 15px;
                width: 100%;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                cursor: not-allowed;
            }

            .return-button {
                display: inline-block;
                color: #e91e63;
                text-decoration: none;
                padding: 8px 15px;
                font-weight: 600;
                font-size: 15px;
                transition: color 0.3s;
            }

            .return-button:hover {
                color: #c2185b;
                text-decoration: none;
            }

            .return-button i {
                margin-right: 8px;
            }

            /* Success and error messages */
            .order-success-message {
                background-color: #e8f5e9;
                color: #1b5e20;
                padding: 12px 15px;
                border-radius: 8px;
                text-align: center;
                margin: 15px auto;
                max-width: 800px;
                border-left: 4px solid #4caf50;
                font-weight: 500;
                box-shadow: 0 2px 8px rgba(76, 175, 80, 0.1);
            }

            .error, .error-message {
                background-color: #fdeef1;
                color: #b71c1c;
                padding: 12px 15px;
                border-radius: 8px;
                text-align: center;
                margin: 15px auto;
                max-width: 800px;
                border-left: 4px solid #e91e63;
                font-weight: 500;
                box-shadow: 0 2px 8px rgba(233, 30, 99, 0.1);
            }

            .error-message i, .order-success-message i {
                margin-right: 8px;
                font-size: 16px;
            }

            /* Special link style for book names */
            .table a {
                color: #e91e63;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s, text-decoration 0.3s;
                display: inline-block;
                padding: 2px 0;
                position: relative;
            }

            .table a::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: 0;
                left: 0;
                background-color: #e91e63;
                transition: width 0.3s;
            }

            .table a:hover {
                color: #c2185b;
                text-decoration: none;
            }

            .table a:hover::after {
                width: 100%;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .cart-container {
                    flex-direction: column;
                    padding: 0 8px;
                }

                .cart-items, .container {
                    padding: 12px;
                }

                .table {
                    font-size: 13px;
                }

                .table th, .table td {
                    padding: 8px 4px;
                }

                .button-container button {
                    padding: 10px 15px;
                    font-size: 14px;
                }

                h2 {
                    font-size: 22px;
                    margin: 12px 0 15px;
                }

                h3 {
                    font-size: 16px;
                }

                .voucher-form {
                    padding: 10px;
                }
            }

            @media (max-width: 480px) {
                .table {
                    font-size: 12px;
                }

                .table th, .table td {
                    padding: 6px 3px;
                }

                input[type="number"] {
                    width: 45px;
                    padding: 6px;
                }

                .voucher-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .order-button, .order-button-disabled {
                    padding: 10px 12px;
                    font-size: 13px;
                }
            }

            /* Add smooth animations */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(8px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .cart-items, .container {
                animation: fadeIn 0.4s ease-out;
            }

            /* Hide total column as requested */
            .hidden-column {
                display: none;
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
            <form method="post" class="logsign">
                <!-- Cart Dropdown -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="CartController" title="Your Cart"><i class="fas fa-shopping-cart"></i></a>
                    </div>
                </div>
                <!-- Orders Dropdown -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="OrderController" title="Your Order"><i class="fas fa-box"></i></a>
                    </div>
                </div>

                <!-- User Account Dropdown -->
                <div class="user-dropdown">
                    <div class="user-icon">
                        <a href="#"><i class="fas fa-user-circle"></i></a>
                    </div>
                    <div class="user-dropdown-content">
                        <a href="ProfileController">My Account</a>
                        <a href="logout">Logout</a>
                    </div>
                </div>
            </form>
        </div>

        <h2 style="color: #e91e63"><i class="fas fa-clipboard-list"></i> Create Order</h2>

        <!-- Display messages -->
        <c:if test="${not empty successMessage}">
            <p class="order-success-message">${successMessage}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error-message" style="color: red; text-align: center; font-weight: bold; background-color: #ffe6e6; padding: 10px; margin: 10px 0; border: 1px solid red; border-radius: 5px;">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
            </div>
        </c:if>

        <div class="cart-container">
            <!-- Product list table (left side) -->
            <div class="cart-items">
                <h3 class="cart-header">Product Order</h3>
                <table class="table" border="1">
                    <tr>
                        <th>Image</th>
                        <th>Book Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th class="hidden-column">Total</th>
                    </tr>
                    <c:forEach items="${cartItems}" var="item">
                        <tr>
                            <td><img src="${item.book.image}" alt="Book Image" width="50" height="75"></td>
                            <td>
                                <a href="viewBookDetailCustomerController?BookID=${item.book.bookID}" 
                                   style="text-decoration: none; color: #e91e63; font-weight: 500;">
                                    ${item.book.bookName}
                                </a>
                            </td>
                            <td>
                                <div class="quantity-container">
                                    <input type="number" id="quantity_${item.cart.bookID}" value="${item.cart.cartBookQuantity}" min="1" max="${item.book.bookQuantity}" readonly>
                                </div>
                            </td>
                            <td>${item.book.bookPrice} $</td>
                            <td class="hidden-column"><span id="total_${item.cart.bookID}">${String.format("%.2f", item.totalItemPrice)}</span> $</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="container">
                <h3>Customer Information</h3>

                <table class="customer-table">
                    <tr>
                        <th>Name</th>
                        <td>${customer.customerName}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${customer.customerAddress}</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>${customer.customerPNB}</td>
                    </tr>
                    <tr>
                        <th>Order Date</th>
                        <td>${orderDate}</td>
                    </tr>
                </table>

                <!-- Price summary - always shown for book total -->
                <div class="price-summary">
                    <p class="total-price">Total Price (Books): ${String.format("%.2f", totalPrice)} $</p>
                </div>

                <!-- Voucher form -->
                <form action="CreateOrderController" method="post" class="voucher-form">
                    <label>Enter Voucher:</label>
                    <input type="text" name="voucherCode" value="${voucherCode != null ? voucherCode : ''}">
                    <input type="hidden" name="from" value="samePage">
                    <input type="hidden" name="action" value="applyVoucher">
                    <button type="submit">Apply Voucher</button>
                </form>

                <c:if test="${not empty errorMessageVoucher}">
                    <p class="error" style="color: red;">${errorMessageVoucher}</p>
                </c:if>

                <!-- Display voucher discount only if discount exists -->
                <c:if test="${discount != null && discount > 0}">
                    <div class="price-summary">
                        <p class="total-price">Discount: <span style="float: right;">${discount}%</span></p>
                        <p class="total-price">Price after discount: <span style="float: right;">${String.format("%.2f", totalPriceAfterDiscount)} $</span></p>
                    </div>
                </c:if>

                <!-- Select delivery unit -->
                <form action="CreateOrderController" method="post" id="deliveryForm" class="delivery-form">
                    <div class="delivery-selection">
                        <label>Select Delivery Unit:</label>
                        <select name="unitID" id="unitID" onchange="this.form.submit()">
                            <option value="">Select a delivery unit</option>
                            <c:forEach items="${deliveryUnits}" var="unit">
                                <option value="${unit.unitID}" ${selectedUnit != null && selectedUnit.unitID == unit.unitID ? 'selected' : ''}>
                                    ${unit.unitName} - ${unit.unitSpeed} - ${String.format("%.2f", unit.unitFee)} $
                                </option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="from" value="samePage">
                        <input type="hidden" name="action" value="selectDelivery">
                        <!-- Button removed, form submits automatically when selection changes -->
                    </div>
                </form>

                <!-- Display delivery information only if a unit is selected -->
                <c:if test="${selectedUnit != null}">
                    <div class="delivery-info">
                        <h3>Delivery Information</h3>
                        <table class="delivery-table">
                            <tr>
                                <th>Delivery Unit</th>
                                <td>${selectedUnit.unitName}</td>
                            </tr>
                            <tr>
                                <th>Delivery Speed</th>
                                <td>${selectedUnit.unitSpeed}</td>
                            </tr>
                            <tr>
                                <th>Delivery Fee</th>
                                <td>${selectedUnit.unitFee} $</td>
                            </tr>
                        </table>
                    </div>

                    <!-- Final price summary only shown if delivery unit is selected -->
                    <div class="price-summary">
                        <p class="total-price">Total Price with Delivery: 
                            <span style="float: right; font-weight: bold;">
                                ${String.format("%.2f", totalPriceAfterDiscountAndDelivery)} $
                            </span>
                        </p>
                    </div>
                </c:if>

                <!-- Place order button -->
                <form action="CreateOrderController" method="post" class="order-form">
                    <input type="hidden" name="from" value="samePage">
                    <input type="hidden" name="action" value="finishOrder">
                    <div class="button-container">
                        <c:choose>
                            <c:when test="${selectedUnit != null}">
                                <button type="submit" class="order-button">PLACE ORDER</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" disabled class="order-button-disabled">Please select a Delivery Unit!</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
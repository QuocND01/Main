<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Cart"%>
<%@page import="DAO.CartDAO"%>
<%@page import="DAO.BookDAO"%>
<%@page import="Model.Books"%>

<%
    String customerID = (String) session.getAttribute("customerID");
    if (customerID == null) {
        response.sendRedirect("LoginForm.jsp");
        return;
    }

    CartDAO cartDAO = new CartDAO();
    BookDAO bookDAO = new BookDAO();
    ArrayList<Cart> cartList = cartDAO.getCartByCustomer(customerID);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Cart</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary: #e91e63;
                --secondary: #4361ee;
                --success: #38b000;
                --danger: #d90429;
                --warning: #ffb703;
                --light: #f8f9fa;
                --dark: #212529;
                --gray: #adb5bd;
                --border-radius: 8px;
                --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Arial, sans-serif;
            }

            body {
                background-color: #f0f2f5;
                color: var(--dark);
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 25px;
                position: relative;
            }

            h1, h2 {
                color: var(--primary);
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #eee;
                font-weight: 600;
            }

            h1 {
                text-align: center;
            }

            .logo {
                text-align: left;
                margin-bottom: 20px;
            }

            .logo img {
                max-height: 60px;
            }

            .empty-cart {
                text-align: center;
                padding: 30px;
                color: var(--gray);
                font-size: 18px;
            }

            .cart-container {
                display: flex;
                gap: 20px;
                margin-top: 20px;
            }

            .cart-items {
                flex: 3;
                overflow-x: auto;
            }

            .cart-summary-container {
                flex: 1;
                position: sticky;
                top: 20px;
                align-self: flex-start;
            }

            .cart-summary {
                background-color: white;
                padding: 20px;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 15px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--box-shadow);
            }

            th {
                background-color: var(--primary);
                color: white;
                padding: 15px 20px;
                text-align: left;
                font-weight: 500;
            }

            td {
                padding: 12px 20px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
            }

            tr:last-child td {
                border-bottom: none;
            }

            tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            tr:hover {
                background-color: #e6f2ff;
            }

            img {
                border-radius: 4px;
                object-fit: cover;
            }

            .quantity-container {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .quantity-container button {
                background-color: white;
                color: black;
                border: 1px solid #ddd;
                width: 30px;
                height: 30px;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .quantity-container button:hover {
                background-color: #eee;
                color: black;
            }

            .quantity-container input {
                width: 50px;
                height: 30px;
                text-align: center;
                border: 1px solid #ddd;
                margin: 0 5px;
                border-radius: 4px;
            }

            .total {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
                color: var(--dark);
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 8px;
                width: 100%;
                margin-bottom: 10px;
                text-align: center;
                justify-content: center;
            }

            .create-order {
                background-color: var(--success);
                color: white;
            }

            .create-order:hover {
                background-color: #2d9900;
                transform: translateY(-2px);
                box-shadow: var(--box-shadow);
            }

            .clear-cart {
                background-color: var(--danger);
                color: white;
            }

            .clear-cart:hover {
                background-color: #b10012;
                transform: translateY(-2px);
                box-shadow: var(--box-shadow);
            }

            button {
                padding: 8px 12px;
                border: none;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
            }

            td button {
                background-color: var(--danger);
                color: white;
            }

            td button:hover {
                background-color: #b10012;
            }

            /* Hide total column */
            .hidden {
                display: none;
            }

            /* Overlay and Confirmation Dialog */
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                animation: fadeIn 0.3s;
            }

            .confirm-box {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 25px;
                border-radius: var(--border-radius);
                z-index: 1001;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                text-align: center;
                width: 90%;
                max-width: 400px;
                animation: slideIn 0.3s;
            }

            .confirm-box p {
                margin-bottom: 20px;
                font-size: 16px;
            }

            .confirm-box button {
                padding: 10px 20px;
                margin: 0 10px;
                border-radius: var(--border-radius);
                font-weight: 500;
            }

            .confirm-yes {
                background-color: var(--primary);
                color: white;
            }

            .confirm-yes:hover {
                background-color: var(--secondary);
            }

            .confirm-no {
                background-color: var(--gray);
                color: white;
            }

            .confirm-no:hover {
                background-color: #6c757d;
            }

            /* Notification styles */
            .notification {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border-radius: var(--border-radius);
                z-index: 1001;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                text-align: center;
                width: 90%;
                max-width: 400px;
                animation: slideIn 0.3s;
            }

            .notification-message {
                margin-bottom: 20px;
                font-size: 16px;
            }

            .notification-close {
                padding: 8px 20px;
                background-color: var(--primary);
                color: white;
                border: none;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
            }

            .notification-close:hover {
                background-color: var(--secondary);
            }

            .notification-timer {
                height: 4px;
                background-color: var(--primary);
                margin-top: 15px;
                width: 100%;
                animation: timerAnimation 3s linear forwards;
            }

            .notification-success {
                border-top: 4px solid var(--success);
            }

            .notification-error {
                border-top: 4px solid var(--danger);
            }

            .notification-warning {
                border-top: 4px solid var(--warning);
            }

            .notification-info {
                border-top: 4px solid var(--primary);
            }

            @keyframes timerAnimation {
                from {
                    width: 100%;
                }
                to {
                    width: 0%;
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    transform: translate(-50%, -60%);
                    opacity: 0;
                }
                to {
                    transform: translate(-50%, -50%);
                    opacity: 1;
                }
            }

            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                .container {
                    padding: 15px;
                }

                .cart-container {
                    flex-direction: column;
                }

                .cart-summary-container {
                    position: static;
                    width: 100%;
                }

                td, th {
                    padding: 10px 15px;
                }

                .quantity-container {
                    flex-wrap: nowrap;
                }

                .quantity-container input {
                    width: 40px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1><i class="fas fa-shopping-cart"></i> Your Shopping Cart</h1>


            <% if (cartList == null || cartList.isEmpty()) { %>
            <div class="empty-cart">
                <i class="fas fa-shopping-cart" style="font-size: 48px; margin-bottom: 15px; color: var(--gray);"></i>
                <p>Your cart is empty!</p>
                <a href="ViewBookCustomerController" class="btn create-order" style="max-width: 200px; margin: 20px auto; display: block;">
                    <i class="fas fa-book"></i> Browse Books
                </a>
            </div>
            <% } else { %>
            <div class="cart-container">
                <!-- Cart items table (left) -->
                <div class="cart-items">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Book Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th class="hidden">Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    double totalPrice = 0;
                                    for (Cart cart : cartList) {
                                        Books book = bookDAO.getBookByBookID(cart.getBookID());
                                        double totalItemPrice = Double.parseDouble(book.getPrice()) * cart.getQuantity();
                                        totalPrice += totalItemPrice;
                                %>
                                <tr>
                                    <td><img src="<%= book.getImage()%>" alt="Book Image" width="50" height="75"></td>
                                    <td>
                                        <a href="viewBookDetailCustomerController?bookId=<%= book.getBookID()%>" 
                                           style="text-decoration: none; color: var(--primary); font-weight: 500;">
                                            <%= book.getBookName()%>
                                        </a>
                                    </td>
                                    <td>
                                        <div class="quantity-container">
                                            <button onclick="updateQuantity('<%= cart.getBookID()%>', -1, '<%= book.getPrice()%>')">-</button>
                                            <input type="number" id="quantity_<%= cart.getBookID()%>" value="<%= cart.getQuantity()%>" min="1" max="<%= book.getQuantity()%>" readonly>
                                            <button onclick="updateQuantity('<%= cart.getBookID()%>', 1, '<%= book.getPrice()%>')">+</button>
                                        </div>
                                    </td>
                                    <td><%= book.getPrice()%> $</td>
                                    <td class="hidden">
                                        <span id="total_<%= cart.getBookID()%>"><%= String.format("%.2f", totalItemPrice)%></span> $
                                    </td>
                                    <td>
                                        <button onclick="confirmDelete('<%= cart.getBookID()%>')">
                                            <i class="fas fa-trash"></i> Remove
                                        </button>
                                    </td>
                                </tr>
                                <% }
                                    session.setAttribute("totalPrice", totalPrice);
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Cart summary and actions (right) -->
                <div class="cart-summary-container">
                    <div class="cart-summary">
                        <h2 style="border-bottom: 1px solid #eee; padding-bottom: 10px; margin-bottom: 15px;">Order Summary</h2>
                        <p class="total">Total Price: <%= String.format("%.2f", totalPrice)%> $</p>
                        <button class="btn create-order" onclick="createOrder()">
                            <i class="fas fa-check-circle"></i> Create Order
                        </button>
                    </div>
                    <div>
                        <button class="btn clear-cart" onclick="confirmClearCart()">
                            <i class="fas fa-trash-alt"></i> Clear Cart
                        </button>
                        <a href="ViewBookCustomerController" class="btn btn-primary" style="background-color: var(--primary); color: white; margin-top: 10px; text-decoration: none;">
                            <i class="fas fa-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
            <% }%>
        </div>

        <!-- Overlay background -->
        <div class="overlay" id="overlay"></div>

        <!-- Confirmation dialog for removing item -->
        <div class="confirm-box" id="confirmBox">
            <p>Are you sure you want to remove this product from your cart?</p>
            <button class="confirm-yes" onclick="submitDelete()">Yes, Remove</button>
            <button class="confirm-no" onclick="closeConfirm()">Cancel</button>
        </div>

        <!-- Confirmation dialog for clearing cart -->
        <div class="confirm-box" id="confirmClearBox">
            <p>Are you sure you want to clear your entire cart?</p>
            <button class="confirm-yes" onclick="submitClearCart()">Yes, Clear All</button>
            <button class="confirm-no" onclick="closeConfirm()">Cancel</button>
        </div>

        <!-- Notification component -->
        <div class="notification" id="notification">
            <div class="notification-message" id="notification-message"></div>
            <button class="notification-close" onclick="hideNotification()">OK</button>
            <div class="notification-timer"></div>
        </div>

        <!-- Hidden forms for actions -->
        <form id="deleteForm" method="post" action="CartController">
            <input type="hidden" name="action" value="remove">
            <input type="hidden" name="bookId" id="deleteBookId">
        </form>

        <form id="clearCartForm" method="post" action="CartController">
            <input type="hidden" name="action" value="clear">
        </form>

        <form id="createOrderForm" method="post" action="CreateOrderController">
            <input type="hidden" name="action" value="finishOrder">
        </form>

        <script>
            let deleteBookID = null;
            let confirmStockExceeded = false; // Flag for when quantity exceeds stock

            function confirmDelete(bookID) {
                deleteBookID = bookID;
                document.getElementById("confirmBox").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeConfirm() {
                document.getElementById("confirmBox").style.display = "none";
                document.getElementById("confirmClearBox").style.display = "none";
                document.getElementById("overlay").style.display = "none";

                if (confirmStockExceeded) {
                    document.querySelector(".confirm-box p").innerText = "Are you sure you want to remove this product from your cart?";
                    document.querySelector(".confirm-yes").style.display = "inline-block";
                    confirmStockExceeded = false;
                }
            }

            function submitDelete() {
                if (deleteBookID) {
                    document.getElementById("deleteBookId").value = deleteBookID;
                    document.getElementById("deleteForm").submit();
                }
            }

            function confirmClearCart() {
                document.getElementById("confirmClearBox").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function submitClearCart() {
                document.getElementById("clearCartForm").submit();
            }

            function createOrder() {
                window.location.href = "CreateOrderController";
            }

            function updateQuantity(bookID, change, price) {
                let quantityInput = document.getElementById("quantity_" + bookID);
                let totalSpan = document.getElementById("total_" + bookID);
                let totalPriceSpan = document.querySelector(".total");
                let maxStock = parseInt(quantityInput.max);
                let newQuantity = parseInt(quantityInput.value) + change;

                if (newQuantity < 1) {
                    showNotification("Quantity cannot be less than 1!", "error");
                    return;
                }

                if (newQuantity > maxStock) {
                    // Show confirmation box if quantity exceeds stock
                    confirmStockExceeded = true;
                    deleteBookID = bookID;
                    showNotification("Not enough stock available!", "error");
                    return;
                }

                // Update interface values immediately
                quantityInput.value = newQuantity;
                let newTotal = (newQuantity * parseFloat(price));
                totalSpan.innerText = newTotal.toFixed(2);

                // Calculate total cart value
                let totalPrice = 0;
                document.querySelectorAll("[id^='total_']").forEach(item => {
                    totalPrice += parseFloat(item.innerText);
                });
                totalPriceSpan.innerText = "Total Price: " + Math.ceil(totalPrice * 100) / 100 + " $";

                // Send update request to server
                fetch("CartController", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: new URLSearchParams({
                        action: "update",
                        bookId: bookID,
                        quantity: newQuantity
                    })
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.newTotal !== undefined && data.totalPrice !== undefined) {
                                totalSpan.innerText = parseFloat(data.newTotal).toFixed(2);
                                totalPriceSpan.innerText = "Total Price: " + (Math.ceil(data.totalPrice * 100) / 100).toFixed(2) + " $";
                            }
                        })
                        .catch(error => console.error("Error updating cart:", error));
            }

            // Function to show notification
            function showNotification(message, type = 'info', autoHide = true) {
                const notification = document.getElementById('notification');
                const notificationMessage = document.getElementById('notification-message');

                // Remove existing notification types
                notification.classList.remove('notification-success', 'notification-error', 'notification-warning', 'notification-info');

                // Add the specific notification type
                notification.classList.add('notification-' + type);

                // Set message
                notificationMessage.textContent = message;

                // Display notification
                notification.style.display = 'block';

                // Add overlay
                document.getElementById('overlay').style.display = 'block';

                // Auto-hide after 3 seconds if autoHide is true
                if (autoHide) {
                    setTimeout(hideNotification, 3000);
            }
            }

            // Function to hide notification
            function hideNotification() {
                document.getElementById('notification').style.display = 'none';
                document.getElementById('overlay').style.display = 'none';
            }

            // Close popup when clicking outside
            window.onclick = function (event) {
                const overlay = document.getElementById('overlay');
                if (event.target === overlay) {
                    document.getElementById('confirmBox').style.display = 'none';
                    document.getElementById('confirmClearBox').style.display = 'none';
                    document.getElementById('notification').style.display = 'none';
                    document.getElementById('overlay').style.display = 'none';
                }
            };
        </script>
    </body>
</html>
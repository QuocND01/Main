<%@page import="DAO.BookDAO"%>
<%@page import="DAO.CartDAO"%>
<%@page import="Model.Books"%>
<%@page import="Model.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Customers"%>
<%@page import="Model.Deliveryunits"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
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
<%
    Customers customer = (Customers) request.getAttribute("customer");
    ArrayList<Deliveryunits> deliveryUnits = (ArrayList<Deliveryunits>) request.getAttribute("deliveryUnits");
    double totalPrice = (double) request.getAttribute("totalPrice");
    Date orderDate = (Date) request.getAttribute("orderDate");

    String voucherCode = (String) request.getAttribute("voucherCode");
    Integer discount = (Integer) request.getAttribute("discount");
    Double newTotalPrice = (Double) request.getAttribute("newTotalPrice");

    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String errorMessageVoucher = (String) request.getAttribute("errorMessageVoucher");
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Order</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            .cart-items h3.cart-header,
            .container h3 {
                color: #e91e63;
                border-bottom: 1px solid #ddd;
                padding-bottom: 8px;
                margin-top: 0;
            }

            /* General styling */
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
                color: #333;
            }

            h2 {
                text-align: center;
                color: #3a86ff;
                margin-bottom: 30px;
                font-size: 28px;
                border-bottom: 2px solid #3498db;
                padding-bottom: 10px;
            }

            h3 {
                color: #2c3e50;
                border-bottom: 1px solid #ddd;
                padding-bottom: 8px;
                margin-top: 0;
            }

            /* Success and error messages */
            .order-success-message {
                background-color: #d4edda;
                color: #155724;
                padding: 15px;
                border-radius: 5px;
                text-align: center;
                margin-bottom: 20px;
                border-left: 5px solid #28a745;
            }

            .error {
                background-color: #f8d7da;
                color: #721c24;
                padding: 15px;
                border-radius: 5px;
                text-align: center;
                margin-bottom: 20px;
                border-left: 5px solid #dc3545;
            }

            .logo{
                margin-left: 10%;
            }

            /* Cart container layout */
            .cart-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .cart-items {
                flex: 2;
                min-width: 300px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            .container {
                flex: 1;
                min-width: 300px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            /* Product table styling */
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }

            .table th {
                background-color: #f2f2f2;
                padding: 12px 8px;
                text-align: left;
                border: 1px solid #ddd;
            }

            .table td {
                padding: 12px 8px;
                border: 1px solid #ddd;
                vertical-align: middle;
            }

            .table tr:hover {
                background-color: #f9f9f9;
            }

            .table img {
                border: 1px solid #ddd;
                border-radius: 4px;
                object-fit: cover;
            }

            /* Links styling */
            a {
                color: #3498db;
                text-decoration: none;
                transition: color 0.3s;
            }

            a:hover {
                color: #2980b9;
                text-decoration: underline;
            }

            /* Quantity controls */
            .quantity-container {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            input[type="number"] {
                width: 60px;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-align: center;
            }

            /* Customer information */
            .customer-table {
                width: 100%;
                margin-bottom: 20px;
                border-collapse: collapse;
            }

            .customer-table th {
                text-align: left;
                width: 40%;
                padding: 10px;
                background-color: #f9f9f9;
                border-bottom: 1px solid #ddd;
            }

            .customer-table td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }

            /* Total price display */
            .total-price {
                font-size: 18px;
                font-weight: bold;
                margin: 15px 0;
                text-align: left;
                color: #dc3545;
                display: flex;
                justify-content: space-between;
            }

            .total-price::after {
                content: attr(data-amount);
                font-weight: bold;
            }

            /* Voucher form */
            .voucher-form {
                display: flex;
                gap: 10px;
                margin: 20px 0;
                padding: 10px;
                background-color: #f9f9f9;
                border-radius: 5px;
                align-items: center;
                flex-wrap: wrap;
            }

            .voucher-form label {
                font-weight: bold;
            }

            .voucher-form input[type="text"] {
                flex: 1;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            /* Delivery selection */
            .delivery-selection {
                margin: 20px 0;
            }

            .delivery-selection select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: white;
                margin-top: 5px;
            }

            /* Buttons */
            button {
                background-color: #3498db;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #2980b9;
            }

            .button-container {
                text-align: center;
                margin-top: 20px;
            }

            .button-container button {
                padding: 12px 30px;
                font-size: 16px;
                background-color: #27ae60;
            }

            .button-container button:hover {
                background-color: #219653;
            }

            /* Hide total column */
            .hidden-column {
                display: none;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .cart-container {
                    flex-direction: column;
                }

                .table th, .table td {
                    padding: 8px 4px;
                    font-size: 14px;
                }

                .cart-header {
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <!-- Logo moved to top left position -->
        <div class="logo">
            <a href="ViewBookCustomerController">
                <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
            </a>
            <h2 style="color: #e91e63"><i class="fas fa-clipboard-list"></i> Create Order</h2>
        </div>

        <!-- Display success message below the main heading -->
        <% if (successMessage != null) {%>
        <p class="order-success-message"><%= successMessage%></p>
        <% } %>
        <% if (errorMessage != null) {%>
        <p class="error"><%= errorMessage%></p>
        <% }%>

        <div class="cart-container">
            <!-- Bảng danh sách sản phẩm (bên trái) -->
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
                    <%
                        for (Cart cart : cartList) {
                            Books book = bookDAO.getBookByBookID(cart.getBookID());
                            double totalItemPrice = Double.parseDouble(book.getPrice()) * cart.getQuantity();
                    %>
                    <tr>
                        <td><img src="<%= book.getImage()%>" alt="Book Image" width="50" height="75"></td>
                        <td>
                            <a href="viewBookDetailCustomerController?bookId=<%= book.getBookID()%>" 
                               style="text-decoration: none; color: blue;">
                                <%= book.getBookName()%>
                            </a>
                        </td>
                        <td>
                            <div class="quantity-container">
                                <input type="number" id="quantity_<%= cart.getBookID()%>" value="<%= cart.getQuantity()%>" min="1" max="<%= book.getQuantity()%>" readonly>
                            </div>
                        </td>
                        <td><%= book.getPrice()%> $</td>
                        <td class="hidden-column"><span id="total_<%= cart.getBookID()%>"><%= String.format("%.2f", totalItemPrice)%></span> $</td>
                    </tr>
                    <% }
                    %>
                </table>
            </div>
            <div class="container">
                <h3>Customer Information</h3>

                <table class="customer-table">
                    <tr>
                        <th>Name</th>
                        <td><%= customer.getCustomerName()%></td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td><%= customer.getCustomerAddress()%></td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td><%= customer.getCustomerPNB()%></td>
                    </tr>
                    <tr>
                        <th>Order Date</th>
                        <td><%= orderDate%></td>
                    </tr>
                </table>

                <p class="total-price">Total Price: <%= String.format("%.2f", totalPrice)%> $</p>

                <!-- Form nhập voucher -->
                <form action="CreateOrderController" method="post" class="voucher-form">
                    <label>Enter Voucher:</label>
                    <input type="text" name="voucherCode" value="<%= (voucherCode != null) ? voucherCode : ""%>">
                    <input type="hidden" name="action" value="applyVoucher">
                    <button type="submit">Apply Voucher</button>
                </form>

                <% if (errorMessageVoucher != null) {%>
                <p class="error"><%= errorMessageVoucher%></p>
                <% }%>

                <!-- Hiển thị voucher, giảm giá và tổng mới - now left-aligned and red -->
                <div class="price-summary">
                    <% if (discount != null) {%>
                    <p class="total-price">Discount: <span style="float: right;"><%= discount%>%</span></p>
                    <p class="total-price">Total price after discount: <span style="float: right;"><%= String.format("%.2f", newTotalPrice)%> $</span></p>
                    <% } %>
                </div>

                <!-- Chọn đơn vị vận chuyển -->
                <form action="CreateOrderController" method="post" class="order-form">
                    <div class="delivery-selection">
                        <label>Select Delivery Unit:</label>
                        <select name="unitID">
                            <% if (deliveryUnits != null && !deliveryUnits.isEmpty()) { %>
                            <% for (Deliveryunits unit : deliveryUnits) {%>
                            <option value="<%= unit.getUnitID()%>"><%= unit.getUnitName()%></option>
                            <% } %>
                            <% } else { %>
                            <option value="">No active delivery units available</option>
                            <% }%>
                        </select>
                    </div>

                    <input type="hidden" name="voucherCode" value="<%= (voucherCode != null) ? voucherCode : ""%>">
                    <input type="hidden" name="action" value="finishOrder">
                    <div class="button-container">
                        <% if (deliveryUnits != null && !deliveryUnits.isEmpty()) { %>
                        <button type="submit">Order</button>
                        <% } else { %>
                        <button type="button" disabled>No Active Delivery Units Available</button>
                        <% }%>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
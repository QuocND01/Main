<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <title>New Orders</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                text-align: center;
            }

            h2 {
                color: white;
                background: #ff66b2;
                padding: 15px;
                display: inline-block;
                border-radius: 10px;
            }

            table {
                width: 90%;
                margin: 30px auto;
                border-collapse: collapse;
                background: #ffffff;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                overflow: hidden;
            }

            th {
                background-color: #007bff;
                color: white;
                padding: 15px;
                text-transform: uppercase;
            }

            td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #ccc;
            }

            .btn {
                padding: 5px 10px;
                background-color: blue;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: 0.3s;
            }

            .btn:hover {
                background-color: darkblue;
            }

            .toggle-books {
                color: blue;
                cursor: pointer;
                font-size: 14px;
                display: inline-block;
                margin-top: 5px;
            }
            .hidden {
                display: none;
            }
        </style>

        <script>
            function toggleBooks(orderID) {
                var bookRows = document.querySelectorAll(".extra-books-" + orderID);
                bookRows.forEach(row => {
                    row.classList.toggle("hidden");
                });
            }
        </script>
    </head>
    <body>
        <h2>New Orders</h2>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer Name</th>
                    <th>Book Name</th>
                    <th>Quantity</th>
                    <th>Order Date</th>
                    <th>Value</th>
                    <th>Order Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${newOrders}">
                    <c:set var="bookList" value="${fn:split(order.BookNames, ',')}" />
                    <c:set var="quantityList" value="${fn:split(order.Quantities, ',')}" />
                    
                    <!-- Dòng đầu tiên của đơn hàng -->
                    <tr>
                        <td>${order.OrderID}</td>
                        <td>${order.CustomerName}</td>
                        <td>
                            <span>${fn:trim(bookList[0])}</span>
                            <c:if test="${fn:length(bookList) > 1}">
                                <span class="toggle-books" onclick="toggleBooks('${order.OrderID}')"> See More ▼</span>
                            </c:if>
                        </td>
                        <td>${fn:trim(quantityList[0])}</td>
                        <td>${order.OrderDate}</td>
                        <td>$${order.Value}</td>
                        <td>${order.OrderStatus}</td>
                        <td><a href="change-status-order?orderID=${order.OrderID}" class="btn">Change Status</a></td>
                    </tr>

                    <!-- Các dòng sách mở rộng -->
                    <c:forEach var="book" items="${bookList}" varStatus="loop">
                        <c:if test="${loop.index > 0}">
                            <tr class="extra-books-${order.OrderID} hidden">
                                <td>${order.OrderID}</td>
                                <td>${order.CustomerName}</td>
                                <td>${fn:trim(book)}</td>
                                <td>${fn:trim(quantityList[loop.index])}</td>
                                <td>${order.OrderDate}</td>
                                <td>$${order.Value}</td>
                                <td>${order.OrderStatus}</td>
                                <td><a href="change-status-order?orderID=${order.OrderID}" class="btn">Change Status</a></td> <!-- Không có nút Change Status ở đây -->
                            </tr>
                        </c:if>
                    </c:forEach>

                </c:forEach>
            </tbody>
        </table>
    </body>
</html>

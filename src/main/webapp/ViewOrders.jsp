<%-- 
    Document   : ViewOrder
    Created on : Mar 5, 2025, 2:08:02 PM
    Author     : Long Ho
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Order List</title>
    </head>
    <body>
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

            tr:hover {
                background-color: #f1f1f1;
            }

            .no-order {
                font-weight: bold;
                color: red;
                padding: 20px;
            }

            .detail-btn, .cancel-btn {
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .detail-btn {
                background-color: #ff66b2;
            }

            .detail-btn:hover {
                background-color: #e60073;
            }

            .cancel-btn {
                background-color: #ff4444;
            }

            .cancel-btn:hover {
                background-color: #cc0000;
            }

            .toggle-books {
                color: #007bff;
                cursor: pointer;
                font-size: 14px;
                display: inline-block;
                margin-top: 5px;
            }

            .hidden {
                display: none;
            }

            /* Căn chỉnh hai nút Detail và Cancel trên cùng một hàng */
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .action-buttons form {
                margin: 0;
            }
        </style>
        <div class="logo">
            <a href="ViewBookCustomerController">
                <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
            </a>
        </div>

        <h2>Your Order List</h2>

        <table>
            <tr>
                <th>Book Title</th>
                <th>Order Date</th>
                <th>Value</th>
                <th>Completion Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <c:choose>
                <c:when test="${not empty orders}">
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>
                                <c:set var="details" value="${orderDetailsMap[order.orderID]}" />
                                <c:if test="${not empty details}">
                                    <span>${details[0].bookTitle}</span>
                                    <c:if test="${fn:length(details) > 1}">
                                        <span class="toggle-books" onclick="toggleBooks('${order.orderID}')">See More ▼</span>
                                    </c:if>
                                    <div id="books-${order.orderID}" class="hidden">
                                        <c:forEach var="detail" items="${details}" begin="1">
                                            <div>${detail.bookTitle}</div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                            </td>
                            <td>${order.orderDate}</td>
                            <td>${order.value} $</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.orderStatus eq 'Completed'}">${order.orderCompleteDate}</c:when>
                                    <c:otherwise>----</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${order.orderStatus}</td>
                            <td>
                                <div class="action-buttons">
                                    <form action="view-order-detail" method="get">
                                        <input type="hidden" name="orderID" value="${order.orderID}">
                                        <button type="submit" class="detail-btn">Detail</button>
                                    </form>

                                    <c:if test="${order.orderStatus ne 'Completed' and order.orderStatus ne 'Cancelled'}">
                                        <form id="cancelForm-${order.orderID}" action="cancel-order" method="post">
                                            <input type="hidden" name="orderID" value="${order.orderID}">
                                            <button type="button" class="cancel-btn" onclick="confirmCancel('${order.orderID}')">Cancel</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${order.orderStatus eq 'Completed'}">
                                        <form action="feedback-page" method="get">
                                            <input type="hidden" name="orderID" value="${order.orderID}">
                                            <button type="submit" class="detail-btn">Feedback</button>
                                        </form>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="no-order">No orders found.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>

        <script>
            function toggleBooks(orderID) {
                var bookList = document.getElementById("books-" + orderID);
                if (bookList.classList.contains("hidden")) {
                    bookList.classList.remove("hidden");
                } else {
                    bookList.classList.add("hidden");
                }
            }

            function confirmCancel(orderID) {
                let confirmAction = confirm("Are you sure you want to cancel this order?");
                if (confirmAction) {
                    document.getElementById("cancelForm-" + orderID).submit();
                }
            }
        </script>

    </body>
</html>

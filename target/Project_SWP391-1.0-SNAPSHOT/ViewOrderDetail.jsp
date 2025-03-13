<%-- 
    Document   : ViewOrderDetail
    Created on : Mar 6, 2025, 2:08:48 PM
    Author     : Long Ho
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Detail</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: 20px auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .back-btn {
                display: block;
                width: 150px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }

            .back-btn:hover {
                background: #218838;
            }

            .order-info {
                margin-top: 20px;
                padding: 15px;
                background: #eef;
                border-radius: 5px;
            }

            .order-info strong {
                color: #007bff;
            }

            .order-status {
                font-weight: bold;
                padding: 5px 10px;
                border-radius: 5px;
                display: inline-block;
            }

            /* Màu sắc theo trạng thái */
            .status-completed {
                color: white;
                background: #28a745;
            }

            .status-not-approved {
                color: white;
                background: #ff9800;
            }

            .status-cancelled {
                color: white;
                background: #dc3545;
            }

            img {
                width: 50px;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Order Detail</h2>

            <table>
                <tr>
                    <th>Book Image</th>
                    <th>Book Title</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
                <c:forEach var="detail" items="${orderDetails}" varStatus="index">
                    <c:set var="book" value="${booksList[index.index]}" />
                    <tr>
                        <td>
                            <img src="${book.image}" alt="Book Image">
                        </td>
                        <td>${book.bookName}</td>
                        <td>${detail.quantity}</td>
                        <td>${detail.price} $</td>
                    </tr>
                </c:forEach>
            </table>

            <div class="order-info">
                <p><strong>Order Date:</strong> ${order.orderDate}</p>
                <p><strong>Value:</strong> ${order.value} $</p>
                <p><strong>Shipping Unit:</strong> ${unit.unitName}</p>
                <c:if test="${not empty voucher}">
                        <p><strong>Voucher Applied:</strong> ${voucher.voucherName}</p>
                        <p><strong>Discount Value:</strong> ${voucher.value} $</p>
                </c:if>
                <p><strong>Status:</strong> 
                    <span class="order-status
                          <c:choose>
                              <c:when test="${order.orderStatus eq 'Completed'}">status-completed</c:when>
                              <c:when test="${order.orderStatus eq 'Not Approved'}">status-not-approved</c:when>
                              <c:when test="${order.orderStatus eq 'Cancelled'}">status-cancelled</c:when>
                          </c:choose>">
                        ${order.orderStatus}
                    </span>
                </p>
                <c:if test="${order.orderStatus eq 'Completed'}">
                    <p><strong>Completion Date:</strong> ${order.orderCompleteDate}</p>
                </c:if>
            </div>

            <a href="OrderController" class="back-btn">Back</a>
        </div>
    </body>
</html>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }
        td {
            text-align: center;
        }
        .order-info {
            background: #eef;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .order-info p {
            margin: 5px 0;
        }
        .highlight {
            font-weight: bold;
        }
        .btn-back {
            display: block;
            width: 100px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background: green;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .status {
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            color: white;
            display: inline-block;
        }
        .status.not-approved {
            background-color: red;
        }
        .status.approved {
            background-color: green;
        }
        .dropdown {
            margin-top: 10px;
        }
        .update-btn {
            background-color: #007bff;
            color: white;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Order Detail</h2>

    <!-- Thông tin khách hàng -->
    <div class="order-info">
        <p><span class="highlight">User Name:</span> ${orderDetail.Username}</p>
        <p><span class="highlight">Customer Name:</span> ${orderDetail.CustomerName}</p>
        <p><span class="highlight">Address:</span> ${orderDetail.CustomerAddress}</p>
        <p><span class="highlight">Phone Number:</span> ${orderDetail.CustomerPNB}</p>
        <p><span class="highlight">Email:</span> ${orderDetail.CustomerEmail}</p>
    </div>

    <!-- Thông tin đơn hàng -->
    <table>
        <thead>
            <tr>
                <th>Book Image</th>
                <th>Book Title</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${not empty orderDetail.books}">
    <c:forEach var="book" items="${orderDetail.books}">
        <tr>
            <td><img src="${book.Image}" alt="${book.BookName}" width="80"></td>
            <td>${book.BookName}</td>
            <td>${book.Quantity}</td>
            <td>${book.Price} $</td>
        </tr>
    </c:forEach>
</c:if>
<c:if test="${empty orderDetail.books}">
    <tr>
        <td colspan="4">Không có sách trong đơn hàng</td>
    </tr>
</c:if>
        </tbody>
    </table>

    <div class="order-info">
        <p><span class="highlight">Order Date:</span> ${orderDetail.OrderDate}</p>
        <p><span class="highlight">Value:</span> <span style="font-weight: bold; color: blue;">${orderDetail.Value} $</span></p>
        <p><span class="highlight">Shipping Unit:</span> <b>${orderDetail.DeliveryUnitName}</b></p>
        <p><span class="highlight">Status:</span> 
            <span class="status ${orderDetail.OrderStatus eq 'Not Approved' ? 'not-approved' : 'approved'}">
                ${orderDetail.OrderStatus}
            </span>
        </p>
    </div>

    <!-- Dropdown cập nhật trạng thái -->
    <form action="change-status-order" method="post">
        <input type="hidden" name="orderID" value="${orderDetail.OrderID}">
        <label class="highlight">Update Status:</label>
        <select name="orderStatus" class="dropdown">
            <option value="Completed" ${orderDetail.OrderStatus eq 'Completed' ? 'selected' : ''}>Complete</option>
            <option value="Cancelled" ${orderDetail.OrderStatus eq 'Cancelled' ? 'selected' : ''}>Cancel</option>
        </select>
        <button type="submit" class="update-btn">Update</button>
    </form>

    <a href="view-new-order" class="btn-back">Back</a>
</div>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Feedback List</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                text-align: center;
                margin: 0;
                padding: 0;
            }

            h2 {
                color: white;
                background: #ff66b2;
                padding: 15px;
                display: inline-block;
                border-radius: 10px;
                margin-top: 20px;
            }

            table {
                width: 80%;
                margin: 30px auto;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: white;
                font-size: 16px;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #ddd;
            }

            .feedback-btn {
                background: #ff66b2;
                color: white;
                padding: 8px 12px;
                text-decoration: none;
                border-radius: 5px;
                transition: background 0.3s;
            }

            .feedback-btn:hover {
                background: #e60073;
            }

            /* CSS cho nút Update */
            .update-btn {
                background: #ffa500; /* Màu cam */
                color: white;
                padding: 8px 12px;
                text-decoration: none;
                border-radius: 5px;
                transition: background 0.3s, transform 0.2s;
                display: inline-block;
                margin-left: 10px;
            }

            .update-btn:hover {
                background: #ff8c00; /* Cam đậm hơn khi hover */
                transform: scale(1.05);
            }

            .update-btn:active {
                transform: scale(0.95);
            }

            .delete-btn {
                background: #dc3545; /* Màu đỏ */
                color: white;
                padding: 8px 12px;
                text-decoration: none;
                border-radius: 5px;
                transition: background 0.3s, transform 0.2s;
                display: inline-block;
                margin-left: 10px;
            }

            .delete-btn:hover {
                background: #c82333; /* Đỏ đậm hơn khi hover */
                transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
            }

            .delete-btn:active {
                transform: scale(0.95); /* Nhấn vào thì thu nhỏ nhẹ */
            }

        </style>
    </head>
    <body>
        <h2>Feedbacks</h2>

        <table>
            <tr>
                <th>Image</th>
                <th>Book Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Action</th>
            </tr>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td><img src="${book.image}" width="80"></td>
                    <td>${book.bookTitle}</td>
                    <td>${book.quantity}</td>
                    <td>${book.price}$</td>
                    <td>
                        <c:choose>
                            <c:when test="${feedbackStatusMap[book.BookID]}">
                                <a href="update-feedback?bookID=${book.BookID}&orderID=${orderID}" class="feedback-btn update-btn">Update Feedback</a>
                                <a href="delete-feedback?bookID=${book.BookID}&orderID=${orderID}" class="feedback-btn delete-btn" onclick="return confirm('Are you sure you want to delete this feedback?');">Delete Feedback</a>
                            </c:when>
                            <c:otherwise>
                                <a href="write-feedback?bookID=${book.BookID}&orderID=${orderID}" class="feedback-btn">Write Feedback</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
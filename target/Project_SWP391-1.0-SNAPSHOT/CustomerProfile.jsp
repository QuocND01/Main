<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Customer Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .notification {
                background-color: #4CAF50;  /* Green background */
                color: white;
                padding: 15px;
                border-radius: 5px;
                position: fixed;
                top: 10px;
                right: 10px;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 300px;
                font-family: Arial, sans-serif;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .notification.error {
                background-color: #f44336;  /* Red background for errors */
            }

            .notification .close-btn {
                background: none;
                border: none;
                color: white;
                font-size: 18px;
                cursor: pointer;
                padding: 0 10px;
            }

            .notification .close-btn:hover {
                color: #ddd;
            }

            .notification.fade {
                animation: fadeOut 0.5s forwards;
            }

            @keyframes fadeOut {
                0% {
                    opacity: 1;
                }
                100% {
                    opacity: 0;
                    transform: translateX(100px);
                }
            }

        </style>
        <script>
            function toggleEditMode(enable) {
                let inputs = document.querySelectorAll(".form-control");
                //khong cho  edit id,username,status
                inputs.forEach(input => {
                    if (input.name !== "CustomerID" && input.name !== "Username" && input.name !== "Status") {
                        input.readOnly = !enable;
                    }
                });
                document.getElementById("editBtn").style.display = enable ? "none" : "inline-block";
                document.getElementById("updateBtn").style.display = enable ? "inline-block" : "none";
                document.getElementById("cancelBtn").style.display = enable ? "inline-block" : "none";
            }
            function closeNotification() {
                var notification = document.getElementById('notification');
                notification.classList.add('fade');
                setTimeout(function () {
                    notification.style.display = 'none';
                }, 500);  // Wait for the fade-out animation to finish
            }

        </script>

    </head>
    <body class="container mt-4">
        <%-- Check if message attribute exists --%>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) {%>
        <div id="notification" class="notification">
            <span class="message"><%= message%></span>
            <button class="close-btn" onclick="closeNotification()">×</button>
        </div>
        <% }%>

        <h2>Customer Profile</h2>
        <c:if test="${not empty customer}">
            <form action="UpdateCusProfile" method="post">
                <!-- Ẩn ID và Status nhưng vẫn gửi dữ liệu -->
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

                <button type="button" id="editBtn" class="btn btn-primary" onclick="toggleEditMode(true)">Edit</button>
                <button type="submit" id="updateBtn" class="btn btn-success" style="display: none;">Update</button>
                <button type="button" id="cancelBtn" class="btn btn-secondary" style="display: none;" onclick="toggleEditMode(false)">Cancel</button>
            </form>

        </c:if>
        <c:if test="${empty customer}">
            <h3>Customer not found!</h3>
        </c:if>
    </body>
</html>
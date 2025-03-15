<%-- 
    Document   : ForgetPassword
    Created on : Feb 26, 2025, 4:29:15 PM
    Author     : Long Ho
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Forget Password</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
            }
            .container {
                background: white;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                text-align: center;
            }
            .error {
                color: red;
            }
            .success {
                color: green;
            }
            input {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .submit-btn {
                background-color: #ff6600;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
            }

        </style>
    </head>
    <body>

        <div class="container">
            <div class="logo">
                <a href="ViewBookCustomerController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>
            <h2>Forget Password</h2>
            <form action="forgetpassword" method="post" onsubmit="return validateForm();">
                <input type="email" name="email" id="email" placeholder="Enter your email" required>
                <input type="text" name="phone" id="phone" placeholder="Enter your phone number" required>
                <input type="password" name="newPassword" id="newPassword" placeholder="Enter new password" required>
                <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm new password" required>
                <button type="submit" class="submit-btn">Reset Password</button>
            </form>
            <c:if test="${not empty errorMessage}">
                <p class="error">${errorMessage}</p>
            </c:if>
            <c:if test="${not empty successMessage}">
                <p class="success">${successMessage}</p>
            </c:if>
            <div id="error-message" style="display:none; color: red; text-align: center; margin-bottom: 10px;"></div>
        </div>

        <script>
            function validateForm() {
                var password = document.getElementById("newPassword").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var errorBox = document.getElementById("error-message");

                if (password !== confirmPassword) {
                    errorBox.innerText = "Confirmation password does not match!";
                    errorBox.style.display = "block";
                    return false;
                } else {
                    errorBox.style.display = "none";
                    return true;
                }
            }
        </script>
    </body>
</html>

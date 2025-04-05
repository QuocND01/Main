<%-- 
    Document   : RegisterPage
    Created on : Feb 22, 2025, 4:51:13 PM
    Author     : Tran Phuc Vinh - CE182381
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('<c:url value="/img/banner-image-bg.jpg"/>') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: 0px 20px 20px 20px;
            box-sizing: border-box;
        }

        .container {
            display: flex;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            max-width: 1000px;
            width: 100%;
            justify-content: space-between;
        }
        span {
                display: inline-block;
                font-size: 12px;
                color: #aaa;
                margin-top: 5px;
                text-align: left;
                float: right;
            }

        .image-container {
            flex: 3;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            margin-right: 20px;
            width: 500px;
            height: 800px;
            margin-top: 30px;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            border-radius: 10px;
        }

        form {
            flex: 2;
            padding: 0px 20px 20px 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .logo {
            text-align: center;
        }

        .logo img {
            height: 150px;
            width: 150px;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            color: #ff5588;
            margin: 0 0 10px 0;
        }

        label {
            display: block;
            font-size: 16px;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #3399ff;
            box-shadow: 0 0 5px rgba(51, 153, 255, 0.5);
            outline: none;
        }

        .error {
            color: red;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .sub {
            width: 100%;
            margin-top: 10px;
        }

        .sub button {
            background-color: #e91e63;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .sub button:hover {
            background-color: #ff5588;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="image-container">
            <img src="<c:url value='/img/bookstore1.jpg'/>" alt="Register Image">
        </div>
        
        <form action="RegisterController" method="post">
            <div class="logo">
                <a href="ViewBookCustomerController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>

            <h2>Register</h2>

            <label>Username:</label>
            <input type="text" name="username" value="${param.username}" required>
            <span>(min 5 chars)</span>
            <c:if test="${not empty errorName}">
                <p class="error">${errorName}</p>
            </c:if>

            <label>Password:</label>
            <input type="password" name="password" required>
            <span>(min 8 chars)</span>
            <c:if test="${not empty errorPassword}">
                <p class="error">${errorPassword}</p>
            </c:if>

            <label>Confirm Password:</label>
            <input type="password" name="confirm" required>
            <span>(min 8 chars)</span>
            <c:if test="${not empty errorConfirm}">
                <p class="error">${errorConfirm}</p>
            </c:if>

            <label>Your Name:</label>
            <input type="text" name="customerName" value="${param.customerName}" required>
            <c:if test="${not empty errorCusName}">
                <p class="error">${errorCusName}</p>
            </c:if>

            <label>Email:</label>
            <input type="email" name="customerEmail" value="${param.customerEmail}" required>

            <label>Address:</label>
            <input type="text" name="customerAddress" value="${param.customerAddress}" required>
            <span>(min 5 chars)</span>
            <c:if test="${not empty errorAddress}">
                <p class="error">${errorAddress}</p>
            </c:if>

            <label>Phone number:</label>
            <input type="text" name="customerPNB" value="${param.customerPNB}" require">
            <c:if test="${not empty errorPNB}">
                <p class="error">${errorPNB}</p>
            </c:if>

            <div class="sub">
                <button type="submit">Register</button>
            </div>

            <c:if test="${not empty successMessage}">
                <p style="color:green; text-align:center;">${successMessage}</p>
            </c:if>

            <div class="login-link">
                Already have an account? <a href="LoginForm.jsp">Login here</a>
            </div>
        </form>
    </div>
</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                color: #333;
            }

            /* Video Background Styling */
            .video-bg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                z-index: -1; /* Send the video to the back */
            }

            form {
                background-color: rgba(255, 255, 255, 0.85); /* Slight transparency */
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
                position: relative;
                z-index: 2; /* Make sure form is above the video */
            }

            .logo {
                text-align: center;
                margin-bottom: 10px;
            }

            .logo img {
                max-width: 150px;
            }

            h2 {
                text-align: center;
                font-size: 32px;
                margin-bottom: 20px;
                color: #FF69B4;
            }

            label {
                display: block;
                font-size: 16px;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 95%;
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

            .sub input[type="submit"] {
                background-color: #FF69B4;
                color: white;
                border: none;
                padding: 12px;
                border-radius: 5px;
                width: 100%;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .sub input[type="submit"]:hover {
                background-color: #77CCFF;
            }

            .checkpass {
                display: flex;
                padding-bottom: 10px;
            }

            .checkpass label {
                margin-left: 5px;
            }

            .sub2 a {
                display: block;
                text-align: center;
                background-color: transparent;
                color: #ff9933;
                border: 2px solid #ff9933;
                padding: 12px 20px;
                border-radius: 5px;
                font-size: 16px;
                text-decoration: none;
                transition: background-color 0.3s ease, color 0.3s ease;
                width: 100%;
                box-sizing: border-box;
                margin-top: 10px;
            }

            .sub2 a:hover {
                background-color: #ff9933;
                color: white;
            }
        </style>

        <!-- JavaScript to show/hide password -->
        <script>
            function togglePasswordVisibility() {
                const passwordInput = document.getElementById("password");
                const passwordToggle = document.getElementById("showPassword");
                passwordInput.type = passwordToggle.checked ? "text" : "password";
            }
        </script>
    </head>
    <body>
    <!-- Video Background -->
    <video class="video-bg" autoplay muted loop>
        <source src="<c:url value='/vid/login1.mp4'/>" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <!-- Login Form -->
    <form action="login" method="post">
        <div class="logo">
            <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
        </div>
        <h2>Login</h2>

        <label for="name">Username:</label>
        <input type="text" name="name" placeholder="Enter your username" id="name" value="<c:out value='${param.name}'/>" required />
        
        <label for="password">Password:</label>
        <input type="password" name="password" placeholder="Enter your password" id="password" required />

        <div class="checkpass">
            <input type="checkbox" id="showPassword" onclick="togglePasswordVisibility()">
            <label for="showPassword">Show Password</label>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <p class="error" style="color: red; text-align: center; margin: 10px 0;">${errorMessage}</p>
        </c:if>

        <div class="sub">
            <input type="submit" value="login">
        </div>

        <div class="sub2">
            <a href="./SigninForm.jsp" class="signin">Sign Up</a>
        </div>
    </form>
</body>
</html>

<%-- 
    Document   : ViewStaffDetail
    Created on : Feb 23, 2025, 7:53:52 PM
    Author     : Long Ho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Account Detail</title>
        <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', Arial, sans-serif;
            }
            body {
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                width: 100%;
                max-width: 500px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                padding: 30px;
                text-align: center;
            }

            h1 {
                color: #e91e63;
                margin-bottom: 20px;
                font-size: 24px;
                font-weight: 700;
            }

            .detail-box {
                text-align: left;
                margin-bottom: 15px;
            }

            .detail-box strong {
                display: block;
                font-size: 16px;
                color: #333;
                margin-bottom: 5px;
            }

            .detail-box span {
                display: block;
                font-size: 14px;
                color: #555;
                background: #f9f9f9;
                padding: 10px;
                border-radius: 5px;
            }

            .btn-back {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #3498db;
                color: #fff;
                text-decoration: none;
                border-radius: 25px;
                font-weight: bold;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-back:hover {
                background-color: #2980b9;
                transform: translateY(-3px);
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Staff Account Detail</h1>
            
            <div class="detail-box">
                <strong>Name:</strong>
                <span>${staffDetail.staffName}</span>
            </div>

            <div class="detail-box">
                <strong>Email:</strong>
                <span>${staffDetail.staffEmail}</span>
            </div>

            <div class="detail-box">
                <strong>Phone Number:</strong>
                <span>${staffDetail.staffPNB}</span>
            </div>

            <div class="detail-box">
                <strong>Address:</strong>
                <span>${staffDetail.staffAddress}</span>
            </div>

            <div class="detail-box">
                <strong>Username:</strong>
                <span>${staffDetail.username}</span>
            </div>

            <div class="detail-box">
                <strong>Password:</strong>
                <span>${staffDetail.password}</span>
            </div>

            <div class="detail-box">
                <strong>Role:</strong>
                <span>${staffDetail.role}</span>
            </div>

            <div class="detail-box">
                <strong>Status:</strong>
                <span>${staffDetail.status}</span>
            </div>

            <a href="viewstaff" class="btn-back">Back to List</a>
        </div>

    </body>
</html>

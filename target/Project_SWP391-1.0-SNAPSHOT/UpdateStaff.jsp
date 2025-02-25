<%-- 
    Document   : UpdateStaff
    Created on : Feb 24, 2025, 9:56:12 PM
    Author     : Long Ho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Update Staff Account</title>
    <style>
      body {
        background-color: #f9f9f9;
        font-family: 'Roboto', Arial, sans-serif;
        padding: 20px;
      }
      .container {
        max-width: 500px;
        margin: 0 auto;
        background: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
      }
      h1 {
        text-align: center;
        color: #3498db;
        margin-bottom: 20px;
      }
      label {
        display: block;
        margin-top: 15px;
        font-weight: bold;
      }
      input[type="text"],
      input[type="password"],
      input[type="email"],
      input[type="number"],
      select {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
      }
      input[readonly] {
        background-color: #e9e9e9;
      }
      .btn-submit {
        display: block;
        width: 100%;
        padding: 10px;
        margin-top: 20px;
        background-color: #3498db;
        color: #fff;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
      }
      .btn-submit:hover {
        background-color: #2980b9;
      }
      .btn-back {
        display: inline-block;
        margin-top: 15px;
        padding: 8px 16px;
        background-color: #8CC103;
        color: #fff;
        text-decoration: none;
        border-radius: 25px;
      }
      .error {
        color: #ff4757;
        margin-top: 10px;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>Update Staff Account</h1>
      <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
      </c:if>
      <form action="updatestaff" method="post">
 
        <label for="staffID">Staff ID:</label>
        <input type="text" id="staffID" name="staffID" value="${staff.staffID}" readonly>

        <label for="role">Role:</label>
        <input type="text" id="role" name="role" value="${staff.role}" readonly>

        <label for="staffName">Name:</label>
        <input type="text" id="staffName" name="staffName" value="${staff.staffName}" required>

        <label for="staffEmail">Email:</label>
        <input type="email" id="staffEmail" name="staffEmail" value="${staff.staffEmail}" required>

        <label for="staffPNB">Phone Number:</label>
        <input type="number" id="staffPNB" name="staffPNB" value="${staff.staffPNB}" required>

        <label for="staffAddress">Address:</label>
        <input type="text" id="staffAddress" name="staffAddress" value="${staff.staffAddress}" required>

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" value="${staff.username}" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="${staff.password}" required>

        <label for="status">Status:</label>
        <select id="status" name="status" required>
          <option value="Active" ${staff.status == 'Active' ? 'selected' : ''}>Active</option>
          <option value="Inactive" ${staff.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
        </select>

        <button type="submit" class="btn-submit">Update Staff</button>
      </form>
      <a href="viewstaff" class="btn-back">Back to List</a>
    </div>
  </body>
</html>

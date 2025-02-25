<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, Model.Customers" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
    <style>
        table { width: 80%; border-collapse: collapse; margin: 20px auto; }
        th, td { padding: 10px; border: 1px solid black; text-align: center; }
        th { background-color: #f2f2f2; }
        a { text-decoration: none; color: blue; }
    </style>
</head>
<body>
    <h2 align="center">Customer List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <%
            ArrayList<Customers> customersList = (ArrayList<Customers>) request.getAttribute("customersList");
            for (Customers c : customersList) {
        %>
        <tr>
            <td><%= c.getCustomerID() %></td>
            <td><%= c.getCustomerName() %></td>
            <td><%= c.getCustomerPNB() %></td>
            <td><%= c.getStatus() %></td>
            <td>
                <a href="ViewCustomerDetailsController?id=<%= c.getCustomerID() %>">Details</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
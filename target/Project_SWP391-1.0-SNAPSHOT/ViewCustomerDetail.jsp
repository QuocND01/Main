<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Customers"%>
<%@page import="Model.Staffs"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Details</title>
    <script>
        function confirmAction(action) {
            return confirm("Are you sure you want to " + action + " this customer?");
        }
    </script>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f4f4;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            font-weight: bold;
            color: #555;
        }

        form {
            display: inline-block;
            margin-right: 10px;
        }

        input[type="submit"] {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"][value="Lock"] {
            background-color: #ffcccc;
            color: #cc0000;
        }

        input[type="submit"][value="Active"] {
            background-color: #ccffcc;
            color: #008000;
        }

        a {
            text-decoration: none;
            background-color: #e0e0e0;
            color: #333;
            padding: 8px 15px;
            border-radius: 4px;
            display: inline-block;
        }

        a:hover {
            background-color: #d0d0d0;
        }

        .customer-not-found {
            color: red;
            font-style: italic;
            text-align: center;
        }
        h2 {
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                color: #FFFFFF;
                background-color: #FF69B4;
                padding: 15px;
                border-radius: 10px;
                display: block; /* Chuyển từ inline-block thành block */
                width: fit-content; /* Giúp tiêu đề chỉ chiếm chiều rộng theo nội dung */
                margin: 20px auto; /* Căn giữa theo chiều ngang */
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            }
    </style>
</head>
<body>
    <div class="container">
        <h2>Customer Details</h2>
        <%
            Customers customer = (Customers) request.getAttribute("customer");
            Staffs staff = (Staffs) session.getAttribute("account");

            if (customer != null) {
        %>
        <table>
            <tr>
                <th>ID</th>
                <td><%= customer.getCustomerID()%></td>
            </tr>
            <tr>
                <th>Name</th>
                <td><%= customer.getCustomerName()%></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><%= customer.getCustomerEmail()%></td>
            </tr>
            <tr>
                <th>Phone</th>
                <td><%= customer.getCustomerPNB()%></td>
            </tr>
            <tr>
                <th>Address</th>
                <td><%= customer.getCustomerAddress()%></td>
            </tr>
            <tr>
                <th>Username</th>
                <td><%= customer.getUsername()%></td>
            </tr>
            <tr>
                <th>Status</th>
                <td><%= customer.getStatus()%></td>
            </tr>
        </table>

        <%
            if (staff != null && "Admin".equals(staff.getRole())) {
                if ("Active".equals(customer.getStatus())) {
        %>
            <form action="DeleteCustomerController" method="post" onsubmit="return confirmAction('Delete');">
            <input type="hidden" name="id" value="<%= customer.getCustomerID()%>">
            <input type="submit" value="Lock">
        </form>
        <%
                }
            }
        %>

        <div style="text-align: center; ">
            <a style="text-align: center; background-color: #ccffcc "href="ViewListCustomersController">Back to list</a>
        </div>
        <%
        } else {
        %>
        <p class="customer-not-found">Customer not found!</p>
        <% }%>
    </div>
</body>
</html>
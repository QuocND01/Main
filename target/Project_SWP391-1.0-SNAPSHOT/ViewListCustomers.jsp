<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, Model.Customers" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Customer List</title>
        <style>
            table {
                width: 80%;
                border-collapse: collapse;
                margin: 20px auto;
            }
            th, td {
                padding: 10px;
                border: 1px solid black;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            a {
                text-decoration: none;
                color: blue;
            }
            a {
                text-decoration: none;
                color: white;
                background-color: blue;
                padding: 5px 10px;
                border-radius: 5px;
                display: inline-block;
            }
            a:hover {
                background-color: darkblue;
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
        <h2>Customer List</h2>
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
                <td><%= c.getCustomerID()%></td>
                <td><%= c.getCustomerName()%></td>
                <td><%= c.getCustomerPNB()%></td>
                <td><%= c.getStatus()%></td>
                <td>
                    <a href="ViewCustomerDetailsController?id=<%= c.getCustomerID()%>">Details</a>
                </td>
            </tr>
            <% }%>
        </table>
    </body>
</html>

<%-- 
    Document   : RestockWarehouse
    Created on : Apr 3, 2025, 5:26:21 PM
    Author     : Tran Phuc Vinh - CE182381
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            /* Custom Styling */
            body {
                display: flex;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7fc;
                margin: 0;
                padding: 20px;
                color: #555;
            }
            .header {
                position: fixed;
                top: 0;
                left: 250px;
                width: calc(100% - 250px);
                height: 110px;
                background: #e91e63;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
                z-index: 1000;
            }
            .sidebar {

                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                height: 100vh;
                background: #343a40;
                padding-top: 20px;

            }
            .sidebar a {
                display: block;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
            }

            .content {
                margin-left: 250px;
                margin-top: 60px;
                padding: 20px;
                flex: 1;
                color: white;
            }

            .logo img {
                width: 70px;
                height: auto;
                border-radius: 5px;
            }





            .container {
                left: 250px;
                background-color: #fff;
                padding: 5px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 3000px;
                margin-top: 10px;
                margin: 250px;
                margin-right: 10px;
            }
            h1 {
                text-align: center;
                color: white;
                margin-bottom: 30px;
                font-size: 36px;
                font-weight: bold;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
            }
            table th, table td {
                padding: 12px 15px;
                text-align: center;
                font-size: 14px;
                border-bottom: 1px solid #e0e0e0;
            }
            table thead th {
                background-color: #3c40c6;
                color: #fff;
                text-transform: uppercase;
            }

            .table {
                width: 100%;
                table-layout: fixed;
            }

        </style>
    </head>
    <body>
        <div class="sidebar" id="mySidebar">
            <div class="logo">
                <a href="viewBookAdminController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo" height="40">
                </a>
            </div>
            <a href="view-new-order">All Orders</a>
            <a href="ManageCustomersController">Manage Customers</a>
            <a href="VoucherController">Manage Vouchers</a>
            <a href="DeliveryunitController">Manage Delivery Units</a>
            <a href="viewCategory">Categories</a>
            <a href="ViewWarehouseController">View Warehouse</a>
            <a href="AuthorController">View Authors</a>
            <a href="WarehouseController" method="get">View Warehouse</a>

            <a href="logout" class="btn btn-danger w-100">Logout</a>
            <c:if test="${role == 'Admin'}">
                <a href="viewstaff">All Staff</a>
                <a href="InsertBookView.jsp">Insert Book</a>
            </c:if>
        </div>

        <!-- Header -->
        <div class="header">

            <div class="content">
                <h1>Dashboard</h1>           
            </div>
            <form class="d-flex" method="get" action="searchBookAdmin">
                <input type="text" class="form-control me-2" placeholder="Enter to search" name="search">
                <button class="btn btn-light" type="submit">Search</button>
            </form>
        </div>
        <div class="container mt-4">
            <h2 class="text-center">Import Warehouse</h2>

            <!-- Form để nhập thông tin nhập kho -->
            <form action="ImportWarehouseController" method="post">
                <!-- Nhập tên nhà cung cấp một lần -->
                <div class="form-group">
                    <label for="supplierName">Supplier Name</label>
                    <input type="text" class="form-control" id="supplierName" name="supplierName" required>
                </div>

                <!-- Bảng nhập thông tin sách -->
                <table class="table table-bordered" id="importTable">
                    <thead class="thead-dark">
                        <tr>
                            <th>Book ID</th>
                            <th>Import Quantity</th>
                            <th>Import Book Value</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" name="bookID[]" class="form-control" required></td>
                            <td><input type="number" name="importQuantity[]" class="form-control" required></td>
                            <td><input type="number" step="0.01" name="importBookValue[]" class="form-control" required></td>
                            <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Remove</button></td>
                        </tr>
                    </tbody>
                </table>

                <button type="button" class="btn btn-success mb-3" onclick="addRow()">Add Row</button>

                <!-- Nút gửi form -->
                <button type="submit" class="btn btn-primary mb-3">Create Import</button>
            </form>
        </div>


    </body>
    <script>
        function addRow() {
            var table = document.getElementById("importTable").getElementsByTagName('tbody')[0];
            var row = table.insertRow();
            row.innerHTML = `
            <td><input type="text" name="bookID[]" class="form-control" required></td>
            <td><input type="number" name="importQuantity[]" class="form-control" required></td>
            <td><input type="number" step="0.01" name="importBookValue[]" class="form-control" required></td>
            <td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Remove</button></td>
        `;
        }

        function removeRow(button) {
            var row = button.parentNode.parentNode;
            row.parentNode.removeChild(row);
        }
    </script>

</html>

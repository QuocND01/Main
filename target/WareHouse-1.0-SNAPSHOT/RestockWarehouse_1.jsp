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
                text-align: center;
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
                background-color: #fff;
                padding: 5px;

                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 3000px;
                margin-left: 226px;
                margin-top: 100px;
                margin-right:-30px;
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
                background-color: #e91e63;
                color: #fff;
                text-transform: uppercase;
            }

            .table {
                width: 100%;
                table-layout: fixed;
            }
            /* Định dạng chung cho các input trong bảng */
            .form-control {
                padding: 10px 12px; /* Tăng kích thước padding để input dễ nhìn */
                font-size: 1rem;
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            /* Khi input focus (chọn vào) sẽ có viền màu xanh */
            .form-control:focus {
                border-color: #66afe9;
                box-shadow: 0 0 5px rgba(102, 175, 233, .8);
            }

            /* Định dạng cho bảng nhập liệu */
            .table input.form-control {
                height: 30px;
                font-size: 1rem;
            }

            /* Cảnh báo lỗi */
            .alert-danger {
                border-radius: 5px;
                padding: 15px;
                font-size: 1rem;
                color: red;

                border-color: #f5c6cb;
                margin-bottom: 15px;
            }

            /* Canh giữa các input trong table */
            .table input {
                text-align: center;
            }

            /* Cải thiện khoảng cách giữa các nút */
            .btn {
                padding: 8px 15px;
                font-size: 1rem;
                border-radius: 5px;
            }
            /* Footer */
            .footer {
                background-color: #f8f8f8;
                padding: 20px 0;
                font-size: 14px;
                color: #666;
                text-align: center;
                border-top: 1px solid #e0e0e0;
                margin-top:200px;
            }

            .footer-top {
                margin-bottom: 10px;
            }

            .footer-top p {
                color: #888;
                font-size: 12px;
                margin-bottom: 5px;
            }

            .country-links a {
                color: #007bff;
                margin: 0 5px;
                text-decoration: none;
                font-size: 12px;
            }

            .country-links a:hover {
                text-decoration: underline;
            }

            .footer-middle {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 10px;
            }

            .policy-links a {
                color: #007bff;
                margin: 0 10px;
                text-decoration: none;
                font-size: 14px;
            }

            .policy-links a:hover {
                text-decoration: underline;
            }

            .registration-icons img {
                height: 40px;
                margin: 0 10px;
            }

            .footer-bottom {
                color: #888;
                font-size: 12px;
                line-height: 1.5;
            }

            .footer-bottom a {
                color: #007bff;
                text-decoration: none;
            }
            
            .footer-bottom a:hover {
                text-decoration: underline;
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
                <h1>New Import</h1>           
            </div>

        </div>
        <div class="container mt-4">
            <!-- Form để nhập thông tin nhập kho -->
            <form action="ImportWarehouseController" method="post">
                <!-- Nhập tên nhà cung cấp một lần -->
                <div class="form-group">
                    <label for="supplierName">Supplier Name</label>
                    <input type="text" class="form-control" id="supplierName" name="supplierName" required>
                </div>
                <div id="formError" class="alert alert-danger d-none" role="alert"></div>

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

        document.querySelector("form").addEventListener("submit", function (e) {
            const errorBox = document.getElementById("formError");
            errorBox.classList.add("d-none");
            errorBox.innerHTML = "";

            const supplierName = document.getElementById("supplierName").value.trim();
            if (supplierName === "") {
                showError("Supplier name cannot be empty.");
                e.preventDefault();
                return;
            }

            const rows = document.querySelectorAll("#importTable tbody tr");
            for (let i = 0; i < rows.length; i++) {
                const bookID = rows[i].querySelector("input[name='bookID[]']").value.trim();
                const quantity = rows[i].querySelector("input[name='importQuantity[]']").value.trim();
                const value = rows[i].querySelector("input[name='importBookValue[]']").value.trim();

                if (!/^B\d+$/.test(bookID)) {
                    showError(`Row ${i + 1}: Book ID must be like B1, B2, etc.`);
                    e.preventDefault();
                    return;
                }

                if (!/^\d+$/.test(quantity) || parseInt(quantity) <= 0) {
                    showError(`Row ${i + 1}: Import Quantity must be a positive integer.`);
                    e.preventDefault();
                    return;
                }

                if (!/^\d+(\.\d+)?$/.test(value) || parseFloat(value) <= 0) {
                    showError(`Row ${i + 1}: Import Book Value must be a positive number.`);
                    e.preventDefault();
                    return;
                }
            }

            function showError(message) {
                errorBox.innerHTML = message;
                errorBox.classList.remove("d-none");
            }
        });
    </script>
    <div class="footer">
        <div class="footer-top">
            <p>© 2024 FPT Book Store. All rights reserved.</p>
            <div class="country-links">
                <a href="#">Singapore</a> | <a href="#">Indonesia</a> | <a href="#">Thailand</a> | 
                <a href="#">Malaysia</a> | <a href="#">Vietnam</a> | <a href="#">Philippines</a> | 
                <a href="#">Brazil</a> | <a href="#">Mexico</a> | <a href="#">Colombia</a> | 
                <a href="#">Chile</a> | <a href="#">Taiwan</a>
            </div>
        </div>
        <div class="footer-middle">
            <div class="policy-links">
                <a href="#">Privacy Policy</a> | 
                <a href="#">Terms of Service</a> | 
                <a href="#">Shipping Policy</a> | 
                <a href="#">Return and Refund Policy</a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>Address: Area 6, An Binh Ward, Ninh Kieu District, Can Tho City, Can Tho 920000, Can Tho.</p>
            <p>Support Hotline: 0947791848 - Email: <a href="mailto:KhanhLNCE181093@fpt.edu.vn">KhanhLNCE181093@fpt.edu.vn</a></p>
            <p>Business Registration Number: 0106773786 issued by Group 4 SE1807 on February 10, 2024.</p>
        </div>
    </div>
</html>

<%-- 
    Document   : ViewAuthors
    Created on : Mar 11, 2025, 1:47:01 PM
    Author     : Tran Phuc Vinh - CE182381
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Author List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            .sidebar a:hover {
                background: #495057;
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
            h2 {
                text-align: center;
                color: #e91e63;
                font-weight: 700;
                margin-bottom: 30px;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .container{
                margin-left: 226px;
            }
            thead {
                background-color: #e91e63;
                color: #fff;
            }

            th, td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #f0f0f0;
            }

            tbody tr:hover {
                background-color: #f1f1f1;
            }

            .btn {
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 14px;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-primary {
                background-color: #3498db;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #2980b9;
                transform: translateY(-3px);
            }

            .btn-danger {
                background-color: #e74c3c;
                color: #fff;
            }

            .btn-danger:hover {
                background-color: #c0392b;
                transform: translateY(-3px);
            }

            .form-control {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .modal-header {
                background-color: #e91e63;
                color: white;
            }

            .alert {
                text-align: center;
                font-weight: bold;
            }
            th {
                background-color: #e91e63 !important;
                color: white !important;
                text-transform: uppercase;
                padding: 15px;
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
        <c:set var="role" value="${sessionScope.role}" />
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
            <a href="WarehouseController">View Warehouse</a>
            <a href="AuthorController">View Authors</a>
            <c:if test="${role == 'Admin'}">
                <a href="viewstaff">All Staff</a>
                <a href="InsertBookView.jsp">Insert Book</a>
            </c:if>

            <a href="logout" class="btn btn-danger w-100">Logout</a>

        </div>

        <!-- Header -->
        <div class="header">

            <div class="content">
                <h1>Authors Management</h1>           
            </div>
            
        </div>
        <div class="container mt-4">
            <h2>Author Management</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover table-bordered text-center align-middle">
                    <tr>
                    <form action="AuthorController" method="post">
                        <input type="hidden" name="action" value="add">
                        <td></td>
                        <td><input type="text" name="authorName" required class="form-control"></td>
                        <td>
                            <button type="submit" class="btn btn-success">Add New Author</button>
                        </td>
                    </form>
                    </tr>
                    <thead>
                        <tr>
                            <th>Author ID</th>
                            <th>Author Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty authorsList}">
                                <c:forEach var="author" items="${authorsList}">
                                    <tr>
                                        <td>${author.authorID}</td>
                                        <td>${author.authorName}</td>
                                        <td>
                                            <button class="btn btn-primary btn-sm" onclick="openUpdateModal('${author.authorID}', '${author.authorName}')">Update</button>
                                            <button class="btn btn-danger btn-sm" onclick="openDeleteModal('${author.authorID}')">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3" class="text-center">No authors found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>

                        <!-- Form thêm tác giả -->
                        
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Update Modal -->
        <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateModalLabel">Update Author</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="updateForm" action="AuthorController" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="authorID" id="updateAuthorID">
                            <input type="hidden" name="status" id="updateStatus"> <!-- Ẩn trường Status -->

                            <div class="mb-3">
                                <label for="updateAuthorName" class="form-label">Author Name</label>
                                <input type="text" name="authorName" id="updateAuthorName" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Delete Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this author?
                    </div>
                    <div class="modal-footer">
                        <form id="deleteForm" action="AuthorController" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="authorID" id="deleteAuthorID">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function openUpdateModal(id, name) {
                document.getElementById('updateAuthorID').value = id;
                document.getElementById('updateAuthorName').value = name;
                new bootstrap.Modal(document.getElementById('updateModal')).show();
            }

            function openDeleteModal(id) {
                document.getElementById('deleteAuthorID').value = id;
                new bootstrap.Modal(document.getElementById('deleteModal')).show();
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, Model.Customers, Model.Staffs" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Customers</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script>
            function showCustomerDetails(customerId) {
                document.getElementById("customerModal").style.display = "block";

                fetch('ManageCustomersController?action=details&id=' + customerId)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Customer not found');
                            }
                            return response.json();
                        })
                        .then(data => {
                            document.getElementById("customerID").textContent = data.customerID;
                            document.getElementById("customerName").textContent = data.customerName;
                            document.getElementById("customerEmail").textContent = data.customerEmail;
                            document.getElementById("customerPNB").textContent = data.customerPNB;
                            document.getElementById("customerAddress").textContent = data.customerAddress;
                            document.getElementById("customerUsername").textContent = data.customerUsername;

                            const deleteButton = document.getElementById("deleteButton");
                            if (deleteButton) {
                                if (data.customerStatus === "Active") {
                                    deleteButton.style.display = "block";
                                    deleteButton.onclick = function () {
                                        showDeleteConfirmation(data.customerID, data.customerName);
                                        closeModal();
                                    };
                                } else {
                                    deleteButton.style.display = "none";
                                }
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error loading customer details: ' + error.message);
                        });
            }

            function closeModal() {
                document.getElementById("customerModal").style.display = "none";
            }

            window.onclick = function (event) {
                const modal = document.getElementById("customerModal");
                const deleteOverlay = document.getElementById("delete-overlay");

                if (event.target == modal) {
                    modal.style.display = "none";
                }

                if (event.target == deleteOverlay) {
                    deleteOverlay.style.display = "none";
                }
            }

            function showDeleteConfirmation(customerId, customerName) {
                document.getElementById("customerId").value = customerId;

                if (customerName) {
                    document.getElementById("delete-message").textContent =
                            `Are you sure you want to delete customer ${customerName}?`;
                } else {
                    document.getElementById("delete-message").textContent =
                            "Are you sure you want to delete this customer?";
                }

                document.getElementById("confirm-delete-btn").onclick = function () {
                    document.getElementById("deleteForm").submit();
                };

                document.getElementById("delete-overlay").style.display = "block";
            }

            function hidePopup(overlayId) {
                document.getElementById(overlayId).style.display = "none";
            }

            function showSuccessMessage() {
                const successMessage = document.getElementById("successMessage");
                if (successMessage.textContent.trim() !== "") {
                    successMessage.style.display = "block";

                    setTimeout(function () {
                        successMessage.style.display = "none";
                    }, 5000);
                }
            }

            window.onload = function () {
                showSuccessMessage();
            };
        </script>
        <style>
            /* All your existing CSS styles remain unchanged */
            body {

                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7fc;
                margin-left: 226px;
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
                max-width: 1600px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 25px;
            }

            .main{
                padding-top: 110px;
                padding-left: 20px;
            }

            table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background-color: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

table thead tr:first-child th:first-child {
    border-top-left-radius: 12px;
}

table thead tr:first-child th:last-child {
    border-top-right-radius: 12px;
}

table tbody tr:last-child td:first-child {
    border-bottom-left-radius: 12px;
}

table tbody tr:last-child td:last-child {
    border-bottom-right-radius: 12px;
}

            h1{
                font-size: 32px;
            }

            h2 {
                color: var(--primary);
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #eee;
                font-weight: 600;
                text-align: center;
            }

            /* Success Message */
            .success-message {
                display: none;
                background-color: var(--success);
                color: white;
                padding: 15px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                text-align: center;
                animation: fadeIn 0.3s;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
            }
            table th {
                background-color: #e91e63;

            }
            th {
                background-color: var(--primary);
                color: white;
                padding: 15px 20px;
                text-align: left;
                font-weight: 500;
            }

            td {
                padding: 12px 20px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
            }

            tr:last-child td {
                border-bottom: none;
            }

            tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            tr:hover {
                background-color: #e6f2ff;
            }

            /* Status Indicators */
            .status-active {
                color: var(--success);
                font-weight: 500;
            }

            .status-inactive {
                color: var(--danger);
                font-weight: 500;
            }

            /* Action Links */
            .action-link {
                color: #3a86ff;
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
            }

            .action-link:hover {
                color: var(--secondary);
                text-decoration: underline;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                animation: fadeIn 0.3s;
            }

            .modal-content {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 25px;
                border-radius: var(--border-radius);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                width: 90%;
                max-width: 600px;
                animation: slideIn 0.3s;
            }

            .close {
                color: var(--gray);
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
                transition: var(--transition);
            }

            .close:hover {
                color: var(--dark);
            }

            /* Button Styles */
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-danger {
                background-color: var(--danger);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
            }

            .btn-danger:hover {
                background-color: #b10012;
                transform: translateY(-2px);
                box-shadow: var(--box-shadow);
            }

            .btn-secondary {
                background-color: var(--gray);
                color: white;
            }

            .btn-secondary:hover {
                background-color: #6c757d;
                transform: translateY(-2px);
                box-shadow: var(--box-shadow);
            }

            /* Delete Confirmation Popup */
            .popup-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                animation: fadeIn 0.3s;
            }

            .popup {
                position: relative;
                background-color: white;
                margin: 10% auto;
                padding: 30px;
                width: 90%;
                max-width: 500px;
                border-radius: var(--border-radius);
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
                animation: slideIn 0.3s;
            }

            .delete-popup {
                text-align: center;
            }

            .delete-popup i {
                font-size: 48px;
                color: var(--danger);
                margin-bottom: 15px;
            }

            .delete-popup h2 {
                color: var(--danger);
                margin-bottom: 10px;
            }

            .delete-popup p {
                margin-bottom: 25px;
                color: var(--dark);
            }

            .delete-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            /* Animations */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    transform: translate(-50%, -60%);
                    opacity: 0;
                }
                to {
                    transform: translate(-50%, -50%);
                    opacity: 1;
                }
            }

            /* Responsive Styles */
            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                .container {
                    padding: 15px;
                }

                th, td {
                    padding: 10px 15px;
                }

                .modal-content {
                    width: 95%;
                    padding: 15px;
                }

                .popup {
                    width: 95%;
                    margin: 20% auto;
                    padding: 20px;
                }

                .btn {
                    padding: 8px 16px;
                }
            }

            /* Footer */
            .footer {
                background-color: #f8f8f8;
                padding: 20px 0;
                font-size: 14px;
                color: #666;
                text-align: center;
                border-top: 1px solid #e0e0e0;
                margin-top: 200px;
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
            table th {
                background-color: #e91e63;
                color: white;
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
            <a href="view-new-order">Manage Orders</a>
            <a href="ManageCustomersController">Manage Customers</a>
            <a href="VoucherController">Manage Vouchers</a>
            <c:if test="${role == 'Admin'}">
                <a href="DeliveryunitController">Manage Delivery Units</a>
            </c:if>
            <a href="viewCategory">Manage Categories</a>
            <a href="WarehouseController">Manage Warehouse</a>
            <a href="AuthorController">Manage Authors</a>
            <c:if test="${role == 'Admin'}">
                <a href="viewstaff">Manage Staff</a>
            </c:if>

            <a href="logout" class="btn btn-danger w-100" 
               style="background-color: #e91e63;
               color: white;
               font-size: 16px;
               text-align: center;
               border-radius: 12px;"
               onmouseover="this.style.backgroundColor = '#495057'" 
               onmouseout="this.style.backgroundColor = '#e91e63'">
                Logout
            </a>
        </div>
    </div>

    <!-- Header -->
    <div class="header">
        <div class="content">
            <h1>Customers Management</h1>           
        </div>
    </div>
    <div class="main">
        <div class="container">
            <div id="successMessage" class="success-message">
                <% String successMessage = (String) session.getAttribute("successMessage");
                    if (successMessage != null && !successMessage.isEmpty()) {
                        out.print(successMessage);
                        session.removeAttribute("successMessage");
                    }
                %>
            </div>

            <table class="table">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Actions</th>
                </tr>
                <%
                    ArrayList<Customers> customersList = (ArrayList<Customers>) request.getAttribute("customersList");
                    if (customersList != null) {
                        for (Customers c : customersList) {
                %>
                <tr>
                    <td><%= c.getCustomerID()%></td>
                    <td><%= c.getCustomerName()%></td>
                    <td><%= c.getCustomerPNB()%></td>

                    <td>
                        <span class="action-link" onclick="showCustomerDetails('<%= c.getCustomerID()%>')">Details</span>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </table>

            <div id="customerModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h2>Customer Details</h2>
                    <table>
                        <tr>
                            <th >ID</th>
                            <td id="customerID"></td>
                        </tr>
                        <tr>
                            <th>Name</th>
                            <td id="customerName"></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td id="customerEmail"></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td id="customerPNB"></td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td id="customerAddress"></td>
                        </tr>
                        <tr>
                            <th>Username</th>
                            <td id="customerUsername"></td>
                        </tr>
                    </table>

                    <%
                        Staffs staff = (Staffs) session.getAttribute("account");
                        if (staff != null && "Admin".equals(staff.getRole())) {
                    %>
                    <div style="text-align: right; margin-top: 20px;">
                        <button id="deleteButton" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Customer
                        </button>
                    </div>
                    <% }%>
                </div>
            </div>

            <div id="delete-overlay" class="popup-overlay">
                <div class="popup delete-popup">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h2>Confirm Delete</h2>
                    <p id="delete-message">Are you sure you want to delete this customer?</p>

                    <div class="delete-buttons">
                        <button type="button" class="btn btn-danger" id="confirm-delete-btn">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="hidePopup('delete-overlay')">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </div>
            </div>

            <form id="deleteForm" action="ManageCustomersController" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="customerId" name="id" value="">
            </form>
        </div>
    </div>

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
</body>

</html>
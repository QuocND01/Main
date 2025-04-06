<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Deliveryunits"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Delivery Units</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            body {
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7fc;
                margin-left: 226px;
                margin-top: 10px;
                padding: 20px;
                color: #555;
            }

            .main{
                padding-top: 100px;
                padding-left: 20px;
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
                height: 44px;
            }
            .sidebar a:hover {
                background: #495057;
            }
            .content {
                color: white;
                padding: 20px;
                flex: 1;
                color: white;
            }

            .logo img {
                width: 70px;
                height: auto;
                border-radius: 5px;
            }

            .logo a {
                height: 90px;
            }
            :root {
                --primary: #e91e63;
                --secondary: #4361ee;
                --success: #38b000;
                --danger: #d90429;
                --warning: #ffb703;
                --light: #f8f9fa;
                --dark: #212529;
                --gray: #adb5bd;
                --border-radius: 8px;
                --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Arial, sans-serif;
            }

            .container {
                max-width: 1600px;
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 25px;
            }

            h1 {
                padding-bottom: 15px;
                text-align: center;
                font-weight: 600;
            }

            h2 {
                color: var(--primary);
                margin-bottom: 20px;
            }

            .alert {
                padding: 15px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                position: relative;
                animation: fadeIn 0.5s;
                transition: opacity 0.3s ease;
                display: flex;
                align-items: center;
            }

            .alert i {
                margin-right: 10px;
                font-size: 18px;
            }

            .alert-success {
                background-color: rgba(56, 176, 0, 0.15);
                color: var(--success);
                border-left: 4px solid var(--success);
            }

            .alert-error {
                background-color: rgba(217, 4, 41, 0.15);
                color: var(--danger);
                border-left: 4px solid var(--danger);
            }

            .alert-close {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 20px;
                cursor: pointer;
                opacity: 0.7;
                transition: opacity 0.3s;
            }

            .alert-close:hover {
                opacity: 1;
            }

            .actions {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
            }

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

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--secondary);
                transform: translateY(-2px);
                box-shadow: var(--box-shadow);
            }

            .btn-danger {
                background-color: var(--danger);
                color: white;
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

            .status-badge {
                display: inline-block;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: 500;
                text-transform: uppercase;
            }

            .status-active {
                background-color: rgba(56, 176, 0, 0.15);
                color: var(--success);
                border: 1px solid var(--success);
            }

            .status-inactive {
                background-color: rgba(217, 4, 41, 0.15);
                color: var(--danger);
                border: 1px solid var(--danger);
            }

            .table-container {
                overflow-x: auto;
                margin: 20px 0;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                border-radius: var(--border-radius);
                overflow: hidden;
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

            /* Delete confirmation popup styling */
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

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--dark);
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: var(--border-radius);
                font-size: 16px;
                transition: var(--transition);
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            select:focus {
                border-color: var(--primary);
                outline: none;
                box-shadow: 0 0 0 3px rgba(58, 134, 255, 0.25);
            }

            .form-buttons {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 25px;
            }

            #errorMessage {
                background-color: rgba(217, 4, 41, 0.1);
                color: var(--danger);
                padding: 12px;
                border-radius: var(--border-radius);
                margin-top: 15px;
                font-size: 14px;
                display: none;
            }

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
                    transform: translateY(-30px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                .container {
                    padding: 15px;
                }

                .popup {
                    width: 95%;
                    margin: 20% auto;
                    padding: 20px;
                }

                td, th {
                    padding: 10px 15px;
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

        <!-- Header -->
        <div class="header">

            <div class="content">
                <h1><i class="fas fa-truck"></i> Delivery Units Management</h1>       
            </div>

        </div>
        <div class="main">
            <div class="container">


                <% if (request.getAttribute("message") != null) {%>
                <div class="alert alert-success" id="serverMessage">
                    <i class="fas fa-check-circle"></i> <%= request.getAttribute("message")%>
                    <span class="alert-close" onclick="this.parentElement.remove()">&times;</span>
                </div>
                <script>
                    setTimeout(function () {
                        var message = document.getElementById('serverMessage');
                        if (message) {
                            message.style.opacity = '0';
                            setTimeout(function () {
                                message.remove();
                            }, 300);
                        }
                    }, 5000);
                </script>
                <% } %>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-error" id="serverError">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error")%>
                    <span class="alert-close" onclick="this.parentElement.remove()">&times;</span>
                </div>
                <script>
                    setTimeout(function () {
                        var error = document.getElementById('serverError');
                        if (error) {
                            error.style.opacity = '0';
                            setTimeout(function () {
                                error.remove();
                            }, 300);
                        }
                    }, 5000);
                </script>
                <% } %>

                <div class="actions">
                    <button class="btn btn-primary" onclick="showPopup('add')">
                        <i class="fas fa-plus"></i> Add Delivery Unit
                    </button>
                </div>

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Unit ID</th>
                                <th>Unit Name</th>
                                <th>Unit Fee</th>
                                <th>Unit Speed</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ArrayList<Deliveryunits> unitList = (ArrayList<Deliveryunits>) request.getAttribute("unitList");
                                for (Deliveryunits unit : unitList) {
                            %>
                            <tr>
                                <td><%= unit.getUnitID()%></td>
                                <td><strong><%= unit.getUnitName()%></strong></td>
                                <td>$<%= String.format("%.2f", unit.getUnitFee())%></td>
                                <td><%= unit.getUnitSpeed()%></td>
                                <td>
                                    <% if ("Active".equals(unit.getUnitStatus())) {%>
                                    <button class="btn btn-primary" onclick="showPopup('update', '<%= unit.getUnitID()%>', '<%= unit.getUnitName()%>', <%= unit.getUnitFee()%>, '<%= unit.getUnitSpeed()%>')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn btn-danger" onclick="showChangeStatusConfirmation('<%= unit.getUnitID()%>', '<%= unit.getUnitName()%>')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                    <% } else { %>
                                    <button class="btn btn-secondary" disabled>
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn btn-secondary" disabled>
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                    <% } %>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <!-- Status Change Confirmation Popup -->
        <div id="status-change-overlay" class="popup-overlay">
            <div class="popup delete-popup">
                <i class="fas fa-exclamation-triangle"></i>
                <h2>Confirm Status Change</h2>
                <p id="status-change-message">Are you sure you want to deactivate this delivery unit?</p>

                <div class="delete-buttons">
                    <button type="button" class="btn btn-danger" id="confirm-status-change-btn">
                        <i class="fas fa-toggle-off"></i> Delete
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="hidePopup('status-change-overlay')">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </div>
        </div>
        <div id="popup-overlay" class="popup-overlay">
            <div class="popup">
                <h2 id="popup-title"><i class="fas fa-plus-circle"></i> Add Delivery Unit</h2>
                <form action="DeliveryunitController" method="post" id="unitForm">
                    <input type="hidden" id="action" name="action" value="add">
                    <input type="hidden" id="unitID" name="unitID">

                    <div class="form-group">
                        <label for="unitName">Unit Name:</label>
                        <input type="text" id="unitName" name="unitName" placeholder="Enter delivery unit name (letters and numbers only)" required>
                    </div>

                    <div class="form-group">
                        <label for="unitFee">Unit Fee ($):</label>
                        <input type="number" id="unitFee" name="unitFee" step="0.01" min="0.01" placeholder="Enter unit fee (greater than 0)" required>
                    </div>

                    <div class="form-group">
                        <label for="unitSpeed">Unit Speed:</label>
                        <!-- This input will be replaced by JavaScript with a select element -->
                        <input type="text" id="unitSpeed" name="unitSpeed" placeholder="Enter unit speed" required>
                    </div>

                    <div id="errorMessage" style="display: none; color: red; margin-bottom: 10px;"></div>

                    <div class="form-buttons">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="hidePopup('popup-overlay')">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Hidden form for status change action -->
        <form id="statusChangeForm" action="DeliveryunitController" method="post" style="display: none;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" id="statusChangeUnitID" name="unitID">
        </form>

        <script>
            function showPopup(action, unitID = '', unitName = '', unitFee = '', unitSpeed = '') {
                document.getElementById('popup-overlay').style.display = 'block';
                document.getElementById('action').value = action;
                document.getElementById('unitID').value = unitID;
                document.getElementById('unitName').value = unitName;
                document.getElementById('unitFee').value = unitFee;

                // Set the correct option in the dropdown
                const unitSpeedSelect = document.getElementById('unitSpeed');
                if (unitSpeedSelect) {
                    for (let i = 0; i < unitSpeedSelect.options.length; i++) {
                        if (unitSpeedSelect.options[i].value === unitSpeed) {
                            unitSpeedSelect.selectedIndex = i;
                            break;
                        }
                    }
                }

                // Update form title and icon based on action
                const popupTitle = document.getElementById('popup-title');
                if (action === 'add') {
                    popupTitle.innerHTML = '<i class="fas fa-plus-circle"></i> Add Delivery Unit';
                } else {
                    popupTitle.innerHTML = '<i class="fas fa-edit"></i> Edit Delivery Unit';
                }

                // Clear any error messages
                document.getElementById('errorMessage').style.display = 'none';
                document.getElementById('errorMessage').textContent = '';
            }

            function hidePopup(overlayId) {
                document.getElementById(overlayId).style.display = 'none';
                if (overlayId === 'popup-overlay') {
                    document.getElementById('unitForm').reset();
                }
            }

            function showChangeStatusConfirmation(unitID, unitName) {
                // Set the unit ID to change status
                document.getElementById('statusChangeUnitID').value = unitID;

                // Update confirmation message with unit name
                document.getElementById('status-change-message').textContent =
                        `Are you sure you want to deactivate "${unitName}"? This unit will be marked as inactive.`;

                // Set click handler for confirm button
                document.getElementById('confirm-status-change-btn').onclick = function () {
                    document.getElementById('statusChangeForm').submit();
                };

                // Show the status change confirmation popup
                document.getElementById('status-change-overlay').style.display = 'block';
            }

            // Close popup when clicking outside
            window.onclick = function (event) {
                var popupOverlay = document.getElementById('popup-overlay');
                var statusChangeOverlay = document.getElementById('status-change-overlay');

                if (event.target === popupOverlay) {
                    hidePopup('popup-overlay');
                }

                if (event.target === statusChangeOverlay) {
                    hidePopup('status-change-overlay');
                }
            };

            // Show temporary message function
            function showTemporaryMessage(message, type) {
                var alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + type;
                alertDiv.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + message;

                var closeButton = document.createElement('span');
                closeButton.innerHTML = '&times;';
                closeButton.className = 'alert-close';
                closeButton.onclick = function () {
                    alertDiv.remove();
                };
                alertDiv.appendChild(closeButton);

                var container = document.querySelector('.container');
                var h1 = container.querySelector('h1');
                h1.parentNode.insertBefore(alertDiv, h1.nextSibling);

                setTimeout(function () {
                    alertDiv.style.opacity = '0';
                    setTimeout(function () {
                        alertDiv.remove();
                    }, 300);
                }, 5000);
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Get form elements
                const unitForm = document.getElementById('unitForm');
                const unitNameInput = document.getElementById('unitName');
                const unitFeeInput = document.getElementById('unitFee');
                const unitSpeedInput = document.getElementById('unitSpeed');
                const errorMessage = document.getElementById('errorMessage');

                // Replace the unit speed text input with a select dropdown
                const unitSpeedContainer = unitSpeedInput.parentElement;
                const unitSpeedLabel = unitSpeedContainer.querySelector('label');

                // Create the select element
                const unitSpeedSelect = document.createElement('select');
                unitSpeedSelect.id = 'unitSpeed';
                unitSpeedSelect.name = 'unitSpeed';
                unitSpeedSelect.required = true;

                // Add options to the select element
                const speedOptions = ['Normal', 'Fast', 'Slow'];
                speedOptions.forEach(option => {
                    const optionElement = document.createElement('option');
                    optionElement.value = option;
                    optionElement.textContent = option;
                    unitSpeedSelect.appendChild(optionElement);
                });

                // Replace the text input with the select element
                unitSpeedInput.replaceWith(unitSpeedSelect);

                // Form validation
                unitForm.addEventListener('submit', function (event) {
                    // Reset error message
                    errorMessage.style.display = 'none';
                    errorMessage.textContent = '';

                    let hasErrors = false;

                    // Validate Unit Name (only allows letters and numbers)
                    if (!/^[a-zA-Z0-9\s]+$/.test(unitNameInput.value.trim())) {
                        showError('Unit Name can only contain letters and numbers');
                        hasErrors = true;
                    }

                    // Validate Unit Fee (positive number)
                    const feeValue = parseFloat(unitFeeInput.value);
                    if (isNaN(feeValue) || feeValue <= 0) {
                        showError('Unit Fee must be a number greater than 0');
                        hasErrors = true;
                    }

                    // If there are errors, prevent form submission
                    if (hasErrors) {
                        event.preventDefault();
                    }
                });

                // Function to show error message
                function showError(message) {
                    errorMessage.textContent = message;
                    errorMessage.style.display = 'block';
                    errorMessage.style.color = 'red';
                    errorMessage.style.marginBottom = '10px';
                }

                // When updating, set the correct option in the dropdown
                if (document.getElementById('action').value === 'update') {
                    const currentSpeed = unitSpeedSelect.getAttribute('data-current-speed');
                    if (currentSpeed) {
                        for (let i = 0; i < unitSpeedSelect.options.length; i++) {
                            if (unitSpeedSelect.options[i].value === currentSpeed) {
                                unitSpeedSelect.selectedIndex = i;
                                break;
                            }
                        }
                    }
                }
            });
        </script>
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
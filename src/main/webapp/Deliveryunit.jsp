<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Deliveryunits"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Delivery Units</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
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

            body {
                background-color: #f0f2f5;
                color: var(--dark);
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 25px;
            }

            h1 {
                color: var(--primary);
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #eee;
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
        </style>
    </head>
    <body>
        <div class="container">
            <div class="logo">
                <a href="/viewBookAdminController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
                <h1><i class="fas fa-truck"></i> Delivery Units Management</h1>
            </div>

            <% if (request.getAttribute("message") != null) {%>
            <div class="alert alert-success" id="serverMessage">
                <i class="fas fa-check-circle"></i> <%= request.getAttribute("message")%>
                <span class="alert-close" onclick="this.parentElement.remove()">&times;</span>
            </div>
            <script>
                // Auto-hide the server message after 5 seconds
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
                // Auto-hide the server error after 5 seconds
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
                            <th>Status</th>
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
                            <td>
                                <span class="status-badge status-<%= unit.getStatus().toLowerCase()%>">
                                    <%= unit.getStatus()%>
                                </span>
                            </td>
                            <td>
                                <% if ("Active".equals(unit.getStatus())) {%>
                                <button class="btn btn-primary" onclick="showPopup('update', '<%= unit.getUnitID()%>', '<%= unit.getUnitName()%>')">
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

        <!-- Add/Update Popup -->
        <div id="popup-overlay" class="popup-overlay">
            <div class="popup">
                <h2 id="popup-title"><i class="fas fa-plus-circle"></i> Add Delivery Unit</h2>
                <form action="DeliveryunitController" method="post" id="unitForm">
                    <input type="hidden" id="action" name="action" value="add">
                    <input type="hidden" id="unitID" name="unitID">

                    <div class="form-group">
                        <label for="unitName">Unit Name:</label>
                        <input type="text" id="unitName" name="unitName" placeholder="Enter delivery unit name" required>
                    </div>

                    <div id="errorMessage"></div>

                    <div class="form-buttons">
                        <!-- Buttons order: Save first, then Cancel -->
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

        <!-- Status Change Confirmation Popup -->
        <div id="status-change-overlay" class="popup-overlay">
            <div class="popup delete-popup">
                <i class="fas fa-exclamation-triangle"></i>
                <h2>Confirm Status Change</h2>
                <p id="status-change-message">Are you sure you want to deactivate this delivery unit?</p>

                <div class="delete-buttons">
                    <button type="button" class="btn btn-danger" id="confirm-status-change-btn">
                        <i class="fas fa-toggle-off"></i> Deactivate
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="hidePopup('status-change-overlay')">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </div>
        </div>

        <!-- Hidden form for status change action -->
        <form id="statusChangeForm" action="DeliveryunitController" method="post" style="display: none;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" id="statusChangeUnitID" name="unitID">
        </form>

        <script>
            function showPopup(action, unitID = '', unitName = '') {
                document.getElementById('popup-overlay').style.display = 'block';
                document.getElementById('action').value = action;
                document.getElementById('unitID').value = unitID;
                document.getElementById('unitName').value = unitName;

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
                // Create the alert element
                var alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + type;
                alertDiv.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + message;

                // Add a close button
                var closeButton = document.createElement('span');
                closeButton.innerHTML = '&times;';
                closeButton.className = 'alert-close';
                closeButton.onclick = function () {
                    alertDiv.remove();
                };
                alertDiv.appendChild(closeButton);

                // Insert at the top of the container
                var container = document.querySelector('.container');
                var h1 = container.querySelector('h1');
                h1.parentNode.insertBefore(alertDiv, h1.nextSibling);

                // Auto-hide after 5 seconds
                setTimeout(function () {
                    // Add fade-out animation
                    alertDiv.style.opacity = '0';
                    setTimeout(function () {
                        alertDiv.remove();
                    }, 300); // Wait for animation to complete
                }, 5000);
            }
        </script>
    </body>
</html>
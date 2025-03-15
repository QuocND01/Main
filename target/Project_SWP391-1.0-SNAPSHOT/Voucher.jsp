<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Vouchers</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>

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

            .alert {
                padding: 15px;
                border-radius: var(--border-radius);
                margin-bottom: 20px;
                position: relative;
                animation: fadeIn 0.5s;
                transition: opacity 0.3s ease;
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

            .status-badge {
                display: inline-block;
                padding: 5px 12px;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .status-active {
                background-color: rgba(56, 176, 0, 0.15);
                color: var(--success);
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
        </style>
    </head>
    <body>
        <div class="container">

            <div class="logo">
                <a href="/viewBookAdminController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
                <h1><i class="fas fa-ticket-alt"></i> Voucher Management</h1>
            </div>

            <!-- For server-side messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-${messageType}" id="serverMessage">
                    <i class="${messageType == 'success' ? 'fas fa-check-circle' : 'fas fa-exclamation-circle'}"></i> ${message}
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
            </c:if>

            <div class="actions">
                <button class="btn btn-primary" onclick="openAddPopup()">
                    <i class="fas fa-plus"></i> Add Voucher
                </button>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Voucher Code</th>
                            <th>Value</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${voucherList}">
                            <tr>
                                <td>${v.voucherID}</td>
                                <td><strong>${v.voucher}</strong></td>
                                <td>${v.value}%</td>
                                <td>
                                    <span class="status-badge ${v.status == 'Active' ? 'status-active' : 'status-inactive'}">${v.status}</span>
                                </td>
                                <td>
                                    <c:if test="${v.status == 'Active'}">
                                        <button class="btn btn-danger" onclick="deactivateVoucher('${v.voucherID}', '${v.voucher}')">
                                            Delete
                                        </button>
                                    </c:if>
                                    <c:if test="${v.status == 'Inactive'}">
                                        <button class="btn btn-secondary" disabled>
                                            <i class="fas fa-ban"></i> Deactivated
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="addVoucherPopup" class="popup-overlay">
            <div class="popup">
                <h2><i class="fas fa-plus-circle"></i> Add Voucher</h2>
                <form id="addVoucherForm">
                    <div class="form-group">
                        <label for="voucherName">Voucher Code:</label>
                        <input type="text" id="voucherName" name="voucherName" placeholder="Enter voucher code" required>
                    </div>

                    <div class="form-group">
                        <label for="value">Value (0-100%):</label>
                        <input type="number" id="value" name="value" placeholder="Enter discount percentage" min="0" max="100" required>
                    </div>

                    <div class="form-group">
                        <label for="status">Status:</label>
                        <select id="status" name="status">
                            <option value="Active">Active</option>
                        </select>
                    </div>

                    <div id="errorMessage"></div>

                    <div class="form-buttons">
                        <button type="button" class="btn btn-primary" onclick="addVoucher()">
                            <i class="fas fa-save"></i> Add
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="closeAddPopup()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function deactivateVoucher(voucherID, voucherCode) {
                // Update the message in the popup
                document.getElementById("deactivate-message").textContent =
                        "Are you sure you want to deactivate voucher " + voucherCode + "?";

                // Set up the confirmation button to navigate to the deactivation URL when clicked
                document.getElementById("confirm-deactivate-btn").onclick = function () {
                    window.location = 'VoucherController?action=deactivate&voucherID=' + voucherID;
                };

                // Show the popup
                document.getElementById("deactivate-overlay").style.display = "block";
            }

            function hidePopup(overlayId) {
                document.getElementById(overlayId).style.display = "none";
                if (overlayId === 'addVoucherPopup') {
                    document.getElementById("errorMessage").style.display = "none";
                    document.getElementById("addVoucherForm").reset();
                }
            }

// Close popup when clicking outside
            window.onclick = function (event) {
                var addVoucherPopup = document.getElementById('addVoucherPopup');
                var deleteOverlay = document.getElementById('deactivate-overlay');

                if (event.target === addVoucherPopup) {
                    hidePopup('addVoucherPopup');
                }

                if (event.target === deleteOverlay) {
                    hidePopup('deactivate-overlay');
                }
            };

            function openAddPopup() {
                document.getElementById("addVoucherPopup").style.display = "block";
                document.getElementById("voucherName").focus();
            }

            function closeAddPopup() {
                document.getElementById("addVoucherPopup").style.display = "none";
                document.getElementById("errorMessage").style.display = "none";
                document.getElementById("addVoucherForm").reset();
            }

            function addVoucher() {
                var voucherName = document.getElementById("voucherName").value;
                var value = document.getElementById("value").value;
                var status = document.getElementById("status").value;
                var errorMessage = document.getElementById("errorMessage");

                // Reset thông báo lỗi trước khi kiểm tra
                errorMessage.style.display = "none";
                errorMessage.textContent = "";

                // Kiểm tra giá trị value hợp lệ
                if (value < 0 || value > 100) {
                    errorMessage.textContent = "Value must be between 0 and 100!";
                    errorMessage.style.display = "block";
                    return; // Dừng việc gửi request nếu sai
                }

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "VoucherController", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var response = xhr.responseText.trim();

                        if (response === "invalid_value") {
                            errorMessage.textContent = "Value must be between 0 and 100!";
                            errorMessage.style.display = "block";
                        } else if (response === "error") {
                            errorMessage.textContent = "Duplicate voucher!";
                            errorMessage.style.display = "block";
                        } else if (response === "success") {
                            closeAddPopup();

                            // Create and show success message
                            var container = document.querySelector('.container');
                            var h1 = container.querySelector('h1');

                            var alertDiv = document.createElement('div');
                            alertDiv.className = 'alert alert-success';
                            alertDiv.innerHTML = '<i class="fas fa-check-circle"></i> Voucher added successfully!';

                            // Insert after h1
                            h1.parentNode.insertBefore(alertDiv, h1.nextSibling);

                            // Refresh voucher list
                            setTimeout(function () {
                                location.reload();
                            }, 1000); // Show message for 1 second before refreshing
                        }
                    }
                };

                xhr.send("voucherName=" + encodeURIComponent(voucherName) +
                        "&value=" + encodeURIComponent(value) +
                        "&status=" + encodeURIComponent(status));
            }

            // Add this function to your existing script
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

        <!-- Deactivate Confirmation Popup (optional, can be used instead of the JavaScript confirm) -->
        <div id="deactivate-overlay" class="popup-overlay" style="display: none;">
            <div class="popup delete-popup">
                <i class="fas fa-exclamation-triangle"></i>
                <h2>Confirm Deactivation</h2>
                <p id="deactivate-message">Are you sure you want to deactivate this voucher?</p>

                <div class="delete-buttons">
                    <button type="button" class="btn btn-danger" id="confirm-deactivate-btn">
                        <i class="fas fa-ban"></i> Deactivate
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="hidePopup('deactivate-overlay')">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </div>
        </div>
    </body>
</html>
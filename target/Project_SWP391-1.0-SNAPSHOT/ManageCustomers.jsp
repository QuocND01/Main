<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, Model.Customers, Model.Staffs" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Customers</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script>
            // Function to show the details popup
            function showCustomerDetails(customerId) {
                // Show modal/popup
                document.getElementById("customerModal").style.display = "block";

                // Get customer details via AJAX
                fetch('ManageCustomersController?action=details&id=' + customerId)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Customer not found');
                            }
                            return response.json();
                        })
                        .then(data => {
                            // Populate the modal with customer data
                            document.getElementById("customerID").textContent = data.customerID;
                            document.getElementById("customerName").textContent = data.customerName;
                            document.getElementById("customerEmail").textContent = data.customerEmail;
                            document.getElementById("customerPNB").textContent = data.customerPNB;
                            document.getElementById("customerAddress").textContent = data.customerAddress;
                            document.getElementById("username").textContent = data.username;

                            const statusElement = document.getElementById("status");
                            statusElement.textContent = data.status;
                            statusElement.className = data.status === "Active" ? "status-active" : "status-inactive";

                            // Set delete button visibility and action
                            const deleteButton = document.getElementById("deleteButton");
                            if (data.status === "Active") {
                                deleteButton.style.display = "block";
                                deleteButton.onclick = function () {
                                    showDeleteConfirmation(data.customerID, data.customerName);
                                    closeModal();
                                };
                            } else {
                                deleteButton.style.display = "none";
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error loading customer details: ' + error.message);
                        });
            }

            // Function to close the modal
            function closeModal() {
                document.getElementById("customerModal").style.display = "none";
            }

            // Close the modal when clicking outside of it
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

            // Function to show delete confirmation popup
            function showDeleteConfirmation(customerId, customerName) {
                // Set the customer ID to delete
                document.getElementById("customerId").value = customerId;

                // Update confirmation message with customer name
                if (customerName) {
                    document.getElementById("delete-message").textContent =
                            `Are you sure you want to delete customer ${customerName}?`;
                } else {
                    document.getElementById("delete-message").textContent =
                            "Are you sure you want to delete this customer?";
                }

                // Set click handler for confirm button
                document.getElementById("confirm-delete-btn").onclick = function () {
                    document.getElementById("deleteForm").submit();
                };

                // Show the delete confirmation popup
                document.getElementById("delete-overlay").style.display = "block";
            }

            // Function to hide popup
            function hidePopup(overlayId) {
                document.getElementById(overlayId).style.display = "none";
            }

            // Function to show success message
            function showSuccessMessage() {
                const successMessage = document.getElementById("successMessage");
                if (successMessage.textContent.trim() !== "") {
                    successMessage.style.display = "block";

                    // Hide success message after 5 seconds
                    setTimeout(function () {
                        successMessage.style.display = "none";
                    }, 5000);
                }
            }

            // When the page loads
            window.onload = function () {
                showSuccessMessage();
            };
        </script>
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
                position: relative;
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
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--box-shadow);
                margin-bottom: 20px;
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
        </style>
    </head>
    <body>
        <div class="container">
            <div class="logo">
                <a href="ViewBookCustomerController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
                <h2>Manage Customers</h2>
            </div>

            <!-- Success message div -->
            <div id="successMessage" class="success-message">
                <% String successMessage = (String) session.getAttribute("successMessage");
                    if (successMessage != null && !successMessage.isEmpty()) {
                        out.print(successMessage);
                        session.removeAttribute("successMessage"); // Clear the message after displaying
                    }
                %>
            </div>

            <!-- Customer list table -->
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
                    if (customersList != null) {
                        for (Customers c : customersList) {
                %>
                <tr>
                    <td><%= c.getCustomerID()%></td>
                    <td><%= c.getCustomerName()%></td>
                    <td><%= c.getCustomerPNB()%></td>
                    <td class="<%= "Active".equals(c.getStatus()) ? "status-active" : "status-inactive"%>">
                        <%= c.getStatus()%>
                    </td>
                    <td>
                        <span class="action-link" onclick="showCustomerDetails('<%= c.getCustomerID()%>')">Details</span>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </table>

            <!-- Customer Details Modal -->
            <div id="customerModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h2>Customer Details</h2>
                    <table>
                        <tr>
                            <th>ID</th>
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
                            <td id="username"></td>
                        </tr>
                        <tr>
                            <th>Status</th>
                            <td id="status"></td>
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

            <!-- Delete Confirmation Popup -->
            <div id="delete-overlay" class="popup-overlay">
                <div class="popup delete-popup">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h2>Confirm Delete</h2>
                    <p id="delete-message">Are you sure you want to delete this customer?</p>

                    <div class="delete-buttons">
                        <!-- Delete button first, then Cancel -->
                        <button type="button" class="btn btn-danger" id="confirm-delete-btn">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="hidePopup('delete-overlay')">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </div>
            </div>

            <!-- Hidden form for delete action -->
            <form id="deleteForm" action="ManageCustomersController" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="customerId" name="id" value="">
            </form>
        </div>
    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page - Webbansachsiucapvjppro</title>
        <!-- Bootstrap CDN -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            /* Custom Styling */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #ffe6f1;
                color: #333;
                padding: 20px;
            }

            .header {
                background-color: #ff6f91;
                color: white;
                border-radius: 8px;
                padding: 15px 30px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .logo img {
                width: 120px;
                height: auto;
                border-radius: 5px;
            }

            .logout-btn {
                background-color: #ff4757;
                border: none;
                color: white;
                border-radius: 5px;
                padding: 8px 16px;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .logout-btn:hover {
                background-color: #e84118;
            }

            .main-actions .btn {
                background-color: #0099ff;
                border: none;
                color: white;
                font-size: 16px;
                padding: 10px 20px;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.3s;
            }

            .main-actions .btn:hover {
                background-color: #003366;
                transform: translateY(-3px);
            }

            .book-card {
                border: none;
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
                overflow: hidden;
            }

            .book-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            }

            .book-card img {
                border-radius: 8px 8px 0 0;
            }

            .book-actions a {
                color: #28a745;
                font-weight: bold;
                text-decoration: none;
            }

            .book-actions a:hover {
                color: #218838;
            }

            .delete-btn {
                color: #ff4757;
                cursor: pointer;
                font-weight: bold;
                transition: color 0.3s;
            }

            .delete-btn:hover {
                color: #e84118;
            }

            .card-description {
                max-height: 3.6em;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                font-size: 14px;
                color: #555;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7fc;
                margin: 0;
                padding: 20px;
                color: #555;
            }
            .container {
                background-color: #fff;
                padding: 5px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 3000px;
                margin: auto;
            }
            h1 {
                text-align: center;
                color: #FF69B4;
                margin-bottom: 30px;
                font-size: 36px;
                font-weight: bold;
            }
            .btn-back {
                background-color: #FF69B4;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 14px;
                margin-bottom: 20px;
                display: inline-block;
                transition: background-color 0.3s;
            }
            .btn-back:hover {
                background-color: #575fcf;
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
            table tbody tr:nth-child(odd) {
                background-color: #f9f9f9; /* Light gray for odd rows */
            }
            table tbody tr:nth-child(even) {
                background-color: #ffffff; /* White for even rows */
            }
            .description {
                max-height: 40px;
                overflow: hidden;
                text-overflow: ellipsis;
                transition: max-height 0.3s;
                font-size: 13px;
                color: #666;
            }
            .description.expand {
                max-height: none;
            }
            .read-more {
                color: #3c40c6;
                cursor: pointer;
                font-size: 12px;
                display: block;
                text-align: left;
                margin-top: 5px;
            }
            .read-more:hover {
                text-decoration: underline;
            }
            .img-thumbnail {
                max-width: 50px;
                height: auto;
                cursor: pointer;
                border-radius: 5px;
            }
            .actions .btn {
                font-size: 12px;
                padding: 5px 10px;
                border: none;
                color: #fff;
                border-radius: 3px;
                margin: 2px;
                transition: background-color 0.3s;
            }
            .btn-update {
                background-color: #1abc9c;
            }
            .btn-update:hover {
                background-color: #16a085;
            }
            .btn-delete {
                background-color: #e74c3c;
            }
            .btn-delete:hover {
                background-color: #c0392b;
            }
            /* Modal Styling */
            .modal-content {
                border-radius: 10px;
            }
            .modal-header {
                border-bottom: none;
            }
            .modal-title {
                font-size: 18px;
                color: #3c40c6;
            }
            .modal-body img {
                border-radius: 10px;
            }
            .table {
                width: 100%;
                table-layout: fixed;
            }

        </style>
    </head>
    <body>
        <c:set var="role" value="${sessionScope.role}" />
        <div class="header d-flex justify-content-between align-items-center">
            <div class="logo">
                <a href="viewBookAdminController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>
            <form class="form-inline" method="get" action="searchBookAdmin">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Enter to search" name="search">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">Search</button>
                    </div>
                </div>
            </form>
            <a href="logout" class="btn logout-btn">Logout</a>
        </div>

        <div class="main-actions d-flex justify-content-between mb-4">
            <a href="InsertBookView.jsp" class="btn">Insert Book</a>
            <form action="viewBookController" method="post">
                <button type="submit" class="btn">All Order</button>
            </form>
            <form action="view-new-order" method="post">
                <button type="submit" class="btn">New Orders</button>
            </form>
            <form action="ViewListCustomersController" method="get">
                <button type="submit" class="btn">All Customer</button>
            </form>
            <!-- Chỉ hiển thị với Admin -->
            <c:if test="${role == 'Admin'}">
                <form action="viewstaff" method="post">
                    <button type="submit" class="btn">All Staff</button>
                </form>
            </c:if>
        </div>
            <form action="viewCategory" method="get">
                <button type="submit" class="btn">Categories</button>
            </form>
        </div>


        <div class="container">
            <h1>Book List</h1>


            <c:if test="${not empty l}">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Book Name</th>
                            <th>Supplier Name</th>
                            <th>Author</th>
                            <th>Publication Year</th>
                            <th>Weight</th>
                            <th>Size</th>
                            <th>Pages</th>
                            <th>Form</th>
                            <th>Describe</th>
                            <th>Image</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Category</th><!-- Added Quantity column -->
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${l}">
                            <tr>
                                <td>${b.bookName}</td>
                                <td>${b.supplierName}</td>
                                <c:forEach items="${author}" var="a">
                                    <c:if test = "${a.authorID == b.authorID}">
                                        <td>${a.authorName}</td>
                                    </c:if>
                                </c:forEach>
                                <td>${b.yearOfPublication}</td>
                                <td>${b.weight}</td>
                                <td>${b.size}</td>
                                <td>${b.numberOfPages}</td>
                                <td>${b.form}</td>
                                <td>
                                    <div class="description" id="desc-${b.bookID}">${b.describe}</div>
                                    <span class="read-more" id="read-more-${b.bookID}" onclick="toggleDescription('${b.bookID}')">Read more</span>
                                </td>
                                <td>
                                    <img src="${b.image}" alt="${b.bookName}" class="img-thumbnail" onclick="openImageModal('${b.image}')">
                                </td>
                                <td>${b.price}</td>
                                <td>${b.quantity}</td>
                                <c:forEach items="${category}" var="c">
                                    <c:if test = "${c.categoryID == b.categoryID}">
                                        <td class="card-text">${c.categoryName}</td>
                                    </c:if>
                                </c:forEach>
                                <td class="actions">
                                    <a href="updateBookController?BookID=${b.bookID}" class="btn btn-update">Update</a>
                                    <button class="btn btn-delete" onclick="doDelete('${b.bookID}')">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>

        <!-- Image Modal -->
        <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imageModalLabel">Book Image</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="modalImage" src="" alt="Book Image" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>


        <!-- Bootstrap and Font Awesome JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                        function doDelete(book) {
                                            if (confirm("Do you want to delete the book with ID: " + book + "?")) {
                                                window.location = 'deleteBookController?BookID=' + book;
                                            }
                                        }

                                        function toggleDescription(bookID) {
                                            var descElement = document.getElementById("desc-" + bookID);
                                            var readMoreElement = document.getElementById("read-more-" + bookID);

                                            if (descElement.style.maxHeight === "35px" || descElement.style.maxHeight === "") {
                                                descElement.style.maxHeight = "none"; // Hiển thị đầy đủ nội dung
                                                readMoreElement.textContent = "Read less"; // Đổi thành "Read less"
                                            } else {
                                                descElement.style.maxHeight = "35px"; // Thu nhỏ lại
                                                readMoreElement.textContent = "Read more"; // Đổi lại "Read more"
                                            }
                                        }

        </script>
    </body>
</html>

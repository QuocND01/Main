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
        </style>
    </head>
    <body>
        <div class="header d-flex justify-content-between align-items-center">
            <div class="logo">
                <a href="viewBookAdminController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>
            <form class="form-inline" method="get" action="searchBookAdminController">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Enter to search" name="search">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">Search</button>
                    </div>
                </div>
            </form>
            <a href="logoutController" class="btn logout-btn">Logout</a>
        </div>

        <div class="main-actions d-flex justify-content-between mb-4">
            <a href="InsertBookView.jsp" class="btn">Insert Book</a>
            <form action="viewBookController" method="post">
                <button type="submit" class="btn">All Order</button>
            </form>
            <form action="viewNewOrderController" method="post">
                <button type="submit" class="btn">New Orders</button>
            </form>
            <form action="viewAllOrderController" method="post">
                <button type="submit" class="btn">All Customer</button>
            </form>
            <form action="allAccountController" method="post">
                <button type="submit" class="btn">All Staff</button>
            </form>
        </div>

        <!-- Books Grid -->
        <div class="row">
            <c:forEach items="${l}" var="b">
                <c:if test="${b.status != 'Unactive'}">
                    <div class="col-md-4 mb-4">
                        <div class="card book-card">
                            <img src="${b.image}" class="card-img-top" alt="${b.bookName}">
                            <div class="card-body">
                                <h5 class="card-title text-pink">
                                    <a href="viewBookDetailAdminController?BookID=${b.bookID}" title="View Product">${b.bookName}</a>
                                </h5>
                                <p class="card-text"><strong>Price:</strong> ${b.price}$</p>
                                <p class="card-text"><strong>In Stock:</strong> ${b.stock}</p>
                                <p class="card-text"><strong>Author:</strong> ${b.author}</p>
                               
                                <c:forEach items="${listCategory}" var="c">
                                <c:if test = "${c.categoryID == b.categoryID}">
                                     <p class="card-text"><strong>Category:</strong> ${c.categoryName}</p>
                                </c:if>
                            </c:forEach>
                                <p class="card-description">${b.describe}</p>
                            </div>
                            <div class="card-footer d-flex justify-content-between">
                                <a href="updateBookController?BookID=${b.bookID}" class="btn btn-success">Update</a>
                                <a href="deleteBookController?BookID=${b.bookID}" class="btn delete-btn">Delete</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
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
        </script>
    </body>
</html>

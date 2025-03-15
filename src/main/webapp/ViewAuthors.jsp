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
            .table thead {
                background-color: #343a40;
                color: white;
            }
            .table tbody tr:hover {
                background-color: #f8f9fa;
            }
            .d-none {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2>Author Management</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <!-- Hiển thị thông báo thành công nếu có -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover table-bordered text-center align-middle">
                    <thead>
                        <tr>
                            <th>Author ID</th>
                            <th>Author Name</th>
                            <th class="d-none">Status</th> <!-- Ẩn cột Status -->
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
                                        <td class="d-none">
                                            <span class="badge ${author.status == 'Active' ? 'bg-success' : 'bg-secondary'}">
                                                ${author.status}
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn btn-primary btn-sm" onclick="openUpdateModal('${author.authorID}', '${author.authorName}', '${author.status}')">Update</button>
                                            <button class="btn btn-danger btn-sm" onclick="openDeleteModal('${author.authorID}')">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center">No authors found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>

                        <!-- Dòng mới để nhập thông tin tác giả -->
                        <tr>
                    <form action="AuthorController" method="post">
                        <input type="hidden" name="action" value="add"> <!-- Thêm trường action -->
                        <td></td>
                        <td><input type="text" name="authorName" required class="form-control"></td>
                        
                        <td>
                            <button type="submit" class="btn btn-success">Add New Author</button>
                        </td>
                    </form>
                    </tr>
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
                            <div class="mb-3">
                                <label for="updateAuthorName" class="form-label">Author Name</label>
                                <input type="text" name="authorName" id="updateAuthorName" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="updateStatus" class="form-label">Status</label>
                                <input type="text" id="updateStatusDisplay" class="form-control" readonly>
                                <input type="hidden" name="status" id="updateStatus" value="">
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
            function openUpdateModal(id, name, status) {
                document.getElementById('updateAuthorID').value = id;
                document.getElementById('updateAuthorName').value = name;
                document.getElementById('updateStatus').value = status;
                new bootstrap.Modal(document.getElementById('updateModal')).show();
            }

            function openDeleteModal(id) {
                document.getElementById('deleteAuthorID').value = id;
                new bootstrap.Modal(document.getElementById('deleteModal')).show();
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

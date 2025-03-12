<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Warehouse Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Warehouse Management</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Stock ID</th>
                <th>Book ID</th>
                <th>Book Name</th>
                <th>Staff ID</th>
                <th>Stock</th>
                <th>Current Quantity</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty warehouseList}">
                    <c:forEach var="warehouse" items="${warehouseList}">
                        <tr>
                            <td>${warehouse.stockID}</td>
                            <td>${warehouse.bookID}</td>
                            <td>${warehouse.bookName}</td>
                            <td>${warehouse.staffID}</td>
                            <td>${warehouse.stock}</td>
                            <td>${warehouse.quantity}</td>
                            <td>                               
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="text-center">There are no data!.</td>
                    </tr>
                </c:otherwise>
            </c:choose>

            <!-- Dòng mới để nhập thông tin import -->
            <tr>
                <form action="ViewWarehouseController" method="post" onsubmit="return validateForm(this)">
                    <input type="hidden" name="staffID" value="${sessionScope.StaffID}">
                    <td></td>
                    <td><input type="text" name="bookID" required class="form-control"></td>
                    <td></td>
                    
                    <td>${sessionScope.StaffID}</td>
                    
                    <td><input type="text" name="stock" required class="form-control"></td>
                    <td></td>
                    <td>
                        <button type="submit" class="btn btn-primary">Create Import</button>
                    </td>
                </form>
            </tr>

        </tbody>
    </table>
</div>

<script>
    function validateForm(form) {
        let quantity = form.importQuantity.value;
        if (quantity === "" || quantity <= 0) {
            alert("Please input the valid data!");
            return false;
        }
        return true;
    }
</script>

</body>
</html>

<%@page import="Model.Feedbacks"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    Feedbacks feedback = (Feedbacks) request.getAttribute("feedback");
    if (feedback == null) {
        response.sendRedirect("feedback-page?error=feedback_not_found");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Feedback</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: white;
            background: #ff66b2;
            padding: 15px;
            display: inline-block;
            border-radius: 10px;
            margin-top: 20px;
        }

        form {
            background: white;
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .stars {
            display: flex;
            justify-content: center;
            margin: 10px 0;
        }

        .star {
            font-size: 30px;
            cursor: pointer;
            color: gray;
            transition: color 0.3s;
        }

        .star:hover, .star.selected {
            color: gold;
        }

        button {
            background: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background: #218838;
        }
    </style>
</head>
<body>
    <h2>Update Feedback</h2>
    
    <form action="update-feedback" method="post">
    <input type="hidden" name="feedbackID" value="<%= feedback.getFeedbackId() %>">
    <input type="hidden" name="orderID" value="<%= request.getParameter("orderID") %>"> <!-- ✅ Thêm orderID -->

    <label for="star">Rating:</label>
    <div class="stars">
        <% for (int i = 1; i <= 5; i++) { %>
            <span class="star <%= i <= feedback.getStar() ? "selected" : "" %>" data-value="<%= i %>">&#9733;</span>
        <% } %>
    </div>
    <input type="hidden" name="star" id="star-value" value="<%= feedback.getStar() %>">

    <label for="detail">Comment:</label>
    <textarea name="detail" required><%= feedback.getDetail() %></textarea>

    <button type="submit">Update</button>
</form>

<script>
   document.addEventListener("DOMContentLoaded", function () {
    let stars = document.querySelectorAll(".star");
    let starValueInput = document.getElementById("star-value");

    stars.forEach(star => {
        star.addEventListener("click", function () {
            let value = this.getAttribute("data-value");
            starValueInput.value = value; // ✅ Cập nhật input hidden

            // ✅ Đổi màu sao được chọn
            stars.forEach(s => s.classList.remove("selected"));
            for (let i = 0; i < value; i++) {
                stars[i].classList.add("selected");
            }
        });
    });
});
</script>

</body>
</html>

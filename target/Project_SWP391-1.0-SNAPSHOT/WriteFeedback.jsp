<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Write Feedback</title>
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

        label {
            display: block;
            font-weight: bold;
            margin: 10px 0 5px;
        }

        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: none;
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
            transition: color 0.3s, transform 0.2s;
        }

        .star:hover, .star.selected {
            color: gold;
            transform: scale(1.2);
        }

        button {
            background: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background: #0056b3;
        }

        #success-message {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 5px;
            display: none;
            animation: fadeInOut 3s;
        }

        @keyframes fadeInOut {
            0% { opacity: 0; }
            20% { opacity: 1; }
            80% { opacity: 1; }
            100% { opacity: 0; }
        }

        .error-message {
            color: red;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h2>Write Feedback</h2>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <%
        String error = request.getParameter("error");
        if ("missing_data".equals(error)) {
    %>
        <p class="error-message">Please fill in all fields and select a rating.</p>
    <% } else if ("invalid_star".equals(error)) { %>
        <p class="error-message">Invalid star rating. Please choose between 1 and 5.</p>
    <% } else if ("invalid_star_format".equals(error)) { %>
        <p class="error-message">Invalid star format. Please select a valid star rating.</p>
    <% } %>

    <form action="write-feedback" method="post">
        <input type="hidden" name="customerID" value="C2">
        <input type="hidden" name="bookID" value="${param.bookID}">
        <input type="hidden" name="orderID" value="${param.orderID}">

        <label for="star">Rating:</label>
        <div class="stars">
            <span class="star" data-value="1">&#9733;</span>
            <span class="star" data-value="2">&#9733;</span>
            <span class="star" data-value="3">&#9733;</span>
            <span class="star" data-value="4">&#9733;</span>
            <span class="star" data-value="5">&#9733;</span>
        </div>
        <input type="hidden" name="star" id="star-value" required>

        <label for="detail">Comment:</label>
        <textarea name="detail" required></textarea>

        <button type="submit">Submit</button>
    </form>

    <div id="success-message" class="hidden">
        Feedback submitted successfully! 🎉
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const stars = document.querySelectorAll(".star");
            let selectedRating = 0;
            const starValueInput = document.getElementById("star-value");

            stars.forEach(star => {
                star.addEventListener("mouseover", function () {
                    let value = parseInt(this.getAttribute("data-value"));
                    highlightStars(value);
                });

                star.addEventListener("mouseout", function () {
                    highlightStars(selectedRating);
                });

                star.addEventListener("click", function () {
                    selectedRating = parseInt(this.getAttribute("data-value"));
                    starValueInput.value = selectedRating;
                    highlightStars(selectedRating);
                });
            });

            function highlightStars(value) {
                stars.forEach(star => {
                    if (parseInt(star.getAttribute("data-value")) <= value) {
                        star.classList.add("selected");
                    } else {
                        star.classList.remove("selected");
                    }
                });
            }
        });
    </script>
</body>
</html>

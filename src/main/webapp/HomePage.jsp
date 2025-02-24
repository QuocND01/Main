<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FPT BookStore</title>
        <style>
            /* General Styling */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                padding-top: 130px; /* Adjust this value to match the height of the header */
                font-family: Arial, sans-serif;
                background-color: #ffffff;
                color: #333;
                line-height: 1.6;
            }
            a {
                text-decoration: none;
                color: #007bff;
                transition: color 0.3s;
            }
            a:hover {
                color: #0056b3;
            }
            /* Header */
            .header {
                background-image: url('<c:url value="/img/header_img2.jpg"/>'); /* Đường dẫn tới ảnh */
                background-size: cover; /* Đảm bảo ảnh che phủ toàn bộ vùng header */
                position: fixed; /* Keeps the header fixed at the top */
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000; /* Ensures the header is on top of other elements */
                padding: 5px 15px;
                display: flex;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease; /* Smooth transition effect */
            }
            .cart-icon {
                color: #77CCFF; /* Icon color */
                font-size: 24px; /* Icon size */
                margin-right: 5px; /* Spacing from the search bar */
                transition: color 0.3s, transform 0.3s;
                margin-left: 50px;
            }

            .cart-icon:hover {
                color: #ff1493; /* Hover color for the cart icon */
                transform: scale(1.1); /* Slightly enlarge the icon on hover */
            }
            .logo img {
                width: 120px;
            }
            .logsign {
                margin-left: auto;
                display: flex;
                gap: 20px;
            }

            .logsign a {
                padding: 8px 16px;
                font-size: 20px;
                font-weight: bold; /* Làm chữ đậm */
                font-weight: 900;
                color: #77CCFF; /* Màu chữ trắng */
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s; /* Hiệu ứng chuyển đổi */

            }

            .logsign a:hover {
                background-color: #ff1493; /* Màu hồng đậm hơn khi hover */
                transform: translateY(-3px); /* Dịch chuyển nhẹ lên trên khi hover */
                box-shadow: 0 8px 15px rgba(255, 20, 147, 0.4); /* Hiệu ứng bóng sáng xung quanh */
            }

            /* Tìm kiếm */
            .search-container {
                display: flex;
                align-items: center;
                padding: 10px;
                border-radius: 20px; /* Bo góc tròn */
                background-color: #ff69b4; /* Màu nền của thanh tìm kiếm */
                box-shadow: 4px 4px 10px #d4554c, -4px -4px 10px #ffffff; /* Hiệu ứng nổi nhẹ hơn Hiệu ứng nổi (neumorphism) */
                max-width: 300px; /* Độ rộng tối đa của thanh */
                margin: 20px auto; /* Căn giữa với khoảng cách phía trên */
                color: #FFFFFF;

            }
            /* Style for the search input placeholder */
            .search-container input::placeholder {
                color: white; /* Change placeholder text to white */
                opacity: 1;   /* Make sure the color is fully visible */
            }

            .search-container input {
                border: none;
                background: transparent;
                outline: none;
                font-size: 16px;
                color: #FFFFFF; /* Màu chữ nhạt */
                flex: 1;
                padding: 5px;
                margin-left: 10px;
                font-weight: bold;
                font-weight: 700;
            }

            .search-container button {
                background-color: #ff69b4; /* Màu hồng đậm cho nút tìm kiếm */
                background: none;
                border: none;
                cursor: pointer;
                color: #FFFFFF;
                font-size: 20px;
                outline: none;
            }

            .search-container button:hover {
                background-color: #ff1493; /* Màu hồng đậm hơn khi hover */
            }
            /* Banner */
            .banners-container {
                display: flex;
                gap: 5px;
                max-width: 1200px;
                margin: 20px auto;
                height:400px;
            }
            .banner {
                position: relative;
                flex: 2;
                height: 400px;
                background-size: cover;
                background-position: center;
                overflow: hidden;
            }
            .banner img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: none;
                transition: opacity 1s;
            }
            .banner img.active {
                display: block;
                opacity: 1;
            }
            .banner-buttons {
                position: absolute;
                top: 50%;
                width: 100%;
                display: flex;
                justify-content: space-between;
                transform: translateY(-50%);
            }
            .banner-button {
                background-color: transparent;
                color: rgba(255, 255, 255, 0.8);
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 24px;
                transition: color 0.3s;
            }
            .banner-button:hover {
                color: rgba(255, 255, 255, 1);
            }
            /* Additional Banners */
            .additional-banners {
                display: flex;
                flex-direction: column;
                gap: 10px;
                flex: 1;
            }
            .additional-banner {
                height: 120px;
                background-size: cover;
                background-position: center;
                border-radius: 5px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .banner-1 {
                background-image: url('<c:url value="/img/sale_banner3.jpg"/>');
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 5px; /* Optional: to match the banner's rounded corners */
            }
            .banner-2 {
                background-image: url('<c:url value="/img/banner_addition2.jpg"/>');
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 5px; /* Optional: to match the banner's rounded corners */
            }
            /* Category Section */
            /* Categories Styling */
            .categories {
                background-image: url('<c:url value="/img/banner-image-bg-1.jpg"/>'); /* Đường dẫn tới ảnh */
                padding: 30px; /* Tăng khoảng cách để nội dung không bị sát */
                background-size: cover; /* Đảm bảo ảnh che phủ toàn bộ vùng */
                background-position: center;
                background-color: rgba(255, 255, 255, 0.9); /* Màu nền trắng trong suốt để nhìn rõ text */
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Tăng cường hiệu ứng đổ bóng */
                margin: 30px auto; /* Tăng khoảng cách trên và dưới */
                max-width: 1200px;
                border-radius: 15px; /* Tăng độ bo tròn góc */
                overflow: hidden; /* Để ẩn nội dung vượt quá phần bo tròn */
                transition: transform 0.3s; /* Hiệu ứng khi di chuột qua */
            }

            .categories:hover {
                transform: translateY(-10px); /* Hiệu ứng nâng nhẹ lên khi hover */
            }

            .categories h3 {
                margin-bottom: 20px; /* Tăng khoảng cách dưới tiêu đề */
                color: #444; /* Tông màu tối hơn cho chữ */
                font-size: 24px; /* Tăng kích thước font chữ */
                font-weight: bold; /* Làm chữ đậm */
                text-align: center; /* Căn giữa tiêu đề */
                text-transform: uppercase; /* Viết hoa toàn bộ chữ */
                letter-spacing: 2px; /* Tăng khoảng cách giữa các chữ cái */
                font-weight: bold; /* Làm chữ đậm */
                font-weight: 700;
            }

            .categories ul {
                list-style: none;
                display: flex;
                gap: 20px; /* Tăng khoảng cách giữa các mục */
                flex-wrap: wrap;
                justify-content: center; /* Căn giữa các mục */
            }

            .categories li {
                background-color: rgba(255, 255, 255, 0.7); /* Màu nền trắng trong suốt cho mỗi mục */
                border-radius: 8px; /* Bo tròn các góc */
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng cho mỗi mục */
                transition: transform 0.2s, box-shadow 0.2s; /* Hiệu ứng khi hover */
            }

            .categories li:hover {
                transform: translateY(-5px); /* Nâng nhẹ lên khi hover */
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Tăng hiệu ứng đổ bóng */
            }

            .categories li a {
                display: block; /* Chuyển link thành block để dễ dàng tùy chỉnh */
                font-size: 18px; /* Tăng kích thước font chữ */
                color: #007bff;
                padding: 10px 20px; /* Tạo khoảng cách bên trong */
                text-align: center; /* Căn giữa chữ */
                font-weight: 500; /* Làm chữ đậm hơn */
                text-decoration: none; /* Xóa gạch chân mặc định */
                transition: color 0.3s; /* Hiệu ứng chuyển màu khi hover */
            }

            .categories li a:hover {
                color: #FF0049; /* Màu xanh đậm hơn khi hover */
            }
            /* Kiểu dáng cho thể loại đang chọn */
            .active-category {
                background-color: #ff69b4; /* Màu nền hồng cho thể loại đang chọn */
                color: #ffffff; /* Màu chữ trắng */
                border-radius: 8px; /* Bo tròn các góc */
                box-shadow: 0 4px 10px rgba(255, 105, 180, 0.4); /* Thêm hiệu ứng bóng */
            }

            .active-category {
                background-color: #ff69b4; /* Màu nền hồng cho thể loại đang chọn */
                color: #ffffff; /* Màu chữ trắng */
            }


            /* Books Section */
            /* Updated Books Section */
            /* Books CSS Section */
            .books {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
            }

            .book-card {
                background-color: #fff;
                padding: 20px;
                border: 2px solid #8711C1; /* Pink border */
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(255, 105, 180, 0.3); /* Pink shadow for a cohesive look */
                transition: transform 0.3s, box-shadow 0.3s;
                overflow: hidden;
                position: relative;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }


            .book-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            }

            .book-card img {
                width: 100%;
                border-radius: 8px;
                margin-bottom: 15px;
                object-fit: cover;
            }

            .book-card h4 {
                font-size: 20px;
                margin: 10px 0;
                color: #333;
            }
            /* Price Styling */
            .book-details p:nth-child(1) {
                font-size: 18px; /* Larger font size for price */
                font-weight: bold;
                color: #ff0000; /* Red color for price */
            }
            /* In Stock Styling */
            .book-details p:nth-child(2) {
                font-size: 16px;
                color: #008000; /* Green color for in stock */
                font-weight: bold;
            }
            .book-details {
                flex: 1;
            }

            .book-details p {
                font-size: 14px;
                color: #666;
                line-height: 1.4;
                max-height: 3.6em;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                transition: max-height 0.3s;
            }

            /* Updated Add to Cart Button */
            .book-card button {
                background-color: #ff69b4;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 25px; /* Make the button rounded */
                cursor: pointer;
                margin-top: 15px;
                font-size: 16px;
                font-weight: bold;
                transition: background-color 0.3s, transform 0.3s;
            }

            .book-card button:hover {
                background-color: #FF0049;
                transform: scale(1.05); /* Slightly enlarge on hover */
            }

            /* Enhanced Quantity Input */
            .book-card input[type="number"] {
                width: 60px;
                padding: 5px;
                border: 2px solid #FBBEBF;
                border-radius: 5px;
                text-align: center;
                font-size: 14px;
                margin-top: 10px;
                transition: border-color 0.3s;
            }

            .book-card input[type="number"]:focus {
                border-color: #FF0049;
                outline: none;
            }

            /* Footer */
            .footer {
                background-color: #f8f8f8;
                padding: 20px 0;
                font-size: 14px;
                color: #666;
                text-align: center;
                border-top: 1px solid #e0e0e0;
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

            /* Video Banner */
            .video-banner {
                position: relative;
                width: 100%;
                height: 430px; /* Adjust the height as needed */
                overflow: hidden;
                margin: 20px 0; /* Space between the video banner and footer */
            }

            .video-banner-content {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            /* Hiệu ứng lửa thật cho chữ "Hot" */
            .logsign a.hot {
                position: relative;
                color: #ff4500; /* Màu cam đậm */
                font-weight: bold;
                font-size: 20px; /* Tăng kích thước chữ */
                transition: color 0.3s;
                text-shadow: 0 0 10px rgba(255, 69, 0, 0.5); /* Hiệu ứng phát sáng xung quanh */
            }

            .logsign a.hot::before,
            .logsign a.hot::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 100px; /* Kích thước của lửa */
                height: 100px; /* Kích thước của lửa */
                background: radial-gradient(circle, rgba(255, 140, 0, 0.7), rgba(255, 69, 0, 0.1));
                border-radius: 50%;
                opacity: 0;
                transform: translate(-50%, -50%) scale(1);
                animation: realFireEffect 2s infinite ease-in-out; /* Hiệu ứng ngọn lửa */
            }

            .logsign a.hot::after {
                animation-delay: 1s; /* Độ trễ giữa hai ngọn lửa */
            }

            @keyframes realFireEffect {
                0% {
                    transform: translate(-50%, -50%) scale(0.5);
                    opacity: 0.7;
                }
                30% {
                    transform: translate(-50%, -80%) scale(0.5); /* Lửa bùng lên cao hơn */
                    opacity: 0.9;
                }
                60% {
                    transform: translate(-50%, -100%) scale(0.6); /* Lửa đạt đỉnh */
                    opacity: 0.5;
                }
                100% {
                    transform: translate(-50%, -150%) scale(0.8); /* Lửa biến mất */
                    opacity: 0;
                }
            }

            .logsign a.hot:hover {
                color: #ff6347; /* Màu sáng hơn khi hover */
                text-shadow: 0 0 15px rgba(255, 140, 0, 0.7); /* Hiệu ứng phát sáng mạnh hơn khi hover */
            }

        </style>
    </head>
    <body>
        <!-- Header Section -->
        <!-- Header Section -->
        <div class="header">
            <div class="logo">
                <a href="ViewBookCustomerController">
                    <img src="<c:url value='/img/logo3.png'/>" alt="FPT Logo">
                </a>
            </div>

            <!-- Kiểm tra trạng thái đăng nhập -->
            <% if (session.getAttribute("acc") != null) { %>
            <!-- Hiển thị khi người dùng đã đăng nhập -->
            <form method="post" class="logsign">
                <a href="newBookController">New</a>
                <a href="hotBookController" class="hot">Hot</a>
                <a href="randomBookController">Random</a>
                <a href="./Cart.jsp">Your Cart</a>
                <a href="logoutController">Logout</a>
            </form>
            <% } else { %>
            <!-- Hiển thị khi người dùng chưa đăng nhập -->
            <form method="post" class="logsign">
                <a href="./LoginForm.jsp" class="login">Log in</a>
                <a href="./SigninForm.jsp" class="signin">Sign up</a>
            </form>
            <form method="post" class="logsign">
                <a href="newBookController">New</a>
                <a href="hotBookController" class="hot">Hot</a>
                <a href="randomBookController">Random</a>
                <a href="./Cart.jsp">Your Cart</a>
            </form>
            <% }%>

           
            <!-- Thanh tìm kiếm -->
            <!-- Thanh tìm kiếm -->
            <form method="get" action="searchBookCustomerController">
                <div class="search-container">
                    <input type="text" placeholder="Enter to search" name="search">
                    <button><i class="fa fa-search"></i></button>
                </div>
            </form>
        </div>


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Banners Container -->
        <div class="banners-container">
            <div class="banner">
                <img src="<c:url value='/img/sale_banner.jpg'/>" class="active" alt="Banner 1">
                <img src="<c:url value='/img/sale_banner2.jpg'/>" alt="Banner 2">
                <img src="<c:url value='/img/sale_banner4.png'/>" alt="Banner 3">
                <div class="banner-buttons">
                    <button class="banner-button" onclick="prevImage()">&#10094;</button>
                    <button class="banner-button" onclick="nextImage()">&#10095;</button>
                </div>
            </div>
            <div class="additional-banners">
                <div class="additional-banner banner-1">

                </div>
                <div class="additional-banner banner-2"></div>
            </div>
        </div>

        <div class="categories">
            <h3>Categories</h3>
            <ul>
                <c:forEach items="${listCategory}" var="c">
                    <li><a href="categoryController?CategoryName=${c.categoryName}">${c.categoryName}</a></li>
                    </c:forEach>
            </ul>

        </div>


        <!-- Books Section -->
        <!-- Books Section -->
        <div class="books">
            <c:forEach items="${l}" var="b">
                <c:if test="${b.stock != 0 || b.status != 'Unactive'}">
                    <div class="book-card">
                        <img src="${b.image}" alt="${b.bookName}">
                        <h4><a href="viewBookDetailCustomerController?BookID=${b.bookID}">${b.bookName}</a></h4>
                        <div class="book-details">
                            <p>Price: ${b.price}$</p>
                            <p>In Stock: ${b.stock}</p>
                            <p>Author: ${b.author}</p>
                            <c:forEach items="${listCategory}" var="c">
                                <c:if test = "${c.categoryID == b.categoryID}">
                                    <p>Category: ${c.categoryName}</p>
                                </c:if>
                            </c:forEach>
                            <p>${b.describe}</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="bookId" value="${b.bookID}" />
                            <input type="number" name="quantity" value="1" min="1" max ="${b.stock}"/>
                            <button type="submit">Add to Cart</button>
                        </form>
                    </div>
                </c:if>
            </c:forEach>
        </div>




    </div>
    <!-- Video Banner Section -->
    <div class="video-banner">
        <video class="video-banner-content" autoplay muted loop>
            <source src="<c:url value='/vid/vid_1.mp4'/>" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>

    <!-- Footer Section -->
    <!-- Footer Section -->
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


    <!-- FontAwesome for Social Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <!-- JavaScript for Image Carousel -->
    <script>
                        let currentImageIndex = 0;
                        const images = document.querySelectorAll('.banner img');
                        const imageCount = images.length;

                        function showImage(index) {
                            images.forEach((img, i) => {
                                if (i === index) {
                                    img.classList.remove('inactive', 'previous');
                                    img.classList.add('active');
                                } else if (i < index) {
                                    img.classList.remove('active', 'inactive');
                                    img.classList.add('previous');
                                } else {
                                    img.classList.remove('active', 'previous');
                                    img.classList.add('inactive');
                                }
                            });
                        }

                        function prevImage() {
                            currentImageIndex = (currentImageIndex - 1 + imageCount) % imageCount;
                            showImage(currentImageIndex);
                        }

                        function nextImage() {
                            currentImageIndex = (currentImageIndex + 1) % imageCount;
                            showImage(currentImageIndex);
                        }

                        // Automatic image transition every 4 seconds
                        setInterval(nextImage, 4000);
    </script>


</body>
</html>

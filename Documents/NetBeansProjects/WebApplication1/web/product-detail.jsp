<%@page import="model.User"%>
<%@page import="model.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.CurrencyHelper"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Product product = (Product)request.getAttribute("product"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= product.getTitle() %></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            max-width: 900px;
            margin-top: 50px;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .carousel-item img {
            max-height: 400px;
            object-fit: contain;
            border-radius: 12px;
        }

        .product-info {
            text-align: center;
            margin-top: 30px;
        }

        .product-title {
            font-size: 30px;
            font-weight: bold;
        }

        .product-desc {
            font-size: 18px;
            color: #666;
            margin-top: 10px;
        }

        .product-price {
            font-size: 24px;
            color: #28a745;
            font-weight: bold;
            margin-top: 20px;
        }

        .comment-section {
            margin-top: 50px;
        }

        .comment-form {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
        }

        .comment-form input {
            flex-grow: 1;
            border-radius: 20px;
        }

        .btn-primary {
            border-radius: 20px;
            padding: 6px 20px;
        }

        .comment {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-left: 3px solid #007bff;
            background-color: #f9f9f9;
            border-radius: 8px;
        }

        .comment-author {
            font-weight: 600;
            color: #007bff;
            margin-right: 10px;
        }

        .comment-text {
            color: #333;
        }

        .login-reminder {
            font-size: 15px;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center mb-4">Product Detail</h1>

    <!-- Carousel hiển thị ảnh -->
    <div id="productCarousel" class="carousel slide mb-4" data-ride="carousel">
        <div class="carousel-inner">
            <% ArrayList<String> images = product.getImages();
               if (images != null && !images.isEmpty()) {
                   for (int i = 0; i < images.size(); i++) {
                       String img = images.get(i); %>
                       <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
                           <img class="d-block w-100" src="<%= img %>" alt="Product Image <%= i + 1 %>">
                       </div>
            <%     }
               } %>
        </div>
        <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <!-- Thông tin sản phẩm -->
    <div class="product-info">
        <div class="product-title"><%= product.getTitle() %></div>
        <div class="product-desc"><%= product.getDescription() %></div>
        <div class="product-price"><%= CurrencyHelper.format(product.getPrice()) %></div>
    </div>

    <!-- Bình luận -->
    <div class="comment-section">
        <% User user = (User) session.getAttribute("user"); %>
        <% if (user != null) { %>
            <form method="POST" action="./product-detail?id=<%= product.getId() %>">
                <div class="comment-form">
                    <input type="hidden" name="product_id" value="<%= product.getId() %>">
                    <input name="comment" type="text" class="form-control" placeholder="Write a comment...">
                    <button type="submit" class="btn btn-primary">Send</button>
                </div>
            </form>
        <% } else { %>
            <div class="login-reminder">
                <p><a href="./login">Log in</a> to leave a comment.</p>
            </div>
        <% } %>

        <% ArrayList<Comment> cmts = product.getComment();
           for (Comment cmt : cmts) { %>
            <div class="comment">
                <span class="comment-author"><%= cmt.getUser().getFullname() %></span>
                <span class="comment-text"><%= cmt.getContent() %></span>
            </div>
        <% } %>
    </div>
</div>

<!-- Script -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<script>
    // Tự động trượt mỗi 3 giây
    $('.carousel').carousel({
        interval: 3000
    });
</script>
</body>
</html>

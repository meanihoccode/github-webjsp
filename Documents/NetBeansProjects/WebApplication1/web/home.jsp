<%-- 
    Document   : home
    Created on : Feb 18, 2024, 7:36:49 PM
    Author     : User
--%>

<%@page import="model.Supplier"%>
<%@page import="utils.CurrencyHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Meani Clothes</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .navbar-brand {
        font-weight: bold;
        font-size: 24px;
    }

    .home-container {
        display: flex;
        gap: 30px;
        padding: 50px 100px;
    }

    .filter-container {
        flex: 2;
        padding: 20px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        height: fit-content;
    }

    .filter-item h5 {
        margin-bottom: 20px;
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
    }

    .filter-item a {
        display: block;
        margin-bottom: 10px;
        color: #333;
        text-decoration: none;
        padding: 6px 10px;
        border-radius: 5px;
    }

    .filter-item a:hover,
    .filter-item .selected {
        background-color: #007bff;
        color: white !important;
        font-weight: bold;
    }

    .product-list {
        flex: 8;
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 20px;
    }

    .product.card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
    }

    .product.card:hover {
        transform: translateY(-5px);
    }

    .card-img-top {
        height: 200px;
        object-fit: cover;
    }

    .strike {
        text-decoration: line-through;
        color: #888;
        font-size: 14px;
    }

    .card-body h5 {
        font-size: 18px;
        margin-bottom: 5px;
    }

    .card-body h4 {
        color: #28a745;
        font-size: 16px;
    }

    .card-body h3 {
        font-size: 16px;
        color: red;
        margin-top: 5px;
        font-weight: bold;
    }

    .sort-buttons {
        margin-bottom: 30px;
    }

    .sort-buttons a {
        margin-right: 10px;
    }

    @media (max-width: 768px) {
        .home-container {
            flex-direction: column;
            padding: 20px;
        }

        .product-list {
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
        }
    }
</style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
    <body>
        <% User user = (User) session.getAttribute("user"); %>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="https://www.youtube.com/watch?v=7kO_ALcwNAw&list=RD7kO_ALcwNAw&start_radio=1">Meani Clothes</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                    </li>
                </ul>
                <span class="navbar-text">
                    <% if (user != null) {%>
                    <h4><%= user.getLastname() + " " + user.getFirstname()%></h4>
                    <% }%> 
                </span>
            </div>
        </nav>

        <div class="home-container">
            <div class="filter-container">
                <div class="filter-item">
                    <h5>Nhà cung cấp</h5>
                    <% String seletedSupplierId = (String) request.getParameter("supplierId");  %>
                    <div class="">
                        <% ArrayList<Supplier> supplierList = (ArrayList<Supplier>) request.getAttribute("supplierList"); %>
                        <% 
                           
                            if (supplierList != null) { 
                            for (Supplier supplier : supplierList) { 
                        %>
                            <div >
                                <a class="<%= seletedSupplierId != null && supplier.getId() == Integer.parseInt(seletedSupplierId) ? "selected" : ""%>" href="./home?supplierId=<%= supplier.getId()%>" class="btn"><%= supplier.getCompanyName()%></a>
                            </div>
                           <!--button class="btn" onclick="handleFilterBySupplier(<%= supplier.getId()%>)"><%= supplier.getCompanyName()%></button> -->
                        <br>
                        <% } }%>
                    </div>
                </div>
            </div>
            <div class="product-list">
                <a href="./home?sortBy=title&order=asc" class="btn btn-primary">Sort by title</a>
                <a href="./home?sortBy=price&order=asc" class="btn btn-info">Sort by price</a>
                <a href="./home?sortBy=sale_rate&order=desc" class="btn btn-secondary">Sort by sale</a>
                <br>
                <% ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList"); %>
                <% 
                           
                            if (productList != null) { 
                            for (Product product : productList) { 
                %>
                <div class="card product">
                    <img class="card-img-top" src=" <%=product.getImages().get(0)%>" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getTitle()%></h5>
                        <h5 class="card-text strike"><%= CurrencyHelper.format(product.getCompareAtPrice())%></h5>
                        <h4 class="card-text"><%= CurrencyHelper.format(product.getPrice())%></h4>
                        <h3 class="card-text" style="color: red;">SALE <%= (int) product.getSaleRate()%>%</h3>
                        <a href="/WebApplication1/product-detail?id=<%= product.getId()%>" class="btn btn-primary">Detail</a>
                    </div>
                </div>
                <% } }%>
            </div>
        </div>
            <div style ="display:flex; justify-content: center; margin-top: 20px;"
            <nav aria-label="...">
                <ul class="pagination">
                    <% int totalPages = (Integer)request.getAttribute("totalPages");%>
                    <% int currentPage = (Integer)request.getAttribute("currentPage");%>
                  <li class="page-item">
                    <a class="page-link" href="./home?page=<%= currentPage-1%>">Previous</a>
                  </li>
                  <% for (int i=1;i<=totalPages;i++) { %>
                      <li class="page-item<%= (i == currentPage ? " active" : "") %>"><a class="page-link" href="./home?page=<%=i%>"><%= i %></a></li>
                  <% } %>
                  <li class="page-item">
                    <a class="page-link" href="./home?page=<%= currentPage+1%>">Next</a>
                  </li>
                </ul>
              </nav>
        </div>        

        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!--             function handleFilterBySupplier(id) {
                $.ajax({
                    url: "./home",
                    type: "get", //send it through get method
                    data: {
                        supplierId: id,
                    },
                    success: function (data) {
                        console.log(">>> data", data);
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            } -->       <script>

            
//            setInterval(() => {callApi()}, 5000);
//            function callApi(){
//                $.ajax({
//                    url: "https://jsonplaceholder.typicode.com/users",
//                    type: "get", //send it through get method
//                    data: {
//                        
//                    },
//                    success: function (data) {
//                        console.log(">>> data", data);
//                    },
//                    error: function (xhr) {
//                        //Do Something to handle error
//                    }
//                });
//            }
        </script>
    </body>
</html>

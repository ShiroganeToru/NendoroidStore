<%-- 
    Document   : Product
    Created on : Mar 17, 2024, 9:09:40 PM
    Author     : Admin
--%>

<%@page import="dao.DAO"%>
<%@page import="dto.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <link href="style/ProductPage.css" rel="stylesheet">
        <%
            DAO dao = new DAO();
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = dao.getProduct(id);
        %>
        <title><%= product.getName()%></title>
    </head>
    <body>
        <%@include file="component/Header.jsp" %>
        
        <div class="product-body">
            <div class="product-container">
                <div class="product-img" style="border: 2px solid <%= product.getColor()%>">
                    <img src="<%= product.getImage()%>">
                </div>
                <div class="product-info">
                    <h1 style="color: <%= product.getColor()%>">
                        <%= product.getId()%> - <%= product.getName()%>
                    </h1>
                    <h2 class="box-container" style="background-color: <%= product.getColor()%>">
                        Product Details
                    </h2>
                    <p class="description">
                        <%= product.getDescription()%>
                    </p>
                    <div class="info-container">
                        <span>Type:</span>
                        <p class="type" style="color: <%= product.getColor()%>">
                            <%= product.getType()%>
                        </p>
                    </div>
                    <div class="info-container">
                        <span>Payment:</span>
                        <p class="payment" style="color: <%= product.getColor()%>">
                            <%= product.getOpenDay()%> ~ <%= product.getClosedDay()%>
                        </p>
                    </div>
                    <div class="info-container">
                        <span>Price:</span>
                        <p class="price" style="color: <%= product.getColor()%>">
                            <%= product.getPrice()%>¥
                        </p>
                    </div>
                    <div>
                        <button class="buy-now" style="background-color: <%= product.getColor()%>">
                            <a href="MainController?action=Create&productID=<%= product.getId()%>"
                               style="text-decoration: none; color: white;">
                                Buy now
                            </a>
                        </button>
                        <button class="add-to-cart" style="color: <%= product.getColor()%>; border: 1px solid <%= product.getColor()%>">
                            <a href="MainController?action=AddToCart&productID=<%= product.getId()%>"
                               style="text-decoration: none; color: <%= product.getColor()%>;">
                                <i class="fa-solid fa-cart-plus"></i>Add to cart
                            </a>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="component/Footer.jsp" %>
    </body>
</html>

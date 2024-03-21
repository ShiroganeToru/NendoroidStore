<%-- 
    Document   : Search
    Created on : Mar 20, 2024, 7:41:28 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="dto.Product"%>
<%@page import="dao.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/style.css">
        <link rel="stylesheet" href="style/ListPage.css">
        <title>Nendoroid Store</title>
    </head>
    <body>
        <%@include file="component/Header.jsp" %>

        <%            
            List<Product> listProduct = (List) request.getAttribute("listSearch");
        %>

        <div class="display-product">
            <div class="title-bar">
                <div class="line-decor-left"></div>
                <div class="display-title">SEARCH</div>
                <div class="line-decor-right"></div>
            </div>

            <div class="frame-container">
                <div class="frame-list">
                    <p>${alert}</p>
                    <div class="product-list">

                        <%
                            if (listProduct != null) {
                                for (Product p : listProduct) {
                        %>
                        <div class="product">
                            <a href="Product.jsp?id=<%= p.getId()%>" style="text-decoration: none;">
                                <div class="img-product">
                                    <img src="<%= p.getImage()%>" alt="<%= p.getName()%>">
                                </div>
                                <p style="color: <%= p.getColor()%>;margin-top: 10px;"><%= p.getName()%></p>
                            </a>
                            <div class="info">
                                <p><%= p.getPrice()%>¥</p>
                                <a href="MainController?action=AddToCart&productID=<%= p.getId()%>">
                                    <i class="fa-solid fa-cart-plus"></i>
                                </a>
                            </div>
                            <span class="code" style="background-color: <%= p.getColor()%>">
                                <%= p.getId()%>
                            </span>
                        </div>        
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="component/Footer.jsp" %>
    </body>
</html>

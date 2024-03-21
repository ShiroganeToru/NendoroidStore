<%-- 
    Document   : ProductList
    Created on : Mar 18, 2024, 10:22:16 AM
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
            String topic = request.getParameter("topic");
        %>
        
        <div class="display-product">
            <div class="title-bar">
                <div class="line-decor-left"></div>
                <div class="display-title"><%= topic.toUpperCase()%></div>
                <div class="line-decor-right"></div>
            </div>
            
            <div class="frame-container">
                <div class="frame-list">
                    <div class="product-list">
                        <%
                            DAO dao = new DAO();
                            List<Product> listProduct = dao.getListProduct();
                            for (Product p : listProduct) {
                                if(p.getIsSale() == 1){
                                    if(topic.equalsIgnoreCase(p.getType())){
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
                                    } else if(topic.equalsIgnoreCase("All")){
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
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
                    
        <%@include file="component/Footer.jsp" %>
    </body>
</html>

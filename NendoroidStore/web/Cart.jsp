<%-- 
    Document   : CartPage
    Created on : Mar 18, 2024, 7:59:16 AM
    Author     : Admin
--%>

<%@page import="dto.Cart"%>
<%@page import="java.util.List"%>
<%@page import="dto.Product"%>
<%@page import="dao.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/style.css" rel="stylesheet">
        <link href="style/CartPage.css" rel="stylesheet">
        <title>Cart List</title>
    </head>
    <body>
        <%@include file="component/Header.jsp" %>
        <%            if (user == null) {
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        %>
        <div class="display-product">
            <div class="title-bar">
                <div class="line-decor-left"></div>
                <div class="display-title">MY CART</div>
                <div class="line-decor-right"></div>
            </div>

            <div class="frame-container">

                <div class="list-cart">
                    <%
                        DAO dao = new DAO();
                        List<Cart> listCart = dao.getCart();
                        List<Product> listProduct = dao.getListProduct();
                        float sum = 0;
                        for (Cart cart : listCart) {
                            for (Product p : listProduct) {
                                if (customer.getId().equals(cart.getCustomerID())) {
                                    if (p.getId() == cart.getProductID()) {
                    %>

                    <div class="cart-product">
                        <div class="option-choice">
                            <input type="checkbox" name="choose">
                        </div>
                        <div class="img-product">
                            <img src="<%= p.getImage()%>" alt="<%= p.getName()%>">
                        </div>
                        <div class="product-name">
                            <h2 style="color: <%= p.getColor()%>">
                                <%= p.getId()%> - <%= p.getName()%>
                            </h2>
                            <div class="quantity-input">
                                <span>Quantity:</span>
                                <input type="text" 
                                       class="quantity" name="quantity"
                                       value="<%= cart.getQuantity()%>"/>
                            </div>
                        </div>
                        <div class="price">
                            <h1><%= p.getPrice()%>¥</h1>
                        </div>
                        <div>
                            <form action="MainController">
                                <input type="submit" name="action" value="Remove" class="delete-btn">
                                <input type="hidden" name="cartID" value="<%= cart.getId()%>">
                            </form>

                        </div>
                    </div>

                    <%              sum += p.getPrice() * cart.getQuantity();
                                    }
                                }
                            }
                        }
                    %>
                </div>
                <div class="total">
                    <h2>Total:</h2>
                    <h1><%= sum%>¥</h1>
                    <button type="submit" name="action" value="Create">
                        Payment
                    </button>
                    <p>${alert}</p>
                </div>
            </div>
        </div>

        <%@include file="component/Footer.jsp" %>
    </body>
</html>

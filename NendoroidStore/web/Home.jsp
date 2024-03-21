<%-- 
    Document   : HomePage
    Created on : Mar 12, 2024, 5:15:31 PM
    Author     : Admin
--%>

<%@page import="dto.User"%>
<%@page import="dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/style.css">
        <link rel="stylesheet" href="style/HomePage.css">
        <title>Home</title>
    </head>
    <body>
        <%@include file="component/Header.jsp" %>
        <div class="cover">
            <img src="assets/img/Cover.png" alt="Cover">
            <div class="center"> QUALITY - PROFESSIONAL - PRESTIGE</div>
        </div>

        <div class="product-type">
            <div class="classification">
                <div class="new-products">
                    <div class="img-holder">
                        <img src="https://images.goodsmile.info/cgm/images/product/20231212/15353/124723/large/42bb3102bbaacb0303fc7d01d4ed6ff4.jpg" alt="Cover">
                    </div>
                    <h2>New Products</h2>
                </div>
                <div class="new-products">
                    <div class="img-holder">
                        <img src="https://images.goodsmile.info/cgm/images/product/20231024/15127/122585/large/19d021754425621a41fc2ce0f56de99c.jpg" alt="Cover">
                    </div>
                    <h2>Pre-Order</h2>
                </div>
                <div class="new-products">
                    <div class="img-holder">
                        <img src="https://images.goodsmile.info/cgm/images/product/20230823/14851/119939/large/0b524bdca7cb19e351f7ccc677066868.jpg" alt="Cover">
                    </div>
                    <h2>Stock Available</h2>
                </div>
                <div class="new-products">
                    <div class="img-holder">
                        <img src="https://images.goodsmile.info/cgm/images/product/20231101/15171/123122/large/cf54f1fa522b66aecea21ddb57876c54.jpg" alt="Cover">
                    </div>
                    <h2>Others</h2>
                </div>
            </div>
        </div>

        <div class="display-product">
            <div class="title-bar">
                <div class="line-decor-left"></div>
                <div class="display-title">PRODUCTS</div>
                <div class="line-decor-right"></div>
            </div>

            <div class="frame-container">
                <div class="frame-list">
                    <div class="product-list">
                        <%                            
                            DAO dao = new DAO();
                            int count = 0;
                            List<Product> listProduct = dao.getListProduct();
                            for (Product p : listProduct) {
                                if(p.getIsSale() == 1){
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
                                count++;
                                if(count > 7) break;
                            }
                        %>
                    </div>
                    <div class="button-area">
                        <button class="viewAll">
                            <a href="ProductList.jsp?topic=All" 
                               style="text-decoration: none; color: white;">
                                See all products ➤
                            </a>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="about-us">
            <div class="about-container">
                <h1>About Nendoroid Store</h1>
                <p>Since our founding, our mission at Nendoroid Store has been to support creators and bring Japanese pop culture to the world whilst stimulating the figure industry as a whole. Presently, while continuing to plan exceptional figures and plastic models, we’ve also enhanced our manufacturing teams and factories and made many business partners within the animation industry. Following the establishment of new locations in the USA and China, we’re working to spread each area’s pop culture throughout the world, Japan included. Nendoroid Store strives to expand our figure, anime and game operations as well as our support services in order to bring the hard work of creators to as many people as possible for as long as possible.</p>
            </div>
            <div class="about-image">
                <img src="assets/img/AboutUs.png" alt="About Us">
            </div>
        </div>
        <%@include file="component/Footer.jsp" %>
    </body>
</html>

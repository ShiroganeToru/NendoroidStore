<%-- 
    Document   : Header
    Created on : Mar 12, 2024, 8:42:42 PM
    Author     : Admin
--%>

<%@page import="dto.Bank"%>
<%@page import="dao.DAO"%>
<%@page import="dto.Customer"%>
<%@page import="dto.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <div class="navbar">
            <div class="container">
                <div class="logo">
                    <a href="Home.jsp">
                        <img src="assets/img/Logo.png">
                    </a>
                </div>
                <div class="selection">
                    <a href="ProductList.jsp?topic=All">Products</a>
                    <a href="ProductList.jsp?topic=Pre-order">Pre-order</a>
                    <a href="ProductList.jsp?topic=Stock available">Stock available</a>
                    <a href="ProductList.jsp?topic=Other">Other</a>
                </div>
                <div class="search">
                    <form action="MainController" method="POST">
                        <input type="text" name="search" placeholder="Search product...">
                        <button type="submit" name="action" value="Search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>

                    </form>
                </div>
                <div class="personal">
                    <a href="Cart.jsp">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <i class="fa-solid fa-circle-user" id="login"></i>
                </div>
            </div>
        </div>

        <div class="pop-up">
            <%
                User user = (User) session.getAttribute("user");
                Customer customer = (Customer) session.getAttribute("customer");
                if (user == null) {
            %>
            <a href="Login.jsp" class="login-btn">Login</a>
            <a href="Register.jsp" class="register-btn">Register</a>
            <%
            } else {
                if (customer != null) {
            %>
            <div class="user-info" style="display: flex; gap: 20px;margin: 20px 30px;justify-content: center;">
                <img src="<%= customer.getAvatar()%>" alt="<%= customer.getFullname()%>" 
                     width="100" 
                     style="border-radius: 100%; border: 2px solid #FF7A00">
                <div style="display: flex; flex-direction: column; justify-content: center; gap: 10px;">
                    <h2 style="width: fit-content;">
                        <a href="User.jsp" style="text-decoration: none;color: #FF7A00;">
                            <%= customer.getFullname()%>
                        </a>
                    </h2>
                    <a href="MainController?action=Logout" style="text-decoration: none; color: red;">
                        Logout
                    </a>
                </div>
            </div>
            <%
            } else {
            %>
            <div class="user-info" style="display: flex; gap: 20px;margin: 20px 30px;justify-content: center;">
                <img src="https://static.wikia.nocookie.net/gensin-impact/images/b/bc/Icon_Emoji_Paimon%27s_Paintings_01_Paimon_3.png" 
                     alt="Paimon" 
                     width="100" 
                     style="border-radius: 100%; border: 2px solid #FF7A00">
                <div style="display: flex; flex-direction: column; justify-content: center; gap: 10px;">
                    <h2 style="width: fit-content;">
                        <a href="User.jsp" style="text-decoration: none;color: #FF7A00;">
                            Profile
                        </a>
                    </h2>
                    <a href="MainController?action=Logout" style="text-decoration: none; color: red;">
                        Logout
                    </a>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>

        <script>
            var logo = document.getElementById("login");
            var popup = document.getElementsByClassName("pop-up")[0];

            logo.onclick = function () {
                popup.style.display = "block";
            }

            window.onclick = function (event) {
                if (event.target == popup) {
                    popup.style.display = "none";
                }
            }
        </script>
    </body>
</html>

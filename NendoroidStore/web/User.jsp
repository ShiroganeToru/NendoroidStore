<%-- 
    Document   : User
    Created on : Mar 18, 2024, 3:56:29 PM
    Author     : Admin
--%>

<%@page import="dto.Product"%>
<%@page import="dto.OrderDetails"%>
<%@page import="java.util.List"%>
<%@page import="dto.Order"%>
<%@page import="dto.Bank"%>
<%@page import="dto.Customer"%>
<%@page import="dao.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/style.css">
        <link rel="stylesheet" href="style/UserPage.css">
        <title>Profile</title>
    </head>
    <body>
        <%@include file="component/Header.jsp" %>

        <%            DAO dao = new DAO();
            Bank bank = (Bank) session.getAttribute("bank");
            String option = request.getParameter("option");
            if (customer == null) {
                request.getRequestDispatcher("Information.jsp").forward(request, response);
            }
        %>
        <div class="user-frame">
            <div class="user-container">
                <div class="user-menu">
                    <div class="base-info">
                        <img src="<%= customer.getAvatar()%>" alt="<%= customer.getFullname()%>">
                        <div class="customer-info">
                            <h2><%= customer.getFullname()%></h2>

                            <p>Balance: <%= bank.getBalance()%>¥</p>
                        </div>
                    </div>
                    <div class="menu-option">
                        <div class="option">
                            <i class="fa-solid fa-user"></i>
                            <a href="User.jsp?option=Profile">
                                Profile
                            </a>
                        </div>
                        <div class="option">
                            <i class="fa-solid fa-file-lines"></i>
                            <a href="User.jsp?option=My order">
                                My order
                            </a>
                        </div>
                        <div class="option">
                            <i class="fa-solid fa-clock-rotate-left"></i>
                            <a href="User.jsp?option=History">
                                History
                            </a>
                        </div>
                        <div class="option">
                            <i class="fa-solid fa-wallet"></i>
                            <a href="User.jsp?option=My wallet">
                                My wallet
                            </a>
                        </div>
                    </div>

                    <div class="logout-container">
                        <form action="MainController">
                            <button class="logout-btn" name="action" value="Logout">
                                Log out
                            </button>
                        </form>
                    </div>
                </div>
                <div class="display-content">
                    <%
                        if (option == null) {
                            option = "Profile";

                    %>
                    <div class="customer-profile">
                        <form action="MainController">
                            <h1>Customer Profile</h1>
                            <div class="input-info">
                                Customer ID: <br>
                                <input type="text" name="id" value="<%= customer.getId()%>" readonly>
                            </div>
                            <div class="input-info">
                                Full Name: <br>
                                <input type="text" name="name" value="<%= customer.getFullname()%>">
                            </div>
                            <div class="input-info">
                                Avatar URL: <br>
                                <input type="text" name="avatar" value="<%= customer.getAvatar()%>">
                            </div>
                            <div class="input-info">
                                Phone number: <br>
                                <input type="text" name="phone" value="<%= customer.getPhone()%>">
                            </div>
                            <div class="input-info">
                                Address: <br>
                                <input type="text" name="address" value="<%= customer.getAddress()%>">
                            </div>
                            <div class="update-btn">
                                <input type="submit" name="action" value="Update Info" style="width: 150px;">
                            </div>

                        </form>
                        <div class="avatar-container">
                            <img src="<%= customer.getAvatar()%>" alt="<%= customer.getFullname()%>">
                        </div>
                    </div>
                    <%
                    } else if (option.equalsIgnoreCase("Profile")) {
                    %>
                    <div class="customer-profile">
                        <form action="MainController">
                            <h1>Customer Profile</h1>
                            <div class="input-info">
                                Customer ID: <br>
                                <input type="text" name="id" value="<%= customer.getId()%>" readonly>
                            </div>
                            <div class="input-info">
                                Full Name: <br>
                                <input type="text" name="name" value="<%= customer.getFullname()%>">
                            </div>
                            <div class="input-info">
                                Avatar URL: <br>
                                <input type="text" name="avatar" value="<%= customer.getAvatar()%>">
                            </div>
                            <div class="input-info">
                                Phone number: <br>
                                <input type="text" name="phone" value="<%= customer.getPhone()%>">
                            </div>
                            <div class="input-info">
                                Address: <br>
                                <input type="text" name="address" value="<%= customer.getAddress()%>">
                            </div>
                            <div class="update-btn">
                                <input type="submit" name="action" value="Update Info" style="width: 150px;">
                            </div>

                        </form>
                        <div class="avatar-container">
                            <img src="<%= customer.getAvatar()%>" alt="<%= customer.getFullname()%>">
                        </div>
                    </div>
                    <%
                    } else if (option.equalsIgnoreCase("My order")) {
                    %>
                    <div class="my-order">
                        <h1 style="color: #FF7A00">My Order</h1>
                        <table>
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Order Date</th>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int no = 1;
                                    List<Product> listProduct = dao.getListProduct();
                                    List<Order> listOrder = dao.getOrder();
                                    List<OrderDetails> orderDetails = dao.getOrderDetails();
                                    for (Order order : listOrder) {
                                        for (OrderDetails od : orderDetails) {
                                            if (od.getOrderID() == order.getId()) {
                                                if(order.getCustomerID().equals(customer.getId())){
                                                    if (order.getStatus().equals("Payment Complete")) {
                                                    
                                %>
                                <tr>
                                    <td><%= no++%></td>
                                    <td><%= order.getOrderDate()%></td>
                                    <%
                                        for (Product product : listProduct) {
                                            if (od.getProductID() == product.getId()) {
                                    %>
                                    <td>
                                        <div>
                                            <img src="<%= product.getImage()%>" alt="<%= product.getName()%>"
                                                 width="100"
                                                 style="border-radius: 10px ">
                                            <p><%= product.getId()%> - <%= product.getName()%></p>
                                        </div>
                                    </td>
                                    <%
                                            }
                                        }
                                    %>
                                    <td><%= od.getPrice()%></td>
                                    <td><%= od.getQuantity()%></td>
                                    <td><%= od.getPrice() * od.getQuantity() + (od.getPrice() * od.getQuantity()) * 0.1 + 300%>
                                    <td><%= order.getPhone()%></td>
                                    <td><%= order.getAddress()%></td>
                                    <td><%= order.getStatus()%></td>
                                </tr>
                                <%
                                                    }
                                                }
                                            }
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <%
                    } else if (option.equalsIgnoreCase("History")) {
                    %>
                    <div class="my-order">
                        <h1 style="color: #FF7A00">History</h1>
                        <table>
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Order Date</th>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int no = 1;
                                    List<Product> listProduct = dao.getListProduct();
                                    List<Order> listOrder = dao.getOrder();
                                    List<OrderDetails> orderDetails = dao.getOrderDetails();
                                    for (int i = listOrder.size() - 1; i >= 0; i--) {
                                        for (int j = orderDetails.size() - 1; j >= 0; j--) {
                                            if (listOrder.get(i).getId() == orderDetails.get(j).getOrderID()) {
                                                if(listOrder.get(i).getCustomerID().equals(customer.getId())){
                                %>
                                <tr>
                                    <td><%= no++%></td>
                                    <td><%= listOrder.get(i).getOrderDate()%></td>
                                    <%
                                        for (Product product : listProduct) {
                                            if (orderDetails.get(j).getProductID() == product.getId()) {
                                    %>
                                    <td>
                                        <div>
                                            <img src="<%= product.getImage()%>" alt="<%= product.getName()%>"
                                                 width="100"
                                                 style="border-radius: 10px ">
                                            <p><%= product.getId()%> - <%= product.getName()%></p>
                                        </div>
                                    </td>
                                    <%
                                            }
                                        }
                                    %>
                                    <td><%= orderDetails.get(j).getPrice()%></td>
                                    <td><%= orderDetails.get(j).getQuantity()%></td>
                                    <td><%= orderDetails.get(j).getPrice() * orderDetails.get(j).getQuantity() + (orderDetails.get(j).getPrice() * orderDetails.get(j).getQuantity()) * 0.1 + 300%>
                                    <td><%= listOrder.get(i).getPhone()%></td>
                                    <td><%= listOrder.get(i).getAddress()%></td>
                                    <td><%= listOrder.get(i).getStatus()%></td>
                                </tr>
                                <%
                                                }
                                            }
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <%
                    } else if (option.equalsIgnoreCase("My wallet")) {
                    %>
                    <div class="my-wallet">
                        <h1>My Wallet</h1>
                        <form action="MainController" method="POST">
                            <h1>My balance: <%= bank.getBalance()%>¥</h1>
                            <p>Bank name: <%= bank.getBankName()%></p>
                            <p style="color: red">${alert}</p>
                            <div class="input-container">
                                <div class="input-info">
                                    Deposit: <br>
                                    <input type="number" name="deposit">
                                </div>
                                <div class="input-info">
                                    Username: <br>
                                    <input type="text" name="userBank" value="<%= bank.getUsername()%>">
                                </div>
                                <div class="input-info">
                                    Password: <br>
                                    <input type="password" name="password">
                                </div>
                            </div>
                            <div class="update-btn">
                                <input type="submit" name="action" value="Deposit" style="width: 150px;">
                            </div>
                        </form>
                    </div>
                    <%
                        } 
                    %>
                </div>
            </div>
        </div>

        <%@include file="component/Footer.jsp" %>
    </body>
</html>

<%-- 
    Document   : Admin
    Created on : Mar 12, 2024, 5:14:56 PM
    Author     : Admin
--%>

<%@page import="dto.OrderDetails"%>
<%@page import="dto.Order"%>
<%@page import="dto.Customer"%>
<%@page import="dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.DAO"%>
<%@page import="dto.Admin"%>
<%@page import="dto.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/Admin.css">
        <script src="https://kit.fontawesome.com/f3d1bdfbd0.js" crossorigin="anonymous"></script>
        <title>Admin</title>
    </head>
    <body>
        <%
            Admin admin = (Admin) session.getAttribute("admin");
            String choice = request.getParameter("choice");
            String popup = request.getParameter("popup");
            DAO dao = new DAO();
        %>
        <div class="sidebar">
            <div class="admin-info">
                <img src="https://static.wikia.nocookie.net/gensin-impact/images/2/2e/Icon_Emoji_Paimon%27s_Paintings_09_Raiden_Shogun_4.png" alt="Raiden Shogun">
                <h2><%= admin.getFullname()%></h2>
                <p>Administrator</p>
            </div>
            <div class="menu">
                <div class="option">
                    <i class="fa-solid fa-border-all"></i>
                    <a href="Management.jsp?choice=Dashboard">
                        <p>Dashboard</p>
                    </a>
                </div>
                <div class="option">
                    <i class="fa-solid fa-user"></i>
                    <a href="Management.jsp?choice=Customer">
                        <p>Customer</p>
                    </a>
                </div>
                <div class="option">
                    <i class="fa-brands fa-product-hunt"></i>
                    <a href="Management.jsp?choice=Product">
                        <p>Product</p>
                    </a>
                </div>
                <div class="option">
                    <i class="fa-regular fa-file-lines"></i>
                    <a href="Management.jsp?choice=Order">
                        <p>Order</p>
                    </a>
                </div>
            </div>
            <div class="btn-area">
                <button>
                    <a href="MainController?action=Logout">Logout</a>
                </button>
            </div>
        </div>
        <div class="content-body">
            <div class="title-bar">
                <div class="admin-name">
                    <p>Welcome admin,</p>
                    <h1><%= admin.getFullname()%></h1>
                </div>
                <div class="logo-container">
                    <img src="assets/img/Logo.png" alt="Logo">
                </div>
            </div>

            <div class="display-content">
                <%
                    if (choice == null) {
                        choice = "Dashboard";
                %>
                <%
                    List<Customer> listCustomer = dao.getListCustomer();
                    List<Product> listProduct = dao.getListProduct();
                    List<Order> listOrder = dao.getOrder();
                    List<OrderDetails> orderDetails = dao.getOrderDetails();
                %>
                <div class="dashboard-container">
                    <div>
                        <p>Number of Customer:</p>
                        <h1><%= listCustomer.size()%></h1>
                    </div>
                    <div>
                        <p>Number of Product:</p>
                        <h1><%= listProduct.size()%></h1>
                    </div>
                    <div>
                        <p>Number of Orders:</p>
                        <h1><%= orderDetails.size()%></h1>
                    </div>
                    <div>
                        <%
                            float sum = 0;
                            for (Order order : listOrder) {
                                for (OrderDetails od : orderDetails) {
                                    if (od.getOrderID() == order.getId()) {
                                        if(order.getStatus().equals("Payment Complete")){
                                            sum += od.getPrice() * od.getQuantity() + (od.getPrice() * od.getQuantity()) * 0.1 + 300;
                                        }
                                    }
                                }
                            }
                        %>
                        <p>Revenue:</p>
                        <h1><%= sum%>¥</h1>
                    </div>
                </div>
                <%
                } else if (choice.equalsIgnoreCase("Dashboard")) {
                %>
                <%
                    List<Customer> listCustomer = dao.getListCustomer();
                    List<Product> listProduct = dao.getListProduct();
                    List<Order> listOrder = dao.getOrder();
                    List<OrderDetails> orderDetails = dao.getOrderDetails();
                %>
                <div class="dashboard-container">
                    <div>
                        <p>Number of Customer:</p>
                        <h1><%= listCustomer.size()%></h1>
                    </div>
                    <div>
                        <p>Number of Product:</p>
                        <h1><%= listProduct.size()%></h1>
                    </div>
                    <div>
                        <p>Number of Orders:</p>
                        <h1><%= orderDetails.size()%></h1>
                    </div>
                    <div>
                        <%
                            float sum = 0;
                            for (Order order : listOrder) {
                                for (OrderDetails od : orderDetails) {
                                    if (od.getOrderID() == order.getId()) {
                                        if(order.getStatus().equals("Payment Complete")){
                                            sum += od.getPrice() * od.getQuantity() + (od.getPrice() * od.getQuantity()) * 0.1 + 300;
                                        }
                                    }
                                }
                            }
                        %>
                        <p>Revenue:</p>
                        <h1><%= sum%>¥</h1>
                    </div>
                </div>
                <%
                } else if (choice.equalsIgnoreCase("Customer")) {
                %>
                <div class="manage-customer">
                    <div>
                        <h1>CUSTOMER MANAGEMENT</h1>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 100px;">No</th>
                                <th style="width: 100px;">ID</th>
                                <th style="width: 200px;">Name</th>
                                <th>Avatar</th>
                                <th style="width: 300px;">Phone</th>
                                <th style="width: 300px;">Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int no = 1;
                                List<Customer> listCustomer = dao.getListCustomer();
                                if (listCustomer != null) {
                                    for (Customer customer : listCustomer) {
                            %>
                            <tr>
                                <td><%= no++%></td>
                                <td><%= customer.getId()%></td>
                                <td><%= customer.getFullname()%></td>
                                <td>
                                    <img src="<%= customer.getAvatar()%>" alt="<%= customer.getFullname()%>" class="img-product">
                                </td>
                                <td><%= customer.getPhone()%></td>
                                <td><%= customer.getAddress()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <%
                } else if (choice.equalsIgnoreCase("Product")) {
                %>
                <div class="manage-product">
                    <div class="header-manage">
                        <h1>PRODUCT MANAGEMENT</h1>
                        <div>
                            <form action="Management.jsp">
                                <input type="submit" name="popup" value="Add Product" class="add-btn">
                                <input type="hidden" name="choice" value="Product">
                            </form>
                        </div>
                    </div>
                    <%
                        if (popup != null && popup.equalsIgnoreCase("Add Product")) {
                    %>
                    <div class="add-container">
                        <form action="MainController" method="POST">
                            <h1>ADD NEW PRODUCT</h1>
                            <div class="input-info">
                                Product ID: <br>
                                <input type="number" name="id">
                            </div>
                            <div class="input-info">
                                Product Name: <br>
                                <input type="text" name="name">
                            </div>
                            <div class="input-info">
                                Image URL: <br>
                                <input type="text" name="image">
                            </div>
                            <div class="input-info">
                                Product Type: <br>
                                <input type="text" name="type">
                            </div>
                            <div class="input-info">
                                Product Description: <br>
                                <input type="text" name="description">
                            </div>
                            <div class="input-info">
                                Product Color: <br>
                                <input type="text" name="color">
                            </div>
                            <div class="input-info">
                                Quantity: <br>
                                <input type="number" name="quantity">
                            </div>
                            <div class="input-info">
                                Price: <br>
                                <input type="number" name="price">
                            </div>
                            <div class="input-info">
                                Open Day: <br>
                                <input type="date" name="open_day">
                            </div>
                            <div class="input-info">
                                Closed Day: <br>
                                <input type="date" name="closed_day">
                            </div>
                            <div class="input-info">
                                isSale: <br>
                                <input type="number" name="isSale">
                            </div>
                            <div class="btn-zone">
                                <input type="submit" name="action" value="Save">
                            </div>
                        </form>
                    </div>
                    <%
                        }
                    %>
                    <div style="margin-top: 10px;">
                        <p style="color: green">${noti}</p>
                        <p style="color: red">${alert}</p>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 50px;">No</th>
                                <th style="width: 50px;">ID</th>
                                <th style="width: 200px;">Name</th>
                                <th>Image</th>
                                <th style="width: 100px;">Type</th>
                                <th style="width: 200px;">Description</th>
                                <th style="width: 100px;">Color</th>
                                <th style="width: 50px;">Quantity</th>
                                <th style="width: 100px;">Price</th>
                                <th style="width: 150px;">Open Day</th>
                                <th style="width: 150px;">Closed Day</th>
                                <th style="width: 50px;">Status</th>
                                <th>Update</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int no = 1;
                                List<Product> listProduct = dao.getListProduct();
                                if (listProduct != null) {
                                    for (Product p : listProduct) {
                            %>
                            <tr>
                        <form action="MainController" method="POST">
                            <td><%= no++%></td>
                            <td>
                                <input type="number" 
                                       name="id" 
                                       value="<%= p.getId()%>"
                                       style="width: 50px;">
                            </td>
                            <td>
                                <input 
                                    type="text" 
                                    name="name" 
                                    value="<%= p.getName()%>"
                                    style="width: 100px;">
                            </td>
                            <td>
                                <img src="<%= p.getImage()%>" alt="<%= p.getName()%>" class="img-product">
                                <input type="text" name="image" value="<%= p.getImage()%>">
                            </td>
                            <td>
                                <input type="text" 
                                       name="type" 
                                       value="<%= p.getType()%>"
                                       style="width: 100px;">
                            </td>
                            <td>
                                <input 
                                    type="text" 
                                    name="description" 
                                    value="<%= p.getDescription()%>"
                                    style="overflow-wrap: break-word;">
                            </td>
                            <td>
                                <input type="text" name="color" value="<%= p.getColor()%>" style="width: 50px;">
                            </td>
                            <td>
                                <input type="number" 
                                       name="quantity" 
                                       value="<%= p.getQuantity()%>"
                                       style="width: 50px;">
                            </td>
                            <td>
                                <input 
                                    type="number" 
                                    name="price" 
                                    value="<%= p.getPrice()%>"
                                    style="width: 50px;">
                            </td>
                            <td>
                                <input type="date" name="open_day" value="<%= p.getOpenDay()%>" style="width: 100px;">
                            </td>
                            <td>
                                <input type="date" name="closed_day" value="<%= p.getClosedDay()%>" style="width: 100px;">
                            </td>
                            <td>
                                <input type="text" 
                                       name="isSale" 
                                       value="<%= p.getIsSale()%>"
                                       style="width: 50px;">
                            </td>
                            <td>
                                <input type="submit" name="action" value="Update" class="btn update">
                            </td>
                            <td>
                                <input type="submit" name="action" value="Delete" class="btn delete">
                            </td>
                        </form>
                        </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <%
                } else if (choice.equalsIgnoreCase("Order")) {
                %>
                <div class="my-order">
                    <h1 style="color: #FF7A00">Order Management</h1>
                    <table>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Order Date</th>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Full Name</th>
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
                                <%
                                    List<Customer> listCustomer = dao.getListCustomer();
                                    if (listCustomer != null) {
                                        for (Customer customer : listCustomer) {
                                            if(order.getCustomerID().equals(customer.getId())){
                                        
                                %>
                                <td><%= customer.getFullname()%></td>
                                <%
                                            }
                                        }
                                    }
                                %>
                                <td><%= order.getPhone()%></td>
                                <td><%= order.getAddress()%></td>
                                <td style="color: <%= order.getStatus().equals("Payment Complete") ? "green" : "red" %>">
                                    <%= order.getStatus()%>
                                </td>
                            </tr>
                            <%
                                        }
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>

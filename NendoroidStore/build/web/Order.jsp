<%-- 
    Document   : Order
    Created on : Mar 18, 2024, 1:26:21 PM
    Author     : Admin
--%>

<%@page import="dto.Bank"%>
<%@page import="dto.OrderDetails"%>
<%@page import="dto.Customer"%>
<%@page import="java.util.List"%>
<%@page import="dto.Order"%>
<%@page import="dto.Product"%>
<%@page import="dao.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/style.css">
        <link rel="stylesheet" href="style/OrderPage.css">
        <title>Order Info</title>
    </head>
    <body>
        <%
            DAO dao = new DAO();
            List<Order> orderList = dao.getOrder();
            Order order = null;
            if (orderList != null && !orderList.isEmpty()) {
                order = orderList.get(orderList.size() - 1);
            }
            Customer customer = (Customer) session.getAttribute("customer");
        %>

        <div class="order-container">
            <div class="order-form">
                <div class="form-container">
                    <h1>Order Information</h1>
                    <p style="color: red">${alert}</p>

                    <form action="OrderController">
                        <div>
                            Full Name: <br>
                            <input type="text" 
                                   name="fullname" 
                                   value="<%= customer.getFullname()%>"
                                   class="info-input" 
                                   placeholder="Enter your fullname"/>
                        </div>
                        <div>
                            Phone number: <br>
                            <input type="text" 
                                   name="phone" 
                                   value="<%= (order != null) ? order.getPhone() : ""%>"
                                   class="info-input" 
                                   placeholder="Enter your phone number"/>
                        </div>
                        <div>
                            Address: <br>
                            <input 
                                type="text" 
                                name="address"
                                value="<%= (order != null) ? order.getAddress() : ""%>"
                                class="info-input" 
                                placeholder="Enter the address to delivery"/>
                        </div>
                        <div>
                            Note: <br>
                            <input type="text" 
                                   name="note" 
                                   class="info-input" 
                                   placeholder="Note for shipper"/>
                        </div>
                    </form>
                    <div>
                        <input type="checkbox" name="confirm"/> 
                        I commit that the above information is true
                    </div>
                </div>
            </div>
            <div class="product-container">
                <%
                    List<OrderDetails> orderDetails = dao.getOrderDetails();
                    Product p = null;
                    if (orderDetails != null && !orderDetails.isEmpty()) {
                        for (OrderDetails od : orderDetails) {
                            if (od.getOrderID() == order.getId()) {
                                p = dao.getProduct(od.getProductID());
                            }
                        }
                    }
                %>

                <div class="order-product">
                    <div class="img-product">
                        <img src="<%= p.getImage()%>" alt="<%= p.getName()%>">
                    </div>
                    <div class="product-name">
                        <h2 style="color: <%= p.getColor()%>">
                            <%= p.getId()%> - <%= p.getName()%>
                        </h2>
                        <div class="quantity-input">
                            <span>Quantity: 1</span>
                        </div>
                    </div>
                    <div class="price">
                        <h1><%= p.getPrice()%>¥</h1>
                    </div>
                </div>
                <%
                    float totalProduct = p.getPrice();
                    double vat = (double) 0.1 * totalProduct;
                    double total = totalProduct + vat + 300;
                %>
                <div class="total-price">
                    <p>Total products price:</p>
                    <h2><%= totalProduct%>¥</h2>
                </div>
                <div class="vat">
                    <p>VAT (10%):</p>
                    <h2><%= vat%>¥</h2>
                </div>
                <div class="delivery">
                    <p>Delivery fee:</p>
                    <h2>300.0¥</h2>
                </div>
                <div class="total">
                    <p>Total:</p>
                    <h1><%= total%>¥</h1>
                </div>
                <div style="text-align: center;">
                    <%
                        Bank bank = dao.getBank(customer.getBankID());
                        if (bank.getBalance() < total) {
                    %>
                        <p style="color: red;">Account balance is not enough!</p>
                        <button class="btn" disabled
                                style="background-color: grey;">
                            Pay
                        </button>
                    <%
                    } else {
                    %>
                    <form action="MainController">
                        <button class="btn" 
                                type="submit"
                                name="action"
                                value="Pay">
                            Pay
                        </button>
                        <input type="hidden" name="total" value="<%= total%>">
                        <input type="hidden" name="orderID" value="<%= order.getId()%>">
                    </form>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>

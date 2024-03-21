<%-- 
    Document   : Register
    Created on : Mar 18, 2024, 1:20:27 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/style.css">
        <link rel="stylesheet" href="style/LoginPage.css">
        <title>Register</title>
    </head>
    <body>
        <div class="login-container">
            <div class="login-image">
                <img src="assets/img/LoginCover.png" alt="Login Cover">
                <div class="center">
                    <img src="assets/img/Logo.png" alt="Logo" class="logo">
                </div>

            </div>
            <div class="login-form">
                <div class="form-container">
                    <h1>CUSTOMER INFO</h1>
                    <p style="color: red">${alert}</p>
                    <form action="CustomerController">
                        <div>
                            Full Name: <br><input type="text" name="fullname" class="info-input" placeholder="Enter your fullname">
                        </div>
                        <div>
                            Avatar: <br><input type="text" name="avatar" class="info-input" placeholder="Enter your avatar url">
                        </div>
                        <div>
                            Phone number: <br><input type="text" name="phone" class="info-input" placeholder="Enter your phone number">
                        </div>
                        <div>
                            Address: <br><input type="text" name="address" class="info-input" placeholder="Enter your address">
                        </div>
                        <input type="submit" name="action" value="Add info" class="login-btn">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

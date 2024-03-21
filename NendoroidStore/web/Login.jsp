<%-- 
    Document   : Login
    Created on : Mar 12, 2024, 5:05:14 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/style.css">
        <link rel="stylesheet" href="style/LoginPage.css">
        <title>Login Page</title>
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
                    <h1>LOGIN ACCOUNT</h1>
                    <p style="color: red">${alert}</p>
                    <form action="LoginController">
                        <div>
                            Username: <br><input type="text" name="username" class="info-input" placeholder="Username">
                        </div>
                        <div>
                            Password: <br><input type="password" name="password" class="info-input" placeholder="Password">
                        </div>
                        <input type="submit" name="action" value="Login" class="login-btn">
                        <span>Don't have account? <a href="Register.jsp" class="register-link">Register here</a></span>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

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
                    <h1>REGISTER</h1>
                    <p style="color: red">${alert}</p>
                    <form action="RegisterController">
                        <div>
                            Username: <br><input type="text" name="username" class="info-input" placeholder="Username">
                        </div>
                        <div>
                            Password: <br><input type="password" name="password" class="info-input" placeholder="Password">
                        </div>
                        <div>
                            Confirm Password: <br><input type="password" name="confirm-password" class="info-input" placeholder="Confirm Password">
                        </div>
                        <input type="submit" name="action" value="Register" class="login-btn">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

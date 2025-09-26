<%-- 
    Document   : login
    Created on : Jul 20, 2025, 11:17:17 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        * {
            padding: 0;
            margin: 0;
            border: 0;
            box-sizing: border-box !important;
            font-family: Helvetica, Arial, sans-serif;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 140px;
        }
        #login-form {
            border: 1px solid #ccc;
            padding: 40px 20px;
            display: block;
            border-radius: 5px;
        }
        .login-form-content .form-control{
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 17px;
            padding: 14px 16px;
            width: 364px;
            box-sizing: border-box;
        }
        .text-content-wrapper {
            margin-bottom: 16px;
        }
        .login-btn {
            background-color: #1877f2;
            border: none;
            border-radius: 6px;
            font-size: 20px;
            line-height: 48px;
            padding: 0 16px;
            width: 366px;
            color: white;
            cursor: pointer;
            display: inline-block;
        }
        .forget-password {
            color: #247cee;
            margin-top: 16px;
            text-decoration: none;
            text-align: center;
            display: block;
            font-size: 14px;
        }
        .hr {
            border-top: 1px solid #ccc;
            margin: 22px 0;
        }

        .create-new-account-btn-container {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .create-new-account-btn {
            background-color: #42b72a;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 17px;
            line-height: 48px;
            padding: 0 16px;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <form method="POST" action="./login" id="login-form">
            <div class="login-form-content">
                <div class="text-content-wrapper">
                    <input name="username" type="text" placeholder="Enter your username..." class="form-control">
                </div>
                <div class="text-content-wrapper">
                    <input name="password" type="password" placeholder="Password" class="form-control">
                </div>
                <% String message = (String)request.getAttribute("message"); %>
                <% if(message != null) { %>
                    <span><%= message %></span>
                <% } %>
                <div class="login-btn-container">
                    <button class="login-btn">Log in</button>
                </div>
                <a href="login.html" class="forget-password">Forgotten password?</a>
                <div class="hr"></div>
                <div class="create-new-account-btn-container">
                    <button class="create-new-account-btn">Create new account</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>

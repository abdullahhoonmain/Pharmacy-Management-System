<%-- 
    Document   : creditentialserrorpage
    Created on : Nov 27, 2024, 10:48:51 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Error</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

         .error-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            text-align: center;
            width: 350px;
        }

         .error-container h1 {
            font-size: 1.8rem;
            color: #e63946;
            margin-bottom: 1rem;
        }

        .error-container p {
            font-size: 1rem;
            color: #555;
            margin-bottom: 2rem;
        }

        /* Button Styles */
        .error-container .btn {
            padding: 0.6rem 1rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            background-color: #2b7a78;
            color: #fff;
        }

        .error-container .btn:hover {
            background-color: #3aafa9;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Login Failed</h1>
        <p>Invalid username or password. Please try again.</p>
        <a href="login.jsp" class="btn">Go Back to Login</a>
    </div>
</body>
</html>


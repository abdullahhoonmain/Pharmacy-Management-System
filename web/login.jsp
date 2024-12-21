<%-- 
    Document   : login.jsp
    Created on : Nov 27, 2024, 5:31:13 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pharmacy Management System</title>
    <style>
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

         .login-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 300px;
            text-align: center;
        }

        /* Heading */
        .login-container h1 {
            margin-bottom: 1rem;
            font-size: 1.5rem;
            color: #2b7a78;
        }

         .login-container label {
            display: block;
            text-align: left;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #555;
        }

        .login-container input {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

        /* Button Styles */
        .login-container button {
            width: 100%;
            padding: 0.6rem;
            background-color: #2b7a78;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }

        .login-container button:hover {
            background-color: #3aafa9;
        }

        /* Sign Up Link Button */
        .signup-button {
            margin-top: 1rem;
            display: inline-block;
            width: 100%;
            padding: 0.6rem;
            background-color: #888;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            text-align: center;
            text-decoration: none;
        }

        .signup-button:hover {
            background-color: #555;
        }

         .login-container p {
            font-size: 0.8rem;
            color: #888;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Pharmacy Management System</h1>
        <form action="LoginServlet" method="POST">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" placeholder="Enter your username" required>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>
        </form>

        <a href="signup.jsp" class="signup-button">Sign Up</a>


        <p>&copy; 2024 Pharmacy Management System</p>
    </div>
</body>
</html>


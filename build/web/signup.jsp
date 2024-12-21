<%-- 
    Document   : signup
    Created on : Nov 27, 2024, 5:37:09 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - Pharmacy Management System</title>
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

         .signup-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 350px;
            text-align: center;
        }

         .signup-container h1 {
            margin-bottom: 1rem;
            font-size: 1.5rem;
            color: #2b7a78;
        }

         .signup-container label {
            display: block;
            text-align: left;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #555;
        }

        .signup-container input {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

         .signup-container button,
        .signup-container .signin-button {
            width: 100%;
            padding: 0.6rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
            text-align: center;
        }

         .signup-container button {
            background-color: #2b7a78;
            color: #fff;
        }

        .signup-container button:hover {
            background-color: #3aafa9;
        }

         .signup-container .signin-button {
            margin-top: 1rem;
            background-color: #888;
            color: #fff;
        }

        .signup-container .signin-button:hover {
            background-color: #555;
        }

        /* Footer Text */
        .signup-container p {
            font-size: 0.8rem;
            color: #888;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1>Signup</h1>
        <form action="SignupServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" id="name" placeholder="Enter your full name" required>

            <label for="designation">Designation:</label>
            <input type="text" name="designation" id="designation" placeholder="Enter your designation" required>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" placeholder="Enter your password" required>

            <label for="username">Username:</label>
            <input type="text" name="username" id="username" placeholder="Enter your username" required>

            <label for="phone">Phone Number:</label>
            <input type="tel" name="phone" id="phone" placeholder="Enter your phone number" required>

             <button type="submit">Sign Up</button>
        </form>

         <a href="login.jsp" class="signin-button">Sign In</a>

        <p>&copy; 2024 Pharmacy Management System</p>
    </div>
</body>
</html>


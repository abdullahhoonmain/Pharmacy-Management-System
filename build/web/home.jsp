<%-- 
    Document   : home
    Created on : Nov 27, 2024, 5:37:50 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page - Pharmacy Management System</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

         h1 {
            margin-top: 0;
            font-size: 2rem;
            color: #2b7a78;
        }

         .links-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
            background-color: #fff;
            padding: 1.5rem 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        /* Individual Links */
        .links-container a {
            text-decoration: none;
            color: #2b7a78;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

         .links-container img {
            width: 30px;
            height: 30px;
        }

        /* Hover Effect */
        .links-container a:hover {
            color: #3aafa9;
        }

        /* Footer */
        footer {
            margin-top: 1rem;
            font-size: 0.8rem;
            color: #888;
        }
    </style>
</head>
<body>
    <h1>Pharmacy Management System</h1>

    <div class="links-container">
        <a href="bill.jsp"><img src="121.png" alt="Bill Icon"> Bill</a>
        <a href="transactionrecord.jsp"><img src="131.png" alt="Transaction Record Icon"> Transaction Record</a>
        <a href="addstock.jsp"><img src="11.png" alt="Stock Icon"> Update Stock</a>
        <a href="viewStock.jsp"><img src="viewStock.png" alt="View Stock Icon"> View Stock</a>
        <a href="supplier.jsp"><img src="141.png" alt="Supplier Icon"> Supplier</a>
        <a href="login.jsp"><img src="1.png" alt="Logout Icon"> Logout</a>
    </div>

    <footer>&copy; 2024 Pharmacy Management System</footer>
</body>
</html>

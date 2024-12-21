<%-- 
    Document   : stock
    Created on : Nov 27, 2024, 5:45:06 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Management - Pharmacy</title>
    <style>
        /* (Existing CSS) */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
                .back-btn {
            width: 80px;
            height: 50px;
            padding: 0.6rem;
            background-color: #2b7a78;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            text-align: center;
            display: inline-block;
            margin-top: 2rem;
            text-decoration: none;
        }

        .stock-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 80%;
            max-width: 900px;
        }
        h1 {
            text-align: center;
            color: #2b7a78;
            font-size: 1.8rem;
        }
        select, input {
            padding: 0.5rem;
            font-size: 1rem;
            margin: 1rem 0;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #2b7a78;
            color: white;
            padding: 0.7rem;
            font-size: 1rem;
            margin: 0.5rem 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #3aafa9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
        }
        th, td {
            padding: 1rem;
            text-align: center;
            border: 1px solid #ccc;
        }
        th {
            background-color: #2b7a78;
            color: white;
        }
        .low-stock {
            background-color: #ffcccb;  
        }
        .expired-stock {
            background-color: #f4d03f;  
        }
    </style>
</head>
<body>
    <div class="stock-container">
        <h1>Stock Management</h1>
        <a href="home.jsp"><button type="submit" class="back-btn">Home</button></a>


<!--         Stock Filter Dropdown 
        <label for="filterCategory">Filter by Category:</label>
        <select id="filterCategory" onchange="filterStock()">
            <option value="All">All</option>
            <option value="Tablet">Tablet</option>
            <option value="Syrup">Syrup</option>
            <option value="Injection">Injection</option>
        </select>-->

         <form  action="AddStockServlet" method="POST">
            <input type="hidden" name="action" value="addStock">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" required>

           

            <label for="category">Category:</label>
            <select name="category" id="category">
            <option value="Tablet">Tablet</option>
            <option value="Syrup">Syrup</option>
            <option value="Injection">Injection</option>
            <option value="others">Others</option>
            </select>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required>

            <label for="expiryDate">Expiry Date:</label>
            <input type="date" id="expiryDate" name="expiryDate" required>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" required>

            <button type="submit" >Add Stock</button>
        </form>

        <!-- Stock Table -->
<!--        <table id="stockTable">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Quantity</th>
                    <th>Expiry Date</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="stockList">
                 Stock entries will appear here 
            </tbody>
        </table>-->
    </div>

   
</body>
</html>

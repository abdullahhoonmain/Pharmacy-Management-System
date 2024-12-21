<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Stock</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .bill-container {
            max-width: 900px;
            margin: 2rem auto;
            background-color: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #2b7a78;
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
        button {
            background-color: #2b7a78;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #3aafa9;
        }
        .filter-container {
            margin: 1rem auto;
            text-align: center;
        }
        .filter-container select {
            padding: 0.5rem;
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Stock Management</h1>
        <a href="home.jsp"><button type="submit" class="back-btn">Home</button></a>
    </div>

    <div class="filter-container">
        <form method="GET" action="viewStock.jsp">
            <label for="categoryFilter">Filter by Category:</label>
            <select name="categoryFilter" id="categoryFilter" onchange="this.form.submit()">
                <option value="">All</option>
                <option value="Tablet" <%= "Tablet".equals(request.getParameter("categoryFilter")) ? "selected" : "" %>>Tablets</option>
                <option value="Injection" <%= "Injection".equals(request.getParameter("categoryFilter")) ? "selected" : "" %>>Injections</option>
                <option value="Syrup" <%= "Syrup".equals(request.getParameter("categoryFilter")) ? "selected" : "" %>>Syrups</option>
            </select>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Expiry Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "");

                    String selectedCategory = request.getParameter("categoryFilter");
                    String sql = "SELECT * FROM stock";
                    
                    if (selectedCategory != null && !selectedCategory.isEmpty()) {
                        sql += " WHERE PCategory = ?";
                    }

                    ps = conn.prepareStatement(sql);

                    if (selectedCategory != null && !selectedCategory.isEmpty()) {
                        ps.setString(1, selectedCategory);
                    }

                    rs = ps.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("PID");
                        String name = rs.getString("PName");
                        String category = rs.getString("PCategory");
                        Integer quantity = rs.getInt("PQuantity");
                        Integer price = rs.getInt("PPrice");
                        String expiry = rs.getString("PExpiry");
            %>
            <form method="POST" action="viewStock.jsp">
                <tr>
                    <td><%= id %></td>
                    <td><input type="text" name="name" value="<%= name %>"></td>
                    <td><input type="text" name="category" value="<%= category %>"></td>
                    <td><input type="number" name="quantity" value="<%= quantity %>"></td>
                    <td><input type="number" name="price" value="<%= price %>"></td>
                    <td><input type="text" name="expiry" value="<%= expiry %>"></td>
                    <td>
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" name="action" value="edit">Edit</button>
                        <button type="submit" name="action" value="delete" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                    </td>
                </tr>
            </form>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException ex) {
                        out.println("<tr><td colspan='7'>Error closing resources: " + ex.getMessage() + "</td></tr>");
                    }
                }
            %>
        </tbody>
    </table>

    <%
        String action = request.getParameter("action");
        if (action != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int price = Integer.parseInt(request.getParameter("price"));
            String expiry = request.getParameter("expiry");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "");

                if ("edit".equals(action)) {
                    String updateSQL = "UPDATE stock SET PName = ?, PCategory = ?, PQuantity = ?, PPrice = ?, PExpiry = ? WHERE PID = ?";
                    ps = conn.prepareStatement(updateSQL);
                    ps.setString(1, name);
                    ps.setString(2, category);
                    ps.setInt(3, quantity);
                    ps.setInt(4, price);
                    ps.setString(5, expiry);
                    ps.setInt(6, id);
                    ps.executeUpdate();
                    response.sendRedirect("viewStock.jsp"); // Refresh the page
                } else if ("delete".equals(action)) {
                    String deleteSQL = "DELETE FROM stock WHERE PID = ?";
                    ps = conn.prepareStatement(deleteSQL);
                    ps.setInt(1, id);
                    ps.executeUpdate();
                    response.sendRedirect("viewStock.jsp"); // Refresh the page
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    out.println("Error closing resources: " + ex.getMessage());
                }
            }
        }
    %>
</body>
</html>

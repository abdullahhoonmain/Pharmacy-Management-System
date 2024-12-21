<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    ArrayList<HashMap<String, String>> supplierList = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "");

        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM suppliers");

        while (rs.next()) {
            HashMap<String, String> supplier = new HashMap<>();
            supplier.put("id", rs.getString("SID"));
            supplier.put("name", rs.getString("SName"));
            supplier.put("contact", rs.getString("SPhone"));
            supplierList.add(supplier);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier - Pharmacy Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
        }

        h1 {
            color: #2b7a78;
            margin-bottom: 1rem;
        }

        form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            width: 400px;
            margin-bottom: 2rem;
        }

        form label {
            display: block;
            margin-bottom: 0.5rem;
            color: #555;
        }

        form input {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }

        form button {
            width: 100%;
            padding: 0.6rem;
            background-color: #2b7a78;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }

        form button:hover {
            background-color: #3aafa9;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 1rem;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 1rem;
            text-align: left;
        }

        table th {
            background-color: #2b7a78;
            color: white;
        }
        .back-btn {
            width: 100%;
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

.back-btn:hover {
    background-color: #3aafa9; 
}


        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .action-buttons form {
            display: inline;
        }

        .action-buttons button {
            padding: 0.4rem 0.8rem;
            font-size: 0.9rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .delete-btn {
            background-color: #f44336;
            color: white;
        }

        .delete-btn:hover {
            background-color: #d32f2f;
        }

        .edit-btn {
            background-color: #ff9800;
            color: white;
        }

        .edit-btn:hover {
            background-color: #fb8c00;
        }
    </style>
    <script>
        
        function escapeHTML(str) {
            return str.replace(/&/g, "&amp;")
                      .replace(/</g, "&lt;")
                      .replace(/>/g, "&gt;")
                      .replace(/"/g, "&quot;")
                      .replace(/'/g, "&#039;");
        }

        function editSupplier(id, name, contact) {
            document.getElementById('editID').value = escapeHTML(id);
            document.getElementById('editName').value = escapeHTML(name);
            document.getElementById('editContact').value = escapeHTML(contact);
            document.getElementById('editForm').style.display = 'block';
        }
    </script>
</head>
<body>
    <h1>Supplier Management</h1>

    <!-- Add Supplier Form -->
    <form action="SupplierServlet" method="POST">
        <input type="hidden" name="action" value="add">
        <label for="supplierName">Supplier Name:</label>
        <input type="text" id="supplierName" name="supplierName" placeholder="Enter supplier name" required>
        <label for="supplierID">Supplier ID:</label>
        <input type="text" name="supplierID" id="supplierID" placeholder="Enter supplier ID" required>
        <label for="supplierContact">Phone Number:</label>
        <input type="tel" name="supplierContact" id="supplierContact" placeholder="Enter supplier contact" required>
        <button type="submit">Save</button>
    </form>

    <!-- Edit Supplier Form -->
    <form action="SupplierServlet" method="POST" id="editForm" style="display: none;">
        <h2>Edit Supplier</h2>
        <input type="hidden" name="action" value="edit">
        <input type="hidden" id="editID" name="supplierID">
        <label for="editName">Supplier Name:</label>
        <input type="text" id="editName" name="supplierName" required>
        <label for="editContact">Phone Number:</label>
        <input type="tel" id="editContact" name="supplierContact" required>
        <button type="submit">Update</button>
    </form>

    
    <table>
        <tr>
            <th>Supplier ID</th>
            <th>Supplier Name</th>
            <th>Supplier Contact</th>
            <th>Actions</th>
        </tr>
        <% for (HashMap<String, String> supplier : supplierList) { %>
        <tr>
            <td><%= supplier.get("id") %></td>
            <td><%= supplier.get("name") %></td>
            <td><%= supplier.get("contact") %></td>
            <td class="action-buttons">
              
                <form action="SupplierServlet" method="POST" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="supplierID" value="<%= supplier.get("id") %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
               
                <button type="button" class="edit-btn" 
                        onclick="editSupplier('<%= supplier.get("id") %>', '<%= supplier.get("name") %>', '<%= supplier.get("contact") %>')">Edit</button>
            </td>
        </tr>
        <% } %>
    </table> <br>
    <br>
    <a href="home.jsp"><button class="back-btn">Back to Home</button></a>

</body>
</html>

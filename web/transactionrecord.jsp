<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction Records</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .transaction-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 1200px;
            padding: 2rem;
            margin-top: 2rem;
        }

        h1 {
            text-align: center;
            color: #2b7a78;
            margin-bottom: 1.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        th {
            background-color: #2b7a78;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #d1e8e2;
        }

        .btn-container {
            margin-top: 2rem;
            text-align: center;
        }

        button {
            background-color: #2b7a78;
            color: #fff;
            padding: 0.7rem 1.5rem;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #3aafa9;
        }

        form {
            display: inline;
        }

        button.go-back-btn {
            background-color: #f44336;
            padding: 0.7rem 1.5rem;
            font-size: 1rem;
        }

        button.go-back-btn:hover {
            background-color: #e53935;
        }

        .bill-items {
            display: none;
            margin-top: 1rem;
            width: 100%;
            border-top: 2px solid #2b7a78;
        }

        .bill-items table {
            width: 100%;
            margin-top: 1rem;
            border: 1px solid #ccc;
        }

        .bill-items td {
            padding: 0.8rem;
        }
    </style>
    <script>
        function toggleItems(billId) {
            var itemsTable = document.getElementById("items-" + billId);
            // Toggle the display of bill items
            if (itemsTable.style.display === "none") {
                itemsTable.style.display = "table";
            } else {
                itemsTable.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <div class="transaction-container">
        <h1>Transactions</h1>
        <table>
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Customer Name</th>
                    <th>Bill Date</th>
                    <th>Total Amount</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Get database connection and query to fetch all bills
                    try {
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "");
                        String query = "SELECT * FROM bills";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                        
                        while (rs.next()) {
                            int billId = rs.getInt("id");
                            String customerName = rs.getString("customer_name");
                            String billDate = rs.getString("bill_date");
                            double totalAmount = rs.getDouble("total_amount");
                %>
                            <tr>
                                <td><%= billId %></td>
                                <td><%= customerName %></td>
                                <td><%= billDate %></td>
                                <td><%= totalAmount %></td>
                                <td><button onclick="toggleItems(<%= billId %>)">View Items</button></td>
                            </tr>

                            <!-- Table for Bill Items (Initially Hidden) -->
                            <tr id="items-<%= billId %>" class="bill-items">
                                <td colspan="5">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Item Name</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                // Fetch items for this bill
                                                String itemQuery = "SELECT * FROM bill_items WHERE bill_id = ?";
                                                try (PreparedStatement ps = conn.prepareStatement(itemQuery)) {
                                                    ps.setInt(1, billId);
                                                    ResultSet itemRs = ps.executeQuery();
                                                    
                                                    while (itemRs.next()) {
                                                        String itemName = itemRs.getString("item_name");
                                                        int quantity = itemRs.getInt("quantity");
                                                        double price = itemRs.getDouble("price");
                                                        double total = itemRs.getDouble("total");
                                            %>
                                                        <tr>
                                                            <td><%= itemName %></td>
                                                            <td><%= quantity %></td>
                                                            <td><%= price %></td>
                                                            <td><%= total %></td>
                                                        </tr>
                                            <% 
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <div class="btn-container">
            <form action="bill.jsp" method="get">
                <button type="submit" class="go-back-btn">Go Back to Bills</button>
            </form>
        </div>
    </div>
</body>
</html>

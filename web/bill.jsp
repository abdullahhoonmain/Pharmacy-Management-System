<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Bill</title>
    <style>
        
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f7f9fc;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #2c786c; 
        }

        form {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }

        input, select, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        input[type="submit"], button {
            background-color: #2c786c;  
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #245d55;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #2c786c;
            color: white;
        }

        .total {
            font-weight: bold;
            text-align: right;
        }

        .remove-btn {
            color: white;
            background-color: #d9534f;  
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
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

        .remove-btn:hover {
            background-color: #c12e2a;
        }

        .grand-total {
            text-align: right;
            font-weight: bold;
            margin-top: 20px;
            color: #2c786c;
        }
    </style>
    </style>
</head>
<body>
    <h1>Generate Bill</h1>
    <a href="home.jsp"><button type="button" class="back-btn">Home</button></a>

    <form action="BillServlet" method="post" name="billForm">
        <label for="customerName">Customer Name:</label>
        <input type="text" id="customerName" name="customerName" required><br><br>

        <label for="billDate">Bill Date:</label>
        <input type="date" id="billDate" name="billDate" required><br><br>
        


        <label for="medicine">Select Medicine:</label>
        <select id="medicine" name="medicineId">
            <option value="" disabled selected>Select a Medicine</option>
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "");

                    String query = "SELECT PID, PName, PQuantity, PPrice FROM stock WHERE PQuantity > 0";
                    ps = conn.prepareStatement(query);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        int pid = rs.getInt("PID");
                        String pname = rs.getString("PName");
                        int pquantity = rs.getInt("PQuantity");
                        int pprice = rs.getInt("PPrice");
            %>
                        <option value="<%= pid %>" data-price="<%= pprice %>" data-quantity="<%= pquantity %>">
                            <%= pname + " - Price: " + pprice + " - Available: " + pquantity %>
                        </option>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <option value="">Error loading stock</option>
            <%
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </select><br><br>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" min="1" required><br><br>

        <button type="button" onclick="addToBill()">Add to Bill</button><br><br>

        <table id="billTable">
            <thead>
                <tr>
                    <th>Medicine Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table><br><br>

        <div>
            <strong>Grand Total: </strong><span id="grandTotal">0.00</span><br><br>
        </div>
                <input type="hidden" name="billData" id="billData">

        <input type="submit" value="Generate Bill">
    </form>

    <script>
        let billItems = [];

        function addToBill() {
            const medicineSelect = document.getElementById('medicine');
            const medicineId = medicineSelect.value;
            const medicineName = medicineSelect.options[medicineSelect.selectedIndex].text.split(" - ")[0];
            const maxQuantity = parseInt(medicineSelect.options[medicineSelect.selectedIndex].getAttribute('data-quantity'));
            const price = parseFloat(medicineSelect.options[medicineSelect.selectedIndex].getAttribute('data-price'));
            const quantity = parseInt(document.getElementById('quantity').value);

            if (!medicineId) {
                alert('Please select a medicine.');
                return;
            }

            if (isNaN(quantity) || quantity < 1) {  
                alert('Please enter a valid quantity.');
                return;
            }

            if (quantity > maxQuantity) {
                alert(`The entered quantity exceeds the available stock (${maxQuantity}).`);
                return;
            }

            const total = price * quantity;

            billItems.push({
                medicineId: medicineId,
                medicineName: medicineName,
                quantity: quantity,
                price: price,
                total: total
            });
//            console.log("billItems after adding:", billItems);

            const table = document.getElementById('billTable').getElementsByTagName('tbody')[0];
            const row = table.insertRow();
            const cell1 = row.insertCell(0);
            const cell2 = row.insertCell(1);
            const cell3 = row.insertCell(2);
            const cell4 = row.insertCell(3);
            const cell5 = row.insertCell(4);

            cell1.textContent = medicineName;
            cell2.textContent = quantity;
            cell3.textContent = price.toFixed(2);
            cell4.textContent = total.toFixed(2);
            cell5.innerHTML = `<button class="remove-btn" onclick="removeItem(this)">Remove</button>`;

            updateGrandTotal();
        }

        function removeItem(button) {
            const row = button.closest('tr');
            const index = row.rowIndex - 1;
            billItems.splice(index, 1);
            row.remove();
            updateGrandTotal();
        }

        function updateGrandTotal() {
            const grandTotal = billItems.reduce((total, item) => total + item.total, 0);
            document.getElementById('grandTotal').textContent = grandTotal.toFixed(2);
        }

       const billForm = document.forms.billForm;

if (billForm) {
    billForm.onsubmit = function (event) {
        console.log("Form is being submitted!");

        // Prevent submission if no items are in the bill
        if (billItems.length === 0) {
            alert("Please add items to the bill.");
            event.preventDefault();
            return;
        }

        // Serialize the billItems array into JSON
        const hiddenField = document.getElementById('billData');
        hiddenField.value = JSON.stringify(billItems);
        

        console.log("Serialized Bill Data:", hiddenField.value);
        alert("Bill Generated Successfully");
    };
} else {
    console.error("Form with name 'billForm' not found.");
}

    </script>
</body>
</html>
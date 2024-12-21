/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import java.util.*;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/BillServlet"})
public class BillServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BillServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BillServlet at " + request.getContextPath() + "</h1>");
            out.println("<a href='bill.jsp' class='back-btn'>Back to Bill Page</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
         
        String customerName = request.getParameter("customerName");
        String billDate = request.getParameter("billDate");
        String billDataJson = request.getParameter("billData");

        if (billDataJson == null || billDataJson.isEmpty()) {
            response.getWriter().println("No bill data received.");
            return;
        }

        Gson gson = new Gson();
        Type listType = new TypeToken<List<Map<String, Object>>>() {}.getType();
        List<Map<String, Object>> billItems = gson.fromJson(billDataJson, listType);

        if (billItems.isEmpty()) {
            response.getWriter().println("No items in the bill.");
            return;
        }

        double totalAmount = 0;

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "")) {

            String billSQL = "INSERT INTO bills (customer_name, bill_date, total_amount) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(billSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, customerName);
                ps.setString(2, billDate);
                ps.setDouble(3, 0);  
                ps.executeUpdate();

                ResultSet generatedKeys = ps.getGeneratedKeys();
                int billId = -1;
                if (generatedKeys.next()) {
                    billId = generatedKeys.getInt(1);  
                }

                if (billId == -1) {
                    response.getWriter().println("Failed to generate bill, no bill_id found.");
                    return;
                }

                for (Map<String, Object> item : billItems) {
                    int medicineId = Integer.parseInt(item.get("medicineId").toString());
                    String itemName = item.get("medicineName").toString();
                    int quantity = ((Double) item.get("quantity")).intValue();
                    double price = (Double) item.get("price");
                    totalAmount += quantity * price;

                    String billItemSQL = "INSERT INTO bill_items (bill_id, item_id, item_name, quantity, price, total) VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement psBillItem = conn.prepareStatement(billItemSQL)) {
                        psBillItem.setInt(1, billId);
                        psBillItem.setInt(2, medicineId);
                        psBillItem.setString(3, itemName);
                        psBillItem.setInt(4, quantity);
                        psBillItem.setDouble(5, price);
                        psBillItem.setDouble(6, quantity * price);
                        psBillItem.executeUpdate();
                    }

                    String stockUpdateSQL = "UPDATE stock SET PQuantity = PQuantity - ? WHERE PID = ?";
                    try (PreparedStatement psStockUpdate = conn.prepareStatement(stockUpdateSQL)) {
                        psStockUpdate.setInt(1, quantity);
                        psStockUpdate.setInt(2, medicineId);
                        psStockUpdate.executeUpdate();
                    }
                }

                String updateBillSQL = "UPDATE bills SET total_amount = ? WHERE id = ?";
                try (PreparedStatement psUpdateBill = conn.prepareStatement(updateBillSQL)) {
                    psUpdateBill.setDouble(1, totalAmount);
                    psUpdateBill.setInt(2, billId);
                    psUpdateBill.executeUpdate();
                }

                response.getWriter().println("Bill generated successfully with ID: " + billId + ". Total Amount: " + totalAmount);
                response.getWriter().println("<br><br>");
response.getWriter().println("<form action='bill.jsp' method='get'>");
response.getWriter().println("<button type='submit'>Go Back to Bills</button>");
response.getWriter().println("</form>");
response.sendRedirect("bill.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

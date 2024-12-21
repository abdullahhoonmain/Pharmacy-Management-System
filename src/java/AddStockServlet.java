/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/AddStockServlet"})
public class AddStockServlet extends HttpServlet {

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
            out.println("<title>Servlet StockServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StockServlet at " + request.getContextPath() + "</h1>");
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
       // processRequest(request, response);
       String action= request.getParameter("action");
       if(action.equals("addStock"))
       {
            String name= request.getParameter("productName");
            String category= request.getParameter("category");
            int quantity= Integer.parseInt(request.getParameter("quantity"));
            String expirydate= request.getParameter("expiryDate");
            int price = Integer.parseInt(request.getParameter("price"));

            try(Connection conn=DBConnection.getConnect())
            {
                String sql= "INSERT INTO stock (PName,PCategory, PPrice, PQuantity, PExpiry) VALUES (?,?,?,?,?)";
                PreparedStatement ps= conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, category);
                ps.setInt(3, price);
                ps.setInt(4, quantity);
                ps.setString(5, expirydate);
                
                int rowInserted= ps.executeUpdate();
                if(rowInserted>0)
                {
                    response.sendRedirect("addstock.jsp");
                }
                else
                {
                response.getWriter().println("Product cannot be added");
                }
                
            }
            
            catch (SQLException ex) {
               Logger.getLogger(AddStockServlet.class.getName()).log(Level.SEVERE, null, ex);
               response.getWriter().println("<p>Error: "+ ex.getMessage());
               
           }

       
       }
       
       
    }

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

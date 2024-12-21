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
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

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
            out.println("<title>Servlet SignupServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupServlet at " + request.getContextPath() + "</h1>");
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
       
      String name= request.getParameter("name");
      String username= request.getParameter("username");
      String phoneno=request.getParameter("phone");
      String password= request.getParameter("password");
      String designation= request.getParameter("designation");
      System.out.print(name);
      
      
      
      try(Connection conn= DBConnection.getConnect())
      {
          String query= "INSERT INTO users (Name, Username, Password, Designation, PhoneNo) VALUES (?,?,?,?,?)";
          
          PreparedStatement ps= conn.prepareStatement(query);
          ps.setString(1, name);
          ps.setString(2, username);
          ps.setString(3,password);
          ps.setString(4, designation );
          ps.setString(5,phoneno);

          
          int rowsInserted = ps.executeUpdate(); // Use executeUpdate for non-SELECT queries
    if (rowsInserted > 0) {
        System.out.println("User registered successfully!");
        response.sendRedirect("home.jsp");
        }
          


//          
//          if(rs.next())
//          {
//          response.getWriter().println("Account Created Successfully"+ name);
//          }
//          
//          else {
//          response.getWriter().println("Some problem occured, please try again");
//          }
      }
      
      catch (SQLException ex)
      {
      Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
      response.getWriter().println("Error:"+ex.getMessage());
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

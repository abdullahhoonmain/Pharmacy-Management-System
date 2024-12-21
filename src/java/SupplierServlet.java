
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/SupplierServlet"})
public class SupplierServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Supplier Servlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Supplier Servlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // Handle GET requests (Optional)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("add")) {
            String supplierID = request.getParameter("supplierID");
            String supplierName = request.getParameter("supplierName");
            String supplierContact = request.getParameter("supplierContact");

            try (Connection conn = DBConnection.getConnect()) {
                String sql = "INSERT INTO suppliers (SID, SName, SPhone) VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, supplierID);
                ps.setString(2, supplierName);
                ps.setString(3, supplierContact);

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    response.getWriter().println("<p>Supplier added successfully!</p>");
                    response.sendRedirect("supplier.jsp");
                } else {
                    response.getWriter().println("<p>Failed to add supplier.</p>");
                }

            } catch (SQLException ex) {
                Logger.getLogger(SupplierServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.getWriter().println("<p>Error: " + ex.getMessage() + "</p>");
            }
        } else if ("edit".equalsIgnoreCase(action)) {
            String supplierID = request.getParameter("supplierID");
            String supplierName = request.getParameter("supplierName");
            String supplierContact = request.getParameter("supplierContact");

            try (Connection conn = DBConnection.getConnect()) {
                String sql = "UPDATE suppliers SET SName = ?, SPhone = ? WHERE SID = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, supplierName);
                ps.setString(2, supplierContact);
                ps.setString(3, supplierID);

                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().println("<p>Supplier updated successfully!</p>");
                    response.sendRedirect("supplier.jsp");
                } else {
                    response.getWriter().println("<p>Failed to update supplier.</p>");
                }

            } catch (SQLException ex) {
                Logger.getLogger(SupplierServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.getWriter().println("<p>Error: " + ex.getMessage() + "</p>");
            }

        } else if ("delete".equalsIgnoreCase(action)) {
            String supplierID = request.getParameter("supplierID");

            try (Connection conn = DBConnection.getConnect()) {
                String sql = "DELETE FROM suppliers WHERE SID = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, supplierID);

                int rowsDeleted = ps.executeUpdate();
                if (rowsDeleted > 0) {
                    response.getWriter().println("<p>Supplier deleted successfully!</p>");
                    response.sendRedirect("supplier.jsp");
                } else {
                    response.getWriter().println("<p>Failed to delete supplier.</p>");
                }

            } catch (SQLException ex) {
                Logger.getLogger(SupplierServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.getWriter().println("<p>Error: " + ex.getMessage() + "</p>");
            }

        } else {
            response.getWriter().println("<p>Invalid action!</p>");
        }
    }

    // Add Supplier
//    private void addSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        String supplierID = request.getParameter("supplierID");
//        String supplierName = request.getParameter("supplierName");
//        String supplierContact = request.getParameter("supplierContact");
//
//        try (Connection conn = DBConnection.getConnect()) {
//            String sql = "INSERT INTO suppliers (SID, SName, SPhone) VALUES (?, ?, ?)";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, supplierID);
//            ps.setString(2, supplierName);
//            ps.setString(3, supplierContact);
//
//            int rowsInserted = ps.executeUpdate();
//            if (rowsInserted > 0) {
//                response.getWriter().println("<p>Supplier added successfully!</p>");
//            } else {
//                response.getWriter().println("<p>Failed to add supplier.</p>");
//            }
//
//        } catch (SQLException ex) {
//            Logger.getLogger(SupplierServlet.class.getName()).log(Level.SEVERE, null, ex);
//            response.getWriter().println("<p>Error: " + ex.getMessage() + "</p>");
//        }
//    }
    // Update Supplier
//    private void updateSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        String supplierID = request.getParameter("supplierID");
//        String supplierName = request.getParameter("supplierName");
//        String supplierContact = request.getParameter("supplierContact");
//
//        try (Connection conn = DBConnection.getConnect()) {
//            String sql = "UPDATE suppliers SET SName = ?, SPhone = ? WHERE SID = ?";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, supplierName);
//            ps.setString(2, supplierContact);
//            ps.setString(3, supplierID);
//
//            int rowsUpdated = ps.executeUpdate();
//            if (rowsUpdated > 0) {
//                response.getWriter().println("<p>Supplier updated successfully!</p>");
//            } else {
//                response.getWriter().println("<p>Failed to update supplier.</p>");
//            }
//
//        } catch (SQLException ex) {
//            Logger.getLogger(SupplierServlet.class.getName()).log(Level.SEVERE, null, ex);
//            response.getWriter().println("<p>Error: " + ex.getMessage() + "</p>");
//        }
//    }
//
//    // Delete Supplier
//    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        String supplierID = request.getParameter("supplierID");
//
//        try (Connection conn = DBConnection.getConnect()) {
//            String sql = "DELETE FROM suppliers WHERE SID = ?";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, supplierID);
//
//            int rowsDeleted = ps.executeUpdate();
//            if (rowsDeleted > 0) {
//                response.getWriter().println("<p>Supplier deleted successfully!</p>");
//                response.sendRedirect("supplier.jsp");
//            } else {
//                response.getWriter().println("<p>Failed to delete supplier.</p>");
//            }
//
//        } catch (SQLException ex) {
//            Logger.getLogger(SupplierServlet.class.getName()).log(Level.SEVERE, null, ex);
//            response.getWriter().println("<p>Error: " + ex.getMessage() + "</p>");
//        }
//    }
    @Override
    public String getServletInfo() {
        return "Handles Supplier Management (Add, Update, Delete)";
    }
}

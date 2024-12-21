/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author HP
 */
public class DBConnection {
    private static Connection conn= null;  
    public static Connection getConnect()
    {
        try 
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/aoop", "root", "");
        }
        
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        
        return conn;
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author UwAngelique
 */
public class MySQLConnector {
        // MySQL connection details
    private static final String URL = "jdbc:mysql://localhost:3306/eventsdb?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";      // your DB username
    private static final String PASSWORD = "yego";  // your DB password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

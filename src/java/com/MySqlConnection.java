//package com;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//
//public class MySqlConnection {
//    Connection con = null;
//
//    public Connection getConnection() {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            // Use Docker service name instead of localhost
//            String url = "jdbc:mysql://localhost:3306/hms"; // Change 'mysql-db' if needed
//            String username = "root";
//            String password = "root";
//
//            con = DriverManager.getConnection(url, username, password);
//            System.out.println("Connected to DB: " + con);
//        } catch (Exception ex) {
//            System.out.println("Exception While Connecting:");
//            ex.printStackTrace(); // Show full stack trace
//        }
//        return con;
//    }
//}

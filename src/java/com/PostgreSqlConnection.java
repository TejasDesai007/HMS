package com;

import java.sql.Connection;
import java.sql.DriverManager;

public class PostgreSqlConnection {

    Connection con = null;

    public Connection getConnection() {
        try {
            // PostgreSQL driver
            Class.forName("org.postgresql.Driver");

            // Neon PostgreSQL JDBC URL (set via Render environment variable)
            String url = System.getenv("DB_URL");
            String username = System.getenv("DB_USER");
            String password = System.getenv("DB_PASS");

            con = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to PostgreSQL DB: " + con);

        } catch (Exception ex) {
            System.out.println("Exception While Connecting to PostgreSQL:");
            ex.printStackTrace();
        }
        return con;
    }
}

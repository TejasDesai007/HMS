package com;

import java.sql.Connection;
import java.sql.DriverManager;

public class PostgreSqlConnection {

    public Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            System.out.println("DB_URL = " + url);
            System.out.println("DB_USER = " + user);

            Connection con = DriverManager.getConnection(url, user, pass);

            System.out.println("✅ PostgreSQL Connected Successfully");
            return con;

        } catch (Exception e) {
            System.out.println("❌ DB CONNECTION FAILED");
            e.printStackTrace();
            return null;
        }
    }
}

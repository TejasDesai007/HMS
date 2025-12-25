package com;

import java.sql.Connection;
import java.sql.DriverManager;

public class PostgreSqlConnection {

    public Connection getConnection() {
        try {
            // Load PostgreSQL JDBC Driver
            Class.forName("org.postgresql.Driver");

            // ✅ CORRECT JDBC URL (NO username/password here)
            String url =
                "jdbc:postgresql://ep-dawn-dew-a1m5y4t3-pooler.ap-southeast-1.aws.neon.tech:5432/neondb?sslmode=require";

            String user = "neondb_owner";
            String pass = "npg_ysd7QUjuecA3";

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

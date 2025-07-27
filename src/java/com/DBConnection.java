/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author DELL
 */
public class DBConnection {

    Connection con = null;

    public Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;databaseName=testingMsSql;encrypt=true;trustServerCertificate=true;";
            String username = "sa";
            String password = "123456";
            con = DriverManager.getConnection(url, username, password);
            System.out.println("Connection String : >>>>>>" + con);
        } catch (Exception ex) {
            System.out.println("Exception While Connection : " + ex.getMessage());

        }
        return con;
    }

}

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
public class MySqlConnection {
    Connection con = null;

    public Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("1");
            String url = "jdbc:mysql://localhost:3306/hms";
            System.out.println("1");
            String username = "root";
            System.out.println("1");
            String password = "root";
            System.out.println("1");
            con = DriverManager.getConnection(url, username, password);
            System.out.println("1");
            System.out.println("Connection String : >>>>>>" + con);
        } catch (Exception ex) {
            System.out.println("Exception While Connection : " + ex.getMessage());
        }
        return con;
    }
}

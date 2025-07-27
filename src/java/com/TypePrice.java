/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author TEJAS
 */
public class TypePrice {

    private String txtUserId, txtTypePrice, txtRoomType;

    public String getTxtUserId() {
        return txtUserId;
    }

    public void setTxtUserId(String txtUserId) {
        this.txtUserId = txtUserId;
    }

    public String getTxtTypePrice() {
        return txtTypePrice;
    }

    public void setTxtTypePrice(String txtTypePrice) {
        this.txtTypePrice = txtTypePrice;
    }

    public String getTxtRoomType() {
        return txtRoomType;
    }

    public void setTxtRoomType(String txtRoomType) {
        this.txtRoomType = txtRoomType;
    }

    public String isBlankNull(String s) {
        return (s == null || s.trim().isEmpty()) ? "" : s;
    }

    public Exception TypePrice() throws SQLException {
        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        MySqlConnection dbc;
        try {
            dbc = new MySqlConnection();
            con = dbc.getConnection();
            pstmt = con.prepareStatement("Insert into roomsTypesDetails(type,type_price,created_on,created_by) values (?,?,now(),?)");
            pstmt.setString(1, txtRoomType);
            pstmt.setString(2, txtTypePrice);
            pstmt.setString(3, txtUserId);
            pstmt.executeUpdate();
            pstmt.close();

        } catch (Exception e) {
            e.printStackTrace();
            e = ex;
        } finally {
            con.close();
        }
        return ex;
    }

}

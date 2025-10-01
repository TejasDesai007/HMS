package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

            // 🔹 Start transaction
            con.setAutoCommit(false);

            // 🔹 Lock the type row (if exists) to prevent duplicate insert
            pstmt = con.prepareStatement("SELECT * FROM roomsTypesDetails WHERE type = ? FOR UPDATE");
            pstmt.setString(1, txtRoomType);
            rst = pstmt.executeQuery();

            if (rst.next()) {
                throw new SQLException("Room type '" + txtRoomType + "' already exists.");
            }
            rst.close();
            pstmt.close();

            // Insert new room type
            pstmt = con.prepareStatement(
                "INSERT INTO roomsTypesDetails(type, type_price, created_on, created_by) VALUES (?, ?, NOW(), ?)"
            );
            pstmt.setString(1, txtRoomType);
            pstmt.setString(2, txtTypePrice);
            pstmt.setString(3, txtUserId);
            pstmt.executeUpdate();
            pstmt.close();

            // 🔹 Commit transaction
            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex2) { ex2.printStackTrace(); }
            }
            System.out.println("Error in TypePrice.java");
            e.printStackTrace();
            ex = e;
        } finally {
            if (rst != null) rst.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }

        return ex;
    }
}

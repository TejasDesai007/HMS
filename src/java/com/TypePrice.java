package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TypePrice {

    private String txtUserId, txtTypePrice, txtRoomType;

    // getters & setters
    public String getTxtUserId() { return txtUserId; }
    public void setTxtUserId(String txtUserId) { this.txtUserId = txtUserId; }

    public String getTxtTypePrice() { return txtTypePrice; }
    public void setTxtTypePrice(String txtTypePrice) { this.txtTypePrice = txtTypePrice; }

    public String getTxtRoomType() { return txtRoomType; }
    public void setTxtRoomType(String txtRoomType) { this.txtRoomType = txtRoomType; }

    public String isBlankNull(String s) {
        return (s == null || s.trim().isEmpty()) ? "" : s;
    }

    // ❗ Renamed method (not constructor)
    public Exception saveTypePrice() throws SQLException {

        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;

        try {
            PostgreSqlConnection dbc = new PostgreSqlConnection();
            con = dbc.getConnection();

            con.setAutoCommit(false);

            // 🔒 Lock row to prevent duplicates
            pstmt = con.prepareStatement(
                "SELECT 1 FROM room_types_details WHERE type = ? FOR UPDATE"
            );
            pstmt.setString(1, txtRoomType);
            rst = pstmt.executeQuery();

            if (rst.next()) {
                throw new SQLException("Room type '" + txtRoomType + "' already exists.");
            }

            rst.close();
            pstmt.close();

            // ✅ PostgreSQL insert
            pstmt = con.prepareStatement(
                "INSERT INTO room_types_details " +
                "(type, type_price, created_on, created_by) " +
                "VALUES (?, ?, CURRENT_TIMESTAMP, ?)"
            );

            pstmt.setString(1, txtRoomType);
            pstmt.setBigDecimal(2, new java.math.BigDecimal(txtTypePrice));
            pstmt.setString(3, txtUserId);

            pstmt.executeUpdate();

            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ignored) {}
            }
            System.out.println("❌ Error in TypePrice.java");
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

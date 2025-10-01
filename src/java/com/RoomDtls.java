package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoomDtls {

    private String txtUserId, txtRoomdscrpt, txtRoomPrice, slcRoomType, txtRoomNo, txtRoomId;

    
    public String getTxtUserId() {
        return txtUserId;
    }

    public void setTxtUserId(String txtUserId) {
        this.txtUserId = txtUserId;
    }

    public String getTxtRoomdscrpt() {
        return txtRoomdscrpt;
    }

    public void setTxtRoomdscrpt(String txtRoomdscrpt) {
        this.txtRoomdscrpt = txtRoomdscrpt;
    }

    public String getTxtRoomPrice() {
        return txtRoomPrice;
    }

    public void setTxtRoomPrice(String txtRoomPrice) {
        this.txtRoomPrice = txtRoomPrice;
    }

    public String getSlcRoomType() {
        return slcRoomType;
    }

    public void setSlcRoomType(String slcRoomType) {
        this.slcRoomType = slcRoomType;
    }

    public String getTxtRoomNo() {
        return txtRoomNo;
    }

    public void setTxtRoomNo(String txtRoomNo) {
        this.txtRoomNo = txtRoomNo;
    }

    public String getTxtRoomId() {
        return txtRoomId;
    }

    public void setTxtRoomId(String txtRoomId) {
        this.txtRoomId = txtRoomId;
    }


    public String isBlankNull(String s) {
        return (s == null || s.trim().isEmpty()) ? "" : s;
    }

    public Exception RoomDtls() throws SQLException {
        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        MySqlConnection dbc;
        String roomtype = "";

        try {
            dbc = new MySqlConnection();
            con = dbc.getConnection();

            // 🔹 Start transaction
            con.setAutoCommit(false);

            // Get room type name
            pstmt = con.prepareStatement(
                "SELECT type FROM roomstypesdetails WHERE type_id = ?", 
                ResultSet.TYPE_SCROLL_INSENSITIVE, 
                ResultSet.CONCUR_READ_ONLY
            );
            pstmt.setString(1, slcRoomType);
            rst = pstmt.executeQuery();
            if (rst.next()) {
                roomtype = rst.getString("type");
            }
            rst.close();
            pstmt.close();

            if (txtRoomId == null || txtRoomId.trim().isEmpty()) {
                // Insert new room
                pstmt = con.prepareStatement(
                    "INSERT INTO rooms(room_no, status, room_type, price_per_day, room_dscrpt, created_on, created_by, type_id) " +
                    "VALUES (?,'Unoccupied',?,?,?,NOW(),?,?)"
                );
                pstmt.setString(1, txtRoomNo);
                pstmt.setString(2, roomtype);
                pstmt.setString(3, txtRoomPrice);
                pstmt.setString(4, txtRoomdscrpt);
                pstmt.setString(5, txtUserId);
                pstmt.setString(6, slcRoomType);
                pstmt.executeUpdate();
                pstmt.close();
            } else {
                // 🔹 Lock the room row for update
                pstmt = con.prepareStatement("SELECT * FROM rooms WHERE roomid = ? FOR UPDATE");
                pstmt.setString(1, txtRoomId);
                rst = pstmt.executeQuery();
                if (!rst.next()) {
                    throw new SQLException("Room not found for roomid: " + txtRoomId);
                }
                rst.close();
                pstmt.close();

                // Update existing room
                pstmt = con.prepareStatement(
                    "UPDATE rooms SET room_no = ?, room_type = ?, price_per_day = ?, room_dscrpt = ?, updated_on = NOW(), updated_by = ?, type_id = ? " +
                    "WHERE roomid = ?"
                );
                pstmt.setString(1, txtRoomNo);
                pstmt.setString(2, roomtype);
                pstmt.setString(3, txtRoomPrice);
                pstmt.setString(4, txtRoomdscrpt);
                pstmt.setString(5, txtUserId);
                pstmt.setString(6, slcRoomType);
                pstmt.setString(7, txtRoomId);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // 🔹 Commit transaction
            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex2) { ex2.printStackTrace(); }
            }
            System.out.println("Error in RoomDtls.java");
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

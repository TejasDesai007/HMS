package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Bookings {

    private String txtBookingid, txtUserId, txtTotalAmt, txtBeverage, txtTax, txtTaxPrc, txtStayDays, txtRoomPrice, slcRooms, slcGuest;

    // --- Getters & Setters (same as before) ---
    public String getTxtBookingid() {
        return txtBookingid;
    }

    public void setTxtBookingid(String txtBookingid) {
        this.txtBookingid = txtBookingid;
    }

    public String getTxtUserId() {
        return txtUserId;
    }

    public void setTxtUserId(String txtUserId) {
        this.txtUserId = txtUserId;
    }

    public String getTxtTotalAmt() {
        return txtTotalAmt;
    }

    public void setTxtTotalAmt(String txtTotalAmt) {
        this.txtTotalAmt = txtTotalAmt;
    }

    public String getTxtBeverage() {
        return txtBeverage;
    }

    public void setTxtBeverage(String txtBeverage) {
        this.txtBeverage = txtBeverage;
    }

    public String getTxtTax() {
        return txtTax;
    }

    public void setTxtTax(String txtTax) {
        this.txtTax = txtTax;
    }

    public String getTxtTaxPrc() {
        return txtTaxPrc;
    }

    public void setTxtTaxPrc(String txtTaxPrc) {
        this.txtTaxPrc = txtTaxPrc;
    }

    public String getTxtStayDays() {
        return txtStayDays;
    }

    public void setTxtStayDays(String txtStayDays) {
        this.txtStayDays = txtStayDays;
    }

    public String getTxtRoomPrice() {
        return txtRoomPrice;
    }

    public void setTxtRoomPrice(String txtRoomPrice) {
        this.txtRoomPrice = txtRoomPrice;
    }

    public String getSlcRooms() {
        return slcRooms;
    }

    public void setSlcRooms(String slcRooms) {
        this.slcRooms = slcRooms;
    }

    public String getSlcGuest() {
        return slcGuest;
    }

    public void setSlcGuest(String slcGuest) {
        this.slcGuest = slcGuest;
    }

    public String isBlankNull(String s) {
        return (s == null || s.trim().isEmpty()) ? "" : s;
    }

    public Exception Bookings() throws SQLException {
        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        MySqlConnection dbc;

        try {
            dbc = new MySqlConnection();
            con = dbc.getConnection();

            // 🔹 start transaction
            con.setAutoCommit(false);

            if (txtBookingid == null || txtBookingid.trim().isEmpty()) {

                // 🔹 Lock the room row (pessimistic lock)
                pstmt = con.prepareStatement("SELECT status FROM rooms WHERE roomid = ? FOR UPDATE");
                pstmt.setString(1, slcRooms);
                rst = pstmt.executeQuery();

                if (rst.next()) {
                    String status = rst.getString("status");
                    if ("Occupied".equalsIgnoreCase(status)) {
                        throw new SQLException("Room already occupied! Please select another room.");
                    }
                }
                rst.close();
                pstmt.close();

                // 🔹 Insert booking
                pstmt = con.prepareStatement(
                        "INSERT INTO Bookings(guestid, roomid, room_price, taxes, beverages, check_in, booked_days, booked_by) "
                        + "VALUES (?,?,?,?,?,NOW(),?,?)");
                pstmt.setString(1, slcGuest);
                pstmt.setString(2, slcRooms);
                pstmt.setString(3, txtRoomPrice);
                pstmt.setString(4, txtTax);
                pstmt.setString(5, txtBeverage);
                pstmt.setString(6, txtStayDays);
                pstmt.setString(7, txtUserId);
                pstmt.executeUpdate();
                pstmt.close();

                // 🔹 Update room status
                pstmt = con.prepareStatement("UPDATE rooms SET status = 'Occupied' WHERE roomid=?");
                pstmt.setString(1, slcRooms);
                pstmt.executeUpdate();
                pstmt.close();

            } else {
                // 🔹 Update existing booking (no need to lock room)
                pstmt = con.prepareStatement(
                        "UPDATE Bookings SET room_price = ?, taxes = ?, beverages = ?, booked_days = ? WHERE bookingid = ?");
                pstmt.setString(1, txtRoomPrice);
                pstmt.setString(2, txtTax);
                pstmt.setString(3, txtBeverage);
                pstmt.setString(4, txtStayDays);
                pstmt.setString(5, txtBookingid);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // 🔹 commit transaction
            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback(); // rollback on error
                } catch (SQLException ex2) {
                    ex2.printStackTrace();
                }
            }
            System.out.println("Error in Bookings.java");
            e.printStackTrace();
            ex = e;
        } finally {
            if (rst != null) {
                rst.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return ex;
    }
}

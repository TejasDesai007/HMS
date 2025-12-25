package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Bookings {

    private String txtBookingid, txtUserId, txtTotalAmt, txtBeverage, txtTax,
            txtTaxPrc, txtStayDays, txtRoomPrice, slcRooms, slcGuest;

    // ---------- Getters & Setters (UNCHANGED) ----------
    public String getTxtBookingid() { return txtBookingid; }
    public void setTxtBookingid(String txtBookingid) { this.txtBookingid = txtBookingid; }

    public String getTxtUserId() { return txtUserId; }
    public void setTxtUserId(String txtUserId) { this.txtUserId = txtUserId; }

    public String getTxtTotalAmt() { return txtTotalAmt; }
    public void setTxtTotalAmt(String txtTotalAmt) { this.txtTotalAmt = txtTotalAmt; }

    public String getTxtBeverage() { return txtBeverage; }
    public void setTxtBeverage(String txtBeverage) { this.txtBeverage = txtBeverage; }

    public String getTxtTax() { return txtTax; }
    public void setTxtTax(String txtTax) { this.txtTax = txtTax; }

    public String getTxtTaxPrc() { return txtTaxPrc; }
    public void setTxtTaxPrc(String txtTaxPrc) { this.txtTaxPrc = txtTaxPrc; }

    public String getTxtStayDays() { return txtStayDays; }
    public void setTxtStayDays(String txtStayDays) { this.txtStayDays = txtStayDays; }

    public String getTxtRoomPrice() { return txtRoomPrice; }
    public void setTxtRoomPrice(String txtRoomPrice) { this.txtRoomPrice = txtRoomPrice; }

    public String getSlcRooms() { return slcRooms; }
    public void setSlcRooms(String slcRooms) { this.slcRooms = slcRooms; }

    public String getSlcGuest() { return slcGuest; }
    public void setSlcGuest(String slcGuest) { this.slcGuest = slcGuest; }

    // --------------------------------------------------

    public Exception Bookings() throws SQLException {

        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        PostgreSqlConnection dbc;

        try {
            dbc = new PostgreSqlConnection();
            con = dbc.getConnection();

            // 🔹 Start transaction
            con.setAutoCommit(false);

            if (txtBookingid == null || txtBookingid.trim().isEmpty()) {

                // 🔹 Pessimistic lock (PostgreSQL supports FOR UPDATE)
                pstmt = con.prepareStatement(
                        "SELECT status FROM rooms WHERE roomid = ? FOR UPDATE");
                pstmt.setInt(1, Integer.parseInt(slcRooms));
                rst = pstmt.executeQuery();

                if (rst.next()) {
                    String status = rst.getString("status");
                    if ("Occupied".equalsIgnoreCase(status)) {
                        throw new SQLException("Room already occupied! Please select another room.");
                    }
                }
                rst.close();
                pstmt.close();

                // 🔹 INSERT booking (NOW() → CURRENT_TIMESTAMP)
                pstmt = con.prepareStatement(
                        "INSERT INTO bookings (guestid, roomid, room_price, taxes, beverages, check_in, booked_days, booked_by) "
                      + "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)");

                pstmt.setInt(1, Integer.parseInt(slcGuest));
                pstmt.setInt(2, Integer.parseInt(slcRooms));
                pstmt.setBigDecimal(3, new java.math.BigDecimal(txtRoomPrice));
                pstmt.setBigDecimal(4, new java.math.BigDecimal(txtTax));
                pstmt.setBigDecimal(5, new java.math.BigDecimal(txtBeverage));
                pstmt.setInt(6, Integer.parseInt(txtStayDays));
                pstmt.setInt(7, Integer.parseInt(txtUserId));

                pstmt.executeUpdate();
                pstmt.close();

                // 🔹 Update room status
                pstmt = con.prepareStatement(
                        "UPDATE rooms SET status = 'Occupied' WHERE roomid = ?");
                pstmt.setInt(1, Integer.parseInt(slcRooms));
                pstmt.executeUpdate();
                pstmt.close();

            } else {

                // 🔹 Update existing booking
                pstmt = con.prepareStatement(
                        "UPDATE bookings SET room_price = ?, taxes = ?, beverages = ?, booked_days = ? WHERE bookingid = ?");

                pstmt.setBigDecimal(1, new java.math.BigDecimal(txtRoomPrice));
                pstmt.setBigDecimal(2, new java.math.BigDecimal(txtTax));
                pstmt.setBigDecimal(3, new java.math.BigDecimal(txtBeverage));
                pstmt.setInt(4, Integer.parseInt(txtStayDays));
                pstmt.setInt(5, Integer.parseInt(txtBookingid));

                pstmt.executeUpdate();
                pstmt.close();
            }

            // 🔹 Commit transaction
            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex2) {
                    ex2.printStackTrace();
                }
            }
            System.out.println("Error in Bookings.java");
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

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
public class Bookings {

    private String txtBookingid, txtUserId, txtTotalAmt, txtBeverage, txtTax, txtTaxPrc, txtStayDays, txtRoomPrice, slcRooms, slcGuest;

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
        String roomtype = "";
        try {
            dbc = new MySqlConnection();
            con = dbc.getConnection();

            if (txtBookingid == null || txtBookingid.trim().isEmpty()) {
                pstmt = con.prepareStatement("Insert into Bookings(guestid, roomid, room_price, taxes, beverages, check_in, booked_days, booked_by) values (?,?,?,?,?,now(),?,?)");
                pstmt.setString(1, slcGuest);
                pstmt.setString(2, slcRooms);
                pstmt.setString(3, txtRoomPrice);
                pstmt.setString(4, txtTax);
                pstmt.setString(5, txtBeverage);
                pstmt.setString(6, txtStayDays);
                pstmt.setString(7, txtUserId);
                pstmt.executeUpdate();
                pstmt.close();

                pstmt = con.prepareStatement("update rooms set status = 'Occupied' where roomid=?");
                pstmt.setString(1, slcRooms);
                pstmt.executeUpdate();
                pstmt.close();
            } else {
                pstmt = con.prepareStatement("Update Bookings set room_price = ?, taxes = ?, beverages = ?, booked_days = ? where bookingid = ?");
                pstmt.setString(1, txtRoomPrice);
                pstmt.setString(2, txtTax);
                pstmt.setString(3, txtBeverage);
                pstmt.setString(4, txtStayDays);
                pstmt.setString(5, txtBookingid); // Ensure that the correct room_id is set
                pstmt.executeUpdate();
                System.out.println("Update Bookings set room_price = '" + txtRoomPrice
                        + "', taxes = '" + txtTax
                        + "', beverages = '" + txtBeverage
                        + "', booked_days = '" + txtStayDays
                        + "' where bookingid = '" + txtBookingid + "';");
                pstmt.close();
            }

        } catch (Exception e) {
            System.out.println("Error in Bookings.java");
            e.printStackTrace();
            e = ex;
        } finally {
            con.close();
        }
        return ex;
    }
}

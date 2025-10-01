package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Guest {

    private String txtUserId, txtUIDNo, txtPhone, ddlUIDType, txtPincode, txtCountry, txtState, txtCity, txtAddress2, txtAddress1, txtFName, txtLName, txtGuestId;

    
    public String getTxtUserId() {
        return txtUserId;
    }

    public void setTxtUserId(String txtUserId) {
        this.txtUserId = txtUserId;
    }

    public String getTxtUIDNo() {
        return txtUIDNo;
    }

    public void setTxtUIDNo(String txtUIDNo) {
        this.txtUIDNo = txtUIDNo;
    }

    public String getTxtPhone() {
        return txtPhone;
    }

    public void setTxtPhone(String txtPhone) {
        this.txtPhone = txtPhone;
    }

    public String getDdlUIDType() {
        return ddlUIDType;
    }

    public void setDdlUIDType(String ddlUIDType) {
        this.ddlUIDType = ddlUIDType;
    }

    public String getTxtPincode() {
        return txtPincode;
    }

    public void setTxtPincode(String txtPincode) {
        this.txtPincode = txtPincode;
    }

    public String getTxtCountry() {
        return txtCountry;
    }

    public void setTxtCountry(String txtCountry) {
        this.txtCountry = txtCountry;
    }

    public String getTxtState() {
        return txtState;
    }

    public void setTxtState(String txtState) {
        this.txtState = txtState;
    }

    public String getTxtCity() {
        return txtCity;
    }

    public void setTxtCity(String txtCity) {
        this.txtCity = txtCity;
    }

    public String getTxtAddress2() {
        return txtAddress2;
    }

    public void setTxtAddress2(String txtAddress2) {
        this.txtAddress2 = txtAddress2;
    }

    public String getTxtAddress1() {
        return txtAddress1;
    }

    public void setTxtAddress1(String txtAddress1) {
        this.txtAddress1 = txtAddress1;
    }

    public String getTxtFName() {
        return txtFName;
    }

    public void setTxtFName(String txtFName) {
        this.txtFName = txtFName;
    }

    public String getTxtLName() {
        return txtLName;
    }

    public void setTxtLName(String txtLName) {
        this.txtLName = txtLName;
    }

    public String getTxtGuestId() {
        return txtGuestId;
    }

    public void setTxtGuestId(String txtGuestId) {
        this.txtGuestId = txtGuestId;
    }

    public Exception Guest() throws SQLException {
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

            if (txtGuestId == null || txtGuestId.trim().isEmpty()) {
                // Insert new guest
                pstmt = con.prepareStatement(
                    "INSERT INTO guests(lname, fname, address1, address2, city, state, country, pincode, UID_type, UID_NO, phone, created_on, created_by) " +
                    "VALUES (?,?,?,?,?,?,?,?,?,?,?,NOW(),?)"
                );
                pstmt.setString(1, txtLName);
                pstmt.setString(2, txtFName);
                pstmt.setString(3, txtAddress1);
                pstmt.setString(4, txtAddress2);
                pstmt.setString(5, txtCity);
                pstmt.setString(6, txtState);
                pstmt.setString(7, txtCountry);
                pstmt.setString(8, txtPincode);
                pstmt.setString(9, ddlUIDType);
                pstmt.setString(10, txtUIDNo);
                pstmt.setString(11, txtPhone);
                pstmt.setString(12, txtUserId);
                pstmt.executeUpdate();
                pstmt.close();
            } else {
                // 🔹 Lock the guest row for update to prevent concurrent modification
                pstmt = con.prepareStatement("SELECT * FROM guests WHERE guestid = ? FOR UPDATE");
                pstmt.setString(1, txtGuestId);
                rst = pstmt.executeQuery();
                if (!rst.next()) {
                    throw new SQLException("Guest not found for guestid: " + txtGuestId);
                }
                rst.close();
                pstmt.close();

                // Update existing guest
                pstmt = con.prepareStatement(
                    "UPDATE guests SET lname = ?, fname = ?, address1 = ?, address2 = ?, city = ?, state = ?, country = ?, pincode = ?, UID_type = ?, UID_NO = ?, phone = ?, update_on = NOW(), updated_by = ? " +
                    "WHERE guestid = ?"
                );
                pstmt.setString(1, txtLName);
                pstmt.setString(2, txtFName);
                pstmt.setString(3, txtAddress1);
                pstmt.setString(4, txtAddress2);
                pstmt.setString(5, txtCity);
                pstmt.setString(6, txtState);
                pstmt.setString(7, txtCountry);
                pstmt.setString(8, txtPincode);
                pstmt.setString(9, ddlUIDType);
                pstmt.setString(10, txtUIDNo);
                pstmt.setString(11, txtPhone);
                pstmt.setString(12, txtUserId);
                pstmt.setString(13, txtGuestId);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // 🔹 Commit transaction
            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex2) { ex2.printStackTrace(); }
            }
            System.out.println("Error in Guest.java");
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

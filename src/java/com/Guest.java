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
        String roomtype = "";
        try {
            dbc = new MySqlConnection();
            con = dbc.getConnection();

            if (txtGuestId == null || txtGuestId.trim().isEmpty()) {
                pstmt = con.prepareStatement("Insert into guests(lname, fname, address1, address2, city, state, country, pincode, UID_type, UID_NO, phone, created_on, created_by) values (?,?,?,?,?,?,?,?,?,?,?,now(),?)");
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
                System.err.println("asfasdf");
                pstmt = con.prepareStatement("Update guests set lname = ?, fname = ?, address1 = ?, address2 = ?, city = ?, state=? , country=?, pincode=?, UID_type=?,UID_NO=?, phone=?,update_on = now(), updated_by = ? where guestid = ?");
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
                System.out.println("Update guests set lname = '" + txtLName + 
                   "', fname = '" + txtFName + 
                   "', address1 = '" + txtAddress1 + 
                   "', address2 = '" + txtAddress2 + 
                   "', city = '" + txtCity + 
                   "', state = '" + txtState + 
                   "', country = '" + txtCountry + 
                   "', pincode = '" + txtPincode + 
                   "', UID_type = '" + ddlUIDType + 
                   "', UID_NO = '" + txtUIDNo + 
                   "', phone = '" + txtPhone + 
                   "', update_on = now(), updated_by = '" + txtUserId + 
                   "' where guestid = '" + txtGuestId + "';");

                pstmt.close();
            }

        } catch (Exception e) {
            System.out.println("Error in Guest.java");
            e.printStackTrace();
            e = ex;
        } finally {
            con.close();
        }
        return ex;
    }

}

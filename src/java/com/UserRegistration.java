package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRegistration {

    private String txtFName, txtLName, txtEmail, txtPhone,
            txtEmpNo, selUserType, txtUserNm,
            txtPassword, txtCnfPassword;

    // ---------- Getters & Setters (UNCHANGED) ----------
    public String getTxtFName() { return txtFName; }
    public void setTxtFName(String txtFName) { this.txtFName = txtFName; }

    public String getTxtLName() { return txtLName; }
    public void setTxtLName(String txtLName) { this.txtLName = txtLName; }

    public String getTxtEmail() { return txtEmail; }
    public void setTxtEmail(String txtEmail) { this.txtEmail = txtEmail; }

    public String getTxtPhone() { return txtPhone; }
    public void setTxtPhone(String txtPhone) { this.txtPhone = txtPhone; }

    public String getTxtEmpNo() { return txtEmpNo; }
    public void setTxtEmpNo(String txtEmpNo) { this.txtEmpNo = txtEmpNo; }

    public String getSelUserType() { return selUserType; }
    public void setSelUserType(String selUserType) { this.selUserType = selUserType; }

    public String getTxtUserNm() { return txtUserNm; }
    public void setTxtUserNm(String txtUserNm) { this.txtUserNm = txtUserNm; }

    public String getTxtPassword() { return txtPassword; }
    public void setTxtPassword(String txtPassword) { this.txtPassword = txtPassword; }

    public String getTxtCnfPassword() { return txtCnfPassword; }
    public void setTxtCnfPassword(String txtCnfPassword) { this.txtCnfPassword = txtCnfPassword; }
    // --------------------------------------------------

    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }

    public Exception UserRegistration() throws SQLException {

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

            // 🔹 Lock username/email row to prevent duplicates
            pstmt = con.prepareStatement(
                "SELECT userid FROM userdetails WHERE username = ? OR email = ? FOR UPDATE"
            );
            pstmt.setString(1, txtUserNm);
            pstmt.setString(2, txtEmail);
            rst = pstmt.executeQuery();

            if (rst.next()) {
                throw new SQLException("Username or Email already exists.");
            }

            rst.close();
            pstmt.close();

            // 🔹 Insert new user (NOW() → CURRENT_TIMESTAMP)
            pstmt = con.prepareStatement(
                "INSERT INTO userdetails (username, fname, lname, email, password, usertype, createdon, employeeno, phone) " +
                "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)"
            );

            pstmt.setString(1, txtUserNm);
            pstmt.setString(2, txtFName);
            pstmt.setString(3, txtLName);
            pstmt.setString(4, txtEmail);
            pstmt.setString(5, txtPassword);
            pstmt.setString(6, selUserType);
            pstmt.setString(7, txtEmpNo);
            pstmt.setString(8, txtPhone);

            pstmt.executeUpdate();
            pstmt.close();

            // 🔹 Commit
            con.commit();

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex2) { ex2.printStackTrace(); }
            }
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

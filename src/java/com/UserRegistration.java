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
 * @author DELL
 */
public class UserRegistration {

    private String txtFName,txtLName,txtEmail,txtPhone,txtEmpNo,selUserType,txtUserNm,txtPassword,txtCnfPassword;

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

    public String getTxtEmail() {
        return txtEmail;
    }

    public void setTxtEmail(String txtEmail) {
        this.txtEmail = txtEmail;
    }

    public String getTxtPhone() {
        return txtPhone;
    }

    public void setTxtPhone(String txtPhone) {
        this.txtPhone = txtPhone;
    }

    public String getTxtEmpNo() {
        return txtEmpNo;
    }

    public void setTxtEmpNo(String txtEmpNo) {
        this.txtEmpNo = txtEmpNo;
    }

    public String getSelUserType() {
        return selUserType;
    }

    public void setSelUserType(String selUserType) {
        this.selUserType = selUserType;
    }

    public String getTxtUserNm() {
        return txtUserNm;
    }

    public void setTxtUserNm(String txtUserNm) {
        this.txtUserNm = txtUserNm;
    }

    public String getTxtPassword() {
        return txtPassword;
    }

    public void setTxtPassword(String txtPassword) {
        this.txtPassword = txtPassword;
    }

    public String getTxtCnfPassword() {
        return txtCnfPassword;
    }

    public void setTxtCnfPassword(String txtCnfPassword) {
        this.txtCnfPassword = txtCnfPassword;
    }

    

    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }

    public Exception UserRegistration() throws SQLException {
        Exception ex = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        MySqlConnection dbc;
        try {
            dbc = new MySqlConnection();
            con = dbc.getConnection();
            pstmt = con.prepareStatement("insert into userdetails(UserName, fName, lName, Email, Password, UserType, CreatedOn, EmployeeNo, Phone) values(?,?,?,?,?,?,now(),?,?)");
            System.out.println("insert into userdetails(UserName, fName, lName, Email, Password, UserType, CreatedOn, EmployeeNo, Phone) values('"+ txtUserNm +"','"+ txtFName +"','"+ txtLName +"','"+ txtEmail +"','"+ txtPassword +"','"+ selUserType +"',now(),'"+ txtEmpNo +"','"+ txtPhone +"')");
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

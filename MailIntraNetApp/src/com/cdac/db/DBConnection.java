package com.cdac.db;

import java.sql.*;

public class DBConnection {

    private static Connection con = null;

    public static Connection config() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mail", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
        	
        }

        return con;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cdac.controller;

import com.cdac.db.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tej
 */
public class Login extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	
    	System.out.println("Servlet Execution Started...");
    	PreparedStatement ps = null;
        ResultSet rs = null;
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        
        String uname = request.getParameter("mail");
        String pass = request.getParameter("passwd");
        System.out.println(uname + " " + pass);
        HttpSession session = null;
        
        try {
            Connection con = DBConnection.config();
            ps = con.prepareStatement("select * from users where mail=? AND passwd=?");
            ps.setString(1, uname);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            if (rs.next()) {
            	System.out.println("Success");
                session = request.getSession();
                request.setAttribute("success", true);
                request.setAttribute("statusCode", 200);
                session.setAttribute("Username", uname);
                session.setAttribute("name", rs.getString("name"));
                response.setStatus(HttpServletResponse.SC_OK);
                request.getRequestDispatcher("Inbox.jsp").forward(request, response);
            } else {
            	System.out.println("Failure");
                request.setAttribute("success", false);
                request.setAttribute("statusCode", 401);
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.println("<script>$('#err').html('Invalid Email or Password');$('#err').show();</script>");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
        	System.out.println("Exception " + e.getClass().getSimpleName() + " " + e.getMessage());
        	request.setAttribute("statusCode", 500);
        	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("<script>$('#err').html('Internal Server Error Occurred');$('#err').show();</script>");
            e.printStackTrace();
        }finally {
        	out.flush();
        	out.close();
        }
    }
}
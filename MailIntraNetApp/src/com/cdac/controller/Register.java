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
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tej
 */
@SuppressWarnings({ "serial", "unused" })
public class Register extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        String mail = request.getParameter("mail");
        String contact = request.getParameter("contact");
        String pass = request.getParameter("passwd");
        String cpass = request.getParameter("cpasswd");

        //DEBUG
        //out.println("Register User");
        //out.println(name + " " + mail + " " + contact  + " " + pass + " " + cpass  + " " + pass.equals(cpass));
        if (pass.equals(cpass)) {
            try {
                Connection con = DBConnection.config();

                PreparedStatement stmt = con.prepareStatement("insert into users values(?,?,?,?)");

                stmt.setString(1, name);
                stmt.setString(2, mail);
                stmt.setString(3, pass);
                stmt.setInt(4, Integer.parseInt(contact));
                int i = stmt.executeUpdate();

                //DEBUG
                //out.println(" " + i);
                if (i > 0) {
                    out.println("<script>alert('Message : Account Created Successfully')</script>");
                    request.getRequestDispatcher("index.html").include(request, response);
                } else {
                    out.println("<script>alert('Account Could not be created...')</script>");
                    request.getRequestDispatcher("register.jsp").include(request, response);
                }
            } catch (Exception e) {//CODE NOT GIVING ERROR MESSAGE ON THE FRONTEND
                out.println("<script>alert('Error occured: \n Account not created')</script>");
                request.getRequestDispatcher("register.jsp").include(request, response);
            }
        } else {
            try {
                out.println("<script>alert('Message : Please ReEnter valid credentials And try Again')</script>");
                request.getRequestDispatcher("register.jsp").include(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

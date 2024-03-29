/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cdac.controller;

import com.cdac.db.DBConnection;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Tej
 */
public class Compose extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Enumeration<String> stringEnum = request.getParameterNames();
		System.out.println("Printing request attributes");
		while (stringEnum.hasMoreElements())
			System.out.println(stringEnum.nextElement());
		System.out.println("Done");

		String message = request.getParameter("user-message");
		String to = request.getParameter("inputEmail1");
		String subject = request.getParameter("subject");

		String completemessage = "\n" + to + "\n" + subject + "\n" + message;

		System.out.println(completemessage);

		HttpSession session = request.getSession(false);
		if (session == null) {
			System.out.println("Session does not exist");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return;
		}

		String uname = (String) session.getAttribute("Username");

		completemessage = uname + "\n" + to + "\n" + subject + "\n" + message;

		System.out.println(completemessage);

		PreparedStatement stmt = null, stmt1 = null, stmt2 = null;

		response.setContentType("text/html");

		try {
			Connection con = DBConnection.config();
			PreparedStatement st = con.prepareStatement("select name from users where mail=?");

			st.setString(1, to);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {// CHECK IF USER/receiver EXISTS
				Date mydate = new java.util.Date();
				java.sql.Date sqldate = new java.sql.Date(mydate.getTime());

				stmt = con.prepareStatement("insert into mail (sender,receiver,subject,message,date,labels)"
						+ " values(?,?,?,?,?,?)");

				stmt.setString(1, uname);
				stmt.setString(2, to);
				stmt.setString(3, subject);
				stmt.setString(4, message);
				stmt.setDate(5, sqldate);
				stmt.setString(6, ";");

				int i = stmt.executeUpdate();

				if (i > 0) {// IF MAIL HAS BEEN SENT
					System.out.println("Message Sent Successfully");
					session.setAttribute("success", true);
					request.getRequestDispatcher("Inbox.jsp").include(request, response);
				} else {// IF MAIL HAS NOT BEEN SENT
					System.out.println("Message not Sent Successfully");
					session.setAttribute("success", false);
				}
			} else {// IF THE USER/receiver DOES NOT EXISTS

				final String from = "NOREPLY@ADMIN.com";
				final String subject1 = "Message Failed Notification";
				String message1 = "The is the Autogenerated email. \n\n The Mail sent to " + to + " with Subject :"
						+ subject + " has been failed since the receiver email id doesnot exist\n\n" + message;

				Date mydate = new java.util.Date();
				java.sql.Date sqldate = new java.sql.Date(mydate.getTime());

				stmt = con.prepareStatement(
						"insert into wrong_mails (sender,receiver,subject,message,date,labels) values(?,?,?,?,?,?)");

				stmt1.setString(1, uname);// Sender's Mail
				stmt1.setString(2, to);// receiver' Mail that doesn't exist
				stmt1.setString(3, subject);// Sender's Subject
				stmt1.setString(4, message);// Sender's Message
				stmt1.setDate(5, sqldate);// TimeStamp
				stmt1.setString(6, ";");

				int i = stmt1.executeUpdate();

				// CHECK IF MAIL HAS BEEN SAVED AS ERROR MAIL
				if (i > 0) {// IF IT IS THEN

					stmt2 = con.prepareStatement(
							"insert into mail (sender,receiver,subject,message,date,labels) values(?,?,?,?,?,?)");

					stmt2.setString(1, from);// Admin's Mail
					stmt2.setString(2, uname);// Sender's Mail
					stmt2.setString(3, subject1);// Notifying Subject
					stmt2.setString(4, message1);// Notifying Message
					stmt2.setDate(5, sqldate);// TimeStamp
					stmt2.setString(6, ";");
					int j = stmt2.executeUpdate();

					// CHECK IF MAIL HAS ALSO BEEN SAVED AS NOTIFICATION FOR ERROR MAIL
					if (j > 0) {// IF IT IS THEN
						System.out.println("Message sent successfully");
						request.getRequestDispatcher("mail.jsp").include(request, response);
					} else {// IF NOT THEN
						stmt1 = con.prepareStatement(
								"DELETE FROM wrong_mails WHERE sender=? and receiver=? and subject=? and message=? and date=?");

						stmt1.setString(1, uname);// Sender's Mail
						stmt1.setString(2, to);// receiver' Mail that doesn't exist
						stmt1.setString(3, subject);// Sender's Subject
						stmt1.setString(4, message);// Sender's Message
						stmt1.setDate(5, sqldate);// TimeStamp

						int d = stmt1.executeUpdate();// DELETE MAIL FROM DB FOR ERROR MAIL AND NOTIFY USER FOR FAILED
														// SENDING

						// CODE REQUIRED HERE FOR LOGGING DETAILS IF ERROR MAIL IS NOT DELETED
						// HERE WE'RE ASSUMING THAT ERROR MESSAGE HAS BEEN DELETED
						System.out.println("message sending failed");
						request.getRequestDispatcher("mail.jsp").include(request, response);
					}

				} else {// IF IT IS NOT SAVED AS ERROR MAIL
					System.out.println("message sending failed");
					request.getRequestDispatcher("mail.jsp").include(request, response);
				}
			}
		} catch (Exception e) {
			System.out.println("Exception Occurred: " + e.getClass().getSimpleName() + " " + e.getMessage());
			e.printStackTrace();
		}
	}
}

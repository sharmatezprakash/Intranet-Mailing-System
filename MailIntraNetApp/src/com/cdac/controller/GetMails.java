package com.cdac.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cdac.db.DBConnection;
import com.cdac.beans.Mail;

public class GetMails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null) {
			System.out.println("Session does not exist");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			return;
		}

		boolean isSender = Boolean.parseBoolean(request.getParameter("isSender"));
		int start = Integer.parseInt(request.getParameter("start"));

		System.out.println(isSender + "  " + start);

		try {
			Connection con = DBConnection.config();
			PreparedStatement ps = null;

			if (isSender) {
				ps = con.prepareStatement("select * from mail where sender=?");
				isSender = true;
			} else {
				ps = con.prepareStatement("select * from mail where receiver=?");
			}

			ps.setString(1, (String) session.getAttribute("Username"));

//			System.out.println(session.getAttribute("Username"));

			ResultSet rs = ps.executeQuery();
			int i = 0;
			List<Mail> mails = new ArrayList<>();
			int size = 0;
			boolean canBeAdded = false;
			while (rs.next() && i++ < (start + 10)) {
				canBeAdded = true;
				if (i == 1) {
					rs.last(); // moves cursor to the last row
					size = rs.getRow(); // get row id
//				  System.out.println(size);
					rs.first();
				}

				if ((i - 1) < start) {// Send next 10 mails
					canBeAdded = false;
				}

				if (isSender) {// If we're fetching sent box mails
					if ((rs.getInt("status") == 0) | (rs.getInt("status") == 1)) { // Check if sender has deleted this
																					// one
						--size;
						continue;// Then don't show this mail to user
					}
					if (canBeAdded) {
						mails.add(getMail(rs));
					}
				} else {// if we're fetching inbox mails
					if ((rs.getInt("status") == 0) | (rs.getInt("status") == 2)) { // Check if receiver has deleted this
																					// one
						--size;
						continue;// Then don't show this mail to user
					}
					if (canBeAdded) {
						mails.add(getMail(rs));
					}
				}
			}

			response.setStatus(HttpServletResponse.SC_OK);
			session.setAttribute("mails", mails);
			session.setAttribute("start", start);
//			System.out.println(size);
			if (isSender) {
				session.setAttribute("sentboxSize", size);
				session.setAttribute("mailsFrom", "sentbox");
				request.getRequestDispatcher("/sentbox.jsp").forward(request, response);
			} else {
				session.setAttribute("inboxSize", size);
				session.setAttribute("mailsFrom", "inbox");
				request.getRequestDispatcher("/Inbox.jsp").forward(request, response);
			}

		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			System.out.println("Exception Occurred: " + e.getClass().getSimpleName() + " " + e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	Mail getMail(ResultSet rs) throws SQLException {
		Mail mail = new Mail();
		mail.setId(rs.getInt("id"));
		mail.setDate(rs.getDate("date"));
		mail.setSender(rs.getString("sender"));
		mail.setReceiver(rs.getString("receiver"));
		mail.setSubject(rs.getString("subject"));
		mail.setMessage(rs.getString("message"));
		mail.setStarred(rs.getBoolean("isStarred"));
		mail.setLabels(Arrays.asList(rs.getString("labels").split(";")));
		mail.setHasBeenRead(rs.getBoolean("hasBeenRead"));
//		mail.setAttachments((InputStream) rs.getBlob("attachments"));

//		System.out.println(mail.isStarred());
		return mail;
	}
}

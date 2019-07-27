package com.cdac.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cdac.db.DBConnection;

/**
 * Servlet implementation class DeleteMail
 */
@WebServlet("/DeleteMail")
public class DeleteMail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		final boolean isSender = Boolean.parseBoolean(request.getParameter("isSender"));
		final boolean deleteMultiple = Boolean.parseBoolean(request.getParameter("deleteMultiple"));
		final int[] mailId;
		
		StringBuilder sql = new StringBuilder(" WHERE id IN (");

		if (deleteMultiple) {
			String[] stringMailIds = request.getParameter("mailId").split(",");
			mailId = new int[stringMailIds.length];
			for (int i = 0; i < stringMailIds.length; i++) {
				mailId[i] = Integer.parseInt(stringMailIds[i]);
				sql.append("?,");
			}
			sql.delete(sql.length() - 1, sql.length());
			sql.append(")");
		} else {
			mailId = new int[1];
			mailId[0] = Integer.parseInt(request.getParameter("mailId").split(",")[0]);
			sql.append("?)");
		}

		try {
			Connection con = DBConnection.config();
			PreparedStatement ps1 = con.prepareStatement("select * from mail " + sql.toString());

			for (int i = 0; i < mailId.length; i++) {
				ps1.setInt(i + 1, mailId[i]);
			}

			ResultSet rs = ps1.executeQuery();
			if (rs.next()) {
				PreparedStatement ps = null;

				ps = con.prepareStatement("update mail SET status=? " + sql.toString());

				if (rs.getInt("status") == -1) {// If none of the users have deleted this mail
					if (isSender) {
						ps.setInt(1, 1);// Deletion by sender only
					} else {
						ps.setInt(1, 2);// Deletion by receiver only
					}
				} else {// if at least one of the users have deleted this
					ps.setInt(1, 0);// Deletion by both users
				}
				
				for (int i = 0; i < mailId.length; i++) {
					ps.setInt(i + 2, mailId[i]);
				}
				
				int i = ps.executeUpdate();

				if (i > 0) {
					System.out.println("Mail Deleted Successfully for " + (isSender ? "sender" : "receiver"));
				} else {
					System.out.println("Mail Could not be Deleted");
				}
				request.getRequestDispatcher("GetMails").include(request, response);
			}
		} catch (Exception e) {
			System.out.println("Exception Occurred: " + e.getClass().getSimpleName() + " " + e.getMessage());
			e.printStackTrace();
		}
	}

}

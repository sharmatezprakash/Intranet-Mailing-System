package com.cdac.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cdac.db.DBConnection;

@WebServlet("/MarkStarred")
public class MarkStarred extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final boolean isMarked = Boolean.parseBoolean(request.getParameter("isMarked"));
		final boolean isSender = Boolean.parseBoolean(request.getParameter("isSender"));
		final int id = Integer.parseInt(request.getParameter("id"));
		final int start = Integer.parseInt(request.getParameter("start"));
		
		try {
			Connection con = DBConnection.config();
			PreparedStatement ps = con.prepareStatement("Update mail set isStarred = ? where id = ?");
			
			ps.setBoolean(1, !isMarked);
			ps.setInt(2, id);
			int isSuccess = ps.executeUpdate();
			if(isSuccess > 0) {
				System.out.println("Successfully Marked or removed marked");
			}else {
				System.out.println("Failure in marking or removing starred");
			}
			if(isSender) {
				request.getRequestDispatcher("/GetMails").forward(request, response);
			}else{
				request.getRequestDispatcher("/GetMails").forward(request, response);
			}
			
		}catch(Exception e) {
			System.out.println("Exception Occurred: " + e.getClass().getSimpleName() + " " + e.getMessage());
			e.printStackTrace();
			if(isSender) {
				request.getRequestDispatcher("/GetMails").forward(request, response);
			}else{
				request.getRequestDispatcher("/GetMails").forward(request, response);
			}
			
		}
		
	}

}

package com.cdac.beans;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class Mail implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private int status;
	private String sender;
	private String receiver;
	private String subject;
	private String message;
	private Date date;
	private List<String> labels;
	private boolean hasBeenRead;
	private boolean isStarred;
	private InputStream attachments;
	
	public Mail(int id, int status, String sender, String receiver, String subject, String message, Date date,
			List<String> labels, boolean hasBeenRead, boolean isStarred, InputStream attachments) {
		this.id = id;
		this.status = status;
		this.sender = sender;
		this.receiver = receiver;
		this.subject = subject;
		this.message = message;
		this.date = date;
		this.labels = labels;
		this.hasBeenRead = hasBeenRead;
		this.isStarred = isStarred;
		this.attachments = attachments;
	}

	public Mail() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public List<String> getLabels() {
		return labels;
	}

	public void setLabels(List<String> labels) {
		this.labels = labels;
	}

	public boolean isStarred() {
		return isStarred;
	}

	public void setStarred(boolean isStarred) {
		this.isStarred = isStarred;
	}

	public boolean isHasBeenRead() {
		return hasBeenRead;
	}

	public void setHasBeenRead(boolean hasBeenRead) {
		this.hasBeenRead = hasBeenRead;
	}

	public InputStream getAttachments() {
		return attachments;
	}

	public void setAttachments(InputStream attachments) {
		this.attachments = attachments;
	}

	@Override
	public String toString() {
		return "Mail [id=" + id + ", status=" + status + ", sender=" + sender + ", receiver=" + receiver + ", subject="
				+ subject + ", message=" + message + ", date=" + date + ", labels=" + labels + ", hasBeenRead="
				+ hasBeenRead + ", isStarred=" + isStarred + ", attachments=" + attachments + "]";
	}

}

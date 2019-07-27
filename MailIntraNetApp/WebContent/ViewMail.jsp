<%@page import="com.cdac.beans.Mail"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><%=Boolean.parseBoolean(request.getParameter("isSender")) ? "Sentbox" : "Inbox"%></title>
<link href="css/bootstrap.min-3.3.0.css" rel="stylesheet"
	id="bootstrap-css">

<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min-3.3.0.js"></script>

<link rel="stylesheet" href="css/inbox.css">

<link rel='stylesheet prefetch' href='css/font-awesome.min-4.2.0.css'>

<%
	//out.println("mail.jsp");
	if (request.getSession(false).getAttribute("Username") == null) {
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request, response);
	}
%>



<%!Mail mail = null;
	int sentboxSize, inboxSize;
	String user = null, identify = null;
	boolean isSender = false;
	int index;%>
<%
	inboxSize = (int) ((session.getAttribute("inboxSize") != null) ? session.getAttribute("inboxSize") : -1);
	sentboxSize = (int) ((session.getAttribute("sentboxSize") != null)
			? session.getAttribute("sentboxSize")
			: -1);
	index = Integer.parseInt(request.getParameter("mailIndex"));

	Object obj = session.getAttribute("mails");

	if (obj instanceof List<?>) {
		List<?> al = (List<?>) obj;

		if (al.size() > 0) {
			Object o = al.get(index);
			if (o instanceof Mail) {
				mail = (Mail) o;
			} else {
				request.getRequestDispatcher("Inbox.jsp").forward(request, response);
			}
		} else {
			request.getRequestDispatcher("Inbox.jsp").forward(request, response);
		}
	}
	obj = null;
	if (Boolean.parseBoolean(request.getParameter("isSender"))) {
		identify = "To";
		user = mail.getReceiver();
	} else {
		identify = "From";
		user = mail.getSender();
	}
%>

<script src="js/jquery-3.3.1.js"></script>
<script src="js/viewMail.js"></script>
<script>
	var isSender;
	var mailId;
	$(document).ready(function() {
		$("#email-link").off('click');
		isSender = <%= Boolean.parseBoolean(request.getParameter("isSender")) %>;
		mailId = <%= mail.getId() %>;
	});
</script>

</head>
<body>
	<div class="container">

		<div class="mail-box">
			<aside class="sm-side">
				<div class="user-head">
					<a class="inbox-avatar" href="javascript:;"> <img width="64"
						height="60" src="img/UserImage.jpg">
					</a>
					<div class="user-name">
						<h5>
							<%
								out.println(session.getAttribute("name"));
							%>
						</h5>
						<span> <a href="" id="email-link"> <%
 	out.println(session.getAttribute("Username"));
 %>
						</a>
						</span>
					</div>
					<a class="mail-dropdown pull-right" href="javascript:;"> <i
						class="fa fa-chevron-down"> </i>
					</a>

					<div class="inbox-body">
						<a href="#myModal" data-toggle="modal" title="Compose"
							class="btn btn-compose"> Compose </a>
						<!-- Modal -->
						<div aria-hidden="true" aria-labelledby="myModalLabel"
							role="dialog" tabindex="-1" id="myModal" class="modal fade"
							style="display: none;">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button aria-hidden="true" data-dismiss="modal" class="close"
											type="button">×</button>
										<h4 class="modal-title">Compose</h4>
									</div>
									<div class="modal-body">
										<form role="form" action="Compose" method='POST'
											id="compose-form" class="form-horizontal">
											<!-- Add Compose Formalities here -->
											<div class="form-group">
												<label class="col-lg-2 control-label">To</label>
												<div class="col-lg-10">
													<!-- id="inputEmailId" -->
													<input type="text" placeholder="" name="inputEmail1"
														required class="form-control">
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-2 control-label">Subject</label>
												<div class="col-lg-10">
													<!--  id="subjectId" -->
													<input type="text" placeholder="" name="subject"
														class="form-control">
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-2 control-label">Message</label>
												<div class="col-lg-10">
													<!-- id="user-messageId"  -->
													<textarea rows="10" cols="30" class="form-control"
														name="user-message" name=""></textarea>
												</div>
											</div>

											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">

													<button class="btn btn-send" type="submit">Send</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->
					</div>
					<ul class="inbox-nav inbox-divider">
						<li <%= identify.equals("From") ? "class='active'" : "" %>><a href="Inbox.jsp"><i
								class="fa fa-inbox"></i> Inbox <span
								class="label label-danger pull-right"><%=(sentboxSize != -1) ? sentboxSize : ""%></span></a></li>
						<li <%= identify.equals("To") ? "class='active'" : "" %>><a href="sentbox.jsp"><i class="fa fa-envelope-o"></i>
								Sent Mail<span class="label label-danger pull-right"><%=(sentboxSize != -1) ? sentboxSize : ""%></span></a></li>

						
						<li><a href="logout.jsp"><i class=" fa fa-lock"></i>
								Logout</a></li>
					</ul>
				</div>
			</aside>
			<aside class="lg-side">
				<div id='inbox'>
					<div class="inbox-head">
						<h3 id='mail-title'><%=mail.getSubject()%></h3>
					</div>
					<div class="inbox-body">
						<div class="mail-option">
							<!-- Make this button for mark as unread -->
							<div class="btn-group hidden-phone"
								onclick='javascript:goBack();'>
								<a data-original-title="Refresh" data-placement="top"
									data-toggle="dropdown" class="btn mini tooltips"
									href="javascript:;"><i class="fa  fa-long-arrow-left"></i> Go Back</a>
							</div>


							<div class="btn-group hidden-phone"
								onclick='javascript:deleteMail();'>
								<a data-original-title="Refresh" data-placement="top"
									data-toggle="dropdown" class="btn mini tooltips"
									href="javascript:;"><i class="fa fa-trash-o"></i> Delete</a>
							</div>
							<div id='mail-body'>
							<br>
								<%=identify + " : " + user%>
								<br>
								<%= "On : " + mail.getDate() %>
								<br><br>
								<%=mail.getMessage()%>
							</div>
						</div>
					</div>
				</div>
				<form id='goBackForm'></form>
				<form id='DeleteMail' action='DeleteMail' method='post'>
					<input type='hidden' name='isSender' id='DeleteMail_isSender' value=''>
					<input type='hidden' name='mailId' id='DeleteMail_mailId' value=''>
					<input type='hidden' name='start' id='DeleteMail_start' value='0'>
					<input type='hidden' name='deleteMultiple' id='DeleteMail_deleteMultiple' value='false'>			
				</form>
			</aside>
		</div>
	</div>
	<script>
	</script>
</body>
</html>
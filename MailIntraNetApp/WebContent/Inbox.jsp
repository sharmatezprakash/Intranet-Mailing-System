<%@page import="com.cdac.beans.Mail"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Inbox</title>
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



<%!boolean redirect = false;
	List<Mail> mails;
	int start = 0, end;
	int sentboxSize, inboxSize;%>
<%
	if ((session.getAttribute("mailsFrom") == null) || !(session.getAttribute("mailsFrom").equals("inbox"))) {
		redirect = true;
	} else {
		redirect = false;

		Object obj = session.getAttribute("mails");

		// Check it's an ArrayList
		if (obj instanceof List<?>) {
			// Get the List.
			List<?> al = (List<?>) obj;
			mails = new ArrayList<>();

			start = (int) session.getAttribute("start");
			inboxSize = (int) ((session.getAttribute("inboxSize") != null)
					? session.getAttribute("inboxSize")
					: -1);
			sentboxSize = (int) ((session.getAttribute("sentboxSize") != null)
					? session.getAttribute("sentboxSize")
					: -1);
			end = ((start + 10) > inboxSize) ? inboxSize : (start + 10);

			if (al.size() > 0) {
				// Iterate.
				for (int i = 0; i < al.size(); i++) {
					// Still not enough for a type.
					Object o = al.get(i);
					if (o instanceof Mail) {
						// Here we go!
						Mail v = (Mail) o;
						// use v.
						mails.add(v);
						/* out.println(v.toString() + " <br><br>"); */
					}
				}
			}
		}
	}
%>

<script src="js/jquery-3.3.1.js"></script>
<script src="js/inbox.js"></script>
<script>
	var startMail;
	var end;
	var arrayOfMailIds = [];
	$(document).ready(function() {
		if (<%=redirect%> == true) {
			$("#getMails").submit();
		}
		$("#email-link").off('click');
		startMail = <%=start%>;
		end = <%=end%>;
	});
</script>
<%
	for (int i = 0; ((mails != null) && (i < mails.size())); i++) {
%>
<script>
	arrayOfMailIds.push(<%=mails.get(i).getId()%>);
</script>
<%
	}
%>
</head>
<body>
	<form action="GetMails" id='getMails'>
		<input type='hidden' name='isSender' value='false' id='GetMails_category'>
		<input type='hidden' name='start' value='0' id='GetMails_start'>
	</form>

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
											<!-- <div class="form-group">
											<label class="col-lg-2 control-label">Cc / Bcc</label>
											<div class="col-lg-10">
												<input type="text" placeholder="" id="cc"
													class="form-control">
											</div>
										</div> -->
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
						<li class="active"><a href="Inbox.jsp"><i
								class="fa fa-inbox"></i> Inbox <span
								class="label label-danger pull-right"><%=(mails != null) ? inboxSize : ""%></span></a></li>
						<li><a href="sentbox.jsp"><i class="fa fa-envelope-o"></i>
								Sent Mail <span class="label label-danger pull-right"><%=(sentboxSize != -1) ? sentboxSize : ""%></span></a></li>

						<li><a href="logout.jsp"><i class=" fa  fa-lock"></i>
								Logout</a></li>
					</ul>

					<!-- 
				<ul class="nav nav-pills nav-stacked labels-info inbox-divider">
					<li>
						<h4>Labels</h4>
					</li>
					<li><a href="#"> <i class=" fa fa-sign-blank text-danger"></i>
							Work
					</a></li>
					<li><a href="#"> <i class=" fa fa-sign-blank text-success"></i>
							Design
					</a></li>
					<li><a href="#"> <i class=" fa fa-sign-blank text-info "></i>
							Family
					</a></li>
					<li><a href="#"> <i
							class=" fa fa-sign-blank text-warning "></i> Friends
					</a></li>
					<li><a href="#"> <i
							class=" fa fa-sign-blank text-primary "></i> Office
					</a></li>
				</ul>
 -->
					<!-- 				<ul class="nav nav-pills nav-stacked labels-info ">
					<li>
						<h4>Buddy online</h4>
					</li>
					<li><a href="#"> <i class=" fa fa-circle text-success"></i>Alireza
							Zare
							<p>I do not think</p></a></li>
					
				</ul>
 -->
					<!-- <div class="inbox-body text-center">
					<div class="btn-group">
						<a class="btn mini btn-primary" href="javascript:;"> <i
							class="fa fa-plus"></i>
						</a>
					</div>
					<div class="btn-group">
						<a class="btn mini btn-success" href="javascript:;"> <i
							class="fa fa-phone"></i>
						</a>
					</div>
					<div class="btn-group">
						<a class="btn mini btn-info" href="javascript:;"> <i
							class="fa fa-cog"></i>
						</a>
					</div> -->
				</div>
			</aside>
			<aside class="lg-side">
				<div id='inbox'>
					<div class="inbox-head">
						<h3>Inbox</h3>
						<form action="#" class="pull-right position">
							<div class="input-append">
								<input id="search-text" type="text" class="sr-input"
									placeholder="Search Mail">
								<button id="search-btn" class="btn sr-btn" type="button">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</form>
					</div>
					<div class="inbox-body">
						<div class="mail-option">
							<div class="chk-all">
								<input id='all-chkbox' type="checkbox"
									onclick='javascript:allChkboxClicked();'
									class="mail-checkbox mail-group-checkbox">
								<div class="btn-group">
									<a data-toggle="dropdown" class="btn mini all"
										aria-expanded="false" href="javascript:;"> All <i
										class="fa fa-angle-down "></i>
									</a>
									<ul class="dropdown-menu">
										<!-- <li><a href="javascript:checkAll()"> All</a></li> -->
										<li><a href="javascript:uncheckAll()"> None</a></li>
										<li><a href="javascript:checkRead()"> Read</a></li>
										<li><a href="javascript:checkUnread()"> Unread</a></li>
									</ul>
								</div>
							</div>
							<div class="btn-group" id='refresh-btn'
								onclick='javascript:loadInbox();'>
								<a data-original-title="Refresh" data-placement="top"
									data-toggle="dropdown" href="javascript:;"
									class="btn mini tooltips"> <i class=" fa fa-refresh"></i>
								</a>
							</div>
							<div class="btn-group hidden-phone" id='delete-btn'
								onclick='javascript:deleteMails();'>
								<a data-original-title="Refresh" data-placement="top"
									data-toggle="dropdown" class="btn mini tooltips"
									href="javascript:;"><i class="fa fa-trash-o"></i> Delete</a>

							</div>

							<ul class="unstyled inbox-pagination">
								<li><span> <%
 	if (mails != null) {
 		out.println((start + 1) + " - " + end + " of " + inboxSize);
 %>
								</span></li>
								<li><a class="np-btn"
									href="javascript:loadInbox(<%=start - 10%>)"><i
										class="fa fa-angle-left  pagination-left"></i></a></li>
								<li><a class="np-btn" href="javascript:loadInbox(<%=end%>)"><i
										class="fa fa-angle-right pagination-right"></i></a></li>
							</ul>
						</div>
						<table class="table table-inbox table-hover">
							<tbody>

								<%
									for (int i = 0; i < mails.size(); i++) {
											int mailId = mails.get(i).getId();
								%>
								<tr class="unread">
									<td class="inbox-small-cells"><input type="checkbox"
										class="mail-checkbox" id='chk-box-<%=mailId%>'
										onclick='javascript:chkboxClick(<%=mailId%>)'></td>

									<td class='inbox-small-cells'><i
										<%=mails.get(i).isStarred() ? "class='fa fa-star showStarred'" : "class='fa fa-star'"%>
										id='starred-<%=mailId%>'
										onclick='javascript:starredClick(<%=mailId%>)'></i></td>
									<!-- 
								<td class="view-message  dont-show">PHPClass</td>
								<td class="view-message ">Added a new class: Login Class
									Fast Site</td>
								<td class="view-message  inbox-small-cells"><i
									class="fa fa-paperclip"></i></td>
								<td class="view-message  text-right">9:27 AM</td>
								 -->
<!-- view-message dont-show -->
									<td class=""><div
											id='viewMsg-<%=mailId%>'
											onclick='javascript:viewInbox(<%=i%>)'><%=mails.get(i).getSender()%></div></td>
									<td class="view-message "><div id='viewMsg-<%=mailId%>'
											onclick='javascript:viewInbox(<%=i%>)'><%=mails.get(i).getSubject()%></div></td>
									<!-- <td class="view-message  inbox-small-cells"><i
									class="fa fa-paperclip"></i></td> -->
									<td class="view-message  text-right"><div
											id='viewMsg-<%=mailId%>'
											onclick='javascript:viewInbox(<%=i%>)'><%=mails.get(i).getDate()%></div></td>
								</tr>
								<%
									}
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
				<form action='ViewMail.jsp' id='viewMailForm'>
					<input type='hidden' name='isSender' value='false' id='isSender'>
					<input type='hidden' name='mailIndex' value='' id='mailIndex'>
				</form>
				<form action='MarkStarred' id='markStarredForm' method='Post'>
					<input type='hidden' name='id' value='' id='markStarredForm_ID'>
					<input type='hidden' name='isMarked' value=''
						id='markStarredForm_isMarked' /> <input type='hidden'
						name='isSender' value='' id='markStarredForm_isSender'> <input
						type='hidden' name='start' value='' id='markStarredForm_start'>
				</form>
				<form id='DeleteMail' action='DeleteMail' method='post'>
					<input type='hidden' name='isSender' id='DeleteMail_isSender' value='false'>
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
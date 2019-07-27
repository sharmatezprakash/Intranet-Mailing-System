<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>Login | Intranet Mailing Application</title>
<link rel="stylesheet" href="css/registration-style.css">
</head>
<body>

	<%
		if (request.getSession(false).getAttribute("Username") != null) {
			request.getRequestDispatcher("Inbox.jsp").forward(request, response);
		}
	%>
	<%!boolean success = false;
	int statusCode = -1;%>
	<%
		if (request.getAttribute("success") != null) {
			if ((boolean) (request.getAttribute("success"))) {
				success = true;
			}
			statusCode = (int) request.getAttribute("statusCode");
		}
	%>
	<form class="box" action="Login" method="post"
		onsubmit="return performValidations();">

		<h1>Login</h1>

		<div id="divMail">
			<input type="email" name="mail" id="mail" placeholder="Email"
				required>
			<div id="lblMail"></div>
		</div>
		<div id="divPasswd">
			<input type="password" name="passwd" id="passwd"
				placeholder="Password" required>
			<div id="lblPasswd"></div>
		</div>

		<div id="err"></div>
		<input type="submit" name="" value="Login">
	</form>

	<script src="js/jquery-3.3.1.js"></script>
	<script src="js/validation.js"></script>
	<script>
		var performValidations = function() {
			if (!validEmail($("#mail").val())) {
				$("#lblMail").html("Please enter Email in a valid structure");
				$("#lblMail").addClass("error");
				$("#lblMail").show();
				return false;
			} else {
				return true;
			}
		}
	</script>

</body>
</html>

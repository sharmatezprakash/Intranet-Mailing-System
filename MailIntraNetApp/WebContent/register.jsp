<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body {
                font-family: Arial, Helvetica, sans-serif;
            }

            form {
                border: 3px solid #f1f1f1;
            }

            input[type=text], input[type=password], input[type=submit], input[type=email]
            {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            button {
                background-color: #4CAF50;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                cursor: pointer;
                width: 40%;
            }

            button:hover {
                opacity: 0.8;
            }

            .container {
                padding: 16px;
            }

            span.psw {
                float: right;
                padding-top: 16px;
            }
            /* Change styles for span and cancel button on extra small screens */
            @media screen and (max-width: 300px) {
                span.psw {
                    display: block;
                    float: none;
                }
                .cancelbtn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <h2>
            <b><i>Registration Form</b></i>
    </h2>
    <hr>

    <form action="Register" method="post">
        <b>Name</b>
        <input type="text" placeholder="Enter Name" name="name" required /><br>
        <b>Email Id</b> <input type="email" placeholder="Enter Email" name="mail" required /><br> 
        <b>Contact</b>
        <input type="text" placeholder="Contact Number" name="contact" required /><br> 
        <b>Password</b> <input type="password" placeholder="Enter Password" name="passwd" required /><br>
        <b>Confirm Password</b> 
        <input type="password" placeholder="Confirm Password" name="cpasswd" required /><br>

        <button type="submit" align='center'>Register</button>

    </form>

</body>
</html>

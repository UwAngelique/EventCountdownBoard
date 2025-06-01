<%-- 
    Document   : register
    Created on : May 31, 2025, 7:34:46 PM
    Author     : UwAngelique
--%>
<%@ page import="java.util.LinkedList" %>
<%@ page import="Events.User" %>
<%@ page import="backend.dbHandler" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(to right, #f8f9fa, #e0e0e0);
                padding: 20px;
                margin: 0;
            }

            .container {
                max-width: 480px;
                margin: 60px auto;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
                padding: 30px;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            input {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 16px;
            }

            button {
                width: 100%;
                padding: 12px;
                background-color: #28a745;
                color: #fff;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 15px;
            }

            button:hover {
                background-color: #218838;
            }

            .google-btn {
                background-color: #db4437;
            }

            .footer {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
            }

            .footer a {
                color: #007bff;
                text-decoration: none;
            }

            .footer a:hover {
                text-decoration: underline;
            }

            @media (max-width: 600px) {
                .container {
                    margin: 30px 15px;
                    padding: 20px;
                }

                h2 {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        <%
            if("POST".equalsIgnoreCase(request.getMethod()))
          {
         String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm_pass = request.getParameter("comfirm-password");
        String username = request.getParameter("username");

        if (email != null && password != null && confirm_pass != null && username != null) {
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-={}';:\\\"\\\\|,.<>/?]).{8,}$";

            if (!password.equals(confirm_pass)) {
                out.println("<p style='color:red;'>Password and confirm password do not match.</p>");
            } else if (!password.matches(passwordPattern)) {
                out.println("<p style='color:red;'> Weak password! Must atleast characters, with uppercase, lowercase, number & special char.</p>");
            } else {
//                injiza muri db
              LinkedList<User> users = new LinkedList<>();
                User user = new User(email,username,password);
                users.add(user);
                dbHandler db = new dbHandler();
                boolean success = false;
                try {
                    success = db.saveUsers(users);
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error saving user: " + e.getMessage() + "</p>");
                }

                if (success) {
//                    out.println("<p style='color:green;'>User registered successfully!</p>");
                      response.sendRedirect("login.jsp");
                        return;
                } else {
                    out.println("<p style='color:red;'>Registration failed. Please try again.</p>");
                }
            }
        }
                    }
        %>
        <div class="container">
            <form action="#" method="post">
                <h2>Create Account</h2>
                <input type="text" name="username" placeholder="Username" required />
                <input type="email" name="email" placeholder="Email" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="password" name="comfirm-password" placeholder="comfirm-password" required />
                <button type="submit">Register</button>

                <%-- Uncomment below for Google sign-in integration 
                <button class="google-btn" type="button" onclick="location.href='https://accounts.google.com/o/oauth2/auth?...'">Continue with Google</button>
                --%>

                <div class="footer">
                    Already have an account? <a href="login.jsp">Login here</a>
                </div>
            </form>
        </div>

    </body>
</html>

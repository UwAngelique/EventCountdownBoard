<%-- 
    Document   : login
    Created on : May 31, 2025, 7:29:52 PM
    Author     : UwAngelique
--%>
<%@ page import="java.util.LinkedList" %>
<%@ page import="Events.User" %>
<%@ page import="backend.dbHandler" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <style>
            /* Reset some default margins and paddings */
            * {
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background-color: #f0f0f0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh; /* full viewport height */
                margin: 0;
            }

            form {
                background: white;
                padding: 30px 25px;
                width: 100%;
                max-width: 400px;
                border-radius: 8px;
                box-shadow: 0 0 12px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: 600;
                color: #333;
            }

            input, button {
                width: 100%;
                padding: 12px 15px;
                margin: 10px 0;
                font-size: 1rem;
                border-radius: 4px;
                border: 1px solid #ccc;
                transition: border-color 0.3s ease;
            }

            input:focus {
                border-color: #28a745;
                outline: none;
            }

            button {
                background-color: #28a745;
                color: white;
                border: none;
                cursor: pointer;
                font-weight: bold;
            }

            button:hover {
                background-color: #218838;
            }

            h5 {
                margin: 15px 0 5px;
                font-weight: normal;
                color: #555;
            }

            a {
                color: #28a745;
                text-decoration: none;
                font-weight: 600;
            }

            a:hover {
                text-decoration: underline;
            }

            /* Responsive tweaks */
            @media (max-width: 480px) {
                body {
                    padding: 10px;
                }

                form {
                    padding: 20px 15px;
                    max-width: 100%;
                }

                input, button {
                    font-size: 0.9rem;
                }
            }
        </style>
    </head>
    <body>
        <%
            if("POST".equalsIgnoreCase(request.getMethod()))
            {
                String username=request.getParameter("username");
                String password=request.getParameter("password");
                  dbHandler db = new dbHandler();

        if (username != null && password != null) {
            try {
                User user = db.LoginUser(username, password);
                if (user != null) {
//                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                      
                    session.setAttribute("user_id", user.getUser_id());   
                    session.setAttribute("email", user.getEmail()); 
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout
                    response.sendRedirect("list-events");
                } else {
                    out.println("<p style='color:red'>Invalid username or password</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            }
        }
            
            }
        %>
        <form action="#" method="post">
            <h2>Login</h2>
            <input type="text" name="username" placeholder="Username" required />
            <input type="password" name="password" placeholder="Password" required />
            <button type="submit">Login</button>
            <h5>Not having an account</h5><a href="register.jsp">register</a>
        </form>
    </body>
</html>


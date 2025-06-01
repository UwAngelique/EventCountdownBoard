<%@ page import="java.util.LinkedList" %>
<%@ page import="Events.User" %>
<%@ page import="backend.dbHandler" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<html>
    <head>
        <title>Event Countdown Board</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 40px;
                background-color: #f5f5f5;
            }
            h1 {
                text-align: center;
            }
            form {
                background: white;
                padding: 20px;
                max-width: 500px;
                margin: 0 auto;
                border-radius: 8px;
                box-shadow: 0 0 8px #ccc;
            }
            input, textarea, select, button {
                width: 100%;
                padding: 8px;
                margin: 10px 0;
                box-sizing: border-box;
            }
            button {
                background-color: green;
                border: none;
                color: white;
                font-weight: bold;
                cursor: pointer;
            }
            button:hover {
                background-color: white;
                color:black;
            }
        </style>
    </head>
    <jsp:include page="includes/header.jsp" />
    <body>
        <%
        User user = (User) session.getAttribute("user");
          String userId = (String) session.getAttribute("user_id");  
        String email = (String) session.getAttribute("email");
    
        if (user != null) {
    //        out.print("Welcome, " + user.getUsername());
    //         out.print("Welcome, " + userId);
    //           out.print("Welcome, " + email);
        
        
//        } else {
//            response.sendRedirect("login.jsp");
//        }
      
        %>
        <!--<h1>Add New Event</h1>
        <form action="add-event" method="post">
            <input type="hidden" id="username" name="username" value="<%=user%>">
            <input type="hidden" id="user_id" name="user_id" value="<%=userId%>">
             <input type="hidden" id="email" name="email" value="<%=email%>">
            <label for="title">Event Title</label>
            <input type="text" id="title" name="title" required>
        
            <label for="description">Description</label>
            <textarea id="description" name="description"></textarea>
        
            <label for="datetime">Date & Time</label>
            <input type="datetime-local" id="datetime" name="datetime" required>
        
            <label for="tag">Tag / Type</label>
            <select id="tag" name="tag">
                <option value="Birthday">Birthday</option>
                 <option value="Birthday">Trainings</option>
                <option value="hackathon">Hackathon</option>
                <option value="graduation">Graduation</option>
                <option value="travel?">Travel</option>
            </select>
        
            <button type="submit">Save Event</button>
        </form>
        </body>
        </html>-->
        <%
//            String action = "add-event";
            String title = "";
            String description = "";
            String datetime = "";
            String tag = "";
            String eventId = request.getParameter("id");
            String user_id=request.getParameter("user_id");
            String action=request.getParameter("action");
        dbHandler db=new dbHandler();
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            if (eventId != null) {
                Events.Event existingEvent = db.getCertainEvent(eventId,user_id);
                if (existingEvent != null) {
                    title = existingEvent.getTitle();
                    description = existingEvent.getDescription();
                     java.time.LocalDateTime dt = existingEvent.getDatetime();
        if (dt != null) {
            datetime = dt.format(formatter);  // convert to string for input datetime-local field
        }
                    tag = existingEvent.getTag();
//                    action = "update-event";
                }
            }
        %>

        <h1><%= (eventId != null) ? "Edit Event" : "Add New Event" %></h1>

        <form action="add-event" method="post">
            <% if (eventId != null) { %>
            <input type="hidden" name="eventId" value="<%= eventId %>">
            <input type="hidden" name="action" value="<%= action %>">
            <% } %>

            <input type="hidden" id="username" name="username" value="<%= user.getUsername() %>">
            <input type="hidden" id="user_id" name="user_id" value="<%= userId %>">
            <input type="hidden" id="email" name="email" value="<%= email %>">

            <label for="title">Event Title</label>
            <input type="text" id="title" name="title" required value="<%= title %>">

            <label for="description">Description</label>
            <textarea id="description" name="description"><%= description %></textarea>

            <label for="datetime">Date & Time</label>
            <input type="datetime-local" id="datetime" name="datetime" required value="<%= datetime %>">

            <label for="tag">Tag / Type</label>
            <select id="tag" name="tag">
                <option value="Birthday" <%= "Birthday".equals(tag) ? "selected" : "" %>>Birthday</option>
                <option value="Trainings" <%= "Trainings".equals(tag) ? "selected" : "" %>>Trainings</option>
                <option value="hackathon" <%= "hackathon".equals(tag) ? "selected" : "" %>>Hackathon</option>
                <option value="graduation" <%= "graduation".equals(tag) ? "selected" : "" %>>Graduation</option>
                <option value="travel?" <%= "travel?".equals(tag) ? "selected" : "" %>>Travel</option>
                <option value="Music" <%= "Music".equals(tag) ? "selected" : "" %>>Music</option>
                <option value="Charity" <%= "Charity".equals(tag) ? "selected" : "" %>>Charity</option>
                <option value="Technology" <%= "Technology".equals(tag) ? "selected" : "" %>>Technology</option>
                <option value="Art" <%= "Art".equals(tag) ? "selected" : "" %>>Art</option>
                <option value="Community" <%= "Community".equals(tag) ? "selected" : "" %>>Community</option>
                
            </select>

            <button type="submit"><%= (eventId != null) ? "Update" : "Save" %> Event</button>
        </form>
    </body>
    <%}   if (user == null) {
        response.sendRedirect("login.jsp");
        return; // ? IMPORTANT: Stop further JSP processing
    }%>

<%-- 
    Document   : list-events
    Created on : Jun 1, 2025, 12:00:21 AM
    Author     : UwAngelique
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="Events.User" %>
<%@ page import="Events.Event" %>
<%@ page import="backend.dbHandler" %>
<%@ page import="backend.MySQLConnector" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>



<!DOCTYPE html>
<head>
    <title>Event List</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

</head>
<jsp:include page="../includes/header.jsp" />
<body>
    <%
        String action="";
        String status = request.getParameter("status");
        action = request.getParameter("action");
    %>

    <% if ("insert".equals(action)) { 
     if ("success".equals(status)) { %>
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Event added successfully.',
            confirmButtonColor: '#3085d6'
        }).then(() => {
            window.location.href = window.location.pathname;
        });

    </script>
    <%  } else if ("fail".equals(status)) { %>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Failed!',
            text: 'Failed to add event. Please try again.',
            confirmButtonColor: '#d33'
        });
    </script>
    <%  } 
    }
        if ("edit".equals(action)) { 
         if ("success".equals(status)) { %>
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Event updated successfully.',
            confirmButtonColor: '#3085d6'
        });
    </script>
    <%  } else if ("fail".equals(status)) { %>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Failed!',
            text: 'Failed to update event. Please try again.',
            confirmButtonColor: '#d33'
        });
    </script>
    <%  } 
    } 

           String id = request.getParameter("id");
        String userId = request.getParameter("user_id");
        action = request.getParameter("action");
    
        out.println("id = " + id);
        out.println("user_id = " + userId);
        out.println("action = " + action);
    out.println("action: "+action+" eventId:"+id+" userId:"+userId);

        if ("delete".equals(action)&& id != null && userId != null) {
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = MySQLConnector.getConnection();
                String sql = "DELETE FROM events WHERE EVENT_ID = ? AND USER_ID = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, id);
                ps.setString(2, userId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
    //                response.sendRedirect("list-events?deleted=true");
    %>
    <script>
        // Show SweetAlert on successful deletion
        Swal.fire({
            icon: 'success',
            title: 'Deleted!',
            text: 'Event deleted successfully.',
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'OK'
        }).then(() => {
            window.location.href = window.location.pathname;
        });
    </script>
    <%   } else {
         response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        out.println("<html><head>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head><body>");
        out.println("<script>");
        out.println("Swal.fire({");
        out.println("  icon: 'error',");
        out.println("  title: 'Delete Failed',");
        out.println("  text: 'Failed to delete event. Event may not exist.',");
        out.println("  confirmButtonColor: '#d33'");
        out.println("}).then(() => {");
        out.println("  window.location.href = 'list-events';");
        out.println("});");
        out.println("</script>");
        out.println("</body></html>");
       }
   } catch (Exception e) {
//            e.printStackTrace(out);
   } finally {
       try { if (ps != null) ps.close(); } catch (Exception e) {}
       try { if (conn != null) conn.close(); } catch (Exception e) {}
   }
} else {
   out.println("Missing parameters.");
}
    %>
    <div class="mycontainer">
    <h1>My Events</h1>
    <div style="margin-bottom: 20px; text-align: right;">
        <a href="${pageContext.request.contextPath}/add-event.jsp" 
           style="background-color: green; color: white; padding: 10px 18px; border-radius: 6px; text-decoration: none; font-weight: bold;">
            + Add Event
        </a>
    </div>
    <div class="table-container">
        <%
            List<Event> events = (List<Event>) request.getAttribute("events");
            if (events != null && !events.isEmpty()) {
        %>
        <table id="eventsTable">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Date & Time</th>
                    <th>Tag</th>
                    <th>Countdown</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int i = 1;
                    for (Event e : events) {
                %>

                <tr>
                    <td><%= i %></td>
                    <td><%= e.getTitle() %></td>
                    <td><%= e.getDescription() %></td>
                    <td><%= e.getDatetime() %></td>
                    <td><%= e.getTag() %></td>
                    <td>
                        <span class="countdown" data-datetime="<%= e.getDatetime() %>"></span>
                    </td>
                    <td>
                        <a href="add-event.jsp?id=<%= e.getEvent_id() %>&user_id=<%= e.getUser_id() %>&action=Edit" title="Edit">
                            <i class="bi bi-pencil-square" style="font-size: 1.2rem; color: green;"></i>
                        </a>
                        &nbsp;
                        <a href="?id=<%= e.getEvent_id() %>&user_id=<%= e.getUser_id() %>&action=delete" title="Delete" onclick="return confirm('Are you sure?');">
                            <i class="bi bi-trash" style="font-size: 1.2rem; color: #dc3545;"></i>
                        </a>

                    </td>

                </tr>

                <%
                       i++;
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p>No events found.</p>
        <%
            }
        %>
    </div
    </div>

    <script >


        // Function to calculate remaining time
        function getRemainingTime(datetimeStr) {
            const now = new Date();
            const eventTime = new Date(datetimeStr);

            const diff = eventTime - now;
            if (diff <= 0)
                return null;

            return {
                days: Math.floor(diff / (1000 * 60 * 60 * 24)),
                hours: Math.floor((diff / (1000 * 60 * 60)) % 24),
                minutes: Math.floor((diff / (1000 * 60)) % 60),
                seconds: Math.floor((diff / 1000) % 60)
            };
        }

        function formatCountdown(timeObj) {
            console.log("object mfite niyi: ", timeObj);
            if (!timeObj)
                return '<span style="color: white; background-color:red; font-weight: bold;">Passed</span>';

            const highlight = timeObj.days < 1 ? 'background-color: orange; color: black; padding: 2px 6px; border-radius: 4px;' : '';
//            console.log("days mfite nizi: " + (timeObj.days).padStart(2, '0'));
            // Convert all parts to safe strings and use padStart
            const days = String(timeObj.days ?? 0).padStart(2, '0');
                    const hours = String(timeObj.hours ?? 0).padStart(2, '0');
                    const minutes = String(timeObj.minutes ?? 0).padStart(2, '0');
                    const seconds = String(timeObj.seconds ?? 0).padStart(2, '0');

//            console.log("days: " + days + " hours: " + hours + " minutes:" + minutes + " seconds:" + seconds)
            //return days+" days "+hours+":"+minutes+":"+seconds;
            const isLessThanOneDay = Number(timeObj.days) < 1;
            const countdownText = days + " days " + hours + ":" + minutes + ":" + seconds;

//            console.log("days: " + days + " hours: " + hours + " minutes:" + minutes + " seconds:" + seconds);
//            console.log("countdownText: ", countdownText);

            if (isLessThanOneDay) {
                return `<span style="background-color: green; color: white; width:30% !important">` + countdownText + `</span>`;
            } else {
                return countdownText;
            }

        }



        // Update all countdowns on page buri second
        function updateCountdowns() {
            const countdownElements = document.querySelectorAll('.countdown');

            countdownElements.forEach(el => {
                const datetime = el.getAttribute('data-datetime');
                const remaining = getRemainingTime(datetime);
                el.innerHTML = formatCountdown(remaining);
            });
        }

        // Start the countdown updates
        updateCountdowns();          // initial call
        setInterval(updateCountdowns, 1000); // update every second
    </script>
</body>



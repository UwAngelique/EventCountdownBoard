/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Events;

import backend.dbHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.LinkedList;

/**
 *
 * @author UwAngelique
 */
@WebServlet("/add-event")
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventId = request.getParameter("eventId");
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String user_id = request.getParameter("user_id");
        String email = request.getParameter("email");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String datetimeStr = request.getParameter("datetime");
        String tag = request.getParameter("tag");

        try {
            LocalDateTime datetime = LocalDateTime.parse(datetimeStr);
            LinkedList<Event> events = new LinkedList<>();
            if ("Edit".equals(action) && eventId != null && !eventId.isEmpty()) {
                // Update existing event
                Events.Event event = new Events.Event(eventId, user_id, title, description, datetime, tag, action);
//                dbHandler.updateEvent(event);
//                response.sendRedirect("list-events");
                boolean updated = dbHandler.updateEvent(event);

                if (updated) {
                    response.sendRedirect("list-events?status=success&action=edit");
                } else {
                    response.sendRedirect("list-events?status=fail&action=edit");
                }
            } else {
                events.add(new Event(username, user_id, title, description, datetime, tag));
                dbHandler.insertEvents(events);

               response.sendRedirect("list-events?status=success&action=insert");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving event: " + e.getMessage());
        }
    }
}

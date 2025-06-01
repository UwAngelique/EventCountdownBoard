/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Events;

import backend.MySQLConnector;
import backend.dbHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import java.time.LocalDateTime;

/**
 *
 * @author UwAngelique
 */
@WebServlet("/list-events")
public class ListEventsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userId = "";
        if (session != null) {
            userId = (String) session.getAttribute("user_id");

        } else {
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("userid mfite: " + userId);
        dbHandler db = new dbHandler();
        List<Event> events;
        try {
            events = db.getEventsByUserId(userId);
//            events.sort(Comparator.comparing(Event::getDatetime));
//            events.sort(Comparator.comparing(Event::getDatetime, Comparator.nullsLast(Comparator.naturalOrder())));
            events.sort(Comparator.comparing((Event e) -> {
                LocalDateTime now = LocalDateTime.now();
                LocalDateTime eventTime = e.getDatetime();

                // If eventTime is null, treat it as in the past (optional)
                if (eventTime == null) {
                    return 1;
                }

                // Future events come first → return 0; Past events → return 1
                return eventTime.isBefore(now) ? 1 : 0;
            }).thenComparing(Event::getDatetime, Comparator.nullsLast(Comparator.naturalOrder())));
            request.setAttribute("events", events);
//            request.getRequestDispatcher("/WEB-INF/list-events.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
//            Logger.getLogger(ListEventsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher("/WEB-INF/list-events.jsp").forward(request, response);
    }
}

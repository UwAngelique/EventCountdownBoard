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

/**
 *
 * @author UwAngelique
 */
@WebServlet("/list-events")
public class ListEventsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userId="";
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
            events.sort(Comparator.comparing(Event::getDatetime));
            request.setAttribute("events", events);
        } catch (Exception ex) {
            ex.printStackTrace();
            Logger.getLogger(ListEventsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher("/WEB-INF/list-events.jsp").forward(request, response);
    }
}

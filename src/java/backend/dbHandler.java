package backend;

import Events.Event;
import Events.User;
import static backend.MySQLConnector.getConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class dbHandler {

//    public static void initDatabase() {
//        String sql = """
//            CREATE TABLE IF NOT EXISTS events (
//                id INT AUTO_INCREMENT PRIMARY KEY,
//                EVENT_ID VARCHAR(10) UNIQUE,
//                title VARCHAR(100),
//                description TEXT,
//                datetime DATETIME,
//                tag VARCHAR(10)
//            )
//            """;
//
//        try (Connection conn = MySQLConnector.getConnection();
//                Statement stmt = conn.createStatement()) {
//            stmt.execute(sql);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
    //function to generate unique id user
    public static String generateClientId() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String date = sdf.format(new Date());

        String random = getRandomAlphaNumeric(8);
        return "USER-" + date + "-" + random;
    }

    private static String getRandomAlphaNumeric(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public boolean saveUsers(LinkedList<User> users) throws Exception {
        try (Connection conn = MySQLConnector.getConnection()) {
            String user_id = generateClientId();
            String query = "INSERT INTO users (user_id,email, username, password) VALUES (?,?, ?, ?)";
            System.out.println("query: " + query);
            PreparedStatement stmt = conn.prepareStatement(query);

            for (User user : users) {
                stmt.setString(1, user_id);
                stmt.setString(2, user.getEmail());
                stmt.setString(3, user.getUsername());
                stmt.setString(4, user.getPassword());
                stmt.executeUpdate();
            }

            System.out.println("All users inserted successfully.");
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User LoginUser(String username, String Passw) throws Exception {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = MySQLConnector.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, Passw);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String user = rs.getString("username");
                    String pass = rs.getString("password");
                    String user_id = rs.getString("user_id");
                    String email = rs.getString("email");
                    return new User(user, pass, user_id, email);
                } else {
                    return null;
                }
            }
        }
    }

    public static void insertEvents(LinkedList<Event> events) throws Exception {
        try (Connection conn = MySQLConnector.getConnection()) {
            String event_id = generateNextEventID(conn);
            String sql = "INSERT INTO events (EVENT_ID,USER_NAME,USER_ID,TITLE, DESCRIPTION, DATETIME, TAG) VALUES (?,?,?,?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            for (Event event : events) {
                stmt.setString(1, event_id);
                stmt.setString(2, event.getUsername());
                stmt.setString(3, event.getUser_id());
                stmt.setString(4, event.getTitle());

                stmt.setString(5, event.getDescription());
                LocalDateTime ldt = event.getDatetime();
                Timestamp ts = Timestamp.valueOf(ldt);
                stmt.setTimestamp(6, ts);
                stmt.setString(7, event.getTag());
                stmt.addBatch();
            }

            stmt.executeBatch();
        }
    }

    public static String generateNextEventID(Connection conn) throws Exception {
        String prefix = "EVNT";
        int nextIdNumber = 1;

        String sql = "SELECT EVENT_ID FROM events ORDER BY EVENT_ID DESC LIMIT 1";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            String lastId = rs.getString("EVENT_ID");
            String numberPart = lastId.substring(4);
            nextIdNumber = Integer.parseInt(numberPart) + 1;
        }

        return prefix + String.format("%02d", nextIdNumber);
    }

    public static List<Event> getEventsByUserId(String userId) throws Exception {
        List<Event> events = new ArrayList<>();

        try (Connection conn = MySQLConnector.getConnection()) {
            String sql = "SELECT * FROM events WHERE USER_ID = ? ORDER BY DATETIME DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Event event = new Event();
                event.setEvent_id(rs.getString("EVENT_ID"));
                event.setUsername(rs.getString("USER_NAME"));
                event.setUser_id(rs.getString("USER_ID"));
                event.setTitle(rs.getString("TITLE"));
                event.setDescription(rs.getString("DESCRIPTION"));
                event.setDatetimeStr(rs.getTimestamp("DATETIME").toLocalDateTime());
                event.setTag(rs.getString("TAG"));
                events.add(event);
            }
        }

        return events;
    }

public static Event getCertainEvent(String event_id, String userId) throws Exception {
    Event event = null;
    try (Connection conn = MySQLConnector.getConnection()) {
        String sql = "SELECT * FROM events WHERE EVENT_ID = ? AND USER_ID = ? ORDER BY DATETIME DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, event_id);
        stmt.setString(2, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) { 
            event = new Event();
            event.setEvent_id(rs.getString("EVENT_ID"));
            event.setUsername(rs.getString("USER_NAME"));
            event.setUser_id(rs.getString("USER_ID"));
            event.setTitle(rs.getString("TITLE"));
            event.setDescription(rs.getString("DESCRIPTION"));
            event.setDatetimeStr(rs.getTimestamp("DATETIME").toLocalDateTime());
            event.setTag(rs.getString("TAG"));
        }
    }
    return event;
}
public static boolean updateEvent(Events.Event event) {
    String sql = "UPDATE events SET TITLE = ?, DESCRIPTION = ?, DATETIME = ?, TAG = ? WHERE EVENT_ID = ? AND USER_ID = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
//        System.out.println("Updating Event with the following values:");
//        System.out.println("Title: " + event.getTitle());
//        System.out.println("Description: " + event.getDescription());
//        System.out.println("Datetime: " + event.getDatetime());
//        System.out.println("Tag: " + event.getTag());
//        System.out.println("Event ID: " + event.getEvent_id());
//        System.out.println("User ID: " + event.getUser_id());
        ps.setString(1, event.getTitle());
        ps.setString(2, event.getDescription());
        ps.setTimestamp(3, Timestamp.valueOf(event.getDatetime()));
        ps.setString(4, event.getTag());
        ps.setString(5, event.getEvent_id());
        ps.setString(6, event.getUser_id());
         int rowsAffected = ps.executeUpdate();
            System.out.println("Update executed, rows affected: " + rowsAffected);
        return ps.executeUpdate() > 0;
             
    } catch (SQLException e) {
          System.err.println("SQLException occurred while updating event:");
        e.printStackTrace();
        return false;
    }
}



}

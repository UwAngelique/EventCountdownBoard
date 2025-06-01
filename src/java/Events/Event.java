/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Events;

import java.security.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author UwAngelique
 */
public class Event {

    String title, description, tag, user_id, username, Event_id,action;

    public LocalDateTime datetime;

    public Event(String username, String user_id, String title, String description, LocalDateTime datetime, String tag) {
        this.username = username;
        this.user_id = user_id;
        this.title = title;
        this.description = description;
        this.datetime = datetime;
        this.tag = tag;
    }
public Event(String eventId, String user_id, String title, String description, LocalDateTime datetime, String tag, String action) {
    this.Event_id = eventId;
    this.user_id = user_id;
    this.title = title;
    this.description = description;
    this.datetime = datetime;
    this.tag = tag;
    this.action = action;
}

   public Event() {

    }

    public String getUsername() {
        return username;
    }

    public String getEvent_id() {
        return Event_id;
    }

    public void setEvent_id(String Event_id) {
        this.Event_id = Event_id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDatetime() {
        return datetime;
    }

    public void setDatetimeStr(LocalDateTime datetime) {
        this.datetime = datetime;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
}

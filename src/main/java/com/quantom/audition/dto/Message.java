package com.quantom.audition.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class Message {

    private String from;
    private String to;
    private String text;

    public String getFrom() {
        return from;
    }
    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }
    public void setTo(String to) {
        this.to = to;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
}
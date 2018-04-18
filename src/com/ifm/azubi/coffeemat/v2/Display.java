package com.ifm.azubi.coffeemat.v2;

public class Display {
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    private String message = "";
    public void output() {
        System.out.println("**DISPLAY: "+getMessage());
    }
}

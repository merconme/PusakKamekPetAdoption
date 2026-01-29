package com.pusakkamek.model;

public class Donation {
    private int id;
    private String donorName;
    private String email;
    private double amount;
    private String message;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
}

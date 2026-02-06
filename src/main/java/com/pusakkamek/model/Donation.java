package com.pusakkamek.model;

import java.sql.Timestamp;

public class Donation {
    private int id;
    private Integer userId; // can be null
    private String donorName;
    private String donorEmail;
    private String donorPhone;
    private double amount;
    private String method;   // "QR" or "FPX"
    private String bank;     // optional
    private String note;     // optional
    private String status;   // PENDING, PAID (optional future)
    private Timestamp createdAt;

    public Donation() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }

    public String getDonorEmail() { return donorEmail; }
    public void setDonorEmail(String donorEmail) { this.donorEmail = donorEmail; }

    public String getDonorPhone() { return donorPhone; }
    public void setDonorPhone(String donorPhone) { this.donorPhone = donorPhone; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getBank() { return bank; }
    public void setBank(String bank) { this.bank = bank; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

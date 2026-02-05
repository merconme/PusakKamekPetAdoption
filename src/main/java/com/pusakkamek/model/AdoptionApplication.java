package com.pusakkamek.model;

import java.sql.Timestamp;

public class AdoptionApplication {

    private int id;
    private int petId;
    private int userId;

    private String fullName;
    private String phone;
    private String email;
    private String address;
    private String reason;

    private String status;
    private Timestamp createdAt;

    // ✅ Extra field for history page (JOIN pets table)
    private String petName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPetId() { return petId; }
    public void setPetId(int petId) { this.petId = petId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }
}

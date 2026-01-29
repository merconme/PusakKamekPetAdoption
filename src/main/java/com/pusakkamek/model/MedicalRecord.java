/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// MedicalRecord.java
package com.pusakkamek.model;

public class MedicalRecord {
    private int id;
    private int petId;
    private String vaccine;
    private String date;
    private String status;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPetId() { return petId; }
    public void setPetId(int petId) { this.petId = petId; }

    public String getVaccine() { return vaccine; }
    public void setVaccine(String vaccine) { this.vaccine = vaccine; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

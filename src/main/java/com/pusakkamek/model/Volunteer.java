/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.model;

public class Volunteer {
    private int id;
    private String name;
    private String email;
    private int age;
    private String role;
    private String availability;

    // Constructors
    public Volunteer() {}

    public Volunteer(int id, String name, String email, int age, String role, String availability) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.age = age;
        this.role = role;
        this.availability = availability;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }
}


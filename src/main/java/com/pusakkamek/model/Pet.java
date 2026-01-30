package com.pusakkamek.model;

public class Pet {
    private int id;
    private String name;
    private String species;
    private String breed;
    private int age;
    private String vaccinationStatus;
    private String condition;
    private String neutered;
    private String color;
    private String imageUrl;

    public Pet(int id, String name, String species, String breed, int age,
               String vaccinationStatus, String condition, String neutered,
               String color, String imageUrl) {
        this.id = id;
        this.name = name;
        this.species = species;
        this.breed = breed;
        this.age = age;
        this.vaccinationStatus = vaccinationStatus;
        this.condition = condition;
        this.neutered = neutered;
        this.color = color;
        this.imageUrl = imageUrl;
    }

    public Pet(String name, String species, String breed, int age,
               String vaccinationStatus, String condition, String neutered,
               String color, String imageUrl) {
        this(0, name, species, breed, age, vaccinationStatus, condition, neutered, color, imageUrl);
    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getSpecies() { return species; }
    public String getBreed() { return breed; }
    public int getAge() { return age; }
    public String getVaccinationStatus() { return vaccinationStatus; }
    public String getCondition() { return condition; }
    public String getNeutered() { return neutered; }
    public String getColor() { return color; }
    public String getImageUrl() { return imageUrl; }
}

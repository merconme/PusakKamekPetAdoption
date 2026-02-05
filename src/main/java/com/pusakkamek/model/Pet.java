package com.pusakkamek.model;

public class Pet {
    private int id;
    private String species;
    private String name;
    private String breed;
    private int age;
    private String vaccinationStatus;
    private String condition;
    private String neutered;
    private String color;
    private String imageUrl;
    private String status; // AVAILABLE / ADOPTED

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSpecies() { return species; }
    public void setSpecies(String species) { this.species = species; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getVaccinationStatus() { return vaccinationStatus; }
    public void setVaccinationStatus(String vaccinationStatus) { this.vaccinationStatus = vaccinationStatus; }

    public String getCondition() { return condition; }
    public void setCondition(String condition) { this.condition = condition; }

    public String getNeutered() { return neutered; }
    public void setNeutered(String neutered) { this.neutered = neutered; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

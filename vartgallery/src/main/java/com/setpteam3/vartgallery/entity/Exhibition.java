package com.setpteam3.vartgallery.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "exhibition")
public class Exhibition {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "expo_time_start")
    private LocalDateTime expoTimeStart;

    @Column(name = "expo_time_end")
    private LocalDateTime expoTimeEnd;

    @Column(name = "expo_space")
    private String expoSpace;

    @Column(name = "image")
    private String image;

    @Column(name = "description")
    private String description;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @Transient
    private String status;

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDateTime getExpoTimeStart() {
        return expoTimeStart;
    }

    public void setExpoTimeStart(LocalDateTime expoTimeStart) {
        this.expoTimeStart = expoTimeStart;
    }

    public LocalDateTime getExpoTimeEnd() {
        return expoTimeEnd;
    }

    public void setExpoTimeEnd(LocalDateTime expoTimeEnd) {
        this.expoTimeEnd = expoTimeEnd;
    }

    public String getExpoSpace() {
        return expoSpace;
    }

    public void setExpoSpace(String expoSpace) {
        this.expoSpace = expoSpace;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
    }

    // toString method
    @Override
    public String toString() {
        return "Exhibition{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", expoTimeStart=" + expoTimeStart +
                ", expoTimeEnd=" + expoTimeEnd +
                ", expoSpace='" + expoSpace + '\'' +
                ", image='" + image + '\'' +
                ", description='" + description + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}

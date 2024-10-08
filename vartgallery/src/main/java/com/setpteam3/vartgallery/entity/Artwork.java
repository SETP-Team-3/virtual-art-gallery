package com.setpteam3.vartgallery.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@NamedEntityGraph(name = "Artwork.detail", attributeNodes = {@NamedAttributeNode("genres")})
@Table(name = "artwork")
public class Artwork {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "artist_id")
    private User artistId;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "dimension")
    private String dimension;

    @Column(name = "image")
    private String image;

    @Column(name = "like_count")
    private int likeCount;

    @Column(name = "view_count")
    private int viewCount;

    @Column(name = "status")
    private String status;

    @Column(name = "price", precision = 10, scale = 2)
    private BigDecimal price;

    @ManyToOne
    @JoinColumn(name = "buyer_id")
    private User buyerId;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "active")
    private String active = "Y";

    @ManyToMany
    @JoinTable(
            name = "join_artwork_genre",
            joinColumns = @JoinColumn(name = "artwork_id"),
            inverseJoinColumns = @JoinColumn(name = "genre_id")
    )
    @JsonManagedReference
    private Set<Genre> genres = new HashSet<>();

    @Transient
    private boolean liked;

    @Version
    private Integer version;

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getArtistId() {
        return artistId;
    }

    public void setArtistId(User artistId) {
        this.artistId = artistId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDimension() {
        return dimension;
    }

    public void setDimension(String dimension) {
        this.dimension = dimension;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public User getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(User buyerId) {
        this.buyerId = buyerId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Set<Genre> getGenres() {
        return genres;
    }

    public void setGenres(Set<Genre> genres) {
        this.genres = genres;
    }

    public boolean isLiked() {
        return liked;
    }

    public boolean getLiked() {
        return liked;
    }

    public void setLiked(boolean liked) {
        this.liked = liked;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // toString method
    @Override
    public String toString() {
        return "Artwork{" +
                "id=" + id +
                ", artistId=" + artistId +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", dimension='" + dimension + '\'' +
                ", image='" + image + '\'' +
                ", likeCount=" + likeCount +
                ", viewCount=" + viewCount +
                ", status='" + status + '\'' +
                ", price=" + price +
                ", buyerId=" + buyerId +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", active='" + active + '\'' +
                ", genres=" + genres +
                ", liked=" + liked +
                ", version=" + version +
                '}';
    }
}

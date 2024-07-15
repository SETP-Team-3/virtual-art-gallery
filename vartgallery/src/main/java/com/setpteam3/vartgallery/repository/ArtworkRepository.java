package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.Artwork;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArtworkRepository extends JpaRepository<Artwork, Integer> {
    @Query("SELECT a FROM Artwork a ORDER BY a.createdAt DESC")
    List<Artwork> findTopByOrderByCreatedAtDesc(int limit);
}

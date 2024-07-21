package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.Artwork;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArtworkRepository extends JpaRepository<Artwork, Integer> {
    @Query("SELECT a FROM Artwork a ORDER BY a.createdAt DESC")
    Page<Artwork> findTopByOrderByCreatedAtDesc(Pageable pageable);

    @Query("SELECT a FROM Artwork a JOIN a.artistId u LEFT JOIN a.genres g WHERE " +
            "(:title IS NULL OR LOWER(a.title) LIKE %:title%) AND " +
            "(:artist IS NULL OR LOWER(u.name) LIKE %:artist%) AND " +
            "(:minPrice IS NULL OR a.price >= :minPrice) AND " +
            "(:maxPrice IS NULL OR a.price <= :maxPrice) AND " +
            "(:genreIds IS NULL OR g.id IN :genreIds)")
    Page<Artwork> findArtworksByFiltersWithGenres(
            @Param("title") String title,
            @Param("artist") String artist,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            @Param("genreIds") List<Integer> genreIds,
            Pageable pageable);

    @Query("SELECT a FROM Artwork a JOIN a.artistId u WHERE " +
            "(:title IS NULL OR LOWER(a.title) LIKE %:title%) AND " +
            "(:artist IS NULL OR LOWER(u.name) LIKE %:artist%) AND " +
            "(:minPrice IS NULL OR a.price >= :minPrice) AND " +
            "(:maxPrice IS NULL OR a.price <= :maxPrice)")
    Page<Artwork> findArtworksByFiltersWithoutGenres(
            @Param("title") String title,
            @Param("artist") String artist,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            Pageable pageable);

    default Page<Artwork> findArtworksByFilters(
            String title,
            String artist,
            Double minPrice,
            Double maxPrice,
            List<Integer> genreIds,
            Pageable pageable) {
        if (genreIds == null || genreIds.isEmpty()) {
            return findArtworksByFiltersWithoutGenres(title, artist, minPrice, maxPrice, pageable);
        } else {
            return findArtworksByFiltersWithGenres(title, artist, minPrice, maxPrice, genreIds, pageable);
        }
    }
}

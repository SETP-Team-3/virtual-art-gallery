package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArtworkRepository extends JpaRepository<Artwork, Integer> {
    @Query("SELECT a FROM Artwork a WHERE a.active = :active ORDER BY a.createdAt DESC")
    Page<Artwork> findTopByOrderByCreatedAtDesc(@Param("active") String active, Pageable pageable);

    @Query(value = "SELECT * FROM artwork WHERE active = ?1 ORDER BY RAND() LIMIT ?2", nativeQuery = true)
    List<Artwork> findRandomArtworks(String active, int limit);

    List<Artwork> findByActive(String active);

    @Query("SELECT a FROM Artwork a JOIN a.artistId u LEFT JOIN a.genres g WHERE a.active = :active AND " +
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
            @Param("active") String active,
            Pageable pageable);

    @Query("SELECT a FROM Artwork a JOIN a.artistId u WHERE a.active = :active AND " +
            "(:title IS NULL OR LOWER(a.title) LIKE %:title%) AND " +
            "(:artist IS NULL OR LOWER(u.name) LIKE %:artist%) AND " +
            "(:minPrice IS NULL OR a.price >= :minPrice) AND " +
            "(:maxPrice IS NULL OR a.price <= :maxPrice)")
    Page<Artwork> findArtworksByFiltersWithoutGenres(
            @Param("title") String title,
            @Param("artist") String artist,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            @Param("active") String active,
            Pageable pageable);

    default Page<Artwork> findArtworksByFilters(
            String title,
            String artist,
            Double minPrice,
            Double maxPrice,
            List<Integer> genreIds,
            String active,
            Pageable pageable) {
        if (genreIds == null || genreIds.isEmpty()) {
            return findArtworksByFiltersWithoutGenres(title, artist, minPrice, maxPrice, active, pageable);
        } else {
            return findArtworksByFiltersWithGenres(title, artist, minPrice, maxPrice, genreIds, active, pageable);
        }
    }

    @Query("SELECT a FROM Artwork a WHERE a.artistId.id = :artistId AND a.active = :active")
    Page<Artwork> findByArtistId(@Param("artistId") int artistId, @Param("active") String active, Pageable pageable);

    List<Artwork> findArtworksByArtistIdAndStatus(User artist, String status);

    @Query("SELECT a FROM Artwork a WHERE a.id IN (:ids) AND a.active = :active")
    List<Artwork> findByIds(@Param("ids") List<Integer> ids, @Param("active") String active);
}

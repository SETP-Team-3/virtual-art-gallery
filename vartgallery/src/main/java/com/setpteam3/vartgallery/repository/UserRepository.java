package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);

    Page<User> findByRole(@Param("role") String role, Pageable pageable);

    @Query("SELECT u FROM User u LEFT JOIN u.genres g WHERE u.role = 'artist' AND " +
            "(:name IS NULL OR LOWER(u.name) LIKE %:name%) AND " +
            "(:genreIds IS NULL OR g.id IN :genreIds)")
    Page<User> findArtistsByFiltersWithGenres(
            @Param("name") String name,
            @Param("genreIds") List<Integer> genreIds,
            Pageable pageable);

    @Query("SELECT u FROM User u WHERE u.role = 'artist' AND " +
            "(:name IS NULL OR LOWER(u.name) LIKE %:name%)")
    Page<User> findArtistsByFiltersWithoutGenres(
            @Param("name") String name,
            Pageable pageable);

    default Page<User> findArtistsByFilters(
            String name,
            List<Integer> genreIds,
            Pageable pageable) {
        if (genreIds == null || genreIds.isEmpty()) {
            return findArtistsByFiltersWithoutGenres(name, pageable);
        } else {
            return findArtistsByFiltersWithGenres(name, genreIds, pageable);
        }
    }
}

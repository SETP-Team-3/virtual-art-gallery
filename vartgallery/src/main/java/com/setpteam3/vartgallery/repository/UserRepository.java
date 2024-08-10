package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);

    @Query("SELECT u FROM User u WHERE u.email = :email AND u.active = 'Y'")
    User findActiveUserByEmail(@Param("email") String email);

    Page<User> findByRole(@Param("role") String role, Pageable pageable);

    List<User> findByActive(String active);

    Page<User> findByRoleAndActive(String role, String active, Pageable pageable);

    @Query("SELECT u FROM User u LEFT JOIN u.genres g WHERE u.role = 'artist' AND u.active = :active AND " +
            "(:name IS NULL OR LOWER(u.name) LIKE %:name%) AND " +
            "(:genreIds IS NULL OR g.id IN :genreIds)")
    Page<User> findArtistsByFiltersWithGenres(
            @Param("name") String name,
            @Param("genreIds") List<Integer> genreIds,
            @Param("active") String active,
            Pageable pageable);

    @Query("SELECT u FROM User u WHERE u.role = 'artist' AND u.active = :active AND " +
            "(:name IS NULL OR LOWER(u.name) LIKE %:name%)")
    Page<User> findArtistsByFiltersWithoutGenres(
            @Param("name") String name,
            @Param("active") String active,
            Pageable pageable);

    default Page<User> findArtistsByFilters(
            String name,
            List<Integer> genreIds,
            String active,
            Pageable pageable) {
        if (genreIds == null || genreIds.isEmpty()) {
            return findArtistsByFiltersWithoutGenres(name, active, pageable);
        } else {
            return findArtistsByFiltersWithGenres(name, genreIds, active, pageable);
        }
    }
}

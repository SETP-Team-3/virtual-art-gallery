package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.PendingArtwork;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PendingArtworkRepository extends JpaRepository<PendingArtwork, Integer> {

}

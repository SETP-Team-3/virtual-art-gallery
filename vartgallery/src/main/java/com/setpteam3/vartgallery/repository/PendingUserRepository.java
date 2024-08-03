package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.PendingUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PendingUserRepository extends JpaRepository<PendingUser, Integer> {

}

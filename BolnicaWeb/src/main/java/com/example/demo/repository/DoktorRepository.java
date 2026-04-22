package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Doktor;

@Repository
public interface DoktorRepository extends JpaRepository<Doktor, Integer> {

	boolean existsByBrojLicence(String brojLicence);
}

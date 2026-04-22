package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Recept;

@Repository
public interface ReceptRepository extends JpaRepository<Recept, Integer> {
}

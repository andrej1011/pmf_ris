package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Dijagnoza;

@Repository
public interface DijagnozaRepository extends JpaRepository<Dijagnoza, String> {
}

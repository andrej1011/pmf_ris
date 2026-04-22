package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Lek;

@Repository
public interface LekRepository extends JpaRepository<Lek, Integer> {
}

package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Odeljenje;

@Repository
public interface OdeljenjeRepository extends JpaRepository<Odeljenje, Integer> {
}

package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Doktor;
import model.Termin;

@Repository
public interface TerminRepository extends JpaRepository<Termin, Integer> {

	List<Termin> findByDoktorAndDostupan(Doktor doktor, byte dostupan);
}

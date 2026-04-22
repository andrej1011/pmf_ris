package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Pacijent;

@Repository
public interface PacijentRepository extends JpaRepository<Pacijent, Integer> {

	Pacijent findByJmbg(String jmbg);

	boolean existsByJmbg(String jmbg);
	
}

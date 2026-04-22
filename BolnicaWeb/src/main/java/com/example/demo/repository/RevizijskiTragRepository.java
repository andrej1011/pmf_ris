package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.RevizijskiTrag;

@Repository
public interface RevizijskiTragRepository extends JpaRepository<RevizijskiTrag, Integer> {

	List<RevizijskiTrag> findAllByOrderByDatumDesc();

	List<RevizijskiTrag> findByAkcijaStartingWithOrderByDatumDesc(String prefix);
}

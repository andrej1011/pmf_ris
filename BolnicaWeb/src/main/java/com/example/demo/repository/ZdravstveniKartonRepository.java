package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.ZdravstveniKarton;

@Repository
public interface ZdravstveniKartonRepository extends JpaRepository<ZdravstveniKarton, Integer> {
}

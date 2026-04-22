package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Doktor;
import model.Pacijent;
import model.ZahtevZaPregled;

@Repository
public interface ZahtevZaPregledRepository extends JpaRepository<ZahtevZaPregled, Integer> {

	List<ZahtevZaPregled> findByPacijentOrderByDatumZahtevaDesc(Pacijent pacijent);

	List<ZahtevZaPregled> findByDoktorAndStatusOrderByDatumZahtevaDesc(Doktor doktor, String status);
	
}

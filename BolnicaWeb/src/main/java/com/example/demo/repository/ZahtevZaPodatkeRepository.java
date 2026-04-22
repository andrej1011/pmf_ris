package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Korisnik;
import model.ZahtevZaPodatke;

@Repository
public interface ZahtevZaPodatkeRepository extends JpaRepository<ZahtevZaPodatke, Integer> {

	List<ZahtevZaPodatke> findAllByOrderByDatumZahtevaDesc();

	List<ZahtevZaPodatke> findByKorisnikOrderByDatumZahtevaDesc(Korisnik korisnik);
}

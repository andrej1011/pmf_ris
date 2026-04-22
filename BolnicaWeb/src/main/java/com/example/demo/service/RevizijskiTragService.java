package com.example.demo.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.KorisnikRepository;
import com.example.demo.repository.RevizijskiTragRepository;

import jakarta.transaction.Transactional;
import model.Korisnik;
import model.RevizijskiTrag;

@Service
public class RevizijskiTragService {

	@Autowired
	RevizijskiTragRepository revizijskiTragRepository;

	@Autowired
	KorisnikRepository korisnikRepository;

	@Transactional
	public void log(String korisnickoIme, String akcija, String tipEntiteta, Integer idEntiteta) {
		try {
			Korisnik korisnik = korisnikRepository.findByKorisnickoIme(korisnickoIme);
			if (korisnik == null)
				return;

			RevizijskiTrag trag = new RevizijskiTrag();
			trag.setKorisnik(korisnik);
			trag.setAkcija(akcija);
			trag.setDatum(new Date());
			trag.setIpAdresa(""); // localhsot izbaci IP
			trag.setObjekat(tipEntiteta != null ? tipEntiteta : "");
			trag.setIdObjekta(idEntiteta != null ? idEntiteta : 0);

			if (korisnik.getPacijent() != null) {
				trag.setIdPacijenta(korisnik.getPacijent().getIdPacijent());
			}

			revizijskiTragRepository.save(trag);
		} catch (Exception e) {
			// Audit log ne sme da prekine glavnu akciju
			e.printStackTrace();
		}
	}

	// Overload bez entiteta
	public void log(String korisnickoIme, String akcija) {
		log(korisnickoIme, akcija, null, null);
	}

	// Overload sa IP 
	public void log(String korisnickoIme, String akcija, String ip) {
		log(korisnickoIme, akcija, null, null);
	}


	public List<RevizijskiTrag> getSvuReviziju() {
		return revizijskiTragRepository.findAllByOrderByDatumDesc();
	}

	public List<RevizijskiTrag> getRevizijuPoKategoriji(String prefix) {
		return revizijskiTragRepository.findByAkcijaStartingWithOrderByDatumDesc(prefix);
	}

}

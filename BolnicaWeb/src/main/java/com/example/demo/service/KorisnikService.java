package com.example.demo.service;

import java.text.Normalizer;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.repository.KorisnikRepository;
import com.example.demo.security.CustomUserDetail;

import model.Korisnik;

@Service
public class KorisnikService implements UserDetailsService {

	@Autowired
	KorisnikRepository korisnikRepository;

	// ── UserDetailsService za JSP/session autentifikaciju ────────

	@Override
	public UserDetails loadUserByUsername(String korisnickoIme) throws UsernameNotFoundException {
		Korisnik korisnik = korisnikRepository.findByKorisnickoIme(korisnickoIme);
		if (korisnik == null) {
			throw new UsernameNotFoundException("Korisnik nije pronadjen: " + korisnickoIme);
		}
		if (korisnik.getAktivan() == 0) {
			throw new UsernameNotFoundException("Nalog je deaktiviran: " + korisnickoIme);
		}
		return new CustomUserDetail(korisnik);
	}

	// ── Generisanje korisnickog imena ────────────────────────────

	/**
	 * Generise korisnicko ime u formatu imeprezime+3cifre. 
	 * Uklanja dijakritike: c->c, c->c, s->s, dj->d, z->z. 
	 * Pokusava dok ne nadje jedinstveno.
	 */

	public String generisiKorisnickoIme(String ime, String prezime) {
		String baza = ukloniDijakritike(ime) + ukloniDijakritike(prezime);
		Random rand = new Random();
		String korisnickoIme;
		do {
			korisnickoIme = baza + (rand.nextInt(900) + 100);
		} while (korisnikRepository.findByKorisnickoIme(korisnickoIme) != null);
		return korisnickoIme;
	}


	private String ukloniDijakritike(String s) {
		if (s == null)
			return "";
		// Rucno mapiraj đ/Đ
		s = s.replace('\u0111', 'd').replace('\u0110', 'd'); // đ, Đ
		s = Normalizer.normalize(s, Normalizer.Form.NFD);
		s = s.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
		return s.toLowerCase().replaceAll("[^a-z]", "");
	}
	
}

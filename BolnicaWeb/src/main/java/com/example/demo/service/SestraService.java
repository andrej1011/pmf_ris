package com.example.demo.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.dto.PacijentDTO;
import com.example.demo.repository.DoktorRepository;
import com.example.demo.repository.KorisnikRepository;
import com.example.demo.repository.PacijentRepository;
import com.example.demo.repository.PregledRepository;
import com.example.demo.repository.TerminRepository;
import com.example.demo.repository.ZdravstveniKartonRepository;
import com.example.demo.security.GeneratorLozinke;

import jakarta.transaction.Transactional;
import model.Korisnik;
import model.Pacijent;
import model.Pregled;
import model.ZdravstveniKarton;

@Service
public class SestraService {

	@Autowired
	PacijentRepository pacijentRepository;
	@Autowired
	KorisnikRepository korisnikRepository;
	@Autowired
	ZdravstveniKartonRepository zdravstveniKartonRepository;
	@Autowired
	PregledRepository pregledRepository;
	@Autowired
	DoktorRepository doktorRepository;
	@Autowired
	TerminRepository terminRepository;

	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	GeneratorLozinke generatorLozinke;

	@Autowired
	RevizijskiTragService revizijskiTragService;
	@Autowired
	KorisnikService korisnikService;

	public boolean postojiJmbg(String jmbg) {
		return pacijentRepository.existsByJmbg(jmbg);
	}

	@Transactional
	public String[] kreirajPacijenta(PacijentDTO dto) {
		Pacijent pacijent = new Pacijent();
		pacijent.setIme(dto.getIme());
		pacijent.setImeOca(dto.getImeOca());
		pacijent.setPrezime(dto.getPrezime());
		pacijent.setJmbg(dto.getJmbg());
		pacijent.setDatumRodjenja(dto.getDatumRodjenja());
		pacijent.setPol(dto.getPol());
		pacijent.setAdresa(dto.getAdresa() == null || dto.getAdresa().isBlank() ? null : dto.getAdresa());
		pacijent.setEmail(dto.getEmail() == null || dto.getEmail().isBlank() ? null : dto.getEmail());
		pacijent.setLbo(dto.getLbo() == null || dto.getLbo().isBlank() ? null : dto.getLbo());
		pacijent.setImeOca(dto.getImeOca() == null || dto.getImeOca().isBlank() ? null : dto.getImeOca());
		boolean imaLbo = dto.getLbo() != null && !dto.getLbo().isBlank();
		pacijent.setOsiguran(imaLbo && dto.isOsiguran() ? (byte) 1 : (byte) 0);
		pacijent.setAktivan((byte) 1);
		pacijent = pacijentRepository.save(pacijent);

		ZdravstveniKarton karton = new ZdravstveniKarton();
		karton.setPacijent(pacijent);
		karton.setDatumKreiranja(new Date());
		karton.setKrvnaGrupa(dto.getKrvnaGrupa() == null || dto.getKrvnaGrupa().isBlank() ? null : dto.getKrvnaGrupa());
		karton.setAlergije(dto.getAlergije() == null || dto.getAlergije().isBlank() ? null : dto.getAlergije());
		karton.setHronicanBolesnik(dto.isHronicanBolesnik() ? (byte) 1 : (byte) 0);
		karton.setNapomena(
				dto.getNapomenKarton() == null || dto.getNapomenKarton().isBlank() ? null : dto.getNapomenKarton());
		zdravstveniKartonRepository.save(karton);

		String korisnickoIme = korisnikService.generisiKorisnickoIme(dto.getIme(), dto.getPrezime());
		String lozinka = generatorLozinke.generisiLozinku();

		Korisnik korisnik = new Korisnik();
		korisnik.setKorisnickoIme(korisnickoIme);
		korisnik.setLozinka(passwordEncoder.encode(lozinka));
		korisnik.setUloga("PACIJENT");
		korisnik.setPacijent(pacijent);
		korisnik.setDoktor(null);
		korisnik.setAktivan((byte) 1);
		korisnik.setDatumKreiranja(new Date());
		korisnikRepository.save(korisnik);

		revizijskiTragService.log(trenutniKorisnik(), "KORISNIK_KREIRAN_NALOG_PACIJENTA", null,
				pacijent.getIdPacijent());

		return new String[] { korisnickoIme, lozinka };
	}

	public Pacijent findByJmbg(String jmbg) {
		return pacijentRepository.findByJmbg(jmbg);
	}

	@org.springframework.transaction.annotation.Transactional
	public List<Pregled> getZakazaniPregledi(Pacijent pacijent) {
		List<Pregled> lista = pregledRepository.findByPacijentAndStatus(pacijent, "ZAKAZAN");
		lista.forEach(p -> {
			if (p.getDoktor() != null)
				p.getDoktor().getIme();
		});
		return lista;
	}

	@Transactional
	public boolean prijaviNaPregled(Integer idPregled) {
		try {
			Pregled pregled = pregledRepository.findById(idPregled).get();

			pregled.setStatus("U_TOKU");
			pregledRepository.save(pregled);

			if (pregled.getZahtevZaPregleds() != null && !pregled.getZahtevZaPregleds().isEmpty()) {
				model.ZahtevZaPregled zahtev = pregled.getZahtevZaPregleds().get(0);
				zahtev.setNapomena("Prvi pregled");
				zahtev.setStatus("ODOBREN");
				zahtev.setDatumObrade(new java.util.Date());
			}

			revizijskiTragService.log(trenutniKorisnik(), "PREGLED_PRIJAVLJEN", "PREGLED", idPregled);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<model.Doktor> getSveDoktore() {
		return doktorRepository.findAll();
	}

	public List<model.Termin> getSlobodneTermine(Integer idDoktora) {
		model.Doktor d = doktorRepository.findById(idDoktora).get();
		return terminRepository.findByDoktorAndDostupan(d, (byte) 1);
	}

	@Transactional
	public boolean zakaziPregled(Pacijent pacijent, Integer idDoktora, Integer idTermina, String napomena) {
		try {
			model.Doktor doktor = doktorRepository.findById(idDoktora).get();
			model.Termin termin = terminRepository.findById(idTermina).get();

			Pregled pregled = new Pregled();
			pregled.setPacijent(pacijent);
			pregled.setDoktor(doktor);
			pregled.setTermin(termin);
			pregled.setDatumVreme(termin.getDatumVreme());
			pregled.setStatus("U_TOKU");
			pregledRepository.save(pregled);

			termin.setDostupan((byte) 0);
			terminRepository.save(termin);

			revizijskiTragService.log(trenutniKorisnik(), "PREGLED_ZAKAZAN_SESTRA", "PREGLED", pregled.getIdPregled());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	private String trenutniKorisnik() {
		return SecurityContextHolder.getContext().getAuthentication().getName();
	}

}

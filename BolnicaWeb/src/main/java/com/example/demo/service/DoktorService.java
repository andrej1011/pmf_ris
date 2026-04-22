package com.example.demo.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.demo.dto.NalazDTO;
import com.example.demo.repository.DijagnozaRepository;
import com.example.demo.repository.DoktorRepository;
import com.example.demo.repository.KorisnikRepository;
import com.example.demo.repository.LekRepository;
import com.example.demo.repository.PregledRepository;
import com.example.demo.repository.ReceptRepository;
import com.example.demo.repository.TerminRepository;
import com.example.demo.repository.ZahtevZaPregledRepository;

import jakarta.transaction.Transactional;
import model.Dijagnoza;
import model.Doktor;
import model.Korisnik;
import model.Pregled;
import model.Recept;
import model.Termin;
import model.ZahtevZaPregled;

@Service
public class DoktorService {

	@Autowired
	KorisnikRepository korisnikRepository;
	@Autowired
	DoktorRepository doktorRepository;
	@Autowired
	PregledRepository pregledRepository;
	@Autowired
	ZahtevZaPregledRepository zahtevZaPregledRepository;
	@Autowired
	TerminRepository terminRepository;
	@Autowired
	DijagnozaRepository dijagnozaRepository;
	@Autowired
	LekRepository lekRepository;
	@Autowired
	ReceptRepository receptRepository;
	@Autowired
	RevizijskiTragService revizijskiTragService;

	// ── Zahtevi ──────────────────────────────────────────────────

	public List<ZahtevZaPregled> getCekajuciZahtevi() {
		return zahtevZaPregledRepository.findByDoktorAndStatusOrderByDatumZahtevaDesc(trenutniDoktor(), "CEKA");
	}

	@Transactional
	public boolean odobriZahtev(Integer idZahtev) {
		try {
			ZahtevZaPregled zahtev = zahtevZaPregledRepository.findById(idZahtev).get();

			Pregled pregled = new Pregled();
			pregled.setPacijent(zahtev.getPacijent());
			pregled.setDoktor(zahtev.getDoktor());
			pregled.setTermin(zahtev.getTermin());
			pregled.setDatumVreme(zahtev.getTermin().getDatumVreme());
			pregled.setStatus("ZAKAZAN");
			pregled = pregledRepository.save(pregled);

			Termin termin = zahtev.getTermin();
			termin.setDostupan((byte) 0);
			terminRepository.save(termin);

			zahtev.setStatus("ODOBREN");
			zahtev.setPregled(pregled);
			zahtev.setDatumObrade(new Date());
			zahtevZaPregledRepository.save(zahtev);

			revizijskiTragService.log(trenutniKorisnik(), "ZAHTEV_ZA_PREGLED_ODOBREN", null, idZahtev);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Transactional
	public boolean odbijZahtev(Integer idZahtev, String komentar) {
		try {
			ZahtevZaPregled zahtev = zahtevZaPregledRepository.findById(idZahtev).get();
			zahtev.setStatus("ODBIJEN");
			zahtev.setKomentarDoktora(komentar);
			zahtev.setDatumObrade(new Date());
			zahtevZaPregledRepository.save(zahtev);

			revizijskiTragService.log(trenutniKorisnik(), "ZAHTEV_ZA_PREGLED_ODBIJEN", null, idZahtev);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ── Novi pregled — pronalaženje po JMBG/LBO ─────────────────

	public String[] zapocniPregled(String brojUnos) {
		try {
			Doktor doktor = trenutniDoktor();
			Pregled pregled = null;

			if (brojUnos == null || brojUnos.isBlank()) {
				return new String[] { "Unos ne sme biti prazan.", null };
			}

			String broj = brojUnos.trim();

			if (broj.length() == 13) {
				// JMBG
				pregled = pregledRepository.findByDoktorAndPacijentJmbgAndStatus(doktor, broj, "ZAKAZAN");
				if (pregled == null) {
					pregled = pregledRepository.findByDoktorAndPacijentJmbgAndStatus(doktor, broj, "U_TOKU");
					if (pregled != null) {
						return new String[] { null, String.valueOf(pregled.getIdPregled()) };
					}
					return new String[] { "Pacijent sa ovim JMBG-om nema zakazanog pregleda kod vas.", null };
				}
			} else if (broj.length() == 11) {
				// LBO
				pregled = pregledRepository.findByDoktorAndPacijentLboAndStatus(doktor, broj, "ZAKAZAN");
				if (pregled == null) {
					pregled = pregledRepository.findByDoktorAndPacijentLboAndStatus(doktor, broj, "U_TOKU");
					if (pregled != null) {
						return new String[] { null, String.valueOf(pregled.getIdPregled()) };
					}
					return new String[] { "Pacijent sa ovim LBO-om nema zakazanog pregleda kod vas.", null };
				}
			} else {
				return new String[] { "Neispravan unos. JMBG ima 13 cifara, LBO ima 11 cifara.", null };
			}

			// Zapocni pregled
			pregled.setStatus("U_TOKU");
			pregledRepository.save(pregled);

			revizijskiTragService.log(trenutniKorisnik(), "PREGLED_ZAPOCET", null);

			return new String[] { null, String.valueOf(pregled.getIdPregled()) };

		} catch (Exception e) {
			e.printStackTrace();
			return new String[] { "Greška pri pretrazi. Pokušajte ponovo.", null };
		}
	}

	// ── Pregledi ─────────────────────────────────────────────────

	public List<Pregled> getZakazaniPregledi() {
		return pregledRepository.findByDoktorAndStatus(trenutniDoktor(), "ZAKAZAN");
	}

	public List<Pregled> getAktivniPregledi() {
		return pregledRepository.findByDoktorAndStatus(trenutniDoktor(), "U_TOKU");
	}

	public List<Pregled> pretraziPoJmbg(String jmbg) {
		return pregledRepository.findByDoktorAndPacijentJmbgOrderByDatumVremeDesc(trenutniDoktor(), jmbg);
	}

	@Transactional
	public Pregled getPregled(Integer idPregled) {
		Pregled p = pregledRepository.findById(idPregled).get();

		if (p.getPacijent() != null && p.getPacijent().getZdravstveniKartons() != null) {
			p.getPacijent().getZdravstveniKartons().size();
		}

		if (p.getDijagnozas() != null) {
			p.getDijagnozas().size();
		}

		return p;
	}

	public List<Pregled> getStariPreglediPacijenta(Integer idPregled) {
		Pregled tekuci = pregledRepository.findById(idPregled).get();
		Doktor doktor = trenutniDoktor();

		// Bezbednosna provjera: pregled mora biti od ovog doktora
		if (tekuci.getDoktor().getIdDoktor() != doktor.getIdDoktor()) {
			return null;
		}

		return pregledRepository.findByPacijentOrderByDatumVremeDesc(tekuci.getPacijent()).stream()
				.filter(p -> p.getIdPregled() != idPregled && "ZAVRSEN".equals(p.getStatus())).toList();
	}

	public List<Dijagnoza> getSveDijagnoze() {
		return dijagnozaRepository.findAll();
	}

	public List<model.Lek> getSveLekove() {
		return lekRepository.findAll();
	}

	@Transactional
	public boolean sacuvajNalaz(NalazDTO dto) {
		try {
			Pregled pregled = pregledRepository.findById(dto.getIdPregled()).get();
			pregled.setNalaz(dto.getNalaz());
			pregled.setVremeZavrsetka(new Date());
			pregled.setStatus("ZAVRSEN");

			if (dto.getDijagnoze() != null) {
				List<Dijagnoza> dijagnoze = new ArrayList<>();
				for (String sifra : dto.getDijagnoze()) {
					dijagnozaRepository.findById(sifra).ifPresent(dijagnoze::add);
				}
				pregled.setDijagnozas(dijagnoze);
			}

			pregledRepository.save(pregled);

			if (dto.getLekovi() != null) {
				for (int i = 0; i < dto.getLekovi().size(); i++) {
					if (dto.getLekovi().get(i) == null || dto.getLekovi().get(i) == 0)
						continue;
					Recept recept = new Recept();
					recept.setPregled(pregled);
					recept.setLek(lekRepository.findById(dto.getLekovi().get(i)).get());
					recept.setKolicina(
							dto.getKolicine() != null && dto.getKolicine().size() > i ? dto.getKolicine().get(i) : 1);
					recept.setUputstvo(
							dto.getUputstva() != null && dto.getUputstva().size() > i ? dto.getUputstva().get(i)
									: null);
					recept.setDatumIzdavanja(new Date());
					recept.setDatumVazenja(dto.getDatumiVazenja() != null && dto.getDatumiVazenja().size() > i
							? dto.getDatumiVazenja().get(i)
							: null);
					recept.setPodignut((byte) 0);
					receptRepository.save(recept);
				}
			}

			revizijskiTragService.log(trenutniKorisnik(), "PREGLED_ZAVRSEN", null, dto.getIdPregled());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// ── Pomocna metoda ───────────────────────────────────────────

	public Doktor trenutniDoktor() {
		String korisnickoIme = SecurityContextHolder.getContext().getAuthentication().getName();
		Korisnik korisnik = korisnikRepository.findByKorisnickoIme(korisnickoIme);
		return korisnik.getDoktor();
	}

	protected String trenutniKorisnik() {
		return SecurityContextHolder.getContext().getAuthentication().getName();
	}

}

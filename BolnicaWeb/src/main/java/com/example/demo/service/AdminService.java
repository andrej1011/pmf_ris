package com.example.demo.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.demo.dto.DoktorDTO;
import com.example.demo.dto.SestraDTO;
import com.example.demo.repository.DoktorRepository;
import com.example.demo.repository.KorisnikRepository;
import com.example.demo.repository.OdeljenjeRepository;
import com.example.demo.repository.PacijentRepository;
import com.example.demo.repository.PregledRepository;
import com.example.demo.repository.RevizijskiTragRepository;
import com.example.demo.repository.ZahtevZaPodatkeRepository;
import com.example.demo.repository.ZahtevZaPregledRepository;
import com.example.demo.repository.ZdravstveniKartonRepository;
import com.example.demo.security.GeneratorLozinke;

import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import model.Doktor;
import model.Korisnik;
import model.Odeljenje;
import model.RevizijskiTrag;
import model.ZahtevZaPodatke;

@Service
public class AdminService {
	
	@Autowired
	EntityManager entityManager;
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	GeneratorLozinke generatorLozinke;
	
	@Autowired
	DoktorRepository doktorRepository;
	@Autowired
	KorisnikRepository korisnikRepository;
	@Autowired
	OdeljenjeRepository odeljenjeRepository;
	@Autowired
	PacijentRepository pacijentRepository;
	@Autowired
	PregledRepository pregledRepository;
	@Autowired
	ZdravstveniKartonRepository zdravstveniKartonRepository;
	@Autowired
	RevizijskiTragRepository revizijskiTragRepository;
	@Autowired
	ZahtevZaPodatkeRepository zahtevZaPodatkeRepository;
	@Autowired
	ZahtevZaPregledRepository zahtevZaPregledRepository;
	
	@Autowired
	KorisnikService korisnikService;
	@Autowired
	RevizijskiTragService revizijskiTragService;
	

	// ── Korisnici ────────────────────────────────────────────────

	public List<Korisnik> getSveKorisnike() {
		return korisnikRepository.findAll();
	}

	public Korisnik getKorisnikByUsername(String korisnickoIme) {
		return korisnikRepository.findByKorisnickoIme(korisnickoIme);
	}

	public List<Odeljenje> getSvaOdeljenja() {
		return odeljenjeRepository.findAll();
	}

	@Transactional
	public String[] kreirajDoktora(DoktorDTO dto) {
		Doktor doktor = new Doktor();
		doktor.setIme(dto.getIme());
		doktor.setPrezime(dto.getPrezime());
		doktor.setSpecijalizacija(dto.getSpecijalizacija());
		doktor.setBrojLicence(dto.getBrojLicence());
		doktor.setEmail(dto.getEmail() == null || dto.getEmail().isBlank() ? null : dto.getEmail());
		doktor.setAktivan((byte) 1);
		doktor.setOdeljenje(odeljenjeRepository.findById(dto.getIdOdeljenja()).get());
		doktor = doktorRepository.save(doktor);

		String korisnickoIme = korisnikService.generisiKorisnickoIme(dto.getIme(), dto.getPrezime());
		String lozinka = generatorLozinke.generisiLozinku();

		Korisnik korisnik = new Korisnik();
		korisnik.setKorisnickoIme(korisnickoIme);
		korisnik.setLozinka(passwordEncoder.encode(lozinka)); 
		korisnik.setUloga("DOKTOR");
		korisnik.setDoktor(doktor);
		korisnik.setPacijent(null);
		korisnik.setAktivan((byte) 1);
		korisnik.setDatumKreiranja(new Date());
		Korisnik sacuvan = korisnikRepository.save(korisnik);

		revizijskiTragService.log(trenutniKorisnik(), "KORISNIK_KREIRAN_NALOG_DOKTORA", null, sacuvan.getIdKorisnik());

		return new String[] { korisnickoIme, lozinka };
	}

	@Transactional
	public String[] kreirajSestru(SestraDTO dto) {
		String korisnickoIme = korisnikService.generisiKorisnickoIme(dto.getIme(), dto.getPrezime());
		String lozinka = generatorLozinke.generisiLozinku();

		Korisnik korisnik = new Korisnik();
		korisnik.setKorisnickoIme(korisnickoIme);
		korisnik.setLozinka(passwordEncoder.encode(lozinka));
		korisnik.setUloga("SESTRA");
		korisnik.setDoktor(null);
		korisnik.setPacijent(null);
		korisnik.setAktivan((byte) 1);
		korisnik.setDatumKreiranja(new Date());
		Korisnik sacuvan = korisnikRepository.save(korisnik);

		revizijskiTragService.log(trenutniKorisnik(), "KORISNIK_KREIRAN_NALOG_SESTRE", null, sacuvan.getIdKorisnik());

		return new String[] { korisnickoIme, lozinka };
	}

	// ── Lozinka ──────────────────────────────────────────────────

	@Transactional
	public boolean promeniLozinku(Integer idKorisnika, String novaLozinka) {
		try {
			Korisnik korisnik = korisnikRepository.findById(idKorisnika).get();
			korisnik.setLozinka(passwordEncoder.encode(novaLozinka));
			korisnikRepository.save(korisnik);

			revizijskiTragService.log(trenutniKorisnik(), "KORISNIK_PROMENJENA_LOZINKA", null, idKorisnika);

			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// ── GDPR ─────────────────────────────────────────────────────

	@Transactional
	public List<ZahtevZaPodatke> getSveZahteve() {
		List<ZahtevZaPodatke> lista = zahtevZaPodatkeRepository.findAllByOrderByDatumZahtevaDesc();
		lista.forEach(z -> {
			if (z.getKorisnik() != null)
				z.getKorisnik().getKorisnickoIme();
		});
		return lista;
	}

	@Transactional
	public boolean promeniStatusZahteva(Integer idZahtev, String noviStatus) {
		try {
			ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
			zahtev.setStatus(noviStatus);
			if (noviStatus.equals("ZAVRSEN")) {
				zahtev.setDatumObrade(new Date());
			}
			zahtevZaPodatkeRepository.save(zahtev);

			revizijskiTragService.log(trenutniKorisnik(), "GDPR_STATUS_" + noviStatus, null, idZahtev);

			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Transactional
	public void izveziPodatke(Integer idZahtev) throws Exception {
		ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
		model.Pacijent p = zahtev.getKorisnik().getPacijent();
		if (p.getZdravstveniKartons() != null)
			p.getZdravstveniKartons().size();
		List<model.Pregled> pregledi = pregledRepository.findByPacijentOrderByDatumVremeDesc(p);
		for (model.Pregled pr : pregledi) {
			if (pr.getDijagnozas() != null)
				pr.getDijagnozas().size();
			if (pr.getRecepts() != null)
				pr.getRecepts().size();
		}

		StringBuilder sb = new StringBuilder();
		sb.append("{\n");
		sb.append("  \"pacijent\": {\n");
		sb.append("    \"ime\": \"").append(p.getIme()).append("\",\n");
		sb.append("    \"prezime\": \"").append(p.getPrezime()).append("\",\n");
		sb.append("    \"imeOca\": \"").append(p.getImeOca() != null ? p.getImeOca() : "").append("\",\n");
		sb.append("    \"datumRodjenja\": \"").append(p.getDatumRodjenja()).append("\",\n");
		sb.append("    \"jmbg\": \"").append(p.getJmbg()).append("\",\n");
		sb.append("    \"lbo\": \"").append(p.getLbo() != null ? p.getLbo() : "").append("\",\n");
		sb.append("    \"adresa\": \"").append(p.getAdresa() != null ? p.getAdresa() : "").append("\",\n");
		sb.append("    \"email\": \"").append(p.getEmail() != null ? p.getEmail() : "").append("\",\n");
		sb.append("    \"telefon\": \"").append(p.getTelefon() != null ? p.getTelefon() : "").append("\",\n");
		sb.append("    \"pol\": \"").append(p.getPol() != null ? p.getPol() : "").append("\",\n");
		sb.append("    \"osiguran\": ").append(p.getOsiguran() == 1).append("\n");
		sb.append("  },\n");
		sb.append("  \"zdravstveniKarton\": [\n");
		if (p.getZdravstveniKartons() != null) {
			for (int i = 0; i < p.getZdravstveniKartons().size(); i++) {
				model.ZdravstveniKarton k = p.getZdravstveniKartons().get(i);
				sb.append("    {\n");
				sb.append("      \"krvnaGrupa\": \"").append(k.getKrvnaGrupa() != null ? k.getKrvnaGrupa() : "")
						.append("\",\n");
				sb.append("      \"alergije\": \"").append(k.getAlergije() != null ? k.getAlergije() : "")
						.append("\",\n");
				sb.append("      \"hronicanBolesnik\": ").append(k.getHronicanBolesnik() == 1).append(",\n");
				sb.append("      \"napomena\": \"").append(k.getNapomena() != null ? k.getNapomena() : "")
						.append("\"\n");
				sb.append("    }").append(i < p.getZdravstveniKartons().size() - 1 ? "," : "").append("\n");
			}
		}
		sb.append("  ],\n");
		sb.append("  \"pregledi\": [\n");
		for (int i = 0; i < pregledi.size(); i++) {
			model.Pregled pr = pregledi.get(i);
			sb.append("    {\n");
			sb.append("      \"idPregled\": ").append(pr.getIdPregled()).append(",\n");
			sb.append("      \"datumVreme\": \"").append(pr.getDatumVreme()).append("\",\n");
			sb.append("      \"doktor\": \"")
					.append(pr.getDoktor() != null ? pr.getDoktor().getIme() + " " + pr.getDoktor().getPrezime() : "")
					.append("\",\n");
			sb.append("      \"status\": \"").append(pr.getStatus()).append("\",\n");
			sb.append("      \"nalaz\": \"").append(pr.getNalaz() != null ? pr.getNalaz().replace("\"", "'") : "")
					.append("\",\n");
			sb.append("      \"recepti\": [");
			if (pr.getRecepts() != null && !pr.getRecepts().isEmpty()) {
				for (int j = 0; j < pr.getRecepts().size(); j++) {
					model.Recept r = pr.getRecepts().get(j);
					sb.append("{\"lek\":\"").append(r.getLek() != null ? r.getLek().getNaziv() : "").append("\"")
							.append(",\"kolicina\":").append(r.getKolicina()).append(",\"uputstvo\":\"")
							.append(r.getUputstvo() != null ? r.getUputstvo().replace("\"", "'") : "").append("\"}");
					if (j < pr.getRecepts().size() - 1)
						sb.append(",");
				}
			}
			sb.append("]\n");
			sb.append("    }").append(i < pregledi.size() - 1 ? "," : "").append("\n");
		}
		sb.append("  ]\n");
		sb.append("}");

		String fileName = "gdpr_" + idZahtev + "_" + System.currentTimeMillis() + ".json";
		String uploadDir = System.getProperty("user.home") + "/bolnica-gdpr/";
		new java.io.File(uploadDir).mkdirs();
		java.nio.file.Files.write(java.nio.file.Paths.get(uploadDir + fileName),
				sb.toString().getBytes(java.nio.charset.StandardCharsets.UTF_8));
		zahtev.setPutanjaFajla(uploadDir + fileName);
		zahtev.setStatus("ZAVRSEN");
		zahtev.setDatumObrade(new Date());
		zahtevZaPodatkeRepository.save(zahtev);
		revizijskiTragService.log(trenutniKorisnik(), "GDPR_IZVEZENO", "ZAHTEV_ZA_PODATKE", idZahtev);
	}

	@Transactional
	public void odobriUvid(Integer idZahtev) {
		ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
		zahtev.setStatus("ZAVRSEN");
		zahtev.setDatumObrade(new Date());
		zahtevZaPodatkeRepository.save(zahtev);
		revizijskiTragService.log(trenutniKorisnik(), "GDPR_UVID_ODOBREN", "ZAHTEV_ZA_PODATKE", idZahtev);
	}

	@Transactional
	public boolean obradiGdprBrisanje(Integer idZahtev) {
		try {
			ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
			// Dohvati pacijenta kroz korisnika
			model.Korisnik korisnik = zahtev.getKorisnik();
			model.Pacijent p = korisnik.getPacijent();
			int idPac = p.getIdPacijent();

			if (idPac == 0)
				return false; // zaštita ghost profila

			// Log prije brisanja
			revizijskiTragService.log(trenutniKorisnik(), "GDPR_BRISANJE", "PACIJENT", idPac);

			// Prebaci preglede na ghost pacijenta (id=0)
			pregledRepository.reassignPacijent(idPac, 0);

			// Deaktiviraj korisnika
			korisnik.setAktivan((byte) 0);
			korisnik.setPacijent(null);
			korisnikRepository.save(korisnik);

			entityManager.flush();
			entityManager.clear();

			// Obrisi pacijenta (kaskadno: ZdravstveniKarton, GdprSaglasnost)
			pacijentRepository.deleteById(idPac);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ZahtevZaPodatke getZahtevById(Integer id) {
		return zahtevZaPodatkeRepository.findById(id).get();
	}

	@Transactional
	public model.ZdravstveniKarton getKartonZaPacijenta(model.Pacijent p) {
		if (p.getZdravstveniKartons() != null && !p.getZdravstveniKartons().isEmpty()) {
			p.getZdravstveniKartons().size();
			return p.getZdravstveniKartons().get(0);
		}
		return null;
	}

	@Transactional
	public void sacuvajGdprIzmenu(Integer idZahtev, Map<String, String> params, String adminIme) {
		try {
			ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
			model.Pacijent p = zahtev.getKorisnik().getPacijent();
			StringBuilder izmene = new StringBuilder();

			if (params.containsKey("ime") && !params.get("ime").isBlank()) {
				p.setIme(params.get("ime"));
				izmene.append("ime ");
			}
			if (params.containsKey("prezime") && !params.get("prezime").isBlank()) {
				p.setPrezime(params.get("prezime"));
				izmene.append("prezime ");
			}
			if (params.containsKey("imeOca")) {
				p.setImeOca(params.get("imeOca").isBlank() ? null : params.get("imeOca"));
				izmene.append("imeOca ");
			}
			if (params.containsKey("adresa")) {
				p.setAdresa(params.get("adresa").isBlank() ? null : params.get("adresa"));
				izmene.append("adresa ");
			}
			if (params.containsKey("email")) {
				p.setEmail(params.get("email").isBlank() ? null : params.get("email"));
				izmene.append("email ");
			}
			if (params.containsKey("telefon")) {
				p.setTelefon(params.get("telefon").isBlank() ? null : params.get("telefon"));
				izmene.append("telefon ");
			}
			if (params.containsKey("pol") && !params.get("pol").isBlank()) {
				p.setPol(params.get("pol"));
				izmene.append("pol ");
			}
			pacijentRepository.save(p);

			model.ZdravstveniKarton k = getKartonZaPacijenta(p);
			if (k != null) {
				if (params.containsKey("krvnaGrupa")) {
					k.setKrvnaGrupa(params.get("krvnaGrupa").isBlank() ? null : params.get("krvnaGrupa"));
					izmene.append("krvnaGrupa ");
				}
				if (params.containsKey("alergije")) {
					k.setAlergije(params.get("alergije").isBlank() ? null : params.get("alergije"));
					izmene.append("alergije ");
				}
				if (params.containsKey("napomena")) {
					k.setNapomena(params.get("napomena").isBlank() ? null : params.get("napomena"));
					izmene.append("napomena ");
				}
				k.setHronicanBolesnik(params.containsKey("hronicanBolesnik") ? (byte) 1 : (byte) 0);
				izmene.append("hronicanBolesnik ");
				zdravstveniKartonRepository.save(k);
			}

			zahtev.setStatus("ZAVRSEN");
			zahtev.setDatumObrade(new Date());
			zahtevZaPodatkeRepository.save(zahtev);

			revizijskiTragService.log(adminIme, "GDPR_IZMENA", "PACIJENT", p.getIdPacijent());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPoslednjeIzmene(Integer idZahtev) {
		List<model.RevizijskiTrag> lista = revizijskiTragRepository
				.findByAkcijaStartingWithOrderByDatumDesc("GDPR_ISPRAVKA");
		if (!lista.isEmpty()) {
			String akcija = lista.get(0).getAkcija();
			return akcija.contains(":") ? akcija.substring(akcija.indexOf(":") + 1) : akcija;
		}
		return "-";
	}

	// ── Revizija ─────────────────────────────────────────────────

	public List<RevizijskiTrag> getSvuReviziju() {
		return revizijskiTragRepository.findAllByOrderByDatumDesc();
	}

	public List<RevizijskiTrag> getRevizijuPoKategoriji(String kategorija) {
		return revizijskiTragRepository.findByAkcijaStartingWithOrderByDatumDesc(kategorija);
	}

	// ── Pomoćne metode ───────────────────────────────────────────
	private String trenutniKorisnik() {
		return SecurityContextHolder.getContext().getAuthentication().getName();
	}
}

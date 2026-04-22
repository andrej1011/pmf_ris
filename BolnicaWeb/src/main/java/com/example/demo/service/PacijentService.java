package com.example.demo.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.example.demo.dto.ZahtevZaPregledDTO;
import com.example.demo.repository.DoktorRepository;
import com.example.demo.repository.KorisnikRepository;
import com.example.demo.repository.PregledRepository;
import com.example.demo.repository.TerminRepository;
import com.example.demo.repository.ZahtevZaPodatkeRepository;
import com.example.demo.repository.ZahtevZaPregledRepository;

import jakarta.transaction.Transactional;
import model.Doktor;
import model.Korisnik;
import model.Pacijent;
import model.Pregled;
import model.Termin;
import model.ZahtevZaPodatke;
import model.ZahtevZaPregled;

@Service
public class PacijentService {

	@Autowired
	KorisnikRepository korisnikRepository;
	@Autowired
	DoktorRepository doktorRepository;
	@Autowired
	PregledRepository pregledRepository;
	@Autowired
	TerminRepository terminRepository;
	@Autowired
	ZahtevZaPregledRepository zahtevZaPregledRepository;
	@Autowired
	ZahtevZaPodatkeRepository zahtevZaPodatkeRepository;
	@Autowired
	RevizijskiTragService revizijskiTragService;

	// ── Pregledi ─────────────────────────────────────────────────

	public List<Pregled> getProsliPregledi() {
		return pregledRepository.findByPacijentAndStatus(trenutniPacijent(), "ZAVRSEN");
	}

	@org.springframework.transaction.annotation.Transactional
	public void stampajIzvestajPacijenta(Integer idPregled, jakarta.servlet.http.HttpServletResponse response)
			throws Exception {
		Pacijent p = trenutniPacijent();
		model.Pregled pregled = pregledRepository.findById(idPregled).get();
		if (pregled.getPacijent().getIdPacijent() != p.getIdPacijent())
			return;

		java.util.Map<String, Object> params = new java.util.HashMap<>();
		params.put("doktorIme", pregled.getDoktor().getIme() + " " + pregled.getDoktor().getPrezime());
		params.put("doktorSpecijalizacija", pregled.getDoktor().getSpecijalizacija());
		params.put("odeljenje", pregled.getDoktor().getOdeljenje().getNaziv());
		params.put("pacijentIme", pregled.getPacijent().getIme() + " "
				+ (pregled.getPacijent().getImeOca() != null ? "(" + pregled.getPacijent().getImeOca() + ") " : "")
				+ pregled.getPacijent().getPrezime());
		params.put("jmbg", pregled.getPacijent().getJmbg());
		params.put("adresa", pregled.getPacijent().getAdresa());
		params.put("lbo", pregled.getPacijent().getLbo());
		params.put("brojProtokola", String.valueOf(pregled.getIdPregled()));
		params.put("datumVreme", pregled.getDatumVreme());
		params.put("vremeZavrsetka", pregled.getVremeZavrsetka());
		params.put("nalaz", pregled.getNalaz());

		StringBuilder dijagnoze = new StringBuilder();
		if (pregled.getDijagnozas() != null)
			for (model.Dijagnoza d : pregled.getDijagnozas())
				dijagnoze.append(d.getSifra()).append(" ").append(d.getOpis()).append("; ");
		params.put("dijagnoze", dijagnoze.toString());

		java.io.InputStream is = getClass().getResourceAsStream("/jasperreports/izvestajPregleda.jrxml");
		net.sf.jasperreports.engine.JasperReport jr = net.sf.jasperreports.engine.JasperCompileManager
				.compileReport(is);
		net.sf.jasperreports.engine.data.JRBeanCollectionDataSource ds = new net.sf.jasperreports.engine.data.JRBeanCollectionDataSource(
				java.util.List.of(new Object()));
		net.sf.jasperreports.engine.JasperPrint jp = net.sf.jasperreports.engine.JasperFillManager.fillReport(jr,
				params, ds);
		response.setContentType("application/pdf");
		response.addHeader("Content-Disposition", "inline; filename=izvestaj_" + idPregled + ".pdf");
		net.sf.jasperreports.engine.JasperExportManager.exportReportToPdfStream(jp, response.getOutputStream());
		is.close();
	}

	public List<model.Recept> getMojeRecepte() {
		Pacijent p = trenutniPacijent();
		List<model.Recept> recepti = new java.util.ArrayList<>();
		for (Pregled pr : pregledRepository.findByPacijentOrderByDatumVremeDesc(p)) {
			if (pr.getRecepts() != null)
				recepti.addAll(pr.getRecepts());
		}
		return recepti;
	}

	public List<Pregled> getBuduciPregledi() {
		Pacijent p = trenutniPacijent();
		List<Pregled> lista = pregledRepository.findByPacijentAndStatus(p, "ZAKAZAN");
		lista.addAll(pregledRepository.findByPacijentAndStatus(p, "U_TOKU"));
		return lista;
	}

	// ── Zakazivanje ──────────────────────────────────────────────

	public List<Doktor> getSveDoktore() {
		return doktorRepository.findAll();
	}

	public List<Termin> getSlobodneTermine(Integer idDoktora) {
		Doktor doktor = doktorRepository.findById(idDoktora).get();
		return terminRepository.findByDoktorAndDostupan(doktor, (byte) 1);
	}

	@Transactional
	public boolean posaljiZahtev(ZahtevZaPregledDTO dto) {
		try {
			Pacijent pacijent = trenutniPacijent();
			Doktor doktor = doktorRepository.findById(dto.getIdDoktora()).get();
			Termin termin = terminRepository.findById(dto.getIdTermina()).get();

			ZahtevZaPregled zahtev = new ZahtevZaPregled();
			zahtev.setPacijent(pacijent);
			zahtev.setDoktor(doktor);
			zahtev.setTermin(termin);
			zahtev.setNapomena(dto.getNapomena());
			zahtev.setStatus("CEKA");
			zahtev.setDatumZahteva(new Date());
			ZahtevZaPregled sacuvan = zahtevZaPregledRepository.save(zahtev);

			revizijskiTragService.log(SecurityContextHolder.getContext().getAuthentication().getName(),
					"ZAHTEV_ZA_PREGLED_PODNET", "ZAHTEV_ZA_PREGLED", sacuvan.getIdZahtev());

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<ZahtevZaPregled> getMojiZahtevi() {
		return zahtevZaPregledRepository.findByPacijentOrderByDatumZahtevaDesc(trenutniPacijent());
	}

	// ── GDPR ─────────────────────────────────────────────────────

	public List<ZahtevZaPodatke> getMojeGdprZahteve() {
		String ime = SecurityContextHolder.getContext().getAuthentication().getName();
		return zahtevZaPodatkeRepository
				.findByKorisnikOrderByDatumZahtevaDesc(korisnikRepository.findByKorisnickoIme(ime));
	}

	@Transactional
	public boolean posaljiGdprZahtev(String tipZahteva, String napomena) {
		try {
			String ime = SecurityContextHolder.getContext().getAuthentication().getName();
			ZahtevZaPodatke zahtev = new ZahtevZaPodatke();
			zahtev.setKorisnik(korisnikRepository.findByKorisnickoIme(ime));
			zahtev.setTipZahteva(tipZahteva);
			zahtev.setNapomena(napomena);
			zahtev.setStatus("PRIMLJEN");
			zahtev.setDatumZahteva(new Date());
			ZahtevZaPodatke sacuvan = zahtevZaPodatkeRepository.save(zahtev);

			revizijskiTragService.log(ime, "GDPR_ZAHTEV_PODNET", "ZAHTEV_ZA_PODATKE", sacuvan.getIdZahtev());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Transactional
	public void preuzmiPodatke(Integer idZahtev, String korisnickoIme,
			jakarta.servlet.http.HttpServletResponse response) throws Exception {
		ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
		if (zahtev.getKorisnik() == null || !zahtev.getKorisnik().getKorisnickoIme().equals(korisnickoIme)
				|| zahtev.getPutanjaFajla() == null) {
			response.sendError(403);
			return;
		}
		java.io.File fajl = new java.io.File(zahtev.getPutanjaFajla());
		if (!fajl.exists()) {
			response.sendError(404);
			return;
		}

		byte[] bytes = java.nio.file.Files.readAllBytes(fajl.toPath());
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + fajl.getName());
		response.setContentLength(bytes.length);
		response.getOutputStream().write(bytes);

		// Obrisi fajl i putanju
		fajl.delete();
		zahtev.setPutanjaFajla(null);
		zahtevZaPodatkeRepository.save(zahtev);
	}

	public Pacijent trenutniPacijent() {
		String korisnickoIme = SecurityContextHolder.getContext().getAuthentication().getName();
		Korisnik korisnik = korisnikRepository.findByKorisnickoIme(korisnickoIme);
		return korisnik.getPacijent();
	}
}
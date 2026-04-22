package com.example.demo.service;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.repository.PregledRepository;
import com.example.demo.repository.ZahtevZaPodatkeRepository;
import model.Pacijent;
import model.Pregled;
import model.Recept;
import model.ZahtevZaPodatke;
import model.ZdravstveniKarton;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Service
public class PravoNaUvidIzvestajService {

	@Autowired
	ZahtevZaPodatkeRepository zahtevZaPodatkeRepository;
	@Autowired
	PregledRepository pregledRepository;

	public JasperPrint kreirajIzvestaj(Integer idZahtev, String korisnickoIme) throws Exception {
		ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
		if (zahtev.getKorisnik() == null || !zahtev.getKorisnik().getKorisnickoIme().equals(korisnickoIme))
			throw new RuntimeException("Neovlascen pristup");
		if (!"UVID".equals(zahtev.getTipZahteva()) || !"ZAVRSEN".equals(zahtev.getStatus()))
			throw new RuntimeException("Zahtev nije odobren");

		Pacijent p = zahtev.getKorisnik().getPacijent();
		if (p.getZdravstveniKartons() != null)
			p.getZdravstveniKartons().size();
		List<Pregled> pregledi = pregledRepository.findByPacijentOrderByDatumVremeDesc(p);
		for (Pregled pr : pregledi) {
			if (pr.getDijagnozas() != null)
				pr.getDijagnozas().size();
		}
		List<model.Recept> recepti = new java.util.ArrayList<>();
		for (model.Pregled pr : pregledi) {
			if (pr.getRecepts() != null)
				recepti.addAll(pr.getRecepts());
		}

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdfDt = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		ZdravstveniKarton k = p.getZdravstveniKartons() != null && !p.getZdravstveniKartons().isEmpty()
				? p.getZdravstveniKartons().get(0)
				: null;

		StringBuilder preglediSb = new StringBuilder();
		for (Pregled pr : pregledi) {
			preglediSb.append(sdfDt.format(pr.getDatumVreme())).append(" | Dr. ")
					.append(pr.getDoktor() != null ? pr.getDoktor().getIme() + " " + pr.getDoktor().getPrezime() : "")
					.append(" | ").append(pr.getStatus());
			if (pr.getNalaz() != null)
				preglediSb.append("\n  Nalaz: ").append(pr.getNalaz());
			preglediSb.append("\n\n");
		}

		StringBuilder receptiSb = new StringBuilder();
		for (Recept r : recepti) {
			receptiSb.append(r.getLek() != null ? r.getLek().getNaziv() : "").append(" | kol: ")
					.append(r.getKolicina());
			if (r.getUputstvo() != null)
				receptiSb.append(" | ").append(r.getUputstvo());
			if (r.getDatumIzdavanja() != null)
				receptiSb.append(" | ").append(sdf.format(r.getDatumIzdavanja()));
			receptiSb.append("\n");
		}

		Map<String, Object> params = new HashMap<>();
		params.put("ime", p.getIme());
		params.put("prezime", p.getPrezime());
		params.put("imeOca", p.getImeOca() != null ? p.getImeOca() : "-");
		params.put("jmbg", p.getJmbg());
		params.put("lbo", p.getLbo() != null ? p.getLbo() : "-");
		params.put("pol", "M".equals(p.getPol()) ? "Muski" : "Z".equals(p.getPol()) ? "Zenski" : "-");
		params.put("datumRodjenja", p.getDatumRodjenja() != null ? sdf.format(p.getDatumRodjenja()) : "-");
		params.put("adresa", p.getAdresa() != null ? p.getAdresa() : "-");
		params.put("email", p.getEmail() != null ? p.getEmail() : "-");
		params.put("telefon", p.getTelefon() != null ? p.getTelefon() : "-");
		params.put("osiguran", p.getOsiguran() == 1 ? "Da" : "Ne");
		params.put("krvnaGrupa", k != null && k.getKrvnaGrupa() != null ? k.getKrvnaGrupa() : "-");
		params.put("alergije", k != null && k.getAlergije() != null ? k.getAlergije() : "-");
		params.put("hronicanBolesnik", k != null && k.getHronicanBolesnik() == 1 ? "Da" : "Ne");
		params.put("napomenaKarton", k != null && k.getNapomena() != null ? k.getNapomena() : "-");
		params.put("pregledi", preglediSb.toString());
		params.put("recepti", receptiSb.toString());
		params.put("datumIzvoza", sdf.format(new Date()));

		InputStream is = getClass().getResourceAsStream("/jasperreports/gdprIzvoz.jrxml");
		JasperReport jr = JasperCompileManager.compileReport(is);
		JasperPrint jp = JasperFillManager.fillReport(jr, params, new JRBeanCollectionDataSource(List.of()));
		is.close();
		return jp;
	}

	@Transactional
	public void sacuvajPdf(Integer idZahtev, JasperPrint jp) throws Exception {
		ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
		String fileName = "uvid_" + idZahtev + "_" + System.currentTimeMillis() + ".pdf";
		String uploadDir = System.getProperty("user.home") + "/bolnica-gdpr/";
		new java.io.File(uploadDir).mkdirs();
		JasperExportManager.exportReportToPdfFile(jp, uploadDir + fileName);
		zahtev.setPdfPutanja(uploadDir + fileName);
		zahtevZaPodatkeRepository.save(zahtev);
	}

	@Transactional
	public void ocistiPdf(Integer idZahtev) {
		ZahtevZaPodatke zahtev = zahtevZaPodatkeRepository.findById(idZahtev).get();
		zahtev.setPdfPutanja(null);
		zahtevZaPodatkeRepository.save(zahtev);
	}

	public ZahtevZaPodatke getZahtev(Integer id) {
		return zahtevZaPodatkeRepository.findById(id).get();
	}
}
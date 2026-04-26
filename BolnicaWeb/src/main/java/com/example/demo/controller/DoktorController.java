package com.example.demo.controller;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.NalazDTO;
import com.example.demo.service.DoktorService;

import jakarta.servlet.http.HttpServletResponse;
import model.Pregled;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
@RequestMapping("/doktor/")
public class DoktorController {

	@Autowired
	DoktorService doktorService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}

	// ── Početna ──────────────────────────────────────────────────

	@GetMapping("pocetna")
	public String pocetna(Model m) {
		m.addAttribute("doktor", doktorService.trenutniDoktor());
		m.addAttribute("cekajuciZahtevi", doktorService.getCekajuciZahtevi());
		m.addAttribute("zakazani", doktorService.getZakazaniPregledi());
		m.addAttribute("aktivni", doktorService.getAktivniPregledi());
		return "doktor/pocetna";
	}

	// ── Zahtevi ──────────────────────────────────────────────────

	@GetMapping("zahtevi")
	public String zahtevi(Model m) {
		m.addAttribute("doktor", doktorService.trenutniDoktor());
		m.addAttribute("zahtevi", doktorService.getCekajuciZahtevi());
		return "doktor/zahtevi";
	}

	@PostMapping("odobriZahtev")
	public String odobriZahtev(@RequestParam("idZahtev") Integer idZahtev, Model m) {
		if (doktorService.odobriZahtev(idZahtev)) {
			m.addAttribute("poruka", "Zahtev odobren.");
		} else {
			m.addAttribute("greska", "Greška pri odobravanju.");
		}
		m.addAttribute("doktor", doktorService.trenutniDoktor());
		m.addAttribute("zahtevi", doktorService.getCekajuciZahtevi());
		return "doktor/zahtevi";
	}

	@PostMapping("odbijZahtev")
	public String odbijZahtev(@RequestParam("idZahtev") Integer idZahtev, @RequestParam("komentar") String komentar,
			Model m) {
		if (doktorService.odbijZahtev(idZahtev, komentar)) {
			m.addAttribute("poruka", "Zahtev odbijen.");
		} else {
			m.addAttribute("greska", "Greška pri odbijanju.");
		}
		m.addAttribute("doktor", doktorService.trenutniDoktor());
		m.addAttribute("zahtevi", doktorService.getCekajuciZahtevi());
		return "doktor/zahtevi";
	}

	// ── Budući pregledi ──────────────────────────────────────────

	@GetMapping("pregledi")
	public String pregledi(Model m) {
		m.addAttribute("doktor", doktorService.trenutniDoktor());
		m.addAttribute("zakazani", doktorService.getZakazaniPregledi());
		m.addAttribute("aktivni", doktorService.getAktivniPregledi());
		return "doktor/pregledi";
	}

	// ── Novi pregled ─────────────────────────────────────────────

	@GetMapping("noviPregled")
	public String noviPregled(Model m) {
		m.addAttribute("doktor", doktorService.trenutniDoktor());
		return "doktor/noviPregled";
	}

	@PostMapping("zapocniPregled")
	public String zapocniPregled(@RequestParam("brojUnos") String brojUnos, Model m) {
		String[] rezultat = doktorService.zapocniPregled(brojUnos);
		if (rezultat[0] != null) {
			m.addAttribute("greska", rezultat[0]);
			m.addAttribute("doktor", doktorService.trenutniDoktor());
			return "doktor/noviPregled";
		}
		return "redirect:/doktor/aktivanPregled?idPregled=" + rezultat[1];
	}

	// ── Aktivan pregled ──────────────────────────────────────────

	@GetMapping("aktivanPregled")
	public String aktivanPregled(@RequestParam("idPregled") Integer idPregled, Model m) {
		m.addAttribute("pregled", doktorService.getPregled(idPregled));
		m.addAttribute("dijagnoze", doktorService.getSveDijagnoze());
		m.addAttribute("lekovi", doktorService.getSveLekove());
		m.addAttribute("nalazDTO", new NalazDTO());
		return "doktor/aktivanPregled";
	}

	// Stari pregledi u novom prozoru
	@GetMapping("stariPregledi")
	public String stariPregledi(@RequestParam("idPregled") Integer idPregled, Model m) {
		m.addAttribute("p", doktorService.getPregled(idPregled));
		m.addAttribute("pregledi", doktorService.getStariPreglediPacijenta(idPregled));
		m.addAttribute("idPregled", idPregled);
		return "doktor/stariPregledi";
	}

	@PostMapping("sacuvajNalaz")
	public String sacuvajNalaz(@ModelAttribute NalazDTO nalazDTO, Model m) {
		if (doktorService.sacuvajNalaz(nalazDTO)) {
			return "redirect:/doktor/izvestaj?idPregled=" + nalazDTO.getIdPregled();
		}
		m.addAttribute("greska", "Greška pri čuvanju nalaza.");
		m.addAttribute("pregled", doktorService.getPregled(nalazDTO.getIdPregled()));
		m.addAttribute("dijagnoze", doktorService.getSveDijagnoze());
		m.addAttribute("lekovi", doktorService.getSveLekove());
		return "doktor/aktivanPregled";
	}

	// ── Izveštaj (JasperReports PDF) ─────────────────────────────

	@GetMapping("izvestaj")
	public String izvestajPreview(@RequestParam("idPregled") Integer idPregled, Model m) {
		m.addAttribute("pregled", doktorService.getPregled(idPregled));
		return "doktor/izvestaj";
	}

	@GetMapping("stampajIzvestaj")
	public void stampajIzvestaj(@RequestParam("idPregled") Integer idPregled, HttpServletResponse response)
			throws JRException, IOException {

		Pregled pregled = doktorService.getPregled(idPregled);

		// Parametri
		Map<String, Object> params = new HashMap<>();
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
		if (pregled.getDijagnozas() != null) {
			for (model.Dijagnoza d : pregled.getDijagnozas()) {
				dijagnoze.append(d.getSifra()).append(" ").append(d.getOpis()).append("; ");
			}
		}
		params.put("dijagnoze", dijagnoze.toString());

		InputStream is = getClass().getResourceAsStream("/jasperreports/izvestajPregleda.jrxml");
		JasperReport jasperReport = JasperCompileManager.compileReport(is);

		JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(java.util.List.of(new Object()));
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, ds);

		response.setContentType("application/pdf");
		response.setCharacterEncoding("UTF-8");
		String filename = "izvestaj_" + idPregled + ".pdf";
		response.addHeader("Content-Disposition", "inline; filename=" + filename);
		JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
		is.close();
	}
}

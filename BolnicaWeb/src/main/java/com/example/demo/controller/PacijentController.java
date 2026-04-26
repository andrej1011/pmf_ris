package com.example.demo.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.ZahtevZaPregledDTO;
import com.example.demo.service.PacijentService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import model.Pacijent;

@Controller
@RequestMapping("/pacijent/")
public class PacijentController {

	@Autowired
	PacijentService pacijentService;

	// ── Pocetna ──────────────────────────────────────────────────

	@GetMapping("pocetna")
	public String pocetna(Model m) {
		m.addAttribute("pacijent", pacijentService.trenutniPacijent());
		return "pacijent/pocetna";
	}

	// ── Karton ───────────────────────────────────────────────────

	@GetMapping("karton")
	public String karton(Model m) {
		m.addAttribute("pacijent", pacijentService.trenutniPacijent());
		return "pacijent/karton";
	}

	// ── Recepti ──────────────────────────────────────────────────

	@GetMapping("recepti")
	public String recepti(Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("recepti", pacijentService.getMojeRecepte());
		return "pacijent/recepti";
	}

	// ── Pregledi ─────────────────────────────────────────────────

	@GetMapping("prosliPregledi")
	public String prosliPregledi(Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("pregledi", pacijentService.getProsliPregledi());
		return "pacijent/prosliPregledi";
	}
	
	@GetMapping("stampajIzvestaj")
	public void stampajIzvestaj(@RequestParam("idPregled") Integer idPregled,
	        jakarta.servlet.http.HttpServletResponse response) throws Exception {
	    pacijentService.stampajIzvestajPacijenta(idPregled, response);
	}

	@GetMapping("buduciPregledi")
	public String buduciPregledi(Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("pregledi", pacijentService.getBuduciPregledi());
		return "pacijent/buduciPregledi";
	}

	// ── Zakazivanje ──────────────────────────────────────────────

	@GetMapping("zakazivanje")
	public String zakazivanje(Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("doktori", pacijentService.getSveDoktore());
		m.addAttribute("zahtevDTO", new ZahtevZaPregledDTO());
		return "pacijent/zakazivanje";
	}

	@GetMapping("slobodniTermini")
	public String slobodniTermini(@RequestParam("idDoktora") Integer idDoktora, Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("doktori", pacijentService.getSveDoktore());
		m.addAttribute("termini", pacijentService.getSlobodneTermine(idDoktora));
		m.addAttribute("idDoktora", idDoktora);
		m.addAttribute("zahtevDTO", new ZahtevZaPregledDTO());
		return "pacijent/zakazivanje";
	}

	@PostMapping("posaljiZahtev")
	public String posaljiZahtev(@Valid @ModelAttribute ZahtevZaPregledDTO zahtevDTO,
			BindingResult result, Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		if (result.hasErrors()) {
			m.addAttribute("greska", "Niste odabrali doktora ili termin.");
			m.addAttribute("doktori", pacijentService.getSveDoktore());
			return "pacijent/zakazivanje";
		}
		if (pacijentService.posaljiZahtev(zahtevDTO)) {
			m.addAttribute("poruka", "Zahtev je uspesno poslat. Cekajte odobrenje doktora.");
		} else {
			m.addAttribute("greska", "Greska pri slanju zahteva. Pokusajte ponovo.");
		}
		m.addAttribute("doktori", pacijentService.getSveDoktore());
		m.addAttribute("zahtevDTO", new ZahtevZaPregledDTO());
		return "pacijent/zakazivanje";
	}

	@GetMapping("mojiZahtevi")
	public String mojiZahtevi(Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("zahtevi", pacijentService.getMojiZahtevi());
		return "pacijent/mojiZahtevi";
	}

	// ── GDPR / Podesavanja ────────────────────────────────────────

	@GetMapping("gdpr")
	public String gdpr(Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("zahtevi", pacijentService.getMojeGdprZahteve());
		return "pacijent/gdpr";
	}

	@PostMapping("posaljiGdpr")
	public String posaljiGdpr(@RequestParam("tipZahteva") String tipZahteva,
			@RequestParam(value = "napomena", required = false) String napomena, Model m) {
		Pacijent p = pacijentService.trenutniPacijent();
		m.addAttribute("pacijent", p);
		if (pacijentService.posaljiGdprZahtev(tipZahteva, napomena)) {
			m.addAttribute("poruka", "GDPR zahtev je uspesno podnet. Administrator ce vas kontaktirati.");
		} else {
			m.addAttribute("greska", "Greska pri podnosenju zahteva.");
		}
		m.addAttribute("zahtevi", pacijentService.getMojeGdprZahteve());
		return "pacijent/gdpr";
	}
	
	@GetMapping("preuzmiPodatke/{idZahtev}")
	public void preuzmiPodatke(@PathVariable Integer idZahtev,
	        HttpServletResponse response, Principal principal) throws Exception {
	    pacijentService.preuzmiPodatke(idZahtev, principal.getName(), response);
	}
}

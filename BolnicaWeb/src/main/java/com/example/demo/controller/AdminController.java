package com.example.demo.controller;

import java.security.Principal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.DoktorDTO;
import com.example.demo.dto.SestraDTO;
import com.example.demo.service.AdminService;

import jakarta.validation.Valid;
import model.ZahtevZaPodatke;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequestMapping("/admin/")
public class AdminController {

	@Autowired
	AdminService adminService;

	private void addNavUser(Model m, Principal principal) {
		if (principal != null) {
			m.addAttribute("korisnik", adminService.getKorisnikByUsername(principal.getName()));
		}
	}

	// ── Pocetna ──────────────────────────────────────────────────

	@GetMapping("pocetna")
	public String pocetna(Model m, Principal principal) {
		addNavUser(m, principal);
		return "admin/pocetna";
	}

	// ── Korisnici ────────────────────────────────────────────────

	@GetMapping("korisnici")
	public String korisnici(Model m, Principal principal,
			@RequestParam(value = "tab", required = false, defaultValue = "svi") String tab) {
		addNavUser(m, principal);
		m.addAttribute("korisnici", adminService.getSveKorisnike());
		m.addAttribute("odeljenja", adminService.getSvaOdeljenja());
		m.addAttribute("doktorDTO", new DoktorDTO());
		m.addAttribute("sestraDTO", new SestraDTO());
		m.addAttribute("tab", tab);
		return "admin/korisnici";
	}

	@PostMapping("kreirajDoktora")
	public String kreirajDoktora(@Valid @ModelAttribute DoktorDTO doktorDTO, BindingResult result, Model m,
			Principal principal) {
		addNavUser(m, principal);
		if (result.hasErrors()) {
			m.addAttribute("errorsDoktor", result.getAllErrors());
			m.addAttribute("korisnici", adminService.getSveKorisnike());
			m.addAttribute("odeljenja", adminService.getSvaOdeljenja());
			m.addAttribute("sestraDTO", new SestraDTO());
			m.addAttribute("tab", "doktor");
			return "admin/korisnici";
		}
		try {
			String[] kredencijali = adminService.kreirajDoktora(doktorDTO);
			m.addAttribute("poruka", "Nalog doktora je uspesno kreiran.");
			m.addAttribute("noviKorisnickoIme", kredencijali[0]);
			m.addAttribute("novaLozinka", kredencijali[1]);
		} catch (Exception e) {
			m.addAttribute("greska", "Greska pri kreiranju naloga.");
		}
		m.addAttribute("korisnici", adminService.getSveKorisnike());
		m.addAttribute("odeljenja", adminService.getSvaOdeljenja());
		m.addAttribute("doktorDTO", new DoktorDTO());
		m.addAttribute("sestraDTO", new SestraDTO());
		m.addAttribute("tab", "svi");
		return "admin/korisnici";
	}

	@PostMapping("kreirajSestru")
	public String kreirajSestru(@Valid @ModelAttribute SestraDTO sestraDTO, BindingResult result, Model m,
			Principal principal) {
		addNavUser(m, principal);
		if (result.hasErrors()) {
			m.addAttribute("errorsSestra", result.getAllErrors());
			m.addAttribute("korisnici", adminService.getSveKorisnike());
			m.addAttribute("odeljenja", adminService.getSvaOdeljenja());
			m.addAttribute("doktorDTO", new DoktorDTO());
			m.addAttribute("tab", "sestra");
			return "admin/korisnici";
		}
		try {
			String[] kredencijali = adminService.kreirajSestru(sestraDTO);
			m.addAttribute("poruka", "Nalog medicinske sestre je uspesno kreiran.");
			m.addAttribute("noviKorisnickoIme", kredencijali[0]);
			m.addAttribute("novaLozinka", kredencijali[1]);
		} catch (Exception e) {
			m.addAttribute("greska", "Greska pri kreiranju naloga.");
		}
		m.addAttribute("korisnici", adminService.getSveKorisnike());
		m.addAttribute("odeljenja", adminService.getSvaOdeljenja());
		m.addAttribute("doktorDTO", new DoktorDTO());
		m.addAttribute("sestraDTO", new SestraDTO());
		m.addAttribute("tab", "svi");
		return "admin/korisnici";
	}

	// ── Lozinka ──────────────────────────────────────────────────

	@GetMapping("lozinka")
	public String lozinka(Model m, Principal principal) {
		addNavUser(m, principal);
		m.addAttribute("korisnici", adminService.getSveKorisnike());
		return "admin/lozinka";
	}

	@PostMapping("promeniLozinku")
	public String promeniLozinku(@RequestParam("idKorisnika") Integer idKorisnika,
			@RequestParam("novaLozinka") String novaLozinka, Model m, Principal principal) {
		addNavUser(m, principal);
		if (novaLozinka == null || novaLozinka.isBlank()) {
			m.addAttribute("greska", "Lozinka ne sme biti prazna.");
		} else if (adminService.promeniLozinku(idKorisnika, novaLozinka)) {
			m.addAttribute("poruka", "Lozinka je uspesno promenjena.");
		} else {
			m.addAttribute("greska", "Greska pri promeni lozinke.");
		}
		m.addAttribute("korisnici", adminService.getSveKorisnike());
		return "admin/lozinka";
	}

	// ── GDPR ─────────────────────────────────────────────────────

	@GetMapping("gdpr")
	public String gdpr(Model m, Principal principal) {
		addNavUser(m, principal);
		m.addAttribute("zahtevi", adminService.getSveZahteve());
		return "admin/gdpr";
	}

	@PostMapping("promeniStatusGdpr")
	public String promeniStatusGdpr(@RequestParam("idZahtev") Integer idZahtev, @RequestParam("status") String status,
			Model m, Principal principal) {
		addNavUser(m, principal);
		if (adminService.promeniStatusZahteva(idZahtev, status)) {
			m.addAttribute("poruka", "Status zahteva je uspesno promenjen.");
		} else {
			m.addAttribute("greska", "Greska pri promeni statusa.");
		}
		m.addAttribute("zahtevi", adminService.getSveZahteve());
		return "admin/gdpr";
	}

	@PostMapping("obradiGdprBrisanje")
	public String obradiGdprBrisanje(@RequestParam("idZahtev") Integer idZahtev, Model m, Principal principal) {
		addNavUser(m, principal);
		if (adminService.obradiGdprBrisanje(idZahtev)) {
			m.addAttribute("poruka", "Podaci pacijenta su uspesno obrisani.");
		} else {
			m.addAttribute("greska", "Greska pri brisanju.");
		}
		m.addAttribute("zahtevi", adminService.getSveZahteve());
		return "admin/gdpr";
	}

	@GetMapping("gdprIzmena/{idZahtev}")
	public String gdprIzmena(@PathVariable Integer idZahtev, Model m, Principal principal) {
		addNavUser(m, principal);
		ZahtevZaPodatke zahtev = adminService.getZahtevById(idZahtev);
		m.addAttribute("zahtev", zahtev);
		model.Pacijent p = zahtev.getKorisnik().getPacijent();
		m.addAttribute("pacijent", p);
		m.addAttribute("karton", adminService.getKartonZaPacijenta(p));
		return "admin/gdprIzmena";
	}

	@PostMapping("sacuvajIzmenu")
	public String sacuvajIzmenu(@RequestParam Integer idZahtev, @RequestParam Map<String, String> params, Model m,
			Principal principal) {
		addNavUser(m, principal);
		ZahtevZaPodatke zahtev = adminService.getZahtevById(idZahtev);
		model.Pacijent p = zahtev.getKorisnik().getPacijent();
		String ime = p.getIme();
		String prezime = p.getPrezime();
		adminService.sacuvajGdprIzmenu(idZahtev, params, principal.getName());
		String izmene = adminService.getPoslednjeIzmene(idZahtev);
		m.addAttribute("pacijentIme", ime + " " + prezime);
		m.addAttribute("izmene", izmene);
		return "admin/sacuvajIzmenu";
	}

	@GetMapping("izvezi/{idZahtev}")
	public String izvezi(@PathVariable Integer idZahtev,
			org.springframework.web.servlet.mvc.support.RedirectAttributes ra) throws Exception {
		ZahtevZaPodatke zahtev = adminService.getZahtevById(idZahtev);
		if ("UVID".equals(zahtev.getTipZahteva())) {
			adminService.odobriUvid(idZahtev);
		} else {
			adminService.izveziPodatke(idZahtev);
		}
		ra.addFlashAttribute("poruka", "Zahtev je obradjen.");
		return "redirect:/admin/gdpr";
	}

	// ── Revizija ─────────────────────────────────────────────────

	@GetMapping("revizija")
	public String revizija(Model m, Principal principal,
			@RequestParam(value = "kategorija", required = false) String kategorija) {
		addNavUser(m, principal);
		if (kategorija != null && !kategorija.isBlank()) {
			m.addAttribute("revizija", adminService.getRevizijuPoKategoriji(kategorija));
			m.addAttribute("aktivnaKategorija", kategorija);
		} else {
			m.addAttribute("revizija", adminService.getSvuReviziju());
		}
		return "admin/revizija";
	}
}

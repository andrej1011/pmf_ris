package com.example.demo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.PacijentDTO;
import com.example.demo.repository.KorisnikRepository;
import com.example.demo.service.SestraService;

import jakarta.validation.Valid;
import model.Pacijent;



@Controller
@RequestMapping("/sestra/")
public class SestraController {

	@Autowired
	SestraService sestraService;

	@Autowired
	KorisnikRepository korisnikRepository;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}

	private void addNavUser(Model m, Principal principal) {
		if (principal != null) {
			m.addAttribute("korisnik", korisnikRepository.findByKorisnickoIme(principal.getName()));
		}
	}


	@GetMapping("pocetna")
	public String pocetna(Model m, Principal principal) {
		addNavUser(m, principal);
		return "sestra/pocetna";
	}


	@GetMapping("kreirajPacijenta")
	public String kreirajPacijentaForm(Model m, Principal principal) {
		addNavUser(m, principal);
		m.addAttribute("pacijentDTO", new PacijentDTO());
		return "sestra/kreirajPacijenta";
	}

	@PostMapping("kreirajPacijenta")
	public String kreirajPacijenta(@Valid @ModelAttribute PacijentDTO pacijentDTO, BindingResult result, Model m,
			Principal principal) {
		addNavUser(m, principal);
		if (result.hasErrors()) {
			m.addAttribute("errors", result.getAllErrors());
			return "sestra/kreirajPacijenta";
		}
		if (sestraService.postojiJmbg(pacijentDTO.getJmbg())) {
			m.addAttribute("greska", "Pacijent sa ovim JMBG-om vec postoji u sistemu.");
			return "sestra/kreirajPacijenta";
		}
		try {
			String[] kredencijali = sestraService.kreirajPacijenta(pacijentDTO);
			m.addAttribute("poruka", "Pacijent je uspesno kreiran.");
			m.addAttribute("korisnickoIme", kredencijali[0]);
			m.addAttribute("lozinka", kredencijali[1]);
		} catch (Exception e) {
			if (e.getMessage() != null && e.getMessage().contains("chk_pacijent_osiguran")) {
				m.addAttribute("greska", "Pacijent sa LBO-om mora biti oznacen kao osiguran i obrnuto.");
			} else {
				m.addAttribute("greska", "Greska pri kreiranju pacijenta. Proverite unos.");
			}
		}
		m.addAttribute("pacijentDTO", new PacijentDTO());
		return "sestra/kreirajPacijenta";
	}


	@GetMapping("prijaviPacijenta")
	public String prijaviPacijentaForm(Model m, Principal principal) {
		addNavUser(m, principal);
		return "sestra/prijaviPacijenta";
	}

	@GetMapping("traziPacijenta")
	public String traziPacijenta(@RequestParam("jmbg") String jmbg, Model m, Principal principal) {
		addNavUser(m, principal);
		Pacijent pacijent = sestraService.findByJmbg(jmbg);
		if (pacijent == null) {
			m.addAttribute("greska", "Pacijent sa JMBG-om " + jmbg + " nije pronadjen.");
			return "sestra/prijaviPacijenta";
		}
		m.addAttribute("pacijent", pacijent);
		m.addAttribute("pregledi", sestraService.getZakazaniPregledi(pacijent));
		m.addAttribute("doktori", sestraService.getSveDoktore());
		return "sestra/prijaviPacijenta";
	}

	@PostMapping("prijaviNaPregled")
	public String prijaviNaPregled(@RequestParam("idPregled") Integer idPregled, @RequestParam("jmbg") String jmbg,
			Model m, Principal principal) {
		addNavUser(m, principal);
		if (sestraService.prijaviNaPregled(idPregled)) {
			m.addAttribute("poruka", "Pacijent je uspesno prijavljen na pregled.");
		} else {
			m.addAttribute("greska", "Greska pri prijavi na pregled.");
		}
		Pacijent pacijent = sestraService.findByJmbg(jmbg);
		m.addAttribute("pacijent", pacijent);
		m.addAttribute("pregledi", sestraService.getZakazaniPregledi(pacijent));
		return "sestra/prijaviPacijenta";
	}

	@GetMapping("traziTermine")
	public String traziTermine(@RequestParam("jmbg") String jmbg, @RequestParam("idDoktora") Integer idDoktora, Model m,
			Principal principal) {
		addNavUser(m, principal);
		Pacijent pacijent = sestraService.findByJmbg(jmbg);
		m.addAttribute("pacijent", pacijent);
		m.addAttribute("pregledi", sestraService.getZakazaniPregledi(pacijent));
		m.addAttribute("doktori", sestraService.getSveDoktore());
		m.addAttribute("termini", sestraService.getSlobodneTermine(idDoktora));
		m.addAttribute("izabraniDoktor", idDoktora);
		return "sestra/prijaviPacijenta";
	}

	@PostMapping("zakaziPregled")
	public String zakaziPregled(@RequestParam("jmbg") String jmbg, @RequestParam("idDoktora") Integer idDoktora,
			@RequestParam("idTermina") Integer idTermina,
			@RequestParam(value = "napomena", required = false) String napomena, Model m, Principal principal) {
		addNavUser(m, principal);
		Pacijent pacijent = sestraService.findByJmbg(jmbg);
		if (sestraService.zakaziPregled(pacijent, idDoktora, idTermina, napomena)) {
			m.addAttribute("poruka", "Pregled uspesno zakazan i prijavljen.");
		} else {
			m.addAttribute("greska", "Greska pri zakazivanju.");
		}
		m.addAttribute("pacijent", pacijent);
		m.addAttribute("pregledi", sestraService.getZakazaniPregledi(pacijent));
		m.addAttribute("doktori", sestraService.getSveDoktore());
		return "sestra/prijaviPacijenta";
	}
}

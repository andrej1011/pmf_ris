package com.example.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.demo.service.PravoNaUvidIzvestajService;
import jakarta.servlet.http.HttpServletResponse;
import model.ZahtevZaPodatke;
import net.sf.jasperreports.engine.JasperPrint;

@Controller
@RequestMapping("/pacijent/uvid")
public class PravoNaUvidIzvestajController {

	@Autowired
	PravoNaUvidIzvestajService service;

	@GetMapping("generisi/{idZahtev}")
	public String generisi(@PathVariable Integer idZahtev, Principal principal, RedirectAttributes ra) {
		try {
			JasperPrint jp = service.kreirajIzvestaj(idZahtev, principal.getName());
			service.sacuvajPdf(idZahtev, jp);
			ra.addFlashAttribute("poruka", "PDF je generisan. Mozete ga preuzeti.");
		} catch (Exception e) {
			e.printStackTrace();
			ra.addFlashAttribute("greska", "Greska pri generisanju.");
		}
		return "redirect:/pacijent/gdpr";
	}

	@GetMapping("preuzmi/{idZahtev}")
	public void preuzmi(@PathVariable Integer idZahtev, Principal principal, HttpServletResponse response)
			throws Exception {
		ZahtevZaPodatke zahtev = service.getZahtev(idZahtev);
		if (zahtev.getKorisnik() == null || !zahtev.getKorisnik().getKorisnickoIme().equals(principal.getName())
				|| zahtev.getPdfPutanja() == null) {
			response.sendError(403);
			return;
		}
		File fajl = new File(zahtev.getPdfPutanja());
		if (!fajl.exists()) {
			response.sendError(404);
			return;
		}
		byte[] bytes = Files.readAllBytes(fajl.toPath());
		response.setContentType("application/pdf");
		response.addHeader("Content-Disposition", "attachment; filename=" + fajl.getName());
		response.setContentLength(bytes.length);
		response.getOutputStream().write(bytes);
		fajl.delete();
		service.ocistiPdf(idZahtev);
	}
}
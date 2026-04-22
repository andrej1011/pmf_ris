package com.example.demo.service;

import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repository.PregledRepository;
import com.example.demo.repository.PacijentRepository;
import com.example.demo.repository.ZahtevZaPodatkeRepository;
import com.example.demo.repository.ZahtevZaPregledRepository;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Service
public class AdminIzvestajService {

	@Autowired
	PregledRepository pregledRepository;
	@Autowired
	PacijentRepository pacijentRepository;
	@Autowired
	ZahtevZaPodatkeRepository zahtevZaPodatkeRepository;
	@Autowired
	ZahtevZaPregledRepository zahtevZaPregledRepository;

	@Transactional
	public JasperPrint kreirajIzvestaj() throws Exception {

		// Top 5 doktora po zavrsenim pregledima
		List<model.Pregled> sviPregledi = pregledRepository.findAll();
		Map<model.Doktor, Long> pregledMap = new java.util.LinkedHashMap<>();
		for (model.Pregled p : sviPregledi) {
			if ("ZAVRSEN".equals(p.getStatus()) && p.getDoktor() != null) {
				pregledMap.merge(p.getDoktor(), 1L, Long::sum);
			}
		}
		StringBuilder topDoktoriSb = new StringBuilder();
		int rank = 1;
		for (Map.Entry<model.Doktor, Long> e : pregledMap.entrySet().stream()
				.sorted(Map.Entry.<model.Doktor, Long>comparingByValue().reversed()).limit(5).toList()) {
			topDoktoriSb.append(rank++).append(". Dr. ").append(e.getKey().getIme()).append(" ")
					.append(e.getKey().getPrezime()).append(" — ").append(e.getValue()).append(" pregleda\n");
		}

		// Top 5 doktora po listi cekanja
		List<model.ZahtevZaPregled> sviZahtevi = zahtevZaPregledRepository.findAll();
		Map<model.Doktor, Long> cekanjemap = new java.util.LinkedHashMap<>();
		for (model.ZahtevZaPregled z : sviZahtevi) {
			if (z.getDoktor() != null) {
				cekanjemap.merge(z.getDoktor(), 1L, Long::sum);
			}
		}
		StringBuilder listaCekanjaSb = new StringBuilder();
		rank = 1;
		for (Map.Entry<model.Doktor, Long> e : cekanjemap.entrySet().stream()
				.sorted(Map.Entry.<model.Doktor, Long>comparingByValue().reversed()).limit(5).toList()) {
			listaCekanjaSb.append(rank++).append(". Dr. ").append(e.getKey().getIme()).append(" ")
					.append(e.getKey().getPrezime()).append(" — ").append(e.getValue()).append(" zahteva\n");
		}

		// Pregledi po statusu
		Map<String, Long> statusMap = new java.util.LinkedHashMap<>();
		for (model.Pregled p : sviPregledi) {
			statusMap.merge(p.getStatus(), 1L, Long::sum);
		}
		StringBuilder preglediSb = new StringBuilder();
		for (Map.Entry<String, Long> e : statusMap.entrySet())
			preglediSb.append(e.getKey()).append(": ").append(e.getValue()).append("\n");

		// GDPR po tipu
		List<model.ZahtevZaPodatke> gdprSvi = zahtevZaPodatkeRepository.findAll();
		Map<String, Long> gdprMap = new java.util.LinkedHashMap<>();
		for (model.ZahtevZaPodatke z : gdprSvi)
			gdprMap.merge(z.getTipZahteva(), 1L, Long::sum);
		StringBuilder gdprSb = new StringBuilder();
		for (Map.Entry<String, Long> e : gdprMap.entrySet())
			gdprSb.append(e.getKey()).append(": ").append(e.getValue()).append("\n");

		Map<String, Object> params = new HashMap<>();
		params.put("topDoktori", topDoktoriSb.toString());
		params.put("listaCekanja", listaCekanjaSb.toString());
		params.put("preglediPoStatusu", preglediSb.toString());
		params.put("noviPacijenti", String.valueOf(pacijentRepository.findAll().size()));
		params.put("gdprPoTipu", gdprSb.toString());
		params.put("datumIzvestaja", new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(new Date()));

		InputStream is = getClass().getResourceAsStream("/jasperreports/adminIzvestaj.jrxml");
		JasperReport jr = JasperCompileManager.compileReport(is);
		JasperPrint jp = JasperFillManager.fillReport(jr, params, new JRBeanCollectionDataSource(List.of()));
		is.close();
		return jp;
	}
}
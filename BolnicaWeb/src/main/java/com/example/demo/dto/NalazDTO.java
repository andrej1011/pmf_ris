package com.example.demo.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class NalazDTO {

	private Integer idPregled;

	private String nalaz;

	private List<String> dijagnoze;

	private List<Integer> lekovi;
	private List<Integer> kolicine;
	private List<String> uputstva;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private List<Date> datumiVazenja;

	public Integer getIdPregled() {
		return idPregled;
	}

	public void setIdPregled(Integer idPregled) {
		this.idPregled = idPregled;
	}

	public String getNalaz() {
		return nalaz;
	}

	public void setNalaz(String nalaz) {
		this.nalaz = nalaz;
	}

	public List<String> getDijagnoze() {
		return dijagnoze;
	}

	public void setDijagnoze(List<String> dijagnoze) {
		this.dijagnoze = dijagnoze;
	}

	public List<Integer> getLekovi() {
		return lekovi;
	}

	public void setLekovi(List<Integer> lekovi) {
		this.lekovi = lekovi;
	}

	public List<Integer> getKolicine() {
		return kolicine;
	}

	public void setKolicine(List<Integer> kolicine) {
		this.kolicine = kolicine;
	}

	public List<String> getUputstva() {
		return uputstva;
	}

	public void setUputstva(List<String> uputstva) {
		this.uputstva = uputstva;
	}

	public List<Date> getDatumiVazenja() {
		return datumiVazenja;
	}

	public void setDatumiVazenja(List<Date> datumiVazenja) {
		this.datumiVazenja = datumiVazenja;
	}
}

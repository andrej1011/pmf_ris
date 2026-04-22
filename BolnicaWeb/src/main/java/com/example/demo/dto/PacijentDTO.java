package com.example.demo.dto;

import java.util.Date;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

public class PacijentDTO {

	@NotBlank(message = "Ime ne sme biti prazno.")
	private String ime;

	private String imeOca;

	@NotBlank(message = "Prezime ne sme biti prazno.")
	private String prezime;

	@NotBlank(message = "JMBG ne sme biti prazan.")
	@Size(min = 13, max = 13, message = "JMBG mora imati tačno 13 cifara.")
	private String jmbg;

	@NotNull(message = "Datum rođenja ne sme biti prazan.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date datumRodjenja;

	private String adresa;

	private String email;

	private String telefon;

	private String lbo;

	@jakarta.validation.constraints.Pattern(regexp = "^[MZ]$", message = "Pol mora biti M ili Z.")
	private String pol;

	private boolean osiguran;

	private String krvnaGrupa;
	private boolean hronicanBolesnik;
	private String alergije;
	private String napomenKarton;

	public String getIme() {
		return ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getImeOca() {
		return imeOca;
	}

	public void setImeOca(String imeOca) {
		this.imeOca = imeOca;
	}

	public String getPrezime() {
		return prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getJmbg() {
		return jmbg;
	}

	public void setJmbg(String jmbg) {
		this.jmbg = jmbg;
	}

	public Date getDatumRodjenja() {
		return datumRodjenja;
	}

	public void setDatumRodjenja(Date datumRodjenja) {
		this.datumRodjenja = datumRodjenja;
	}

	public String getAdresa() {
		return adresa;
	}

	public void setAdresa(String adresa) {
		this.adresa = adresa;
	}

	public String getPol() {
		return pol;
	}

	public void setPol(String pol) {
		this.pol = pol;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTelefon() {
		return telefon;
	}

	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}

	public String getLbo() {
		return lbo;
	}

	public void setLbo(String lbo) {
		this.lbo = lbo;
	}

	public boolean isOsiguran() {
		return osiguran;
	}

	public void setOsiguran(boolean osiguran) {
		this.osiguran = osiguran;
	}

	public String getKrvnaGrupa() {
		return krvnaGrupa;
	}

	public void setKrvnaGrupa(String krvnaGrupa) {
		this.krvnaGrupa = krvnaGrupa;
	}

	public boolean isHronicanBolesnik() {
		return hronicanBolesnik;
	}

	public void setHronicanBolesnik(boolean hronicanBolesnik) {
		this.hronicanBolesnik = hronicanBolesnik;
	}

	public String getAlergije() {
		return alergije;
	}

	public void setAlergije(String alergije) {
		this.alergije = alergije;
	}

	public String getNapomenKarton() {
		return napomenKarton;
	}

	public void setNapomenKarton(String napomenKarton) {
		this.napomenKarton = napomenKarton;
	}
}

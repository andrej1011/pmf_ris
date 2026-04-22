package com.example.demo.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class DoktorDTO {

	@NotBlank(message = "Ime ne sme biti prazno.")
	@Size(max = 50, message = "Ime ne sme biti duže od 50 karaktera.")
	private String ime;

	@NotBlank(message = "Prezime ne sme biti prazno.")
	@Size(max = 50, message = "Prezime ne sme biti duže od 50 karaktera.")
	private String prezime;

	@Size(max = 100, message = "Specijalizacija ne sme biti duža od 100 karaktera.")
	private String specijalizacija;

	@NotBlank(message = "Broj licence ne sme biti prazan.")
	@Size(max = 50, message = "Broj licence ne sme biti duži od 50 karaktera.")
	private String brojLicence;

	@Size(max = 100, message = "Email ne sme biti duži od 100 karaktera.")
	private String email;

	@NotNull(message = "Odeljenje mora biti odabrano.")
	private Integer idOdeljenja;

	public String getIme() {
		return ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getPrezime() {
		return prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getSpecijalizacija() {
		return specijalizacija;
	}

	public void setSpecijalizacija(String specijalizacija) {
		this.specijalizacija = specijalizacija;
	}

	public String getBrojLicence() {
		return brojLicence;
	}

	public void setBrojLicence(String brojLicence) {
		this.brojLicence = brojLicence;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getIdOdeljenja() {
		return idOdeljenja;
	}

	public void setIdOdeljenja(Integer idOdeljenja) {
		this.idOdeljenja = idOdeljenja;
	}
}

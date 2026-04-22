package com.example.demo.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class SestraDTO {

	@NotBlank(message = "Ime ne sme biti prazno.")
	@Size(max = 50, message = "Ime ne sme biti duže od 50 karaktera.")
	private String ime;

	@NotBlank(message = "Prezime ne sme biti prazno.")
	@Size(max = 50, message = "Prezime ne sme biti duže od 50 karaktera.")
	private String prezime;

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
}

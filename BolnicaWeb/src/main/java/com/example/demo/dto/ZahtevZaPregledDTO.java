package com.example.demo.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class ZahtevZaPregledDTO {

	@NotNull(message = "Doktor mora biti odabran.")
	private Integer idDoktora;

	@NotNull(message = "Termin mora biti odabran.")
	private Integer idTermina;

	@Size(max = 500, message = "Napomena ne sme biti duža od 500 karaktera.")
	private String napomena;

	public Integer getIdDoktora() {
		return idDoktora;
	}

	public void setIdDoktora(Integer idDoktora) {
		this.idDoktora = idDoktora;
	}

	public Integer getIdTermina() {
		return idTermina;
	}

	public void setIdTermina(Integer idTermina) {
		this.idTermina = idTermina;
	}

	public String getNapomena() {
		return napomena;
	}

	public void setNapomena(String napomena) {
		this.napomena = napomena;
	}
}

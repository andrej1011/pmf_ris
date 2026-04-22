package com.example.demo.exceptions;

public class PacijentNotFoundException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public PacijentNotFoundException(String poruka, String jmbg) {
		super(poruka + " JMBG: " + jmbg);
	}
}

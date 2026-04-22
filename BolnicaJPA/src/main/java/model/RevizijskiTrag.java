package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the REVIZIJSKI_TRAG database table.
 * 
 */
@Entity
@Table(name="REVIZIJSKI_TRAG")
@NamedQuery(name="RevizijskiTrag.findAll", query="SELECT r FROM RevizijskiTrag r")
public class RevizijskiTrag implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idRevizija;

	private String akcija;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datum;

	private int idObjekta;

	private int idPacijenta;

	private String ipAdresa;

	private String objekat;

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
@JoinColumn(name="idKorisnik")
	private Korisnik korisnik;

	public RevizijskiTrag() {
	}

	public int getIdRevizija() {
		return this.idRevizija;
	}

	public void setIdRevizija(int idRevizija) {
		this.idRevizija = idRevizija;
	}

	public String getAkcija() {
		return this.akcija;
	}

	public void setAkcija(String akcija) {
		this.akcija = akcija;
	}

	public Date getDatum() {
		return this.datum;
	}

	public void setDatum(Date datum) {
		this.datum = datum;
	}

	public int getIdObjekta() {
		return this.idObjekta;
	}

	public void setIdObjekta(int idObjekta) {
		this.idObjekta = idObjekta;
	}

	public int getIdPacijenta() {
		return this.idPacijenta;
	}

	public void setIdPacijenta(int idPacijenta) {
		this.idPacijenta = idPacijenta;
	}

	public String getIpAdresa() {
		return this.ipAdresa;
	}

	public void setIpAdresa(String ipAdresa) {
		this.ipAdresa = ipAdresa;
	}

	public String getObjekat() {
		return this.objekat;
	}

	public void setObjekat(String objekat) {
		this.objekat = objekat;
	}

	public Korisnik getKorisnik() {
		return this.korisnik;
	}

	public void setKorisnik(Korisnik korisnik) {
		this.korisnik = korisnik;
	}

}
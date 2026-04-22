package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the ZAHTEV_ZA_PREGLED database table.
 * 
 */
@Entity
@Table(name="ZAHTEV_ZA_PREGLED")
@NamedQuery(name="ZahtevZaPregled.findAll", query="SELECT z FROM ZahtevZaPregled z")
public class ZahtevZaPregled implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idZahtev;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumObrade;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumZahteva;

	private String komentarDoktora;

	private String napomena;

	private String status;

	//bi-directional many-to-one association to Doktor
	@ManyToOne
@JoinColumn(name="idDoktora")
	private Doktor doktor;

	//bi-directional many-to-one association to Pacijent
	@ManyToOne
@JoinColumn(name="idPacijenta")
	private Pacijent pacijent;

	//bi-directional many-to-one association to Pregled
	@ManyToOne
@JoinColumn(name="idPregleda")
	private Pregled pregled;

	//bi-directional many-to-one association to Termin
	@ManyToOne
@JoinColumn(name="idTermina")
	private Termin termin;

	public ZahtevZaPregled() {
	}

	public int getIdZahtev() {
		return this.idZahtev;
	}

	public void setIdZahtev(int idZahtev) {
		this.idZahtev = idZahtev;
	}

	public Date getDatumObrade() {
		return this.datumObrade;
	}

	public void setDatumObrade(Date datumObrade) {
		this.datumObrade = datumObrade;
	}

	public Date getDatumZahteva() {
		return this.datumZahteva;
	}

	public void setDatumZahteva(Date datumZahteva) {
		this.datumZahteva = datumZahteva;
	}

	public String getKomentarDoktora() {
		return this.komentarDoktora;
	}

	public void setKomentarDoktora(String komentarDoktora) {
		this.komentarDoktora = komentarDoktora;
	}

	public String getNapomena() {
		return this.napomena;
	}

	public void setNapomena(String napomena) {
		this.napomena = napomena;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Doktor getDoktor() {
		return this.doktor;
	}

	public void setDoktor(Doktor doktor) {
		this.doktor = doktor;
	}

	public Pacijent getPacijent() {
		return this.pacijent;
	}

	public void setPacijent(Pacijent pacijent) {
		this.pacijent = pacijent;
	}

	public Pregled getPregled() {
		return this.pregled;
	}

	public void setPregled(Pregled pregled) {
		this.pregled = pregled;
	}

	public Termin getTermin() {
		return this.termin;
	}

	public void setTermin(Termin termin) {
		this.termin = termin;
	}

}
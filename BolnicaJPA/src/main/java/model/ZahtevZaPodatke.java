package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the ZAHTEV_ZA_PODATKE database table.
 * 
 */
@Entity
@Table(name="ZAHTEV_ZA_PODATKE")
@NamedQuery(name="ZahtevZaPodatke.findAll", query="SELECT z FROM ZahtevZaPodatke z")
public class ZahtevZaPodatke implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idZahtev;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumObrade;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumZahteva;

	private String napomena;

	private String status;

	private String tipZahteva;
	
	private String putanjaFajla;
	
	private String pdfPutanja;
	

	//bi-directional many-to-one association to Korisnik
	@ManyToOne
	@JoinColumn(name="korisnickoIme", referencedColumnName="korisnickoIme")
	private Korisnik korisnik;

	public ZahtevZaPodatke() {
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

	public String getTipZahteva() {
		return this.tipZahteva;
	}

	public void setTipZahteva(String tipZahteva) {
		this.tipZahteva = tipZahteva;
	}

	public Korisnik getKorisnik() { 
		return korisnik; 
	}
	
	public void setKorisnik(Korisnik korisnik) { 
		this.korisnik = korisnik; 
	}
	
	public String getPutanjaFajla() { 
		return putanjaFajla; 
	}
	public void setPutanjaFajla(String s) { 
		this.putanjaFajla = s;
	}
	
	public String getPdfPutanja() {
		return pdfPutanja;
	}

	public void setPdfPutanja(String s) {
		this.pdfPutanja = s;
	}
	

}
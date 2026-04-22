package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the DOKTOR database table.
 * 
 */
@Entity
@NamedQuery(name="Doktor.findAll", query="SELECT d FROM Doktor d")
public class Doktor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idDoktor;

	private byte aktivan;

	private String brojLicence;

	private String email;

	private String ime;

	private String prezime;

	private String specijalizacija;

	//bi-directional many-to-one association to Odeljenje
	@ManyToOne
@JoinColumn(name="idOdeljenja")
	private Odeljenje odeljenje;

	//bi-directional many-to-one association to Korisnik
	@OneToMany(mappedBy="doktor")
	private List<Korisnik> korisniks;

	//bi-directional many-to-one association to Odeljenje
	@OneToMany(mappedBy="doktor")
	private List<Odeljenje> odeljenjes;

	//bi-directional many-to-one association to Pregled
	@OneToMany(mappedBy="doktor")
	private List<Pregled> pregleds;

	//bi-directional many-to-one association to RasporedDoktora
	@OneToMany(mappedBy="doktor")
	private List<RasporedDoktora> rasporedDoktoras;

	//bi-directional many-to-one association to Termin
	@OneToMany(mappedBy="doktor")
	private List<Termin> termins;

	//bi-directional many-to-one association to ZahtevZaPregled
	@OneToMany(mappedBy="doktor")
	private List<ZahtevZaPregled> zahtevZaPregleds;

	public Doktor() {
	}

	public int getIdDoktor() {
		return this.idDoktor;
	}

	public void setIdDoktor(int idDoktor) {
		this.idDoktor = idDoktor;
	}

	public byte getAktivan() {
		return this.aktivan;
	}

	public void setAktivan(byte aktivan) {
		this.aktivan = aktivan;
	}

	public String getBrojLicence() {
		return this.brojLicence;
	}

	public void setBrojLicence(String brojLicence) {
		this.brojLicence = brojLicence;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIme() {
		return this.ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getPrezime() {
		return this.prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getSpecijalizacija() {
		return this.specijalizacija;
	}

	public void setSpecijalizacija(String specijalizacija) {
		this.specijalizacija = specijalizacija;
	}

	public Odeljenje getOdeljenje() {
		return this.odeljenje;
	}

	public void setOdeljenje(Odeljenje odeljenje) {
		this.odeljenje = odeljenje;
	}

	public List<Korisnik> getKorisniks() {
		return this.korisniks;
	}

	public void setKorisniks(List<Korisnik> korisniks) {
		this.korisniks = korisniks;
	}

	public Korisnik addKorisnik(Korisnik korisnik) {
		getKorisniks().add(korisnik);
		korisnik.setDoktor(this);

		return korisnik;
	}

	public Korisnik removeKorisnik(Korisnik korisnik) {
		getKorisniks().remove(korisnik);
		korisnik.setDoktor(null);

		return korisnik;
	}

	public List<Odeljenje> getOdeljenjes() {
		return this.odeljenjes;
	}

	public void setOdeljenjes(List<Odeljenje> odeljenjes) {
		this.odeljenjes = odeljenjes;
	}

	public Odeljenje addOdeljenje(Odeljenje odeljenje) {
		getOdeljenjes().add(odeljenje);
		odeljenje.setDoktor(this);

		return odeljenje;
	}

	public Odeljenje removeOdeljenje(Odeljenje odeljenje) {
		getOdeljenjes().remove(odeljenje);
		odeljenje.setDoktor(null);

		return odeljenje;
	}

	public List<Pregled> getPregleds() {
		return this.pregleds;
	}

	public void setPregleds(List<Pregled> pregleds) {
		this.pregleds = pregleds;
	}

	public Pregled addPregled(Pregled pregled) {
		getPregleds().add(pregled);
		pregled.setDoktor(this);

		return pregled;
	}

	public Pregled removePregled(Pregled pregled) {
		getPregleds().remove(pregled);
		pregled.setDoktor(null);

		return pregled;
	}

	public List<RasporedDoktora> getRasporedDoktoras() {
		return this.rasporedDoktoras;
	}

	public void setRasporedDoktoras(List<RasporedDoktora> rasporedDoktoras) {
		this.rasporedDoktoras = rasporedDoktoras;
	}

	public RasporedDoktora addRasporedDoktora(RasporedDoktora rasporedDoktora) {
		getRasporedDoktoras().add(rasporedDoktora);
		rasporedDoktora.setDoktor(this);

		return rasporedDoktora;
	}

	public RasporedDoktora removeRasporedDoktora(RasporedDoktora rasporedDoktora) {
		getRasporedDoktoras().remove(rasporedDoktora);
		rasporedDoktora.setDoktor(null);

		return rasporedDoktora;
	}

	public List<Termin> getTermins() {
		return this.termins;
	}

	public void setTermins(List<Termin> termins) {
		this.termins = termins;
	}

	public Termin addTermin(Termin termin) {
		getTermins().add(termin);
		termin.setDoktor(this);

		return termin;
	}

	public Termin removeTermin(Termin termin) {
		getTermins().remove(termin);
		termin.setDoktor(null);

		return termin;
	}

	public List<ZahtevZaPregled> getZahtevZaPregleds() {
		return this.zahtevZaPregleds;
	}

	public void setZahtevZaPregleds(List<ZahtevZaPregled> zahtevZaPregleds) {
		this.zahtevZaPregleds = zahtevZaPregleds;
	}

	public ZahtevZaPregled addZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().add(zahtevZaPregled);
		zahtevZaPregled.setDoktor(this);

		return zahtevZaPregled;
	}

	public ZahtevZaPregled removeZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().remove(zahtevZaPregled);
		zahtevZaPregled.setDoktor(null);

		return zahtevZaPregled;
	}

}
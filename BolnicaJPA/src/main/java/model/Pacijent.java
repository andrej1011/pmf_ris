package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the PACIJENT database table.
 * 
 */
@Entity
@NamedQuery(name="Pacijent.findAll", query="SELECT p FROM Pacijent p")
public class Pacijent implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idPacijent;

	private String adresa;

	private byte aktivan;

	@Temporal(TemporalType.DATE)
	private Date datumRodjenja;

	private String email;

	private String ime;

	private String imeOca;

	private String jmbg;

	private String lbo;

	private byte osiguran;

	private String prezime;
	
	private String pol;

	private String telefon;

	//bi-directional many-to-one association to GdprSaglasnost
	@OneToMany(mappedBy="pacijent")
	private List<GdprSaglasnost> gdprSaglasnosts;

	//bi-directional many-to-one association to Korisnik
	@OneToMany(mappedBy="pacijent")
	private List<Korisnik> korisniks;

	//bi-directional many-to-one association to Pregled
	@OneToMany(mappedBy="pacijent")
	private List<Pregled> pregleds;


	//bi-directional many-to-one association to ZahtevZaPregled
	@OneToMany(mappedBy="pacijent")
	private List<ZahtevZaPregled> zahtevZaPregleds;

	//bi-directional many-to-one association to ZdravstveniKarton
	@OneToMany(mappedBy="pacijent")
	private List<ZdravstveniKarton> zdravstveniKartons;

	public Pacijent() {
	}

	public int getIdPacijent() {
		return this.idPacijent;
	}

	public void setIdPacijent(int idPacijent) {
		this.idPacijent = idPacijent;
	}

	public String getAdresa() {
		return this.adresa;
	}

	public void setAdresa(String adresa) {
		this.adresa = adresa;
	}

	public byte getAktivan() {
		return this.aktivan;
	}

	public void setAktivan(byte aktivan) {
		this.aktivan = aktivan;
	}

	public Date getDatumRodjenja() {
		return this.datumRodjenja;
	}

	public void setDatumRodjenja(Date datumRodjenja) {
		this.datumRodjenja = datumRodjenja;
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

	public String getImeOca() {
		return this.imeOca;
	}

	public void setImeOca(String imeOca) {
		this.imeOca = imeOca;
	}

	public String getJmbg() {
		return this.jmbg;
	}

	public void setJmbg(String jmbg) {
		this.jmbg = jmbg;
	}

	public String getLbo() {
		return this.lbo;
	}

	public void setLbo(String lbo) {
		this.lbo = lbo;
	}

	public byte getOsiguran() {
		return this.osiguran;
	}

	public void setOsiguran(byte osiguran) {
		this.osiguran = osiguran;
	}

	public String getPrezime() {
		return this.prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getTelefon() {
		return this.telefon;
	}

	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}
	
	public String getPol() {
		return this.pol;
	}

	public void setPol(String pol) {
		this.pol = pol;
	}

	public List<GdprSaglasnost> getGdprSaglasnosts() {
		return this.gdprSaglasnosts;
	}

	public void setGdprSaglasnosts(List<GdprSaglasnost> gdprSaglasnosts) {
		this.gdprSaglasnosts = gdprSaglasnosts;
	}

	public GdprSaglasnost addGdprSaglasnost(GdprSaglasnost gdprSaglasnost) {
		getGdprSaglasnosts().add(gdprSaglasnost);
		gdprSaglasnost.setPacijent(this);

		return gdprSaglasnost;
	}

	public GdprSaglasnost removeGdprSaglasnost(GdprSaglasnost gdprSaglasnost) {
		getGdprSaglasnosts().remove(gdprSaglasnost);
		gdprSaglasnost.setPacijent(null);

		return gdprSaglasnost;
	}

	public List<Korisnik> getKorisniks() {
		return this.korisniks;
	}

	public void setKorisniks(List<Korisnik> korisniks) {
		this.korisniks = korisniks;
	}

	public Korisnik addKorisnik(Korisnik korisnik) {
		getKorisniks().add(korisnik);
		korisnik.setPacijent(this);

		return korisnik;
	}

	public Korisnik removeKorisnik(Korisnik korisnik) {
		getKorisniks().remove(korisnik);
		korisnik.setPacijent(null);

		return korisnik;
	}

	public List<Pregled> getPregleds() {
		return this.pregleds;
	}

	public void setPregleds(List<Pregled> pregleds) {
		this.pregleds = pregleds;
	}

	public Pregled addPregled(Pregled pregled) {
		getPregleds().add(pregled);
		pregled.setPacijent(this);

		return pregled;
	}

	public Pregled removePregled(Pregled pregled) {
		getPregleds().remove(pregled);
		pregled.setPacijent(null);

		return pregled;
	}

	public List<ZahtevZaPregled> getZahtevZaPregleds() {
		return this.zahtevZaPregleds;
	}

	public void setZahtevZaPregleds(List<ZahtevZaPregled> zahtevZaPregleds) {
		this.zahtevZaPregleds = zahtevZaPregleds;
	}

	public ZahtevZaPregled addZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().add(zahtevZaPregled);
		zahtevZaPregled.setPacijent(this);

		return zahtevZaPregled;
	}

	public ZahtevZaPregled removeZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().remove(zahtevZaPregled);
		zahtevZaPregled.setPacijent(null);

		return zahtevZaPregled;
	}

	public List<ZdravstveniKarton> getZdravstveniKartons() {
		return this.zdravstveniKartons;
	}

	public void setZdravstveniKartons(List<ZdravstveniKarton> zdravstveniKartons) {
		this.zdravstveniKartons = zdravstveniKartons;
	}

	public ZdravstveniKarton addZdravstveniKarton(ZdravstveniKarton zdravstveniKarton) {
		getZdravstveniKartons().add(zdravstveniKarton);
		zdravstveniKarton.setPacijent(this);

		return zdravstveniKarton;
	}

	public ZdravstveniKarton removeZdravstveniKarton(ZdravstveniKarton zdravstveniKarton) {
		getZdravstveniKartons().remove(zdravstveniKarton);
		zdravstveniKarton.setPacijent(null);

		return zdravstveniKarton;
	}

}
package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the KORISNIK database table.
 * 
 */
@Entity
@NamedQuery(name="Korisnik.findAll", query="SELECT k FROM Korisnik k")
public class Korisnik implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idKorisnik;

	private byte aktivan;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumKreiranja;

	private String korisnickoIme;

	private String lozinka;

	private String uloga;

	//bi-directional many-to-one association to Doktor
	@ManyToOne
@JoinColumn(name="idDoktora")
	private Doktor doktor;

	//bi-directional many-to-one association to Pacijent
	@ManyToOne
@JoinColumn(name="idPacijenta")
	private Pacijent pacijent;

	//bi-directional many-to-one association to RevizijskiTrag
	@OneToMany(mappedBy="korisnik")
	private List<RevizijskiTrag> revizijskiTrags;

	public Korisnik() {
	}

	public int getIdKorisnik() {
		return this.idKorisnik;
	}

	public void setIdKorisnik(int idKorisnik) {
		this.idKorisnik = idKorisnik;
	}

	public byte getAktivan() {
		return this.aktivan;
	}

	public void setAktivan(byte aktivan) {
		this.aktivan = aktivan;
	}

	public Date getDatumKreiranja() {
		return this.datumKreiranja;
	}

	public void setDatumKreiranja(Date datumKreiranja) {
		this.datumKreiranja = datumKreiranja;
	}

	public String getKorisnickoIme() {
		return this.korisnickoIme;
	}

	public void setKorisnickoIme(String korisnickoIme) {
		this.korisnickoIme = korisnickoIme;
	}

	public String getLozinka() {
		return this.lozinka;
	}

	public void setLozinka(String lozinka) {
		this.lozinka = lozinka;
	}

	public String getUloga() {
		return this.uloga;
	}

	public void setUloga(String uloga) {
		this.uloga = uloga;
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

	public List<RevizijskiTrag> getRevizijskiTrags() {
		return this.revizijskiTrags;
	}

	public void setRevizijskiTrags(List<RevizijskiTrag> revizijskiTrags) {
		this.revizijskiTrags = revizijskiTrags;
	}

	public RevizijskiTrag addRevizijskiTrag(RevizijskiTrag revizijskiTrag) {
		getRevizijskiTrags().add(revizijskiTrag);
		revizijskiTrag.setKorisnik(this);

		return revizijskiTrag;
	}

	public RevizijskiTrag removeRevizijskiTrag(RevizijskiTrag revizijskiTrag) {
		getRevizijskiTrags().remove(revizijskiTrag);
		revizijskiTrag.setKorisnik(null);

		return revizijskiTrag;
	}

}
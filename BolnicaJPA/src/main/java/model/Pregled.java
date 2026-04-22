package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the PREGLED database table.
 * 
 */
@Entity
@NamedQuery(name="Pregled.findAll", query="SELECT p FROM Pregled p")
public class Pregled implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idPregled;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumVreme;

	private String komentarOtkazivanja;

	private String nalaz;

	private String status;

	@Temporal(TemporalType.TIMESTAMP)
	private Date vremeZavrsetka;

	//bi-directional many-to-one association to Doktor
	@ManyToOne
@JoinColumn(name="idDoktora")
	private Doktor doktor;

	//bi-directional many-to-one association to Pacijent
	@ManyToOne
@JoinColumn(name="idPacijenta")
	private Pacijent pacijent;

	//bi-directional many-to-one association to Termin
	@ManyToOne
@JoinColumn(name="idTermina")
	private Termin termin;

	//bi-directional many-to-many association to Dijagnoza
	@ManyToMany
	@JoinTable(
		name="PREGLED_DIJAGNOZA"
		, joinColumns={
@JoinColumn(name="idPregled")
			}
		, inverseJoinColumns={
@JoinColumn(name="sifra")
			}
		)
	private List<Dijagnoza> dijagnozas;

	//bi-directional many-to-one association to Recept
	@OneToMany(mappedBy="pregled")
	private List<Recept> recepts;

	//bi-directional many-to-one association to ZahtevZaPregled
	@OneToMany(mappedBy="pregled")
	private List<ZahtevZaPregled> zahtevZaPregleds;

	public Pregled() {
	}

	public int getIdPregled() {
		return this.idPregled;
	}

	public void setIdPregled(int idPregled) {
		this.idPregled = idPregled;
	}

	public Date getDatumVreme() {
		return this.datumVreme;
	}

	public void setDatumVreme(Date datumVreme) {
		this.datumVreme = datumVreme;
	}

	public String getKomentarOtkazivanja() {
		return this.komentarOtkazivanja;
	}

	public void setKomentarOtkazivanja(String komentarOtkazivanja) {
		this.komentarOtkazivanja = komentarOtkazivanja;
	}

	public String getNalaz() {
		return this.nalaz;
	}

	public void setNalaz(String nalaz) {
		this.nalaz = nalaz;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getVremeZavrsetka() {
		return this.vremeZavrsetka;
	}

	public void setVremeZavrsetka(Date vremeZavrsetka) {
		this.vremeZavrsetka = vremeZavrsetka;
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

	public Termin getTermin() {
		return this.termin;
	}

	public void setTermin(Termin termin) {
		this.termin = termin;
	}

	public List<Dijagnoza> getDijagnozas() {
		return this.dijagnozas;
	}

	public void setDijagnozas(List<Dijagnoza> dijagnozas) {
		this.dijagnozas = dijagnozas;
	}

	public List<Recept> getRecepts() {
		return this.recepts;
	}

	public void setRecepts(List<Recept> recepts) {
		this.recepts = recepts;
	}

	public Recept addRecept(Recept recept) {
		getRecepts().add(recept);
		recept.setPregled(this);

		return recept;
	}

	public Recept removeRecept(Recept recept) {
		getRecepts().remove(recept);
		recept.setPregled(null);

		return recept;
	}

	public List<ZahtevZaPregled> getZahtevZaPregleds() {
		return this.zahtevZaPregleds;
	}

	public void setZahtevZaPregleds(List<ZahtevZaPregled> zahtevZaPregleds) {
		this.zahtevZaPregleds = zahtevZaPregleds;
	}

	public ZahtevZaPregled addZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().add(zahtevZaPregled);
		zahtevZaPregled.setPregled(this);

		return zahtevZaPregled;
	}

	public ZahtevZaPregled removeZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().remove(zahtevZaPregled);
		zahtevZaPregled.setPregled(null);

		return zahtevZaPregled;
	}

}
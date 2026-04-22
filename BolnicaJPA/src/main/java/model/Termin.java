package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the TERMIN database table.
 * 
 */
@Entity
@NamedQuery(name="Termin.findAll", query="SELECT t FROM Termin t")
public class Termin implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idTermin;

	@Temporal(TemporalType.TIMESTAMP)
	private Date datumVreme;

	private byte dostupan;

	private int trajanje;

	//bi-directional many-to-one association to Pregled
	@OneToMany(mappedBy="termin")
	private List<Pregled> pregleds;

	//bi-directional many-to-one association to Doktor
	@ManyToOne
@JoinColumn(name="idDoktora")
	private Doktor doktor;

	//bi-directional many-to-one association to RasporedDoktora
	@ManyToOne
@JoinColumn(name="idRasporeda")
	private RasporedDoktora rasporedDoktora;

	//bi-directional many-to-one association to ZahtevZaPregled
	@OneToMany(mappedBy="termin")
	private List<ZahtevZaPregled> zahtevZaPregleds;

	public Termin() {
	}

	public int getIdTermin() {
		return this.idTermin;
	}

	public void setIdTermin(int idTermin) {
		this.idTermin = idTermin;
	}

	public Date getDatumVreme() {
		return this.datumVreme;
	}

	public void setDatumVreme(Date datumVreme) {
		this.datumVreme = datumVreme;
	}

	public byte getDostupan() {
		return this.dostupan;
	}

	public void setDostupan(byte dostupan) {
		this.dostupan = dostupan;
	}

	public int getTrajanje() {
		return this.trajanje;
	}

	public void setTrajanje(int trajanje) {
		this.trajanje = trajanje;
	}

	public List<Pregled> getPregleds() {
		return this.pregleds;
	}

	public void setPregleds(List<Pregled> pregleds) {
		this.pregleds = pregleds;
	}

	public Pregled addPregled(Pregled pregled) {
		getPregleds().add(pregled);
		pregled.setTermin(this);

		return pregled;
	}

	public Pregled removePregled(Pregled pregled) {
		getPregleds().remove(pregled);
		pregled.setTermin(null);

		return pregled;
	}

	public Doktor getDoktor() {
		return this.doktor;
	}

	public void setDoktor(Doktor doktor) {
		this.doktor = doktor;
	}

	public RasporedDoktora getRasporedDoktora() {
		return this.rasporedDoktora;
	}

	public void setRasporedDoktora(RasporedDoktora rasporedDoktora) {
		this.rasporedDoktora = rasporedDoktora;
	}

	public List<ZahtevZaPregled> getZahtevZaPregleds() {
		return this.zahtevZaPregleds;
	}

	public void setZahtevZaPregleds(List<ZahtevZaPregled> zahtevZaPregleds) {
		this.zahtevZaPregleds = zahtevZaPregleds;
	}

	public ZahtevZaPregled addZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().add(zahtevZaPregled);
		zahtevZaPregled.setTermin(this);

		return zahtevZaPregled;
	}

	public ZahtevZaPregled removeZahtevZaPregled(ZahtevZaPregled zahtevZaPregled) {
		getZahtevZaPregleds().remove(zahtevZaPregled);
		zahtevZaPregled.setTermin(null);

		return zahtevZaPregled;
	}

}
package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Time;
import java.util.List;


/**
 * The persistent class for the RASPORED_DOKTORA database table.
 * 
 */
@Entity
@Table(name="RASPORED_DOKTORA")
@NamedQuery(name="RasporedDoktora.findAll", query="SELECT r FROM RasporedDoktora r")
public class RasporedDoktora implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idRaspored;

	private byte aktivan;

	private byte danUNedelji;

	private int trajanje;

	private Time vremeDo;

	private Time vremeOd;

	//bi-directional many-to-one association to Doktor
	@ManyToOne
@JoinColumn(name="idDoktora")
	private Doktor doktor;

	//bi-directional many-to-one association to Termin
	@OneToMany(mappedBy="rasporedDoktora")
	private List<Termin> termins;

	public RasporedDoktora() {
	}

	public int getIdRaspored() {
		return this.idRaspored;
	}

	public void setIdRaspored(int idRaspored) {
		this.idRaspored = idRaspored;
	}

	public byte getAktivan() {
		return this.aktivan;
	}

	public void setAktivan(byte aktivan) {
		this.aktivan = aktivan;
	}

	public byte getDanUNedelji() {
		return this.danUNedelji;
	}

	public void setDanUNedelji(byte danUNedelji) {
		this.danUNedelji = danUNedelji;
	}

	public int getTrajanje() {
		return this.trajanje;
	}

	public void setTrajanje(int trajanje) {
		this.trajanje = trajanje;
	}

	public Time getVremeDo() {
		return this.vremeDo;
	}

	public void setVremeDo(Time vremeDo) {
		this.vremeDo = vremeDo;
	}

	public Time getVremeOd() {
		return this.vremeOd;
	}

	public void setVremeOd(Time vremeOd) {
		this.vremeOd = vremeOd;
	}

	public Doktor getDoktor() {
		return this.doktor;
	}

	public void setDoktor(Doktor doktor) {
		this.doktor = doktor;
	}

	public List<Termin> getTermins() {
		return this.termins;
	}

	public void setTermins(List<Termin> termins) {
		this.termins = termins;
	}

	public Termin addTermin(Termin termin) {
		getTermins().add(termin);
		termin.setRasporedDoktora(this);

		return termin;
	}

	public Termin removeTermin(Termin termin) {
		getTermins().remove(termin);
		termin.setRasporedDoktora(null);

		return termin;
	}

}
package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the ODELJENJE database table.
 * 
 */
@Entity
@NamedQuery(name="Odeljenje.findAll", query="SELECT o FROM Odeljenje o")
public class Odeljenje implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idOdeljenje;

	private String lokacija;

	private String naziv;

	//bi-directional many-to-one association to Doktor
	@OneToMany(mappedBy="odeljenje")
	private List<Doktor> doktors;

	//bi-directional many-to-one association to Doktor
	@ManyToOne
@JoinColumn(name="idNacelnika")
	private Doktor doktor;

	public Odeljenje() {
	}

	public int getIdOdeljenje() {
		return this.idOdeljenje;
	}

	public void setIdOdeljenje(int idOdeljenje) {
		this.idOdeljenje = idOdeljenje;
	}

	public String getLokacija() {
		return this.lokacija;
	}

	public void setLokacija(String lokacija) {
		this.lokacija = lokacija;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public List<Doktor> getDoktors() {
		return this.doktors;
	}

	public void setDoktors(List<Doktor> doktors) {
		this.doktors = doktors;
	}

	public Doktor addDoktor(Doktor doktor) {
		getDoktors().add(doktor);
		doktor.setOdeljenje(this);

		return doktor;
	}

	public Doktor removeDoktor(Doktor doktor) {
		getDoktors().remove(doktor);
		doktor.setOdeljenje(null);

		return doktor;
	}

	public Doktor getDoktor() {
		return this.doktor;
	}

	public void setDoktor(Doktor doktor) {
		this.doktor = doktor;
	}

}
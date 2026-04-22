package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the DIJAGNOZA database table.
 * 
 */
@Entity
@NamedQuery(name="Dijagnoza.findAll", query="SELECT d FROM Dijagnoza d")
public class Dijagnoza implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String sifra;

	private String opis;

	//bi-directional many-to-many association to Pregled
	@ManyToMany(mappedBy="dijagnozas")
	private List<Pregled> pregleds;

	public Dijagnoza() {
	}

	public String getSifra() {
		return this.sifra;
	}

	public void setSifra(String sifra) {
		this.sifra = sifra;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public List<Pregled> getPregleds() {
		return this.pregleds;
	}

	public void setPregleds(List<Pregled> pregleds) {
		this.pregleds = pregleds;
	}

}
package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the LEK database table.
 * 
 */
@Entity
@NamedQuery(name="Lek.findAll", query="SELECT l FROM Lek l")
public class Lek implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idLek;

	private String aktivnaMaterija;

	private byte kategorijaRX;

	private String naziv;

	private String proizvodjac;

	//bi-directional many-to-one association to Recept
	@OneToMany(mappedBy="lek")
	private List<Recept> recepts;

	public Lek() {
	}

	public int getIdLek() {
		return this.idLek;
	}

	public void setIdLek(int idLek) {
		this.idLek = idLek;
	}

	public String getAktivnaMaterija() {
		return this.aktivnaMaterija;
	}

	public void setAktivnaMaterija(String aktivnaMaterija) {
		this.aktivnaMaterija = aktivnaMaterija;
	}

	public byte getKategorijaRX() {
		return this.kategorijaRX;
	}

	public void setKategorijaRX(byte kategorijaRX) {
		this.kategorijaRX = kategorijaRX;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getProizvodjac() {
		return this.proizvodjac;
	}

	public void setProizvodjac(String proizvodjac) {
		this.proizvodjac = proizvodjac;
	}

	public List<Recept> getRecepts() {
		return this.recepts;
	}

	public void setRecepts(List<Recept> recepts) {
		this.recepts = recepts;
	}

	public Recept addRecept(Recept recept) {
		getRecepts().add(recept);
		recept.setLek(this);

		return recept;
	}

	public Recept removeRecept(Recept recept) {
		getRecepts().remove(recept);
		recept.setLek(null);

		return recept;
	}

}
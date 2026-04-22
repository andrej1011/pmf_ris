package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the RECEPT database table.
 * 
 */
@Entity
@NamedQuery(name="Recept.findAll", query="SELECT r FROM Recept r")
public class Recept implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idRecept;

	@Temporal(TemporalType.DATE)
	private Date datumIzdavanja;

	@Temporal(TemporalType.DATE)
	private Date datumVazenja;

	private int kolicina;

	private byte podignut;

	private String uputstvo;

	//bi-directional many-to-one association to Lek
	@ManyToOne
@JoinColumn(name="idLek")
	private Lek lek;

	//bi-directional many-to-one association to Pregled
	@ManyToOne
@JoinColumn(name="idPregled")
	private Pregled pregled;

	public Recept() {
	}

	public int getIdRecept() {
		return this.idRecept;
	}

	public void setIdRecept(int idRecept) {
		this.idRecept = idRecept;
	}

	public Date getDatumIzdavanja() {
		return this.datumIzdavanja;
	}

	public void setDatumIzdavanja(Date datumIzdavanja) {
		this.datumIzdavanja = datumIzdavanja;
	}

	public Date getDatumVazenja() {
		return this.datumVazenja;
	}

	public void setDatumVazenja(Date datumVazenja) {
		this.datumVazenja = datumVazenja;
	}

	public int getKolicina() {
		return this.kolicina;
	}

	public void setKolicina(int kolicina) {
		this.kolicina = kolicina;
	}

	public byte getPodignut() {
		return this.podignut;
	}

	public void setPodignut(byte podignut) {
		this.podignut = podignut;
	}

	public String getUputstvo() {
		return this.uputstvo;
	}

	public void setUputstvo(String uputstvo) {
		this.uputstvo = uputstvo;
	}

	public Lek getLek() {
		return this.lek;
	}

	public void setLek(Lek lek) {
		this.lek = lek;
	}

	public Pregled getPregled() {
		return this.pregled;
	}

	public void setPregled(Pregled pregled) {
		this.pregled = pregled;
	}

}
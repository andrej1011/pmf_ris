package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the ZDRAVSTVENI_KARTON database table.
 * 
 */
@Entity
@Table(name="ZDRAVSTVENI_KARTON")
@NamedQuery(name="ZdravstveniKarton.findAll", query="SELECT z FROM ZdravstveniKarton z")
public class ZdravstveniKarton implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idKarton;

	private String alergije;

	@Temporal(TemporalType.DATE)
	private Date datumKreiranja;

	private byte hronicanBolesnik;

	private String krvnaGrupa;

	private String napomena;

	//bi-directional many-to-one association to Pacijent
	@ManyToOne
@JoinColumn(name="idPacijenta")
	private Pacijent pacijent;

	public ZdravstveniKarton() {
	}

	public int getIdKarton() {
		return this.idKarton;
	}

	public void setIdKarton(int idKarton) {
		this.idKarton = idKarton;
	}

	public String getAlergije() {
		return this.alergije;
	}

	public void setAlergije(String alergije) {
		this.alergije = alergije;
	}

	public Date getDatumKreiranja() {
		return this.datumKreiranja;
	}

	public void setDatumKreiranja(Date datumKreiranja) {
		this.datumKreiranja = datumKreiranja;
	}

	public byte getHronicanBolesnik() {
		return this.hronicanBolesnik;
	}

	public void setHronicanBolesnik(byte hronicanBolesnik) {
		this.hronicanBolesnik = hronicanBolesnik;
	}

	public String getKrvnaGrupa() {
		return this.krvnaGrupa;
	}

	public void setKrvnaGrupa(String krvnaGrupa) {
		this.krvnaGrupa = krvnaGrupa;
	}

	public String getNapomena() {
		return this.napomena;
	}

	public void setNapomena(String napomena) {
		this.napomena = napomena;
	}

	public Pacijent getPacijent() {
		return this.pacijent;
	}

	public void setPacijent(Pacijent pacijent) {
		this.pacijent = pacijent;
	}

}
package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;


/**
 * The persistent class for the GDPR_SAGLASNOST database table.
 * 
 */
@Entity
@Table(name="GDPR_SAGLASNOST")
@NamedQuery(name="GdprSaglasnost.findAll", query="SELECT g FROM GdprSaglasnost g")
public class GdprSaglasnost implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int idSaglasnost;

	private byte aktivan;

	@Temporal(TemporalType.DATE)
	private Date datumDavanja;

	@Temporal(TemporalType.DATE)
	private Date datumIsteka;

	private String tipSaglasnosti;

	//bi-directional many-to-one association to Pacijent
	@ManyToOne
@JoinColumn(name="idPacijenta")
	private Pacijent pacijent;

	public GdprSaglasnost() {
	}

	public int getIdSaglasnost() {
		return this.idSaglasnost;
	}

	public void setIdSaglasnost(int idSaglasnost) {
		this.idSaglasnost = idSaglasnost;
	}

	public byte getAktivan() {
		return this.aktivan;
	}

	public void setAktivan(byte aktivan) {
		this.aktivan = aktivan;
	}

	public Date getDatumDavanja() {
		return this.datumDavanja;
	}

	public void setDatumDavanja(Date datumDavanja) {
		this.datumDavanja = datumDavanja;
	}

	public Date getDatumIsteka() {
		return this.datumIsteka;
	}

	public void setDatumIsteka(Date datumIsteka) {
		this.datumIsteka = datumIsteka;
	}

	public String getTipSaglasnosti() {
		return this.tipSaglasnosti;
	}

	public void setTipSaglasnosti(String tipSaglasnosti) {
		this.tipSaglasnosti = tipSaglasnosti;
	}

	public Pacijent getPacijent() {
		return this.pacijent;
	}

	public void setPacijent(Pacijent pacijent) {
		this.pacijent = pacijent;
	}

}
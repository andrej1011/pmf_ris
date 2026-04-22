package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import model.Doktor;
import model.Pacijent;
import model.Pregled;

@Repository
public interface PregledRepository extends JpaRepository<Pregled, Integer> {

	List<Pregled> findByPacijentAndStatus(Pacijent pacijent, String status);

	List<Pregled> findByPacijentOrderByDatumVremeDesc(Pacijent pacijent);

	List<Pregled> findByDoktorAndStatus(Doktor doktor, String status);

	List<Pregled> findByDoktorOrderByDatumVremeDesc(Doktor doktor);

	List<Pregled> findByDoktorAndPacijentJmbgOrderByDatumVremeDesc(Doktor doktor, String jmbg);

	Pregled findByDoktorAndPacijentJmbgAndStatus(Doktor doktor, String jmbg, String status);

	Pregled findByDoktorAndPacijentLboAndStatus(Doktor doktor, String lbo, String status);

	@Transactional
	@Modifying
	@Query("UPDATE Pregled p SET p.status = :status WHERE p.idPregled = :id")
	int updateStatus(@Param("id") Integer id, @Param("status") String status);

	@Transactional
	@Modifying
	@Query(value = "UPDATE PREGLED SET idPacijenta = :obrisanId WHERE idPacijenta = :oldId", nativeQuery = true)
	void reassignPacijent(@Param("oldId") int oldId, @Param("obrisanId") int obrisanId);
}

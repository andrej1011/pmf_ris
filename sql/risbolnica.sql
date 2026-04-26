-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: ris_bolnica
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `DIJAGNOZA`
--

DROP TABLE IF EXISTS `DIJAGNOZA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DIJAGNOZA` (
  `sifra` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opis` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`sifra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DIJAGNOZA`
--

LOCK TABLES `DIJAGNOZA` WRITE;
/*!40000 ALTER TABLE `DIJAGNOZA` DISABLE KEYS */;
INSERT INTO `DIJAGNOZA` VALUES ('E11','Dijabetes melitus tip 2'),('F41.1','Generalizovani anksiozni poremećaj'),('G43','Migrena'),('I10','Esencijalna (primarna) hipertenzija'),('I25.1','Aterosklerotska bolest srca'),('J06.9','Akutna infekcija gornjeg respiratornog trakta, nespecifikovana'),('K29.5','Hronični gastritis, nespecifikovan'),('M43.6','Tortikollis'),('M54.5','Bol u donjem delu leđa'),('N39.0','Infekcija urinarnog trakta, nespecifikovana');
/*!40000 ALTER TABLE `DIJAGNOZA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DOKTOR`
--

DROP TABLE IF EXISTS `DOKTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DOKTOR` (
  `idDoktor` int NOT NULL AUTO_INCREMENT,
  `ime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prezime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specijalizacija` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brojLicence` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idOdeljenja` int NOT NULL,
  `aktivan` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idDoktor`),
  UNIQUE KEY `uq_brojLicence` (`brojLicence`),
  UNIQUE KEY `uq_doktor_email` (`email`),
  KEY `fk_doktor_odeljenje` (`idOdeljenja`),
  CONSTRAINT `fk_doktor_odeljenje` FOREIGN KEY (`idOdeljenja`) REFERENCES `ODELJENJE` (`idOdeljenje`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DOKTOR`
--

LOCK TABLES `DOKTOR` WRITE;
/*!40000 ALTER TABLE `DOKTOR` DISABLE KEYS */;
INSERT INTO `DOKTOR` VALUES (1,'Marko','Petrović','Interna medicina','114518','m.petrovic@bolnica.rs',1,1),(2,'Jelena','Nikolić','Hirurgija','306732','j.nikolic@bolnica.rs',2,1),(3,'Stefan','Jovanović','Neurologija','206937','s.jovanovic@bolnica.rs',3,1),(4,'Ana','Milošević','Fizikalna medicina i rehabilitacija','403264','a.milosevic@bolnica.rs',4,1),(5,'Nikola','Stojanović','Pedijatrija','118379','n.stojanovic@bolnica.rs',5,1),(9,'Marta','Stefanović','Ortopedija sa traumatologijom','308099','marta@bolnica.rs',4,1);
/*!40000 ALTER TABLE `DOKTOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GDPR_SAGLASNOST`
--

DROP TABLE IF EXISTS `GDPR_SAGLASNOST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GDPR_SAGLASNOST` (
  `idSaglasnost` int NOT NULL AUTO_INCREMENT,
  `idPacijenta` int NOT NULL,
  `tipSaglasnosti` enum('OSNOVNA_OBRADA','ISTRAZIVANJE','MARKETING') COLLATE utf8mb4_unicode_ci NOT NULL,
  `datumDavanja` date NOT NULL DEFAULT (curdate()),
  `datumIsteka` date DEFAULT NULL,
  `aktivan` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idSaglasnost`),
  KEY `idx_saglasnost_pacijent` (`idPacijenta`),
  CONSTRAINT `fk_saglasnost_pacijent` FOREIGN KEY (`idPacijenta`) REFERENCES `PACIJENT` (`idPacijent`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GDPR_SAGLASNOST`
--

LOCK TABLES `GDPR_SAGLASNOST` WRITE;
/*!40000 ALTER TABLE `GDPR_SAGLASNOST` DISABLE KEYS */;
INSERT INTO `GDPR_SAGLASNOST` VALUES (1,1,'OSNOVNA_OBRADA','2025-10-15',NULL,1),(2,1,'ISTRAZIVANJE','2025-10-15','2026-10-15',1),(3,2,'OSNOVNA_OBRADA','2025-10-15',NULL,1),(4,2,'ISTRAZIVANJE','2025-10-15','2026-10-15',1),(5,3,'OSNOVNA_OBRADA','2025-10-16',NULL,1),(6,3,'MARKETING','2025-10-16','2026-01-16',0),(7,4,'OSNOVNA_OBRADA','2025-10-16',NULL,1),(8,5,'OSNOVNA_OBRADA','2025-10-17',NULL,1),(9,6,'OSNOVNA_OBRADA','2025-11-20',NULL,1);
/*!40000 ALTER TABLE `GDPR_SAGLASNOST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KORISNIK`
--

DROP TABLE IF EXISTS `KORISNIK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KORISNIK` (
  `idKorisnik` int NOT NULL AUTO_INCREMENT,
  `korisnickoIme` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lozinka` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uloga` enum('PACIJENT','DOKTOR','SESTRA','ADMIN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `idPacijenta` int DEFAULT NULL,
  `idDoktora` int DEFAULT NULL,
  `aktivan` tinyint(1) NOT NULL DEFAULT '1',
  `datumKreiranja` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idKorisnik`),
  UNIQUE KEY `uq_korisnickoIme` (`korisnickoIme`),
  KEY `fk_korisnik_pacijent` (`idPacijenta`),
  KEY `fk_korisnik_doktor` (`idDoktora`),
  KEY `idx_korisnik_uloga` (`uloga`),
  CONSTRAINT `fk_korisnik_doktor` FOREIGN KEY (`idDoktora`) REFERENCES `DOKTOR` (`idDoktor`) ON DELETE SET NULL,
  CONSTRAINT `fk_korisnik_pacijent` FOREIGN KEY (`idPacijenta`) REFERENCES `PACIJENT` (`idPacijent`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KORISNIK`
--

LOCK TABLES `KORISNIK` WRITE;
/*!40000 ALTER TABLE `KORISNIK` DISABLE KEYS */;
INSERT INTO `KORISNIK` VALUES (1,'admin','$2a$10$y1ksE9Ja/3avST53pXue9.ACAgo8pTCJRoHoMAYo/IWRBfB3Q.qAm','ADMIN',NULL,NULL,1,'2025-09-01 08:00:00'),(2,'sestra1','$2a$10$QMg/L0GkldZGZuWx5gmWLONpNP.DtHDhxt3RMge2TmnxCp4nSM7wG','SESTRA',NULL,NULL,1,'2025-09-01 08:30:00'),(3,'sestra2','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','SESTRA',NULL,NULL,1,'2025-09-01 08:30:00'),(4,'markpetrovic','$2a$10$OeZ3aGDua8p5hnXTjT.PVOlyRIqoO2bZvApo/pyBkYdB92bB1CxRS','DOKTOR',NULL,1,1,'2025-09-01 09:00:00'),(5,'jelenikolic','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','DOKTOR',NULL,2,1,'2025-09-01 09:00:00'),(6,'stefanjovanovic','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','DOKTOR',NULL,3,1,'2025-09-01 09:00:00'),(7,'anamilosevic','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','DOKTOR',NULL,4,1,'2025-09-01 09:00:00'),(8,'nikolastojanovic','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','DOKTOR',NULL,5,1,'2025-09-01 09:00:00'),(9,'milandjordjevic847','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','PACIJENT',1,NULL,1,'2025-10-15 10:00:00'),(10,'jovanapopovic213','$2a$10$cD4of4HA9aOJXG78aF4wBuNaW6oBQ7WFXLbO/AQTPFcLhA.xiUkEe','PACIJENT',2,NULL,1,'2025-10-15 10:15:00'),(11,'aleksandarstankovic561','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','PACIJENT',3,NULL,1,'2025-10-16 09:00:00'),(12,'milicavasic392','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','PACIJENT',4,NULL,1,'2025-10-16 09:30:00'),(13,'draganmarkovic174','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','PACIJENT',5,NULL,1,'2025-10-17 11:00:00'),(14,'sofijadjuric628','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','PACIJENT',6,NULL,1,'2025-11-20 10:00:00'),(23,'martastefanovic401','b98d813ce02220df65d7f0d457eed37a944676f5650ad1e94d3f63f539f7b155','DOKTOR',NULL,9,1,'2026-04-20 18:23:03'),(35,'svetlanas231','$2a$10$IwDTi5Afdw08JT8THzJw3OSAbhccuTyFr9JA3451dwkxqPb5qCGMK','SESTRA',NULL,NULL,1,'2026-04-22 12:49:45'),(36,'jovanajovanic729','$2a$10$MGj1pkJ9GEIkbp9oufCwTeu1jrf6FgOR4UhaN8LVmfNcFbe3Jiug.','PACIJENT',17,NULL,1,'2026-04-22 12:51:34');
/*!40000 ALTER TABLE `KORISNIK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LEK`
--

DROP TABLE IF EXISTS `LEK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LEK` (
  `idLek` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aktivnaMaterija` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proizvodjac` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kategorijaRX` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idLek`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LEK`
--

LOCK TABLES `LEK` WRITE;
/*!40000 ALTER TABLE `LEK` DISABLE KEYS */;
INSERT INTO `LEK` VALUES (1,'Amlodipin 5mg','amlodipin','KRKA',1),(2,'Metformin 500mg','metformin hidrohlorid','Hemofarm',1),(3,'Aspirin 100mg','acetilsalicilna kiselina','Bayer',0),(4,'Ibuprofen 400mg','ibuprofen','Galenika',0),(5,'Omeprazol 20mg','omeprazol','KRKA',1),(6,'Paracetamol 500mg','paracetamol','Hemofarm',0),(7,'Diazepam 5mg','diazepam','Galenika',1),(8,'Lisinopril 10mg','lizinopril','KRKA',1),(9,'Atorvastatin 20mg','atorvastatin','Pfizer',1),(10,'Amoksicilin 500mg','amoksicilin','Hemofarm',1);
/*!40000 ALTER TABLE `LEK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ODELJENJE`
--

DROP TABLE IF EXISTS `ODELJENJE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ODELJENJE` (
  `idOdeljenje` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokacija` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idNacelnika` int DEFAULT NULL,
  PRIMARY KEY (`idOdeljenje`),
  KEY `fk_odeljenje_nacelnik` (`idNacelnika`),
  CONSTRAINT `fk_odeljenje_nacelnik` FOREIGN KEY (`idNacelnika`) REFERENCES `DOKTOR` (`idDoktor`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ODELJENJE`
--

LOCK TABLES `ODELJENJE` WRITE;
/*!40000 ALTER TABLE `ODELJENJE` DISABLE KEYS */;
INSERT INTO `ODELJENJE` VALUES (1,'Interna medicina','Blok A, 2. sprat',1),(2,'Hirurgija','Blok B, 3. sprat',2),(3,'Neurologija','Blok C, 1. sprat',3),(4,'Fizikalna medicina i rehabilitacija','Blok D, prizemlje',4),(5,'Pedijatrija','Blok E, 1. sprat',5);
/*!40000 ALTER TABLE `ODELJENJE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PACIJENT`
--

DROP TABLE IF EXISTS `PACIJENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PACIJENT` (
  `idPacijent` int NOT NULL AUTO_INCREMENT,
  `ime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imeOca` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prezime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `JMBG` char(13) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datumRodjenja` date NOT NULL,
  `pol` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresa` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LBO` char(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `osiguran` tinyint(1) NOT NULL DEFAULT '0',
  `aktivan` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idPacijent`),
  UNIQUE KEY `uq_pacijent_jmbg` (`JMBG`),
  UNIQUE KEY `uq_pacijent_email` (`email`),
  UNIQUE KEY `uq_pacijent_lbo` (`LBO`),
  CONSTRAINT `chk_pacijent_osiguran` CHECK ((((`LBO` is null) and (`osiguran` = false)) or ((`LBO` is not null) and (`osiguran` = true)))),
  CONSTRAINT `chk_pacijent_pol` CHECK (((`pol` in (_utf8mb4'M',_utf8mb4'Z')) or (`pol` is null)))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PACIJENT`
--

LOCK TABLES `PACIJENT` WRITE;
/*!40000 ALTER TABLE `PACIJENT` DISABLE KEYS */;
INSERT INTO `PACIJENT` VALUES (0,'OBRISAN',NULL,'OBRISAN','0000000000000','1900-01-01',NULL,NULL,NULL,NULL,NULL,0,0),(1,'Milan','Dragan','Đorđević','1504978710015','1978-04-15','M','Bulevar oslobođenja 12, Novi Sad','milan.djordjevic@email.com','+381641234567','30508780514',1,1),(2,'Jovana','Petar','Popović','2209985714225','1985-09-22','Z','Zmaj Jovina 5, Novi Sad','jovana.popovic@email.com','+381652345678','30509850621',1,1),(3,'Aleksandar','Miloš','Stanković','0307990710031','1990-07-03','M','Futoška 44, Novi Sad','aleksandar.stankovic@gmail.com',NULL,'30509901234',1,1),(4,'Milica','Nikola','Vasić','0811972715012','1972-11-08','Z','Dunavska 18, Novi Sad','m.vasic@email.com','+381674567890','30507720876',1,1),(5,'Dragan','Slobodanka','Marković','2802963710047','1963-02-28','M','Kralja Aleksandra 33, Beograd',NULL,'+381685678901',NULL,0,1),(6,'Sofija','Miloš','Đurić','1206021715004','2021-06-12','Z','Laze Teleckog 8, Novi Sad','milos.djuric@email.com','+381696789012','30506210234',1,1),(17,'Jovana ',NULL,'Jovanic','0912976801350','2026-04-22','M',NULL,NULL,NULL,NULL,0,1);
/*!40000 ALTER TABLE `PACIJENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PREGLED`
--

DROP TABLE IF EXISTS `PREGLED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PREGLED` (
  `idPregled` int NOT NULL AUTO_INCREMENT,
  `idPacijenta` int NOT NULL,
  `idDoktora` int NOT NULL,
  `idTermina` int DEFAULT NULL,
  `datumVreme` datetime NOT NULL,
  `vremeZavrsetka` datetime DEFAULT NULL,
  `nalaz` varchar(3000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ZAKAZAN',
  `komentarOtkazivanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idPregled`),
  KEY `fk_pregled_termin` (`idTermina`),
  KEY `idx_pregled_pacijent` (`idPacijenta`),
  KEY `idx_pregled_doktor` (`idDoktora`),
  KEY `idx_pregled_datum` (`datumVreme`),
  KEY `idx_pregled_status` (`status`),
  CONSTRAINT `fk_pregled_doktor` FOREIGN KEY (`idDoktora`) REFERENCES `DOKTOR` (`idDoktor`),
  CONSTRAINT `fk_pregled_pacijent` FOREIGN KEY (`idPacijenta`) REFERENCES `PACIJENT` (`idPacijent`),
  CONSTRAINT `fk_pregled_termin` FOREIGN KEY (`idTermina`) REFERENCES `TERMIN` (`idTermin`) ON DELETE SET NULL,
  CONSTRAINT `chk_pregled_status` CHECK ((`status` in (_utf8mb4'ZAKAZAN',_utf8mb4'U_TOKU',_utf8mb4'ZAVRSEN',_utf8mb4'OTKAZAN')))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PREGLED`
--

LOCK TABLES `PREGLED` WRITE;
/*!40000 ALTER TABLE `PREGLED` DISABLE KEYS */;
INSERT INTO `PREGLED` VALUES (1,1,1,1,'2026-01-15 08:00:00','2026-01-15 08:42:00','Pacijent se javlja na redovnu kontrolu arterijske hipertenzije. Pritisak 150/95 mmHg, puls 78/min ritmičan. Srčani tonovi jasni, bez šumova. Plućni i abdominalni nalaz uredan. Preporučuje se nastavak antihipertenzivne terapije, smanjenje unosa kuhinjske soli, redovna fizička aktivnost 30 min/dan. Kućno merenje krvnog pritiska 2x dnevno uz beleženje rezultata. Sledeća kontrola za 3 meseca.','ZAVRSEN',NULL),(2,2,3,2,'2026-01-20 08:00:00','2026-01-20 08:38:00','Pacijentkinja navodi rekurentne glavobolje frontotemporalno, intenziteta 7/10, trajanja 8–24h, praćene mučninom i fotofobijom, bez aure. Neurološki status uredan. Fundus uredan. Dijagnoza migrene bez aure. Preporučuje se vođenje dnevnika glavobolje, izbegavanje poznatih okidača (stres, gladovanje). Upućuje se na MRI endokranijuma radi isključenja sekundarnih uzroka.','ZAVRSEN',NULL),(3,3,2,3,'2026-02-04 10:00:00','2026-02-04 10:28:00','Pacijent navodi bol u lumbalnoj regiji trajanja 3 nedelje, pojačan pri sedenju i naginjanju. Status lokalis: napetost paravertebralnih mišića L4-L5, pozitivan Lasegueov test desno pod 60 stepeni. Neurološki ispadi ne postoje. Preporučuju se analgetici, mirovanje 3–5 dana, fizikalna terapija 10 procedura. Rendgenska snimanja L-kičme bez strukturalnih promena.','ZAVRSEN',NULL),(4,4,4,4,'2026-02-09 13:00:00','2026-02-09 13:35:00','Pacijentkinja upućena od ortopeda na fizikalnu terapiju. Nalaz: ograničena pokretljivost vrata u rotaciji i lateralnoj fleksiji, spazam paravertebralnih mišića cervikalne regije bilateralno. Preporučuje se 10 procedura fizikalne terapije, kineziterapija i primena toplote. Edukacija o domaćem programu vežbi za istezanje. Kontrola za 6 nedelja.','ZAVRSEN',NULL),(5,6,5,5,'2026-02-16 08:00:00','2026-02-16 08:20:00','Dete uzrasta 4 godine i 8 meseci, dolazi uz roditelja. Opšte stanje dobro, afebrilan. Telesna masa 18 kg, visina 105 cm — u referentnim vrednostima za uzrast. Plućni nalaz uredan. Faringealna sluznica blago hiperemična, tonzile uvećane I stepena. Abdomen mekan, bezbolan. Preporučuje se nastavak redovnih kontrola.','ZAVRSEN',NULL),(6,1,1,6,'2026-03-02 08:30:00','2026-03-02 09:05:00','Kontrolni pregled. Pacijent donosi dnevnik krvnog pritiska — vrednosti 130–145/85–92 mmHg, poboljšanje u odnosu na prethodnu posetu. Povremeni bol u grudima pri naporu. EKG bez akutnih promena. Holter EKG i ehokardiografija naručeni. Lipidski status: LDL 4.2 mmol/L — indikacija za uvođenje statina. Korekcija terapije, kontrola lipida za 6 nedelja.','ZAVRSEN',NULL),(7,5,4,8,'2026-03-10 13:30:00','2026-03-10 14:10:00','Pacijent upućen zbog hroničnih bolova u epigastrijumu i smanjenog apetita. Navodi dugogodišnje tegobe pojačane stresom. Prisutna anksioznost i poremećaj sna. Gastroskopija preporučena. Uvedena empirijska gastroprotektivna terapija. Upućuje se na psihijatrijsku konsultaciju. Kontrola za mesec dana.','ZAVRSEN',NULL),(8,2,3,7,'2026-03-16 08:00:00','2026-03-16 08:35:00','Kontrolni pregled bolesnice sa poznatom migrenom. Pacijentkinja navodi smanjenu učestalost napada — 1–2 mesečno. MRI mozga urađen i uredan — bez patoloških promena. Uvodi se preventivna terapija. Edukacija o okidačima nastavljena. Prognoza povoljna, sledeća kontrola za 6 meseci.','ZAVRSEN',NULL),(9,3,2,9,'2026-03-20 10:00:00',NULL,NULL,'OTKAZAN','Pacijent otkazao dan ranije — hitna privatna situacija. Preporučiti novo zakazivanje.'),(28,2,1,33,'2026-05-04 10:30:00','2026-04-22 08:27:56','','ZAVRSEN',NULL),(29,2,1,22,'2026-05-01 09:00:00',NULL,NULL,'U_TOKU',NULL),(30,17,1,41,'2026-05-05 10:30:00',NULL,NULL,'ZAKAZAN',NULL);
/*!40000 ALTER TABLE `PREGLED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PREGLED_DIJAGNOZA`
--

DROP TABLE IF EXISTS `PREGLED_DIJAGNOZA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PREGLED_DIJAGNOZA` (
  `idPregled` int NOT NULL,
  `sifra` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idPregled`,`sifra`),
  KEY `fk_pd_dijagnoza` (`sifra`),
  CONSTRAINT `fk_pd_dijagnoza` FOREIGN KEY (`sifra`) REFERENCES `DIJAGNOZA` (`sifra`) ON DELETE CASCADE,
  CONSTRAINT `fk_pd_pregled` FOREIGN KEY (`idPregled`) REFERENCES `PREGLED` (`idPregled`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PREGLED_DIJAGNOZA`
--

LOCK TABLES `PREGLED_DIJAGNOZA` WRITE;
/*!40000 ALTER TABLE `PREGLED_DIJAGNOZA` DISABLE KEYS */;
INSERT INTO `PREGLED_DIJAGNOZA` VALUES (28,'E11'),(7,'F41.1'),(2,'G43'),(8,'G43'),(1,'I10'),(6,'I10'),(28,'I10'),(6,'I25.1'),(5,'J06.9'),(7,'K29.5'),(4,'M43.6'),(3,'M54.5');
/*!40000 ALTER TABLE `PREGLED_DIJAGNOZA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RASPORED_DOKTORA`
--

DROP TABLE IF EXISTS `RASPORED_DOKTORA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RASPORED_DOKTORA` (
  `idRaspored` int NOT NULL AUTO_INCREMENT,
  `idDoktora` int NOT NULL,
  `danUNedelji` tinyint NOT NULL,
  `vremeOd` time NOT NULL,
  `vremeDo` time NOT NULL,
  `trajanje` int NOT NULL DEFAULT '30',
  `aktivan` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idRaspored`),
  KEY `idx_raspored_doktor` (`idDoktora`),
  KEY `idx_raspored_aktivan` (`aktivan`),
  CONSTRAINT `fk_raspored_doktor` FOREIGN KEY (`idDoktora`) REFERENCES `DOKTOR` (`idDoktor`) ON DELETE CASCADE,
  CONSTRAINT `chk_raspored_dan` CHECK ((`danUNedelji` between 1 and 7)),
  CONSTRAINT `chk_raspored_trajanje` CHECK (((`trajanje` > 0) and (`trajanje` <= 480))),
  CONSTRAINT `chk_raspored_vreme` CHECK ((`vremeOd` < `vremeDo`))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RASPORED_DOKTORA`
--

LOCK TABLES `RASPORED_DOKTORA` WRITE;
/*!40000 ALTER TABLE `RASPORED_DOKTORA` DISABLE KEYS */;
INSERT INTO `RASPORED_DOKTORA` VALUES (1,1,1,'08:00:00','12:00:00',30,1),(2,1,2,'08:00:00','12:00:00',30,1),(3,1,3,'08:00:00','12:00:00',30,1),(4,1,4,'08:00:00','12:00:00',30,1),(5,1,5,'08:00:00','12:00:00',30,1),(6,2,1,'10:00:00','14:00:00',45,1),(7,2,3,'10:00:00','14:00:00',45,1),(8,2,5,'10:00:00','14:00:00',45,1),(9,3,2,'08:00:00','13:00:00',30,1),(10,3,4,'08:00:00','13:00:00',30,1),(11,4,1,'13:00:00','16:00:00',30,1),(12,4,2,'13:00:00','16:00:00',30,1),(13,4,3,'13:00:00','16:00:00',30,1),(14,4,4,'13:00:00','16:00:00',30,1),(15,4,5,'13:00:00','16:00:00',30,1),(16,5,1,'08:00:00','11:00:00',20,1),(17,5,2,'08:00:00','11:00:00',20,1),(18,5,3,'08:00:00','11:00:00',20,1),(19,5,4,'08:00:00','11:00:00',20,1),(20,5,5,'08:00:00','11:00:00',20,1);
/*!40000 ALTER TABLE `RASPORED_DOKTORA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RECEPT`
--

DROP TABLE IF EXISTS `RECEPT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RECEPT` (
  `idRecept` int NOT NULL AUTO_INCREMENT,
  `idPregled` int NOT NULL,
  `idLek` int NOT NULL,
  `kolicina` int NOT NULL DEFAULT '1',
  `uputstvo` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datumIzdavanja` date NOT NULL DEFAULT (curdate()),
  `datumVazenja` date DEFAULT NULL,
  `podignut` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idRecept`),
  KEY `fk_recept_lek` (`idLek`),
  KEY `idx_recept_pregled` (`idPregled`),
  CONSTRAINT `fk_recept_lek` FOREIGN KEY (`idLek`) REFERENCES `LEK` (`idLek`),
  CONSTRAINT `fk_recept_pregled` FOREIGN KEY (`idPregled`) REFERENCES `PREGLED` (`idPregled`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RECEPT`
--

LOCK TABLES `RECEPT` WRITE;
/*!40000 ALTER TABLE `RECEPT` DISABLE KEYS */;
INSERT INTO `RECEPT` VALUES (1,1,1,1,'1 tableta ujutro, dugotrajno','2026-01-15','2026-04-15',1),(2,1,8,1,'1 tableta ujutro, dugotrajno','2026-01-15','2026-04-15',1),(3,2,4,2,'1 tableta 3x dnevno uz obrok, 5 dana','2026-01-20','2026-02-03',1),(4,3,4,2,'Po potrebi, maksimalno 3x dnevno','2026-02-04','2026-05-04',1),(5,5,10,1,'1 tableta 3x dnevno tokom 7 dana','2026-02-16','2026-03-02',1),(6,6,1,1,'1 tableta ujutro, dugotrajno','2026-03-02','2026-06-02',0),(7,6,9,1,'1 tableta uveče, dugotrajno','2026-03-02','2026-06-02',0),(8,7,5,1,'1 tableta pre doručka na prazan stomak','2026-03-10','2026-06-10',0),(9,7,7,1,'Po potrebi, maksimalno 1x dnevno uveče','2026-03-10','2026-04-10',0),(10,8,4,1,'Po potrebi pri napadu','2026-03-16','2026-06-16',1),(16,28,4,1,'','2026-04-22','2026-04-22',0),(17,28,6,1,'','2026-04-22','2026-04-22',0);
/*!40000 ALTER TABLE `RECEPT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REVIZIJSKI_TRAG`
--

DROP TABLE IF EXISTS `REVIZIJSKI_TRAG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REVIZIJSKI_TRAG` (
  `idRevizija` int NOT NULL AUTO_INCREMENT,
  `idKorisnik` int NOT NULL,
  `idPacijenta` int DEFAULT NULL,
  `akcija` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datum` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipAdresa` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `objekat` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idObjekta` int DEFAULT NULL,
  PRIMARY KEY (`idRevizija`),
  KEY `idx_audit_korisnik` (`idKorisnik`),
  KEY `idx_audit_pacijent` (`idPacijenta`),
  KEY `idx_audit_datum` (`datum`),
  CONSTRAINT `fk_revizija_korisnik` FOREIGN KEY (`idKorisnik`) REFERENCES `KORISNIK` (`idKorisnik`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REVIZIJSKI_TRAG`
--

LOCK TABLES `REVIZIJSKI_TRAG` WRITE;
/*!40000 ALTER TABLE `REVIZIJSKI_TRAG` DISABLE KEYS */;
INSERT INTO `REVIZIJSKI_TRAG` VALUES (1,2,1,'KORISNIK_KREIRAN_PACIJENT','2025-10-15 10:00:00','192.168.1.10','PACIJENT',1),(2,2,2,'KORISNIK_KREIRAN_PACIJENT','2025-10-15 10:15:00','192.168.1.10','PACIJENT',2),(3,2,3,'KORISNIK_KREIRAN_PACIJENT','2025-10-16 09:00:00','192.168.1.10','PACIJENT',3),(4,3,4,'KORISNIK_KREIRAN_PACIJENT','2025-10-16 09:30:00','192.168.1.11','PACIJENT',4),(5,3,5,'KORISNIK_KREIRAN_PACIJENT','2025-10-17 11:00:00','192.168.1.11','PACIJENT',5),(6,3,6,'KORISNIK_KREIRAN_PACIJENT','2025-11-20 10:00:00','192.168.1.11','PACIJENT',6),(7,4,1,'PREGLED_ZAVRSEN','2026-01-15 08:42:00','192.168.1.20','PREGLED',1),(8,6,2,'PREGLED_ZAVRSEN','2026-01-20 08:38:00','192.168.1.22','PREGLED',2),(9,5,3,'PREGLED_ZAVRSEN','2026-02-04 10:28:00','192.168.1.21','PREGLED',3),(10,7,4,'PREGLED_ZAVRSEN','2026-02-09 13:35:00','192.168.1.23','PREGLED',4),(11,8,6,'PREGLED_ZAVRSEN','2026-02-16 08:20:00','192.168.1.24','PREGLED',5),(12,9,1,'GDPR_ZAHTEV_PODNET','2026-02-10 10:30:00','88.200.10.15','ZAHTEV_ZA_PODATKE',1),(13,1,1,'GDPR_ZAHTEV_OBRADJENO','2026-02-12 14:00:00','192.168.1.1','ZAHTEV_ZA_PODATKE',1),(14,4,1,'PREGLED_ZAVRSEN','2026-03-02 09:05:00','192.168.1.20','PREGLED',6),(15,6,5,'PREGLED_ZAVRSEN','2026-03-10 14:10:00','192.168.1.22','PREGLED',7),(16,7,2,'PREGLED_ZAVRSEN','2026-03-16 08:35:00','192.168.1.23','PREGLED',8),(17,5,3,'PREGLED_OTKAZAN','2026-03-20 10:00:00','192.168.1.21','PREGLED',9),(18,10,2,'GDPR_ZAHTEV_PODNET','2026-03-25 16:00:00','88.200.10.22','ZAHTEV_ZA_PODATKE',2),(19,4,1,'ZAHTEV_ZA_PREGLED_ODOBREN','2026-03-21 09:15:00','192.168.1.20','ZAHTEV_ZA_PREGLED',1),(20,8,6,'ZAHTEV_ZA_PREGLED_ODOBREN','2026-03-26 08:30:00','192.168.1.24','ZAHTEV_ZA_PREGLED',2),(484,1,0,'LOGIN','2026-04-22 08:21:58','','',0),(485,1,0,'KORISNIK_PROMENJENA_LOZINKA','2026-04-22 08:23:23','','',2),(486,1,0,'KORISNIK_PROMENJENA_LOZINKA','2026-04-22 08:24:09','','',4),(487,1,0,'KORISNIK_PROMENJENA_LOZINKA','2026-04-22 08:24:40','','',10),(488,1,0,'LOGOUT','2026-04-22 08:25:59','','',0),(489,4,0,'LOGIN','2026-04-22 08:26:10','','',0),(490,4,0,'LOGOUT','2026-04-22 08:26:17','','',0),(491,2,0,'LOGIN','2026-04-22 08:26:26','','',0),(492,2,0,'PREGLED_ZAKAZAN_SESTRA','2026-04-22 08:27:03','','PREGLED',28),(493,2,0,'LOGOUT','2026-04-22 08:27:11','','',0),(494,4,0,'LOGIN','2026-04-22 08:27:19','','',0),(495,4,0,'PREGLED_ZAVRSEN','2026-04-22 08:27:56','','',28),(496,4,0,'LOGOUT','2026-04-22 08:28:26','','',0),(497,10,2,'LOGIN','2026-04-22 08:28:35','','',0),(498,10,2,'LOGIN','2026-04-22 10:03:53','','',0),(499,10,2,'LOGOUT','2026-04-22 10:03:57','','',0),(500,4,0,'LOGIN','2026-04-22 10:04:10','','',0),(501,4,0,'LOGOUT','2026-04-22 10:04:47','','',0),(502,2,0,'LOGIN','2026-04-22 10:05:00','','',0),(503,2,0,'PREGLED_ZAKAZAN_SESTRA','2026-04-22 10:05:16','','PREGLED',29),(504,2,0,'LOGOUT','2026-04-22 10:05:18','','',0),(505,4,0,'LOGIN','2026-04-22 10:05:27','','',0),(506,1,0,'LOGIN','2026-04-22 10:44:00','','',0),(507,1,0,'LOGOUT','2026-04-22 10:44:11','','',0),(508,1,0,'LOGIN','2026-04-22 12:06:37','','',0),(509,1,0,'LOGOUT','2026-04-22 12:06:39','','',0),(510,4,0,'LOGIN','2026-04-22 12:13:08','','',0),(511,4,0,'LOGOUT','2026-04-22 12:13:43','','',0),(512,1,0,'LOGIN','2026-04-22 12:45:33','','',0),(513,1,0,'KORISNIK_PROMENJENA_LOZINKA','2026-04-22 12:48:18','','',10),(514,1,0,'LOGOUT','2026-04-22 12:49:25','','',0),(515,1,0,'LOGIN','2026-04-22 12:49:38','','',0),(516,1,0,'KORISNIK_KREIRAN_NALOG_SESTRE','2026-04-22 12:49:45','','',35),(517,1,0,'LOGOUT','2026-04-22 12:49:57','','',0),(518,35,0,'LOGIN','2026-04-22 12:50:06','','',0),(519,35,0,'KORISNIK_KREIRAN_NALOG_PACIJENTA','2026-04-22 12:51:34','','',17),(520,35,0,'LOGOUT','2026-04-22 12:56:24','','',0),(521,36,17,'LOGIN','2026-04-22 12:56:43','','',0),(522,36,17,'ZAHTEV_ZA_PREGLED_PODNET','2026-04-22 12:57:19','','ZAHTEV_ZA_PREGLED',20),(523,36,17,'LOGOUT','2026-04-22 12:57:22','','',0),(524,4,0,'LOGIN','2026-04-22 12:57:36','','',0),(525,4,0,'ZAHTEV_ZA_PREGLED_ODOBREN','2026-04-22 12:57:58','','',20);
/*!40000 ALTER TABLE `REVIZIJSKI_TRAG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TERMIN`
--

DROP TABLE IF EXISTS `TERMIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TERMIN` (
  `idTermin` int NOT NULL AUTO_INCREMENT,
  `idDoktora` int NOT NULL,
  `idRasporeda` int DEFAULT NULL,
  `datumVreme` datetime NOT NULL,
  `trajanje` int NOT NULL DEFAULT '30',
  `dostupan` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTermin`),
  UNIQUE KEY `uq_termin_doktor_datum` (`idDoktora`,`datumVreme`),
  KEY `fk_termin_raspored` (`idRasporeda`),
  KEY `idx_termin_doktor_datum` (`idDoktora`,`datumVreme`),
  KEY `idx_termin_dostupan` (`dostupan`),
  CONSTRAINT `fk_termin_doktor` FOREIGN KEY (`idDoktora`) REFERENCES `DOKTOR` (`idDoktor`),
  CONSTRAINT `fk_termin_raspored` FOREIGN KEY (`idRasporeda`) REFERENCES `RASPORED_DOKTORA` (`idRaspored`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TERMIN`
--

LOCK TABLES `TERMIN` WRITE;
/*!40000 ALTER TABLE `TERMIN` DISABLE KEYS */;
INSERT INTO `TERMIN` VALUES (1,1,NULL,'2026-01-15 08:00:00',30,0),(2,3,NULL,'2026-01-20 08:00:00',30,0),(3,2,NULL,'2026-02-04 10:00:00',45,0),(4,4,NULL,'2026-02-09 13:00:00',30,0),(5,5,NULL,'2026-02-16 08:00:00',20,0),(6,1,NULL,'2026-03-02 08:30:00',30,0),(7,3,NULL,'2026-03-10 08:00:00',30,0),(8,4,NULL,'2026-03-16 13:30:00',30,0),(9,2,NULL,'2026-03-20 10:00:00',45,0),(10,1,NULL,'2026-04-07 08:00:00',30,0),(11,1,NULL,'2026-04-07 08:30:00',30,0),(12,1,NULL,'2026-04-07 09:00:00',30,0),(13,3,NULL,'2026-04-07 08:00:00',30,0),(14,2,NULL,'2026-04-08 10:00:00',45,0),(15,4,NULL,'2026-04-09 13:00:00',30,1),(16,4,NULL,'2026-04-09 13:30:00',30,1),(17,1,NULL,'2026-04-10 09:00:00',30,0),(18,5,NULL,'2026-04-14 08:00:00',20,0),(19,2,NULL,'2026-04-08 10:45:00',45,0),(20,1,5,'2026-05-01 08:00:00',30,0),(21,1,5,'2026-05-01 08:30:00',30,0),(22,1,5,'2026-05-01 09:00:00',30,0),(23,1,5,'2026-05-01 09:30:00',30,0),(24,1,5,'2026-05-01 10:00:00',30,0),(25,1,5,'2026-05-01 10:30:00',30,1),(26,1,5,'2026-05-01 11:00:00',30,1),(27,1,5,'2026-05-01 11:30:00',30,1),(28,1,1,'2026-05-04 08:00:00',30,1),(29,1,1,'2026-05-04 08:30:00',30,1),(30,1,1,'2026-05-04 09:00:00',30,1),(31,1,1,'2026-05-04 09:30:00',30,1),(32,1,1,'2026-05-04 10:00:00',30,1),(33,1,1,'2026-05-04 10:30:00',30,0),(34,1,1,'2026-05-04 11:00:00',30,0),(35,1,1,'2026-05-04 11:30:00',30,1),(36,1,2,'2026-05-05 08:00:00',30,1),(37,1,2,'2026-05-05 08:30:00',30,1),(38,1,2,'2026-05-05 09:00:00',30,1),(39,1,2,'2026-05-05 09:30:00',30,1),(40,1,2,'2026-05-05 10:00:00',30,1),(41,1,2,'2026-05-05 10:30:00',30,0),(42,1,2,'2026-05-05 11:00:00',30,1),(43,1,2,'2026-05-05 11:30:00',30,1),(44,1,3,'2026-05-06 08:00:00',30,1),(45,1,3,'2026-05-06 08:30:00',30,1),(46,1,3,'2026-05-06 09:00:00',30,1),(47,1,3,'2026-05-06 09:30:00',30,1),(48,1,3,'2026-05-06 10:00:00',30,1),(49,1,3,'2026-05-06 10:30:00',30,1),(50,1,3,'2026-05-06 11:00:00',30,1),(51,1,3,'2026-05-06 11:30:00',30,1),(52,1,4,'2026-05-07 08:00:00',30,1),(53,1,4,'2026-05-07 08:30:00',30,1),(54,1,4,'2026-05-07 09:00:00',30,1),(55,1,4,'2026-05-07 09:30:00',30,0),(56,1,4,'2026-05-07 10:00:00',30,1),(57,1,4,'2026-05-07 10:30:00',30,1),(58,1,4,'2026-05-07 11:00:00',30,1),(59,1,4,'2026-05-07 11:30:00',30,1),(60,1,5,'2026-05-08 08:00:00',30,1),(61,1,5,'2026-05-08 08:30:00',30,1),(62,1,5,'2026-05-08 09:00:00',30,1),(63,1,5,'2026-05-08 09:30:00',30,1),(64,1,5,'2026-05-08 10:00:00',30,1),(65,1,5,'2026-05-08 10:30:00',30,1),(66,1,5,'2026-05-08 11:00:00',30,1),(67,1,5,'2026-05-08 11:30:00',30,1),(68,1,1,'2026-05-11 08:00:00',30,1),(69,1,1,'2026-05-11 08:30:00',30,1),(70,1,1,'2026-05-11 09:00:00',30,1),(71,1,1,'2026-05-11 09:30:00',30,1),(72,1,1,'2026-05-11 10:00:00',30,1),(73,1,1,'2026-05-11 10:30:00',30,1),(74,1,1,'2026-05-11 11:00:00',30,1),(75,1,1,'2026-05-11 11:30:00',30,1),(76,1,2,'2026-05-12 08:00:00',30,1),(77,1,2,'2026-05-12 08:30:00',30,1),(78,1,2,'2026-05-12 09:00:00',30,1),(79,1,2,'2026-05-12 09:30:00',30,1),(80,1,2,'2026-05-12 10:00:00',30,1),(81,1,2,'2026-05-12 10:30:00',30,1),(82,1,2,'2026-05-12 11:00:00',30,1),(83,1,2,'2026-05-12 11:30:00',30,1),(84,1,3,'2026-05-13 08:00:00',30,1),(85,1,3,'2026-05-13 08:30:00',30,1),(86,1,3,'2026-05-13 09:00:00',30,1),(87,1,3,'2026-05-13 09:30:00',30,1),(88,1,3,'2026-05-13 10:00:00',30,1),(89,1,3,'2026-05-13 10:30:00',30,1),(90,1,3,'2026-05-13 11:00:00',30,1),(91,1,3,'2026-05-13 11:30:00',30,1),(92,1,4,'2026-05-14 08:00:00',30,1),(93,1,4,'2026-05-14 08:30:00',30,1),(94,1,4,'2026-05-14 09:00:00',30,1),(95,1,4,'2026-05-14 09:30:00',30,1),(96,1,4,'2026-05-14 10:00:00',30,1),(97,1,4,'2026-05-14 10:30:00',30,1),(98,1,4,'2026-05-14 11:00:00',30,1),(99,1,4,'2026-05-14 11:30:00',30,1),(100,1,5,'2026-05-15 08:00:00',30,1),(101,1,5,'2026-05-15 08:30:00',30,1),(102,1,5,'2026-05-15 09:00:00',30,1),(103,1,5,'2026-05-15 09:30:00',30,1),(104,1,5,'2026-05-15 10:00:00',30,1),(105,1,5,'2026-05-15 10:30:00',30,1),(106,1,5,'2026-05-15 11:00:00',30,1),(107,1,5,'2026-05-15 11:30:00',30,1),(108,1,1,'2026-05-18 08:00:00',30,1),(109,1,1,'2026-05-18 08:30:00',30,1),(110,1,1,'2026-05-18 09:00:00',30,1),(111,1,1,'2026-05-18 09:30:00',30,1),(112,1,1,'2026-05-18 10:00:00',30,1),(113,1,1,'2026-05-18 10:30:00',30,1),(114,1,1,'2026-05-18 11:00:00',30,1),(115,1,1,'2026-05-18 11:30:00',30,1),(116,1,2,'2026-05-19 08:00:00',30,1),(117,1,2,'2026-05-19 08:30:00',30,1),(118,1,2,'2026-05-19 09:00:00',30,1),(119,1,2,'2026-05-19 09:30:00',30,1),(120,1,2,'2026-05-19 10:00:00',30,1),(121,1,2,'2026-05-19 10:30:00',30,1),(122,1,2,'2026-05-19 11:00:00',30,1),(123,1,2,'2026-05-19 11:30:00',30,1),(124,1,3,'2026-05-20 08:00:00',30,1),(125,1,3,'2026-05-20 08:30:00',30,1),(126,1,3,'2026-05-20 09:00:00',30,1),(127,1,3,'2026-05-20 09:30:00',30,1),(128,1,3,'2026-05-20 10:00:00',30,1),(129,1,3,'2026-05-20 10:30:00',30,1),(130,1,3,'2026-05-20 11:00:00',30,1),(131,1,3,'2026-05-20 11:30:00',30,1),(132,1,4,'2026-05-21 08:00:00',30,1),(133,1,4,'2026-05-21 08:30:00',30,1),(134,1,4,'2026-05-21 09:00:00',30,1),(135,1,4,'2026-05-21 09:30:00',30,1),(136,1,4,'2026-05-21 10:00:00',30,1),(137,1,4,'2026-05-21 10:30:00',30,1),(138,1,4,'2026-05-21 11:00:00',30,1),(139,1,4,'2026-05-21 11:30:00',30,1),(140,1,5,'2026-05-22 08:00:00',30,1),(141,1,5,'2026-05-22 08:30:00',30,1),(142,1,5,'2026-05-22 09:00:00',30,1),(143,1,5,'2026-05-22 09:30:00',30,1),(144,1,5,'2026-05-22 10:00:00',30,1),(145,1,5,'2026-05-22 10:30:00',30,1),(146,1,5,'2026-05-22 11:00:00',30,1),(147,1,5,'2026-05-22 11:30:00',30,1),(148,1,1,'2026-05-25 08:00:00',30,1),(149,1,1,'2026-05-25 08:30:00',30,1),(150,1,1,'2026-05-25 09:00:00',30,1),(151,1,1,'2026-05-25 09:30:00',30,1),(152,1,1,'2026-05-25 10:00:00',30,1),(153,1,1,'2026-05-25 10:30:00',30,1),(154,1,1,'2026-05-25 11:00:00',30,1),(155,1,1,'2026-05-25 11:30:00',30,1),(156,1,2,'2026-05-26 08:00:00',30,1),(157,1,2,'2026-05-26 08:30:00',30,1),(158,1,2,'2026-05-26 09:00:00',30,1),(159,1,2,'2026-05-26 09:30:00',30,1),(160,1,2,'2026-05-26 10:00:00',30,1),(161,1,2,'2026-05-26 10:30:00',30,1),(162,1,2,'2026-05-26 11:00:00',30,1),(163,1,2,'2026-05-26 11:30:00',30,1),(164,1,3,'2026-05-27 08:00:00',30,1),(165,1,3,'2026-05-27 08:30:00',30,1),(166,1,3,'2026-05-27 09:00:00',30,1),(167,1,3,'2026-05-27 09:30:00',30,1),(168,1,3,'2026-05-27 10:00:00',30,1),(169,1,3,'2026-05-27 10:30:00',30,1),(170,1,3,'2026-05-27 11:00:00',30,1),(171,1,3,'2026-05-27 11:30:00',30,1),(172,1,4,'2026-05-28 08:00:00',30,1),(173,1,4,'2026-05-28 08:30:00',30,1),(174,1,4,'2026-05-28 09:00:00',30,1),(175,1,4,'2026-05-28 09:30:00',30,1),(176,1,4,'2026-05-28 10:00:00',30,1),(177,1,4,'2026-05-28 10:30:00',30,1),(178,1,4,'2026-05-28 11:00:00',30,1),(179,1,4,'2026-05-28 11:30:00',30,1),(180,1,5,'2026-05-29 08:00:00',30,1),(181,1,5,'2026-05-29 08:30:00',30,1),(182,1,5,'2026-05-29 09:00:00',30,1),(183,1,5,'2026-05-29 09:30:00',30,1),(184,1,5,'2026-05-29 10:00:00',30,1),(185,1,5,'2026-05-29 10:30:00',30,1),(186,1,5,'2026-05-29 11:00:00',30,1),(187,1,5,'2026-05-29 11:30:00',30,1),(188,2,8,'2026-05-01 10:00:00',45,1),(189,2,8,'2026-05-01 10:45:00',45,1),(190,2,8,'2026-05-01 11:30:00',45,1),(191,2,8,'2026-05-01 12:15:00',45,1),(192,2,8,'2026-05-01 13:00:00',45,1),(193,2,8,'2026-05-01 13:45:00',45,1),(194,2,6,'2026-05-04 10:00:00',45,1),(195,2,6,'2026-05-04 10:45:00',45,1),(196,2,6,'2026-05-04 11:30:00',45,1),(197,2,6,'2026-05-04 12:15:00',45,1),(198,2,6,'2026-05-04 13:00:00',45,1),(199,2,6,'2026-05-04 13:45:00',45,1),(200,2,7,'2026-05-06 10:00:00',45,1),(201,2,7,'2026-05-06 10:45:00',45,1),(202,2,7,'2026-05-06 11:30:00',45,1),(203,2,7,'2026-05-06 12:15:00',45,1),(204,2,7,'2026-05-06 13:00:00',45,1),(205,2,7,'2026-05-06 13:45:00',45,1),(206,2,8,'2026-05-08 10:00:00',45,1),(207,2,8,'2026-05-08 10:45:00',45,1),(208,2,8,'2026-05-08 11:30:00',45,1),(209,2,8,'2026-05-08 12:15:00',45,1),(210,2,8,'2026-05-08 13:00:00',45,1),(211,2,8,'2026-05-08 13:45:00',45,1),(212,2,6,'2026-05-11 10:00:00',45,1),(213,2,6,'2026-05-11 10:45:00',45,1),(214,2,6,'2026-05-11 11:30:00',45,1),(215,2,6,'2026-05-11 12:15:00',45,1),(216,2,6,'2026-05-11 13:00:00',45,1),(217,2,6,'2026-05-11 13:45:00',45,1),(218,2,7,'2026-05-13 10:00:00',45,1),(219,2,7,'2026-05-13 10:45:00',45,1),(220,2,7,'2026-05-13 11:30:00',45,1),(221,2,7,'2026-05-13 12:15:00',45,1),(222,2,7,'2026-05-13 13:00:00',45,1),(223,2,7,'2026-05-13 13:45:00',45,1),(224,2,8,'2026-05-15 10:00:00',45,1),(225,2,8,'2026-05-15 10:45:00',45,1),(226,2,8,'2026-05-15 11:30:00',45,1),(227,2,8,'2026-05-15 12:15:00',45,1),(228,2,8,'2026-05-15 13:00:00',45,1),(229,2,8,'2026-05-15 13:45:00',45,1),(230,2,6,'2026-05-18 10:00:00',45,1),(231,2,6,'2026-05-18 10:45:00',45,1),(232,2,6,'2026-05-18 11:30:00',45,1),(233,2,6,'2026-05-18 12:15:00',45,1),(234,2,6,'2026-05-18 13:00:00',45,1),(235,2,6,'2026-05-18 13:45:00',45,1),(236,2,7,'2026-05-20 10:00:00',45,1),(237,2,7,'2026-05-20 10:45:00',45,1),(238,2,7,'2026-05-20 11:30:00',45,1),(239,2,7,'2026-05-20 12:15:00',45,1),(240,2,7,'2026-05-20 13:00:00',45,1),(241,2,7,'2026-05-20 13:45:00',45,1),(242,2,8,'2026-05-22 10:00:00',45,1),(243,2,8,'2026-05-22 10:45:00',45,1),(244,2,8,'2026-05-22 11:30:00',45,1),(245,2,8,'2026-05-22 12:15:00',45,1),(246,2,8,'2026-05-22 13:00:00',45,1),(247,2,8,'2026-05-22 13:45:00',45,1),(248,2,6,'2026-05-25 10:00:00',45,1),(249,2,6,'2026-05-25 10:45:00',45,1),(250,2,6,'2026-05-25 11:30:00',45,1),(251,2,6,'2026-05-25 12:15:00',45,1),(252,2,6,'2026-05-25 13:00:00',45,1),(253,2,6,'2026-05-25 13:45:00',45,1),(254,2,7,'2026-05-27 10:00:00',45,1),(255,2,7,'2026-05-27 10:45:00',45,1),(256,2,7,'2026-05-27 11:30:00',45,1),(257,2,7,'2026-05-27 12:15:00',45,1),(258,2,7,'2026-05-27 13:00:00',45,0),(259,2,7,'2026-05-27 13:45:00',45,1),(260,2,8,'2026-05-29 10:00:00',45,1),(261,2,8,'2026-05-29 10:45:00',45,1),(262,2,8,'2026-05-29 11:30:00',45,1),(263,2,8,'2026-05-29 12:15:00',45,1),(264,2,8,'2026-05-29 13:00:00',45,1),(265,2,8,'2026-05-29 13:45:00',45,1),(266,3,9,'2026-05-05 08:00:00',30,1),(267,3,9,'2026-05-05 08:30:00',30,0),(268,3,9,'2026-05-05 09:00:00',30,0),(269,3,9,'2026-05-05 09:30:00',30,1),(270,3,9,'2026-05-05 10:00:00',30,1),(271,3,9,'2026-05-05 10:30:00',30,1),(272,3,9,'2026-05-05 11:00:00',30,1),(273,3,9,'2026-05-05 11:30:00',30,1),(274,3,9,'2026-05-05 12:00:00',30,1),(275,3,9,'2026-05-05 12:30:00',30,1),(276,3,10,'2026-05-07 08:00:00',30,1),(277,3,10,'2026-05-07 08:30:00',30,1),(278,3,10,'2026-05-07 09:00:00',30,1),(279,3,10,'2026-05-07 09:30:00',30,1),(280,3,10,'2026-05-07 10:00:00',30,1),(281,3,10,'2026-05-07 10:30:00',30,1),(282,3,10,'2026-05-07 11:00:00',30,1),(283,3,10,'2026-05-07 11:30:00',30,1),(284,3,10,'2026-05-07 12:00:00',30,1),(285,3,10,'2026-05-07 12:30:00',30,1),(286,3,9,'2026-05-12 08:00:00',30,1),(287,3,9,'2026-05-12 08:30:00',30,1),(288,3,9,'2026-05-12 09:00:00',30,1),(289,3,9,'2026-05-12 09:30:00',30,1),(290,3,9,'2026-05-12 10:00:00',30,1),(291,3,9,'2026-05-12 10:30:00',30,1),(292,3,9,'2026-05-12 11:00:00',30,1),(293,3,9,'2026-05-12 11:30:00',30,1),(294,3,9,'2026-05-12 12:00:00',30,1),(295,3,9,'2026-05-12 12:30:00',30,1),(296,3,10,'2026-05-14 08:00:00',30,1),(297,3,10,'2026-05-14 08:30:00',30,1),(298,3,10,'2026-05-14 09:00:00',30,1),(299,3,10,'2026-05-14 09:30:00',30,1),(300,3,10,'2026-05-14 10:00:00',30,1),(301,3,10,'2026-05-14 10:30:00',30,1),(302,3,10,'2026-05-14 11:00:00',30,1),(303,3,10,'2026-05-14 11:30:00',30,1),(304,3,10,'2026-05-14 12:00:00',30,1),(305,3,10,'2026-05-14 12:30:00',30,1),(306,3,9,'2026-05-19 08:00:00',30,1),(307,3,9,'2026-05-19 08:30:00',30,1),(308,3,9,'2026-05-19 09:00:00',30,1),(309,3,9,'2026-05-19 09:30:00',30,1),(310,3,9,'2026-05-19 10:00:00',30,1),(311,3,9,'2026-05-19 10:30:00',30,1),(312,3,9,'2026-05-19 11:00:00',30,1),(313,3,9,'2026-05-19 11:30:00',30,1),(314,3,9,'2026-05-19 12:00:00',30,1),(315,3,9,'2026-05-19 12:30:00',30,1),(316,3,10,'2026-05-21 08:00:00',30,1),(317,3,10,'2026-05-21 08:30:00',30,1),(318,3,10,'2026-05-21 09:00:00',30,1),(319,3,10,'2026-05-21 09:30:00',30,1),(320,3,10,'2026-05-21 10:00:00',30,1),(321,3,10,'2026-05-21 10:30:00',30,1),(322,3,10,'2026-05-21 11:00:00',30,1),(323,3,10,'2026-05-21 11:30:00',30,1),(324,3,10,'2026-05-21 12:00:00',30,1),(325,3,10,'2026-05-21 12:30:00',30,1),(326,3,9,'2026-05-26 08:00:00',30,1),(327,3,9,'2026-05-26 08:30:00',30,1),(328,3,9,'2026-05-26 09:00:00',30,1),(329,3,9,'2026-05-26 09:30:00',30,1),(330,3,9,'2026-05-26 10:00:00',30,1),(331,3,9,'2026-05-26 10:30:00',30,1),(332,3,9,'2026-05-26 11:00:00',30,1),(333,3,9,'2026-05-26 11:30:00',30,1),(334,3,9,'2026-05-26 12:00:00',30,1),(335,3,9,'2026-05-26 12:30:00',30,1),(336,3,10,'2026-05-28 08:00:00',30,1),(337,3,10,'2026-05-28 08:30:00',30,1),(338,3,10,'2026-05-28 09:00:00',30,1),(339,3,10,'2026-05-28 09:30:00',30,1),(340,3,10,'2026-05-28 10:00:00',30,1),(341,3,10,'2026-05-28 10:30:00',30,1),(342,3,10,'2026-05-28 11:00:00',30,1),(343,3,10,'2026-05-28 11:30:00',30,1),(344,3,10,'2026-05-28 12:00:00',30,1),(345,3,10,'2026-05-28 12:30:00',30,1),(346,4,15,'2026-05-01 13:00:00',30,1),(347,4,15,'2026-05-01 13:30:00',30,0),(348,4,15,'2026-05-01 14:00:00',30,1),(349,4,15,'2026-05-01 14:30:00',30,1),(350,4,15,'2026-05-01 15:00:00',30,1),(351,4,15,'2026-05-01 15:30:00',30,1),(352,4,11,'2026-05-04 13:00:00',30,1),(353,4,11,'2026-05-04 13:30:00',30,1),(354,4,11,'2026-05-04 14:00:00',30,1),(355,4,11,'2026-05-04 14:30:00',30,1),(356,4,11,'2026-05-04 15:00:00',30,1),(357,4,11,'2026-05-04 15:30:00',30,1),(358,4,12,'2026-05-05 13:00:00',30,1),(359,4,12,'2026-05-05 13:30:00',30,1),(360,4,12,'2026-05-05 14:00:00',30,1),(361,4,12,'2026-05-05 14:30:00',30,1),(362,4,12,'2026-05-05 15:00:00',30,1),(363,4,12,'2026-05-05 15:30:00',30,1),(364,4,13,'2026-05-06 13:00:00',30,1),(365,4,13,'2026-05-06 13:30:00',30,1),(366,4,13,'2026-05-06 14:00:00',30,1),(367,4,13,'2026-05-06 14:30:00',30,1),(368,4,13,'2026-05-06 15:00:00',30,1),(369,4,13,'2026-05-06 15:30:00',30,1),(370,4,14,'2026-05-07 13:00:00',30,1),(371,4,14,'2026-05-07 13:30:00',30,1),(372,4,14,'2026-05-07 14:00:00',30,1),(373,4,14,'2026-05-07 14:30:00',30,1),(374,4,14,'2026-05-07 15:00:00',30,1),(375,4,14,'2026-05-07 15:30:00',30,1),(376,4,15,'2026-05-08 13:00:00',30,1),(377,4,15,'2026-05-08 13:30:00',30,1),(378,4,15,'2026-05-08 14:00:00',30,1),(379,4,15,'2026-05-08 14:30:00',30,1),(380,4,15,'2026-05-08 15:00:00',30,1),(381,4,15,'2026-05-08 15:30:00',30,1),(382,4,11,'2026-05-11 13:00:00',30,1),(383,4,11,'2026-05-11 13:30:00',30,1),(384,4,11,'2026-05-11 14:00:00',30,1),(385,4,11,'2026-05-11 14:30:00',30,1),(386,4,11,'2026-05-11 15:00:00',30,1),(387,4,11,'2026-05-11 15:30:00',30,1),(388,4,12,'2026-05-12 13:00:00',30,1),(389,4,12,'2026-05-12 13:30:00',30,1),(390,4,12,'2026-05-12 14:00:00',30,1),(391,4,12,'2026-05-12 14:30:00',30,1),(392,4,12,'2026-05-12 15:00:00',30,1),(393,4,12,'2026-05-12 15:30:00',30,1),(394,4,13,'2026-05-13 13:00:00',30,1),(395,4,13,'2026-05-13 13:30:00',30,1),(396,4,13,'2026-05-13 14:00:00',30,1),(397,4,13,'2026-05-13 14:30:00',30,1),(398,4,13,'2026-05-13 15:00:00',30,1),(399,4,13,'2026-05-13 15:30:00',30,1),(400,4,14,'2026-05-14 13:00:00',30,1),(401,4,14,'2026-05-14 13:30:00',30,1),(402,4,14,'2026-05-14 14:00:00',30,1),(403,4,14,'2026-05-14 14:30:00',30,1),(404,4,14,'2026-05-14 15:00:00',30,1),(405,4,14,'2026-05-14 15:30:00',30,1),(406,4,15,'2026-05-15 13:00:00',30,1),(407,4,15,'2026-05-15 13:30:00',30,1),(408,4,15,'2026-05-15 14:00:00',30,1),(409,4,15,'2026-05-15 14:30:00',30,1),(410,4,15,'2026-05-15 15:00:00',30,1),(411,4,15,'2026-05-15 15:30:00',30,1),(412,4,11,'2026-05-18 13:00:00',30,1),(413,4,11,'2026-05-18 13:30:00',30,1),(414,4,11,'2026-05-18 14:00:00',30,1),(415,4,11,'2026-05-18 14:30:00',30,1),(416,4,11,'2026-05-18 15:00:00',30,1),(417,4,11,'2026-05-18 15:30:00',30,1),(418,4,12,'2026-05-19 13:00:00',30,1),(419,4,12,'2026-05-19 13:30:00',30,1),(420,4,12,'2026-05-19 14:00:00',30,1),(421,4,12,'2026-05-19 14:30:00',30,1),(422,4,12,'2026-05-19 15:00:00',30,1),(423,4,12,'2026-05-19 15:30:00',30,1),(424,4,13,'2026-05-20 13:00:00',30,1),(425,4,13,'2026-05-20 13:30:00',30,1),(426,4,13,'2026-05-20 14:00:00',30,1),(427,4,13,'2026-05-20 14:30:00',30,1),(428,4,13,'2026-05-20 15:00:00',30,1),(429,4,13,'2026-05-20 15:30:00',30,1),(430,4,14,'2026-05-21 13:00:00',30,1),(431,4,14,'2026-05-21 13:30:00',30,1),(432,4,14,'2026-05-21 14:00:00',30,1),(433,4,14,'2026-05-21 14:30:00',30,1),(434,4,14,'2026-05-21 15:00:00',30,1),(435,4,14,'2026-05-21 15:30:00',30,1),(436,4,15,'2026-05-22 13:00:00',30,1),(437,4,15,'2026-05-22 13:30:00',30,1),(438,4,15,'2026-05-22 14:00:00',30,1),(439,4,15,'2026-05-22 14:30:00',30,1),(440,4,15,'2026-05-22 15:00:00',30,1),(441,4,15,'2026-05-22 15:30:00',30,1),(442,4,11,'2026-05-25 13:00:00',30,1),(443,4,11,'2026-05-25 13:30:00',30,1),(444,4,11,'2026-05-25 14:00:00',30,1),(445,4,11,'2026-05-25 14:30:00',30,1),(446,4,11,'2026-05-25 15:00:00',30,1),(447,4,11,'2026-05-25 15:30:00',30,1),(448,4,12,'2026-05-26 13:00:00',30,1),(449,4,12,'2026-05-26 13:30:00',30,1),(450,4,12,'2026-05-26 14:00:00',30,1),(451,4,12,'2026-05-26 14:30:00',30,1),(452,4,12,'2026-05-26 15:00:00',30,1),(453,4,12,'2026-05-26 15:30:00',30,1),(454,4,13,'2026-05-27 13:00:00',30,1),(455,4,13,'2026-05-27 13:30:00',30,1),(456,4,13,'2026-05-27 14:00:00',30,1),(457,4,13,'2026-05-27 14:30:00',30,1),(458,4,13,'2026-05-27 15:00:00',30,1),(459,4,13,'2026-05-27 15:30:00',30,1),(460,4,14,'2026-05-28 13:00:00',30,1),(461,4,14,'2026-05-28 13:30:00',30,1),(462,4,14,'2026-05-28 14:00:00',30,1),(463,4,14,'2026-05-28 14:30:00',30,1),(464,4,14,'2026-05-28 15:00:00',30,1),(465,4,14,'2026-05-28 15:30:00',30,1),(466,4,15,'2026-05-29 13:00:00',30,1),(467,4,15,'2026-05-29 13:30:00',30,1),(468,4,15,'2026-05-29 14:00:00',30,1),(469,4,15,'2026-05-29 14:30:00',30,1),(470,4,15,'2026-05-29 15:00:00',30,1),(471,4,15,'2026-05-29 15:30:00',30,1),(472,5,20,'2026-05-01 08:00:00',20,1),(473,5,20,'2026-05-01 08:20:00',20,1),(474,5,20,'2026-05-01 08:40:00',20,1),(475,5,20,'2026-05-01 09:00:00',20,1),(476,5,20,'2026-05-01 09:20:00',20,1),(477,5,20,'2026-05-01 09:40:00',20,1),(478,5,20,'2026-05-01 10:00:00',20,1),(479,5,20,'2026-05-01 10:20:00',20,1),(480,5,20,'2026-05-01 10:40:00',20,1),(481,5,16,'2026-05-04 08:00:00',20,1),(482,5,16,'2026-05-04 08:20:00',20,1),(483,5,16,'2026-05-04 08:40:00',20,1),(484,5,16,'2026-05-04 09:00:00',20,1),(485,5,16,'2026-05-04 09:20:00',20,1),(486,5,16,'2026-05-04 09:40:00',20,1),(487,5,16,'2026-05-04 10:00:00',20,1),(488,5,16,'2026-05-04 10:20:00',20,1),(489,5,16,'2026-05-04 10:40:00',20,1),(490,5,17,'2026-05-05 08:00:00',20,1),(491,5,17,'2026-05-05 08:20:00',20,1),(492,5,17,'2026-05-05 08:40:00',20,1),(493,5,17,'2026-05-05 09:00:00',20,1),(494,5,17,'2026-05-05 09:20:00',20,1),(495,5,17,'2026-05-05 09:40:00',20,1),(496,5,17,'2026-05-05 10:00:00',20,1),(497,5,17,'2026-05-05 10:20:00',20,1),(498,5,17,'2026-05-05 10:40:00',20,1),(499,5,18,'2026-05-06 08:00:00',20,1),(500,5,18,'2026-05-06 08:20:00',20,1),(501,5,18,'2026-05-06 08:40:00',20,1),(502,5,18,'2026-05-06 09:00:00',20,1),(503,5,18,'2026-05-06 09:20:00',20,1),(504,5,18,'2026-05-06 09:40:00',20,1),(505,5,18,'2026-05-06 10:00:00',20,1),(506,5,18,'2026-05-06 10:20:00',20,1),(507,5,18,'2026-05-06 10:40:00',20,1),(508,5,19,'2026-05-07 08:00:00',20,1),(509,5,19,'2026-05-07 08:20:00',20,1),(510,5,19,'2026-05-07 08:40:00',20,1),(511,5,19,'2026-05-07 09:00:00',20,1),(512,5,19,'2026-05-07 09:20:00',20,1),(513,5,19,'2026-05-07 09:40:00',20,1),(514,5,19,'2026-05-07 10:00:00',20,1),(515,5,19,'2026-05-07 10:20:00',20,1),(516,5,19,'2026-05-07 10:40:00',20,1),(517,5,20,'2026-05-08 08:00:00',20,1),(518,5,20,'2026-05-08 08:20:00',20,1),(519,5,20,'2026-05-08 08:40:00',20,1),(520,5,20,'2026-05-08 09:00:00',20,1),(521,5,20,'2026-05-08 09:20:00',20,1),(522,5,20,'2026-05-08 09:40:00',20,1),(523,5,20,'2026-05-08 10:00:00',20,1),(524,5,20,'2026-05-08 10:20:00',20,1),(525,5,20,'2026-05-08 10:40:00',20,1),(526,5,16,'2026-05-11 08:00:00',20,1),(527,5,16,'2026-05-11 08:20:00',20,1),(528,5,16,'2026-05-11 08:40:00',20,1),(529,5,16,'2026-05-11 09:00:00',20,1),(530,5,16,'2026-05-11 09:20:00',20,1),(531,5,16,'2026-05-11 09:40:00',20,1),(532,5,16,'2026-05-11 10:00:00',20,1),(533,5,16,'2026-05-11 10:20:00',20,1),(534,5,16,'2026-05-11 10:40:00',20,1),(535,5,17,'2026-05-12 08:00:00',20,1),(536,5,17,'2026-05-12 08:20:00',20,1),(537,5,17,'2026-05-12 08:40:00',20,1),(538,5,17,'2026-05-12 09:00:00',20,1),(539,5,17,'2026-05-12 09:20:00',20,1),(540,5,17,'2026-05-12 09:40:00',20,1),(541,5,17,'2026-05-12 10:00:00',20,1),(542,5,17,'2026-05-12 10:20:00',20,1),(543,5,17,'2026-05-12 10:40:00',20,1),(544,5,18,'2026-05-13 08:00:00',20,1),(545,5,18,'2026-05-13 08:20:00',20,1),(546,5,18,'2026-05-13 08:40:00',20,1),(547,5,18,'2026-05-13 09:00:00',20,1),(548,5,18,'2026-05-13 09:20:00',20,1),(549,5,18,'2026-05-13 09:40:00',20,1),(550,5,18,'2026-05-13 10:00:00',20,1),(551,5,18,'2026-05-13 10:20:00',20,1),(552,5,18,'2026-05-13 10:40:00',20,1),(553,5,19,'2026-05-14 08:00:00',20,1),(554,5,19,'2026-05-14 08:20:00',20,1),(555,5,19,'2026-05-14 08:40:00',20,1),(556,5,19,'2026-05-14 09:00:00',20,1),(557,5,19,'2026-05-14 09:20:00',20,1),(558,5,19,'2026-05-14 09:40:00',20,1),(559,5,19,'2026-05-14 10:00:00',20,1),(560,5,19,'2026-05-14 10:20:00',20,1),(561,5,19,'2026-05-14 10:40:00',20,1),(562,5,20,'2026-05-15 08:00:00',20,1),(563,5,20,'2026-05-15 08:20:00',20,1),(564,5,20,'2026-05-15 08:40:00',20,1),(565,5,20,'2026-05-15 09:00:00',20,1),(566,5,20,'2026-05-15 09:20:00',20,1),(567,5,20,'2026-05-15 09:40:00',20,1),(568,5,20,'2026-05-15 10:00:00',20,1),(569,5,20,'2026-05-15 10:20:00',20,1),(570,5,20,'2026-05-15 10:40:00',20,1),(571,5,16,'2026-05-18 08:00:00',20,1),(572,5,16,'2026-05-18 08:20:00',20,1),(573,5,16,'2026-05-18 08:40:00',20,1),(574,5,16,'2026-05-18 09:00:00',20,1),(575,5,16,'2026-05-18 09:20:00',20,1),(576,5,16,'2026-05-18 09:40:00',20,1),(577,5,16,'2026-05-18 10:00:00',20,1),(578,5,16,'2026-05-18 10:20:00',20,1),(579,5,16,'2026-05-18 10:40:00',20,1),(580,5,17,'2026-05-19 08:00:00',20,1),(581,5,17,'2026-05-19 08:20:00',20,1),(582,5,17,'2026-05-19 08:40:00',20,1),(583,5,17,'2026-05-19 09:00:00',20,1),(584,5,17,'2026-05-19 09:20:00',20,1),(585,5,17,'2026-05-19 09:40:00',20,1),(586,5,17,'2026-05-19 10:00:00',20,1),(587,5,17,'2026-05-19 10:20:00',20,1),(588,5,17,'2026-05-19 10:40:00',20,1),(589,5,18,'2026-05-20 08:00:00',20,1),(590,5,18,'2026-05-20 08:20:00',20,1),(591,5,18,'2026-05-20 08:40:00',20,1),(592,5,18,'2026-05-20 09:00:00',20,1),(593,5,18,'2026-05-20 09:20:00',20,1),(594,5,18,'2026-05-20 09:40:00',20,1),(595,5,18,'2026-05-20 10:00:00',20,1),(596,5,18,'2026-05-20 10:20:00',20,1),(597,5,18,'2026-05-20 10:40:00',20,1),(598,5,19,'2026-05-21 08:00:00',20,1),(599,5,19,'2026-05-21 08:20:00',20,1),(600,5,19,'2026-05-21 08:40:00',20,1),(601,5,19,'2026-05-21 09:00:00',20,1),(602,5,19,'2026-05-21 09:20:00',20,1),(603,5,19,'2026-05-21 09:40:00',20,1),(604,5,19,'2026-05-21 10:00:00',20,1),(605,5,19,'2026-05-21 10:20:00',20,1),(606,5,19,'2026-05-21 10:40:00',20,1),(607,5,20,'2026-05-22 08:00:00',20,1),(608,5,20,'2026-05-22 08:20:00',20,1),(609,5,20,'2026-05-22 08:40:00',20,1),(610,5,20,'2026-05-22 09:00:00',20,1),(611,5,20,'2026-05-22 09:20:00',20,1),(612,5,20,'2026-05-22 09:40:00',20,1),(613,5,20,'2026-05-22 10:00:00',20,1),(614,5,20,'2026-05-22 10:20:00',20,1),(615,5,20,'2026-05-22 10:40:00',20,1),(616,5,16,'2026-05-25 08:00:00',20,1),(617,5,16,'2026-05-25 08:20:00',20,1),(618,5,16,'2026-05-25 08:40:00',20,1),(619,5,16,'2026-05-25 09:00:00',20,1),(620,5,16,'2026-05-25 09:20:00',20,1),(621,5,16,'2026-05-25 09:40:00',20,1),(622,5,16,'2026-05-25 10:00:00',20,1),(623,5,16,'2026-05-25 10:20:00',20,1),(624,5,16,'2026-05-25 10:40:00',20,1),(625,5,17,'2026-05-26 08:00:00',20,1),(626,5,17,'2026-05-26 08:20:00',20,1),(627,5,17,'2026-05-26 08:40:00',20,1),(628,5,17,'2026-05-26 09:00:00',20,1),(629,5,17,'2026-05-26 09:20:00',20,1),(630,5,17,'2026-05-26 09:40:00',20,1),(631,5,17,'2026-05-26 10:00:00',20,1),(632,5,17,'2026-05-26 10:20:00',20,1),(633,5,17,'2026-05-26 10:40:00',20,1),(634,5,18,'2026-05-27 08:00:00',20,1),(635,5,18,'2026-05-27 08:20:00',20,1),(636,5,18,'2026-05-27 08:40:00',20,1),(637,5,18,'2026-05-27 09:00:00',20,1),(638,5,18,'2026-05-27 09:20:00',20,1),(639,5,18,'2026-05-27 09:40:00',20,1),(640,5,18,'2026-05-27 10:00:00',20,1),(641,5,18,'2026-05-27 10:20:00',20,1),(642,5,18,'2026-05-27 10:40:00',20,1),(643,5,19,'2026-05-28 08:00:00',20,1),(644,5,19,'2026-05-28 08:20:00',20,1),(645,5,19,'2026-05-28 08:40:00',20,1),(646,5,19,'2026-05-28 09:00:00',20,1),(647,5,19,'2026-05-28 09:20:00',20,1),(648,5,19,'2026-05-28 09:40:00',20,1),(649,5,19,'2026-05-28 10:00:00',20,1),(650,5,19,'2026-05-28 10:20:00',20,1),(651,5,19,'2026-05-28 10:40:00',20,1),(652,5,20,'2026-05-29 08:00:00',20,1),(653,5,20,'2026-05-29 08:20:00',20,1),(654,5,20,'2026-05-29 08:40:00',20,1),(655,5,20,'2026-05-29 09:00:00',20,1),(656,5,20,'2026-05-29 09:20:00',20,1),(657,5,20,'2026-05-29 09:40:00',20,1),(658,5,20,'2026-05-29 10:00:00',20,1),(659,5,20,'2026-05-29 10:20:00',20,1),(660,5,20,'2026-05-29 10:40:00',20,1);
/*!40000 ALTER TABLE `TERMIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ZAHTEV_ZA_PODATKE`
--

DROP TABLE IF EXISTS `ZAHTEV_ZA_PODATKE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ZAHTEV_ZA_PODATKE` (
  `idZahtev` int NOT NULL AUTO_INCREMENT,
  `tipZahteva` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datumZahteva` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datumObrade` datetime DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PRIMLJEN',
  `napomena` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `korisnickoIme` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `putanjaFajla` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdfPutanja` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idZahtev`),
  KEY `idx_zahtev_podatke_status` (`status`),
  KEY `fk_zahtev_korisnik` (`korisnickoIme`),
  CONSTRAINT `fk_zahtev_korisnik` FOREIGN KEY (`korisnickoIme`) REFERENCES `KORISNIK` (`korisnickoIme`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `chk_gdpr_status` CHECK ((`status` in (_utf8mb4'PRIMLJEN',_utf8mb4'U_OBRADI',_utf8mb4'ZAVRSEN'))),
  CONSTRAINT `chk_tip_zahteva` CHECK ((`tipZahteva` in (_utf8mb4'UVID',_utf8mb4'BRISANJE',_utf8mb4'PRENOSIVOST',_utf8mb4'ISPRAVKA')))
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ZAHTEV_ZA_PODATKE`
--

LOCK TABLES `ZAHTEV_ZA_PODATKE` WRITE;
/*!40000 ALTER TABLE `ZAHTEV_ZA_PODATKE` DISABLE KEYS */;
INSERT INTO `ZAHTEV_ZA_PODATKE` VALUES (1,'UVID','2026-02-10 10:30:00','2026-02-12 14:00:00','ZAVRSEN','Podaci dostavljeni pacijentu kroz portal.','draganmarkovic174',NULL,NULL),(2,'PRENOSIVOST','2026-03-25 16:00:00','2026-04-15 23:17:40','ZAVRSEN','Pacijentkinja traži JSON izvoz za novog lekara.','draganmarkovic174',NULL,NULL),(9,'ISPRAVKA','2026-04-19 23:02:11','2026-04-21 00:39:32','ZAVRSEN','','draganmarkovic174',NULL,NULL),(35,'UVID','2026-04-21 14:06:51','2026-04-21 14:07:06','ZAVRSEN','','milicavasic392',NULL,NULL),(36,'BRISANJE','2026-04-21 14:06:55',NULL,'PRIMLJEN','','milicavasic392',NULL,NULL);
/*!40000 ALTER TABLE `ZAHTEV_ZA_PODATKE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ZAHTEV_ZA_PREGLED`
--

DROP TABLE IF EXISTS `ZAHTEV_ZA_PREGLED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ZAHTEV_ZA_PREGLED` (
  `idZahtev` int NOT NULL AUTO_INCREMENT,
  `idPacijenta` int NOT NULL,
  `idDoktora` int NOT NULL,
  `idTermina` int DEFAULT NULL,
  `napomena` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CEKA',
  `komentarDoktora` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datumZahteva` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datumObrade` datetime DEFAULT NULL,
  `idPregleda` int DEFAULT NULL,
  PRIMARY KEY (`idZahtev`),
  KEY `fk_zp_termin` (`idTermina`),
  KEY `fk_zp_pregled` (`idPregleda`),
  KEY `idx_zp_doktor_status` (`idDoktora`,`status`),
  KEY `idx_zp_pacijent` (`idPacijenta`),
  CONSTRAINT `fk_zp_doktor` FOREIGN KEY (`idDoktora`) REFERENCES `DOKTOR` (`idDoktor`),
  CONSTRAINT `fk_zp_pacijent` FOREIGN KEY (`idPacijenta`) REFERENCES `PACIJENT` (`idPacijent`),
  CONSTRAINT `fk_zp_pregled` FOREIGN KEY (`idPregleda`) REFERENCES `PREGLED` (`idPregled`) ON DELETE SET NULL,
  CONSTRAINT `fk_zp_termin` FOREIGN KEY (`idTermina`) REFERENCES `TERMIN` (`idTermin`) ON DELETE SET NULL,
  CONSTRAINT `chk_zp_status` CHECK ((`status` in (_utf8mb4'CEKA',_utf8mb4'ODOBREN',_utf8mb4'ODBIJEN')))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ZAHTEV_ZA_PREGLED`
--

LOCK TABLES `ZAHTEV_ZA_PREGLED` WRITE;
/*!40000 ALTER TABLE `ZAHTEV_ZA_PREGLED` DISABLE KEYS */;
INSERT INTO `ZAHTEV_ZA_PREGLED` VALUES (1,1,1,17,'Kontrolni pregled, nastavak praćenja hipertenzije i lipidskog statusa.','ODOBREN','Termin potvrđen. Molim Vas da ponete dnevnik krvnog pritiska i rezultate Holter EKG-a.','2026-03-20 11:00:00','2026-03-21 09:15:00',NULL),(2,6,5,18,'Redovni pedijatrijski pregled. Roditelj: Miloš Đurić.','ODOBREN','Termin potvrđen. Molim da dete bude naspavano i nahranjeno.','2026-03-25 14:00:00','2026-03-26 08:30:00',NULL),(3,3,2,14,'Javljam se zbog bolova u stomaku koji traju već nekoliko nedelja.','ODBIJEN','Izvinite, ovaj termin je u međuvremenu zauzet. Molim Vas odaberite drugi slobodan termin u sistemu.','2026-03-28 10:00:00','2026-03-28 16:45:00',NULL),(4,5,3,13,'Povremene glavobolje i vrtoglavice poslednje dve nedelje.','ODBIJEN','necu','2026-04-01 09:30:00','2026-04-19 17:19:43',NULL),(5,4,2,19,'Kontrola posle završene fizikalne terapije cervikalne kičme.','ODOBREN','Termin potvrđen. Preporučujem da nastavite s domaćim programom vežbi.','2026-03-30 12:00:00','2026-04-01 08:00:00',NULL),(6,1,4,15,'Donecu cokoladu i 200g kafe. Srdacan pozdrav doktorka. ','CEKA',NULL,'2026-04-18 22:47:31',NULL,NULL),(7,6,2,14,'','ODOBREN',NULL,'2026-04-18 23:45:35','2026-04-18 23:47:13',NULL),(8,1,1,10,'','ODOBREN',NULL,'2026-04-19 16:17:28','2026-04-19 16:19:28',NULL),(9,1,3,13,'','ODBIJEN','necu','2026-04-19 16:17:35','2026-04-19 17:19:40',NULL),(12,4,3,267,'','ODOBREN',NULL,'2026-04-19 17:18:37','2026-04-19 17:19:36',NULL),(13,2,3,268,'','ODOBREN',NULL,'2026-04-19 23:22:27','2026-04-19 23:22:48',NULL),(14,1,1,20,'','ODOBREN',NULL,'2026-04-20 00:29:27','2026-04-20 18:51:25',NULL),(15,1,4,347,'Prvi pregled.','ODOBREN',NULL,'2026-04-20 00:31:04','2026-04-20 00:31:23',NULL),(20,17,1,41,'nesto','ODOBREN',NULL,'2026-04-22 12:57:19','2026-04-22 12:57:58',30);
/*!40000 ALTER TABLE `ZAHTEV_ZA_PREGLED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ZDRAVSTVENI_KARTON`
--

DROP TABLE IF EXISTS `ZDRAVSTVENI_KARTON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ZDRAVSTVENI_KARTON` (
  `idKarton` int NOT NULL AUTO_INCREMENT,
  `idPacijenta` int NOT NULL,
  `krvnaGrupa` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alergije` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hronicanBolesnik` tinyint(1) NOT NULL DEFAULT '0',
  `napomena` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datumKreiranja` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`idKarton`),
  UNIQUE KEY `uq_karton_pacijent` (`idPacijenta`),
  CONSTRAINT `fk_karton_pacijent` FOREIGN KEY (`idPacijenta`) REFERENCES `PACIJENT` (`idPacijent`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ZDRAVSTVENI_KARTON`
--

LOCK TABLES `ZDRAVSTVENI_KARTON` WRITE;
/*!40000 ALTER TABLE `ZDRAVSTVENI_KARTON` DISABLE KEYS */;
INSERT INTO `ZDRAVSTVENI_KARTON` VALUES (1,1,'A+','Penicilin',1,'U terapiji hipertenzije od 2020. godine.','2025-10-15'),(2,2,'O+',NULL,0,NULL,'2025-10-15'),(3,3,'B+',NULL,0,'Povremene tegobe sa lumbalnom kičmom.','2025-10-16'),(4,4,'AB-','Ibuprofen (blaga reakcija)',1,'Hronične tegobe cervikalne kičme.','2025-10-16'),(5,5,'A-',NULL,1,'Dijabetes tip 2 pod terapijom od 2018. godine.','2025-10-17'),(6,6,'O+',NULL,0,'Dete, 4 godine. Pristup dozvoljen roditelju.','2025-11-20'),(14,17,NULL,NULL,0,NULL,'2026-04-22');
/*!40000 ALTER TABLE `ZDRAVSTVENI_KARTON` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-22 23:02:18

-- MySQL dump 10.15  Distrib 10.0.21-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	10.0.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `summary` text NOT NULL,
  `content` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'1st Blog Post','Lorem ipsum','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.','2016-02-27 19:12:45'),(2,'DUMP najavljuje besplatnu Malu školu Photoshopa','Nakon održane tradicionalne Škole osnova programiranja, DUMP Udruga mladih programera iz Splita organizira novi ciklus na zahtjev publike.','Nakon održane tradicionalne Škole osnova programiranja, DUMP Udruga mladih programera iz Splita organizira novi ciklus na zahtjev publike. Veliki broj zainteresiranih za znanje iz područja obrade fotografije imat će priliku besplatno naučiti osnove Photoshopa – jednog od najmoćnijih alata za manipulaciju fotografijama. Splitska publika imat će priliku proširiti svoje znanje na novom ciklusu besplatnih predavanja pod imenom Mala škola Photoshopa koji DUMP održava po prvi put od 2013. godine.\n\nDUMP Udruga mladih programera, većinom sastavljena od studenata splitskog FESB-a, već godinama održava različita besplatna predavanja i radionice kako bi zainteresirala javnost za različita tehnološka područja. Kvalitetu i pogođenost DUMP-ovih predavanja dokazuje nekoliko tisuća posjetitelja na predavanjima održanim tokom prošle godine.\n\nMala škola Photoshopa kreće u subotu 5.3., u 17 sati u amfiteatru A100 na FESB-u u Splitu, a trajat će tri vikenda. Informacije o ostalim aktivnostima udruge, kao i detaljnije informacije vezane za ciklus, mogu se pronaći na web ili Facebook stranici DUMP-a.','2016-02-27 22:22:14'),(3,'Hakiranje Touch ID senzora – plastelinom','Sigurnosni stručnjaci iz kompanije Vkansee demonstrirali su na ovotjednom MWC-u u Barceloni kako se naizgled sigurno rješenje za zaštitu mobitela lako može prevariti. Oni su za demonstraciju koristili iPhone s Touch ID senzorom otiska prsta, te najobičniji dječji plastelin.','Sigurnosni stručnjaci iz kompanije Vkansee demonstrirali su na ovotjednom MWC-u u Barceloni kako se naizgled sigurno rješenje za zaštitu mobitela lako može prevariti. Oni su za demonstraciju koristili iPhone s Touch ID senzorom otiska prsta, te najobičniji dječji plastelin.\n\n\"Hakiranje\" funkcionira onako kako bi to očekivali čitatelji jeftinih krimi-romana: napadač u plastelinu napravi otisak prsta vlasnika mobitela, te isti prisloni na Touch ID čitač. Nakon samo nekoliko pokušaja, iPhone je otključan!\n\nIza cijele ove priče stoji i komercijalni aspekt, jer, ipak se radi o izlagačima sa sajma elektronike. Kompanija Vkansee razvila je senzor otiska prsta koji snima otiske u rezoluciji od 2000 dpi, za razliku od Appleovog koji ima rezoluciju tek 500 dpi. Samim time oni tvrde da su njihovi proizvodi sigurniji i bolji od ostalih na tržištu.\n\nSvejedno, korisnici mobitela s čitačem otiska prsta trebali bi pripaziti na ovu činjenicu i ne dozvoliti neznancima da im uzimaju otisak prsta u plastelinu, barem dok proizvođači u mobitele ne ugrade Vkanseeove senzore.','2016-02-27 23:13:27'),(4,'#LadiesZG: Razgrabljene pozivnice za Ladies of New Business!','Čini se da je tema žena u tehnološkoj i digitalnoj industriji itekako zanimljiva, s obzirom na to da su se pozivnice za konferenciju Ladies of New Business razgrabile i prije no što smo uspjeli službeno najaviti sudionike i sudionice programa. Prijave su od danas zatvorene, a evo što očekuje one koji su uspjeli doći do svoje pozivnice.','Čini se da je tema žena u tehnološkoj i digitalnoj industriji itekako zanimljiva, s obzirom na to da su se pozivnice za konferenciju Ladies of New Business razgrabile i prije no što smo uspjeli službeno najaviti sudionike i sudionice programa. Prijave su od danas zatvorene, a evo što očekuje one koji su uspjeli doći do svoje pozivnice.\n\nPodsjetimo, Ladies of New Business događanja su koja Netokracija organizira u Zagrebu, Ljubljani i Beogradu. U Zagrebu će se u petak, 4. ožujka, u novootvorenom prostoru HUB385 okupiti oko 150 sudionika i sudionica iz tehnološke industrije, bilo da je riječ o direktoricama i članicama uprava, poduzetnicama koje razvijaju svoje tehnološke projekte i agencije, aktivisticama koje razvijaju nove društveno-korisne tehnološke projekte, dizajnericama, programerkama, digitalnim marketingašicama… A sve kako bi razgovarale o izazovima u razvoju svoje (digitalne) karijere te o svom osobnom razvoju.\n\nRazgovor s Ivanom Šoljan i Elizabetom Novaković\nOdržat će se dva jedan-na-jedan razgovora na pozornici – jedan će biti s mladom poduzetnicom Elizabetom Novaković, autoricom Acro planera, koja nam je svojedobno na Netokraciji otkrila kako koristi moć Instagrama za brendiranje svog proizvoda, a u petak ćemo imati priliku čuti i njenu osobniju priču. Drugi će razgovor biti s Ivanom Šoljan, članicom uprave u tvrtki IN2, a u ovom kontekstu je dodatno zanimljivo što je i suosnivačica Zaklade Luka, koja je i partner događanja. Zaklada je počela djelovanje programom koji pruža financijsku potporu ženama i djevojkama slabijeg imovinskog stanja u stjecanju najboljeg mogućeg obrazovanja, kao i u njihovim ranim poslovnim karijerama. Tu je uključen i program mentoriranja gdje stipendistice imaju na raspolaganju mentora ili mentoricu koji će im tijekom studija pružati stručnu pomoć i potporu, temeljem dugogodišnjeg vlastitog iskustva.\n\nRasprave o važnosti mentoriranja i napretku – do vrha\nVažnost mentoriranja za osobni i poslovni razvoj prepoznali smo i mi, stoga smo u sklopu Ladies of New Business organizirali i program povezivanja mentora i mentorica s osobama koje žele biti mentorirane pod imenom Digitalni karanfili. Također, o važnosti mentoriranja raspravljat će se i na jednom od panela na kojemu će, među ostalima, sudjelovati Ida Pandur, direktorica i osnivačica agencije ENTG, Lana Rosandić, direktorica agencije Alert, Antonija Bilić Arar, country managerica Blablacara za Hrvatsku, te Ivana Matić, osnivačica i direktorica Women in Adria.\n\nA kako do vrha, otkrit će nam u drugom panelu Ivana Galić, direktorica marketinga i korporativnih komunikacija, NovaTV, Nataša Kapetanović, članica uprave Grawe osiguranja, Nataša Đukanović, direktorica marketinga, .Me Domaina, Dijana Hrastović, članica Uprave Zagrebačke banke i druge sudionice.\n\nNa događanju ćemo predstaviti i rezultate istraživanja nastalog u suradnji s Hendalom, koje će nam otkriti nešto više o izazovima s kojima se žene u Hrvatskoj susreću na svom poslovnom putu, a nakon razgovora, panela i pronalaska pravog mentora ili mentorice, slijedi i neformalno druženje od 21 sat.','2016-02-29 09:34:15');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-28  2:56:02

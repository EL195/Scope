-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 03 Janvier 2019 à 03:07
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `scope`
--
CREATE DATABASE IF NOT EXISTS `scope` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `scope`;

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ADD_COMMANDE_TEMP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_COMMANDE_TEMP`(P_IDU int,
P_CodeP varchar(50),P_IDA varchar(10),
P_Qte int,P_Mt int)
BEGIN
   INSERT INTO `scope`.`commande_temp` 
   (`IDUtilisateur`, `CodePatient`, `IDActe`, `Qte`, `Montant`) 
   VALUES (P_IDU, P_CodeP, P_IDA, P_Qte, P_Mt);

END$$

DROP PROCEDURE IF EXISTS `COMMANDES_PAR_DEBUT_NOMPATIENT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMMANDES_PAR_DEBUT_NOMPATIENT`(P_NomP varchar(50))
BEGIN

  select  * from   facture f,commande c,patient p  
  where c.CodeCommande = f.CodeCommande
 -- and CodeCommande = P_CodeCmd
  and c.CodePatient = p.CodePatient
  and p.NomPatient like concat(P_NomP,'%')
  group by f.CodeCommande;



  -- select distinct * 
-- from commande c,patient p,acte a 
-- where c.CodePatient = p.CodePatient
-- and c.IDActe = a.IDActe
-- and p.NomPatient like concat(P_NomP,'%')
-- group by CodeCommande ;
END$$

DROP PROCEDURE IF EXISTS `COMMANDE_TEMPS_SAVING`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `COMMANDE_TEMPS_SAVING`(P_CodePatient varchar(50),P_IDUser int)
BEGIN
  select distinct * from (
 select distinct CT.CodePatient,CT.IDActe,CT.Qte
 ,CT.Montant,CT.IDUtilisateur,curdate(),curtime() 
  from ACTE A,COMMANDE_TEMP CT
  where 
   A.IDActe = CT.IDActe
  -- and P.CodePatient = CT.CodePatient
   and A.IDActe 
  in (select IDActe  from COMMANDE_TEMP  
       where CodePatient =P_CodePatient 
       and IDUtilisateur =P_IDUser
     )) CM 
     where CM.CodePatient =P_CodePatient  ;
END$$

DROP PROCEDURE IF EXISTS `COUT_TOTAL_COMMANDE_TEMP_D_UN_PATIENT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `COUT_TOTAL_COMMANDE_TEMP_D_UN_PATIENT`(P_CodePatient varchar(50),
P_IDUser int)
BEGIN
     -- declare T int;
    if (P_CodePatient<>'' and P_IDUser > 0) then
    
		  select sum(Montant) as CT 
	   from commande_temp 
	   where CodePatient = P_CodePatient
	   and IDUtilisateur = P_IDUser;
       
    end if;

   
END$$

DROP PROCEDURE IF EXISTS `CREATE_ACTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_ACTE`(P_NomA varchar(100),
P_IDDomaine int,P_CoutA int)
BEGIN

  declare init varchar(10);
  declare max_act int;
  declare set_init varchar(10);
  select Initiale into init from domaine where IDDomaine = P_IDDomaine;
  select (count(IDActe)+1) into max_act from ACTE where IDDomaine = P_IDDomaine;
  
  set set_init = concat(init,max_act); 
  INSERT INTO 
  `scope`.`acte`
  (`IDActe`, `NomActe`, 
  `KAnesthesie`, `KChirurgical`, `CoutActe`,
  `IDDomaine`, `DateCreation`,`HeureCreation`) 
  VALUES (set_init, P_NomA, '', '', P_CoutA,P_IDDomaine, curdate(), curtime());

END$$

DROP PROCEDURE IF EXISTS `CREATE_COMMANDE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_COMMANDE`(P_CodePatient varchar(50),
P_IDUser int,P_CodeCmd varchar(100),
P_Avance int,P_IDService int,P_IDPraticien int)
BEGIN
        declare ct int;
        declare CodeRecu varchar(100);
        declare d varchar(10); 
        set d =  DATE_COURANTE_FR(curdate()); 
         select sum(Montant) into ct 
	   from commande_temp 
	   where CodePatient = P_CodePatient
	   and IDUtilisateur = P_IDUser;
       
           insert into commande(CodeCommande,CodePatient,IDService,IDPraticien,
              IDActe,QuantiteCommande,Montant,IDUtilisateur,
              DateCommande,HeureCommande) 
              select distinct 
              P_CodeCmd, CT.CodePatient,P_IDService,P_IDPraticien,CT.IDActe,CT.Qte,CT.Montant,
                   CT.IDUtilisateur,d,curtime() 
            from COMMANDE_TEMP CT 
           where CT.CodePatient =P_CodePatient 
             and CT.IDUtilisateur =P_IDUser ;
           
		
        
        INSERT INTO `scope`.`facture`
        (`CodeCommande`, `NetAPayer`, `DateFacture`, `HeureFacture`)
        VALUES (P_CodeCmd, ct,
        d,curtime());
        
        select replace(replace(P_CodeCmd,'COM','FAC') ,'PAT00AB','REG00P') into CodeRecu;
        
        INSERT INTO `scope`.`recu` 
        (`CodeRecu`, `CodeCommande`, 
        `MontantRecu`, `FraisLivraison`,
        `ResteAPayer`, `Acompte`, 
        `Assurance`, `IDMode`, `DateRecu`,
        `HeureRecu`, `IDTypeReglement`) 
        VALUES (CodeRecu, P_CodeCmd,
				P_Avance , 0, 
                ct-P_Avance , 0, 
                0, 1, 
                d,curtime(), 1);


        
           
END$$

DROP PROCEDURE IF EXISTS `CREATE_PATIENT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREATE_PATIENT`(P_CodeP varchar(50),P_NomP varchar(50),
P_PrenomP varchar(50) , P_DateN varchar(10) ,P_LieuN varchar(100),
P_SexeP varchar(1), P_NiveauS varchar(100),P_NomReli varchar(100),
P_Ethnie varchar(100), P_Profession varchar(100), P_SituationM varchar(60),
P_TelP varchar(50), P_EmailP varchar(100),
P_NationP varchar(100),P_Pays varchar(100),
P_Quartier varchar(100),P_Ville varchar(100),P_NomPersprev varchar(150),
P_Telprev varchar(50),P_Pere varchar(150),
P_Mere varchar(150),
P_LieuDeces varchar(150),P_DateDeces varchar(10), P_HeureDeces varchar(10),
P_IDType int,op int)
BEGIN
   declare max int;
   declare newcode varchar(30);
   select (count(CodePatient)+1) into max from PATIENT where IDTypePatient = P_IDType;
   -- select (replace('PAT00T',P_IDType,max)) into newcode;
      
		IF op = 1 THEN
		--  DateDeces varchar(10), HeureDeces time, LieuDeces varchar(150) ,
		  INSERT INTO `patient`
		  (`CodePatient`, `NomPatient`,
		  `PrenomPatient`, `DateNaissance`, 
		  `LieuNaissance`, `SexePatient`, 
		  `NiveauScolaire`, `NomReligion`,
		  `NomEthnie`, `NomProfession`, 
		  `SituationMatrimoniale`, 
		  `TelephonePatient`, `EmailPatient`, 
		  `NomNationalite`, `NomPays`, 
		  `NomQuartier`, `NomVille`, `NomPersAPrevenir`,
		  `TelPersAPrevenir`, `NomPere`,`NomMere`,
		   `LieuDeces`, `DateDeces`, `HeureDeces`,
		  `DateEnregistrer`,`HeureEnregistrer`,`IDTypePatient`) 
		  
		  VALUES (concat('PAT00T',P_IDType,max,year(curdate())),
				  P_NomP,
				  P_PrenomP,
				  P_DateN, 
				  P_LieuN, 
				  P_SexeP, 
				  P_NiveauS, 
				  P_NomReli, 
				  P_Ethnie, 
				  P_Profession,
				  P_SituationM, 
				  P_TelP, 
				  P_EmailP, 
				  P_NationP, 
				  P_Pays, 
				  P_Quartier, 
				  P_Ville, 
				  P_NomPersprev, 
				  P_Telprev, 
				  P_Pere, 
				  P_Mere, 
				  P_LieuDeces, 
				  P_DateDeces, 
				  P_HeureDeces, 
				  curdate(),
				  curtime() ,
				  P_IDType );
		END IF;
        
        IF op = 2 THEN
		--  DateDeces varchar(10), HeureDeces time, LieuDeces varchar(150) ,
		UPDATE `patient` 
        SET `NomPatient`=P_NomP,
        `PrenomPatient`=P_PrenomP, 
        `DateNaissance`=P_DateN,
        `LieuNaissance`=P_LieuN, 
        `SexePatient`=P_SexeP,  
        `NiveauScolaire`=P_NiveauS,
        `NomReligion`=P_NomReli, 
        `NomEthnie`=P_Ethnie,
        `NomProfession`= P_Profession,
        `SituationMatrimoniale`= P_SituationM,
        `AdressePatient`='z', 
        `TelephonePatient`=P_TelP, 
        `EmailPatient`=P_EmailP, 
        `NomNationalite`=P_NationP, 
        `NomPays`=P_Pays,
        `NomQuartier`=P_Quartier, 
        `NomVille`=P_Ville,  
        `DateDeces`= P_DateDeces,
        `HeureDeces`= P_HeureDeces, 
        `LieuDeces`=P_LieuDeces, 
        `NomPersAPrevenir`=P_NomPersprev, 
        `TelPersAPrevenir`= P_Telprev,  
        `NomPere`=P_Pere, 
        `NomMere`=P_Mere,  
        `IDTypePatient`= P_IDType
        WHERE `CodePatient`=P_CodeP;

		END IF;
  

END$$

DROP PROCEDURE IF EXISTS `CREER_ASSURANCE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CREER_ASSURANCE`(P_Nom varchar(60),
P_Ville varchar(100),P_BP varchar(30),
P_Adresse varchar(30),P_Tel varchar(50),
P_Fax varchar(20),P_Mail varchar(100),
P_Etat boolean,P_NomC varchar(60),
P_TelC varchar(50))
BEGIN
    declare m int;
    select (count(*)+1) into m  from `scope`.`assurance`;
    
    INSERT INTO `scope`.`assurance`
    (`CodeAssurance`, `NomAssurance`, 
    `NomVille`, `BoitePostale`, 
    `AdresseAssurance`, `TelephoneAssurance`,
    `FaxAssurance`, `EmailAssurance`,
    `Etat`, `NomContactAssurance`, `TelephoneContactAssurance`)
    VALUES (concat('ASSP',m), P_Nom, 
            P_Ville, P_BP,
            P_Adresse, P_Tel, 
            P_Fax, P_Mail, 
            P_Etat, P_NomC, P_TelC);

END$$

DROP PROCEDURE IF EXISTS `DEATILS_RECU_D_UNE_FACTURE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DEATILS_RECU_D_UNE_FACTURE`(P_CodeCmd varchar(100))
BEGIN
  select * from   `recu` 
  where CodeCommande = P_CodeCmd ;
END$$

DROP PROCEDURE IF EXISTS `DELETE_COMMANDE_TEMP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETE_COMMANDE_TEMP`(P_IDU int,
P_CodeP varchar(100),P_IDA varchar(10))
BEGIN
    delete from commande_temp 
    where IDActe = P_IDA 
    and CodePatient = P_CodeP 
     and  IDUtilisateur = P_IDU;
END$$

DROP PROCEDURE IF EXISTS `DETAILS_COMMANDE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DETAILS_COMMANDE`(P_CodeCmd varchar(100))
BEGIN
   select distinct * 
from commande c,patient p,acte a 
where c.CodePatient = p.CodePatient
and c.IDActe = a.IDActe
and CodeCommande = P_CodeCmd ;
END$$

DROP PROCEDURE IF EXISTS `DETAILS_COMMANDE_PAR_DEBUT_NOMPATIENT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DETAILS_COMMANDE_PAR_DEBUT_NOMPATIENT`(P_NomP varchar(50))
BEGIN
   select distinct * 
from commande c,patient p,acte a 
where c.CodePatient = p.CodePatient
and c.IDActe = a.IDActe
and p.NomPatient like concat(P_NomP,'%') ;
END$$

DROP PROCEDURE IF EXISTS `DETAILS_COMMANDE_TEMP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DETAILS_COMMANDE_TEMP`(P_CodePatient varchar(50),P_IDUser int)
BEGIN
  select distinct * from (
 select distinct CT.IDActe,A.CoutActe,A.NomActe,CT.Qte,CT.Montant ,CT.CodePatient
-- sum(CT.Montant) as CT
  from ACTE A,COMMANDE_TEMP CT
  where 
   A.IDActe = CT.IDActe
  -- and P.CodePatient = CT.CodePatient
   and A.IDActe 
  in (select IDActe  from COMMANDE_TEMP  
       where CodePatient = P_CodePatient 
       and IDUtilisateur = P_IDUser
     )) CM 
     where CM.CodePatient = P_CodePatient ;
      -- and P.CodePatient = CT.CodePatient;
    --  group by (CT.CodePatient,CT.IDActe)  ;  
   -- and IDUtilisateur = P_IDUser  ;
END$$

DROP PROCEDURE IF EXISTS `DETAILS_FACTURE_D_UNE_COMMAND`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DETAILS_FACTURE_D_UNE_COMMAND`(P_CodeCmd varchar(100))
BEGIN
  select  * from   facture f,commande c,patient p  
  where c.CodeCommande = f.CodeCommande
  and CodeCommande = P_CodeCmd
  and c.CodePatient = p.CodePatient;
END$$

DROP PROCEDURE IF EXISTS `DETAILS_FACTURE_D_UNE_COMMANDE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DETAILS_FACTURE_D_UNE_COMMANDE`(P_CodeCmd varchar(100))
BEGIN
  select * from   facture
  where CodeCommande = P_CodeCmd;
END$$

DROP PROCEDURE IF EXISTS `DETAILS_RECU_D_UNE_FACTURE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DETAILS_RECU_D_UNE_FACTURE`(P_CodeCmd varchar(100))
BEGIN
  select distinct * from   `recu` 
  where CodeCommande = P_CodeCmd ;
END$$

DROP PROCEDURE IF EXISTS `LISTE_ACTES_D_UN_DOMAINE_D_UN_PATIENT_PAR_DEBUT_NOM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_ACTES_D_UN_DOMAINE_D_UN_PATIENT_PAR_DEBUT_NOM`(P_Libelle varchar(100),P_CodeP varchar(100),P_IDDomaine int)
BEGIN
  select * from acte  
  where IDActe not in 
 (select IDActe from commande_temp where CodePatient = P_CodeP) 
 AND NomActe like concat(P_Libelle,'%') 
 and IDDomaine = P_IDDomaine;
END$$

DROP PROCEDURE IF EXISTS `LISTE_ACTES_D_UN_PATIENT_PAR_DEBUT_NOM`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_ACTES_D_UN_PATIENT_PAR_DEBUT_NOM`(P_Libelle varchar(100),P_CodeP varchar(100))
BEGIN
  select * from acte  
  where IDActe not in 
 (select IDActe from commande_temp where CodePatient = P_CodeP) 
 AND NomActe like concat(P_Libelle,'%');
END$$

DROP PROCEDURE IF EXISTS `LISTE_DES_ACCES_D_UN_MODULE_A_UN_UTILISATEUR`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_DES_ACCES_D_UN_MODULE_A_UN_UTILISATEUR`(P_IDModule int,P_IDUtilisateur int)
BEGIN
		SELECT  distinct * 
		FROM attribution_acces ata ,utilisateur u,menu m,sous_menu sm,module mo
		where ata.IDModule = mo.IDModule
		and  ata.IDUtilisateur = u.IDUtilisateur
		and ata.IDMenu = m.IDMenu
		and ata.IDSousMenu = sm.IDSousMenu
        and  ata.IDUtilisateur  = P_IDUtilisateur
        and ata.IDModule = P_IDModule;
END$$

DROP PROCEDURE IF EXISTS `LISTE_DES_MENUS_DISPONIBLES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_DES_MENUS_DISPONIBLES`()
BEGIN
	-- SELECT  distinct *
	-- FROM attribution_acces ata ,menu m,sous_menu sm,module mo
		-- where ata.IDModule = mo.IDModule
		-- and ata.IDMenu = m.IDMenu
		-- and ata.IDSousMenu = sm.IDSousMenu;
        
        SELECT  distinct * from menu;
END$$

DROP PROCEDURE IF EXISTS `LISTE_DES_MENUS_D_UN_MODULE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_DES_MENUS_D_UN_MODULE`(P_IDModule int)
BEGIN
select  distinct * 
	from appartenance_module_menu apmm,menu m ,module mo
	where apmm.IDMenu = m.IDMenu
	and apmm.IDModule = mo.IDModule
	and apmm.IDModule = P_IDModule;
END$$

DROP PROCEDURE IF EXISTS `LISTE_DES_MENUS_D_UN_MODULE_A_UN_UTILISATEUR`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_DES_MENUS_D_UN_MODULE_A_UN_UTILISATEUR`(P_IDModule int,P_IDUtilisateur int)
BEGIN
		SELECT  distinct *
		FROM attribution_acces ata ,utilisateur u,menu m,sous_menu sm,module mo
		where ata.IDModule = mo.IDModule
		and  ata.IDUtilisateur = u.IDUtilisateur
		and ata.IDMenu = m.IDMenu
		and ata.IDSousMenu = sm.IDSousMenu
        and  ata.IDUtilisateur  = P_IDUtilisateur
        and ata.IDModule = P_IDModule;
END$$

DROP PROCEDURE IF EXISTS `LISTE_DES_MODULES_D_UN_UTILISATEUR`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_DES_MODULES_D_UN_UTILISATEUR`(P_IDUtilisateur int)
BEGIN
		SELECT  distinct *
		FROM attribution_acces ata ,utilisateur u,module mo
		where ata.IDModule = mo.IDModule
		and  ata.IDUtilisateur = u.IDUtilisateur
        and  ata.IDUtilisateur  = P_IDUtilisateur;
END$$

DROP PROCEDURE IF EXISTS `LISTE_DES_SOUS_MENUS_D_UN_MENU`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTE_DES_SOUS_MENUS_D_UN_MENU`(P_IDMenu int)
BEGIN
select  distinct * 
	from appartenance_menu_sous_menu apmsm,menu m ,sous_menu sm
	where apmsm.IDMenu = m.IDMenu
	and apmsm.IDSousMenu = sm.IDSousMenu
	and apmsm.IDMenu = P_IDMenu;
END$$

DROP PROCEDURE IF EXISTS `MODIFIER_ASSURANCE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MODIFIER_ASSURANCE`(P_Code varchar(10),P_Nom varchar(60),
P_Ville varchar(100),P_BP varchar(30),
P_Adresse varchar(30),P_Tel varchar(50),
P_Fax varchar(20),P_Mail varchar(100),
P_Etat boolean,P_NomC varchar(60),
P_TelC varchar(50))
BEGIN
   UPDATE `scope`.`assurance` 
   SET `NomAssurance`=P_Nom, 
       `NomVille`=P_Ville, 
       `BoitePostale`=P_BP, 
       `AdresseAssurance`=P_Adresse, 
       `TelephoneAssurance`=P_Tel, 
       `FaxAssurance`=P_Fax, 
       `EmailAssurance`=P_Mail, 
       `Etat`=P_Etat, 
       `NomContactAssurance`=P_NomC , 
       `TelephoneContactAssurance`=P_TelC 
       WHERE `CodeAssurance`=P_Code;

END$$

DROP PROCEDURE IF EXISTS `NEW_INDEX_CODE_COMMANDE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `NEW_INDEX_CODE_COMMANDE`(P_IDUser int)
BEGIN
    -- select distinct (count(*)+1) as max
    -- from ( select distinct c.CodeCommande
    -- from commande c , patient p where p.CodePatient=c.CodePatient
    -- and  c.CodePatient =P_CodePatient and c.IDUtilisateur =P_IDUser ) cm;
    select distinct (count(CodeCommande)+1 ) as max ,curdate() as dt
   from (SELECT distinct CodeCommande ,DateCommande
          FROM scope.commande where DateCommande = curdate() 
          and IDUtilisateur =P_IDUser ) CT;
END$$

--
-- Fonctions
--
DROP FUNCTION IF EXISTS `DATE_COURANTE_FR`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `DATE_COURANTE_FR`(P_Date varchar(10)) RETURNS varchar(10) CHARSET latin1
BEGIN

RETURN concat(day(P_Date),'/',month(P_Date),'/',year(P_Date));
END$$

DROP FUNCTION IF EXISTS `maxpatient`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `maxpatient`() RETURNS int(11)
BEGIN
    declare t int;
    select count(*) as maxpatient into t  from patient ;
RETURN t;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `accord_remise`
--

DROP TABLE IF EXISTS `accord_remise`;
CREATE TABLE IF NOT EXISTS `accord_remise` (
  `IDRemise` varchar(10) NOT NULL,
  `CodeCommande` varchar(100) NOT NULL,
  `Pourcentage` float NOT NULL,
  `Etat` tinyint(1) NOT NULL,
  `AttribuerPar` varchar(100) NOT NULL,
  `DateRemise` date NOT NULL,
  `HeureRemise` time NOT NULL,
  `MotifRemise` varchar(500) NOT NULL,
  PRIMARY KEY (`IDRemise`),
  KEY `CodeCommande` (`CodeCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `acte`
--

DROP TABLE IF EXISTS `acte`;
CREATE TABLE IF NOT EXISTS `acte` (
  `IDActe` varchar(30) NOT NULL,
  `NomActe` varchar(100) NOT NULL,
  `KAnesthesie` varchar(15) DEFAULT NULL,
  `KChirurgical` varchar(15) DEFAULT NULL,
  `CoutActe` int(11) DEFAULT NULL,
  `KValeur` int(11) DEFAULT NULL,
  `IDDomaine` int(11) DEFAULT NULL,
  `DateCreation` date DEFAULT NULL,
  `HeureCreation` time DEFAULT NULL,
  `CodeGroupeAnalytique` varchar(50) DEFAULT NULL,
  `CodeGroupeRecette` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDActe`),
  KEY `IDDomaine` (`IDDomaine`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `acte`
--

INSERT INTO `acte` (`IDActe`, `NomActe`, `KAnesthesie`, `KChirurgical`, `CoutActe`, `KValeur`, `IDDomaine`, `DateCreation`, `HeureCreation`, `CodeGroupeAnalytique`, `CodeGroupeRecette`) VALUES
('CONS1', 'CARNET', '', '', 500, NULL, 1, '2018-10-11', '09:22:21', NULL, NULL),
('CONS2', 'CARNET CPN', '', '', 2000, NULL, 1, '2018-10-11', '09:23:02', NULL, NULL),
('MAT1', 'FGEGDG', '', '', 2000, NULL, 2, '2018-10-11', '09:24:06', NULL, NULL),
('MAT2', 'QSEFDGDG', '', '', 2500, NULL, 2, '2018-10-11', '09:24:20', NULL, NULL),
('MAT3', 'LADDVC', '', '', 2500, NULL, 2, '2018-10-11', '09:24:37', NULL, NULL),
('MORG1', 'LAVAGE CORPS', '', '', 10500, NULL, 7, '2018-10-11', '09:27:33', NULL, NULL),
('MORG2', 'BOMAGE CORPS', '', '', 6500, NULL, 7, '2018-10-11', '09:28:43', NULL, NULL),
('RADIO1', 'PONCTION LOMBERT', '', '', 12000, NULL, 3, '2018-10-11', '09:25:46', NULL, NULL),
('RADIO2', 'PONCTION LOMBERT ABV', '', '', 12500, NULL, 3, '2018-10-11', '09:25:59', NULL, NULL),
('RADIO3', 'PONCTION', '', '', 10500, NULL, 3, '2018-10-11', '09:26:19', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `appartenance_menu_sous_menu`
--

DROP TABLE IF EXISTS `appartenance_menu_sous_menu`;
CREATE TABLE IF NOT EXISTS `appartenance_menu_sous_menu` (
  `CodeAppartenance` varchar(30) NOT NULL DEFAULT '',
  `IDMenu` int(11) NOT NULL DEFAULT '0',
  `IDSousMenu` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CodeAppartenance`,`IDMenu`,`IDSousMenu`),
  KEY `IDMenu` (`IDMenu`),
  KEY `IDSousMenu` (`IDSousMenu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `appartenance_module_menu`
--

DROP TABLE IF EXISTS `appartenance_module_menu`;
CREATE TABLE IF NOT EXISTS `appartenance_module_menu` (
  `CodeAppartenance` varchar(30) NOT NULL DEFAULT '',
  `IDMenu` int(11) NOT NULL DEFAULT '0',
  `IDModule` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CodeAppartenance`,`IDMenu`,`IDModule`),
  KEY `IDMenu` (`IDMenu`),
  KEY `IDModule` (`IDModule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `appartenance_module_menu`
--

INSERT INTO `appartenance_module_menu` (`CodeAppartenance`, `IDMenu`, `IDModule`) VALUES
('', 1, 2),
('', 2, 2),
('', 3, 2),
('', 4, 2),
('', 5, 2),
('', 6, 1),
('', 7, 1),
('', 8, 1),
('', 9, 1);

-- --------------------------------------------------------

--
-- Structure de la table `assurance`
--

DROP TABLE IF EXISTS `assurance`;
CREATE TABLE IF NOT EXISTS `assurance` (
  `CodeAssurance` varchar(10) NOT NULL,
  `NomAssurance` varchar(60) NOT NULL,
  `NomVille` varchar(100) NOT NULL,
  `BoitePostale` varchar(30) NOT NULL,
  `AdresseAssurance` varchar(30) NOT NULL,
  `TelephoneAssurance` varchar(50) NOT NULL,
  `FaxAssurance` varchar(20) NOT NULL,
  `EmailAssurance` varchar(100) NOT NULL,
  `Etat` tinyint(1) NOT NULL,
  `NomContactAssurance` varchar(60) NOT NULL,
  `TelephoneContactAssurance` varchar(50) NOT NULL,
  PRIMARY KEY (`CodeAssurance`),
  KEY `NomVille` (`NomVille`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `assurance`
--

INSERT INTO `assurance` (`CodeAssurance`, `NomAssurance`, `NomVille`, `BoitePostale`, `AdresseAssurance`, `TelephoneAssurance`, `FaxAssurance`, `EmailAssurance`, `Etat`, `NomContactAssurance`, `TelephoneContactAssurance`) VALUES
('ASSP1', 'ASCOMA', 'EBOLOWA', '125PO1', 'Rue Magzzi Bassa', '332214785423', '2154', 'monassurance.com', 1, 'M. YOUMBI MERLINO', '651897412'),
('ASSP2', 'HCR', 'BERTOUA', 'PO457ILP', 'Avenue Kenedy', '+2382569874120', '4587AF', 'hcr@yahoo.fr', 1, 'M. KEMAYOU HERMAN', '675604995'),
('ASSP3', 'KOALA', 'BUEA', '', '', '', '', 'erccx', 1, '', '');

-- --------------------------------------------------------

--
-- Structure de la table `attribution_acces`
--

DROP TABLE IF EXISTS `attribution_acces`;
CREATE TABLE IF NOT EXISTS `attribution_acces` (
  `NomAcces` varchar(100) DEFAULT NULL,
  `IDModule` int(11) NOT NULL DEFAULT '0',
  `IDMenu` int(11) NOT NULL DEFAULT '0',
  `IDSousMenu` int(11) NOT NULL DEFAULT '0',
  `IDUtilisateur` int(11) NOT NULL DEFAULT '0',
  `DateAttribution` date DEFAULT NULL,
  `HeureAttribution` time DEFAULT NULL,
  PRIMARY KEY (`IDModule`,`IDUtilisateur`,`IDSousMenu`,`IDMenu`),
  KEY `IDMenu` (`IDMenu`),
  KEY `IDSousMenu` (`IDSousMenu`),
  KEY `IDUtilisateur` (`IDUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `attribution_acces`
--

INSERT INTO `attribution_acces` (`NomAcces`, `IDModule`, `IDMenu`, `IDSousMenu`, `IDUtilisateur`, `DateAttribution`, `HeureAttribution`) VALUES
(NULL, 1, 6, 1, 1, NULL, NULL),
(NULL, 1, 7, 1, 1, NULL, NULL),
(NULL, 1, 8, 1, 1, NULL, NULL),
(NULL, 1, 9, 1, 1, NULL, NULL),
(NULL, 2, 2, 1, 1, NULL, NULL),
(NULL, 2, 3, 1, 1, NULL, NULL),
(NULL, 2, 4, 1, 1, NULL, NULL),
(NULL, 2, 5, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `CodeCommande` varchar(100) NOT NULL DEFAULT '',
  `CodePatient` varchar(50) NOT NULL DEFAULT '',
  `CodeProduit` varchar(50) NOT NULL DEFAULT '',
  `IDActe` varchar(10) NOT NULL DEFAULT '',
  `QuantiteCommande` int(11) DEFAULT NULL,
  `Montant` int(11) DEFAULT NULL,
  `Remise` float DEFAULT NULL,
  `PourcentageRemise` float NOT NULL,
  `MontantRemise` int(11) NOT NULL,
  `DateCommande` varchar(10) NOT NULL DEFAULT '',
  `HeureCommande` time DEFAULT NULL,
  `DateRemise` date NOT NULL,
  `HeureRemise` time NOT NULL,
  `DateRegler` varchar(10) DEFAULT NULL,
  `heureRegler` time DEFAULT NULL,
  `EtatCommande` int(11) DEFAULT NULL,
  `IDPraticien` int(11) DEFAULT NULL,
  `IDTypeCommande` int(11) NOT NULL DEFAULT '0',
  `IDUtilisateur` int(11) NOT NULL DEFAULT '0',
  `IDService` int(11) DEFAULT NULL,
  `DateModifCommande` datetime DEFAULT NULL,
  PRIMARY KEY (`CodeCommande`,`CodePatient`,`CodeProduit`,`IDActe`,`IDTypeCommande`,`DateCommande`,`IDUtilisateur`),
  KEY `CodePatient` (`CodePatient`),
  KEY `IDService` (`IDService`),
  KEY `IDUtilisateur` (`IDUtilisateur`),
  KEY `IDPraticien` (`IDPraticien`),
  KEY `CodeProduit` (`CodeProduit`),
  KEY `IDActe` (`IDActe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `commande`
--

INSERT INTO `commande` (`CodeCommande`, `CodePatient`, `CodeProduit`, `IDActe`, `QuantiteCommande`, `Montant`, `Remise`, `PourcentageRemise`, `MontantRemise`, `DateCommande`, `HeureCommande`, `DateRemise`, `HeureRemise`, `DateRegler`, `heureRegler`, `EtatCommande`, `IDPraticien`, `IDTypeCommande`, `IDUtilisateur`, `IDService`, `DateModifCommande`) VALUES
('COM1PAT00AB10U120181020', 'PAT00AB102018', '', 'CONS1', 1, 500, NULL, 0, 0, '20/10/2018', '08:08:43', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB10U120181020', 'PAT00AB102018', '', 'RADIO1', 1, 12000, NULL, 0, 0, '20/10/2018', '08:08:43', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB10U120181020', 'PAT00AB102018', '', 'RADIO2', 2, 25000, NULL, 0, 0, '20/10/2018', '08:08:43', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB10U120181205', 'PAT00AB102018', '', 'CONS2', 2, 4000, NULL, 0, 0, '5/12/2018', '12:23:11', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB10U120181205', 'PAT00AB102018', '', 'MAT2', 2, 5000, NULL, 0, 0, '5/12/2018', '12:23:11', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB10U120181205', 'PAT00AB102018', '', 'MORG1', 1, 10500, NULL, 0, 0, '5/12/2018', '12:23:11', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB14U120181020', 'PAT00AB142018', '', 'MAT3', 2, 5000, NULL, 0, 0, '20/10/2018', '08:14:54', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB14U120181020', 'PAT00AB142018', '', 'RADIO1', 1, 12000, NULL, 0, 0, '20/10/2018', '08:14:54', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB17U120181123', 'PAT00AB172018', '', 'CONS1', 1, 500, NULL, 0, 0, '23/11/2018', '03:09:20', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB17U120181123', 'PAT00AB172018', '', 'CONS2', 1, 2000, NULL, 0, 0, '23/11/2018', '03:09:20', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB17U120181123', 'PAT00AB172018', '', 'RADIO3', 1, 10500, NULL, 0, 0, '23/11/2018', '03:09:20', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB1U120181018', 'PAT00AB12018', '', 'CONS1', 1, 500, NULL, 0, 0, '18/10/2018', '22:54:42', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB1U120181018', 'PAT00AB12018', '', 'RADIO1', 2, 24000, NULL, 0, 0, '18/10/2018', '22:54:42', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB1U120181018', 'PAT00AB12018', '', 'RADIO3', 1, 10500, NULL, 0, 0, '18/10/2018', '22:54:42', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB25U120181020', 'PAT00AB252018', '', 'CONS1', 1, 500, NULL, 0, 0, '20/10/2018', '08:38:37', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB25U120181020', 'PAT00AB252018', '', 'MAT1', 1, 2000, NULL, 0, 0, '20/10/2018', '08:38:37', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB25U120181020', 'PAT00AB252018', '', 'MAT2', 3, 7500, NULL, 0, 0, '20/10/2018', '08:38:37', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB25U120181020', 'PAT00AB252018', '', 'MORG2', 1, 6500, NULL, 0, 0, '20/10/2018', '08:38:37', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB25U120181108', 'PAT00AB252018', '', 'CONS1', 1, 500, NULL, 0, 0, '8/11/2018', '00:10:34', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB25U120181108', 'PAT00AB252018', '', 'RADIO2', 1, 12500, NULL, 0, 0, '8/11/2018', '00:10:34', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB26U120181121', 'PAT00AB262018', '', 'CONS1', 2, 1000, NULL, 0, 0, '21/11/2018', '14:37:38', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB26U120181121', 'PAT00AB262018', '', 'MORG1', 2, 21000, NULL, 0, 0, '21/11/2018', '14:37:38', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181107', 'PAT00AB22018', '', 'CONS1', 1, 500, NULL, 0, 0, '7/11/2018', '21:22:53', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181107', 'PAT00AB22018', '', 'CONS2', 1, 2000, NULL, 0, 0, '7/11/2018', '21:22:53', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181107', 'PAT00AB22018', '', 'MAT1', 1, 2000, NULL, 0, 0, '7/11/2018', '21:22:53', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181107', 'PAT00AB22018', '', 'MAT3', 1, 2500, NULL, 0, 0, '7/11/2018', '21:22:53', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181205', 'PAT00AB22018', '', 'MAT2', 1, 2500, NULL, 0, 0, '5/12/2018', '12:18:36', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181205', 'PAT00AB22018', '', 'MAT3', 1, 2500, NULL, 0, 0, '5/12/2018', '12:18:36', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL),
('COM1PAT00AB2U120181205', 'PAT00AB22018', '', 'RADIO1', 1, 12000, NULL, 0, 0, '5/12/2018', '12:18:36', '0000-00-00', '00:00:00', NULL, NULL, NULL, 0, 0, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `commande_temp`
--

DROP TABLE IF EXISTS `commande_temp`;
CREATE TABLE IF NOT EXISTS `commande_temp` (
  `IDUtilisateur` int(11) NOT NULL DEFAULT '0',
  `CodePatient` varchar(50) NOT NULL DEFAULT '',
  `IDActe` varchar(10) NOT NULL DEFAULT '',
  `Qte` int(11) DEFAULT NULL,
  `Montant` int(11) DEFAULT NULL,
  `Remise` float NOT NULL,
  PRIMARY KEY (`CodePatient`,`IDActe`,`IDUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `domaine`
--

DROP TABLE IF EXISTS `domaine`;
CREATE TABLE IF NOT EXISTS `domaine` (
  `IDDomaine` int(11) NOT NULL AUTO_INCREMENT,
  `NomDomaine` varchar(100) NOT NULL,
  `Initiale` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`IDDomaine`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `domaine`
--

INSERT INTO `domaine` (`IDDomaine`, `NomDomaine`, `Initiale`) VALUES
(1, 'CONSULTATION', 'CONS'),
(2, 'MATERNITE', 'MAT'),
(3, 'RADIOLOGIE', 'RADIO'),
(4, 'CHIRUGIE', 'CHIRG'),
(5, 'MEDICO TECHNIQUE', 'MEDT'),
(6, 'LABORATOIRE', 'LABO'),
(7, 'MORGUE', 'MORG'),
(8, 'OPHTAMOLOGIE', 'OPH'),
(9, 'KINESITHERAPIE', 'KINE'),
(10, 'ORL', 'ORL'),
(11, 'GASTRONOMIE', 'GAST'),
(12, 'PLANNING FAMILLIAL', 'PLAN'),
(13, 'DOCUMENT', 'DOC'),
(14, 'URGENCES', 'URGE'),
(15, 'HOSPITALISATION', 'HOSP'),
(16, 'PEDIATRIE', 'PED');

-- --------------------------------------------------------

--
-- Structure de la table `ethnie`
--

DROP TABLE IF EXISTS `ethnie`;
CREATE TABLE IF NOT EXISTS `ethnie` (
  `NomEthnie` varchar(100) NOT NULL,
  PRIMARY KEY (`NomEthnie`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `ethnie`
--

INSERT INTO `ethnie` (`NomEthnie`) VALUES
('BAFANG'),
('BANDJOUN'),
('BULU'),
('DSCHANG'),
('ETONE'),
('SAGMELIMA');

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

DROP TABLE IF EXISTS `facture`;
CREATE TABLE IF NOT EXISTS `facture` (
  `CodeCommande` varchar(100) NOT NULL,
  `NetAPayer` int(11) DEFAULT NULL,
  `DateFacture` varchar(10) DEFAULT NULL,
  `HeureFacture` time DEFAULT NULL,
  KEY `CodeCommande` (`CodeCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `facture`
--

INSERT INTO `facture` (`CodeCommande`, `NetAPayer`, `DateFacture`, `HeureFacture`) VALUES
('COM1PAT00AB1U120181018', 35000, '18/10/2018', '22:54:42'),
('COM1PAT00AB10U120181020', 37500, '20/10/2018', '08:08:43'),
('COM1PAT00AB14U120181020', 17000, '20/10/2018', '08:14:54'),
('COM1PAT00AB25U120181020', 16500, '20/10/2018', '08:38:37'),
('COM1PAT00AB2U120181107', 7000, '7/11/2018', '21:22:53'),
('COM1PAT00AB25U120181108', 13000, '8/11/2018', '00:10:35'),
('COM1PAT00AB26U120181121', 22000, '21/11/2018', '14:37:38'),
('COM1PAT00AB17U120181123', 13000, '23/11/2018', '03:09:20'),
('COM1PAT00AB2U120181205', 17000, '5/12/2018', '12:18:36'),
('COM1PAT00AB10U120181205', 19500, '5/12/2018', '12:23:12');

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `IDMenu` int(11) NOT NULL AUTO_INCREMENT,
  `NomMenu` varchar(100) NOT NULL,
  `LienMenu` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`IDMenu`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `menu`
--

INSERT INTO `menu` (`IDMenu`, `NomMenu`, `LienMenu`) VALUES
(1, 'ACCEUIL', NULL),
(2, 'PATIENTS', NULL),
(3, 'ACTES MEDICAUX', NULL),
(4, 'MEDECINS', NULL),
(5, 'DOMAINES', NULL),
(6, 'FACTURATION', NULL),
(7, 'PREFACTURATION', NULL),
(8, 'REMISE', NULL),
(9, 'RECETTE JOURNALIERE', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `module`
--

DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `IDModule` int(11) NOT NULL AUTO_INCREMENT,
  `NomModule` varchar(100) NOT NULL,
  PRIMARY KEY (`IDModule`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `module`
--

INSERT INTO `module` (`IDModule`, `NomModule`) VALUES
(1, 'FACTURATION'),
(2, 'HOSPITALISATION'),
(3, 'COMPTABILITE'),
(4, 'ASSURANCE'),
(5, 'PHARMACIE'),
(6, 'LABORATOIRE'),
(7, 'MORGUE'),
(8, 'STATISTIQUES'),
(9, 'PARAMETRES');

-- --------------------------------------------------------

--
-- Structure de la table `nationalite`
--

DROP TABLE IF EXISTS `nationalite`;
CREATE TABLE IF NOT EXISTS `nationalite` (
  `NomNationalite` varchar(100) NOT NULL,
  PRIMARY KEY (`NomNationalite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `nationalite`
--

INSERT INTO `nationalite` (`NomNationalite`) VALUES
('CAMEROUNAISE'),
('EEDDDFDFG'),
('IVOIRIENNE'),
('OUGANDAISE');

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `CodePatient` varchar(50) NOT NULL,
  `NomPatient` varchar(50) NOT NULL,
  `PrenomPatient` varchar(50) DEFAULT NULL,
  `DateNaissance` varchar(10) DEFAULT NULL,
  `LieuNaissance` varchar(100) DEFAULT NULL,
  `SexePatient` varchar(1) DEFAULT NULL,
  `NiveauScolaire` varchar(100) DEFAULT NULL,
  `NomReligion` varchar(100) DEFAULT NULL,
  `NomEthnie` varchar(100) DEFAULT NULL,
  `NomProfession` varchar(100) DEFAULT NULL,
  `SituationMatrimoniale` varchar(60) DEFAULT NULL,
  `AdressePatient` varchar(60) DEFAULT NULL,
  `TelephonePatient` varchar(50) DEFAULT NULL,
  `EmailPatient` varchar(100) DEFAULT NULL,
  `NomNationalite` varchar(100) DEFAULT NULL,
  `NomPays` varchar(100) DEFAULT NULL,
  `NomQuartier` varchar(100) DEFAULT NULL,
  `NomVille` varchar(100) DEFAULT NULL,
  `DateDeces` datetime DEFAULT NULL,
  `HeureDeces` varchar(10) NOT NULL,
  `LieuDeces` varchar(150) DEFAULT NULL,
  `NomPersAPrevenir` varchar(50) DEFAULT NULL,
  `TelPersAPrevenir` varchar(50) DEFAULT NULL,
  `DateEnregistrer` varchar(10) NOT NULL,
  `HeureEnregistrer` time NOT NULL,
  `NomPere` varchar(150) DEFAULT NULL,
  `NomMere` varchar(150) DEFAULT NULL,
  `IDTypePatient` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodePatient`,`DateEnregistrer`,`HeureEnregistrer`),
  KEY `IDTypePatient` (`IDTypePatient`),
  KEY `NomNationalite` (`NomNationalite`),
  KEY `NomPays` (`NomPays`),
  KEY `NomVille` (`NomVille`),
  KEY `NomReligion` (`NomReligion`),
  KEY `NomEthnie` (`NomEthnie`),
  KEY `NomProfession` (`NomProfession`),
  KEY `NomQuartier` (`NomQuartier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `patient`
--

INSERT INTO `patient` (`CodePatient`, `NomPatient`, `PrenomPatient`, `DateNaissance`, `LieuNaissance`, `SexePatient`, `NiveauScolaire`, `NomReligion`, `NomEthnie`, `NomProfession`, `SituationMatrimoniale`, `AdressePatient`, `TelephonePatient`, `EmailPatient`, `NomNationalite`, `NomPays`, `NomQuartier`, `NomVille`, `DateDeces`, `HeureDeces`, `LieuDeces`, `NomPersAPrevenir`, `TelPersAPrevenir`, `DateEnregistrer`, `HeureEnregistrer`, `NomPere`, `NomMere`, `IDTypePatient`) VALUES
('PAT00AB12018', 'SIMO NTAMDEM', 'JOEL', '10/11/2010', 'NGAROUNDERE', 'M', 'Aucun', 'CATHOLIQUE', 'BANDJOUN', 'EMISSAIRE', 'Célibataire', 'z', '691894015', 'joelepalle19@gmail.com', 'CAMEROUNAISE', 'CAMEROUN', 'NDOG-PASSI II', 'EBOLOWA', '0000-00-00 00:00:00', 'null', '', 'THEODORE ', '671153120', '', '00:00:00', 'NTAMDEM THOMAS', 'MOTSEBO LUCIENNE', 1),
('PAT00AB22018', 'WHEKAZE', 'VALERIE', 'null', 'DOUALA', 'F', 'Aucun', 'CATHOLIQUE', 'BANDJOUN', 'MECANICIEN(NE)', 'Aucune', 'z', 'z', 'z', '', '', '', '', '0000-00-00 00:00:00', 'null', '', '', '', '', '00:00:00', '', '', 1),
('PAT00AB32018', 'ASHU', 'JAY', '30/02/2000', '', 'M', 'Aucun', 'PRESBITERIENNE', 'DSCHANG', 'NOTAIRE', 'Aucune', 'z', 'z', 'z', '', '', '', '', '0000-00-00 00:00:00', 'null', '', '', '', '', '00:00:00', 'AUCUNE', '', 1),
('PAT00AB52018', 'SAMO', 'MICHAEL', '2018-05-26', 'DOUALA', 'M', 'Aucun', 'Aucune', 'BAFANG', 'PARACHUTISTE', 'Marié(e)', NULL, '', '', 'CAMEROUNAISE', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB102018', 'ETOUNDI', 'BRICE', 'null', '', 'M', 'Aucun', 'CATHOLIQUE', 'BANDJOUN', 'AVOCAT', 'Célibataire', 'z', 'z', 'null', 'CAMEROUNAISE', '', '', '', '0000-00-00 00:00:00', 'null', '', '', 'AUCUNE', '', '00:00:00', '', '', 1),
('PAT00AB62018', 'EYENGA', 'BERTE', '', 'Aucun', 'M', 'Aucun', 'Aucune', 'Aucune', 'Aucune', 'Aucune', NULL, '', '', 'Aucune', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB42018', 'MEGA', 'LAURE', '1995-10-25', 'YAOUNDE', 'F', 'Aucun', 'CATHOLIQUE', 'BANDJOUN', 'PARACHUTISTE', 'Marié(e)', NULL, '', '', 'CAMEROUNAISE', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB92018', 'MOTUO', 'CHANCELLE', '2018-09-16', 'DOUALA', 'F', 'Aucun', 'CATHOLIQUE', 'BAFOUSSAM', 'NOTAIRE', 'Marié(e)', NULL, '', '', 'CAMEROUNAISE', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB302018', 'EMATCHA DAMENI', 'STEVE', '', 'Aucun', 'M', 'Aucun', 'PROTESTANT', 'BAFANG', 'NOTAIRE', 'Célibataire', NULL, '', '', 'CAMEROUNAISE', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB82018', 'ADAMOU', 'CLEOLLE', '2018-09-12', 'Aucun', 'M', 'Aucun', 'PRESBITERIEN', 'BANDJOUN', 'POLICIER', 'Veu(f)(ve)', NULL, '', '', 'Aucune', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB122018', 'NOUMSI NTAMDEM', 'VIVIANE', '1992-02-13', 'DOUALA', 'F', 'Aucun', 'CATHOLIQUE', 'BANDJOUN', 'SECRETAIRE', 'Célibataire', NULL, '698928545', '', 'CANADIENNE', 'CAMEROUN', 'PK-8', 'DOUALA', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB132018', 'SIKATI', 'NADINE', '2018-09-20', 'DOUALA', 'F', 'Aucun', 'Aucune', 'Aucune', 'COMMERCANTE(E)', 'Aucune', NULL, '', '', 'Aucune', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB142018', 'MAYAP', 'KEVINE', '1990-06-13', 'DOUALA', 'M', 'Aucun', 'MUSULMANE', 'BANDJOUN', 'ETUDIANTE(E)', 'Célibataire', NULL, '', '', 'CAMEROUNAISE', 'CAMEROUN', 'PK-8', 'DOUALA', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB152018', 'LATALE YEMATEU', 'JEAN PIERRE', '1995-11-12', 'DOUALA', 'M', 'Aucun', 'MUSULMANE', 'DSCHANG', 'POLICIER', 'Marié(e)', NULL, '+237697841258', '', 'MALIENNE', 'CAMEROUN', 'AKWA', 'DAKAR', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB162018', 'MAKOUGANG FEGA', 'ROYALE', '1996-03-21', 'DOUALA', 'F', 'Aucun', 'Aucune', 'BOUDA', 'SECRETAIRE', 'Célibataire', NULL, '', '', 'Aucune', 'CAMEROUN', 'PK-8', 'YAOUNDE', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB172018', 'TAKAM', 'RAISSA', '1997-06-01', 'DOUALA', 'F', 'Aucun', 'CATHOLIQUE', 'BAFANG', 'ETUDIANTE(E)', 'Célibataire', NULL, '', '', 'CAMEROUNAISE', 'Aucun', 'Aucun', 'Aucune', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB182018', 'TAMO WATO', 'HERMAN', '1992-02-11', 'DAKAR', 'M', 'Aucun', 'TEMOINS DE JEOVAH', 'DSCHANG', 'ELECTRICIEN', 'Marié(e)', NULL, '', '', 'GHANNEENE', 'CAMEROUN', 'DEIDO', 'DOUALA', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB192018', 'EMANA JEAN KALVIN', 'BRINSTON', '1990-10-22', 'Aucune', 'M', 'Aucun', 'MUSULMANE', 'Aucune', 'DIRECTEUR ECOLE PRIMAIRE', 'Aucune', NULL, '', '', 'MAROCAINE', 'CAMEROUN', 'PONT-YAIKO 2', 'MAROUA', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB202018', 'PIERRE MASSOMA', 'GERARD', '1983-10-22', 'DOUALA', 'M', 'Aucun', 'PRESBITERIEN', 'BULU', 'COMMERCANTE(E)', 'Divorcé(e)', NULL, '', '', 'GABONAISE', 'CAMEROUN', 'AKWA', 'YAOUNDE', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB002018', 'FOMAT', 'JOSPIN', '1999-04-12', 'KRIBI', 'M', 'Aucun', 'Aucune', 'BANDJOUN', 'COMMERCANTE(E)', 'Aucune', NULL, '698457841', '', 'CAMEROUNAISE', 'CAMEROUN', 'NYALLA-KAMPO', 'DOUALA', NULL, '00:00:00', NULL, '', '', '', '00:00:00', '', '', 1),
('PAT00AB212018', 'DJUIDJE MOTSEBO', 'NICAISE LETICIA', '1996-12-23', 'DOUALA', 'F', 'Aucun', 'CATHOLIQUE', 'BANDJOUN', 'ETUDIANTE(E)', 'Marié(e)', NULL, '', '', 'CAMEROUNAISE', 'Aucun', 'AKWA', 'ACRA', NULL, '00:00:00', NULL, '', '', '2018-10-01', '23:14:12', '', '', 1),
('PAT00AB242018', 'BEALADE KOROSANGO', 'SAMUEL', '1994-10-12', 'BERTOUA', 'M', 'Aucun', 'CATHOLIQUE', 'MALEKE', 'ETUDIANTE(E)', 'Aucune', NULL, '', '', 'Non Définie', 'CAMEROUN', 'PK-8', 'DOUALA', '0000-00-00 00:00:00', '', '', '', '', '2018-10-04', '22:59:41', '', '', 1),
('PAT00AB232018', 'OYONGO BITOLO', 'SAMUEL', '1999-10-01', 'BUEA', 'M', 'Aucun', 'CATHOLIQUE', 'EWONDO', 'FOOTBALLEUR', 'Aucune', NULL, '', '', 'CAMEROUNAISE', 'CAMEROUN', 'DEIDO', 'MAROUA', '0000-00-00 00:00:00', '', '', '', '', '2018-10-04', '22:56:23', '', '', 1),
('PAT00AB222018', 'JEAN NORR', 'ETOUN', '2018-10-23', '', 'M', 'Aucun', 'Non Définie', 'Non Définie', 'Non Définie', 'Aucune', NULL, '', '', 'Non Définie', 'Non Définie', 'Non Définie', 'Non Définie', '2018-10-18 00:00:00', '23:02', 'BEPANDA MOUSOKE', '', '', '2018-10-04', '22:48:18', '', '', 1),
('PAT00AB252018', 'TCHOKONTE DJALEU', 'BERTRAND IVAN', '1990-10-22', 'YAOUNDE', 'M', 'Aucun', 'CATHOLIQUE', 'DSCHANG', 'MEDECIN', 'Célibataire', NULL, '6985215412', 'micheldorado@gmail.com', 'IVOIRIENNE', 'CAMEROUN', 'DEIDO', 'DOUALA', '0000-00-00 00:00:00', '', '', '', '', '2018-10-20', '08:37:47', '', '', 1),
('PAT00AB262018', 'BROLI', 'ETOO', '', 'Non Définie', 'M', 'Aucun', 'Non Définie', 'Non Définie', 'Non Définie', 'Aucune', NULL, '', '', 'Non Définie', 'Non Définie', 'Non Définie', 'Non Définie', '0000-00-00 00:00:00', '', '', '', '', '2018-11-21', '14:32:45', '', '', 1),
('PAT00T1292018', 'DERTE', '', 'null', 'Non Définie', 'M', 'Aucun', 'Non Définie', 'Non Définie', 'Non Définie', 'Aucune', NULL, '', '', 'Non Définie', 'Non Définie', 'Non Définie', 'Non Définie', '0000-00-00 00:00:00', 'null', '', '', '', '2018-12-29', '21:24:32', '', '', 1),
('PAT00T1302018', 'ZENABOU', 'KIEDI', '12/11/1985', 'BERTOUA', 'F', 'Aucun', 'MUSULMANE', 'BULU', 'ETUDIANT(E)', 'Aucune', 'z', 'z', 'null', '', '', 'Non Définie', 'Non Définie', '0000-00-00 00:00:00', 'null', '', 'NON DÉFINIE', 'NON DÉFINIE', '2018-12-29', '21:25:23', '', '', 1),
('PAT00T1312018', 'SSSS', '', '25/12/1998', 'Non Définie', 'M', 'Aucun', 'Non Définie', 'Non Définie', 'Non Définie', 'Aucune', 'z', 'null', '', '', 'Non Définie', 'Non Définie', 'Non Définie', '0000-00-00 00:00:00', 'null', '', 'NON DÉFINIE', '', '2018-12-29', '21:27:05', '', '', 1),
('PAT00T1272018', 'KAMTO', 'MAURICE', 'null', 'BERTOUA', 'M', 'Aucun', 'CATHOLIQUE', 'Non Définie', 'MEDECIN', 'Célibataire', NULL, '', '', 'Non Définie', 'Non Définie', 'Non Définie', 'Non Définie', '0000-00-00 00:00:00', 'null', '', '', '', '2018-12-29', '16:12:22', '', '', 1),
('PAT00T1282018', 'LOL', '', 'null', 'Non Définie', 'M', 'Aucun', 'Non Définie', 'Non Définie', 'Non Définie', 'Aucune', NULL, '', '', 'Non Définie', 'Non Définie', 'Non Définie', 'Non Définie', '0000-00-00 00:00:00', 'null', '', '', '', '2018-12-29', '21:23:20', '', '', 1);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `NomPays` varchar(100) NOT NULL,
  PRIMARY KEY (`NomPays`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `pays`
--

INSERT INTO `pays` (`NomPays`) VALUES
('CAMEROUN'),
('CHINE'),
('CONGO'),
('GUINNEE EQUATORIALE'),
('JAPON'),
('RDC'),
('TCHAD');

-- --------------------------------------------------------

--
-- Structure de la table `profession`
--

DROP TABLE IF EXISTS `profession`;
CREATE TABLE IF NOT EXISTS `profession` (
  `NomProfession` varchar(100) NOT NULL,
  PRIMARY KEY (`NomProfession`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `profession`
--

INSERT INTO `profession` (`NomProfession`) VALUES
('AVOCAT'),
('BASKETEUR'),
('COMMERCANT(E)'),
('CYCLISTE'),
('ELEVE'),
('EMISSAIRE'),
('ENSEIGNANT(E)'),
('ETUDIANT(E)'),
('MACHINISTE'),
('MECANICIEN(NE)'),
('MEDECIN'),
('NOTAIRE'),
('PECHEUR'),
('PROTESTANTE');

-- --------------------------------------------------------

--
-- Structure de la table `quartier`
--

DROP TABLE IF EXISTS `quartier`;
CREATE TABLE IF NOT EXISTS `quartier` (
  `NomQuartier` varchar(100) NOT NULL,
  PRIMARY KEY (`NomQuartier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `quartier`
--

INSERT INTO `quartier` (`NomQuartier`) VALUES
('CICACAO'),
('DEIDO'),
('NDOG-PASSI I'),
('NDOG-PASSI II'),
('NDOG-PASSI III'),
('NGODI-BAKOKO'),
('PK-8'),
('SABLE'),
('SOA'),
('YASSA');

-- --------------------------------------------------------

--
-- Structure de la table `recu`
--

DROP TABLE IF EXISTS `recu`;
CREATE TABLE IF NOT EXISTS `recu` (
  `CodeRecu` varchar(100) NOT NULL,
  `CodeCommande` varchar(100) DEFAULT NULL,
  `MontantRecu` int(11) DEFAULT NULL,
  `FraisLivraison` int(11) DEFAULT NULL,
  `ResteAPayer` int(11) DEFAULT NULL,
  `Acompte` int(11) DEFAULT NULL,
  `Assurance` int(11) DEFAULT NULL,
  `IDMode` int(11) DEFAULT NULL,
  `DateRecu` varchar(10) DEFAULT NULL,
  `HeureRecu` time DEFAULT NULL,
  `IDTypeReglement` int(11) DEFAULT NULL,
  PRIMARY KEY (`CodeRecu`),
  KEY `IDTypeReglement` (`IDTypeReglement`),
  KEY `IDMode` (`IDMode`),
  KEY `CodeCommande` (`CodeCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `recu`
--

INSERT INTO `recu` (`CodeRecu`, `CodeCommande`, `MontantRecu`, `FraisLivraison`, `ResteAPayer`, `Acompte`, `Assurance`, `IDMode`, `DateRecu`, `HeureRecu`, `IDTypeReglement`) VALUES
('FAC1REG00P10U120181020', 'COM1PAT00AB10U120181020', 37500, 0, 0, 0, 0, 1, '20/10/2018', '08:08:43', 1),
('FAC1REG00P10U120181205', 'COM1PAT00AB10U120181205', 19500, 0, 0, 0, 0, 1, '5/12/2018', '12:23:12', 1),
('FAC1REG00P14U120181020', 'COM1PAT00AB14U120181020', 17000, 0, 0, 0, 0, 1, '20/10/2018', '08:14:54', 1),
('FAC1REG00P17U120181123', 'COM1PAT00AB17U120181123', 13000, 0, 0, 0, 0, 1, '23/11/2018', '03:09:20', 1),
('FAC1REG00P1U120181018', 'COM1PAT00AB1U120181018', 35000, 0, 0, 0, 0, 1, '18/10/2018', '22:54:42', 1),
('FAC1REG00P25U120181020', 'COM1PAT00AB25U120181020', 16500, 0, 0, 0, 0, 1, '20/10/2018', '08:38:37', 1),
('FAC1REG00P25U120181108', 'COM1PAT00AB25U120181108', 13000, 0, 0, 0, 0, 1, '8/11/2018', '00:10:35', 1),
('FAC1REG00P26U120181121', 'COM1PAT00AB26U120181121', 22000, 0, 0, 0, 0, 1, '21/11/2018', '14:37:38', 1),
('FAC1REG00P2U120181107', 'COM1PAT00AB2U120181107', 7000, 0, 0, 0, 0, 1, '7/11/2018', '21:22:53', 1),
('FAC1REG00P2U120181205', 'COM1PAT00AB2U120181205', 17000, 0, 0, 0, 0, 1, '5/12/2018', '12:18:36', 1);

-- --------------------------------------------------------

--
-- Structure de la table `religion`
--

DROP TABLE IF EXISTS `religion`;
CREATE TABLE IF NOT EXISTS `religion` (
  `NomReligion` varchar(100) NOT NULL,
  PRIMARY KEY (`NomReligion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `religion`
--

INSERT INTO `religion` (`NomReligion`) VALUES
('CATHOLIQUE'),
('MUSULMANE'),
('PRESBITERIENNE'),
('PROTESTANTE');

-- --------------------------------------------------------

--
-- Structure de la table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `IDService` int(11) NOT NULL AUTO_INCREMENT,
  `NomService` varchar(100) NOT NULL,
  PRIMARY KEY (`IDService`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Contenu de la table `service`
--

INSERT INTO `service` (`IDService`, `NomService`) VALUES
(1, 'BLOC OPERATOIRE'),
(2, 'CARDIOLOGIE'),
(3, 'CHIRURGIE'),
(4, 'CONSULTATION EXTERNE'),
(5, 'CONSULTATION PRENATALE'),
(6, 'GASTROLOGIE'),
(7, 'GYNECOLOGIE'),
(8, 'KINESITHERAPIE'),
(9, 'LABORATOIRE'),
(10, 'MATERNITE'),
(11, 'MEDECINE'),
(12, 'MORGUE'),
(13, 'OPHTALMOLOGIE'),
(14, 'ORL'),
(15, 'PEDIATRIE'),
(16, 'PHARMACIE'),
(17, 'PLANING FAMILIALE'),
(18, 'RADIOLOGIE'),
(19, 'STOMATOLOGIE'),
(20, 'UPEC'),
(21, 'URGENCE');

-- --------------------------------------------------------

--
-- Structure de la table `sous_menu`
--

DROP TABLE IF EXISTS `sous_menu`;
CREATE TABLE IF NOT EXISTS `sous_menu` (
  `IDSousMenu` int(11) NOT NULL AUTO_INCREMENT,
  `NomSousMenu` varchar(100) NOT NULL,
  `LienSousMenu` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`IDSousMenu`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `sous_menu`
--

INSERT INTO `sous_menu` (`IDSousMenu`, `NomSousMenu`, `LienSousMenu`) VALUES
(1, 'AUCUN', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `typepatient`
--

DROP TABLE IF EXISTS `typepatient`;
CREATE TABLE IF NOT EXISTS `typepatient` (
  `IDTypePatient` int(11) NOT NULL AUTO_INCREMENT,
  `NomTypePatient` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IDTypePatient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `type_commande`
--

DROP TABLE IF EXISTS `type_commande`;
CREATE TABLE IF NOT EXISTS `type_commande` (
  `IDTypeCommande` int(11) NOT NULL AUTO_INCREMENT,
  `NomTypeCommande` varchar(60) NOT NULL,
  PRIMARY KEY (`IDTypeCommande`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `IDUtilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `NomUtilisateur` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IDUtilisateur`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`IDUtilisateur`, `NomUtilisateur`) VALUES
(1, 'SIMO JOEL'),
(2, 'THEODOR ZTIET'),
(3, 'MICHELTENGA');

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

DROP TABLE IF EXISTS `ville`;
CREATE TABLE IF NOT EXISTS `ville` (
  `NomVille` varchar(100) NOT NULL,
  PRIMARY KEY (`NomVille`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `ville`
--

INSERT INTO `ville` (`NomVille`) VALUES
('ACRA'),
('BERTOUA'),
('BUEA'),
('DOUALA'),
('EBOLOWA'),
('EDEA'),
('MELONG'),
('NGAROUNDERE'),
('PARIS'),
('YAMOUSSOUKROU'),
('YAOUNDE');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `appartenance_menu_sous_menu`
--
ALTER TABLE `appartenance_menu_sous_menu`
  ADD CONSTRAINT `appartenance_menu_sous_menu_ibfk_1` FOREIGN KEY (`IDMenu`) REFERENCES `menu` (`IDMenu`),
  ADD CONSTRAINT `appartenance_menu_sous_menu_ibfk_2` FOREIGN KEY (`IDSousMenu`) REFERENCES `sous_menu` (`IDSousMenu`);

--
-- Contraintes pour la table `appartenance_module_menu`
--
ALTER TABLE `appartenance_module_menu`
  ADD CONSTRAINT `appartenance_module_menu_ibfk_1` FOREIGN KEY (`IDMenu`) REFERENCES `menu` (`IDMenu`),
  ADD CONSTRAINT `appartenance_module_menu_ibfk_2` FOREIGN KEY (`IDModule`) REFERENCES `module` (`IDModule`);

--
-- Contraintes pour la table `attribution_acces`
--
ALTER TABLE `attribution_acces`
  ADD CONSTRAINT `attribution_acces_ibfk_1` FOREIGN KEY (`IDModule`) REFERENCES `module` (`IDModule`),
  ADD CONSTRAINT `attribution_acces_ibfk_2` FOREIGN KEY (`IDMenu`) REFERENCES `menu` (`IDMenu`),
  ADD CONSTRAINT `attribution_acces_ibfk_3` FOREIGN KEY (`IDSousMenu`) REFERENCES `sous_menu` (`IDSousMenu`),
  ADD CONSTRAINT `attribution_acces_ibfk_4` FOREIGN KEY (`IDUtilisateur`) REFERENCES `utilisateur` (`IDUtilisateur`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

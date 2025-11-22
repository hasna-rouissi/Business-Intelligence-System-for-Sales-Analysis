-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ComptoirED
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ComptoirED
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ComptoirED` DEFAULT CHARACTER SET utf8 ;
USE `ComptoirED` ;

-- -----------------------------------------------------
-- Table `ComptoirED`.`DimClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComptoirED`.`DimClient` (
  `codeClient` VARCHAR(5) NOT NULL,
  `societe` VARCHAR(40) NULL,
  `contact` VARCHAR(30) NULL,
  `fonction` VARCHAR(30) NULL,
  `adresse` VARCHAR(60) NULL,
  `ville` VARCHAR(15) NULL,
  `region` VARCHAR(15) NULL,
  `codePostal` VARCHAR(10) NULL,
  `pays` VARCHAR(15) NULL,
  `telephone` VARCHAR(24) NULL,
  `fax` VARCHAR(24) NULL,
  PRIMARY KEY (`codeClient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComptoirED`.`DimTemps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComptoirED`.`DimTemps` (
  `DateID` DATETIME NOT NULL,
  `dateCommande` DATETIME NULL,
  `jours` VARCHAR(10) NULL,
  `mois` VARCHAR(10) NULL,
  `annees` VARCHAR(10) NULL,
  PRIMARY KEY (`DateID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComptoirED`.`DimProduits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComptoirED`.`DimProduits` (
  `refProduit` VARCHAR(4) NOT NULL,
  `nomProduit` VARCHAR(40) NULL,
  `unitesEnstock` INT NULL,
  `unitesCommandee` INT NULL,
  `niveauDreappro` INT NULL,
  `indisponible` TINYINT NULL,
  `qunatiteParUnite` VARCHAR(30) NULL,
  `categorie` VARCHAR(45) NULL,
  PRIMARY KEY (`refProduit`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComptoirED`.`FaitVentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComptoirED`.`FaitVentes` (
  `idVentes` VARCHAR(5) NOT NULL,
  `quantite` INT(11) NULL,
  `montant_total` DECIMAL(10,2) NULL,
  `DimTemps_DateID` DATETIME NOT NULL,
  `DimProduits_refProduit` VARCHAR(4) NOT NULL,
  `DimClient_codeClient` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idVentes`),
  INDEX `fk_FaitVentes_DimTemps1_idx` (`DimTemps_DateID` ASC) VISIBLE,
  INDEX `fk_FaitVentes_DimProduits1_idx` (`DimProduits_refProduit` ASC) VISIBLE,
  INDEX `fk_FaitVentes_DimClient1_idx` (`DimClient_codeClient` ASC) VISIBLE,
  CONSTRAINT `fk_FaitVentes_DimTemps1`
    FOREIGN KEY (`DimTemps_DateID`)
    REFERENCES `ComptoirED`.`DimTemps` (`DateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FaitVentes_DimProduits1`
    FOREIGN KEY (`DimProduits_refProduit`)
    REFERENCES `ComptoirED`.`DimProduits` (`refProduit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FaitVentes_DimClient1`
    FOREIGN KEY (`DimClient_codeClient`)
    REFERENCES `ComptoirED`.`DimClient` (`codeClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE `specify_import`;

/*
DROP TABLE IF EXISTS `exp_dorsa_accession`;
DROP TABLE IF EXISTS `exp_dorsa_accessionagent`;
DROP TABLE IF EXISTS `exp_dorsa_collectionobject`;
DROP TABLE IF EXISTS `exp_dorsa_collector`;
DROP TABLE IF EXISTS `exp_dorsa_determination`;
DROP TABLE IF EXISTS `exp_dorsa_preparation`;
DROP TABLE IF EXISTS `exp_dorsa_preparationattribute`;
*/


/******************************************************************************/
/* tables                                                                     */
/******************************************************************************/

CREATE TABLE IF NOT EXISTS `exp_dorsa_accession`
(
  `key`                 VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `AccessionNumber`     VARCHAR(60),
  `Type`                VARCHAR(32),
  `DateReceived`        DATE,
  `VerbatimDate`        VARCHAR(50),
  `Text3`               TEXT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_accession_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_dorsa_accession_01 UNIQUE (`specifycollcode`, `AccessionNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_accession` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_dorsa_accessionagent`
(
  `key`                 VARCHAR(128),
  `accessionkey`        VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `FirstName`           VARCHAR(50),
  `LastName`            VARCHAR(120),
  `Role`                VARCHAR(50),
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_accessionagent_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_accessionagent` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_dorsa_collectionobject`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `CatalogNumber`               VARCHAR(32),
  `CatalogerFirstName`          VARCHAR(50),
  `CatalogerLastName`           VARCHAR(120),
  `CatalogedDate`               DATE,

  `Availability`                VARCHAR(32),
  `Description`                 VARCHAR(255),
  `Visibility`                  TINYINT,
  `Remarks`                     TEXT,

  `CollEventContinent`          VARCHAR(64),
  `CollEventCountry`            VARCHAR(64),
  `CollEventState`              VARCHAR(64),
  `CollEventLocalityName`       VARCHAR(255),
  `CollEventStartDate`          DATE,
  `CollEventEndDate`            DATE,
  `CollEventDMSLatitude1`       VARCHAR(50),
  `CollEventDMSLongitude1`      VARCHAR(50),
  `CollEventMinElevationMeters` DOUBLE,
  `CollEventMaxElevationMeters` DOUBLE,
  `CollEventRemarks`            TEXT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_collectionobject_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_dorsa_collectionobject_01 UNIQUE (`specifycollcode`, `CatalogNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_collectionobject` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_dorsa_collector`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `OrderNumber`         INT,
  `FirstName`           VARCHAR(50),
  `LastName`            VARCHAR(120),
  `IsPrimary`           BIT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_collector_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_collector` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_dorsa_determination`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Kingdom`             VARCHAR(64),
  `Phylum`              VARCHAR(64),
  `Class`               VARCHAR(64),
  `Order`               VARCHAR(64),
  `Suborder`            VARCHAR(64),
  `Superfamily`         VARCHAR(64),
  `Family`              VARCHAR(64),
  `Subfamily`           VARCHAR(64),
  `Tribe`               VARCHAR(64),
  `Genus`               VARCHAR(64),
  `Subgenus`            VARCHAR(64),
  `Species`             VARCHAR(64),
  `Subspecies`          VARCHAR(64),
  `SpeciesAuthor`       VARCHAR(128),
  `SubspeciesAuthor`    VARCHAR(128),

  `Addendum`            VARCHAR(16),
  `Qualifier`           VARCHAR(16),
  `SubSpQualifier`      VARCHAR(16),
  `VarQualifier`        VARCHAR(16),
  `TypeStatusName`      VARCHAR(50),
  `DeterminerFirstName` VARCHAR(50),
  `DeterminerLastName`  VARCHAR(120),
  `DeterminedYear`      INT,
  `IsCurrent`           BIT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_determination_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_determination` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_dorsa_preparation`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Count`               INT,
  `PrepType`            VARCHAR(64),
  `StorageBuilding`     VARCHAR(64),
  `StorageCollection`   VARCHAR(64),
  `StorageRoom`         VARCHAR(64),
  `StorageCabinet`      VARCHAR(64),
  `StorageShelf`        VARCHAR(64),
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_preparation_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_preparation` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_dorsa_preparationattribute`
(
  `key`                 VARCHAR(128),
  `preparationkey`      VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Text8`               VARCHAR(50),
  `Text9`               VARCHAR(50),

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_dorsa_preparationattribute_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_dorsa_preparationattribute` TO `mfn-sql-1`@`%`;


/******************************************************************************/
/* stored procedures                                                          */
/******************************************************************************/

-- import procedure for Orthoptera from DORSA project

DROP PROCEDURE IF EXISTS `import_ZMB_Orth_Dorsa`;

DELIMITER GO

CREATE PROCEDURE `import_ZMB_Orth_Dorsa`($reccount INT)
BEGIN
  INSERT 
    INTO `t_imp_collectionobject` 
         (
           `key`,
           `specifycollcode`,

           `CatalogNumber`,
           `CatalogerFirstName`,
           `CatalogerLastName`,
           `CatalogedDate`,

           `Availability`,
           `Description`,
           `Visibility`,
           `Remarks`,

           `CollEventContinent`,
           `CollEventCountry`,
           `CollEventState`,
           `CollEventLocalityName`,
           `CollEventStartDate`,
           `CollEventEndDate`,
           `CollEventDMSLatitude1`,
           `CollEventDMSLongitude1`,
           `CollEventMinElevationMeters`,
           `CollEventMaxElevationMeters`,
           `CollEventRemarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `specifycollcode`,

                `CatalogNumber`,
                `CatalogerFirstName`,
                `CatalogerLastName`,
                `CatalogedDate`,

                `Availability`,
                `Description`,
                `Visibility`,
                `Remarks`,

                `CollEventContinent`,
                `CollEventCountry`,
                `CollEventState`,
                `CollEventLocalityName`,
                `CollEventStartDate`,
                `CollEventEndDate`,
                `CollEventDMSLatitude1`,
                `CollEventDMSLongitude1`,
                `CollEventMinElevationMeters`,
                `CollEventMaxElevationMeters`,
                `CollEventRemarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_dorsa_collectionobject`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collectionobject`))
          LIMIT 0, $reccount;

  INSERT 
    INTO `t_imp_accession` 
         (
           `key`,
           `specifycollcode`,

           `AccessionNumber`,
           `Type`,
           `DateReceived`,
           `VerbatimDate`,
           `Text3`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`, 
                `specifycollcode`,

                `AccessionNumber`,
                `Type`,
                `DateReceived`,
                `VerbatimDate`,
                `Text3`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_dorsa_accession`
          WHERE (`AccessionNumber` IN (SELECT `AccessionNumber`
                                         FROM `t_imp_collectionobject`
                                        WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_accession`));

  INSERT 
    INTO `t_imp_accessionagent` 
         (
           `key`,
           `accessionkey`,
           `specifycollcode`,

           `FirstName`,
           `LastName`,
           `Role`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`, 
                `accessionkey`,
                `specifycollcode`,

                `FirstName`,
                `LastName`,
                `Role`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_dorsa_accessionagent`
          WHERE (`accessionkey` IN (SELECT `key`
                                      FROM `t_imp_accession`
                                     WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_accessionagent`));

  INSERT 
    INTO `t_imp_collector` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `OrderNumber`,
           `FirstName`,
           `LastName`,
           `IsPrimary`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `collectionobjectkey`,
                `specifycollcode`,

                `OrderNumber`,
                `FirstName`,
                `LastName`,
                `IsPrimary`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_dorsa_collector`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collector`));
       
  INSERT 
    INTO `t_imp_determination` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `Kingdom`,
           `Phylum`,
           `Class`,
           `Order`,
           `Suborder`,
           `Superfamily`,
           `Family`,
           `Subfamily`,
           `Tribe`,
           `Genus`,
           `Subgenus`,
           `Species`,
           `Subspecies`,
           `SpeciesAuthor`,
           `SubspeciesAuthor`,

           `Addendum`,
           `Qualifier`,
           `SubSpQualifier`,
           `VarQualifier`,
           `TypeStatusName`,
           `DeterminerFirstName`,
           `DeterminerLastName`,
           `DeterminedYear`,
           `IsCurrent`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `collectionobjectkey`,
                `specifycollcode`,

                `Kingdom`,
                `Phylum`,
                `Class`,
                `Order`,
                `Suborder`,
                `Superfamily`,
                `Family`,
                `Subfamily`,
                `Tribe`,
                `Genus`,
                `Subgenus`,
                `Species`,
                `Subspecies`,
                `SpeciesAuthor`,
                `SubspeciesAuthor`,

                `Addendum`,
                `Qualifier`,
                `SubSpQualifier`,
                `VarQualifier`,
                `TypeStatusName`,
                `DeterminerFirstName`,
                `DeterminerLastName`,
                `DeterminedYear`,
                `IsCurrent`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_dorsa_determination`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_determination`));

  INSERT 
    INTO `t_imp_preparation` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `Count`,
           `StorageBuilding`,
           `StorageCollection`,
           `StorageRoom`,
           `StorageCabinet`,
           `StorageShelf`,
           `PrepType`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `collectionobjectkey`,
                `specifycollcode`,

                `Count`,
                `StorageBuilding`,
                `StorageCollection`,
                `StorageRoom`,
                `StorageCabinet`,
                `StorageShelf`,
                `PrepType`,
		        `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_dorsa_preparation`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_preparation`));

  INSERT 
    INTO `t_imp_preparationattribute` 
         (
           `key`,
           `preparationkey`,
           `collectionobjectkey`,
           `specifycollcode`,

           `Text8`,
           `Text9`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `preparationkey`,
                `collectionobjectkey`,
                `specifycollcode`,

                `Text8`,
                `Text9`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_dorsa_preparationattribute`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_preparationattribute`));


  CALL `p_Import`;
END;

GO

DELIMITER ;

-- Phasmatodea (unfinished, partially obsolete)

USE `specify_import`;

/*
DROP TABLE IF EXISTS `exp_phasm_collectionobject`;
DROP TABLE IF EXISTS `exp_phasm_collector`;
DROP TABLE IF EXISTS `exp_phasm_determination`;
DROP TABLE IF EXISTS `exp_phasm_preparation`;
DROP TABLE IF EXISTS `exp_phasm_collobjattr_phasmatodea`;
DROP TABLE IF EXISTS `exp_phasm_containerrel`;
*/


/******************************************************************************/
/* views                                                                      */
/******************************************************************************/

CREATE OR REPLACE VIEW `v_imp_collobjattr_mfnphasmatodea`
AS
   SELECT `key`,
          `collectionobjectkey`,
          `specifycollcode`,

          `Text8`  AS `Sex`,
          `Text7`  AS `Age`,
          `YesNo1` AS `Breed`,
          `Remarks`, 

          `TimestampCreated`,
          `CreatedByFirstName`,
          `CreatedByLastName`,
          `TimestampModified`,
          `ModifiedByFirstName`,
          `ModifiedByLastName`,

          `_CollectionID`,
          `_CollectionObjectID`,
          `_CollectionObjectAttributeID`,
          `_Age`,
          `_BiologicalSex`,
          `_CreatedByAgentID`,
          `_ModifiedByAgentID`,

          `_importguid`,
          `_hasdata`,
          `_error`,
          `_errormsg`,
          `_imported`

     FROM `t_imp_collectionobjectattribute`
    WHERE (`specifycollcode` = 'ZMB_Phasm');


/******************************************************************************/
/* tables                                                                     */
/******************************************************************************/

CREATE TABLE IF NOT EXISTS `exp_phasm_collectionobject`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `CatalogNumber`               VARCHAR(32),
  `CatalogerFirstName`          VARCHAR(50),
  `CatalogerLastName`           VARCHAR(120),
  `CatalogedDate`               DATE,

  `AccessionNumber`             VARCHAR(60),
  `AccessionType`               VARCHAR(32),

  `Availability`                VARCHAR(32),
  `Description`                 VARCHAR(255),
  `Remarks`                     TEXT,

  `CollEventContinent`          VARCHAR(64),
  `CollEventCountry`            VARCHAR(64),
  -- `CollEventState`              VARCHAR(64),
  -- `CollEventCounty`             VARCHAR(64),
  `CollEventLocalityName`       VARCHAR(255),
  `CollEventStartDate`          DATE,
  `CollEventStartMonth`         INT,
  `CollEventStartYear`          INT,
  `CollEventEndDate`            DATE,
  `CollEventEndMonth`           INT,
  `CollEventEndYear`            INT,
  `CollEventVerbatimDate`       VARCHAR(50),
  `CollEventMinElevationMeters` DOUBLE,
  `CollEventMaxElevationMeters` DOUBLE,
  `CollEventRemarks`            TEXT,

  `Visibility`                  TINYINT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_phasm_collectionobject_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_phasm_collectionobject_01 UNIQUE (`specifycollcode`, `CatalogNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_phasm_collectionobject` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_phasm_collector`
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

  CONSTRAINT pk_exp_phasm_collector_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_phasm_collector` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_phasm_determination`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Kingdom`             VARCHAR(64),
  `Phylum`              VARCHAR(64),
  `Class`               VARCHAR(64),
  `Order`               VARCHAR(64),
  `Suborder`            VARCHAR(64),
  `Infraorder`          VARCHAR(64),
  `Family`              VARCHAR(64),
  `Subfamily`           VARCHAR(64),
  `Tribe`               VARCHAR(64),
  `Genus`               VARCHAR(64),
  `Subgenus`            VARCHAR(64),
  `Species`             VARCHAR(64),
  `Subspecies`          VARCHAR(64),
  `Variation`           VARCHAR(64),
  `Qualifier`           VARCHAR(16),
  `SpeciesAuthor`       VARCHAR(128),
  `SubspeciesAuthor`    VARCHAR(128),
  `VariationAuthor`     VARCHAR(128),

  `TypeStatusName`      VARCHAR(50),
  `IsCurrent`           BIT,
  `DeterminedDate`      DATE,
  `DeterminedMonth`     INT,
  `DeterminedYear`      INT,
  `DeterminerFirstName` VARCHAR(50),
  `DeterminerLastName`  VARCHAR(120),
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_phasm_determination_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_phasm_determination` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_phasm_preparation`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Count`               INT,
  `PrepType`            VARCHAR(64),

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_phasm_preparation_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_phasm_preparation` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_phasm_collobjattr_phasmatodea`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Sex`                 VARCHAR(50),
  `Age`                 VARCHAR(50),
  `Breed`               BIT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_phasm_collobjattr_phasmatodea_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_phasm_collobjattr_phasmatodea` TO `mfn-sql-1`@`%`;


/******************************************************************************/
/* stored procedures                                                          */
/******************************************************************************/

-- import procedure for Phasmatodea

DROP PROCEDURE IF EXISTS `import_ZMB_Phasm`;

DELIMITER GO

CREATE PROCEDURE `import_ZMB_Phasm`($reccount INT)
BEGIN
  INSERT 
    INTO `t_imp_collectionobject` 
         (
           `key`,
           `specifycollcode`,

           `CatalogNumber`,
           `CatalogerLastName`,
           `CatalogerFirstName`,
           `CatalogedDate`,

           `AccessionNumber`,
           `AccessionType`,

           `Availability`,
           `Description`,
           `Remarks`,

           `CollEventContinent`,
           `CollEventCountry`,
           -- `CollEventState`,
           -- `CollEventCounty`,
           `CollEventLocalityName`,
           `CollEventMinElevationMeters`,
           `CollEventMaxElevationMeters`,
           `CollEventStartDate`,
           `CollEventStartMonth`,
           `CollEventStartYear`,
           `CollEventEndDate`,
           `CollEventEndMonth`,
           `CollEventEndYear`,
           `CollEventVerbatimDate`,
           `CollEventRemarks`,

           `Visibility`,

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
                `CatalogerLastName`,
                `CatalogerFirstName`,
                `CatalogedDate`,

                `AccessionNumber`,
                `AccessionType`,

                `Availability`,
                `Description`,
                `Remarks`,

                `CollEventContinent`,
                `CollEventCountry`,
                -- `CollEventState`,
                -- `CollEventCounty`,
                `CollEventLocalityName`,
                `CollEventMinElevationMeters`,
                `CollEventMaxElevationMeters`,
                `CollEventStartDate`,
                `CollEventStartMonth`,
                `CollEventStartYear`,
                `CollEventEndDate`,
                `CollEventEndMonth`,
                `CollEventEndYear`,
                `CollEventVerbatimDate`,
                `CollEventRemarks`,

                `Visibility`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_phasm_collectionobject`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collectionobject`))
          LIMIT 0, $reccount;

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
           FROM `specify_import`.`exp_phasm_collector`
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
           `Infraorder`,
           `Family`,
           `Subfamily`,
           `Tribe`,
           `Genus`,
           `Subgenus`,
           `Species`,
           `Subspecies`,
           `Variation`,
           `Qualifier`,
           `SpeciesAuthor`,
           `SubspeciesAuthor`,
           `VariationAuthor`,

           `TypeStatusName`,
           `IsCurrent`,
           `DeterminedDate`,
           `DeterminedMonth`,
           `DeterminedYear`,
           `DeterminerFirstName`,
           `DeterminerLastName`,
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
                `Infraorder`,
                `Family`,
                `Subfamily`,
                `Tribe`,
                `Genus`,
                `Subgenus`,
                `Species`,
                `Subspecies`,
                `Variation`,
                `Qualifier`,
                `SpeciesAuthor`,
                `SubspeciesAuthor`,
                `VariationAuthor`,

                `TypeStatusName`,
                `IsCurrent`,
                `DeterminedDate`,
                `DeterminedMonth`,
                `DeterminedYear`,
                `DeterminerFirstName`,
                `DeterminerLastName`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_phasm_determination`
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
           `PrepType`,

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
                `PrepType`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_phasm_preparation`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_preparation`));

  INSERT 
    INTO `v_imp_collobjattr_mfnphasmatodea` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,
  
           `Sex`,
           `Age`,
           `Breed`,
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

                `Sex`,
                `Age`,
                `Breed`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_phasm_collobjattr_phasmatodea`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `v_imp_collobjattr_mfnphasmatodea`));

  CALL `p_Import`;
END;

GO

DELIMITER ;
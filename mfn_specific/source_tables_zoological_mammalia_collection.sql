USE `specify_import`;

/*
DROP TABLE IF EXISTS `exp_mammalia_accession`;
DROP TABLE IF EXISTS `exp_mammalia_accessionagent`;
DROP TABLE IF EXISTS `exp_mammalia_collectionobject`;
DROP TABLE IF EXISTS `exp_mammalia_otheridentifier`;
DROP TABLE IF EXISTS `exp_mammalia_collector`;
DROP TABLE IF EXISTS `exp_mammalia_determination`;
DROP TABLE IF EXISTS `exp_mammalia_preparation`;
DROP TABLE IF EXISTS `exp_mammalia_collobjattr_mammals`;
*/


/******************************************************************************/
/* views                                                                      */
/******************************************************************************/

CREATE OR REPLACE VIEW `v_imp_collobjattr_mfnmammalia`
AS
   SELECT `key`,
          `collectionobjectkey`,
          `specifycollcode`,

          `text8` AS `Sex`,
          `text7` AS `Age`,
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
    WHERE (`specifycollcode` = 'ZMB_Mam');


/******************************************************************************/
/* tables                                                                     */
/******************************************************************************/

CREATE TABLE IF NOT EXISTS `exp_mammalia_accession`
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

  CONSTRAINT pk_exp_mammalia_accession_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_mammalia_accession_01 UNIQUE (`specifycollcode`, `AccessionNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_accession` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_accessionagent`
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

  CONSTRAINT pk_exp_mammalia_accessionagent_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_accessionagent` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_collectionobject`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `CatalogNumber`               VARCHAR(32),
  `CatalogerFirstName`          VARCHAR(50),
  `CatalogerLastName`           VARCHAR(120),
  `CatalogedDate`               DATE,

  `AccessionNumber`             VARCHAR(60),

  `Availability`                VARCHAR(32),
  `Description`                 VARCHAR(255),
  `Remarks`                     TEXT,
  `Visibility`                  TINYINT,

  `CollEventContinent`          VARCHAR(64),
  `CollEventCountry`            VARCHAR(64),
  `CollEventState`              VARCHAR(64),
  `CollEventCounty`             VARCHAR(64),
  `CollEventLocalityName`       VARCHAR(255),
  `CollEventStartDate`          DATE,
  `CollEventStartMonth`         INT,
  `CollEventStartYear`          INT,
  `CollEventEndDate`            DATE,
  `CollEventEndMonth`           INT,
  `CollEventEndYear`            INT,
  `CollEventVerbatimDate`       VARCHAR(50),
  `CollEventStationFieldNumber` VARCHAR(50),
  `CollEventVerbatimLocality`   TEXT,
  `CollEventRemarks`            TEXT,
  `CollEventDDLatitude1`        DECIMAL(12,10),
  `CollEventDDLongitude1`       DECIMAL(13,10),
  `CollEventLatLongMethod`      VARCHAR(50),

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_mammalia_collectionobject_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_mammalia_collectionobject_01 UNIQUE (`specifycollcode`, `CatalogNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_collectionobject` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_otheridentifier`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `identifier`          VARCHAR(64),
  `institution`         VARCHAR(64),
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_mammalia_otheridentifier_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_otheridentifier` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_collector`
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

  CONSTRAINT pk_exp_mammalia_collector_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_collector` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_determination`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Kingdom`             VARCHAR(64),
  `Phylum`              VARCHAR(64),
  `Class`               VARCHAR(64),
  `Order`               VARCHAR(64),
  `Family`              VARCHAR(64),
  `Genus`               VARCHAR(64),
  `Species`             VARCHAR(64),
  `Subspecies`          VARCHAR(64),
  `SpeciesAuthor`       VARCHAR(64),
  `SubspeciesAuthor`    VARCHAR(64),

  `Addendum`            VARCHAR(16),
  `Qualifier`           VARCHAR(16),
  `SubSpQualifier`      VARCHAR(16),
  `VarQualifier`        VARCHAR(16),
  `TypeStatusName`      VARCHAR(50),
  `DeterminedDate`      DATE,
  `DeterminedMonth`     INT,
  `DeterminedYear`      INT,
  `DeterminerFirstName` VARCHAR(50),
  `DeterminerLastName`  VARCHAR(120),
  `IsCurrent`           BIT,
  `Remarks`             TEXT,
  `Text1`               TEXT,
  `Text2`               TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_mammalia_determination_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_determination` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_preparation`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Description`         VARCHAR(255),
  `Count`               INT,
  `PrepType`            VARCHAR(64),
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_mammalia_preparation_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_preparation` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_mammalia_collobjattr_mammals`
(
  `key`                   VARCHAR(128),
  `collectionobjectkey`   VARCHAR(128),
  `specifycollcode`       VARCHAR(128),

  `Sex`                   VARCHAR(50),
  `Age`                   VARCHAR(50),
  `Remarks`               TEXT,

  `TimestampCreated`      DATETIME,
  `CreatedByFirstName`    VARCHAR(50),
  `CreatedByLastName`     VARCHAR(120),
  `TimestampModified`     DATETIME,
  `ModifiedByFirstName`   VARCHAR(50),
  `ModifiedByLastName`    VARCHAR(120),

  CONSTRAINT pk_exp_mammalia_collobjattr_mammals_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_mammalia_collobjattr_mammals` TO `mfn-sql-1`@`%`;


/******************************************************************************/
/* stored procedures                                                          */
/******************************************************************************/

-- import procedure for zoological mammalia collection

DROP PROCEDURE IF EXISTS `import_ZMB_Mam`;

DELIMITER GO

CREATE PROCEDURE `import_ZMB_Mam`($reccount INT)
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

           `AccessionNumber`,

           `Availability`,
           `Description`,
           `Remarks`,
           `Visibility`,
         
           `CollEventContinent`,
           `CollEventCountry`,
           `CollEventState`,
           `CollEventCounty`,
           `CollEventLocalityName`,
           `CollEventStartDate`,
           `CollEventStartMonth`,
           `CollEventStartYear`,
           `CollEventEndDate`,
           `CollEventEndMonth`,
           `CollEventEndYear`,
           `CollEventVerbatimDate`,
           `CollEventStationFieldNumber`,
           `CollEventVerbatimLocality`,
           `CollEventRemarks`,
           `CollEventDDLatitude1`,
           `CollEventDDLongitude1`,
           -- `CollEventLatLongMethod`,

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

                `AccessionNumber`,

                `Availability`,
                `Description`,
                `Remarks`,
                `Visibility`,
         
                `CollEventContinent`,
                `CollEventCountry`,
                `CollEventState`,
                `CollEventCounty`,
                `CollEventLocalityName`,
                `CollEventStartDate`,
                `CollEventStartMonth`,
                `CollEventStartYear`,
                `CollEventEndDate`,
                `CollEventEndMonth`,
                `CollEventEndYear`,
                `CollEventVerbatimDate`,
                `CollEventStationFieldNumber`,
                `CollEventVerbatimLocality`,
                `CollEventRemarks`,
                `CollEventDDLatitude1`,
                `CollEventDDLongitude1`,
                -- `CollEventLatLongMethod`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_mammalia_collectionobject`
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
           FROM `exp_mammalia_accession`
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
           FROM `exp_mammalia_accessionagent`
          WHERE (`accessionkey` IN (SELECT `key`
                                      FROM `t_imp_accession`
                                     WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_accessionagent`));

  INSERT 
    INTO `t_imp_otheridentifier` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `Identifier`,
           `Institution`,
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

                `Identifier`,
                `Institution`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_mammalia_otheridentifier`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_otheridentifier`));

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
           FROM `specify_import`.`exp_mammalia_collector`
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
           `Family`,
           `Genus`,
           `Species`,
           `Subspecies`,
           `SpeciesAuthor`,
           `SubspeciesAuthor`,

           `Addendum`,
           `Qualifier`,
           `SubSpQualifier`,
           `VarQualifier`,
           `TypeStatusName`,
           `DeterminedDate`,
           `DeterminedMonth`,
           `DeterminedYear`,
           `DeterminerFirstName`,
           `DeterminerLastName`,
           `IsCurrent`,
           `Remarks`,
           `Text1`,
           `Text2`,

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
                `Family`,
                `Genus`,
                `Species`,
                `Subspecies`,
                `SpeciesAuthor`,
                `SubspeciesAuthor`,

                `Addendum`,
                `Qualifier`,
                `SubSpQualifier`,
                `VarQualifier`,
                `TypeStatusName`,
                `DeterminedDate`,
                `DeterminedMonth`,
                `DeterminedYear`,
                `DeterminerFirstName`,
                `DeterminerLastName`,
                `IsCurrent`,
                `Remarks`,
                `Text1`,
                `Text2`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_mammalia_determination`
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

           `Description`,
           `Count`,
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

                `Description`,
                `Count`,
                `PrepType`,
		    `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_mammalia_preparation`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_preparation`));

  INSERT 
    INTO `v_imp_collobjattr_mfnmammalia`
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,
  
           `Sex`,
           `Age`,
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
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_mammalia_collobjattr_mammals`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `v_imp_collobjattr_mfnmammalia`));

  CALL `p_Import`;
END;

GO

DELIMITER ;
USE `specify_import`;

/*
DROP TABLE IF EXISTS `exp_embryo_collectionobject`;
DROP TABLE IF EXISTS `exp_embryo_otheridentifier`;
DROP TABLE IF EXISTS `exp_embryo_determination`;
DROP TABLE IF EXISTS `exp_embryo_preparation`;
DROP TABLE IF EXISTS `exp_embryo_preparationattribute`;
*/


/******************************************************************************/
/* tables                                                                     */
/******************************************************************************/

CREATE TABLE IF NOT EXISTS `exp_embryo_collectionobject`
(
  `key`                 VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `CatalogNumber`       VARCHAR(32),
  `CatalogerFirstName`  VARCHAR(50),
  `CatalogerLastName`   VARCHAR(120),
  `CatalogedDate`       DATE,

  `AccessionNumber`     VARCHAR(60),
  `AccessionType`       VARCHAR(32),

  `Availability`        VARCHAR(32),
  `Description`         VARCHAR(255),
  `Remarks`             TEXT,

  `Visibility`          TINYINT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_embryo_collectionobject_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_embryo_collectionobject_01 UNIQUE (`specifycollcode`, `CatalogNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_embryo_collectionobject` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_embryo_otheridentifier`
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

  CONSTRAINT pk_exp_embryo_otheridentifier_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_embryo_otheridentifier` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_embryo_determination`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Kingdom`             VARCHAR(64),
  `Phylum`              VARCHAR(64),
  `Subphylum`           VARCHAR(64),
  `Class`               VARCHAR(64),
  `Order`               VARCHAR(64),
  `Suborder`            VARCHAR(64),
  `Family`              VARCHAR(64),
  `Genus`               VARCHAR(64),
  `Subgenus`            VARCHAR(64),
  `Species`             VARCHAR(64),
  `Subspecies`          VARCHAR(64),
  `Variation`           VARCHAR(64),
  `SpeciesAuthor`       VARCHAR(128),
  `SubspeciesAuthor`    VARCHAR(128),
  `VariationAuthor`     VARCHAR(128),
  `Qualifier`           VARCHAR(16),
  `SubSpQualifier`      VARCHAR(16),

  `IsCurrent`           BIT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_embryo_determination_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_embryo_determination` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_embryo_preparation`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Description`         VARCHAR(255),
  `Count`               INT,
  `PrepType`            VARCHAR(64),
  `Remarks`             TEXT,

  `StorageBuilding`     VARCHAR(64),
  `StorageCollection`   VARCHAR(64),
  `StorageShelf`        VARCHAR(64),

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_embryo_preparation_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_embryo_preparation` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_embryo_preparationattribute`
(
  `key`                 VARCHAR(128),
  `preparationkey`      VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Text3`               VARCHAR(50),
  `Text4`               VARCHAR(50),
  `Text5`               VARCHAR(50),
  `Text6`               VARCHAR(50),

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_embryo_preparationattribute_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_embryo_preparationattribute` TO `mfn-sql-1`@`%`;


/******************************************************************************/
/* stored procedures                                                          */
/******************************************************************************/

-- import procedure for embryological collection

DROP PROCEDURE IF EXISTS `import_ZMB_Embryo`;

DELIMITER GO

GO

CREATE PROCEDURE `import_ZMB_Embryo`($reccount INT)
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

                `Visibility`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_embryo_collectionobject`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collectionobject`))
          LIMIT 0, $reccount;

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
           FROM `specify_import`.`exp_embryo_otheridentifier`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_otheridentifier`));

  INSERT 
    INTO `t_imp_determination` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `Kingdom`,
           `Phylum`,
           `Subphylum`,
           `Class`,
           `Order`,
           `Suborder`,
           `Family`,
           `Genus`,
           `Subgenus`,
           `Species`,
           `Subspecies`,
           `Variation`,
           `SpeciesAuthor`,
           `SubspeciesAuthor`,
           `VariationAuthor`,
           `Qualifier`,
           `SubspQualifier`,

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
                `Subphylum`,
                `Class`,
                `Order`,
                `Suborder`,
                `Family`,
                `Genus`,
                `Subgenus`,
                `Species`,
                `Subspecies`,
                `Variation`,
                `SpeciesAuthor`,
                `SubspeciesAuthor`,
                `VariationAuthor`,
                `Qualifier`,
                `SubspQualifier`,

                `IsCurrent`,
                `Remarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_embryo_determination`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`))
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

           `StorageBuilding`,
           `StorageCollection`,
           `StorageShelf`,

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

                `StorageBuilding`,
                `StorageCollection`,
                `StorageShelf`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_embryo_preparation`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_preparation`));

  INSERT 
    INTO `t_imp_preparationattribute` 
         (
           `key`,
           `preparationkey`,
           `collectionobjectkey`,
           `specifycollcode`,

           `Text3`,
           `Text4`,
           `Text5`,
           `Text6`,

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

                `Text3`,
                `Text4`,
                `Text5`,
                `Text6`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_embryo_preparationattribute`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`)) AND
                (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_preparationattribute`));

  CALL `p_Import`;
END;

GO


DELIMITER ;

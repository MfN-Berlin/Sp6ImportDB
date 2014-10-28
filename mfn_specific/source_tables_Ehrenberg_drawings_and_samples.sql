-- Ehrenberg drawings and samples

USE `specify_import`;

/*
DROP TABLE IF EXISTS `exp_ehrenbergdrawings_container`;
DROP TABLE IF EXISTS `exp_ehrenbergdrawings_collectionobject`;
DROP TABLE IF EXISTS `exp_ehrenbergdrawings_collectionobjectattribute`;
DROP TABLE IF EXISTS `exp_ehrenbergsamples_container`;
DROP TABLE IF EXISTS `exp_ehrenbergsamples_collectionobject`;
*/

/******************************************************************************/
/* tables                                                                     */
/******************************************************************************/

CREATE TABLE IF NOT EXISTS `exp_ehrenbergdrawings_container`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `Name`                        VARCHAR(64),
  `Type`                        VARCHAR(50),
  `Description`                 VARCHAR(255),
  `Number`                      INT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_ehrenbergdrawings_container_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_ehrenbergdrawings_container` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_ehrenbergdrawings_collectionobject`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `CatalogNumber`               VARCHAR(32),
  `CatalogerFirstName`          VARCHAR(50),
  `CatalogerLastName`           VARCHAR(120),
  `CatalogedDate`               DATE,

  `Availability`                VARCHAR(32),
  `Description`                 VARCHAR(255),
  `Remarks`                     TEXT,
  `Text1`                       TEXT,

  `OwnerOfContainer`            VARCHAR(64),
  `ChildOfContainer`            VARCHAR(64),

  `Visibility`                  TINYINT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_ehrenbergdrawings_collectionobject_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_ehrenbergdrawings_collectionobject_01 UNIQUE (`specifycollcode`, `CatalogNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_ehrenbergdrawings_collectionobject` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_ehrenbergdrawings_collectionobjectattribute`
(
  `key`                 VARCHAR(128),
  `collectionobjectkey` VARCHAR(128),
  `specifycollcode`     VARCHAR(128),

  `Text1`               TEXT,
  `Text2`               TEXT,
  `Text3`               TEXT,
  `YesNo1`              BIT,
  `YesNo2`              BIT,
  `Text4`               VARCHAR(50),
  `Text5`               VARCHAR(50),

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50),
  `CreatedByLastName`   VARCHAR(120),
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50),
  `ModifiedByLastName`  VARCHAR(120),

  CONSTRAINT pk_exp_ehrenbergdrawings_collectionobjectattribute_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_ehrenbergdrawings_collectionobjectattribute` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_ehrenbergsamples_container`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `Name`                        VARCHAR(64),
  `Type`                        VARCHAR(50),
  `Description`                 VARCHAR(255),
  `Number`                      INT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_ehrenbergsamples_container_01 PRIMARY KEY (`key`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_ehrenbergsamples_container` TO `mfn-sql-1`@`%`;


CREATE TABLE IF NOT EXISTS `exp_ehrenbergsamples_collectionobject`
(
  `key`                         VARCHAR(128),
  `specifycollcode`             VARCHAR(128),

  `CatalogNumber`               VARCHAR(32),
  `CatalogerFirstName`          VARCHAR(50),
  `CatalogerLastName`           VARCHAR(120),
  `CatalogedDate`               DATE,

  `Availability`                VARCHAR(32),
  `Description`                 VARCHAR(255),
  `Remarks`                     TEXT,
  `Text1`                       TEXT,

  `OwnerOfContainer`            VARCHAR(64),
  `ChildOfContainer`            VARCHAR(64),

  `CollEventContinent`          VARCHAR(64),
  `CollEventCountry`            VARCHAR(64),
  `CollEventState`              VARCHAR(64),
  `CollEventCounty`             VARCHAR(64),
  `CollEventLocalityName`       VARCHAR(255),

  `Visibility`                  TINYINT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50),
  `CreatedByLastName`           VARCHAR(120),
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50),
  `ModifiedByLastName`          VARCHAR(120),

  CONSTRAINT pk_exp_ehrenbergsamples_collectionobject_01 PRIMARY KEY (`key`),
  CONSTRAINT uq_exp_ehrenbergsamples_collectionobject_01 UNIQUE (`specifycollcode`, `CatalogNumber`)
) DEFAULT CHARSET=utf8;

GRANT INSERT, DELETE ON `exp_ehrenbergsamples_collectionobject` TO `mfn-sql-1`@`%`;


/******************************************************************************/
/* stored procedures                                                          */
/******************************************************************************/

--  import procedure for Ehrenberg drawings and samples

DROP PROCEDURE IF EXISTS `import_Ehrenberg`;

DELIMITER GO

CREATE PROCEDURE `import_Ehrenberg`($reccount INT)
BEGIN
  INSERT 
    INTO `t_imp_container` 
         (
           `key`,
           `specifycollcode`,

           `Name`,
           `Type`,
           `Description`,
           `Number`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `specifycollcode`,

                `Name`,
                `Type`,
                `Description`,
                `Number`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_ehrenbergsamples_container`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_container`));

  INSERT 
    INTO `t_imp_container`
         (
           `key`,
           `specifycollcode`,

           `Name`,
           `Type`,
           `Description`,
           `Number`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `key`,
                `specifycollcode`,

                `Name`,
                `Type`,
                `Description`,
                `Number`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_ehrenbergdrawings_container`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_container`));

  INSERT 
    INTO `t_imp_collectionobject` 
         (
           `key`,
           `specifycollcode`,

           `CatalogNumber`,
           `CatalogerLastName`,
           `CatalogerFirstName`,
           `CatalogedDate`,

           `Availability`,
           `Description`,
           `Remarks`,
           `Text1`,

           `OwnerOfContainer`,
           `ChildOfContainer`,
 
           `CollEventContinent`,
           `CollEventCountry`,
           `CollEventState`,
           `CollEventCounty`,
           `CollEventLocalityName`,

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

                `Availability`,
                `Description`,
                `Remarks`,
                `Text1`,

                `OwnerOfContainer`,
                `ChildOfContainer`,

                `CollEventContinent`,
                `CollEventCountry`,
                `CollEventState`,
                `CollEventCounty`,
                `CollEventLocalityName`,

                `Visibility`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_ehrenbergsamples_collectionobject`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collectionobject`))
          LIMIT 0, $reccount;

  INSERT 
    INTO `t_imp_collectionobject` 
         (
           `key`,
           `specifycollcode`,

           `CatalogNumber`,
           `CatalogerLastName`,
           `CatalogerFirstName`,
           `CatalogedDate`,

           `Availability`,
           `Description`,
           `Remarks`,
           `Text1`,

           `OwnerOfContainer`,
           `ChildOfContainer`,

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

                `Availability`,
                `Description`,
                `Remarks`,
                `Text1`,

                `OwnerOfContainer`,
                `ChildOfContainer`,

                `Visibility`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `exp_ehrenbergdrawings_collectionobject`
          WHERE (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collectionobject`))
          LIMIT 0, $reccount;

  INSERT 
    INTO `t_imp_collectionobjectattribute` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,
  
           `Text1`,
           `Text2`,
           `Text3`,
           `YesNo1`,
           `YesNo2`,
           `Text4`,
           `Text5`,

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

                `Text1`,
                `Text2`,
                `Text3`,
                `YesNo1`,
                `YesNo2`,
                `Text4`,
                `Text5`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `specify_import`.`exp_ehrenbergdrawings_collectionobjectattribute`
          WHERE (`collectionobjectkey` IN (SELECT `key`
                                             FROM `t_imp_collectionobject`
                                            WHERE (`_error` = 0)))
            AND (`key` NOT IN (SELECT `key`
                                 FROM `t_imp_collectionobjectattribute`));

  CALL `p_Import`;
END;

GO

DELIMITER ;


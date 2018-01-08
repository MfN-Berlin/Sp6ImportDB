/*************************************************************************************************/
/* Import taxonomy from catalogue of life structure in an empty collection of Specify 6          */
/*************************************************************************************************/

-- This script requires collection specific taxonomy. If you're using an institution wide taxonomy tree 
-- you might need to modify the function `f_getTaxonTreeDefID`

-- Replace all svar_destdb_ entries with the Specify destination database name 
-- in your text editor: e.g. svar_destdb_ -> specify.

DELIMITER GO

use `specify_import`;

GO

-- Table for the data to be imported.

-- DROP TABLE IF EXISTS `t_coltaxonimport`;

GO

-- t_coltaxonimport contains the taxonomic backbone that should be imported
-- Fill this table as you like after its creation.

CREATE TABLE IF NOT EXISTS `t_coltaxonimport`
(
  `id`                  INT          NOT NULL,
  `name`                VARCHAR(64)  NOT NULL,
  `rank`                VARCHAR(32)  NOT NULL,
  `name_status`         VARCHAR(64)  NOT NULL, -- "accepted name", "synonym"
  `parentid`            INT          NOT NULL,
  `validid`             INT          NOT NULL DEFAULT 0, -- <>0, if synonym
  `genus`               VARCHAR(64)  NULL DEFAULT '',
  `species`             VARCHAR(64)  NULL DEFAULT '',
  `infraspecies_marker` VARCHAR(64)  NULL DEFAULT '',
  `infraspecies`        VARCHAR(32)  NULL DEFAULT '',
  `author`              VARCHAR(128) NULL DEFAULT '',
  `additional_comments` TEXT         NULL,

  CONSTRAINT `pk_coltaxonimport_01` PRIMARY KEY (`id`),
  INDEX      `ix_coltaxonimport_01` (`parentid`, `name`),
  INDEX      `ix_coltaxonimport_02` (`genus`, `species`, `infraspecies`)

) DEFAULT CHARSET=utf8;

GO

-- functions

DROP FUNCTION IF EXISTS `f_getTaxonTreeDefID`;

GO

CREATE FUNCTION `f_getTaxonTreeDefID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT D.`TaxonTreeDefID`
            FROM svar_destdb_.`collection`            C
                 INNER JOIN svar_destdb_.`discipline` D ON (C.`DisciplineID` = D.`DisciplineID`)
           WHERE (C.`Code` = $collname));

GO

--

DROP FUNCTION IF EXISTS `f_getTaxonTreeDefItemID`;

GO

CREATE FUNCTION `f_getTaxonTreeDefItemID`($treedefid INT, $rankid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `TaxonTreeDefItemID`
            FROM svar_destdb_.`taxontreedefitem`
           WHERE (`TaxonTreeDefID` = $treedefid)
             AND (`RankID`         = $rankid));

GO
--

DROP FUNCTION IF EXISTS `f_getTaxonRootID`;

GO

CREATE FUNCTION `f_getTaxonRootID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `taxonid` 
            FROM svar_destdb_.`taxon` 
           WHERE (`TaxonTreeDefID` = `f_GetTaxonTreeDefID`($collname)) 
             AND (`ParentID`       IS NULL)
             AND (`Name`           = 'Life'));

GO

-- Import procedure

DROP PROCEDURE IF EXISTS `p_insertCOLTaxonomy`;

GO

-- $collname: name of the target collection. This collection must be generated before taxon import  
CREATE PROCEDURE `p_insertCOLTaxonomy`($collname VARCHAR(128))
BEGIN
  DECLARE $taxonrootid   INT;
  DECLARE $treedefid     INT;
  DECLARE $treedefitemid INT;

  -- New index for Specify field "taxon.Number1" that contains the cataloque of life id.

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name   = 'taxon')
                    AND (index_name   = 'ix_mfn_catalogueoflifeid'))) THEN
    CREATE INDEX ix_mfn_catalogueoflifeid ON `svar_destdb_`.`taxon` (`Number1`, `TaxonID`);
  END IF;

  SET $treedefid     = `f_getTaxonTreeDefID`($collname);
  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 10);
  SET $taxonrootid   = `f_getTaxonRootID`($collname);

  -- Kingdom

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 10, $taxonrootid, `name`, `name`, `author`, `name_status`, `id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport`
          WHERE (`rank`    = 'Kingdom')
            AND (`validid` = 0);

  -- Phyla

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 30);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 30, T2.`TaxonID`, T1.`name`, T1.`name`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Phylum')
            AND (T1.`validid`        = 0)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- Class

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 60);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 60, T2.`TaxonID`, T1.`name`, T1.`name`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Class')
            AND (T1.`validid`        = 0)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- Order

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 100);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 100, T2.`TaxonID`, T1.`name`, T1.`name`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Order')
            AND (T1.`validid`        = 0)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- Superfamily

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 130);

  IF ($treedefitemid IS NOT NULL) THEN
    INSERT
      INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                                 , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                                 , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                                 , `TimestampCreated`, `TimestampModified`
                                 , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
           SELECT 130, T2.`TaxonID`, T1.`name`, T1.`name`, T1.`author`, T1.`name_status`, T1.`id`, 1
                , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
             FROM `t_coltaxonimport` T1
                  INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
            WHERE (T1.`rank`           = 'Superfamily')
              AND (T1.`validid`        = 0)
              AND (T2.`TaxonTreeDefID` = $treedefid);
  END IF;

  -- Family

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 140);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 140, T2.`TaxonID`, T1.`name`, T1.`name`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Family')
            AND (T1.`validid`        = 0)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- Genus

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 180);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 180, T2.`TaxonID`, T1.`name`, T1.`name`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Genus')
            AND (T1.`validid`        = 0)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- valid species

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 220);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 220, T2.`TaxonID`, T1.`name`, T1.`species`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Species')
            AND (T1.`validid`        = 0)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- valid subspecies

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 230);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 230, T2.`TaxonID`, T1.`name`, T1.`infraspecies`, T1.`author`, T1.`name_status`, T1.`id`, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`parentid` = T2.`Number1`)
          WHERE (T1.`rank`           = 'Infraspecies')
            AND (T1.`validid`        = 0)
            AND (COALESCE(T1.`infraspecies_marker`, '') IN ('', 'subspecies'))
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- synonyms

  DROP TEMPORARY TABLE IF EXISTS `synonyms`;

  CREATE TEMPORARY TABLE `synonyms`
  (
    `itisid`     INT,
    `familyid`   INT,
    `rankid`     INT,
    `genus`      VARCHAR(64),
    `genusid`    INT,
    `species`    VARCHAR(64),
    `speciesid`  INT,
    `subspecies` VARCHAR(64),
    `parentid`   INT,

    PRIMARY KEY (`itisid`),
    INDEX (`familyid`),
    INDEX (`rankid`),
    INDEX (`parentid`),
    INDEX (`genus`),
    INDEX (`genusid`),
    INDEX (`species`),
    INDEX (`speciesid`)
  );
 
  -- species synonyms for species

  INSERT 
	INTO `synonyms`
         SELECT T1.`id`, T3.`ParentID`, 220, T1.`Genus`, NULL, T1.`Species`, NULL, '', NULL
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`validid`  = T2.`Number1`)
                INNER JOIN `svar_destdb_`.`taxon` T3 ON (T2.`ParentID` = T3.`TaxonID`)
          WHERE (T1.`rank`           = 'species')
            AND (T1.`validid`        > 0)
            AND (T2.`RankID`         = 220)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- species synonyms for subspecies

  INSERT 
	INTO `synonyms`
         SELECT T1.`id`, T4.`ParentID`, 220, T1.`Genus`, NULL, T1.`Species`, NULL, '', NULL
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`validid`  = T2.`Number1`)
                INNER JOIN `svar_destdb_`.`taxon` T3 ON (T2.`ParentID` = T3.`TaxonID`)
                INNER JOIN `svar_destdb_`.`taxon` T4 ON (T3.`ParentID` = T4.`TaxonID`)
          WHERE (T1.`rank`           = 'species')
            AND (T1.`validid`        > 0)
            AND (T2.`RankID`         = 230)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- subspecies synonyms for species

  INSERT 
	INTO `synonyms`
         SELECT T1.`id`, T3.`ParentID`, 230, T1.`Genus`, NULL, T1.`Species`, NULL, T1.`Infraspecies`, NULL
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`validid`  = T2.`Number1`)
                INNER JOIN `svar_destdb_`.`taxon` T3 ON (T2.`ParentID` = T3.`TaxonID`)
          WHERE (T1.`rank`           = 'Infraspecies') AND (COALESCE(T1.`infraspecies_marker`) IN ('', 'subspecies'))
            AND (T1.`validid`        > 0)
            AND (T2.`RankID`         = 220)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- subspecies synonyms for subspecies

  INSERT 
	INTO `synonyms`
         SELECT T1.`id`, T4.`ParentID`, 230, T1.`Genus`, NULL, T1.`Species`, NULL, T1.`Infraspecies`, NULL
           FROM `t_coltaxonimport` T1
                INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`validid`  = T2.`Number1`)
                INNER JOIN `svar_destdb_`.`taxon` T3 ON (T2.`ParentID` = T3.`TaxonID`)
                INNER JOIN `svar_destdb_`.`taxon` T4 ON (T3.`ParentID` = T4.`TaxonID`)
          WHERE (T1.`rank`           = 'Infraspecies') AND (COALESCE(T1.`infraspecies_marker`) IN ('', 'subspecies'))
            AND (T1.`validid`        > 0)
            AND (T2.`RankID`         = 230)
            AND (T2.`TaxonTreeDefID` = $treedefid);

  -- find existing genera parents

  UPDATE `synonyms` T1
		 INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`familyid` = T2.`ParentID`) AND (T1.`Genus` = T2.`Name`)
     SET T1.`genusid` = T2.`TaxonID`
   WHERE (T1.`RankID`         > 180)
     AND (T2.`RankID`         = 180)
	 AND (T2.`TaxonTreeDefID` = $treedefid);

  -- insert missing genera parents

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 180);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT DISTINCT
                180, `familyid`, `genus`, `genus`, '', 'created for species synonym', NULL, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `synonyms`
          WHERE (`genusid` IS NULL);

  -- find new genera parents

  UPDATE `synonyms` T1
		 INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`familyid` = T2.`ParentID`) AND (T1.`Genus` = T2.`Name`)
     SET T1.`genusid` = T2.`TaxonID`
   WHERE (T1.`rankid`         > 180)
     AND (T2.`RankID`         = 180)
	 AND (T2.`TaxonTreeDefID` = $treedefid)
     AND (T1.`genusid` IS NULL);

  -- find existing species parents

  UPDATE `synonyms` T1
		 INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`genusid` = T2.`ParentID`) AND (T1.`Species` = T2.`Name`)
     SET T1.`speciesid` = T2.`TaxonID`
   WHERE (T1.`rankid`         > 220)
     AND (T2.`RankID`         = 220)
     AND (T2.`TaxonTreeDefID` = $treedefid);
  
  -- insert missing species parents

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 220);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT DISTINCT
                220, `genusid`, CONCAT(`genus`, ' ', `species`), `species`, '', 'created for species synonym', NULL, 1
              , $treedefid, $treedefitemid, 1, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `synonyms`
          WHERE (`rankid` > 220)
		    AND (`speciesid` IS NULL);

  -- find new species parents

  UPDATE `synonyms` T1
		 INNER JOIN `svar_destdb_`.`taxon` T2 ON (T1.`genusid` = T2.`ParentID`) AND (T1.`Species` = T2.`Name`)
     SET T1.`speciesid` = T2.`TaxonID`
   WHERE (T1.`rankid`         > 220)
     AND (T2.`RankID`         = 220)
     AND (T2.`TaxonTreeDefID` = $treedefid)
     AND (T1.`speciesid` IS NULL);

  -- set parentid for all synonyms

  UPDATE `synonyms`
     SET `parentid` = COALESCE(`speciesid`, `genusid`, `familyid`);

  -- insert all species synonyms to specify

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `AcceptedID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 220, T1.`parentid`, T3.`TaxonID`, T2.`name`, T1.`species`, T2.`author`, T2.`name_status`, T2.`id`, 1
              , $treedefid, $treedefitemid, 0, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `synonyms` T1
                INNER JOIN `t_coltaxonimport` T2 ON (T1.`itisid` = T2.`id`)
                INNER JOIN `svar_destdb_`.`taxon` T3 ON (T2.`validid` = T3.`Number1`)
          WHERE (T1.`rankid`         = 220)
            AND (T3.`TaxonTreeDefID` = $treedefid);

  -- insert all subspecies synonyms to specify

  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, 230);

  INSERT
    INTO `svar_destdb_`.`taxon` (`RankID`, `ParentID`, `AcceptedID`, `FullName`, `Name`, `Author`
                               , `COLStatus`, `Number1`, `Version`, `TaxonTreeDefID`
                               , `TaxonTreeDefItemID`, `IsAccepted`, `IsHybrid`
                               , `TimestampCreated`, `TimestampModified`
                               , `CreatedByAgentID`, `ModifiedByAgentID`, `Source`)
         SELECT 230, T1.`parentid`, T3.`TaxonID`, T2.`name`, T1.`subspecies`, T2.`author`, T2.`name_status`, T2.`id`, 1
              , $treedefid, $treedefitemid, 0, 0, NOW(), NOW(), 1, 1, 'Catalogue of Life'
           FROM `synonyms` T1
                INNER JOIN `t_coltaxonimport` T2 ON (T1.`itisid` = T2.`id`)
                INNER JOIN `svar_destdb_`.`taxon` T3 ON (T2.`validid` = T3.`Number1`)
          WHERE (T1.`rankid`         = 230)
            AND (T3.`TaxonTreeDefID` = $treedefid);

     
  DROP TEMPORARY TABLE IF EXISTS `synonyms`;
END

GO

DELIMITER ;

-- example usage:
-- CALL `p_insertCOLTaxonomy`('ZMB_Orth');


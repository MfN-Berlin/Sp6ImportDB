/******************************************************************************/
/* Import database for Specify 6                                              */
/******************************************************************************/

-- Replace all svar_destdb_ entries with the Specify destination database name 
-- in your text editor: e.g. svar_destdb_ -> specify.

-- After the import you must rebuild all trees in Specify
-- [System] > [Trees] > [Update Xxx Tree].

DELIMITER GO

-- create specify import database

CREATE DATABASE IF NOT EXISTS `specify_import`;

GO

-- switch to import database

USE `specify_import`;

GO

/******************************************************************************/
/* tables                                                                     */
/******************************************************************************/

-- all agent fields use binary strings for case sensitive comparisons


-- accession

CREATE TABLE IF NOT EXISTS `t_imp_accession`
(
  `key`                 VARCHAR(128) NOT NULL,
  `specifycollcode`     VARCHAR(128) NOT NULL,

  `AccessionNumber`     VARCHAR(60),
  `Type`                VARCHAR(32),
  `DateReceived`        DATE,
  `VerbatimDate`        VARCHAR(50),
  `Number1`             FLOAT(20, 10),
  `Number2`             FLOAT(20, 10),
  `Text1`               TEXT,
  `Text2`               TEXT,
  `Text3`               TEXT,
  `YesNo1`              BIT,
  `YesNo2`              BIT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`   VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`  VARCHAR(120) CHARACTER SET binary,

  `_AccessionNumber`    VARCHAR(60),
  `_DivisionID`         INT,
  `_DisciplineID`       INT,
  `_CollectionID`       INT,
  `_AccessionID`        INT,
  `_CreatedByAgentID`   INT,
  `_ModifiedByAgentID`  INT,

  `_importguid`         VARCHAR(36),
  `_error`              BIT          DEFAULT 0,
  `_errormsg`           VARCHAR(255),
  `_imported`           BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_accession_01` PRIMARY KEY (`key`),
  KEY (`_AccessionNumber`),
  KEY (`_DisciplineID`, `_CollectionID`),
  KEY (`_AccessionID`),
  KEY (`_importguid`),
  KEY (`_CollectionID`, `AccessionNumber`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- accession agents

CREATE TABLE IF NOT EXISTS `t_imp_accessionagent`
(
  `key`                   VARCHAR(128) NOT NULL,
  `accessionkey`          VARCHAR(128) NOT NULL,
  `specifycollcode`       VARCHAR(128) NOT NULL,

  `FirstName`             VARCHAR(50)  CHARACTER SET binary,
  `LastName`              VARCHAR(120) CHARACTER SET binary,
  `Role`                  VARCHAR(50),
  `Remarks`               TEXT,
--  `RepositoryAgreementID` INT,

  `TimestampCreated`      DATETIME,
  `CreatedByFirstName`    VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`     VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`     DATETIME,
  `ModifiedByFirstName`   VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`    VARCHAR(120) CHARACTER SET binary,

--  `_DisciplineID`         INT,
  `_CollectionID`         INT,
  `_AccessionID`          INT,
  `_AccessionAgentID`     INT,
  `_AgentID`              INT,
  `_AccessionRole`        VARCHAR(50),
  `_CreatedByAgentID`     INT,
  `_ModifiedByAgentID`    INT,

  `_importguid`           VARCHAR(36),
  `_error`                BIT          DEFAULT 0,
  `_errormsg`             VARCHAR(255),
  `_imported`             BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_accessionagent_01` PRIMARY KEY (`key`),
  KEY (`accessionkey`),
  KEY (`_importguid`),
  KEY (`_AccessionID`, `_AgentID`, `Role`),
  KEY (`_CollectionID`, `LastName`, `FirstName`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- container

CREATE TABLE IF NOT EXISTS `t_imp_container`
(
  `key`                         VARCHAR(128) NOT NULL,
  `specifycollcode`             VARCHAR(128) NOT NULL,

  `Type`                        VARCHAR(64),
  `Name`                        VARCHAR(64)  NOT NULL,
  `Description`                 VARCHAR(255),
  `Number`                      INT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`           VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`          VARCHAR(120) CHARACTER SET binary,

  `_DisciplineID`               INT,
  `_CollectionID`               INT,
  `_ContainerID`                INT,
  `_ContainerTypeName`          VARCHAR(64),
  `_ContainerTypeID`            INT,
  `_CreatedByAgentID`           INT,
  `_ModifiedByAgentID`          INT,

  `_importguid`                 VARCHAR(36),
  `_error`                      BIT          DEFAULT 0,
  `_errormsg`                   VARCHAR(255),
  `_imported`                   BIT          DEFAULT 0,

  CONSTRAINT pk_imp_container_01 PRIMARY KEY (`key`),
  KEY (`Name`),
  KEY (`_importguid`),
  KEY (`_ContainerID`),
  KEY (`_ContainerTypeName`, `key`),
  KEY (`_ContainerID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_ContainerID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- collection object

CREATE TABLE IF NOT EXISTS `t_imp_collectionobject`
(
  `key`                         VARCHAR(128) NOT NULL,
  `specifycollcode`             VARCHAR(128) NOT NULL,

  `CatalogNumber`               VARCHAR(32)  NOT NULL,
  `AltCatalogNumber`            VARCHAR(32),
  `GUID`                        VARCHAR(128),
  `CatalogerFirstName`          VARCHAR(50)  CHARACTER SET binary,
  `CatalogerLastName`           VARCHAR(120) CHARACTER SET binary,
  `CatalogedDate`               DATE,
  `CatalogedMonth`              INT,
  `CatalogedYear`               INT,

  `AccessionNumber`             VARCHAR(60),

  `Description`                 VARCHAR(255),
  `Remarks`                     TEXT,
  `Availability`                VARCHAR(32),
  `Deaccessioned`               BIT,
  `CountAmt`                    INT,
  `Text1`                       TEXT,
  `Text2`                       TEXT,
  `Text3`                       TEXT,
  `Integer1`                    INT,
  `Integer2`                    INT,
  `Number1`                     FLOAT(20,10),
  `Number2`                     FLOAT(20,10),
  `YesNo1`                      BIT,
  `YesNo2`                      BIT,
  `YesNo3`                      BIT,
  `YesNo4`                      BIT,
  `YesNo5`                      BIT,
  `YesNo6`                      BIT,

  `OwnerOfContainer`            VARCHAR(64),
  `ChildOfContainer`            VARCHAR(64),

  `CollEventContinent`          VARCHAR(64),
  `CollEventCountry`            VARCHAR(64),
  `CollEventState`              VARCHAR(64),
  `CollEventCounty`             VARCHAR(64),
  `CollEventLocalityName`       VARCHAR(255),
  `CollEventLocalityRemarks`    TEXT,
  `CollEventLatLongType`        VARCHAR(50),
  `CollEventDMSLatitude1`       VARCHAR(50),
  `CollEventDDMLatitude1`       VARCHAR(50),
  `CollEventDDLatitude1`        DECIMAL(12,10),
  `CollEventDMSLongitude1`      VARCHAR(50),
  `CollEventDDMLongitude1`      VARCHAR(50),
  `CollEventDDLongitude1`       DECIMAL(13,10),
  `CollEventDMSLatitude2`       VARCHAR(50),
  `CollEventDDMLatitude2`       VARCHAR(50),
  `CollEventDDLatitude2`        DECIMAL(12,10),
  `CollEventDMSLongitude2`      VARCHAR(50),
  `CollEventDDMLongitude2`      VARCHAR(50),
  `CollEventDDLongitude2`       DECIMAL(13,10),
  `CollEventMinElevationMeters` DOUBLE,
  `CollEventMaxElevationMeters` DOUBLE,

  `CollEventStartDateVerbatim`  VARCHAR(50),
  `CollEventStartDate`          DATE,
  `CollEventStartMonth`         INT,
  `CollEventStartYear`          INT,
  `CollEventEndDateVerbatim`    VARCHAR(50),
  `CollEventEndDate`            DATE,
  `CollEventEndMonth`           INT,
  `CollEventEndYear`            INT,
  `CollEventVerbatimDate`       VARCHAR(50),
  `CollEventMethod`             VARCHAR(50),
  `CollEventStationFieldNumber` VARCHAR(50),
  `CollEventVerbatimLocality`   TEXT,
  `CollEventRemarks`            TEXT,

  `ChronosStratErathemEra`      VARCHAR(64),
  `ChronosStratSystemPeriod`    VARCHAR(64),
  `ChronosStratSeriesEpoch`     VARCHAR(64),
  `ChronosStratStageAge`        VARCHAR(64),
  `PalaeoContextRemarks`        TEXT,

  `Visibility`                  TINYINT, 

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`           VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`          VARCHAR(120) CHARACTER SET binary,

  `_DisciplineID`               INT,
  `_CollectionID`               INT,
  `_CollectionObjectID`         INT,
  `_AccessionID`                INT,
  `_OwnerOfContainerID`         INT,
  `_ChildOfContainerID`         INT,
  `_CollectingEventID`          INT,
  `_PaleoContextID`             INT,
  `_CatalogerID`                INT,
  `_CatalogedDate`              DATE,
  `_CatalogedDatePrecision`     INT          DEFAULT 1,
  `_CreatedByAgentID`           INT,
  `_ModifiedByAgentID`          INT,

  `_importguid`                 VARCHAR(36),
  `_error`                      BIT          DEFAULT 0,
  `_errormsg`                   VARCHAR(255),
  `_imported`                   BIT          DEFAULT 0,

  CONSTRAINT pk_imp_collectionobject_01 PRIMARY KEY (`key`),
  KEY (`CatalogNumber`),
  KEY (`_importguid`),
  KEY (`_CollectionObjectID`),
  KEY (`_CollectingEventID`),
  KEY (`_CollectionID`, `AccessionNumber`),
  KEY (`_CollectionID`, `CatalogerLastName`, `CatalogerFirstName`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- other identifiers

CREATE TABLE IF NOT EXISTS `t_imp_otheridentifier`
(
  `key`                    VARCHAR(128) NOT NULL,
  `collectionobjectkey`    VARCHAR(128) NOT NULL,
  `specifycollcode`        VARCHAR(128) NOT NULL,

  `Identifier`             VARCHAR(64),
  `Institution`            VARCHAR(64),
  `Remarks`                TEXT,

  `TimestampCreated`       DATETIME,
  `CreatedByFirstName`     VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`      VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`      DATETIME,
  `ModifiedByFirstName`    VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`     VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`          INT,
  `_CollectionObjectID`    INT,
  `_OtherIdentifierID`     INT,
  `_CreatedByAgentID`      INT,
  `_ModifiedByAgentID`     INT,

  `_importguid`            VARCHAR(36),
  `_error`                 BIT          DEFAULT 0,
  `_errormsg`              VARCHAR(255),
  `_imported`              BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_preparation_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_CollectionObjectID`),
  KEY (`_OtherIdentifierID`),
  KEY (`_importguid`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- collecting event

CREATE TABLE IF NOT EXISTS `t_imp_collectingevent`
(
  `key`                          VARCHAR(128) NOT NULL,
  `collectionobjectkey`          VARCHAR(128) NOT NULL,
  `specifycollcode`              VARCHAR(128) NOT NULL,

  `LocalityContinent`            VARCHAR(64),
  `LocalityCountry`              VARCHAR(64),
  `LocalityState`                VARCHAR(64),
  `LocalityCounty`               VARCHAR(64),
  `LocalityName`                 VARCHAR(255),
  `LocalityRemarks`              TEXT,
  `LocalityNamedPlace`           VARCHAR(255),
  `LocalityRelationToNamedPlace` VARCHAR(120),
  `LocalityLatLongType`          VARCHAR(50),
  `LocalityDMSLatitude1`         VARCHAR(50),
  `LocalityDDMLatitude1`         VARCHAR(50),
  `LocalityDDLatitude1`          DECIMAL(12,10),
  `LocalityDMSLongitude1`        VARCHAR(50),
  `LocalityDDMLongitude1`        VARCHAR(50),
  `LocalityDDLongitude1`         DECIMAL(13,10),
  `LocalityDMSLatitude2`         VARCHAR(50),
  `LocalityDDMLatitude2`         VARCHAR(50),
  `LocalityDDLatitude2`          DECIMAL(12,10),
  `LocalityDMSLongitude2`        VARCHAR(50),
  `LocalityDDMLongitude2`        VARCHAR(50),
  `LocalityDDLongitude2`         DECIMAL(13,10),
  `LocalityMinElevationMeters`   DOUBLE,
  `LocalityMaxElevationMeters`   DOUBLE,

  `StartDateVerbatim`            VARCHAR(50),
  `StartDate`                    DATE,
  `StartMonth`                   INT,
  `StartYear`                    INT,
  `EndDateVerbatim`              VARCHAR(50),
  `EndDate`                      DATE,
  `EndMonth`                     INT,
  `EndYear`                      INT,
  `VerbatimDate`                 VARCHAR(50),
  `Method`                       VARCHAR(50),
  `StationFieldNumber`           VARCHAR(50),
  `VerbatimLocality`             TEXT,
  `Remarks`                      TEXT,

  `TimestampCreated`             DATETIME,
  `CreatedByFirstName`           VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`            VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`            DATETIME,
  `ModifiedByFirstName`          VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`           VARCHAR(120) CHARACTER SET binary,

  `_DisciplineID`                INT,
  `_CollectionID`                INT,
  `_CollectingEventID`           INT,
  `_LocalityID`                  INT,
  `_StartDate`                   DATE,
  `_StartDatePrecision`          INT          DEFAULT 1,
  `_EndDate`                     DATE,
  `_EndDatePrecision`            INT          DEFAULT 1,
  `_CreatedByAgentID`            INT,
  `_ModifiedByAgentID`           INT,

  `_importguid`                  VARCHAR(36),
  `_error`                       BIT          DEFAULT 0,
  `_errormsg`                    VARCHAR(255),
  `_imported`                    BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_collectingevent_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_CollectingEventID`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- locality

CREATE TABLE IF NOT EXISTS `t_imp_locality`
(
  `key`                  VARCHAR(128) NOT NULL,
  `specifycollcode`      VARCHAR(128) NOT NULL,

  `Continent`            VARCHAR(64),
  `Country`              VARCHAR(64),
  `State`                VARCHAR(64),
  `County`               VARCHAR(64),
  `LocalityName`         VARCHAR(255),
  `Remarks`              TEXT,

  `NamedPlace`           VARCHAR(255),
  `RelationToNamedPlace` VARCHAR(120),

  `LatLongType`          VARCHAR(50),
  `DMSLatitude1`         VARCHAR(50),
  `DDMLatitude1`         VARCHAR(50),
  `DDLatitude1`          DECIMAL(12,10),
  `DMSLongitude1`        VARCHAR(50),
  `DDMLongitude1`        VARCHAR(50),
  `DDLongitude1`         DECIMAL(13,10),
  `DMSLatitude2`         VARCHAR(50),
  `DDMLatitude2`         VARCHAR(50),
  `DDLatitude2`          DECIMAL(12,10),
  `DMSLongitude2`        VARCHAR(50),
  `DDMLongitude2`        VARCHAR(50),
  `DDLongitude2`         DECIMAL(13,10),

  `MinElevationMeters`   DOUBLE,
  `MaxElevationMeters`   DOUBLE,

  `TimestampCreated`     DATETIME,
  `CreatedByFirstName`   VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`    VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`    DATETIME,
  `ModifiedByFirstName`  VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`   VARCHAR(120) CHARACTER SET binary,

  `_DisciplineID`        INT,
  `_CollectionID`        INT,
  `_LocalityID`          INT,
  `_LocalityName`        VARCHAR(255),
  `_GeographyID`         INT,
  `_Latitude1`           DECIMAL(12,10),
  `_Lat1Text`            VARCHAR(50),
  `_Longitude1`          DECIMAL(13,10),
  `_Long1Text`           VARCHAR(50),
  `_Latitude2`           DECIMAL(12,10),
  `_Lat2Text`            VARCHAR(50),
  `_Longitude2`          DECIMAL(13,10),
  `_Long2Text`           VARCHAR(50),
  `_LatLongType`         VARCHAR(50),
  `_SrcLatLongUnit`      INT          DEFAULT 0,

  `_CreatedByAgentID`    INT,
  `_ModifiedByAgentID`   INT,
  `_importguid`          VARCHAR(36),
  `_error`               BIT          DEFAULT 0,
  `_errormsg`            VARCHAR(255),
  `_imported`            BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_locality_01` PRIMARY KEY (`key`),
  KEY (`_importguid`),
  KEY (`_DisciplineID`, `_GeographyID`, `LocalityName`, `_Latitude1`, `_Longitude1`, `_Latitude2`, `_Longitude2`, `_LatLongType`, `MinElevationMeters`, `MaxElevationMeters`, `NamedPlace`, `RelationToNamedPlace`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)

) DEFAULT CHARSET=utf8;

GO

-- geography

CREATE TABLE IF NOT EXISTS `t_imp_geography`
(
  `key`                 VARCHAR(128) NOT NULL,
  `specifycollcode`     VARCHAR(64)  NOT NULL,

  `Continent`           VARCHAR(64),
  `Country`             VARCHAR(64),
  `State`               VARCHAR(64),
  `County`              VARCHAR(64),

  `_DisciplineID`       INT,
  `_CollectionID`       INT,
  `_GeographyTreeDefID` INT,
  `_GeographyRankID`    INT,
  `_GeographyID`        INT,
  `_ContinentParentID`  INT,
  `_ContinentID`        INT,
  `_Continent`          VARCHAR(64),
  `_CountryParentID`    INT,
  `_CountryID`          INT,
  `_Country`            VARCHAR(64),
  `_StateParentID`      INT,
  `_StateID`            INT,
  `_State`              VARCHAR(64),
  `_CountyParentID`     INT,
  `_CountyID`           INT,
  `_County`             VARCHAR(64),
  `_changedvalues`      TEXT,

  `_importguid`         VARCHAR(36),
  `_error`              BIT          DEFAULT 0,
  `_errormsg`           VARCHAR(255),
  `_imported`           BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_geography_01` PRIMARY KEY (`key`),
  KEY (`_ContinentParentID`, `_Continent`),
  KEY (`_Continent`),
  KEY (`_CountryParentID`, `_Country`),
  KEY (`_Country`),
  KEY (`_StateParentID`, `_State`),
  KEY (`_State`),
  KEY (`_CountyParentID`, `_County`),
  KEY (`_County`),
  KEY (`_importguid`)
) DEFAULT CHARSET=utf8;

GO

CREATE TABLE IF NOT EXISTS `t_imp_determination`
(
  `key`                 VARCHAR(128) NOT NULL,
  `collectionobjectkey` VARCHAR(128) NOT NULL,
  `specifycollcode`     VARCHAR(128) NOT NULL,

  `Kingdom`             VARCHAR(64),
  `KingdomAuthor`       VARCHAR(128),
  `Division`            VARCHAR(64),
  `DivisionAuthor`      VARCHAR(128),
  `Phylum`              VARCHAR(64),
  `PhylumAuthor`        VARCHAR(128),
  `Subphylum`           VARCHAR(64),
  `SubphylumAuthor`     VARCHAR(128),
  `Superclass`          VARCHAR(64),
  `SuperclassAuthor`    VARCHAR(128),
  `Class`               VARCHAR(64),
  `ClassAuthor`         VARCHAR(128),
  `Subclass`            VARCHAR(64),
  `SubclassAuthor`      VARCHAR(128),
  `Infraclass`          VARCHAR(64),
  `InfraclassAuthor`    VARCHAR(128),
  `Superorder`          VARCHAR(64),
  `SuperorderAuthor`    VARCHAR(128),
  `Order`               VARCHAR(64),
  `OrderAuthor`         VARCHAR(128),
  `Suborder`            VARCHAR(64),
  `SuborderAuthor`      VARCHAR(128),
  `Infraorder`          VARCHAR(64),
  `InfraorderAuthor`    VARCHAR(128),
  `Superfamily`         VARCHAR(64),
  `SuperfamilyAuthor`   VARCHAR(128),
  `Family`              VARCHAR(64),
  `FamilyAuthor`        VARCHAR(128),
  `Subfamily`           VARCHAR(64),
  `SubfamilyAuthor`     VARCHAR(128),
  `Tribe`               VARCHAR(64),
  `TribeAuthor`         VARCHAR(128),
  `Subtribe`            VARCHAR(64),
  `SubtribeAuthor`      VARCHAR(128),
  `Genus`               VARCHAR(64),
  `GenusAuthor`         VARCHAR(128),
  `Subgenus`            VARCHAR(64),
  `SubgenusAuthor`      VARCHAR(128),
  `Species`             VARCHAR(64),
  `SpeciesAuthor`       VARCHAR(128),
  `Subspecies`          VARCHAR(64),
  `SubspeciesAuthor`    VARCHAR(128),
  `Variation`           VARCHAR(64),
  `VariationAuthor`     VARCHAR(128),

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

  `AlternateName`       VARCHAR(128),
  `Confidence`          VARCHAR(50),
  `FeatureOrBasis`      VARCHAR(50),
  `Method`              VARCHAR(50),
  `NameUsage`           VARCHAR(64),
  `Number1`             FLOAT(20,10),
  `Number2`             FLOAT(20,10),
  `Text1`               TEXT,
  `Text2`               TEXT,
  `YesNo1`              BIT,
  `YesNo2`              BIT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`   VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`  VARCHAR(120) CHARACTER SET binary,

  `_DisciplineID`            INT,
  `_CollectionID`            INT,
  `_CollectionObjectID`      INT,
  `_DeterminationID`         INT,
  `_TaxonID`                 INT,
  `_TypeStatusName`          VARCHAR(50),
  `_TypeStatusValue`         VARCHAR(64),
  `_DeterminerID`            INT,
  `_DeterminedDate`          DATE,
  `_DeterminedDatePrecision` INT          DEFAULT 1,
  `_CreatedByAgentID`        INT,
  `_ModifiedByAgentID`       INT,
  `_importguid`              VARCHAR(36),
  `_error`                   BIT          DEFAULT 0,
  `_errormsg`                VARCHAR(255),
  `_imported`                BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_determination_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_CollectionID`, `_TypeStatusName`),
  KEY (`_TypeStatusName`, `key`),
  KEY (`_CollectionID`, `DeterminerLastName`, `DeterminerFirstName`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)

) DEFAULT CHARSET=utf8;

GO

-- taxon

CREATE TABLE IF NOT EXISTS t_imp_taxon
(
  `key`                  VARCHAR(128) NOT NULL,
  `specifycollcode`      VARCHAR(128),

  `Kingdom`              VARCHAR(64),
  `KingdomAuthor`        VARCHAR(128),
  `Division`             VARCHAR(64),
  `DivisionAuthor`       VARCHAR(128),
  `Phylum`               VARCHAR(64),
  `PhylumAuthor`         VARCHAR(128),
  `Subphylum`            VARCHAR(64),
  `SubphylumAuthor`      VARCHAR(128),
  `Superclass`           VARCHAR(64),
  `SuperclassAuthor`     VARCHAR(128),
  `Class`                VARCHAR(64),
  `ClassAuthor`          VARCHAR(128),
  `Subclass`             VARCHAR(64),
  `SubclassAuthor`       VARCHAR(128),
  `Infraclass`           VARCHAR(64),
  `InfraclassAuthor`     VARCHAR(128),
  `Superorder`           VARCHAR(64),
  `SuperorderAuthor`     VARCHAR(128),
  `Order`                VARCHAR(64),
  `OrderAuthor`          VARCHAR(128),
  `Suborder`             VARCHAR(64),
  `SuborderAuthor`       VARCHAR(128),
  `Infraorder`           VARCHAR(64),
  `InfraorderAuthor`     VARCHAR(128),
  `Superfamily`          VARCHAR(64),
  `SuperfamilyAuthor`    VARCHAR(128),
  `Family`               VARCHAR(64),
  `FamilyAuthor`         VARCHAR(128),
  `Subfamily`            VARCHAR(64),
  `SubfamilyAuthor`      VARCHAR(128),
  `Tribe`                VARCHAR(64),
  `TribeAuthor`          VARCHAR(128),
  `Subtribe`             VARCHAR(64),
  `SubtribeAuthor`       VARCHAR(128),
  `Genus`                VARCHAR(64),
  `GenusAuthor`          VARCHAR(128),
  `Subgenus`             VARCHAR(64),
  `SubgenusAuthor`       VARCHAR(128),
  `Species`              VARCHAR(64),
  `SpeciesAuthor`        VARCHAR(128),
  `Subspecies`           VARCHAR(64),
  `SubspeciesAuthor`     VARCHAR(128),
  `Variation`            VARCHAR(64),
  `VariationAuthor`      VARCHAR(128),
/*
  `SynGenus`                VARCHAR(64),
  `SynGenusAuthor`          VARCHAR(128),
  `SynSubgenus`             VARCHAR(64),
  `SynSubgenusAuthor`       VARCHAR(128),
  `SynSpecies`              VARCHAR(64),
  `SynSpeciesAuthor`        VARCHAR(128),
  `SynSubspecies`           VARCHAR(64),
  `SynSubspeciesAuthor`     VARCHAR(128),
  `SynVariation`            VARCHAR(64),
  `SynVariationAuthor`      VARCHAR(128),
*/
  `_DisciplineID`        INT,
  `_CollectionID`        INT,
  `_TaxonTreeDefID`      INT,
  `_TaxonRankID`         INT,
  `_TaxonID`             INT,
  `_KingdomParentID`     INT,
  `_KingdomID`           INT,
  `_DivisionParentID`    INT,
  `_DivisionID`          INT,
  `_PhylumParentID`      INT,
  `_PhylumID`            INT,
  `_SubphylumParentID`   INT,
  `_SubphylumID`         INT,
  `_SuperclassParentID`  INT,
  `_SuperclassID`        INT,
  `_ClassParentID`       INT,
  `_ClassID`             INT,
  `_SubclassParentID`    INT,
  `_SubclassID`          INT,
  `_InfraclassParentID`  INT,
  `_InfraclassID`        INT,
  `_SuperorderParentID`  INT,
  `_SuperorderID`        INT,
  `_OrderParentID`       INT,
  `_OrderID`             INT,
  `_SuborderParentID`    INT,
  `_SuborderID`          INT,
  `_InfraorderParentID`  INT,
  `_InfraorderID`        INT,
  `_SuperfamilyParentID` INT,
  `_SuperfamilyID`       INT,
  `_FamilyParentID`      INT,
  `_FamilyID`            INT,
  `_SubfamilyParentID`   INT,
  `_SubfamilyID`         INT,
  `_TribeParentID`       INT,
  `_TribeID`             INT,
  `_SubtribeParentID`    INT,
  `_SubtribeID`          INT,
  `_GenusParentID`       INT,
  `_GenusID`             INT,
  `_SubgenusParentID`    INT,
  `_SubgenusID`          INT,
  `_SpeciesParentID`     INT,
  `_SpeciesID`           INT,
  `_SubspeciesParentID`  INT,
  `_SubspeciesID`        INT,
  `_VariationParentID`   INT,
  `_VariationID`         INT,

  `_importguid`          VARCHAR(36),
  `_error`               BIT          DEFAULT 0,
  `_errormsg`            VARCHAR(255),
  `_imported`            BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_taxon_01` PRIMARY KEY (`key`),
  CONSTRAINT `uq_imp_taxon_01` UNIQUE (`specifycollcode`, `key`),

  KEY (`_importguid`),
  KEY (`_TaxonRankID`, `key`),
  KEY (`_KingdomParentID`,     `Kingdom`,     `KingdomAuthor`),
  KEY (`_DivisionParentID`,    `Division`,    `DivisionAuthor`),
  KEY (`_PhylumParentID`,      `Phylum`,      `PhylumAuthor`),
  KEY (`_SubphylumParentID`,   `Subphylum`,   `SubphylumAuthor`),
  KEY (`_SuperclassParentID`,  `Superclass`,  `SuperclassAuthor`),
  KEY (`_ClassParentID`,       `Class`,       `ClassAuthor`),
  KEY (`_SubclassParentID`,    `Subclass`,    `SubclassAuthor`),
  KEY (`_InfraclassParentID`,  `Infraclass`,  `InfraclassAuthor`),
  KEY (`_SuperorderParentID`,  `Superorder`,  `SuperorderAuthor`),
  KEY (`_OrderParentID`,       `Order`,       `OrderAuthor`),
  KEY (`_SuborderParentID`,    `Suborder`,    `SuborderAuthor`),
  KEY (`_InfraorderParentID`,  `Infraorder`,  `InfraorderAuthor`),
  KEY (`_SuperfamilyParentID`, `Superfamily`, `SuperfamilyAuthor`),
  KEY (`_FamilyParentID`,      `Family`,      `FamilyAuthor`),
  KEY (`_SubfamilyParentID`,   `Subfamily`,   `SubfamilyAuthor`),
  KEY (`_TribeParentID`,       `Tribe`,       `TribeAuthor`),
  KEY (`_SubtribeParentID`,    `Subtribe`,    `SubtribeAuthor`),
  KEY (`_GenusParentID`,       `Genus`,       `GenusAuthor`),
  KEY (`_SubgenusParentID`,    `Subgenus`,    `SubgenusAuthor`),
  KEY (`_SpeciesParentID`,     `Species`,     `SpeciesAuthor`),
  KEY (`_SubspeciesParentID`,  `Subspecies`,  `SubspeciesAuthor`),
  KEY (`_VariationParentID`,   `Variation`,   `VariationAuthor`)

) DEFAULT CHARSET=utf8;

GO

-- geological time period

CREATE TABLE IF NOT EXISTS `t_imp_geologictimeperiod`
(
  `key`                          VARCHAR(128) NOT NULL,
  `specifycollcode`              VARCHAR(64),

  `ErathemEra`                   VARCHAR(64),
  `SystemPeriod`                 VARCHAR(64),
  `SeriesEpoch`                  VARCHAR(64),
  `StageAge`                     VARCHAR(64),

  `_GeologicTimePeriodTreeDefID` INT,
  `_GeologicTimePeriodRankID`    INT,
  `_GeologicTimePeriodID`        INT,
  `_ErathemEraParentID`          INT,
  `_ErathemEraID`                INT,
  `_ErathemEra`                  VARCHAR(64),
  `_SystemPeriodParentID`        INT,
  `_SystemPeriodID`              INT,
  `_SystemPeriod`                VARCHAR(64),
  `_SeriesEpochParentID`         INT,
  `_SeriesEpochID`               INT,
  `_SeriesEpoch`                 VARCHAR(64),
  `_StageAgeParentID`            INT,
  `_StageAgeID`                  INT,
  `_StageAge`                    VARCHAR(64),

  `_importguid`                  VARCHAR(36),
  `_error`                       BIT          DEFAULT 0,
  `_errormsg`                    VARCHAR(255),
  `_imported`                    BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_geologictimeperiod_01` PRIMARY KEY (`key`),
  KEY (`_ErathemEraParentID`, `_ErathemEra`),
  KEY (`_ErathemEra`),
  KEY (`_SystemPeriodParentID`, `_SystemPeriod`),
  KEY (`_SystemPeriod`),
  KEY (`_SeriesEpochParentID`, `_SeriesEpoch`),
  KEY (`_SeriesEpoch`),
  KEY (`_StageAgeParentID`, `_StageAge`),
  KEY (`_StageAge`),
  KEY (`_importguid`)
) DEFAULT CHARSET=utf8;

GO

--

CREATE TABLE IF NOT EXISTS `t_imp_paleocontext`
(
  `key`                      VARCHAR(128) NOT NULL,
  `collectionobjectkey`      VARCHAR(128) NOT NULL,
  `specifycollcode`          VARCHAR(128) NOT NULL,

  `ChronosStratErathemEra`   VARCHAR(64),
  `ChronosStratSystemPeriod` VARCHAR(64),
  `ChronosStratSeriesEpoch`  VARCHAR(64),
  `ChronosStratStageAge`     VARCHAR(64),

  `BottomDistance`           FLOAT(20,10),
  `TopDistance`              FLOAT(20,10),
  `Direction`                VARCHAR(32), 
  `DistanceUnits`            VARCHAR(16), 
  `PositionState`            VARCHAR(32),
  `Text1`                    VARCHAR(64), 
  `Text2`                    VARCHAR(64), 
  `YesNo1`                   BIT,
  `YesNo2`                   BIT,

  `Remarks`                  TEXT,

  `TimestampCreated`         DATETIME,
  `CreatedByFirstName`       VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`        VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`        DATETIME,
  `ModifiedByFirstName`      VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`       VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`            INT,
  `_PaleoContextID`          INT,
  `_ChronosStratID`          INT,
  `_ChronosStratEndID`       INT,
  `_BioStratID`              INT,
  `_LithoStratID`            INT,
  `_CreatedByAgentID`        INT,
  `_ModifiedByAgentID`       INT,

  `_importguid`              VARCHAR(36),
  `_error`                   BIT          DEFAULT 0,
  `_errormsg`                VARCHAR(255),
  `_imported`                BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_paleocontext_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_PaleoContextID`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- collectors

CREATE TABLE IF NOT EXISTS `t_imp_collector`
(
  `key`                 VARCHAR(128) NOT NULL,
  `collectionobjectkey` VARCHAR(128) NOT NULL,
  `specifycollcode`     VARCHAR(128) NOT NULL,

  `OrderNumber`         INT,
  `FirstName`           VARCHAR(50)  CHARACTER SET binary,
  `LastName`            VARCHAR(120) CHARACTER SET binary,
  `IsPrimary`           BIT,
  `Remarks`             TEXT,

  `TimestampCreated`    DATETIME,
  `CreatedByFirstName`  VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`   VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`   DATETIME,
  `ModifiedByFirstName` VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`  VARCHAR(120) CHARACTER SET binary,

  `_OrderNumber`        INT,
  `_DivisionID`         INT,
  `_CollectionID`       INT,
  `_CollectionObjectID` INT,
  `_CollectingEventID`  INT,
  `_CollectorID`        INT,
  `_AgentID`            INT,
  `_CreatedByAgentID`   INT,
  `_ModifiedByAgentID`  INT,

  `_importguid`         VARCHAR(36),
  `_error`              BIT          DEFAULT 0,
  `_errormsg`           VARCHAR(255),
  `_imported`           BIT          DEFAULT 0,


  CONSTRAINT `pk_imp_collector_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_CollectingEventID`, `OrderNumber`),
  KEY (`_CollectionID`, `LastName`, `FirstName`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- storage

CREATE TABLE IF NOT EXISTS t_imp_storage
(
  `key`                 VARCHAR(128) NOT NULL,
  `specifycollcode`     VARCHAR(64)  NOT NULL,

  `Building`            VARCHAR(64),
  `Collection`          VARCHAR(64),
  `Room`                VARCHAR(64),
  `Aisle`               VARCHAR(64),
  `Cabinet`             VARCHAR(64),
  `Shelf`               VARCHAR(64),
  `Box`                 VARCHAR(64),
  `Rack`                VARCHAR(64),
  `Vial`                VARCHAR(64),

  `_StorageTreeDefID`   INT,
  `_StorageID`          INT,
  `_StorageRankID`      INT,
  `_BuildingParentID`   INT,
  `_BuildingID`         INT,
  `_CollectionParentID` INT,
  `_CollectionID`       INT,
  `_RoomParentID`       INT,
  `_RoomID`             INT,
  `_AisleParentID`      INT,
  `_AisleID`            INT,
  `_CabinetParentID`    INT,
  `_CabinetID`          INT,
  `_ShelfParentID`      INT,
  `_ShelfID`            INT,
  `_BoxParentID`        INT,
  `_BoxID`              INT,
  `_RackParentID`       INT,
  `_RackID`             INT,
  `_VialParentID`       INT,
  `_VialID`             INT,

  `_importguid`         VARCHAR(36),
  `_error`              BIT          DEFAULT 0,
  `_errormsg`           VARCHAR(255),
  `_imported`           BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_storage_01` PRIMARY KEY (`key`),
  KEY (`_StorageRankID`, `key`),
  KEY (`_BuildingParentID`,   `Building`),
  KEY (`_CollectionParentID`, `Collection`),
  KEY (`_RoomParentID`,       `Room`),
  KEY (`_AisleParentID`,      `Aisle`),
  KEY (`_CabinetParentID`,    `Cabinet`),
  KEY (`_ShelfParentID`,      `Shelf`),
  KEY (`_BoxParentID`,        `Box`),
  KEY (`_RackParentID`,       `Rack`),
  KEY (`_VialParentID`,       `Vial`),
  KEY (`_importguid`)
) DEFAULT CHARSET=utf8;

GO

-- preparation

CREATE TABLE IF NOT EXISTS `t_imp_preparation`
(
  `key`                    VARCHAR(128) NOT NULL,
  `collectionobjectkey`    VARCHAR(128) NOT NULL,
  `specifycollcode`        VARCHAR(128) NOT NULL,

  `Description`            VARCHAR(255),
  `Count`                  INT,
  `PrepType`               VARCHAR(64),
  `PreparedDate`           DATE,
  `PreparedMonth`          INT,
  `PreparedYear`           INT,
  `PreparedByFirstName`    VARCHAR(50)  CHARACTER SET binary,
  `PreparedByLastName`     VARCHAR(120) CHARACTER SET binary,
  `SampleNumber`           VARCHAR(32),
  `StorageLocation`        VARCHAR(50),
  `Remarks`                TEXT,

  `StorageBuilding`        VARCHAR(64),
  `StorageCollection`      VARCHAR(64),
  `StorageRoom`            VARCHAR(64),
  `StorageAisle`           VARCHAR(64),
  `StorageCabinet`         VARCHAR(64),
  `StorageShelf`           VARCHAR(64),
  `StorageBox`             VARCHAR(64),
  `StorageRack`            VARCHAR(64),
  `StorageVial`            VARCHAR(64),

  `YesNo1`                 BIT,          -- mfn paldb cast
  `YesNo2`                 BIT,          -- mfn paldb original
  `YesNo3`                 BIT,

  `TimestampCreated`       DATETIME,
  `CreatedByFirstName`     VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`      VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`      DATETIME,
  `ModifiedByFirstName`    VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`     VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`          INT,
  `_CollectionObjectID`    INT,
  `_PreparationID`         INT,
  `_PrepTypeName`          VARCHAR(64),
  `_PrepTypeID`            INT,
  `_PreparedByID`          INT,
  `_PreparedDate`          DATE,
  `_PreparedDatePrecision` INT          DEFAULT 1,
  `_StorageID`             INT,
  `_CreatedByAgentID`      INT,
  `_ModifiedByAgentID`     INT,

  `_hasdata`               BIT          DEFAULT 0,
  `_importguid`            VARCHAR(36),
  `_error`                 BIT          DEFAULT 0,
  `_errormsg`              VARCHAR(255),
  `_imported`              BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_preparation_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_CollectionObjectID`),
  KEY (`_importguid`),
  KEY (`_CollectionID`, `_PrepTypeID`),
  KEY (`_PrepTypeName`, `key`),
  KEY (`_CollectionID`, `PreparedByLastName`, `PreparedByFirstName`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- preparation attributes

CREATE TABLE IF NOT EXISTS `t_imp_preparationattribute`
(
  `key`                     VARCHAR(128) NOT NULL,
  `preparationkey`          VARCHAR(128) NOT NULL,
  `collectionobjectkey`     VARCHAR(128) NOT NULL,
  `specifycollcode`         VARCHAR(128) NOT NULL,

  `AttrDate`                DATETIME,

  `Number1`                 FLOAT(20,10),
  `Number2`                 FLOAT(20,10),
  `Number3`                 FLOAT(20,10),
  `Number4`                 INT,
  `Number5`                 INT,
  `Number6`                 INT,
  `Number7`                 INT,
  `Number8`                 INT,
  `Number9`                 SMALLINT,

  `Text1`                   TEXT,
  `Text2`                   TEXT,
  `Text3`                   VARCHAR(50),
  `Text4`                   VARCHAR(50),
  `Text5`                   VARCHAR(50),
  `Text6`                   VARCHAR(50),
  `Text7`                   VARCHAR(50),
  `Text8`                   VARCHAR(50),
  `Text9`                   VARCHAR(50),
  `Text10`                  VARCHAR(50),
  `Text11`                  VARCHAR(50),
  `Text12`                  VARCHAR(50),
  `Text13`                  VARCHAR(50),
  `Text14`                  VARCHAR(50),
  `Text15`                  VARCHAR(50),
  `Text16`                  VARCHAR(50),
  `Text17`                  VARCHAR(50),
  `Text18`                  VARCHAR(50),
  `Text19`                  VARCHAR(50),
  `Text20`                  VARCHAR(50),
  `Text21`                  VARCHAR(50),
  `Text22`                  VARCHAR(50),
  `Text23`                  VARCHAR(50),
  `Text24`                  VARCHAR(50),
  `Text25`                  VARCHAR(50),
  `Text26`                  VARCHAR(50),

  `YesNo1`                  BIT,
  `YesNo2`                  BIT,
  `YesNo3`                  BIT,
  `YesNo4`                  BIT,

  `Remarks`                 TEXT,

  `TimestampCreated`        DATETIME,
  `CreatedByFirstName`      VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`       VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`       DATETIME,
  `ModifiedByFirstName`     VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`      VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`           INT,
  `_CollectionObjectID`     INT,
  `_PreparationID`          INT,
  `_PreparationAttributeID` INT,
  `_CreatedByAgentID`       INT,
  `_ModifiedByAgentID`      INT,

  `_hasdata`                BIT          DEFAULT 0,
  `_importguid`             VARCHAR(36),
  `_error`                  BIT          DEFAULT 0,
  `_errormsg`               VARCHAR(255),
  `_imported`               BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_preparationattribute_01` PRIMARY KEY (`key`),
  KEY (`preparationkey`),
  KEY (`_importguid`),
  KEY (`_CollectionObjectID`),
  KEY (`_PreparationID`),
  KEY (`_PreparationAttributeID`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- collection object attributes

CREATE TABLE IF NOT EXISTS `t_imp_collectionobjectattribute`
(
  `key`                          VARCHAR(128) NOT NULL,
  `collectionobjectkey`          VARCHAR(128) NOT NULL,
  `specifycollcode`              VARCHAR(128) NOT NULL,

  `Number1`                      FLOAT(20,10),
  `Number2`                      FLOAT(20,10),
  `Number3`                      FLOAT(20,10),
  `Number4`                      FLOAT(20,10),
  `Number5`                      FLOAT(20,10),
  `Number6`                      FLOAT(20,10),
  `Number7`                      FLOAT(20,10),
  `Number8`                      TINYINT(4),
  `Number9`                      FLOAT(20,10),
  `Number10`                     FLOAT(20,10),
  `Number11`                     FLOAT(20,10),
  `Number12`                     FLOAT(20,10),
  `Number13`                     FLOAT(20,10),
  `Number14`                     FLOAT(20,10),
  `Number15`                     FLOAT(20,10),
  `Number16`                     FLOAT(20,10),
  `Number17`                     FLOAT(20,10),
  `Number18`                     FLOAT(20,10),
  `Number19`                     FLOAT(20,10),
  `Number20`                     FLOAT(20,10),
  `Number21`                     FLOAT(20,10),
  `Number22`                     FLOAT(20,10),
  `Number23`                     FLOAT(20,10),
  `Number24`                     FLOAT(20,10),
  `Number25`                     FLOAT(20,10),
  `Number26`                     FLOAT(20,10),
  `Number27`                     FLOAT(20,10),
  `Number28`                     FLOAT(20,10),
  `Number29`                     FLOAT(20,10),
  `Number30`                     SMALLINT(6),
  `Number31`                     FLOAT(20,10),
  `Number32`                     FLOAT(20,10),
  `Number33`                     FLOAT(20,10),
  `Number34`                     FLOAT(20,10),
  `Number35`                     FLOAT(20,10),
  `Number36`                     FLOAT(20,10),
  `Number37`                     FLOAT(20,10),
  `Number38`                     FLOAT(20,10),
  `Number39`                     FLOAT(20,10),
  `Number40`                     FLOAT(20,10),
  `Number41`                     FLOAT(20,10),
  `Number42`                     FLOAT(20,10),

  `Text1`                        TEXT,
  `Text2`                        TEXT,
  `Text3`                        TEXT,
  `Text4`                        VARCHAR(50),
  `Text5`                        VARCHAR(50),
  `Text6`                        VARCHAR(100),
  `Text7`                        VARCHAR(100),
  `Text8`                        VARCHAR(50),
  `Text9`                        VARCHAR(50),
  `Text10`                       VARCHAR(50),
  `Text11`                       VARCHAR(50),
  `Text12`                       VARCHAR(50),
  `Text13`                       VARCHAR(50),
  `Text14`                       VARCHAR(50),
  `Text15`                       VARCHAR(64),

  `YesNo1`                       BIT,
  `YesNo2`                       BIT,
  `YesNo3`                       BIT,
  `YesNo4`                       BIT,
  `YesNo5`                       BIT,
  `YesNo6`                       BIT,
  `YesNo7`                       BIT,

  `Remarks`                      TEXT,

  `TimestampCreated`             DATETIME,
  `CreatedByFirstName`           VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`            VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`            DATETIME,
  `ModifiedByFirstName`          VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`           VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`                INT,
  `_CollectionObjectID`          INT,
  `_CollectionObjectAttributeID` INT,
  `_Age`                         VARCHAR(50),
  `_BiologicalSex`               VARCHAR(50),
  `_CreatedByAgentID`            INT,
  `_ModifiedByAgentID`           INT,

  `_hasdata`                     BIT          DEFAULT 0,
  `_importguid`                  VARCHAR(36),
  `_error`                       BIT          DEFAULT 0,
  `_errormsg`                    VARCHAR(255),
  `_imported`                    BIT          DEFAULT 0,

  CONSTRAINT `pk_imp_collectionobjectattribute_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_CollectionObjectID`),
  KEY (`_CollectionID`, `_Age`),
  KEY (`_Age`, `key`),
  KEY (`_CollectionID`, `_BiologicalSex`),
  KEY (`_BiologicalSex`, `key`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- collection object citations

CREATE TABLE IF NOT EXISTS `t_imp_collectionobjectcitation`
(
  `key`                         VARCHAR(128) NOT NULL,
  `collectionobjectkey`         VARCHAR(128) NOT NULL,
  `specifycollcode`             VARCHAR(128) NOT NULL,

  `RefWorkType`                 VARCHAR(64),
  `RefWorkTitle`                VARCHAR(255),
  `RefWorkPublisher`            VARCHAR(50),
  `RefWorkPlaceOfPublication`   VARCHAR(50),
  `RefWorkWorkDate`             VARCHAR(25),
  `RefWorkVolume`               VARCHAR(25),
  `RefWorkPages`                VARCHAR(50),
  `RefWorkJournalName`          VARCHAR(255),
  `RefWorkJournalAbbreviation`  VARCHAR(50),
  `RefWorkLibraryNumber`        VARCHAR(50),
  `RefWorkISBN`                 VARCHAR(16),
  `RefWorkGUID`                 VARCHAR(128),
  `RefWorkURL`                  TEXT,
  `RefWorkIsPublished`          BIT,
  `RefWorkRemarks`              TEXT,
  `RefWorkText1`                TEXT,
  `RefWorkText2`                TEXT,
  `RefWorkNumber1`              FLOAT(20,10), 
  `RefWorkNumber2`              FLOAT(20,10),
  `RefWorkYesNo1`               BIT,
  `RefWorkYesNo2`               BIT,

  `IsFigured`                   BIT,
  `Remarks`                     TEXT,

  `TimestampCreated`            DATETIME,
  `CreatedByFirstName`          VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`           VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`           DATETIME,
  `ModifiedByFirstName`         VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`          VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`               INT,
  `_CollectionObjectID`         INT,
  `_CollectionObjectCitationID` INT,
  `_ReferenceWorkID`            INT,
  `_CreatedByAgentID`           INT,
  `_ModifiedByAgentID`          INT,

  `_importguid`                 VARCHAR(36),
  `_error`                      BIT          DEFAULT 0,
  `_errormsg`                   VARCHAR(255),
  `_imported`                   BIT          DEFAULT 0,


  CONSTRAINT `pk_imp_collectionobjectcitation_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_CollectionObjectID`),
  KEY (`_CollectionID`, `key`),
  KEY (`_CollectionObjectID`, `key`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- determination citations
-- currently unused

CREATE TABLE IF NOT EXISTS `t_imp_determinationcitation`
(
  `key`                        VARCHAR(128) NOT NULL,
  `collectionobjectkey`        VARCHAR(128) NOT NULL,
  `determinationkey`           VARCHAR(128) NOT NULL,
  `specifycollcode`            VARCHAR(128) NOT NULL,

  `RefWorkType`                VARCHAR(64),
  `RefWorkTitle`               VARCHAR(255),
  `RefWorkPublisher`           VARCHAR(50),
  `RefWorkPlaceOfPublication`  VARCHAR(50),
  `RefWorkWorkDate`            VARCHAR(25),
  `RefWorkVolume`              VARCHAR(25),
  `RefWorkPages`               VARCHAR(50),
  `RefWorkJournalName`         VARCHAR(255),
  `RefWorkJournalAbbreviation` VARCHAR(50),
  `RefWorkLibraryNumber`       VARCHAR(50),
  `RefWorkISBN`                VARCHAR(16),
  `RefWorkGUID`                VARCHAR(128),
  `RefWorkURL`                 TEXT,
  `RefWorkIsPublished`         BIT,
  `RefWorkRemarks`             TEXT,
  `RefWorkText1`               TEXT,
  `RefWorkText2`               TEXT,
  `RefWorkNumber1`             FLOAT(20,10), 
  `RefWorkNumber2`             FLOAT(20,10),
  `RefWorkYesNo1`              BIT,
  `RefWorkYesNo2`              BIT,

  `IsFigured`                  BIT,
  `Remarks`                    TEXT,

  `TimestampCreated`           DATETIME,
  `CreatedByFirstName`         VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`          VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`          DATETIME,
  `ModifiedByFirstName`        VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`         VARCHAR(120) CHARACTER SET binary,

  `_CollectionID`              INT,
  `_CollectionObjectID`        INT,
  `_DeterminationID`           INT,
  `_DeterminationCitationID`   INT,
  `_ReferenceWorkID`           INT,
  `_CreatedByAgentID`          INT,
  `_ModifiedByAgentID`         INT,

  `_importguid`                VARCHAR(36),
  `_error`                     BIT          DEFAULT 0,
  `_errormsg`                  VARCHAR(255),
  `_imported`                  BIT          DEFAULT 0,


  CONSTRAINT `pk_imp_collectionobjectcitation_01` PRIMARY KEY (`key`),
  KEY (`collectionobjectkey`),
  KEY (`_importguid`),
  KEY (`_CollectionObjectID`),
  KEY (`_CollectionID`, `key`),
  KEY (`_CollectionObjectID`, `key`),
  KEY (`_CollectionID`, `CreatedByLastName`, `CreatedByFirstName`),
  KEY (`_CollectionID`, `ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

-- reference work

CREATE TABLE IF NOT EXISTS `t_imp_referencework`
(
  `key`                  VARCHAR(128) NOT NULL,
  `specifycollcode`      VARCHAR(128) NOT NULL,

  `ReferenceWorkType`    VARCHAR(64),
  `Title`                VARCHAR(255),
  `Publisher`            VARCHAR(50),
  `PlaceOfPublication`   VARCHAR(50),
  `WorkDate`             VARCHAR(25),
  `Volume`               VARCHAR(25),
  `Pages`                VARCHAR(50),
  `JournalName`          VARCHAR(255),
  `JournalAbbreviation`  VARCHAR(50),
  `LibraryNumber`        VARCHAR(50),
  `ISBN`                 VARCHAR(16),
  `GUID`                 VARCHAR(128),
  `URL`                  TEXT,
  `IsPublished`          BIT,
  `Remarks`              TEXT,

  `Text1`                TEXT,
  `Text2`                TEXT,
  `Number1`              FLOAT(20,10), 
  `Number2`              FLOAT(20,10),
  `YesNo1`               BIT,
  `YesNo2`               BIT,

  `TimestampCreated`     DATETIME,
  `CreatedByFirstName`   VARCHAR(50)  CHARACTER SET binary,
  `CreatedByLastName`    VARCHAR(120) CHARACTER SET binary,
  `TimestampModified`    DATETIME,
  `ModifiedByFirstName`  VARCHAR(50)  CHARACTER SET binary,
  `ModifiedByLastName`   VARCHAR(120) CHARACTER SET binary,

  `_InstitutionID`       INT,
  `_ReferenceWorkID`     INT,
  `_ReferenceWorkTypeID` INT,
  `_JournalID`           INT,
  `_ContainedRFParentID` INT,
  `_CreatedByAgentID`    INT,
  `_ModifiedByAgentID`   INT,

  `_importguid`          VARCHAR(36),
  `_error`               BIT          DEFAULT 0,
  `_errormsg`            VARCHAR(255),
  `_imported`            BIT          DEFAULT 0,


  CONSTRAINT `pk_imp_referencework_01` PRIMARY KEY (`key`),
  KEY (`_ReferenceWorkTypeID`, `Title`, `Publisher`, `PlaceOfPublication`, `WorkDate`, `Volume`, `Pages`, `_JournalID`, `_ContainedRFParentID`),
  KEY (`_importguid`),
  KEY (`_ReferenceWorkID`),
  KEY (`_JournalID`),
  KEY (`_ContainedRFParentID`),
  KEY (`CreatedByLastName`, `CreatedByFirstName`),
  KEY (`ModifiedByLastName`, `ModifiedByFirstName`)
) DEFAULT CHARSET=utf8;

GO

CREATE TABLE IF NOT EXISTS `t_specifycountry`
(
  `GeographyCode`    VARCHAR(8)  NOT NULL,
  `Country`          VARCHAR(64) NOT NULL,
  `SpecifyCountry`   VARCHAR(64) NOT NULL,
  `SpecifyContinent` VARCHAR(64) NOT NULL,

  CONSTRAINT `pk_specifycountry_01` PRIMARY KEY (`GeographyCode`, `Country`),
  INDEX      `ix_specifycountry_01` (`Country`, `SpecifyCountry`),
  INDEX      `ix_specifycountry_02` (`SpecifyCountry`, `SpecifyContinent`)

) DEFAULT CHARSET=utf8;

GO

/******************************************************************************/
/* trigger                                                                    */
/******************************************************************************/

-- 

DROP TRIGGER IF EXISTS `tr_imp_geography`;

GO

CREATE TRIGGER `tr_imp_geography` BEFORE INSERT ON `t_imp_geography`
  FOR EACH ROW 
BEGIN
  SET NEW.`Continent` = COALESCE(TRIM(NEW.`Continent`), '');
  SET NEW.`Country`   = COALESCE(TRIM(NEW.`Country`)  , '');
  SET NEW.`State`     = COALESCE(TRIM(NEW.`State`)    , '');
  SET NEW.`County`    = COALESCE(TRIM(NEW.`County`)   , '');
END

GO

-- 

DROP TRIGGER IF EXISTS `tr_imp_storage`;

GO

CREATE TRIGGER `tr_imp_storage` BEFORE INSERT ON `t_imp_storage`
  FOR EACH ROW 
BEGIN
  SET NEW.`Building`   = COALESCE(TRIM(NEW.`Building`),   '');
  SET NEW.`Collection` = COALESCE(TRIM(NEW.`Collection`), '');
  SET NEW.`Room`       = COALESCE(TRIM(NEW.`Room`),       '');
  SET NEW.`Aisle`      = COALESCE(TRIM(NEW.`Aisle`),      '');
  SET NEW.`Cabinet`    = COALESCE(TRIM(NEW.`Cabinet`),    '');
  SET NEW.`Shelf`      = COALESCE(TRIM(NEW.`Shelf`),      '');
  SET NEW.`Box`        = COALESCE(TRIM(NEW.`Box`),        '');
  SET NEW.`Rack`       = COALESCE(TRIM(NEW.`Rack`),       '');
  SET NEW.`Vial`       = COALESCE(TRIM(NEW.`Vial`),       '');
END

GO

-- 

DROP TRIGGER IF EXISTS `tr_imp_taxon`;

GO

CREATE TRIGGER `tr_imp_taxon` BEFORE INSERT ON `t_imp_taxon`
  FOR EACH ROW 
BEGIN
  SET NEW.`Kingdom`     = COALESCE(TRIM(NEW.`Kingdom`), '');
  SET NEW.`Division`    = COALESCE(TRIM(NEW.`Division`), '');
  SET NEW.`Phylum`      = COALESCE(TRIM(NEW.`Phylum`), '');
  SET NEW.`Subphylum`   = COALESCE(TRIM(NEW.`Subphylum`), '');
  SET NEW.`Superclass`  = COALESCE(TRIM(NEW.`Superclass`), '');
  SET NEW.`Class`       = COALESCE(TRIM(NEW.`Class`), '');
  SET NEW.`Subclass`    = COALESCE(TRIM(NEW.`Subclass`), '');
  SET NEW.`Infraclass`  = COALESCE(TRIM(NEW.`Infraclass`), '');
  SET NEW.`Superorder`  = COALESCE(TRIM(NEW.`Superorder`), '');
  SET NEW.`Order`       = COALESCE(TRIM(NEW.`Order`), '');
  SET NEW.`Suborder`    = COALESCE(TRIM(NEW.`Suborder`), '');
  SET NEW.`Infraorder`  = COALESCE(TRIM(NEW.`Infraorder`), '');
  SET NEW.`Superfamily` = COALESCE(TRIM(NEW.`Superfamily`), '');
  SET NEW.`Family`      = COALESCE(TRIM(NEW.`Family`), '');
  SET NEW.`Subfamily`   = COALESCE(TRIM(NEW.`Subfamily`), '');
  SET NEW.`Tribe`       = COALESCE(TRIM(NEW.`Tribe`), '');
  SET NEW.`Subtribe`    = COALESCE(TRIM(NEW.`Subtribe`), '');
  SET NEW.`Genus`       = COALESCE(TRIM(NEW.`Genus`), '');
  SET NEW.`Subgenus`    = COALESCE(TRIM(NEW.`Subgenus`), '');
  SET NEW.`Species`     = COALESCE(TRIM(NEW.`Species`), '');
  SET NEW.`Subspecies`  = COALESCE(TRIM(NEW.`Subspecies`), '');
  SET NEW.`Variation`   = COALESCE(TRIM(NEW.`Variation`), '');

  SET NEW.`KingdomAuthor`     = COALESCE(TRIM(NEW.`KingdomAuthor`), '');
  SET NEW.`DivisionAuthor`    = COALESCE(TRIM(NEW.`DivisionAuthor`), '');
  SET NEW.`PhylumAuthor`      = COALESCE(TRIM(NEW.`PhylumAuthor`), '');
  SET NEW.`SubphylumAuthor`   = COALESCE(TRIM(NEW.`SubphylumAuthor`), '');
  SET NEW.`SuperclassAuthor`  = COALESCE(TRIM(NEW.`SuperclassAuthor`), '');
  SET NEW.`ClassAuthor`       = COALESCE(TRIM(NEW.`ClassAuthor`), '');
  SET NEW.`SubclassAuthor`    = COALESCE(TRIM(NEW.`SubclassAuthor`), '');
  SET NEW.`InfraclassAuthor`  = COALESCE(TRIM(NEW.`InfraclassAuthor`), '');
  SET NEW.`SuperorderAuthor`  = COALESCE(TRIM(NEW.`SuperorderAuthor`), '');
  SET NEW.`OrderAuthor`       = COALESCE(TRIM(NEW.`OrderAuthor`), '');
  SET NEW.`SuborderAuthor`    = COALESCE(TRIM(NEW.`SuborderAuthor`), '');
  SET NEW.`InfraorderAuthor`  = COALESCE(TRIM(NEW.`InfraorderAuthor`), '');
  SET NEW.`SuperfamilyAuthor` = COALESCE(TRIM(NEW.`SuperfamilyAuthor`), '');
  SET NEW.`FamilyAuthor`      = COALESCE(TRIM(NEW.`FamilyAuthor`), '');
  SET NEW.`SubfamilyAuthor`   = COALESCE(TRIM(NEW.`SubfamilyAuthor`), '');
  SET NEW.`TribeAuthor`       = COALESCE(TRIM(NEW.`TribeAuthor`), '');
  SET NEW.`SubtribeAuthor`    = COALESCE(TRIM(NEW.`SubtribeAuthor`), '');
  SET NEW.`GenusAuthor`       = COALESCE(TRIM(NEW.`GenusAuthor`), '');
  SET NEW.`SubgenusAuthor`    = COALESCE(TRIM(NEW.`SubgenusAuthor`), '');
  SET NEW.`SpeciesAuthor`     = COALESCE(TRIM(NEW.`SpeciesAuthor`), '');
  SET NEW.`SubspeciesAuthor`  = COALESCE(TRIM(NEW.`SubspeciesAuthor`), '');
  SET NEW.`VariationAuthor`   = COALESCE(TRIM(NEW.`VariationAuthor`), '');
END

GO


/******************************************************************************/
/* functions                                                                  */
/******************************************************************************/

-- returns the id for a collection name

DROP FUNCTION IF EXISTS `f_getCollectionID`;

GO

CREATE FUNCTION `f_getCollectionID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `CollectionID`
            FROM svar_destdb_.`collection`
           WHERE (`Code` = $collname));

GO

-- returns the discipline id for a specify collection

DROP FUNCTION IF EXISTS `f_getDisciplineID`;

GO

CREATE FUNCTION `f_getDisciplineID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `DisciplineID`
            FROM svar_destdb_.`collection`
           WHERE (`Code` = $collname));

GO

-- returns the division id for a specify collection

DROP FUNCTION IF EXISTS `f_getDivisionID`;

GO

CREATE FUNCTION `f_getDivisionID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `DivisionID`
            FROM svar_destdb_.`collection`            T1
                 INNER JOIN svar_destdb_.`discipline` T2 ON (T1.`DisciplineID` = T2.`DisciplineID`)
           WHERE (`Code` = $collname));

GO

-- returns the division id for a specify collection id

DROP FUNCTION IF EXISTS `f_getDivisionIDByCollectionID`;

GO

CREATE FUNCTION `f_getDivisionIDByCollectionID`($collectionid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `DivisionID`
            FROM svar_destdb_.`collection`            T1
                 INNER JOIN svar_destdb_.`discipline` T2 ON (T1.`DisciplineID` = T2.`DisciplineID`)
           WHERE (`CollectionID` = $collectionid));

GO

-- returns the GeologicTimePeriodTreeDefID for a specify collection

DROP FUNCTION IF EXISTS `f_getGeologicTimePeriodTreeDefID`;

GO

CREATE FUNCTION `f_getGeologicTimePeriodTreeDefID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT D.`GeologicTimePeriodTreeDefID`
            FROM svar_destdb_.`collection`            C
                 INNER JOIN svar_destdb_.`discipline` D ON (C.`DisciplineID` = D.`DisciplineID`)
           WHERE (C.`Code` = $collname));

GO

--

DROP FUNCTION IF EXISTS `f_getGeologicTimePeriodTreeDefItemID`;

GO

CREATE FUNCTION `f_getGeologicTimePeriodTreeDefItemID`($treedefid INT, $rankid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `GeologicTimePeriodTreeDefItemID`
            FROM svar_destdb_.`geologictimeperiodtreedefitem`
           WHERE (`GeologicTimePeriodTreeDefID` = $treedefid)
             AND (`RankID`                      = $rankid));

GO

--

DROP FUNCTION IF EXISTS `f_getGeologicTimePeriodTreeDefItemIsEnforced`;

GO

CREATE FUNCTION `f_getGeologicTimePeriodTreeDefItemIsEnforced`($treedefid INT, $rankid INT) 
  RETURNS BIT(1)
  READS SQL DATA
  RETURN COALESCE((SELECT `IsEnforced`
                     FROM svar_destdb_.`geologictimeperiodtreedefitem`
                    WHERE (`GeologicTimePeriodTreeDefID` = $treedefid)
                      AND (`RankID`                      = $rankid)), 0);

GO

--

DROP FUNCTION IF EXISTS `f_getGeographyRootID`;

GO

CREATE FUNCTION `f_getGeographyRootID`($treedefid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `GeographyID` 
            FROM svar_destdb_.`geography` 
           WHERE (`GeographyTreeDefID` = $treedefid) 
             AND (`ParentID`           IS NULL)
             AND (`Name`               = 'Earth')
           LIMIT 0, 1);

GO

--

DROP FUNCTION IF EXISTS `f_getGeographyTreeDefID`;

GO

CREATE FUNCTION `f_getGeographyTreeDefID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT D.`GeographyTreeDefID`
            FROM svar_destdb_.`collection`            C
                 INNER JOIN svar_destdb_.`discipline` D ON (C.`DisciplineID` = D.`DisciplineID`)
           WHERE (C.`Code` = $collname));

GO

--

DROP FUNCTION IF EXISTS `f_getGeographyTreeDefItemID`;

GO

CREATE FUNCTION `f_getGeographyTreeDefItemID`($treedefid INT, $rankid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `GeographyTreeDefItemID`
            FROM svar_destdb_.`geographytreedefitem`
           WHERE (`GeographyTreeDefID` = $treedefid)
             AND (`RankID`             = $rankid));

GO

--

DROP FUNCTION IF EXISTS `f_getGeographyTreeDefItemIsEnforced`;

GO

CREATE FUNCTION `f_getGeographyTreeDefItemIsEnforced`($treedefid INT, $rankid INT) 
  RETURNS BIT(1)
  READS SQL DATA
  RETURN COALESCE((SELECT `IsEnforced`
                     FROM svar_destdb_.`geographytreedefitem`
                    WHERE (`GeographyTreeDefID` = $treedefid)
                      AND (`RankID`             = $rankid)), 0);

GO

--

DROP FUNCTION IF EXISTS `f_getReferenceWorkTypeID`;

GO

CREATE FUNCTION `f_getReferenceWorkTypeID`($itemtitle VARCHAR(64))
  RETURNS INT
  READS SQL DATA
BEGIN
  DECLARE $result INT;
  
  SET $result = (SELECT CASE TRIM($itemtitle)
                          WHEN 'Book'             THEN 0
                          WHEN 'Electronic Media' THEN 1
                          WHEN 'Paper'            THEN 2
                          WHEN 'Technical Report' THEN 3
                          WHEN 'Thesis'           THEN 4
                          WHEN 'Section in Book'  THEN 5
                          ELSE NULL
                        END);
  
  RETURN $result;
END

GO

-- 

DROP FUNCTION IF EXISTS `f_getStorageRootID`;

GO

CREATE FUNCTION `f_getStorageRootID`($treedefid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `StorageID` 
            FROM svar_destdb_.`storage` 
           WHERE (`StorageTreeDefID` = $treedefid) 
             AND (`ParentID`         IS NULL)
             AND (`Name`             = 'Site')
           LIMIT 0, 1);

GO

-- 

DROP FUNCTION IF EXISTS `f_getStorageTreeDefID`;

GO

CREATE FUNCTION `f_getStorageTreeDefID`($collname VARCHAR(128)) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT I.`StorageTreeDefID`
            FROM svar_destdb_.`collection`             C
                 INNER JOIN svar_destdb_.`discipline`  D1 ON (C.`DisciplineID`   = D1.`DisciplineID`)
                 INNER JOIN svar_destdb_.`division`    D2 ON (D1.`DivisionID`    = D2.`DivisionID`)
                 INNER JOIN svar_destdb_.`institution` I  ON (D2.`InstitutionID` = I.`InstitutionID`)
           WHERE (C.`Code` = $collname));

GO

--

DROP FUNCTION IF EXISTS `f_getStorageTreeDefItemID`;

GO

CREATE FUNCTION `f_getStorageTreeDefItemID`($treedefid INT, $rankid INT) 
  RETURNS INT
  READS SQL DATA
  RETURN (SELECT `StorageTreeDefItemID`
            FROM svar_destdb_.`storagetreedefitem`
           WHERE (`StorageTreeDefID` = $treedefid)
             AND (`RankID`           = $rankid));

GO

--

DROP FUNCTION IF EXISTS `f_getStorageTreeDefItemIsEnforced`;

GO

CREATE FUNCTION `f_getStorageTreeDefItemIsEnforced`($treedefid INT, $rankid INT) 
  RETURNS BIT(1)
  READS SQL DATA
  RETURN COALESCE((SELECT `IsEnforced`
                     FROM svar_destdb_.`storagetreedefitem`
                    WHERE (`StorageTreeDefID` = $treedefid)
                      AND (`RankID`           = $rankid)), 0);

GO

--

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

DROP FUNCTION IF EXISTS `f_getTaxonTreeDefItemIsEnforced`;

GO

CREATE FUNCTION `f_getTaxonTreeDefItemIsEnforced`($treedefid INT, $rankid INT) 
  RETURNS BIT(1)
  READS SQL DATA
  RETURN COALESCE((SELECT `IsEnforced`
                     FROM svar_destdb_.`taxontreedefitem`
                    WHERE (`TaxonTreeDefID` = $treedefid)
                      AND (`RankID`         = $rankid)), 0);

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

--

DROP FUNCTION IF EXISTS `f_appendAccessionRole`;

GO

CREATE FUNCTION `f_appendAccessionRole`($itemtitle    VARCHAR(64)
                                       ,$collectionid INT)
  RETURNS VARCHAR(64)
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $picklistid INT;
  DECLARE $result     VARCHAR(64);
  
  IF (NULLIF($itemtitle,'') IS NULL) THEN
    RETURN NULL;
  END IF;

  SET $picklistid = (SELECT `PickListID`
                       FROM svar_destdb_.`picklist`
                      WHERE `CollectionID` = $collectionid
                        AND `Name`         = 'AccessionRole');

  SET $result = (SELECT `Value` 
                   FROM svar_destdb_.`picklistitem` 
                  WHERE ((`Title` = $itemtitle) OR (`Value` = $itemtitle))
                    AND (`PickListID` = $picklistid)
                  LIMIT 0,1);

  IF  ($result     IS NULL)
  AND ($picklistid IS NOT NULL) THEN
    INSERT 
      INTO svar_destdb_.`picklistitem` 
          (
            `PicklistID`,
            `Title`,
            `Value`,
            `Ordinal`,

            `Version`,
            `TimestampCreated`,
            `TimestampModified`
          )
      VALUES 
          (
            $picklistid,
            $itemtitle,
            $itemtitle,
            0,

            1,
            NOW(),
            NOW()
          );
   
    SET $result = (SELECT `Value` 
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`Title`      = $itemtitle)
                      AND (`PickListID` = $picklistid)
                    LIMIT 0,1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendAge`;

GO

CREATE FUNCTION `f_appendAge`($itemtitle    VARCHAR(64)
                             ,$collectionid INT)
  RETURNS VARCHAR(64)
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $picklistid INT;
  DECLARE $result     VARCHAR(64);
  
  IF (NULLIF($itemtitle,'') IS NULL) THEN
    RETURN NULL;
  END IF;

  SET $picklistid = (SELECT `PickListID`
                       FROM svar_destdb_.`picklist`
                      WHERE `CollectionID` = $collectionid
                        AND `Name`         = 'Age');

  SET $result = (SELECT `Value` 
                   FROM svar_destdb_.`picklistitem` 
                  WHERE ((`Title` = $itemtitle) OR (`Value` = $itemtitle))
                    AND (`PickListID` = $picklistid)
                  LIMIT 0,1);

  IF  ($result     IS NULL)
  AND ($picklistid IS NOT NULL) THEN
    INSERT 
      INTO svar_destdb_.`picklistitem` 
          (
            `PicklistID`,
            `Title`,
            `Value`,
            `Ordinal`,

            `Version`,
            `TimestampCreated`,
            `TimestampModified`
          )
      VALUES 
          (
            $picklistid,
            $itemtitle,
            $itemtitle,
            0,

            1,
            NOW(),
            NOW()
          );
   
    SET $result = (SELECT `Value` 
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`Title`      = $itemtitle)
                      AND (`PickListID` = $picklistid)
                    LIMIT 0,1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendAgent`;

GO

CREATE FUNCTION `f_appendAgent`($lastname     VARBINARY(120)
                               ,$firstname    VARBINARY(50)
                               ,$collectionid INT)
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $divisionid INT;
  DECLARE $result     INT;
  
  SET $divisionid = `f_getDivisionIDByCollectionID`($collectionid);
  SET $lastname   = COALESCE(TRIM($lastname), '');
  SET $firstname  = COALESCE(TRIM($firstname), '');

  IF ($lastname = '') THEN
    RETURN NULL;
  END IF;

  SET $result = (SELECT `AgentID` 
                   FROM svar_destdb_.`agent` 
                  WHERE (BINARY `LastName`  = $lastname) 
                    AND (BINARY `FirstName` = $firstname)
                    AND (`DivisionID`       = $divisionid)
                    AND (`AgentType`        = 1)
                  LIMIT 0, 1);

  IF ($result IS NULL) THEN
    INSERT 
      INTO svar_destdb_.`agent` 
           (
             `LastName`,
             `Firstname`,
             `MiddleInitial`,
             `Abbreviation`,
             `AgentType`,
             `DivisionID`,

             `Version`,
             `TimestampCreated`,
             `TimestampModified`,
             `CreatedByAgentID`,
             `ModifiedByAgentID`
           )
      VALUES 
           (
             $lastname,
             $firstname,
             '',
             '',
             1,
             $divisionid,

             1,
             NOW(),
             NOW(),
             1,
             1
           );

    SET $result = (SELECT `AgentID` 
                     FROM svar_destdb_.`agent` 
                    WHERE (BINARY `LastName`  = $lastname) 
                      AND (BINARY `FirstName` = $firstname)
                      AND (`DivisionID`       = $divisionid)
                      AND (`AgentType`        = 1)
                    LIMIT 0, 1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendBiologicalSex`;

GO

CREATE FUNCTION `f_appendBiologicalSex`($itemtitle    VARCHAR(64)
                                       ,$collectionid INT)
  RETURNS VARCHAR(64)
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $picklistid INT;
  DECLARE $result     VARCHAR(64);
  
  IF (NULLIF($itemtitle,'') IS NULL) THEN
    RETURN NULL;
  END IF;

  SET $picklistid = (SELECT `PickListID`
                       FROM svar_destdb_.`picklist`
                      WHERE `CollectionID` = $collectionid
                        AND `Name`         = 'BiologicalSex');

  SET $result = (SELECT `Value` 
                   FROM svar_destdb_.`picklistitem` 
                  WHERE ((`Title` = $itemtitle) OR (`Value` = $itemtitle))
                    AND (`PickListID` = $picklistid)
                  LIMIT 0,1);

  IF  ($result     IS NULL)
  AND ($picklistid IS NOT NULL) THEN
    INSERT 
      INTO svar_destdb_.`picklistitem` 
          (
            `PicklistID`,
            `Title`,
            `Value`,
            `Ordinal`,

            `Version`,
            `TimestampCreated`,
            `TimestampModified`
          )
      VALUES 
          (
            $picklistid,
            $itemtitle,
            $itemtitle,
            0,

            1,
            NOW(),
            NOW()
          );
   
    SET $result = (SELECT `Value` 
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`Title`      = $itemtitle)
                      AND (`PickListID` = $picklistid)
                    LIMIT 0,1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendContainerType`;

GO

CREATE FUNCTION `f_appendContainerType`($itemtitle    VARCHAR(64)
                                       ,$collectionid INT)
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $itemid     INT;
  DECLARE $picklistid INT;
  DECLARE $result     INT;
  
  IF (NULLIF($itemtitle,'') IS NULL) THEN
    RETURN NULL;
  END IF;

  SET $picklistid = (SELECT `PickListID`
                       FROM svar_destdb_.`picklist`
                      WHERE `CollectionID` = $collectionid
                        AND `Name`         = 'ContainerType');

  SET $result = (SELECT `Value` 
                   FROM svar_destdb_.`picklistitem` 
                  WHERE ((`Title` = $itemtitle) OR (`Value` = $itemtitle))
                    AND (`PickListID` = $picklistid)
                  LIMIT 0,1);

  IF  ($result     IS NULL)
  AND ($picklistid IS NOT NULL) THEN
    SET $itemid = (SELECT MAX(`Value`) + 1
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`PickListID` = $picklistid));

    INSERT 
      INTO svar_destdb_.`picklistitem` 
          (
            `PicklistID`,
            `Title`,
            `Value`,
            `Ordinal`,

            `Version`,
            `TimestampCreated`,
            `TimestampModified`
          )
      VALUES 
          (
            $picklistid,
            $itemtitle,
            $itemid,
            0,

            1,
            NOW(),
            NOW()
          );
   
    SET $result = (SELECT `Value` 
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`Title`      = $itemtitle)
                      AND (`PickListID` = $picklistid)
                    LIMIT 0,1);
  END IF;
  
  RETURN $result;
END

GO

DROP FUNCTION IF EXISTS `f_appendGeologicTimePeriod`;

GO

CREATE FUNCTION `f_appendGeologicTimePeriod`($treedefid INT
                                            ,$parentid  INT
                                            ,$rankid    INT
                                            ,$name      VARCHAR(64))
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $result        INT;
  DECLARE $treedefitemid INT;
  
  SET $name          = COALESCE(NULLIF(TRIM($name),''),'?');
  SET $treedefitemid = `f_getGeologicTimePeriodTreeDefItemID`($treedefid,$rankid);

  IF ($treedefitemid IS NULL)
  OR (($name = '?') AND (`f_getGeologicTimePeriodTreeDefItemIsEnforced`($treedefid,$rankid) = 0)) THEN 
    RETURN $parentid;
  END IF;

  SET $result = (SELECT `GeologicTimePeriodID` 
                   FROM svar_destdb_.`geologictimeperiod` 
                  WHERE (`GeologicTimePeriodTreeDefID` = $treedefid) 
                    AND (`ParentID`                    = $parentid)
                    AND (`Name`                        = $name)
                    AND (`RankID`                      = $rankid)
                  LIMIT 0,1);

  IF ($result IS NULL) THEN
    INSERT 
      INTO svar_destdb_.`geologictimeperiod` 
          (
            `RankID`,
            `ParentID`,
            `Fullname`,
            `Name`,
            `Version`,
            `GeologicTimePeriodTreeDefID`,
            `GeologicTimePeriodTreeDefItemID`,
            `IsAccepted`,
            `TimestampCreated`,
            `TimestampModified`,
            `CreatedByAgentID`,
            `ModifiedByAgentID`
          )
      VALUES 
          (
            $rankid,
            $parentid,
            $name,
            $name,
            1,
            $treedefid,
            $treedefitemid,
            0,
            NOW(),
            NOW(),
            1,
            1
          );

      SET $result = (SELECT `GeologicTimePeriodID` 
                       FROM svar_destdb_.`geologictimeperiod` 
                      WHERE (`GeologicTimePeriodTreeDefID` = $treedefid) 
                        AND (`ParentID`                    = $parentid)
                        AND (`Name`                        = $name)
                        AND (`RankID`                      = $rankid)
                      LIMIT 0,1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendGeography`;

GO

CREATE FUNCTION `f_appendGeography`($treedefid INT
                                   ,$parentid  INT
                                   ,$rankid    INT
                                   ,$name      VARCHAR(64))
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $result        INT;
  DECLARE $treedefitemid INT;
  
  SET $name          = COALESCE(NULLIF(TRIM($name), ''), '?');
  SET $treedefitemid = `f_getGeographyTreeDefItemID`($treedefid, $rankid);

  IF ($treedefitemid IS NULL)
  OR (($name = '?') AND (`f_getGeographyTreeDefItemIsEnforced`($treedefid, $rankid) = 0)) THEN 
    RETURN $parentid;
  END IF;

  SET $result = (SELECT `GeographyID` 
                   FROM svar_destdb_.`geography` 
                  WHERE (`GeographyTreeDefID` = $treedefid) 
                    AND (`ParentID`           = $parentid)
                    AND (`Name`               = $name)
                    AND (`RankID`             = $rankid)
                  LIMIT 0, 1);

  IF ($result IS NULL) THEN
    INSERT 
      INTO svar_destdb_.`geography` 
          (
            `RankID`,
            `ParentID`,
            `Fullname`,
            `Name`,
            `Version`,
            `GeographyTreeDefID`,
            `GeographyTreeDefItemID`,
            `IsAccepted`,
            `IsCurrent`,
            `TimestampCreated`,
            `TimestampModified`,
            `CreatedByAgentID`,
            `ModifiedByAgentID`
          )
      VALUES 
          (
            $rankid,
            $parentid,
            $name,
            $name,
            1,
            $treedefid,
            $treedefitemid,
            1,
            0,
            NOW(),
            NOW(),
            1,
            1
          );

      SET $result = (SELECT `GeographyID` 
                       FROM svar_destdb_.`geography` 
                      WHERE (`GeographyTreeDefID` = $treedefid) 
                        AND (`ParentID`           = $parentid)
                        AND (`Name`               = $name)
                        AND (`RankID`             = $rankid)
                      LIMIT 0, 1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendJournal`;

GO

CREATE FUNCTION `f_appendJournal`($journalname  VARCHAR(255)
                                 ,$abbreviation VARCHAR(50))
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $result INT;
  
  SET $journalname  = COALESCE(TRIM($journalname), '');
  SET $abbreviation = COALESCE(TRIM($abbreviation), '');

  IF ($journalname <> '') THEN
    SET $result = (SELECT `JournalID` 
                     FROM svar_destdb_.`journal` 
                    WHERE (`JournalName`  = $journalname) 
                    LIMIT 0, 1);

    IF ($result IS NULL) THEN
      INSERT 
        INTO svar_destdb_.`journal` 
            (
              `JournalName`,
              `JournalAbbreviation`,

              `Version`,
              `TimestampCreated`,
              `TimestampModified`,
              `CreatedByAgentID`,
              `ModifiedByAgentID`
            )
        VALUES 
            (
              $journalname,
              $abbreviation,

              1,
              NOW(),
              NOW(),
              1,
              1
            );
   
      SET $result = (SELECT `JournalID` 
                       FROM svar_destdb_.`journal` 
                      WHERE (`JournalName`  = $journalname) 
                      LIMIT 0, 1);
    END IF;
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendPrepType`;

GO

CREATE FUNCTION `f_appendPrepType`($preptypename VARCHAR(64)
                                  ,$collectionid INT)
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $result INT;
  
  SET $preptypename = COALESCE(TRIM($preptypename), '');

  IF ($preptypename <> '') THEN
    SET $result = (SELECT `PrepTypeID` 
                     FROM svar_destdb_.`preptype` 
                    WHERE (`name`         = $preptypename) 
                      AND (`CollectionID` = $collectionid)
                    LIMIT 0, 1);


    IF ($result IS NULL) THEN
      INSERT 
        INTO svar_destdb_.`preptype` 
            (
              `CollectionID`,
              `Name`,
              `IsLoanable`,

              `Version`,
              `TimestampCreated`,
              `TimestampModified`,
              `CreatedByAgentID`,
              `ModifiedByAgentID`
            )
        VALUES 
            (
              $collectionid,
              $preptypename,
              1,

              1,
              NOW(),
              NOW(),
              1,
              1
            );
   

      SET $result = (SELECT `PrepTypeID` 
                       FROM svar_destdb_.`preptype` 
                      WHERE (`name`         = $preptypename) 
                        AND (`CollectionID` = $collectionid)
                      LIMIT 0, 1);
    END IF;
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendStorage`;

GO 

CREATE FUNCTION `f_appendStorage`($treedefid INT
                                 ,$parentid  INT
                                 ,$rankid    INT
                                 ,$name      VARCHAR(64))
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $result        INT;
  DECLARE $treedefitemid INT;
  
  SET $name          = COALESCE(NULLIF(TRIM($name), ''), '?');
  SET $treedefitemid = `f_getStorageTreeDefItemID`($treedefid,$rankid);

  IF ($treedefitemid IS NULL)
  OR (($name = '?') AND (`f_getStorageTreeDefItemIsEnforced`($treedefid, $rankid) = 0)) THEN 
    RETURN $parentid;
  END IF;

  SET $result = (SELECT `StorageID` 
                   FROM svar_destdb_.`storage` 
                  WHERE (`StorageTreeDefID` = $treedefid) 
                    AND (`ParentID`         = $parentid)
                    AND (`Name`             = $name)
                    AND (`RankID`           = $rankid)
                  LIMIT 0,1);

  IF ($result IS NULL) THEN
    INSERT 
      INTO svar_destdb_.`storage` 
          (
            `RankID`,
            `ParentID`,
            `Fullname`,
            `Name`,
            `Version`,
            `StorageTreeDefID`,
            `StorageTreeDefItemID`,
            `IsAccepted`,
            `TimestampCreated`,
            `TimestampModified`,
            `CreatedByAgentID`,
            `ModifiedByAgentID`
          )
      VALUES 
          (
            $rankid,
            $parentid,
            $name,
            $name,
            1,
            $treedefid,
            $treedefitemid,
            1,
            NOW(),
            NOW(),
            1,
            1
          );

      SET $result = (SELECT `StorageID` 
                       FROM svar_destdb_.`storage` 
                      WHERE (`StorageTreeDefID` = $treedefid) 
                        AND (`ParentID`         = $parentid)
                        AND (`Name`             = $name)
                        AND (`RankID`           = $rankid)
                      LIMIT 0, 1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendTaxon`;

GO 

CREATE FUNCTION `f_appendTaxon`($treedefid INT
                               ,$parentid  INT
                               ,$rankid    INT
                               ,$taxon     VARCHAR(128)
                               ,$author    VARCHAR(128))
  RETURNS INT
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $result        INT;
  DECLARE $treedefitemid INT;
  
  SET $taxon         = COALESCE(NULLIF(TRIM($taxon), ''), '?');
  SET $author        = COALESCE(NULLIF(TRIM($author), ''), '');
  SET $treedefitemid = `f_getTaxonTreeDefItemID`($treedefid, $rankid);

  IF ($treedefitemid IS NULL)
  OR (($taxon = '?') AND (`f_getTaxonTreeDefItemIsEnforced`($treedefid, $rankid) = 0)) THEN 
    RETURN $parentid;
  END IF;

  IF ($author = '') THEN
    SET $result = (SELECT `taxonid` 
                     FROM svar_destdb_.`taxon` 
                    WHERE (`TaxonTreeDefID` = $treedefid) 
                      AND (`ParentID`       = $parentid)
                      AND (`Name`           = $taxon)
                      AND (`RankID`         = $rankid)
                    LIMIT 0,1);
  ELSE
    SET $result = (SELECT `taxonid` 
                     FROM svar_destdb_.`taxon` 
                    WHERE (`TaxonTreeDefID` = $treedefid) 
                      AND (`ParentID`       = $parentid)
                      AND (`Name`           = $taxon)
                      AND (`Author`         = $author)
                      AND (`RankID`         = $rankid)
                    LIMIT 0, 1);
  END IF;

  IF ($result IS NULL) THEN
    INSERT 
      INTO svar_destdb_.`taxon` 
          (
            `RankID`,
            `ParentID`,
            `Fullname`,
            `Name`,
            `Author`,
            `Version`,
            `TaxonTreeDefID`,
            `TaxonTreeDefItemID`,
            `IsAccepted`,
            `IsHybrid`,
            `TimestampCreated`,
            `TimestampModified`,
            `CreatedByAgentID`,
            `ModifiedByAgentID`
          )
      VALUES 
          (
            $rankid,
            $parentid,
            $taxon,
            $taxon,
            $author,
            1,
            $treedefid,
            $treedefitemid,
            1,
            0,
            NOW(),
            NOW(),
            1,
            1
          );

      SET $result = (SELECT `taxonid` 
                       FROM svar_destdb_.`taxon` 
                      WHERE (`TaxonTreeDefID` = $treedefid) 
                        AND (`ParentID`       = $parentid)
                        AND (`Name`           = $taxon)
                        AND (`Author`         = $author)
                        AND (`RankID`         = $rankid)
                      LIMIT 0, 1);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_appendAgentTitle`;

GO

CREATE FUNCTION `f_appendAgentTitle`($itemtitle    VARCHAR(64)
                                    ,$collectionid INT)
  RETURNS VARCHAR(64)
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $picklistid INT;
  DECLARE $result     VARCHAR(64);
  
  IF (NULLIF($itemtitle, '') IS NULL) THEN
    RETURN NULL;
  END IF;

  SET $picklistid = (SELECT `PickListID`
                       FROM svar_destdb_.`picklist`
                      WHERE `CollectionID` = $collectionid
                        AND `Name`         = 'AgentTitles');

  SET $itemtitle = COALESCE(TRIM($itemtitle),'');

  SET $result = (SELECT `Value` 
                   FROM svar_destdb_.`picklistitem` 
                  WHERE ((`Title` = $itemtitle) OR (`Value` = $itemtitle))
                    AND (`PickListID` = $picklistid)
                  LIMIT 0, 1);

  IF  ($result     IS NULL)
  AND ($picklistid IS NOT NULL) THEN
    INSERT 
      INTO svar_destdb_.`picklistitem` 
           (
             `PicklistID`,
             `Title`,
             `Value`,
             `Ordinal`,

             `Version`,
             `TimestampCreated`,
             `TimestampModified`
           )
           SELECT `PickListID`
                  $itemtitle,
                  $itemtitle,
                  0,

                  1,
                  NOW(),
                  NOW()
             FROM svar_destdb_.`picklist`
            WHERE (`Name` = 'AgentTitles')
              AND (`PickListID` NOT IN (SELECT DISTINCT `PickListID`
                                          FROM svar_destdb_.`picklist` T1
                                               INNER JOIN svar_destdb_.`picklistitem` T2 ON (T1.`PickListID` = T2.`PickListID`)
                                         WHERE (T1.`CollectionID` = $collectionid)
                                           AND (T1.`Name`         = 'AgentTitles')
                                           AND ((T2.`Title` = $itemtitle) OR (T2.`Value` = $itemtitle))));
   
    SET $result = (SELECT `Value` 
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`Title`      = $itemtitle)
                      AND (`PickListID` = $picklistid)
                    LIMIT 0, 1);
  END IF;
  
  RETURN $result;
END

GO

DROP FUNCTION IF EXISTS `f_appendTypeStatus`;

GO

CREATE FUNCTION `f_appendTypeStatus`($typestatusname VARCHAR(64)
                                    ,$collectionid   INT)
  RETURNS VARCHAR(64)
  MODIFIES SQL DATA
  READS SQL DATA
BEGIN
  DECLARE $picklistid INT;
  DECLARE $result     VARCHAR(64);
  
  IF (NULLIF($typestatusname, '') IS NULL) 
  OR ($typestatusname = 'none') THEN
    RETURN NULL;
  END IF;

  SET $picklistid = (SELECT `PickListID`
                       FROM svar_destdb_.`picklist`
                      WHERE `CollectionID` = $collectionid
                        AND `Name`         = 'TypeStatus');

  SET $result = (SELECT `Value` 
                   FROM svar_destdb_.`picklistitem` 
                  WHERE ((`Title` = $typestatusname) OR (`Value` = $typestatusname))
                    AND (`PickListID` = $picklistid)
                  LIMIT 0, 1);

  IF  ($result     IS NULL)
  AND ($picklistid IS NOT NULL) THEN
    INSERT 
      INTO svar_destdb_.`picklistitem` 
          (
            `PicklistID`,
            `Title`,
            `Value`,
            `Ordinal`,

            `Version`,
            `TimestampCreated`,
            `TimestampModified`
          )
      VALUES 
          (
            $picklistid,
            $typestatusname,
            $typestatusname,
            0,

            1,
            NOW(),
            NOW()
          );
   
    SET $result = (SELECT `Value` 
                     FROM svar_destdb_.`picklistitem` 
                    WHERE (`Title`      = $typestatusname)
                      AND (`PickListID` = $picklistid)
                    LIMIT 0, 1);
  END IF;
  
  RETURN $result;
END

GO

DROP FUNCTION IF EXISTS `f_getDate`;

GO

CREATE FUNCTION `f_getDate`($yearvalue  INT
                           ,$monthvalue INT
                           ,$datevalue  DATE) 
  RETURNS DATE
  DETERMINISTIC
BEGIN
  -- DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  -- DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;

  IF ($yearvalue IS NOT NULL) THEN
    IF ($monthvalue IS NOT NULL) THEN
      RETURN CONCAT(CAST($yearvalue AS CHAR),N'-',CAST($monthvalue AS CHAR),N'-01');
    ELSE
      RETURN CONCAT(CAST($yearvalue AS CHAR),N'-01-01');
    END IF;
  ELSE
    RETURN $datevalue;
  END IF;
  
  RETURN NULL;
END

GO

--

DROP FUNCTION IF EXISTS `f_getDatePrecision`;

GO

CREATE FUNCTION `f_getDatePrecision`($yearvalue  INT
                                    ,$monthvalue INT
                                    ,$datevalue  DATE) 
  RETURNS INT
  DETERMINISTIC
BEGIN
  -- DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  -- DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;

  IF ($yearvalue IS NOT NULL) THEN
    IF ($monthvalue IS NOT NULL) THEN
      RETURN 2;
    ELSE
      RETURN 3;
    END IF;
  END IF;
  
  RETURN 1;
END

GO

--

DROP FUNCTION IF EXISTS `f_lat_dms2dd`;

GO

CREATE FUNCTION `f_lat_dms2dd`($value VARCHAR(50))
  RETURNS DECIMAL(12, 10)
  DETERMINISTIC
BEGIN
  DECLARE $cutpos1 INT;
  DECLARE $cutpos2 INT;
  DECLARE $cutpos3 INT;
  DECLARE $degrees INT;
  DECLARE $minutes DECIMAL(20, 10);
  DECLARE $seconds DECIMAL(20, 10);
  DECLARE $result  DECIMAL(13, 10);
  DECLARE $direction NVARCHAR(1);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;

  SET $value     = REPLACE(TRIM($value), ',', '.');
  SET $direction = SUBSTRING($value,CHAR_LENGTH($value), 1);

  IF ($direction IN ('N', 'S')) THEN
    SET $value = SUBSTRING($value, 1, CHAR_LENGTH($value) - 1);

    IF ($direction = 'S') THEN
      SET $value = CONCAT('-', $value);
    END IF;
  END IF;

  SET $cutpos1 = LOCATE(N'°', $value);
  SET $cutpos2 = LOCATE(N'''', $value);
  SET $cutpos3 = LOCATE(N'"', $value);

  IF ($cutpos2 = 0) THEN
    SET $value   = CONCAT($value, '''');
    SET $cutpos2 = LOCATE('''', $value);
  END IF;

  IF ($cutpos3 = 0) THEN
    SET $value   = CONCAT($value, '"');
    SET $cutpos3 = LOCATE('"', $value);
  END IF;

  IF ($cutpos1 > 0) THEN
    SET $degrees = SUBSTRING($value, 1, $cutpos1 - 1);

    IF (($degrees < -90) OR ($result > 90)) THEN
      RETURN NULL;
    END IF;

    SET $minutes = COALESCE(NULLIF(SUBSTRING($value, $cutpos1 + 1, $cutpos2 - $cutpos1 - 1), ''), 0);
    SET $minutes = ($minutes * 360000) / 21600000;

    IF (($minutes < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    SET $seconds = COALESCE(NULLIF(SUBSTRING($value, $cutpos2 + 1, $cutpos3 - $cutpos2 - 1), ''), 0);
    SET $seconds = ($seconds * 6000) / 21600000;

    IF (($seconds < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    IF ($degrees < 0) THEN
      SET $minutes = -$minutes;
      SET $seconds = -$seconds;
    END IF;

    SET $result = $degrees + $minutes + $seconds;
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_long_dms2dd`;

GO

CREATE FUNCTION `f_long_dms2dd`($value VARCHAR(50))
  RETURNS DECIMAL(13, 10)
  DETERMINISTIC
BEGIN
  DECLARE $cutpos1 INT;
  DECLARE $cutpos2 INT;
  DECLARE $cutpos3 INT;
  DECLARE $degrees INT;
  DECLARE $minutes DECIMAL(20, 10);
  DECLARE $seconds DECIMAL(20, 10);
  DECLARE $result  DECIMAL(13, 10);
  DECLARE $direction NVARCHAR(1);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;

  SET $value     = REPLACE(TRIM($value), ',', '.');
  SET $direction = SUBSTRING($value, CHAR_LENGTH($value), 1);

  IF ($direction IN ('W', 'E', 'O')) THEN
    SET $value = SUBSTRING($value, 1, CHAR_LENGTH($value) - 1);

    IF ($direction = 'W') THEN
      SET $value = CONCAT('-', $value);
    END IF;
  END IF;

  SET $cutpos1 = LOCATE(N'°', $value);
  SET $cutpos2 = LOCATE(N'''', $value);
  SET $cutpos3 = LOCATE(N'"', $value);

  IF ($cutpos2 = 0) THEN
    SET $value   = CONCAT($value, '''');
    SET $cutpos2 = LOCATE('''', $value);
  END IF;

  IF ($cutpos3 = 0) THEN
    SET $value   = CONCAT($value, '"');
    SET $cutpos3 = LOCATE('"', $value);
  END IF;

  IF ($cutpos1 > 0) THEN
    SET $degrees = SUBSTRING($value, 1, $cutpos1 - 1);

    IF (($degrees < -180) OR ($result > 180)) THEN
      RETURN NULL;
    END IF;

    SET $minutes = COALESCE(NULLIF(SUBSTRING($value, $cutpos1 + 1, $cutpos2 - $cutpos1 - 1), ''), 0);
    SET $minutes = ($minutes * 360000) / 21600000;

    IF (($minutes < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    SET $seconds = COALESCE(NULLIF(SUBSTRING($value, $cutpos2 + 1, $cutpos3 - $cutpos2 - 1), ''), 0);
    SET $seconds = ($seconds * 6000) / 21600000;

    IF (($seconds < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    IF ($degrees < 0) THEN
      SET $minutes = -$minutes;
      SET $seconds = -$seconds;
    END IF;

    SET $result = $degrees + $minutes + $seconds;
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_lat_dms2text`;

GO

CREATE FUNCTION `f_lat_dms2text`($value VARCHAR(50))
  RETURNS NVARCHAR(50)
  DETERMINISTIC
BEGIN
  DECLARE $cutpos1   INT;
  DECLARE $cutpos2   INT;
  DECLARE $cutpos3   INT;
  DECLARE $degrees   INT;
  DECLARE $minutes   INT;
  DECLARE $seconds   NVARCHAR(16);
  DECLARE $result    NVARCHAR(50);
  DECLARE $direction NVARCHAR(1);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;

  SET $value     = REPLACE(TRIM($value), ',', '.');
  SET $direction = SUBSTRING($value, CHAR_LENGTH($value),1);

  IF ($direction IN ('N','S')) THEN
    SET $value = SUBSTRING($value, 1, CHAR_LENGTH($value) - 1);

    IF ($direction = 'S') THEN
      SET $value = CONCAT('-', $value);
    END IF;
  END IF;

  SET $cutpos1 = LOCATE(N'°', $value);
  SET $cutpos2 = LOCATE(N'''', $value);
  SET $cutpos3 = LOCATE(N'"', $value);

  IF ($cutpos2 = 0) THEN
    SET $value   = CONCAT($value, '''');
    SET $cutpos2 = LOCATE('''', $value);
  END IF;

  IF ($cutpos3 = 0) THEN
    SET $value   = CONCAT($value, '"');
    SET $cutpos3 = LOCATE('"', $value);
  END IF;

  IF ($cutpos1 > 0) THEN
    SET $degrees = SUBSTRING($value, 1, $cutpos1 - 1);

    IF (($result < -90) OR ($result > 90)) THEN
      RETURN NULL;
    END IF;

    SET $minutes = NULLIF(TRIM(SUBSTRING($value, $cutpos1 + 1, $cutpos2 - $cutpos1 - 1)), '');

    IF (($minutes < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    SET $seconds = NULLIF(TRIM(SUBSTRING($value, $cutpos2 + 1, $cutpos3 - $cutpos2 - 1)), '');

    IF (($seconds < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    IF ($degrees < 0) THEN
      SET $direction = 'S';
    ELSE
      SET $direction = 'N';
    END IF;

    SET $degrees = ABS($degrees);
    SET $result  = CONCAT($degrees, '° '
                         ,COALESCE(CONCAT($minutes, '\' '), '')
                         ,COALESCE(CONCAT(LEFT($seconds, 6), '" '), '')
                         ,$direction);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_long_dms2text`;

GO

CREATE FUNCTION `f_long_dms2text`($value VARCHAR(50))
  RETURNS NVARCHAR(50)
  DETERMINISTIC
BEGIN
  DECLARE $cutpos1   INT;
  DECLARE $cutpos2   INT;
  DECLARE $cutpos3   INT;
  DECLARE $degrees   INT;
  DECLARE $minutes   INT;
  DECLARE $seconds   NVARCHAR(16);
  DECLARE $result    NVARCHAR(50);
  DECLARE $direction NVARCHAR(1);

  DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;

  SET $value     = REPLACE(TRIM($value), ',', '.');
  SET $direction = SUBSTRING($value,CHAR_LENGTH($value), 1);

  IF ($direction IN ('W', 'E', 'O')) THEN
    SET $value = SUBSTRING($value, 1, CHAR_LENGTH($value) - 1);

    IF ($direction = 'W') THEN
      SET $value = CONCAT('-', $value);
    END IF;
  END IF;

  SET $cutpos1 = LOCATE(N'°', $value);
  SET $cutpos2 = LOCATE(N'''', $value);
  SET $cutpos3 = LOCATE(N'"', $value);

  IF ($cutpos2 = 0) THEN
    SET $value   = CONCAT($value, '''');
    SET $cutpos2 = LOCATE('''', $value);
  END IF;

  IF ($cutpos3 = 0) THEN
    SET $value   = CONCAT($value, '"');
    SET $cutpos3 = LOCATE('"', $value);
  END IF;

  IF ($cutpos1 > 0) THEN
    SET $degrees = SUBSTRING($value, 1, $cutpos1 - 1);

    IF (($result < -180) OR ($result > 180)) THEN
      RETURN NULL;
    END IF;

    SET $minutes = NULLIF(TRIM(SUBSTRING($value, $cutpos1 + 1, $cutpos2 - $cutpos1 - 1)), '');

    IF (($minutes < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    SET $seconds = NULLIF(TRIM(SUBSTRING($value, $cutpos2 + 1, $cutpos3 - $cutpos2 - 1)), '');

    IF (($seconds < -59) OR ($result > 59)) THEN
      RETURN NULL;
    END IF;

    IF ($degrees < 0) THEN
      SET $direction = 'W';
    ELSE
      SET $direction = 'E';
    END IF;

    SET $degrees = ABS($degrees);
    SET $result  = CONCAT($degrees, '° '
                         ,COALESCE(CONCAT($minutes, '\' '), '')
                         ,COALESCE(CONCAT(LEFT($seconds, 6), '" '), '')
                         ,$direction);
  END IF;
  
  RETURN $result;
END

GO

--

DROP FUNCTION IF EXISTS `f_lat_dd2text`;

GO

CREATE FUNCTION `f_lat_dd2text`($value DECIMAL(20, 10)) 
  RETURNS NVARCHAR(13) 
  DETERMINISTIC 
  RETURN CONCAT(LEFT(CAST(ABS($value) AS DECIMAL(9, 7)), 10),'° ',CASE WHEN ($value < 0) THEN 'S' ELSE 'N' END); 

GO

--

DROP FUNCTION IF EXISTS `f_long_dd2text`;

GO

CREATE FUNCTION `f_long_dd2text`($value DECIMAL(20, 10)) 
  RETURNS NVARCHAR(13) 
  DETERMINISTIC 
  RETURN CONCAT(LEFT(CAST(ABS($value) AS DECIMAL(9, 6)), 10),'° ',CASE WHEN ($value < 0) THEN 'W' ELSE 'E' END); 

GO

--

DROP FUNCTION IF EXISTS `f_appendString`;

GO

CREATE FUNCTION `f_appendString`($value1 VARCHAR(255)
                               , $value2 VARCHAR(255))
  RETURNS VARCHAR(255)
  DETERMINISTIC
BEGIN
  IF (NULLIF($value1, '') IS NULL)
  OR (NULLIF($value2, '') IS NULL) THEN
    RETURN CONCAT(COALESCE($value1, ''), COALESCE($value2, ''));
  ELSE
    RETURN CONCAT($value1, ', ', $value2);
  END IF;
END

GO

/******************************************************************************/
/* procedures                                                                 */
/******************************************************************************/

--

DROP PROCEDURE IF EXISTS `p_ImportInit`;

GO

CREATE PROCEDURE `p_ImportInit`()
BEGIN
  DROP TABLE IF EXISTS `tmp_steps`;
  CREATE TABLE IF NOT EXISTS `tmp_steps`
  (
    `Object`    VARCHAR(128),
    `StepID`    DOUBLE,
    `Timestamp` DATETIME,

    PRIMARY KEY (`Object`,`StepID`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('init',0,NOW());

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'agent')
                    AND (index_name = 'ix_importagentappend'))) THEN
    CREATE INDEX ix_importagentappend ON svar_destdb_.`agent` (`LastName`, `FirstName`, `DivisionID`, `AgentType`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'determination')
                    AND (index_name = 'ix_importdeterminationtempguid'))) THEN
    CREATE INDEX ix_importdeterminationtempguid ON svar_destdb_.`determination` (`Method`, `DeterminationID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'collectingevent')
                    AND (index_name = 'ix_importcollectingeventtempguid'))) THEN
    CREATE INDEX ix_importcollectingeventtempguid ON svar_destdb_.`collectingevent` (`Method`, `CollectingEventID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'locality')
                    AND (index_name = 'ix_importlocalitytempguid'))) THEN
    CREATE INDEX ix_importlocalitytempguid ON svar_destdb_.`locality` (`GUID`, `LocalityID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'paleocontext')
                    AND (index_name = 'ix_importpaleocontexttempguid'))) THEN
    CREATE INDEX ix_importpaleocontexttempguid ON svar_destdb_.`paleocontext` (`Text2`, `PaleoContextID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'preparation')
                    AND (index_name = 'ix_importpreparationtempguid'))) THEN
    CREATE INDEX ix_importpreparationtempguid ON svar_destdb_.`preparation` (`StorageLocation`, `PreparationID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'collectionobjectattribute')
                    AND (index_name = 'ix_importcollectionobjectattributetempguid'))) THEN
    CREATE INDEX ix_importcollectionobjectattributetempguid ON svar_destdb_.`collectionobjectattribute` (`Text14`, `CollectionObjectAttributeID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'taxon')
                    AND (index_name = 'ix_importtaxon'))) THEN
    CREATE INDEX ix_importtaxon ON svar_destdb_.`taxon` (`TaxonTreeDefID`, `ParentID`, `RankID`, `Name`, `Author`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'collectionobjectcitation')
                    AND (index_name = 'ix_importcollectionobjectcitationguid'))) THEN
    CREATE INDEX ix_importcollectionobjectcitationguid ON svar_destdb_.`collectionobjectcitation` (`Remarks`(36), `CollectionObjectCitationID`);
  END IF;

  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'referencework')
                    AND (index_name = 'ix_importreferenceworkkey'))) THEN
    CREATE INDEX ix_importreferenceworkkey ON svar_destdb_.`referencework` (`ReferenceWorkType`, `Title`, `Publisher`, `PlaceOfPublication`, `WorkDate`, `Volume`, `Pages`, `JournalID`, `ContainedRFParentID`);
  END IF;


  INSERT INTO `tmp_steps` VALUES ('init',1,NOW());


  DROP TABLE IF EXISTS `tmp_collection`;
  CREATE TABLE IF NOT EXISTS `tmp_collection`
  (
    `specifycollcode`    VARCHAR(128),
    `CollectionID`       INT,
    `DisciplineID`       INT,
    `DivisionID`         INT,
    `TaxonTreeDefID`     INT,
    `TaxonRootID`        INT,
    `GeographyTreeDefID` INT,
    `GeographyRootID`    INT,
    `StorageTreeDefID`   INT,
    `StorageRootID`      INT,

    PRIMARY KEY (`specifycollcode`),
    KEY (`CollectionID`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('init',2,NOW());


  DROP TABLE IF EXISTS `tmp_agent`;
  CREATE TABLE IF NOT EXISTS `tmp_agent`
  (
    `CollectionID` INT            NOT NULL,
    `LastName`     VARBINARY(120) NOT NULL,
    `FirstName`    VARBINARY(50)  NOT NULL,
    `AgentID`      INT,

    PRIMARY KEY (`CollectionID`, `LastName`, `FirstName`),
    KEY (`AgentID`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('init',3,NOW());


  DROP TABLE IF EXISTS `tmp_typestatus`;
  CREATE TABLE IF NOT EXISTS `tmp_typestatus`
  (
    `CollectionID`    INT,
    `TypeStatusName`  VARCHAR(64),
    `TypeStatusValue` VARCHAR(64),

    PRIMARY KEY (`CollectionID`, `TypeStatusName`),
    KEY (`TypeStatusValue`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('init',4,NOW());


  DROP TABLE IF EXISTS `tmp_taxon`;
  CREATE TABLE IF NOT EXISTS `tmp_taxon`
  (
    `TaxonTreeDefID` INT,
    `ParentID`       INT,
    `RankID`         INT,
    `Name`           VARCHAR(64),
    `Author`         VARCHAR(128),
    `TaxonID`        INT,
    `SpecifyName`    VARCHAR(64),

    PRIMARY KEY (`TaxonTreeDefID`, `ParentID`, `RankID`, `Name`, `Author`),
    KEY (`ParentID`, `Name`, `Author`),
    KEY (`ParentID`),
    KEY (`TaxonID`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('init',5,NOW());


  DROP TABLE IF EXISTS `tmp_geography`;
  CREATE TABLE IF NOT EXISTS `tmp_geography`
  (
    `GeographyTreeDefID` INT,
    `ParentID`           INT,
    `RankID`             INT,
    `Name`               VARCHAR(64),
    `GeographyID`        INT, 
    `SpecifyName`        VARCHAR(64),

    PRIMARY KEY (`GeographyTreeDefID`, `ParentID`, `RankID`, `Name`),
    KEY (`ParentID`, `RankID`, `Name`),
    KEY (`ParentID`),
    KEY (`GeographyID`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('init',6,NOW());


  DROP TABLE IF EXISTS `tmp_storage`;
  CREATE TABLE IF NOT EXISTS `tmp_storage`
  (
    `StorageTreeDefID` INT,
    `ParentID`         INT,
    `RankID`           INT,
    `Name`             VARCHAR(64),
    `StorageID`        INT, 
    `SpecifyName`      VARCHAR(64),

    PRIMARY KEY (`StorageTreeDefID`, `ParentID`, `RankID`, `Name`),
    KEY (`ParentID`, `RankID`, `Name`),
    KEY (`ParentID`),
    KEY (`StorageID`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('init',7,NOW());


  DROP TABLE IF EXISTS `tmp_biologicalsex`;
  CREATE TABLE IF NOT EXISTS `tmp_biologicalsex`
  (
    `CollectionID` INT,
    `Name`         VARCHAR(64),
    `Value`        VARCHAR(64),

    PRIMARY KEY (`CollectionID`, `Name`),
    KEY (`Value`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('init',8,NOW());


  DROP TABLE IF EXISTS `tmp_age`;
  CREATE TABLE IF NOT EXISTS `tmp_age`
  (
    `CollectionID` INT,
    `Name`         VARCHAR(64),
    `Value`        VARCHAR(64),

    PRIMARY KEY (`CollectionID`, `Name`),
    KEY (`Value`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('init',9,NOW());

END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportDone`;

GO

CREATE PROCEDURE `p_ImportDone`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('done',0,NOW());

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'collectionobjectcitation')
                AND (index_name = 'ix_importcollectionobjectcitationguid'))) THEN
    DROP INDEX ix_importcollectionobjectcitationguid ON svar_destdb_.`collectionobjectcitation`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'agent')
                AND (index_name = 'ix_importagentappend'))) THEN
    DROP INDEX ix_importagentappend ON svar_destdb_.`agent`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'determination')
                AND (index_name = 'ix_importdeterminationtempguid'))) THEN
    DROP INDEX ix_importdeterminationtempguid ON svar_destdb_.`determination`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'collectingevent')
                AND (index_name = 'ix_importcollectingeventtempguid'))) THEN
    DROP INDEX ix_importcollectingeventtempguid ON svar_destdb_.`collectingevent`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'locality')
                AND (index_name = 'ix_importlocalitytempguid'))) THEN
    DROP INDEX ix_importlocalitytempguid ON svar_destdb_.`locality`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'paleocontext')
                AND (index_name = 'ix_importpaleocontexttempguid'))) THEN
    DROP INDEX ix_importpaleocontexttempguid ON svar_destdb_.`paleocontext`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'preparation')
                AND (index_name = 'ix_importpreparationtempguid'))) THEN
    DROP INDEX ix_importpreparationtempguid ON svar_destdb_.`preparation`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'collectionobjectattribute')
                AND (index_name = 'ix_importcollectionobjectattributetempguid'))) THEN
    DROP INDEX ix_importcollectionobjectattributetempguid ON svar_destdb_.`collectionobjectattribute`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'taxon')
                AND (index_name = 'ix_importtaxon'))) THEN
    DROP INDEX ix_importtaxon ON svar_destdb_.`taxon`;
  END IF;

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'referencework')
                AND (index_name = 'ix_importreferenceworkkey'))) THEN
    DROP INDEX ix_importreferenceworkkey ON svar_destdb_.`referencework`;
  END IF;

  INSERT INTO `tmp_steps` VALUES ('done',1,NOW());


  DROP TABLE IF EXISTS `tmp_age`;

  INSERT INTO `tmp_steps` VALUES ('done',3,NOW());


  DROP TABLE IF EXISTS `tmp_biologicalsex`;

  INSERT INTO `tmp_steps` VALUES ('done',4,NOW());


  DROP TABLE IF EXISTS `tmp_storage`;

  INSERT INTO `tmp_steps` VALUES ('done',5,NOW());


  DROP TABLE IF EXISTS `tmp_locality`;

  INSERT INTO `tmp_steps` VALUES ('done',6,NOW());


  DROP TABLE IF EXISTS `tmp_geography`;

  INSERT INTO `tmp_steps` VALUES ('done',7,NOW());

  
  DROP TABLE IF EXISTS `tmp_taxon`;

  INSERT INTO `tmp_steps` VALUES ('done',8,NOW());


  DROP TABLE IF EXISTS `tmp_typestatus`;

  INSERT INTO `tmp_steps` VALUES ('done',9,NOW());


  DROP TABLE IF EXISTS `tmp_agent`;

  INSERT INTO `tmp_steps` VALUES ('done',10,NOW());


  DROP TABLE IF EXISTS `tmp_collection`;

  INSERT INTO `tmp_steps` VALUES ('done',11,NOW());

END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportAccessionAgent`;

GO

CREATE PROCEDURE `p_ImportAccessionAgent`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('accessionagent', 0, NOW());


  DROP TABLE IF EXISTS `tmp_accessionrole`;
  CREATE TABLE IF NOT EXISTS `tmp_accessionrole`
  (
    `CollectionID` INT,
    `Name`         VARCHAR(64),
    `Value`        VARCHAR(64),

    PRIMARY KEY (`CollectionID`, `Name`),
    KEY (`Value`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 0.1, NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_accessionagent` T1
         INNER JOIN `t_imp_accession` T2 ON (T1.`accessionkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_AccessionID`        = T2.`_AccessionID`,
         T1.`FirstName`           = COALESCE(TRIM(T1.`FirstName`), ''),
         T1.`LastName`            = COALESCE(TRIM(T1.`LastName`), ''),
         T1.`_AccessionRole`      = NULLIF(TRIM(T1.`Role`), ''),
         T1.`CreatedByFirstName`  = COALESCE(TRIM(T1.`CreatedByFirstName`), ''),
         T1.`CreatedByLastName`   = COALESCE(TRIM(T1.`CreatedByLastName`), ''),
         T1.`ModifiedByFirstName` = COALESCE(TRIM(T1.`ModifiedByFirstName`), ''),
         T1.`ModifiedByLastName`  = COALESCE(TRIM(T1.`ModifiedByLastName`), ''),
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 1, NOW());


  -- checking relationships

  UPDATE `t_imp_accessionagent` T1
         INNER JOIN `t_imp_accession` T2 ON (T1.`accessionkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_accession.'
   WHERE (T1.`_imported` = 0)
     AND (T2.`_error` = 1);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 2.1, NOW());


  UPDATE `t_imp_accessionagent`
     SET `_error`    = 1,
         `_errormsg` = 'Accession object not found.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_AccessionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 2.2, NOW());


  -- Agents: AccessionAgent, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, 
                T1.`LastName`,
                T1.`FirstName`
           FROM (SELECT DISTINCT
                        `_CollectionID` AS `CollectionID`,
                        `LastName`,
                        `FirstName`
                   FROM `t_imp_accessionagent` 
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `CreatedByLastName`,
                        `CreatedByFirstName`
                   FROM `t_imp_accessionagent`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_accessionagent`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID` = T2.`CollectionID`)
                                              AND (T1.`LastName`     = T2.`LastName`)
                                              AND (T1.`FirstName`    = T2.`FirstName`)
          WHERE (T2.`AgentID` IS NULL)
            AND (T1.`LastName` <> '');

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.1, NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`, `FirstName`, `CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.2, NOW());


  UPDATE `t_imp_accessionagent`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                  AND (T1.`LastName`      = T2.`LastName`)
                                  AND (T1.`FirstName`     = T2.`FirstName`)
     SET `_AgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.3, NOW());


  UPDATE `t_imp_accessionagent` T1
     SET `_error`    = 1,
         `_errormsg` = 'AgentID cannot be null.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_AgentID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.4, NOW());


  UPDATE `t_imp_accessionagent` T1
         INNER JOIN (SELECT `_AccessionID`, 
                            `_AgentID`,
                            `_AccessionRole`,
                            MIN(`_importguid`) AS `exception_importguid`
                       FROM `t_imp_accessionagent`
                      WHERE (`_imported` = 0)
                        AND (`_error`    = 0)
                      GROUP BY `_AccessionID`, `_AgentID`, `_AccessionRole`
                     HAVING (COUNT(*) > 1)) AS T2
                 ON (T1.`_AccessionID`   = T2.`_AccessionID`)
                AND (T1.`_AgentID`       = T2.`_AgentID`)
                AND (T1.`_AccessionRole` = T2.`_AccessionRole`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Duplicate name with the same role.'
   WHERE (T1.`_importguid` <> T2.`exception_importguid`);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.5, NOW());


  UPDATE `t_imp_accessionagent`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);


  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.6, NOW());

  UPDATE `t_imp_accessionagent`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 3.7, NOW());


  -- `Role`

  INSERT
    INTO `tmp_accessionrole` (`CollectionID`, `Name`)
         SELECT DISTINCT
                T1.`_CollectionID`,
                T1.`_AccessionRole`
           FROM `t_imp_accessionagent` T1
                LEFT OUTER JOIN `tmp_age` T2 ON (T1.`_CollectionID`  = T2.`CollectionID`)
                                            AND (T1.`_AccessionRole` = T2.`Name`)
          WHERE (T1.`_AccessionRole` IS NOT NULL)
            AND (T2.`Value` IS NULL)
            AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 4.1, NOW());


  UPDATE `tmp_accessionrole`
     SET `Value` = `f_appendAccessionRole`(`Name`, `CollectionID`)
    WHERE (`Value` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 4.2, NOW());


  UPDATE `t_imp_accessionagent` T1
         INNER JOIN `tmp_accessionrole` T2 ON (T1.`_CollectionID`  = T2.`CollectionID`)
                                          AND (T1.`_AccessionRole` = T2.`Name`)
     SET T1.`_AccessionRole` = T2.`Value`
   WHERE (T1.`_AccessionRole` IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 4.3, NOW());


  -- Specify Import

  INSERT 
    INTO svar_destdb_.`accessionagent` 
         (
           `AccessionID`,
           
           `AgentID`,
           `Role`,
           `Remarks`,
           
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,
           `Version`
         )
         SELECT `_AccessionID`,

                `_AgentID`,
                `_AccessionRole`,
                `Remarks`,

                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,
                1
           FROM `t_imp_accessionagent`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);
         
  INSERT INTO `tmp_steps` VALUES ('accessionagent', 5, NOW());


  -- AccessionAgentID

  UPDATE `t_imp_accessionagent` T1
         INNER JOIN svar_destdb_.`accessionagent` T2 ON (T1.`_AccessionID`   = T2.`AccessionID`)
                                                    AND (T1.`_AgentID`       = T2.`AgentID`)
                                                    AND (T1.`_AccessionRole` = T2.`Role`)
     SET T1.`_AccessionAgentID` = T2.`AccessionAgentID`
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 6, NOW());


  -- set imported flag

  UPDATE `t_imp_accessionagent` T1
         INNER JOIN svar_destdb_.`accessionagent` T2 ON (T1.`_AccessionAgentID` = T2.`AccessionAgentID`)
     SET `_imported` = 1
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 7, NOW());


  -- drop import helper

  DROP TABLE IF EXISTS `tmp_accessionrole`;

  INSERT INTO `tmp_steps` VALUES ('accessionagent', 255, NOW());
END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportAccession`;

GO

CREATE PROCEDURE `p_ImportAccession`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('accession',0,NOW());


  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'accession')
                    AND (index_name = 'ix_importaccessionguid'))) THEN
    CREATE INDEX ix_importaccessionguid ON svar_destdb_.`accession` (`Text3`(36), `AccessionID`);
  END IF;

  INSERT INTO `tmp_steps` VALUES ('accession',0.1,NOW());


  -- DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_accession`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('accession',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`),
         `DivisionID`   = `f_getDivisionID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('accession',1.2,NOW());


  -- DisciplineID, TimestampCreated, TimestampModified

  UPDATE `t_imp_accession` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_DivisionID`        = T2.`DivisionID`,
         T1.`_DisciplineID`      = T2.`DisciplineID`,
         T1.`_CollectionID`      = T2.`CollectionID`,
         T1.`key`                = COALESCE(NULLIF(TRIM(T1.`key`), ''),UUID()),
         T1.`TimestampCreated`   = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`  = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`        = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accession',2,NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_container`
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_container`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');


  INSERT INTO `tmp_steps` VALUES ('accession',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('accession',3.2,NOW());


  UPDATE `t_imp_accession`      T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accession',3.3,NOW());


  UPDATE `t_imp_accession`      T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accession',3.4,NOW());


  -- Specify Import

  INSERT 
    INTO svar_destdb_.`accession`
         (
           `DivisionID`,

           `AccessionNumber`,
           `Type`,
           `DateReceived`,
           `VerbatimDate`,
           `Remarks`,
           `Number1`,
           `Number2`,
           `Text1`,
           `Text2`,
           `Text3`,
           `YesNo1`,
           `YesNo2`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`
       )
       SELECT `_DivisionID`,

              `AccessionNumber`,
              `Type`,
              `DateReceived`,
              `VerbatimDate`,
              `Remarks`,
              `Number1`,
              `Number2`,
              `Text1`,
              `Text2`,
              `_importguid`,
              `YesNo1`,
              `YesNo2`,

              1, 
              `TimestampCreated`,
              `_CreatedByAgentID`,
              `TimestampModified`,
              `_ModifiedByAgentID`
         FROM `t_imp_accession`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('accession',4.1,NOW());


  -- `AccessionID`

  UPDATE `t_imp_accession` T1
         INNER JOIN svar_destdb_.`accession` T2 ON (T1.`_importguid` = T2.`Text3`)
     SET T1.`_AccessionID` = T2.`AccessionID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('accession',4.2,NOW());


  UPDATE svar_destdb_.`accession` T1
         INNER JOIN `t_imp_accession` T2 ON (T1.`AccessionID` = T2.`_AccessionID`) 
     SET T1.`Text3` = T2.`Text3`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('accession',5.3,NOW());


  -- Finalisation

  UPDATE `t_imp_accession` T1
         INNER JOIN svar_destdb_.`accession` T2 ON (T1.`_AccessionID` = T2.`AccessionID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('accession',5,NOW());


  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'accession')
                AND (index_name = 'ix_importaccessionguid'))) THEN
    DROP INDEX ix_importaccessionguid ON svar_destdb_.`accession`;
  END IF;

  INSERT INTO `tmp_steps` VALUES ('accession',255.1,NOW());

END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportContainer`;

GO

CREATE PROCEDURE `p_ImportContainer`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('container',0,NOW());


  DROP TABLE IF EXISTS `tmp_containertype`;
  CREATE TABLE IF NOT EXISTS `tmp_containertype`
  (
    `CollectionID` INT,
    `Name`         VARCHAR(64),
    `ID`           INT,

    PRIMARY KEY (`CollectionID`, `Name`),
    KEY (`ID`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('container',0.1,NOW());


  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'container')
                    AND (index_name = 'ix_importcontainerguid'))) THEN
    CREATE INDEX ix_importcontainerguid ON svar_destdb_.`container` (`Description`, `ContainerID`);
  END IF;

  INSERT INTO `tmp_steps` VALUES ('container',0.2,NOW());


  -- CollectionID, DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_container`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('container',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('container',1.2,NOW());


  -- CollectionID, DisciplineID, TimestampCreated, TimestampModified

  UPDATE `t_imp_container` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`      = T2.`CollectionID`,
         T1.`_DisciplineID`      = T2.`DisciplineID`,
         T1.`key`                = COALESCE(NULLIF(TRIM(T1.`key`), ''),UUID()),
         T1.`_ContainerTypeName` = NULLIF(TRIM(T1.`Type`), ''),
         T1.`TimestampCreated`   = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`  = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`        = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('container',2,NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_container`
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_container`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');


  INSERT INTO `tmp_steps` VALUES ('container',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('container',3.2,NOW());


  UPDATE `t_imp_container`      T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('container',3.3,NOW());


  UPDATE `t_imp_container`      T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('container',3.4,NOW());


  -- `ContainerType`

  INSERT
    INTO `tmp_containertype` (`CollectionID`, `Name`)
         SELECT DISTINCT
                T1.`_CollectionID`,
                T1.`_ContainerTypeName`
           FROM `t_imp_container` T1
                LEFT OUTER JOIN `tmp_containertype` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                                      AND (T1.`_ContainerTypeName` = T2.`Name`)
          WHERE (T1.`_ContainerTypeName` IS NOT NULL)
            AND (T2.`ID`                 IS NULL)
            AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('container',4.1,NOW());


  UPDATE `tmp_containertype`
     SET `ID` = `f_appendContainerType`(`Name`, `CollectionID`)
    WHERE (`ID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('container',4.2,NOW());


  UPDATE `t_imp_container` T1
         INNER JOIN `tmp_containertype` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                          AND (T1.`_ContainerTypeName` = T2.`Name`)
     SET T1.`_ContainerTypeID` = T2.`ID`
   WHERE (T1.`_ContainerTypeName` IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('container',4.3,NOW());


  UPDATE `t_imp_container`
     SET `_ContainerTypeID` = 0
   WHERE (`_ContainerTypeID` IS NULL) 
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('container',4.4,NOW());


  -- Specify Import

  INSERT 
    INTO svar_destdb_.`container`
         (
           `CollectionMemberID`,

           `Name`,
           `Type`,
           `Description`,
           `Number`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`
       )
       SELECT `_CollectionID`,

              `Name`,
              `_ContainerTypeID`,
              `_importguid`,
              `Number`,

              1, 
              `TimestampCreated`,
              `_CreatedByAgentID`,
              `TimestampModified`,
              `_ModifiedByAgentID`
         FROM `t_imp_container`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('container',5.1,NOW());


  -- `ContainerID`

  UPDATE `t_imp_container` T1
         INNER JOIN svar_destdb_.`container` T2 ON (T1.`_importguid` = T2.`Description`)
     SET T1.`_ContainerID` = T2.`ContainerID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('container',5.2,NOW());


  UPDATE svar_destdb_.`container` T1
         INNER JOIN `t_imp_container` T2 ON (T1.`ContainerID` = T2.`_ContainerID`) 
     SET T1.`Description` = T2.`Description`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('container',6.3,NOW());


  -- Finalisation

  UPDATE `t_imp_container` T1
         INNER JOIN svar_destdb_.`container` T2 ON (T1.`_ContainerID` = T2.`ContainerID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('container',6,NOW());


  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'container')
                AND (index_name = 'ix_importcontainerguid'))) THEN
    DROP INDEX ix_importcontainerguid ON svar_destdb_.`container`;
  END IF;

  INSERT INTO `tmp_steps` VALUES ('container',255.1,NOW());


  -- drop import helper

  DROP TABLE IF EXISTS `tmp_containertype`;

  INSERT INTO `tmp_steps` VALUES ('container',255.2,NOW());
END

GO


-- 

DROP PROCEDURE IF EXISTS `p_PrepareGeography`;

GO

CREATE PROCEDURE `p_PrepareGeography`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('preparegeography',0,NOW());


  UPDATE `t_imp_geography` T1
         INNER JOIN `t_specifycountry` T2 ON (T1.`_Country` = T2.`Country`)
     SET T1.`_changedvalues` = `f_appendString`(T1.`_changedvalues`, T1.`_Continent`),
         T1.`_Continent`     = T2.`SpecifyContinent`
   WHERE (`_Country` IS NOT NULL)
     AND (T1.`_Continent` <> T2.`SpecifyContinent`)
     AND (T1.`_imported`  =  0)
     AND (T1.`_error`     =  0);

  INSERT INTO `tmp_steps` VALUES ('preparegeography',2.1,NOW());


  UPDATE `t_imp_geography`             T1
         INNER JOIN `t_specifycountry` T2 ON (T1.`_Country` = T2.`Country`)
     SET T1.`_changedvalues` = `f_appendString`(T1.`_Country`, T1.`_changedvalues`),
         T1.`_Country`       = T2.`SpecifyCountry`
   WHERE (`_Country`  IS NOT NULL)
     AND (T1.`_Country`  <> T2.`SpecifyCountry`)
     AND (T1.`_imported` =  0)
     AND (T1.`_error`    =  0);

  INSERT INTO `tmp_steps` VALUES ('preparegeography',2.2,NOW());

END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportGeography100`;

GO

CREATE PROCEDURE `p_ImportGeography100`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geography100', 0, NOW());

  -- Continent

  INSERT 
    INTO `tmp_geography`
         (
           `GeographyTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeographyTreeDefID`,
                `_ContinentParentID`,
                100,
                `_Continent`
           FROM `t_imp_geography`
          WHERE (`_GeographyRankID` >= 100)
            AND (`_Continent` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography100', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyTreeDefID` = T2.`GeographyTreeDefID`)
                                               AND (T1.`ParentID`           = T2.`ParentID`)
                                               AND (T1.`RankID`             = T2.`RankID`)
                                               AND (T1.`Name`               = T2.`Name`)
     SET T1.`GeographyID` = T2.`GeographyID`
   WHERE (T1.`GeographyID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('geography100', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geography`
     SET `GeographyID` = `f_appendGeography`(`GeographyTreeDefID`, `ParentID`, 100, `Name`)
   WHERE (`GeographyID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography100', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_geography`
   WHERE (`ParentID` = `GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography100', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyID` = T2.`GeographyID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography100', 1.4, NOW());


  -- save values in t_imp_geography

  UPDATE `t_imp_geography` T1 
         INNER JOIN `tmp_geography` T2 ON (T1.`_ContinentParentID` = T2.`ParentID`)
                                      AND (T1.`_Continent`         = T2.`Name`)
     SET T1.`_ContinentID`     = T2.`GeographyID`,
         T1.`_GeographyID`     = T2.`GeographyID`,
         T1.`_CountryParentID` = T2.`GeographyID`
   WHERE (T2.`RankID`            = 100)
     AND (T1.`_GeographyRankID` >= 100)
     AND (T1.`_imported`         =  0)
     AND (T1.`_error`            =  0);

  INSERT INTO `tmp_steps` VALUES ('geography100', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_geography`
     SET `_CountryParentID` = `_ContinentParentID`
   WHERE (`_CountryParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography100', 1.6, NOW());
END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportGeography200`;

GO

CREATE PROCEDURE `p_ImportGeography200`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geography200', 0, NOW());

  -- Country

  INSERT 
    INTO `tmp_geography`
         (
           `GeographyTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeographyTreeDefID`,
                `_CountryParentID`,
                200,
                `_Country`
           FROM `t_imp_geography`
          WHERE (`_GeographyRankID` >= 200)
            AND (`_Country` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography200', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyTreeDefID` = T2.`GeographyTreeDefID`)
                                               AND (T1.`ParentID`           = T2.`ParentID`)
                                               AND (T1.`RankID`             = T2.`RankID`)
                                               AND (T1.`Name`               = T2.`Name`)
     SET T1.`GeographyID` = T2.`GeographyID`
   WHERE (T1.`GeographyID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('geography200', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geography`
     SET `GeographyID` = `f_appendGeography`(`GeographyTreeDefID`, `ParentID`, 200, `Name`)
   WHERE (`GeographyID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography200', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_geography`
   WHERE (`ParentID` = `GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography200', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyID` = T2.`GeographyID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography200', 1.4, NOW());


  -- save values in t_imp_geography

  UPDATE `t_imp_geography` T1 
         INNER JOIN `tmp_geography` T2 ON (T1.`_CountryParentID` = T2.`ParentID`)
                                      AND (T1.`_Country`          = T2.`Name`)
     SET T1.`_CountryID`     = T2.`GeographyID`,
         T1.`_GeographyID`   = T2.`GeographyID`,
         T1.`_StateParentID` = T2.`GeographyID`
   WHERE (T2.`RankID`            = 200)
     AND (T1.`_GeographyRankID` >= 200)
     AND (T1.`_imported`         =  0)
     AND (T1.`_error`            =  0);

  INSERT INTO `tmp_steps` VALUES ('geography200', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_geography`
     SET `_StateParentID` = `_CountryParentID`
   WHERE (`_StateParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography200', 1.6, NOW());
END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportGeography300`;

GO

CREATE PROCEDURE `p_ImportGeography300`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geography300', 0, NOW());

  -- State

  INSERT 
    INTO `tmp_geography`
         (
           `GeographyTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeographyTreeDefID`,
                `_StateParentID`,
                300,
                `_State`
           FROM `t_imp_geography`
          WHERE (`_GeographyRankID` >= 300)
            AND (`_State` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography300', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyTreeDefID` = T2.`GeographyTreeDefID`)
                                               AND (T1.`ParentID`           = T2.`ParentID`)
                                               AND (T1.`RankID`             = T2.`RankID`)
                                               AND (T1.`Name`               = T2.`Name`)
     SET T1.`GeographyID` = T2.`GeographyID`
   WHERE (T1.`GeographyID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('geography300', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geography`
     SET `GeographyID` = `f_appendGeography`(`GeographyTreeDefID`, `ParentID`, 300, `Name`)
   WHERE (`GeographyID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography300', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_geography`
   WHERE (`ParentID` = `GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography300', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyID` = T2.`GeographyID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography300', 1.4, NOW());


  -- save values in t_imp_geography

  UPDATE `t_imp_geography` T1 
         INNER JOIN `tmp_geography` T2 ON (T1.`_StateParentID` = T2.`ParentID`)
                                      AND (T1.`_State`         = T2.`Name`)
     SET T1.`_StateID`        = T2.`GeographyID`,
         T1.`_GeographyID`    = T2.`GeographyID`,
         T1.`_CountyParentID` = T2.`GeographyID`
   WHERE (T2.`RankID`            = 300)
     AND (T1.`_GeographyRankID` >= 300)
     AND (T1.`_imported`         =  0)
     AND (T1.`_error`            =  0);

  INSERT INTO `tmp_steps` VALUES ('geography300', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_geography`
     SET `_CountyParentID` = `_StateParentID`
   WHERE (`_CountyParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography300', 1.6, NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportGeography400`;

GO

CREATE PROCEDURE `p_ImportGeography400`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geography400', 0, NOW());

  -- County

  INSERT 
    INTO `tmp_geography`
         (
           `GeographyTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeographyTreeDefID`,
                `_CountyParentID`,
                400,
                `_County`
           FROM `t_imp_geography`
          WHERE (`_GeographyRankID` >= 400)
            AND (`_County` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geography400', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyTreeDefID` = T2.`GeographyTreeDefID`)
                                               AND (T1.`ParentID`           = T2.`ParentID`)
                                               AND (T1.`RankID`             = T2.`RankID`)
                                               AND (T1.`Name`               = T2.`Name`)
     SET T1.`GeographyID` = T2.`GeographyID`
   WHERE (T1.`GeographyID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('geography400', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geography`
     SET `GeographyID` = `f_appendGeography`(`GeographyTreeDefID`, `ParentID`, 400, `Name`)
   WHERE (`GeographyID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography400', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_geography`
   WHERE (`ParentID` = `GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography400', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geography` T1
         INNER JOIN svar_destdb_.`geography` T2 ON (T1.`GeographyID` = T2.`GeographyID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeographyID`);

  INSERT INTO `tmp_steps` VALUES ('geography400', 1.4, NOW());


  -- save values in t_imp_geography

  UPDATE `t_imp_geography` T1 
         INNER JOIN `tmp_geography` T2 ON (T1.`_CountyParentID` = T2.`ParentID`)
                                      AND (T1.`_County`         = T2.`Name`)
     SET T1.`_CountyID`    = T2.`GeographyID`,
         T1.`_GeographyID` = T2.`GeographyID`
   WHERE (T2.`RankID`            = 400)
     AND (T1.`_GeographyRankID` >= 400)
     AND (T1.`_imported`         =  0)
     AND (T1.`_error`            =  0);

  INSERT INTO `tmp_steps` VALUES ('geography400', 1.5, NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportGeography`;

GO

CREATE PROCEDURE `p_ImportGeography`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geography',0,NOW());


  -- CollectionID, DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_geography`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('geography',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography',1.2,NOW());


  UPDATE `tmp_collection`
     SET `GeographyTreeDefID` = `f_GetGeographyTreeDefID`(`specifycollcode`)
   WHERE (`GeographyTreeDefID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography',1.3,NOW());


  UPDATE `tmp_collection`
     SET `GeographyRootID` = `f_GetGeographyRootID`(`GeographyTreeDefID`)
   WHERE (`GeographyRootID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geography',1.4,NOW());


  UPDATE `t_imp_geography` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`       = T2.`CollectionID`,
         T1.`_DisciplineID`       = T2.`DisciplineID`,
         T1.`_GeographyTreeDefID` = T2.`GeographyTreeDefID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`_importguid`         = UUID(),
         T1.`_Continent`          = NULLIF(NULLIF(TRIM(`Continent`),''),'?'),
         T1.`_Country`            = NULLIF(NULLIF(TRIM(`Country`),''),'?'),
         T1.`_State`              = NULLIF(NULLIF(TRIM(`State`),''),'?'),
         T1.`_County`             = NULLIF(NULLIF(TRIM(`County`),''),'?')
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',1.5,NOW());


  UPDATE `t_imp_geography`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid `specifycollcode` value.'
   WHERE (`_CollectionID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',1.6,NOW());


  -- Geography rank

  UPDATE `t_imp_geography`
     SET `_GeographyRankID` = CASE 
                                WHEN (COALESCE(TRIM(`County`)    ,'') > '') THEN 400
                                WHEN (COALESCE(TRIM(`State`)     ,'') > '') THEN 300
                                WHEN (COALESCE(TRIM(`Country`)   ,'') > '') THEN 200
                                WHEN (COALESCE(TRIM(`Continent`) ,'') > '') THEN 100
                                ELSE 0
                              END
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',2.1,NOW());


  UPDATE `t_imp_geography`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid geography rank.'
   WHERE (`_GeographyRankID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',2.2,NOW());


  -- GeographyTreeDefID, Parent of Continent

  UPDATE `t_imp_geography` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_GeographyTreeDefID`  = T2.`GeographyTreeDefID`,
         T1.`_ContinentParentID`   = T2.`GeographyRootID`,
         T1.`_GeographyID`         = T2.`GeographyRootID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',3.1,NOW());


  UPDATE `t_imp_geography`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid GeographyTreeDefID.'
   WHERE (`_GeographyTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',3.2,NOW());


  UPDATE `t_imp_geography`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid Continent parent id.'
   WHERE (`_GeographyTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',3.3,NOW());


  CALL `p_PrepareGeography`;


  UPDATE `t_imp_geography`
     SET `_Continent` = '?'
   WHERE (`_GeographyRankID` > 100)
     AND (`_Continent` IS NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',4.1,NOW());


  UPDATE `t_imp_geography`
     SET `_Country` = '?'
   WHERE (`_GeographyRankID` > 200)
     AND (`_Country` IS NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',4.2,NOW());


  UPDATE `t_imp_geography`
     SET `_State` = '?'
   WHERE (`_GeographyRankID` > 300)
     AND (`_State` IS NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',4.3,NOW());


  CALL `p_ImportGeography100`;
  CALL `p_ImportGeography200`;
  CALL `p_ImportGeography300`;
  CALL `p_ImportGeography400`;


  -- set imported flag

  UPDATE `t_imp_geography`
     SET `_imported` = 1
   WHERE (`_GeographyID` IS NOT NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geography',5,NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_PrepareGeologicTimePeriod`;

GO

CREATE PROCEDURE `p_PrepareGeologicTimePeriod`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('preparegeography',0,NOW());

  -- currently nothing to do

END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportGeologicTimePeriod100`;

GO

CREATE PROCEDURE `p_ImportGeologicTimePeriod100`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 0, NOW());

  -- ErathemEra

  INSERT 
    INTO `tmp_geologictimeperiod`
         (
           `GeologicTimePeriodTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeologicTimePeriodTreeDefID`,
                `_ErathemEraParentID`,
                100,
                `_ErathemEra`
           FROM `t_imp_geologictimeperiod`
          WHERE (`_GeologicTimePeriodRankID` >= 100)
            AND (`_ErathemEra` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodTreeDefID` = T2.`GeologicTimePeriodTreeDefID`)
                                                        AND (T1.`ParentID`                    = T2.`ParentID`)
                                                        AND (T1.`RankID`                      = T2.`RankID`)
                                                        AND (T1.`Name`                        = T2.`Name`)
     SET T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`
   WHERE (T1.`GeologicTimePeriodID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geologictimeperiod`
     SET `GeologicTimePeriodID` = `f_appendGeologicTimePeriod`(`GeologicTimePeriodTreeDefID`, `ParentID`, 100, `Name`)
   WHERE (`GeologicTimePeriodID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_GeologicTimePeriod`
   WHERE (`ParentID` = `GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.4, NOW());


  -- save values in t_imp_GeologicTimePeriod

  UPDATE `t_imp_geologictimeperiod` T1 
         INNER JOIN `tmp_geologictimeperiod` T2 ON (T1.`_ErathemEraParentID` = T2.`ParentID`)
                                               AND (T1.`_ErathemEra`         = T2.`Name`)
     SET T1.`_ErathemEraID`         = T2.`GeologicTimePeriodID`,
         T1.`_GeologicTimePeriodID` = T2.`GeologicTimePeriodID`,
         T1.`_SystemPeriodParentID` = T2.`GeologicTimePeriodID`
   WHERE (T2.`RankID`                     = 100)
     AND (T1.`_GeologicTimePeriodRankID` >= 100)
     AND (T1.`_imported`                  =  0)
     AND (T1.`_error`                     =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_geologictimeperiod`
     SET `_SystemPeriodParentID` = `_ErathemEraParentID`
   WHERE (`_SystemPeriodParentID` IS NULL) 
     AND (`_imported`             =  0)
     AND (`_error`                =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod100', 1.6, NOW());
END

GO

--

DROP PROCEDURE IF EXISTS `p_ImportGeologicTimePeriod200`;

GO

CREATE PROCEDURE `p_ImportGeologicTimePeriod200`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 0, NOW());

  -- SystemPeriod

  INSERT 
    INTO `tmp_geologictimeperiod`
         (
           `GeologicTimePeriodTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeologicTimePeriodTreeDefID`,
                `_SystemPeriodParentID`,
                200,
                `_SystemPeriod`
           FROM `t_imp_geologictimeperiod`
          WHERE (`_GeologicTimePeriodRankID` >= 200)
            AND (`_SystemPeriod` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodTreeDefID` = T2.`GeologicTimePeriodTreeDefID`)
                                                        AND (T1.`ParentID`                    = T2.`ParentID`)
                                                        AND (T1.`RankID`                      = T2.`RankID`)
                                                        AND (T1.`Name`                        = T2.`Name`)
     SET T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`
   WHERE (T1.`GeologicTimePeriodID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geologictimeperiod`
     SET `GeologicTimePeriodID` = `f_appendGeologicTimePeriod`(`GeologicTimePeriodTreeDefID`, `ParentID`, 200, `Name`)
   WHERE (`GeologicTimePeriodID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_GeologicTimePeriod`
   WHERE (`ParentID` = `GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.4, NOW());


  -- save values in t_imp_GeologicTimePeriod

  UPDATE `t_imp_geologictimeperiod` T1 
         INNER JOIN `tmp_geologictimeperiod` T2 ON (T1.`_SystemPeriodParentID` = T2.`ParentID`)
                                               AND (T1.`_SystemPeriod`         = T2.`Name`)
     SET T1.`_SystemPeriodID`         = T2.`GeologicTimePeriodID`,
         T1.`_GeologicTimePeriodID` = T2.`GeologicTimePeriodID`,
         T1.`_SeriesEpochParentID` = T2.`GeologicTimePeriodID`
   WHERE (T2.`RankID`                     = 200)
     AND (T1.`_GeologicTimePeriodRankID` >= 200)
     AND (T1.`_imported`                  =  0)
     AND (T1.`_error`                     =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_geologictimeperiod`
     SET `_SeriesEpochParentID` = `_SystemPeriodParentID`
   WHERE (`_SeriesEpochParentID` IS NULL) 
     AND (`_imported`            =  0)
     AND (`_error`               =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod200', 1.6, NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportGeologicTimePeriod300`;

GO

CREATE PROCEDURE `p_ImportGeologicTimePeriod300`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 0, NOW());

  -- SeriesEpoch

  INSERT 
    INTO `tmp_geologictimeperiod`
         (
           `GeologicTimePeriodTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeologicTimePeriodTreeDefID`,
                `_SeriesEpochParentID`,
                300,
                `_SeriesEpoch`
           FROM `t_imp_geologictimeperiod`
          WHERE (`_GeologicTimePeriodRankID` >= 300)
            AND (`_SeriesEpoch` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodTreeDefID` = T2.`GeologicTimePeriodTreeDefID`)
                                                        AND (T1.`ParentID`                    = T2.`ParentID`)
                                                        AND (T1.`RankID`                      = T2.`RankID`)
                                                        AND (T1.`Name`                        = T2.`Name`)
     SET T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`
   WHERE (T1.`GeologicTimePeriodID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geologictimeperiod`
     SET `GeologicTimePeriodID` = `f_appendGeologicTimePeriod`(`GeologicTimePeriodTreeDefID`, `ParentID`, 300, `Name`)
   WHERE (`GeologicTimePeriodID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_GeologicTimePeriod`
   WHERE (`ParentID` = `GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.4, NOW());


  -- save values in t_imp_GeologicTimePeriod

  UPDATE `t_imp_geologictimeperiod` T1 
         INNER JOIN `tmp_geologictimeperiod` T2 ON (T1.`_SeriesEpochParentID` = T2.`ParentID`)
                                               AND (T1.`_SeriesEpoch`         = T2.`Name`)
     SET T1.`_SeriesEpochID`        = T2.`GeologicTimePeriodID`,
         T1.`_GeologicTimePeriodID` = T2.`GeologicTimePeriodID`,
         T1.`_StageAgeParentID`     = T2.`GeologicTimePeriodID`
   WHERE (T2.`RankID`                     = 300)
     AND (T1.`_GeologicTimePeriodRankID` >= 300)
     AND (T1.`_imported`                  =  0)
     AND (T1.`_error`                     =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_geologictimeperiod`
     SET `_StageAgeParentID` = `_SeriesEpochParentID`
   WHERE (`_StageAgeParentID` IS NULL) 
     AND (`_imported`         =  0)
     AND (`_error`            =  0);

  INSERT INTO `tmp_steps` VALUES ('GeologicTimePeriod300', 1.6, NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportGeologicTimePeriod400`;

GO

CREATE PROCEDURE `p_ImportGeologicTimePeriod400`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 0, NOW());

  -- StageAge

  INSERT 
    INTO `tmp_geologictimeperiod`
         (
           `GeologicTimePeriodTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_GeologicTimePeriodTreeDefID`,
                `_StageAgeParentID`,
                400,
                `_StageAge`
           FROM `t_imp_geologictimeperiod`
          WHERE (`_GeologicTimePeriodRankID` >= 400)
            AND (`_StageAge` IS NOT NULL)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodTreeDefID` = T2.`GeologicTimePeriodTreeDefID`)
                                                        AND (T1.`ParentID`                    = T2.`ParentID`)
                                                        AND (T1.`RankID`                      = T2.`RankID`)
                                                        AND (T1.`Name`                        = T2.`Name`)
     SET T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`
   WHERE (T1.`GeologicTimePeriodID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_geologictimeperiod`
     SET `GeologicTimePeriodID` = `f_appendGeologicTimePeriod`(`GeologicTimePeriodTreeDefID`, `ParentID`, 400, `Name`)
   WHERE (`GeologicTimePeriodID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM `tmp_geologictimeperiod`
   WHERE (`ParentID` = `GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 1.31, NOW());


  -- Specify names

  UPDATE `tmp_geologictimeperiod` T1
         INNER JOIN svar_destdb_.`geologictimeperiod` T2 ON (T1.`GeologicTimePeriodID` = T2.`GeologicTimePeriodID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`GeologicTimePeriodID`);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 1.4, NOW());


  -- save values in t_imp_geologictimeperiod

  UPDATE `t_imp_geologictimeperiod` T1 
         INNER JOIN `tmp_geologictimeperiod` T2 ON (T1.`_StageAgeParentID` = T2.`ParentID`)
                                               AND (T1.`_StageAge`         = T2.`Name`)
     SET T1.`_StageAgeID`           = T2.`GeologicTimePeriodID`,
         T1.`_GeologicTimePeriodID` = T2.`GeologicTimePeriodID`
   WHERE (T2.`RankID`                     = 400)
     AND (T1.`_GeologicTimePeriodRankID` >= 400)
     AND (T1.`_imported`                  =  0)
     AND (T1.`_error`                     =  0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod400', 1.5, NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportGeologicTimePeriod`;

GO

CREATE PROCEDURE `p_ImportGeologicTimePeriod`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',0,NOW());


  DROP TABLE IF EXISTS `tmp_geologictimeperiod`;
  CREATE TABLE IF NOT EXISTS `tmp_geologictimeperiod`
  (
    `GeologicTimePeriodTreeDefID` INT,
    `ParentID`                    INT,
    `RankID`                      INT,
    `Name`                        VARCHAR(64),
    `GeologicTimePeriodID`        INT, 
    `SpecifyName`                 VARCHAR(64),

    PRIMARY KEY (`GeologicTimePeriodTreeDefID`, `ParentID`, `RankID`, `Name`),
    KEY (`ParentID`, `RankID`, `Name`),
    KEY (`ParentID`),
    KEY (`GeologicTimePeriodID`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',0.1,NOW());


  -- CollectionID, DisciplineID

  INSERT
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_geologictimeperiod`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',1.2,NOW());


  UPDATE `tmp_collection`
     SET `GeologicTimePeriodTreeDefID` = `f_GetGeologicTimePeriodTreeDefID`(`specifycollcode`)
   WHERE (`GeologicTimePeriodTreeDefID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',1.3,NOW());


  UPDATE `tmp_collection`
     SET `GeologicTimePeriodRootID` = `f_GetGeologicTimePeriodRootID`(`GeologicTimePeriodTreeDefID`)
   WHERE (`GeologicTimePeriodRootID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',1.4,NOW());


  UPDATE `t_imp_geologictimeperiod` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`       = T2.`CollectionID`,
         T1.`_DisciplineID`       = T2.`DisciplineID`,
         T1.`_GeologicTimePeriodTreeDefID` = T2.`GeologicTimePeriodTreeDefID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`_importguid`         = UUID(),
         T1.`_ErathemEra`         = NULLIF(NULLIF(TRIM(`ErathemEra`),''),'?'),
         T1.`_SystemPeriod`       = NULLIF(NULLIF(TRIM(`SystemPeriod`),''),'?'),
         T1.`_SeriesEpoch`        = NULLIF(NULLIF(TRIM(`SeriesEpoch`),''),'?'),
         T1.`_StageAge`           = NULLIF(NULLIF(TRIM(`StageAge`),''),'?')
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',1.5,NOW());


  UPDATE `t_imp_geologictimeperiod`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid `specifycollcode` value.'
   WHERE (`_CollectionID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',1.6,NOW());


  -- GeologicTimePeriod rank

  UPDATE `t_imp_geologictimeperiod`
     SET `_GeologicTimePeriodRankID` = CASE 
                                         WHEN (COALESCE(TRIM(`StageAge`)    ,'') > '') THEN 400
                                         WHEN (COALESCE(TRIM(`SeriesEpoch`) ,'') > '') THEN 300
                                         WHEN (COALESCE(TRIM(`SystemPeriod`),'') > '') THEN 200
                                         WHEN (COALESCE(TRIM(`ErathemEra`)  ,'') > '') THEN 100
                                         ELSE 0
                                       END
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',2.1,NOW());


  UPDATE `t_imp_geologictimeperiod`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid geologictimeperiod rank.'
   WHERE (`_GeologicTimePeriodRankID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',2.2,NOW());


  -- GeologicTimePeriodTreeDefID, Parent of ErathemEra

  UPDATE `t_imp_geologictimeperiod` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_GeologicTimePeriodTreeDefID`  = T2.`GeologicTimePeriodTreeDefID`,
         T1.`_ErathemEraParentID`   = T2.`GeologicTimePeriodRootID`,
         T1.`_GeologicTimePeriodID`         = T2.`GeologicTimePeriodRootID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',3.1,NOW());


  UPDATE `t_imp_geologictimeperiod`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid GeologicTimePeriodTreeDefID.'
   WHERE (`_GeologicTimePeriodTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',3.2,NOW());


  UPDATE `t_imp_geologictimeperiod`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid ErathemEra parent id.'
   WHERE (`_GeologicTimePeriodTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',3.3,NOW());


  CALL `p_PrepareGeologicTimePeriod`;


  UPDATE `t_imp_geologictimeperiod`
     SET `_ErathemEra` = '?'
   WHERE (`_GeologicTimePeriodRankID` > 100)
     AND (`_ErathemEra` IS NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',4.1,NOW());


  UPDATE `t_imp_geologictimeperiod`
     SET `_SystemPeriod` = '?'
   WHERE (`_GeologicTimePeriodRankID` > 200)
     AND (`_SystemPeriod` IS NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',4.2,NOW());


  UPDATE `t_imp_geologictimeperiod`
     SET `_SeriesEpoch` = '?'
   WHERE (`_GeologicTimePeriodRankID` > 300)
     AND (`_SeriesEpoch` IS NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',4.3,NOW());


  CALL `p_ImportGeologicTimePeriod100`;
  CALL `p_ImportGeologicTimePeriod200`;
  CALL `p_ImportGeologicTimePeriod300`;
  CALL `p_ImportGeologicTimePeriod400`;


  -- set imported flag

  UPDATE `t_imp_geologictimeperiod`
     SET `_imported` = 1
   WHERE (`_GeologicTimePeriodID` IS NOT NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);


  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',5,NOW());


  DROP TABLE IF EXISTS `tmp_geologictimeperiod`;

  INSERT INTO `tmp_steps` VALUES ('geologictimeperiod',255,NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportLocality`;

GO

CREATE PROCEDURE `p_ImportLocality`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('locality',0,NOW());


  DROP TABLE IF EXISTS `tmp_locality`;
  CREATE TABLE IF NOT EXISTS `tmp_locality`
  (
    `TempID`               INT NOT NULL AUTO_INCREMENT,
    `DisciplineID`         INT,
    `GeographyID`          INT,
    `LocalityName`         VARCHAR(255),
    `Latitude1`            DECIMAL(12,10),
    `Longitude1`           DECIMAL(13,10),
    `Latitude2`            DECIMAL(12,10),
    `Longitude2`           DECIMAL(13,10),
    `LatLongType`          VARCHAR(50),
    `MinElevation`         DOUBLE,
    `MaxElevation`         DOUBLE,
    `NamedPlace`           VARCHAR(255),
    `RelationToNamedPlace` VARCHAR(120),
    `Remarks`              TEXT,
    `Lat1Text`             VARCHAR(50),
    `Long1Text`            VARCHAR(50),
    `Lat2Text`             VARCHAR(50),
    `Long2Text`            VARCHAR(50),
    `SrcLatLongUnit`       INT DEFAULT 0,
    `TimestampCreated`     DATETIME,
    `TimestampModified`    DATETIME,
    `CreatedByAgentID`     INT,
    `ModifiedByAgentID`    INT,
    `LocalityID`           INT,
    `importguid`           VARCHAR(36),

    PRIMARY KEY (`TempID`),
    KEY (`DisciplineID`, `GeographyID`, `LocalityName`, `Latitude1`, `Longitude1`, `Latitude2`, `Longitude2`, `LatLongType`, `SrcLatLongUnit`, `MinElevation`, `MaxElevation`, `NamedPlace`, `RelationToNamedPlace`),
    KEY (`LocalityID`),
    KEY (`importguid`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('locality',0.1,NOW());


  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'locality')
                    AND (index_name = 'ix_importlocalityuniquefields'))) THEN
    CREATE INDEX ix_importlocalityuniquefields ON svar_destdb_.`locality` (`DisciplineID`, `GeographyID`, `LocalityName`, `Latitude1`, `Longitude1`, `Latitude2`, `Longitude2`, `LatLongType`, `SrcLatLongUnit`, `MinElevation`, `MaxElevation`, `NamedPlace`, `RelationToNamedPlace`);
  END IF;

  INSERT INTO `tmp_steps` VALUES ('locality',0.2,NOW());


  -- CollectionID, DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_locality`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('locality',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('locality',1.2,NOW());


  -- CollectionID, DisciplineID, TimestampCreated, TimestampModified

  UPDATE `t_imp_locality` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`     = T2.`CollectionID`,
         T1.`_DisciplineID`     = T2.`DisciplineID`,
         T1.`key`               = COALESCE(NULLIF(TRIM(T1.`key`), ''),UUID()),
         T1.`_LocalityName`     = COALESCE(TRIM(T1.`LocalityName`), ''),
         T1.`TimestampCreated`  = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified` = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`       = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',2,NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_locality`
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_locality`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');


  INSERT INTO `tmp_steps` VALUES ('locality',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('locality',3.2,NOW());


  UPDATE `t_imp_locality`        T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',3.3,NOW());


  UPDATE `t_imp_locality`       T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',3.4,NOW());


  -- Degrees-Minutes-Seconds: Latitude1, Longitude1, LatText1, LongText1, SrcLatLongUnit, LatLongType

  UPDATE `t_imp_locality`
     SET `_Latitude1`      = `f_lat_dms2dd`(`DMSLatitude1`),
         `_Longitude1`     = `f_long_dms2dd`(`DMSLongitude1`),
         `_Lat1Text`       = `f_lat_dms2text`(`DMSLatitude1`),
         `_Long1Text`      = `f_long_dms2text`(`DMSLongitude1`),
         `_SrcLatLongUnit` = 1,
         `_LatLongType`    = COALESCE(NULLIF(`LatLongType`,''),'Point')
   WHERE ((`DMSLatitude1` IS NOT NULL) AND (`DMSLongitude1` IS NOT NULL))
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',4.1,NOW());


  -- Degrees-Minutes-Seconds: Latitude2, Longitude2, LatText2, LongText2, LatLongType

  UPDATE `t_imp_locality`
     SET `_Latitude2`   = `f_lat_dms2dd`(`DMSLatitude2`),
         `_Longitude2`  = `f_long_dms2dd`(`DMSLongitude2`),
         `_Lat2Text`    = `f_lat_dms2text`(`DMSLatitude2`),
         `_Long2Text`   = `f_long_dms2text`(`DMSLongitude2`),
         `_LatLongType` = COALESCE(NULLIF(`LatLongType`,''),'Rectangle')
   WHERE ((`_Latitude1` IS NOT NULL) AND (`_Longitude1` IS NOT NULL))
     AND ((`DMSLatitude2` IS NOT NULL) AND (`DMSLongitude2` IS NOT NULL))
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',4.2,NOW());

  /*
  -- Degrees-Decimal minutes: Latitude1, Longitude1, LatText1, LongText1, SrcLatLongUnit, LatLongType

  UPDATE `t_imp_locality`
     SET `_Latitude1`   = `f_lat_ddm2dd`(`DDMLatitude1`),
         `_Longitude1`  = `f_lat_ddm2dd`(`DDMLongitude1`),
         `_Lat1Text`    = `f_lat_ddm2text`(`DDLatitude1`),
         `_Long1Text`   = `f_long_ddm2text`(`DDLongitude1`),
         `_SrcLatLongUnit` = 2,
         `_LatLongType`    = COALESCE(NULLIF(`LatLongType`,''),'Point')
   WHERE ((`DDMLatitude1` IS NOT NULL) AND (`DDMLongitude1` IS NOT NULL))
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',4.3,NOW());


  -- Degrees-Decimal minutes: Latitude2, Longitude2, LatText2, LongText2, LatLongType

  UPDATE `t_imp_locality`
     SET `_Latitude2`   = `f_lat_ddm2dd`(`DDMLatitude2`),
         `_Longitude2`  = `f_long_ddm2dd`(`DDMLongitude2`),
         `_Lat2Text`    = `f_lat_ddm2text`(`DDMLatitude2`),
         `_Long2Text`   = `f_long_ddm2text`(`DDMLongitude2`),
         `_LatLongType` = COALESCE(NULLIF(`LatLongType`,''),'Rectangle')
   WHERE ((`_Latitude1` IS NOT NULL) AND (`_Longitude1` IS NOT NULL))
     AND ((`DDMLatitude2` IS NOT NULL) AND (`DDMLongitude2` IS NOT NULL))
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',4.4,NOW());
  */

  -- Decimal degrees: Latitude1, Longitude1, LatText1, LongText1, SrcLatLongUnit, LatLongType

  UPDATE `t_imp_locality`
     SET `_Latitude1`   = `DDLatitude1`,
         `_Longitude1`  = `DDLongitude1`,
         `_Lat1Text`    = `f_lat_dd2text`(`DDLatitude1`),
         `_Long1Text`   = `f_long_dd2text`(`DDLongitude1`),
         `_SrcLatLongUnit` = 0,
         `_LatLongType`    = COALESCE(NULLIF(`LatLongType`,''),'Point')
   WHERE ((`DDLatitude1` IS NOT NULL) AND (`DDLongitude1` IS NOT NULL))
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',4.5,NOW());


  -- Decimal degrees: Latitude2, Longitude2, LatText2, LongText2, LatLongType

  UPDATE `t_imp_locality`
     SET `_Latitude2`   = `DDLatitude2`,
         `_Longitude2`  = `DDLongitude2`,
         `_Lat2Text`    = `f_lat_dd2text`(`DDLatitude2`),
         `_Long2Text`   = `f_long_dd2text`(`DDLongitude2`),
         `_LatLongType` = COALESCE(NULLIF(`LatLongType`,''),'Rectangle')
   WHERE ((`_Latitude1` IS NOT NULL) AND (`_Longitude1` IS NOT NULL))
     AND ((`DDLatitude2` IS NOT NULL) AND (`DDLongitude2` IS NOT NULL))
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',4.6,NOW());


  -- Geography

  INSERT 
    INTO `t_imp_geography`
         (
           `key`,
           `specifycollcode`,
           `Continent`,
           `Country`,
           `State`,
           `County`
         )
         SELECT `_importguid`,
                `specifycollcode`,
                `Continent`,
                `Country`,
                `State`,
                `County`
           FROM `t_imp_locality`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',5,NOW());

  
  CALL `p_ImportGeography`;


  -- GeographyID

  UPDATE `t_imp_locality` T1
         INNER JOIN `t_imp_geography` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_GeographyID` = T2.`_GeographyID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_imported` = 1)
     AND (T2.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',6.1,NOW());


  -- checking GeographyID

  UPDATE `t_imp_locality` T1
     SET `_error`    = 1,
         `_errormsg` = 'Invalid geography id.'
   WHERE (`_GeographyID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',6.2,NOW());


  -- LocalityName

  UPDATE `t_imp_locality` T1
         INNER JOIN `tmp_geography` T2 ON (T1.`_GeographyID` = T2.`GeographyID`)
     SET T1.`_LocalityName` = T2.`Name`
   WHERE (T1.`_LocalityName` = '');

  INSERT INTO `tmp_steps` VALUES ('locality',7,NOW());


  -- LocalityID

  INSERT 
    INTO `tmp_locality`
         (
           `DisciplineID`,
           `GeographyID`,
           `LocalityName`,
           `Latitude1`,
           `Longitude1`,
           `Latitude2`,
           `Longitude2`,
           `LatLongType`,
           `Lat1Text`,
           `Long1Text`,
           `Lat2Text`,
           `Long2Text`,
           `SrcLatLongUnit`,
           `MinElevation`,
           `MaxElevation`,
           `NamedPlace`,
           `RelationToNamedPlace`
         )
         SELECT DISTINCT
                T1.`_DisciplineID`,
                T1.`_GeographyID`,
                T1.`_LocalityName`,
                T1.`_Latitude1`,
                T1.`_Longitude1`,
                T1.`_Latitude2`,
                T1.`_Longitude2`,
                T1.`_LatLongType`,
                T1.`_Lat1Text`,
                T1.`_Long1Text`,
                T1.`_Lat2Text`,
                T1.`_Long2Text`,
                T1.`_SrcLatLongUnit`,
                T1.`MinElevationMeters`,
                T1.`MaxElevationMeters`,
                T1.`NamedPlace`,
                T1.`RelationToNamedPlace`
           FROM `t_imp_locality` T1
                LEFT OUTER JOIN `tmp_locality` T2 
                             ON (T1.`_DisciplineID`       = T2.`DisciplineID`)
                            AND (T1.`_GeographyID`        = T2.`GeographyID`)
                            AND (T1.`_LocalityName`       = T2.`LocalityName`)
                            AND ((T1.`_Latitude1`         = T2.`Latitude1`)   OR (T1.`_Latitude1`  IS NULL AND T2.`Latitude1`  IS NULL))
                            AND ((T1.`_Longitude1`        = T2.`Longitude1`)  OR (T1.`_Longitude1` IS NULL AND T2.`Longitude1` IS NULL))
                            AND ((T1.`_Latitude2`         = T2.`Latitude2`)   OR (T1.`_Latitude2`  IS NULL AND T2.`Latitude2`  IS NULL))
                            AND ((T1.`_Longitude2`        = T2.`Longitude2`)  OR (T1.`_Longitude2` IS NULL AND T2.`Longitude2` IS NULL))
                            AND (COALESCE(T1.`_LatLongType`, '') = COALESCE(T2.`LatLongType`,''))
                            AND (T1.`_SrcLatLongUnit`     = T2.`SrcLatLongUnit`)
                            AND ((T1.`MinElevationMeters` = T2.`MinElevation`) OR (T1.`MinElevationMeters` IS NULL AND T2.`MinElevation` IS NULL))
                            AND ((T1.`MaxElevationMeters` = T2.`MaxElevation`) OR (T1.`MaxElevationMeters` IS NULL AND T2.`MaxElevation` IS NULL))
                            AND (COALESCE(T1.`NamedPlace`, '')           = COALESCE(T2.`NamedPlace`, ''))
                            AND (COALESCE(T1.`RelationToNamedPlace`, '') = COALESCE(T2.`RelationToNamedPlace`, ''))
          WHERE (T1.`_imported` = 0)
            AND (T1.`_error`    = 0)
            AND (T2.`TempID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('locality',8.1,NOW());


  UPDATE `tmp_locality` T1
         INNER JOIN `t_imp_locality` T2 ON (T1.`DisciplineID`   = T2.`_DisciplineID`)
                                       AND (T1.`GeographyID`    = T2.`_GeographyID`)
                                       AND (T1.`LocalityName`   = T2.`_LocalityName`)
                                       AND ((T1.`Latitude1`     = T2.`_Latitude1`)   OR (T1.`Latitude1`  IS NULL AND T2.`_Latitude1`  IS NULL))
                                       AND ((T1.`Longitude1`    = T2.`_Longitude1`)  OR (T1.`Longitude1` IS NULL AND T2.`_Longitude1` IS NULL))
                                       AND ((T1.`Latitude2`     = T2.`_Latitude2`)   OR (T1.`Latitude2`  IS NULL AND T2.`_Latitude2`  IS NULL))
                                       AND ((T1.`Longitude2`    = T2.`_Longitude2`)  OR (T1.`Longitude2` IS NULL AND T2.`_Longitude2` IS NULL))
                                       AND (COALESCE(T1.`LatLongType`, '') = COALESCE(T2.`_LatLongType`,''))
                                       AND (T1.`SrcLatLongUnit` = T2.`_SrcLatLongUnit`)
                                       AND ((T1.`MinElevation`  = T2.`MinElevationMeters`) OR (T1.`MinElevation` IS NULL AND T2.`MinElevationMeters` IS NULL))
                                       AND ((T1.`MaxElevation`  = T2.`MaxElevationMeters`) OR (T1.`MaxElevation` IS NULL AND T2.`MaxElevationMeters` IS NULL))
                                       AND (COALESCE(T1.`NamedPlace`, '')           = COALESCE(T2.`NamedPlace`, ''))
                                       AND (COALESCE(T1.`RelationToNamedPlace`, '') = COALESCE(T2.`RelationToNamedPlace`, ''))
     SET T1.`importguid`        = UUID(),
         T1.`Remarks`           = T2.`Remarks`,
         T1.`TimestampCreated`  = T2.`TimestampCreated`,
         T1.`TimestampModified` = T2.`TimestampModified`,
         T1.`CreatedByAgentID`  = T2.`_CreatedByAgentID`,
         T1.`ModifiedByAgentID` = T2.`_ModifiedByAgentID`
   WHERE (T1.`TimestampCreated` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('locality',8.2,NOW());


  -- check existing localities

  UPDATE `tmp_locality` T1
         INNER JOIN svar_destdb_.`locality` T2 
                 ON (T1.`DisciplineID`   = T2.`DisciplineID`)
                AND (T1.`GeographyID`    = T2.`GeographyID`)
                AND (T1.`LocalityName`   = T2.`LocalityName`)
                AND ((T1.`Latitude1`     = T2.`Latitude1`)   OR (T1.`Latitude1`  IS NULL AND T2.`Latitude1`  IS NULL))
                AND ((T1.`Longitude1`    = T2.`Longitude1`)  OR (T1.`Longitude1` IS NULL AND T2.`Longitude1` IS NULL))
                AND ((T1.`Latitude2`     = T2.`Latitude2`)   OR (T1.`Latitude2`  IS NULL AND T2.`Latitude2`  IS NULL))
                AND ((T1.`Longitude2`    = T2.`Longitude2`)  OR (T1.`Longitude2` IS NULL AND T2.`Longitude2` IS NULL))
                AND (COALESCE(T1.`LatLongType`, '') = COALESCE(T2.`LatLongType`,''))
                AND (T1.`SrcLatLongUnit` = T2.`SrcLatLongUnit`)
                AND ((T1.`MinElevation`  = T2.`MinElevation`) OR (T1.`MinElevation` IS NULL AND T2.`MinElevation` IS NULL))
                AND ((T1.`MaxElevation`  = T2.`MaxElevation`) OR (T1.`MaxElevation` IS NULL AND T2.`MaxElevation` IS NULL))
                AND (COALESCE(T1.`NamedPlace`, '')           = COALESCE(T2.`NamedPlace`, ''))
                AND (COALESCE(T1.`RelationToNamedPlace`, '') = COALESCE(T2.`RelationToNamedPlace`, ''))
     SET T1.`LocalityID` = T2.`LocalityID`
   WHERE (T1.`LocalityID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('locality',8.3,NOW());


  -- insert new localities

  INSERT 
    INTO svar_destdb_.`locality`
         (
           `DisciplineID`,
           `GeographyID`,
           `LocalityName`,
           `Latitude1`,
           `Longitude1`,
           `Latitude2`,
           `Longitude2`,
           `LatLongType`,
           `MinElevation`,
           `MaxElevation`,
           `NamedPlace`,
           `RelationToNamedPlace`,

           `Lat1Text`,
           `Long1Text`,
           `Lat2Text`,
           `Long2Text`,
           `SrcLatLongUnit`,
 
           `Version`,
           `TimestampCreated`,
           `TimestampModified`,
           `CreatedByAgentID`,
           `ModifiedByAgentID`,

           `GUID`
         )
         SELECT `DisciplineID`,
                `GeographyID`,
                `LocalityName`,
                `Latitude1`,
                `Longitude1`,
                `Latitude2`,
                `Longitude2`,
                `LatLongType`,
                `MinElevation`,
                `MaxElevation`,
                `NamedPlace`,
                `RelationToNamedPlace`,

                `Lat1Text`,
                `Long1Text`,
                `Lat2Text`,
                `Long2Text`,
                `SrcLatLongUnit`,

                1,
                `TimestampCreated`,
                `TimestampModified`,
                `CreatedByAgentID`,
                `ModifiedByAgentID`,

                `importguid`
           FROM `tmp_locality`
          WHERE (`LocalityID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('locality',8.4,NOW());

  
  UPDATE `tmp_locality` T1
         INNER JOIN svar_destdb_.`locality` T2 ON (T1.`importguid` = T2.`GUID`)
     SET T1.`LocalityID` = T2.`LocalityID`;

  INSERT INTO `tmp_steps` VALUES ('locality',8.5,NOW());


  UPDATE `t_imp_locality` T1
         INNER JOIN `tmp_locality` T2
                 ON (T1.`_DisciplineID`       = T2.`DisciplineID`)
                AND (T1.`_GeographyID`        = T2.`GeographyID`)
                AND (T1.`_LocalityName`       = T2.`LocalityName`)
                AND ((T1.`_Latitude1`         = T2.`Latitude1`)   OR (T1.`_Latitude1`  IS NULL AND T2.`Latitude1`  IS NULL))
                AND ((T1.`_Longitude1`        = T2.`Longitude1`)  OR (T1.`_Longitude1` IS NULL AND T2.`Longitude1` IS NULL))
                AND ((T1.`_Latitude2`         = T2.`Latitude2`)   OR (T1.`_Latitude2`  IS NULL AND T2.`Latitude2`  IS NULL))
                AND ((T1.`_Longitude2`        = T2.`Longitude2`)  OR (T1.`_Longitude2` IS NULL AND T2.`Longitude2` IS NULL))
                AND (COALESCE(T1.`_LatLongType`, '') = COALESCE(T2.`LatLongType`,''))
                AND ((T1.`MinElevationMeters` = T2.`MinElevation`) OR (T1.`MinElevationMeters` IS NULL AND T2.`MinElevation` IS NULL))
                AND ((T1.`MaxElevationMeters` = T2.`MaxElevation`) OR (T1.`MaxElevationMeters` IS NULL AND T2.`MaxElevation` IS NULL))
                AND (COALESCE(T1.`NamedPlace`, '')           = COALESCE(T2.`NamedPlace`, ''))
                AND (COALESCE(T1.`RelationToNamedPlace`, '') = COALESCE(T2.`RelationToNamedPlace`, ''))
     SET T1.`_LocalityID` = T2.`LocalityID`
   WHERE (T1.`_LocalityID` IS NULL)
     AND (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',8.6,NOW());


  -- checking LocalityID

  UPDATE `t_imp_locality`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid locality id.'
   WHERE (`_GeographyID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',8.7,NOW());


  -- Finalisation

  UPDATE `t_imp_locality` T1
         INNER JOIN svar_destdb_.`locality` T2 ON (T1.`_LocalityID` = T2.`LocalityID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('locality',9,NOW());


  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'locality')
                AND (index_name = 'ix_importlocalityuniquefields'))) THEN
    DROP INDEX ix_importlocalityuniquefields ON svar_destdb_.`locality`;
  END IF;

  INSERT INTO `tmp_steps` VALUES ('locality',255.1,NOW());


  INSERT INTO `tmp_steps` VALUES ('locality',255.2,NOW());
END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportCollectingEvent`;

GO

CREATE PROCEDURE `p_ImportCollectingEvent`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('collectingevent',0,NOW());


  -- CollectionID, DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_collectingevent`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('collectingevent',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',1.2,NOW());


  -- CollectionID, DisciplineID, TimestampCreated, TimestampModified

  UPDATE `t_imp_collectingevent` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`     = T2.`CollectionID`,
         T1.`_DisciplineID`     = T2.`DisciplineID`,
         T1.`key`               = COALESCE(NULLIF(TRIM(T1.`key`), ''),UUID()),
         T1.`TimestampCreated`  = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified` = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`       = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',2,NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_collectingevent`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_collectingevent`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');

  INSERT INTO `tmp_steps` VALUES ('collectingevent',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('collectingevent',3.2,NOW());


  UPDATE `t_imp_collectingevent`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',3.3,NOW());


  UPDATE `t_imp_collectingevent`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',3.4,NOW());


  -- StartDate, StartDatePrecision

  UPDATE `t_imp_collectingevent`
     SET `_StartDate`          = `f_getDate`(`StartYear`,`StartMonth`,`StartDate`),
         `_StartDatePrecision` = `f_getDatePrecision`(`StartYear`,`StartMonth`,`StartDate`)
   WHERE (`_imported` = 0)
     AND ((`StartDate` IS NOT NULL) OR (`StartYear` IS NOT NULL));

  INSERT INTO `tmp_steps` VALUES ('collectingevent',4.1,NOW());


  -- EndDate, EndDatePrecision

  UPDATE `t_imp_collectingevent`
     SET `_EndDate`          = `f_getDate`(`EndYear`,`EndMonth`,`EndDate`),
         `_EndDatePrecision` = `f_getDatePrecision`(`EndYear`,`EndMonth`,`EndDate`)
   WHERE (`_imported` = 0)
     AND ((`EndDate` IS NOT NULL) OR (`EndYear` IS NOT NULL));

  INSERT INTO `tmp_steps` VALUES ('collectingevent',4.2,NOW());


  -- Locality

  INSERT 
    INTO `t_imp_locality`
         (
           `key`,
           `specifycollcode`,

           `Continent`,
           `Country`,
           `State`,
           `County`,
           `LocalityName`,
           `Remarks`,

           `NamedPlace`,
           `RelationToNamedPlace`,

           `LatLongType`,
           `DMSLatitude1`,
           `DDMLatitude1`,
           `DDLatitude1`,
           `DMSLongitude1`,
           `DDMLongitude1`,
           `DDLongitude1`,
           `DMSLatitude2`,
           `DDMLatitude2`,
           `DDLatitude2`,
           `DMSLongitude2`,
           `DDMLongitude2`,
           `DDLongitude2`,

           `MinElevationMeters`,
           `MaxElevationMeters`,

           `_DisciplineID`,
           `_CollectionID`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
       )
       SELECT `_importguid`,
              `specifycollcode`,

              `LocalityContinent`,
              `LocalityCountry`,
              `LocalityState`,
              `LocalityCounty`,
              `LocalityName`,
              `LocalityRemarks`,

              `LocalityNamedPlace`,
              `LocalityRelationToNamedPlace`,

              `LocalityLatLongType`,
              `LocalityDMSLatitude1`,
              `LocalityDDMLatitude1`,
              `LocalityDDLatitude1`,
              `LocalityDMSLongitude1`,
              `LocalityDDMLongitude1`,
              `LocalityDDLongitude1`,
              `LocalityDMSLatitude2`,
              `LocalityDDMLatitude2`,
              `LocalityDDLatitude2`,
              `LocalityDMSLongitude2`,
              `LocalityDDMLongitude2`,
              `LocalityDDLongitude2`,

              `LocalityMinElevationMeters`,
              `LocalityMaxElevationMeters`,

              `_DisciplineID`,
              `_CollectionID`,

              `TimestampCreated`,
              `CreatedByFirstName`,
              `CreatedByLastName`,
              `TimestampModified`,
              `ModifiedByFirstName`,
              `ModifiedByLastName`
         FROM `t_imp_collectingevent`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',5,NOW());


  CALL `p_ImportLocality`;


  -- LocalityID

  UPDATE `t_imp_collectingevent`     T1
         INNER JOIN `t_imp_locality` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_LocalityID` = T2.`_LocalityID`;

  INSERT INTO `tmp_steps` VALUES ('collectingevent',6,NOW());


  -- CollectingEvent 
  -- used column `Method` temporary as identifier

  INSERT 
    INTO svar_destdb_.`collectingevent` 
         (
           `DisciplineID`,
           `LocalityID`,
           `StartDateVerbatim`,
           `StartDate`,
           `StartDatePrecision`,
           `EndDateVerbatim`,
           `EndDate`,
           `EndDatePrecision`,
           `VerbatimDate`,
           `StationFieldNumber`,
           `VerbatimLocality`,
           `Method`,
           `Remarks`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,

           `GUID`
         )
         SELECT `_DisciplineID`,
                `_LocalityID`,
                `StartDateVerbatim`,
                `_StartDate`,
                `_StartDatePrecision`,
                `EndDateVerbatim`,
                `_EndDate`,
                `_EndDatePrecision`,
                `VerbatimDate`,
                `StationFieldNumber`,
                `VerbatimLocality`,
                `Method`,
                `Remarks`,

                1,
                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,

                `_importguid`
           FROM `t_imp_collectingevent`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',7,NOW());

         
  -- CollectingEventID
         
  UPDATE `t_imp_collectingevent` T1
         INNER JOIN svar_destdb_.`collectingevent` T2 ON (T1.`_importguid` = T2.`GUID`)
     SET T1.`_CollectingEventID` = T2.`CollectingEventID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('collectingevent',8.1,NOW());


--  UPDATE svar_destdb_.`collectingevent` T1
--         INNER JOIN `t_imp_collectingevent` T2 ON (T1.`CollectingEventID` = T2.`_CollectingEventID`) 
--     SET T1.`Method` = T2.`Method`
--   WHERE (T2.`_imported` = 0);

--  INSERT INTO `tmp_steps` VALUES ('collectingevent',8.2,NOW());


  -- Finalisation

  UPDATE `t_imp_collectingevent` T1
         INNER JOIN svar_destdb_.`collectingevent` T2 ON (T1.`_CollectingEventID` = T2.`CollectingEventID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectingevent',9,NOW());

END

GO

-- 

DROP PROCEDURE IF EXISTS `p_ImportPaleoContext`;

GO

CREATE PROCEDURE `p_ImportPaleoContext`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('paleocontext',0,NOW());


  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'paleocontext')
                    AND (index_name = 'ix_importpaleocontext'))) THEN
    CREATE INDEX ix_importpaleocontext ON svar_destdb_.`paleocontext` (`Text2`);
  END IF;
  
  INSERT INTO `tmp_steps` VALUES ('paleocontext',0.1,NOW());


  -- CollectionID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_paleocontext`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('paleocontext',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',1.2,NOW());


  -- CollectionID, TimestampCreated, TimestampModified

  UPDATE `t_imp_paleocontext` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`       = T2.`CollectionID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`), ''),UUID()),
         T1.`CreatedByFirstName`  = COALESCE(TRIM(T1.`CreatedByFirstName`), ''),
         T1.`CreatedByLastName`   = COALESCE(TRIM(T1.`CreatedByLastName`), ''),
         T1.`ModifiedByFirstName` = COALESCE(TRIM(T1.`ModifiedByFirstName`), ''),
         T1.`ModifiedByLastName`  = COALESCE(TRIM(T1.`ModifiedByLastName`), ''),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',2,NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, 
                T1.`LastName`,
                T1.`FirstName`
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_collectionobjectattribute`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_collectionobjectattribute`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID` = T2.`CollectionID`)
                                              AND (T1.`LastName`     = COALESCE(T2.`LastName`,''))
                                              AND (T1.`FirstName`    = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (T1.`LastName` <> '');

  INSERT INTO `tmp_steps` VALUES ('paleocontext',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('paleocontext',3.2,NOW());


  UPDATE `t_imp_paleocontext`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',3.3,NOW());


  UPDATE `t_imp_paleocontext`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',3.4,NOW());


  -- Chronostratigraphy

  INSERT 
    INTO `t_imp_geologictimeperiod`
         (
           `key`,
           `specifycollcode`,

           `ErathemEra`,
           `SystemPeriod`,
           `SeriesEpoch`,
           `StageAge`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
       )
       SELECT `_importguid`,
              `specifycollcode`,

              `ChronosStratErathemEra`,
              `ChronosStratSystemPeriod`,
              `ChronosStratSeriesEpoch`,
              `ChronosStratStageAge`,
              `PaleoContextRemarks`,

              `TimestampCreated`,
              `CreatedByFirstName`,
              `CreatedByLastName`,
              `TimestampModified`,
              `ModifiedByFirstName`,
              `ModifiedByLastName`
         FROM `t_imp_paleocontext`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',4.1,NOW());


  CALL `p_ImportGeologicTimePeriod`;


  -- ChronosStratID

  UPDATE `t_imp_paleocontext`     T1
         INNER JOIN `t_imp_geologictimeperiod` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_ChronosStratID` = T2.`_GeologicTimePeriodID`;

  INSERT INTO `tmp_steps` VALUES ('paleocontext',4.2,NOW());


  -- PaleoContext 
  -- used column `Text2` temporary as identifier

  INSERT 
    INTO svar_destdb_.`paleocontext` 
         (
           `ChronosStratID`,
           `ChronosStratEndID`,
           `BioStratID`,
           `LithoStratID`,

           `BottomDistance`,
           `TopDistance`,
           `Direction`, 
           `DistanceUnits`, 
           `PositionState`,
           `Text1`, 
           `YesNo1`,
           `YesNo2`,

           `Remarks`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,

           `Text2`
         )
         SELECT `_ChronosStratID`,
                `_ChronosStratEndID`,
                `_BioStratID`,
                `_LithoStratID`,

                `BottomDistance`,
                `TopDistance`,
                `Direction`, 
                `DistanceUnits`, 
                `PositionState`,
                `Text1`, 
                `YesNo1`,
                `YesNo2`,

                `Remarks`,

                1,
                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,

                `_importguid`
           FROM `t_imp_paleocontext`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',8,NOW());

         
  -- PaleoContextID
         
  UPDATE `t_imp_paleocontext` T1
         INNER JOIN svar_destdb_.`paleocontext` T2 ON (T1.`_importguid` = T2.`Text2`)
     SET T1.`_PaleoContextID` = T2.`PaleoContextID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('paleocontext',9.1,NOW());


  UPDATE svar_destdb_.`paleocontext` T1
         INNER JOIN `t_imp_paleocontext` T2 ON (T1.`PaleoContextID` = T2.`_PaleoContextID`) 
     SET T1.`Text2` = T2.`Text2`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',9.2,NOW());


  -- Finalisation

  UPDATE `t_imp_paleocontext` T1
         INNER JOIN svar_destdb_.`paleocontext` T2 ON (T1.`_PaleoContextID` = T2.`PaleoContextID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('paleocontext',10,NOW());


  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'paleocontext')
                AND (index_name = 'ix_importpaleocontext'))) THEN
    DROP INDEX ix_importpaleocontext ON svar_destdb_.`paleocontext`;
  END IF;
  
  INSERT INTO `tmp_steps` VALUES ('paleocontext',255,NOW());
END

GO

-- import procedure for collection objects

DROP PROCEDURE IF EXISTS `p_ImportCollectionobject`;

GO

CREATE PROCEDURE `p_ImportCollectionobject`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('collectionobject',0,NOW());


  -- CollectionID, DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_collectionobject`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('collectionobject',1.1,NOW());

  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',1.2,NOW());


  -- CollectionID, DisciplineID, TimestampCreated, TimestampModified

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`     = T2.`CollectionID`,
         T1.`_DisciplineID`     = T2.`DisciplineID`,
         T1.`key`               = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`  = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified` = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`       = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',2,NOW());


  -- CollectionID

  UPDATE `t_imp_collectionobject`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid `specifycollcode` value.'
   WHERE (`_CollectionID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',3,NOW());


  -- Agents: Cataloger, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CatalogerLastName`  AS `LastName`,
                        `CatalogerFirstName` AS `FirstName`
                   FROM `t_imp_collectionobject` 
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `CreatedByLastName`,
                        `CreatedByFirstName`
                   FROM `t_imp_collectionobject`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_collectionobject`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');
           
  INSERT INTO `tmp_steps` VALUES ('collectionobject',4.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('collectionobject',4.2,NOW());


  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                    AND (T1.`CatalogerLastName`  = T2.`LastName`)
                                    AND (T1.`CatalogerFirstName` = T2.`FirstName`)
     SET `_CatalogerID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',4.3,NOW());

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                    AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                    AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',4.5,NOW());

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                    AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                    AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',4.6,NOW());


  -- CatalogedDate, CatalogedDatePrecision

  UPDATE `t_imp_collectionobject`
     SET `_CatalogedDate`          = COALESCE(`f_getDate`(`CatalogedYear`,`CatalogedMonth`,`CatalogedDate`),`TimestampCreated`),
         `_CatalogedDatePrecision` = `f_getDatePrecision`(`CatalogedYear`,`CatalogedMonth`,`CatalogedDate`)
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',5,NOW());


  -- Check duplicate cataloge numbers

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN (SELECT `_CollectionID`,
                            `CatalogNumber`
                       FROM `t_imp_collectionobject`
                      WHERE (`_imported` = 0) 
                      GROUP BY `_CollectionID`, `CatalogNumber`
                     HAVING (COUNT(*) > 1)) AS T2 ON (T1.`_CollectionID` = T2.`_CollectionID`)
                                                 AND (T1.`CatalogNumber` = T2.`CatalogNumber`)
     SET `_error`    = 1,
         `_errormsg` = 'Duplicate catalog number in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',6.1,NOW());


  UPDATE `t_imp_collectionobject` T1
         INNER JOIN svar_destdb_.`collectionobject` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                                      AND (T1.`CatalogNumber` = T2.`CatalogNumber`)
     SET `_error`    = 1,
         `_errormsg` = 'Duplicate catalog number.'
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',6.2,NOW());


  -- prepare collecting events for import

  INSERT 
    INTO `t_imp_collectingevent` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `LocalityContinent`,
           `LocalityCountry`,
           `LocalityState`,
           `LocalityCounty`,
           `LocalityName`,
           `LocalityRemarks`,
           `LocalityLatLongType`,
           `LocalityDMSLatitude1`,
           `LocalityDDMLatitude1`,
           `LocalityDDLatitude1`,
           `LocalityDMSLongitude1`,
           `LocalityDDMLongitude1`,
           `LocalityDDLongitude1`,
           `LocalityDMSLatitude2`,
           `LocalityDDMLatitude2`,
           `LocalityDDLatitude2`,
           `LocalityDMSLongitude2`,
           `LocalityDDMLongitude2`,
           `LocalityDDLongitude2`,
           `LocalityMinElevationMeters`,
           `LocalityMaxElevationMeters`,

           `StartDateVerbatim`,
           `StartDate`,
           `StartMonth`,
           `StartYear`,
           `EndDateVerbatim`,
           `EndDate`,
           `EndMonth`,
           `EndYear`,
           `VerbatimDate`,
           `Method`,
           `StationFieldNumber`,
           `VerbatimLocality`,
           `Remarks`,
           
           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `_importguid`,
                `key`,
                `specifycollcode`,

                `CollEventContinent`,
                `CollEventCountry`,
                `CollEventState`,
                `CollEventCounty`,
                `CollEventLocalityName`,
                `CollEventLocalityRemarks`,
                `CollEventLatLongType`,
                `CollEventDMSLatitude1`,
                `CollEventDDMLatitude1`,
                `CollEventDDLatitude1`,
                `CollEventDMSLongitude1`,
                `CollEventDDMLongitude1`,
                `CollEventDDLongitude1`,
                `CollEventDMSLatitude2`,
                `CollEventDDMLatitude2`,
                `CollEventDDLatitude2`,
                `CollEventDMSLongitude2`,
                `CollEventDDMLongitude2`,
                `CollEventDDLongitude2`,
                `CollEventMinElevationMeters`,
                `CollEventMaxElevationMeters`,

                `CollEventStartDateVerbatim`,
                `CollEventStartDate`,
                `CollEventStartMonth`,
                `CollEventStartYear`,
                `CollEventEndDateVerbatim`,
                `CollEventEndDate`,
                `CollEventEndMonth`,
                `CollEventEndYear`,
                `CollEventVerbatimDate`,
                `CollEventMethod`,
                `CollEventStationFieldNumber`,
                `CollEventVerbatimLocality`,
                `CollEventRemarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `t_imp_collectionobject`
          WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',7.1,NOW());


  -- importing collecting events

  CALL `p_ImportCollectingEvent`;


  -- `CollectingEventID`

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `t_imp_collectingevent` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_CollectingEventID` = T2.`_CollectingEventID`
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',7.2,NOW());


  -- prepare palaeocontext for import

  INSERT 
    INTO `t_imp_paleocontext` 
         (
           `key`,
           `collectionobjectkey`,
           `specifycollcode`,

           `ChronosStratErathemEra`,
           `ChronosStratSystemPeriod`,
           `ChronosStratSeriesEpoch`,
           `ChronosStratStageAge`,
           `Remarks`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
         )
         SELECT `_importguid`,
                `key`,
                `specifycollcode`,

                `ChronosStratErathemEra`,
                `ChronosStratSystemPeriod`,
                `ChronosStratSeriesEpoch`,
                `ChronosStratStageAge`,
                `PalaeoContextRemarks`,

                `TimestampCreated`,
                `CreatedByFirstName`,
                `CreatedByLastName`,
                `TimestampModified`,
                `ModifiedByFirstName`,
                `ModifiedByLastName`
           FROM `t_imp_collectionobject`
          WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',8.1,NOW());


  -- importing palaeocontext

  -- CALL `p_ImportPaleocontext`;


  -- `PalaeoContextID`

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `t_imp_paleocontext` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_PaleoContextID` = T2.`_PaleoContextID`
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',8.2,NOW());


  -- `AccessionID`

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `t_imp_accession` T2 ON (T1.`_CollectionID`   = T2.`_CollectionID`)
                                        AND (T1.`AccessionNumber` = T2.`AccessionNumber`)
     SET T1.`_AccessionID` = T2.`_AccessionID`
   WHERE (T1.`_imported` = 0)
     AND (COALESCE(TRIM(T1.`AccessionNumber`), '') <> '');

  INSERT INTO `tmp_steps` VALUES ('collectionobject',9.1,NOW());


  -- `ContainerOwnerID`

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `t_imp_container` T2 ON (T1.`_CollectionID`    = T2.`_CollectionID`)
                                        AND (T1.`OwnerOfContainer` = T2.`Name`)
     SET T1.`_OwnerOfContainerID` = T2.`_ContainerID`
   WHERE (T1.`_imported` = 0)
     AND (COALESCE(TRIM(T1.`OwnerOfContainer`), '') <> '');

  INSERT INTO `tmp_steps` VALUES ('collectionobject',9.2,NOW());


  -- `ContainerID`

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN `t_imp_container` T2 ON (T1.`_CollectionID`    = T2.`_CollectionID`)
                                        AND (T1.`ChildOfContainer` = T2.`Name`)
     SET T1.`_ChildOfContainerID` = T2.`_ContainerID`
   WHERE (T1.`_imported` = 0)
     AND (COALESCE(TRIM(T1.`ChildOfContainer`), '') <> '');

  INSERT INTO `tmp_steps` VALUES ('collectionobject',9.3,NOW());


  -- Specify Import

  INSERT
    INTO svar_destdb_.`collectionobject` 
         (
           `CollectionID`,
           `CollectionMemberID`,
           `CatalogNumber`,
           `AltCatalogNumber`,
           `GUID`,
           `CatalogerID`,
           `CatalogedDate`,
           `CatalogedDatePrecision`,
           `Description`,
           `Remarks`,
           `Availability`,
           `Deaccessioned`,
           `CountAmt`,
           `CollectingEventID`,
           `Visibility`,

           `Text1`,
           `Text2`,
           `Text3`,
           `Integer1`,
           `Integer2`,
           `Number1`,
           `Number2`,
           `YesNo1`,
           `YesNo2`,
           `YesNo3`,
           `YesNo4`,
           `YesNo5`,
           `YesNo6`,

           `AccessionID`,
           `ContainerID`,
           `ContainerOwnerID`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`
         )
         SELECT `_CollectionID`,
                `_CollectionID`,
                `CatalogNumber`,
                `AltCatalogNumber`,
                `_importguid`,
                `_CatalogerID`,
                `_CatalogedDate`,
                `_CatalogedDatePrecision`,
                `Description`,
                `Remarks`,
                `Availability`,
                `Deaccessioned`,
                `CountAmt`,
                `_CollectingEventID`,
                `Visibility`,

                `Text1`,
                `Text2`,
                `Text3`,
                `Integer1`,
                `Integer2`,
                `Number1`,
                `Number2`,
                `YesNo1`,
                `YesNo2`,
                `YesNo3`,
                `YesNo4`,
                `YesNo5`,
                `YesNo6`,

                `_AccessionID`,
                `_OwnerOfContainerID`,
                `_ChildOfContainerID`,

                1,
                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`
           FROM `t_imp_collectionobject`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);
  
  INSERT INTO `tmp_steps` VALUES ('collectionobject',10,NOW());


  -- CollectionObjectID

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN svar_destdb_.`collectionobject` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                                      AND (T1.`_importguid`   = T2.`GUID`)
     SET `_CollectionObjectID` = T2.`CollectionObjectID`
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',11,NOW());


  -- set imported flag

  UPDATE `t_imp_collectionobject` T1
         INNER JOIN svar_destdb_.`collectionobject` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                                      AND (T1.`CatalogNumber` = T2.`CatalogNumber`)
     SET `_imported` = 1
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobject',12,NOW());
END

GO

-- import procedure for other identifiers

DROP PROCEDURE IF EXISTS `p_importOtherIdentifier`;

GO

CREATE PROCEDURE `p_importOtherIdentifier`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('otheridentifier',0,NOW());


  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'otheridentifier')
                    AND (index_name = 'ix_importotheridentifierguid'))) THEN
    CREATE INDEX ix_importotheridentifierguid ON svar_destdb_.`otheridentifier` (`Remarks`(36), `OtherIdentifierID`);
  END IF;

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',0.1,NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_otheridentifier` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`Identifier`          = NULLIF(TRIM(T1.`Identifier`), ''),
         T1.`Institution`         = NULLIF(TRIM(T1.`Institution`), ''),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',1,NOW());


  -- checking relationships

  UPDATE `t_imp_otheridentifier` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',2.1,NOW());


  UPDATE `t_imp_otheridentifier`
     SET `_error`    = 1,
         `_errormsg` = 'Collection object not found.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',2.2,NOW());


  UPDATE `t_imp_otheridentifier`
     SET `_error`    = 1,
         `_errormsg` = 'Identifier cannot be null.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`Identifier` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',2.3,NOW());


  -- Agents: PreparedBy, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_otheridentifier`
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                 UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_otheridentifier`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');
           
  INSERT INTO `tmp_steps` VALUES ('otheridentifier',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',3.2,NOW());


  UPDATE `t_imp_otheridentifier` T1
         INNER JOIN `tmp_agent`  T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                   AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                   AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',3.3,NOW());


  UPDATE `t_imp_otheridentifier` T1
         INNER JOIN `tmp_agent`  T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                   AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                   AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',3.4,NOW());


  -- 

  INSERT 
    INTO svar_destdb_.`otheridentifier`
         (
           `CollectionMemberID`,
           `CollectionObjectID`,

           `Identifier`,
           `Institution`,
           `Remarks`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`
       )
       SELECT `_CollectionID`,
              `_CollectionObjectID`,

              `Identifier`,
              `Institution`,
              `_importguid`,

              1, 
              `TimestampCreated`,
              `_CreatedByAgentID`,
              `TimestampModified`,
              `_ModifiedByAgentID`
         FROM `t_imp_otheridentifier`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',4.1,NOW());


  -- `OtherIdentifierID`

  UPDATE `t_imp_otheridentifier` T1
         INNER JOIN svar_destdb_.`otheridentifier` T2 ON (T1.`_importguid` = T2.`Remarks`)
     SET T1.`_OtherIdentifierID` = T2.`OtherIdentifierID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('otheridentifier',4.2,NOW());


  UPDATE svar_destdb_.`otheridentifier` T1
         INNER JOIN `t_imp_otheridentifier` T2 ON (T1.`OtherIdentifierID` = T2.`_OtherIdentifierID`) 
     SET T1.`Remarks` = T2.`Remarks`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',4.3,NOW());


  -- Finalisation

  UPDATE `t_imp_otheridentifier` T1
         INNER JOIN svar_destdb_.`otheridentifier` T2 ON (T1.`_OtherIdentifierID` = T2.`OtherIdentifierID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',5,NOW());


  -- drop helper

  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'otheridentifier')
                AND (index_name = 'ix_importotheridentifierguid'))) THEN
    DROP INDEX ix_importotheridentifierguid ON svar_destdb_.`otheridentifier`;
  END IF;

  INSERT INTO `tmp_steps` VALUES ('otheridentifier',255,NOW());
END

GO

-- import procedure for reference works

DROP PROCEDURE IF EXISTS `p_importReferencework`;

GO

CREATE PROCEDURE `p_importReferencework`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('referencework',0,NOW());

  DROP TABLE IF EXISTS `tmp_refworktype`;
  CREATE TABLE IF NOT EXISTS `tmp_refworktype`
  (
    `Name`         VARCHAR(64),
    `ID`           INT,

    PRIMARY KEY (`Name`),
    KEY (`ID`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('referencework',0.1,NOW());


  DROP TABLE IF EXISTS `tmp_journal`;
  CREATE TABLE IF NOT EXISTS `tmp_journal`
  (
    `Name`         VARCHAR(255),
    `Abbreviation` VARCHAR(50),
    `ID`           INT,

    PRIMARY KEY (`Name`),
    KEY (`ID`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('referencework',0.2,NOW());


  DROP TABLE IF EXISTS `tmp_refwork`;
  CREATE TABLE IF NOT EXISTS `tmp_refwork`
  (
    `ReferenceWorkTypeID`  INT,
    `Title`                VARCHAR(255),
    `Publisher`            VARCHAR(50),
    `PlaceOfPublication`   VARCHAR(50),
    `WorkDate`             VARCHAR(25),
    `Volume`               VARCHAR(25),
    `Pages`                VARCHAR(50),
    `JournalID`            INT,
    `ContainedRFParentID`  INT,
    `ID`                   INT,

    PRIMARY KEY (`ReferenceWorkTypeID`, `Title`, `Publisher`, `PlaceOfPublication`, `WorkDate`, `Volume`, `Pages`, `JournalID`, `ContainedRFParentID`),
    KEY (`ID`)
  ) ENGINE=INNODB;

  INSERT INTO `tmp_steps` VALUES ('referencework',0.3,NOW());


  -- TimestampCreated, TimestampModified

  UPDATE `t_imp_referencework` T1
     SET T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`Title`               = COALESCE(TRIM(T1.`Title`), ''),
         T1.`Publisher`           = COALESCE(TRIM(T1.`Publisher`), ''),
         T1.`PlaceOfPublication`  = COALESCE(TRIM(T1.`PlaceOfPublication`), ''),
         T1.`WorkDate`            = COALESCE(TRIM(T1.`WorkDate`), ''),
         T1.`Volume`              = COALESCE(TRIM(T1.`Volume`), ''),
         T1.`Pages`               = COALESCE(TRIM(T1.`Pages`), ''),
         T1.`_importguid`         = UUID()
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',1,NOW());


/*

  INSERT INTO `tmp_steps` VALUES ('referencework',2,NOW());
*/


  INSERT 
    INTO `tmp_refworktype` (`Name`)
         SELECT DISTINCT
                T1.`ReferenceWorkType`
           FROM `t_imp_referencework` T1
                LEFT OUTER JOIN `tmp_refworktype` T2 ON (T1.`ReferenceWorkType` = T2.`Name`)
          WHERE (NULLIF(T1.`ReferenceWorkType`, '') IS NOT NULL)
            AND (T2.`ID` IS NULL)
            AND (T1.`_imported`   = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',3.1,NOW());


   UPDATE `tmp_refworktype`
     SET `ID` = `f_getReferenceWorkTypeID`(`Name`)
    WHERE (`ID` IS NULL);

   INSERT INTO `tmp_steps` VALUES ('referencework',3.2,NOW());


  UPDATE `t_imp_referencework` T1
         INNER JOIN `tmp_refworktype` T2 ON (T1.`ReferenceWorkType` = T2.`Name`)
     SET T1.`_ReferenceWorkTypeID` = T2.`ID`
   WHERE (NULLIF(T1.`ReferenceWorkType`, '') IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',3.3,NOW());


  UPDATE `t_imp_referencework`
     SET `_error`    = 1,
         `_errormsg` = 'ReferenceWorkType cannot be null.'
   WHERE (`_ReferenceWorkTypeID` IS NULL) 
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',3.4,NOW());


  INSERT 
    INTO `tmp_journal` (`Name`)
         SELECT DISTINCT
                T1.`JournalName`
           FROM `t_imp_referencework` T1
                LEFT OUTER JOIN `tmp_journal` T2 ON (T1.`JournalName` = T2.`Name`)
          WHERE (T1.`JournalName` IS NOT NULL)
            AND (T2.`ID`          IS NULL)
            AND (T1.`_imported`   = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',4.1,NOW());


  UPDATE `tmp_journal`
     SET `ID` = `f_appendJournal`(`Name`, `Abbreviation`)
    WHERE (`ID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('referencework',4.2,NOW());


  UPDATE `t_imp_referencework` T1
         INNER JOIN `tmp_journal` T2 ON (T1.`JournalName` = T2.`Name`)
     SET T1.`_JournalID` = T2.`ID`
   WHERE (T1.`JournalName` IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',4.3,NOW());


  INSERT 
    INTO `tmp_refwork` 
         (
           `ReferenceWorkTypeID`,
           `Title`,
           `Publisher`,
           `PlaceOfPublication`,
           `WorkDate`,
           `Volume`,
           `Pages`,
           `JournalID`,
           `ContainedRFParentID`
         )
         SELECT DISTINCT
                T1.`_ReferenceWorkTypeID`,
                T1.`Title`,
                T1.`Publisher`,
                T1.`PlaceOfPublication`,
                T1.`WorkDate`,
                T1.`Volume`,
                T1.`Pages`,
                COALESCE(T1.`_JournalID`,0),
                0
           FROM `t_imp_referencework` T1
                LEFT OUTER JOIN `tmp_refwork` T2 ON (T1.`_ReferenceWorkTypeID`              = T2.`ReferenceWorkTypeID`)
                                                AND (T1.`Title`                             = T2.`Title`)
                                                AND (T1.`Publisher`                         = T2.`Publisher`)
                                                AND (T1.`PlaceOfPublication`                = T2.`PlaceOfPublication`)
                                                AND (T1.`WorkDate`                          = T2.`WorkDate`) 
                                                AND (T1.`Volume`                            = T2.`Volume`)
                                                AND (T1.`Pages`                             = T2.`Pages`)
                                                AND (COALESCE(T1.`_JournalID`,0)            = T2.`JournalID`)
                                                AND (COALESCE(T1.`_ContainedRFParentID`, 0) = T2.`ContainedRFParentID`)
          WHERE (T1.`Title` IS NOT NULL)
            AND (T2.`ID`    IS NULL)
            AND (T1.`_error`    = 0)
            AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',5.1,NOW());


  UPDATE `tmp_refwork` T1
         INNER JOIN svar_destdb_.`referencework` T2 ON (T1.`ReferenceWorkTypeID` = T2.`ReferenceWorkType`)
                                                   AND (T1.`Title`               = T2.`Title`)
                                                   AND (T1.`Publisher`           = COALESCE(T2.`Publisher`, ''))
                                                   AND (T1.`PlaceOfPublication`  = COALESCE(T2.`PlaceOfPublication`, ''))
                                                   AND (T1.`WorkDate`            = COALESCE(T2.`WorkDate`, '')) 
                                                   AND (T1.`Volume`              = COALESCE(T2.`Volume`, ''))
                                                   AND (T1.`Pages`               = COALESCE(T2.`Pages`, ''))
                                                   AND (T1.`JournalID`           = COALESCE(T2.`JournalID`, 0))
                                                   AND (T1.`ContainedRFParentID` = COALESCE(T2.`ContainedRFParentID`, 0))
     SET T1.`ID` = T2.`ReferenceWorkID`
   WHERE (T1.`ID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('referencework',5.2,NOW());


  INSERT 
    INTO svar_destdb_.`referencework`
         (
           `ReferenceWorkType`,
           `Title`,
           `Publisher`,
           `PlaceOfPublication`,
           `WorkDate`,
           `Volume`,
           `Pages`,
           `JournalID`,
           `ContainedRFParentID`,
           `TimestampCreated`,
           `Version`
         )
        SELECT `ReferenceWorkTypeID`,
               `Title`,
               `Publisher`,
               `PlaceOfPublication`,
               `WorkDate`,
               `Volume`,
               `Pages`,
               NULLIF(`JournalID`, 0),
               NULLIF(`ContainedRFParentID`, 0),
               NOW(),
               1
          FROM `tmp_refwork`
         WHERE (`ID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('referencework',5.3,NOW());


  UPDATE `tmp_refwork` T1
         INNER JOIN svar_destdb_.`referencework` T2 ON (T1.`ReferenceWorkTypeID` = T2.`ReferenceWorkType`)
                                                   AND (T1.`Title`               = T2.`Title`)
                                                   AND (T1.`Publisher`           = COALESCE(T2.`Publisher`, ''))
                                                   AND (T1.`PlaceOfPublication`  = COALESCE(T2.`PlaceOfPublication`, ''))
                                                   AND (T1.`WorkDate`            = COALESCE(T2.`WorkDate`, '')) 
                                                   AND (T1.`Volume`              = COALESCE(T2.`Volume`, ''))
                                                   AND (T1.`Pages`               = COALESCE(T2.`Pages`, ''))
                                                   AND (T1.`JournalID`           = COALESCE(T2.`JournalID`, 0))
                                                   AND (T1.`ContainedRFParentID` = COALESCE(T2.`ContainedRFParentID`, 0))
     SET T1.`ID` = T2.`ReferenceWorkID`
   WHERE (T1.`ID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('referencework',5.4,NOW());


   UPDATE `t_imp_referencework` T1
          INNER JOIN `tmp_refwork` T2 ON (T1.`_ReferenceWorkTypeID`              = T2.`ReferenceWorkTypeID`)
                                     AND (T1.`Title`                             = T2.`Title`)
                                     AND (T1.`Publisher`                         = T2.`Publisher`)
                                     AND (T1.`PlaceOfPublication`                = T2.`PlaceOfPublication`)
                                     AND (T1.`WorkDate`                          = T2.`WorkDate`) 
                                     AND (T1.`Volume`                            = T2.`Volume`)
                                     AND (T1.`Pages`                             = T2.`Pages`)
                                     AND (COALESCE(T1.`_JournalID`,0)            = T2.`JournalID`)
                                     AND (COALESCE(T1.`_ContainedRFParentID`, 0) = T2.`ContainedRFParentID`)

     SET T1.`_ReferenceWorkID` = T2.`ID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',5.5,NOW());


  -- Finalisation

  UPDATE `t_imp_referencework` T1
         INNER JOIN svar_destdb_.`referencework` T2 ON (T1.`_ReferenceWorkID` = T2.`ReferenceWorkID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('referencework',6,NOW());


  -- drop import helper

  DROP TABLE IF EXISTS `tmp_refwork`;
  DROP TABLE IF EXISTS `tmp_journal`;
  DROP TABLE IF EXISTS `tmp_refworktype`;

  INSERT INTO `tmp_steps` VALUES ('referencework',255,NOW());
END

GO

-- import procedure for collection object citations

DROP PROCEDURE IF EXISTS `p_importCollectionobjectCitation`;

GO

CREATE PROCEDURE `p_importCollectionobjectCitation`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',0,NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_collectionobjectcitation` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',1,NOW());


  -- checking relationships

  UPDATE `t_imp_collectionobjectcitation` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',2.1,NOW());


  UPDATE `t_imp_collectionobjectcitation` T1
         LEFT OUTER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Collection object not found.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`key` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',2.2,NOW());


  -- Agents: PreparedBy, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_collectionobjectcitation`
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                 UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_collectionobjectcitation`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');
           
  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',3.2,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                    AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                    AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',3.3,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                    AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                    AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',3.4,NOW());


  -- ReferenceWork

  INSERT 
    INTO `t_imp_referencework`
         (
           `key`,

           `ReferenceWorkType`,
           `Title`,
           `Publisher`,
           `PlaceOfPublication`,
           `WorkDate`,
           `Volume`,
           `Pages`,
           `JournalName`,
           `JournalAbbreviation`,
           `LibraryNumber`,
           `ISBN`,
           `GUID`,
           `URL`,
           `IsPublished`,
           `Remarks`,
           `Text1`,
           `Text2`,
           `Number1`,
           `Number2`,
           `YesNo1`,
           `YesNo2`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
       )
       SELECT `_importguid`,

              `RefWorkType`,
              `RefWorkTitle`,
              `RefWorkPublisher`,
              `RefWorkPlaceOfPublication`,
              `RefWorkWorkDate`,
              `RefWorkVolume`,
              `RefWorkPages`,
              `RefWorkJournalName`,
              `RefWorkJournalAbbreviation`,
              `RefWorkLibraryNumber`,
              `RefWorkISBN`,
              `RefWorkGUID`,
              `RefWorkURL`,
              `RefWorkIsPublished`,
              `RefWorkRemarks`,
              `RefWorkText1`,
              `RefWorkText2`,
              `RefWorkNumber1`,
              `RefWorkNumber2`,
              `RefWorkYesNo1`,
              `RefWorkYesNo2`,

              `TimestampCreated`,
              `CreatedByFirstName`,
              `CreatedByLastName`,
              `TimestampModified`,
              `ModifiedByFirstName`,
              `ModifiedByLastName`
         FROM `t_imp_collectionobjectcitation`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',4.1,NOW());


  CALL `p_ImportReferenceWork`;


  -- ...


  -- `ReferenceWorkID`

  UPDATE `t_imp_collectionobjectcitation` T1
         INNER JOIN `t_imp_referencework` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_ReferenceWorkID` = T2.`_ReferenceWorkID`
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',5.1,NOW());


  UPDATE `t_imp_collectionobjectcitation`
     SET `_error`    = 1,
         `_errormsg` = 'ReferenceWorkID canot be null.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_ReferenceWorkID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',5.2,NOW());


  INSERT 
    INTO svar_destdb_.`collectionobjectcitation`
         (
           `CollectionMemberID`,
           `CollectionObjectID`,

           `ReferenceWorkID`,
           `IsFigured`,
           `Remarks`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`
       )
       SELECT `_CollectionID`,
              `_CollectionObjectID`,

              `_ReferenceWorkID`,
              `IsFigured`,
              `_importguid`,

              1, 
              `TimestampCreated`,
              `_CreatedByAgentID`,
              `TimestampModified`,
              `_ModifiedByAgentID`
         FROM `t_imp_collectionobjectcitation`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',6.1,NOW());


  UPDATE `t_imp_collectionobjectcitation` T1
         INNER JOIN svar_destdb_.`collectionobjectcitation` T2 ON (T1.`_importguid` = T2.`Remarks`)
     SET T1.`_CollectionObjectCitationID` = T2.`CollectionObjectCitationID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',6.2,NOW());


  UPDATE svar_destdb_.`collectionobjectcitation` T1
         INNER JOIN `t_imp_collectionobjectcitation` T2 ON (T1.`CollectionObjectCitationID` = T2.`_CollectionObjectCitationID`) 
     SET T1.`Remarks` = T2.`Remarks`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',6.3,NOW());


  -- Finalisation

  UPDATE `t_imp_collectionobjectcitation` T1
         INNER JOIN svar_destdb_.`collectionobjectcitation` T2 ON (T1.`_CollectionObjectCitationID` = T2.`CollectionObjectCitationID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectcitation',7,NOW());
END

GO

-- import procedure for collectors

DROP PROCEDURE IF EXISTS `p_ImportCollector`;

GO

CREATE PROCEDURE `p_ImportCollector`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('collector',0,NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_collector` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`_CollectingEventID`  = T2.`_CollectingEventID`,
         T1.`FirstName`           = COALESCE(TRIM(T1.`FirstName`), ''),
         T1.`LastName`            = COALESCE(TRIM(T1.`LastName`), ''),
         T1.`CreatedByFirstName`  = COALESCE(TRIM(T1.`CreatedByFirstName`), ''),
         T1.`CreatedByLastName`   = COALESCE(TRIM(T1.`CreatedByLastName`), ''),
         T1.`ModifiedByFirstName` = COALESCE(TRIM(T1.`ModifiedByFirstName`), ''),
         T1.`ModifiedByLastName`  = COALESCE(TRIM(T1.`ModifiedByLastName`), ''),
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',1,NOW());


  -- DivisionID

  UPDATE `tmp_collection`
     SET `DivisionID` = `f_getDivisionID`(`specifycollcode`)
   WHERE (`DivisionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collector',2.1,NOW());


  UPDATE `t_imp_collector` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
     SET T1.`_DivisionID` = T2.`DivisionID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',2.2,NOW());


  -- checking relationships

  UPDATE `t_imp_collector` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0)
     AND (T2.`_error` = 1);

  INSERT INTO `tmp_steps` VALUES ('collector',3.1,NOW());


  UPDATE `t_imp_collector`
     SET `_error`    = 1,
         `_errormsg` = 'Collection object not found.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collector',3.2,NOW());


  UPDATE `t_imp_collector` T1
         INNER JOIN `t_imp_collectingevent` T2 ON (T1.`_CollectingEventID` = T2.`_CollectingEventID`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectingevent.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('collector',3.3,NOW());


  UPDATE `t_imp_collector`
     SET `_error`    = 1,
         `_errormsg` = 'CollectingEvent object not found.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_CollectingEventID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collector',3.4,NOW());


  -- Agents: Determiner, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, 
                T1.`LastName`,
                T1.`FirstName`
           FROM (SELECT DISTINCT
                        `_CollectionID` AS `CollectionID`,
                        `LastName`,
                        `FirstName`
                   FROM `t_imp_collector` 
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `CreatedByLastName`,
                        `CreatedByFirstName`
                   FROM `t_imp_collector`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_collector`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID` = T2.`CollectionID`)
                                              AND (T1.`LastName`     = T2.`LastName`)
                                              AND (T1.`FirstName`    = T2.`FirstName`)
          WHERE (T2.`AgentID` IS NULL)
            AND (T1.`LastName` <> '');

  INSERT INTO `tmp_steps` VALUES ('collector',4.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('collector',4.2,NOW());


  UPDATE `t_imp_collector`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                  AND (T1.`LastName`      = T2.`LastName`)
                                  AND (T1.`FirstName`     = T2.`FirstName`)
     SET `_AgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',4.3,NOW());


  UPDATE `t_imp_collector` T1
     SET `_error`    = 1,
         `_errormsg` = 'AgentID cannot be null.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_AgentID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collector',4.4,NOW());


  UPDATE `t_imp_collector` T1
         INNER JOIN (SELECT `_CollectingEventID`, 
                            `_AgentID`,
                            MIN(`_importguid`) AS `exception_importguid`
                       FROM `t_imp_collector`
                      WHERE (`_imported` = 0)
                        AND (`_error`    = 0)
                      GROUP BY `_CollectingEventID`, `_AgentID`
                     HAVING (COUNT(*) > 1)) AS T2
                 ON (T1.`_CollectingEventID` = T2.`_CollectingEventID`)
                AND (T1.`_AgentID`           = T2.`_AgentID`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Duplicate collectors name.'
   WHERE (T1.`_importguid` <> T2.`exception_importguid`);

  INSERT INTO `tmp_steps` VALUES ('collector',4.5,NOW());


  UPDATE `t_imp_collector`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);


  INSERT INTO `tmp_steps` VALUES ('collector',4.6,NOW());

  UPDATE `t_imp_collector`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',4.7,NOW());


  -- `OrderNumber` / `_OrderNumber`

  UPDATE `t_imp_collector` T1
         INNER JOIN (-- ROW_NUMBER per Partition: Brian Steffens
                     -- http://briansteffens.com/2011/07/19/row_number-partition-and-over-in-mysql/
                     SELECT @id := if(@lastid != `_CollectingEventID`, 1, @id + 1) as row_number,
                            @lastid := `_CollectingEventID` AS `_CollectingEventID`,
                            `_importguid`
                      FROM `t_imp_collector` I1,
                           (select @id := 0) I2,
                           (select @lastid := null) I3
                     ORDER BY `_CollectingEventID`) T2 ON (T1.`_importguid` = T2.`_importguid`)
     SET `_OrderNumber` =  `row_number`
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',5,NOW());


  -- Specify Import

  INSERT 
    INTO svar_destdb_.`collector` 
         (
           `DivisionID`,
           `CollectingEventID`,
           
           `OrderNumber`,
           `AgentID`,
           `IsPrimary`,
           `Remarks`,
           
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,
           `Version`
         )
         SELECT `_DivisionID`,
                `_CollectingEventID`,

                `_OrderNumber`,
                `_AgentID`,
                `IsPrimary`,
                `Remarks`,

                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,
                1
           FROM `t_imp_collector`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);
         
  INSERT INTO `tmp_steps` VALUES ('collector',6,NOW());


  -- CollectionObjectID

  UPDATE `t_imp_collector` T1
         INNER JOIN svar_destdb_.`collector` T2 ON (T1.`_CollectingEventID` = T2.`CollectingEventID`)
                                               AND (T1.`_OrderNumber`       = T2.`OrderNumber`)
                                               AND (T1.`_AgentID`           = T2.`AgentID`)
     SET T1.`_CollectorID` = T2.`CollectorID`
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',7,NOW());


  -- set imported flag

  UPDATE `t_imp_collector` T1
         INNER JOIN svar_destdb_.`collector` T2 ON (T1.`_CollectorID` = T2.`CollectorID`)
     SET `_imported` = 1
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collector',8,NOW());

END

GO

-- import procedure for kingdom taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon10`;

GO

CREATE PROCEDURE `p_ImportTaxon10`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon10', 0, NOW());

  -- Kingdom

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_KingdomParentID`,
                10,
                `Kingdom`, 
                `KingdomAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 10)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 10, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_KingdomParentID` = T2.`ParentID`)
                                  AND (T1.`Kingdom`          = T2.`Name`)
                                  AND (T1.`KingdomAuthor`    = T2.`Author`)
     SET T1.`_KingdomID`        = T2.`TaxonID`,
         T1.`_TaxonID`          = T2.`TaxonID`,
         T1.`_DivisionParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 10)
     AND (T1.`_TaxonRankID` >= 10)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_DivisionParentID` = `_KingdomParentID`
   WHERE (`_DivisionParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon10', 1.6, NOW());
END

GO

-- import procedure for division taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon20`;

GO

CREATE PROCEDURE `p_ImportTaxon20`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon20', 0, NOW());

  -- Division

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_DivisionParentID`,
                20,
                `Division`, 
                `DivisionAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 20)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 20, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_DivisionParentID` = T2.`ParentID`)
                                  AND (T1.`Division`          = T2.`Name`)
                                  AND (T1.`DivisionAuthor`    = T2.`Author`)
     SET T1.`_DivisionID`     = T2.`TaxonID`,
         T1.`_TaxonID`        = T2.`TaxonID`,
         T1.`_PhylumParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 20)
     AND (T1.`_TaxonRankID` >= 20)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_PhylumParentID` = `_DivisionParentID`
   WHERE (`_PhylumParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon20', 1.6, NOW());
END

GO

-- import procedure for phylum taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon30`;

GO

CREATE PROCEDURE `p_ImportTaxon30`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon30', 0, NOW());

  -- Phylum

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_PhylumParentID`,
                30,
                `Phylum`, 
                `PhylumAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 30)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 30, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_PhylumParentID` = T2.`ParentID`)
                                  AND (T1.`Phylum`          = T2.`Name`)
                                  AND (T1.`PhylumAuthor`    = T2.`Author`)
     SET T1.`_PhylumID`          = T2.`TaxonID`,
         T1.`_TaxonID`           = T2.`TaxonID`,
         T1.`_SubphylumParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 30)
     AND (T1.`_TaxonRankID` >= 30)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SubphylumParentID` = `_PhylumParentID`
   WHERE (`_SubphylumParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon30', 1.6, NOW());
END

GO

-- import procedure for subphylum taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon40`;

GO

CREATE PROCEDURE `p_ImportTaxon40`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon40', 0, NOW());

  -- Subphylum

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SubphylumParentID`,
                40,
                `Subphylum`, 
                `SubphylumAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 40)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 40, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SubphylumParentID` = T2.`ParentID`)
                                  AND (T1.`Subphylum`          = T2.`Name`)
                                  AND (T1.`SubphylumAuthor`    = T2.`Author`)
     SET T1.`_SubphylumID`        = T2.`TaxonID`,
         T1.`_TaxonID`            = T2.`TaxonID`,
         T1.`_SuperclassParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 40)
     AND (T1.`_TaxonRankID` >= 40)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SuperclassParentID` = `_SubphylumParentID`
   WHERE (`_SuperclassParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon40', 1.6, NOW());
END

GO

-- import procedure for superclass taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon50`;

GO

CREATE PROCEDURE `p_ImportTaxon50`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon50', 0, NOW());

  -- Superclass

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SuperclassParentID`,
                50,
                `Superclass`, 
                `SuperclassAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 50)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 50, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SuperclassParentID` = T2.`ParentID`)
                                  AND (T1.`Superclass`          = T2.`Name`)
                                  AND (T1.`SuperclassAuthor`    = T2.`Author`)
     SET T1.`_SuperclassID`  = T2.`TaxonID`,
         T1.`_TaxonID`       = T2.`TaxonID`,
         T1.`_ClassParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 50)
     AND (T1.`_TaxonRankID` >= 50)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_ClassParentID` = `_SuperclassParentID`
   WHERE (`_ClassParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon50', 1.6, NOW());
END

GO

-- import procedure for class taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon60`;

GO

CREATE PROCEDURE `p_ImportTaxon60`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon60', 0, NOW());

  -- Class

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_ClassParentID`,
                60,
                `Class`, 
                `ClassAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 60)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 60, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_ClassParentID` = T2.`ParentID`)
                                  AND (T1.`Class`          = T2.`Name`)
                                  AND (T1.`ClassAuthor`    = T2.`Author`)
     SET T1.`_ClassID`          = T2.`TaxonID`,
         T1.`_TaxonID`          = T2.`TaxonID`,
         T1.`_SubclassParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 60)
     AND (T1.`_TaxonRankID` >= 60)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SubclassParentID` = `_ClassParentID`
   WHERE (`_SubclassParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon60', 1.6, NOW());
END

GO

-- import procedure for subclass taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon70`;

GO

CREATE PROCEDURE `p_ImportTaxon70`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon70', 0, NOW());

  -- Subclass

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SubclassParentID`,
                70,
                `Subclass`, 
                `SubclassAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 70)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 70, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SubclassParentID` = T2.`ParentID`)
                                  AND (T1.`Subclass`          = T2.`Name`)
                                  AND (T1.`SubclassAuthor`    = T2.`Author`)
     SET T1.`_SubclassID`         = T2.`TaxonID`,
         T1.`_TaxonID`            = T2.`TaxonID`,
         T1.`_InfraclassParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 70)
     AND (T1.`_TaxonRankID` >= 70)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_InfraclassParentID` = `_SubclassParentID`
   WHERE (`_InfraclassParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon70', 1.6, NOW());
END

GO

-- import procedure for infraclass taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon80`;

GO

CREATE PROCEDURE `p_ImportTaxon80`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon80', 0, NOW());

  -- Infraclass

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_InfraclassParentID`,
                80,
                `Infraclass`, 
                `InfraclassAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 80)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 80, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_InfraclassParentID` = T2.`ParentID`)
                                  AND (T1.`Infraclass`          = T2.`Name`)
                                  AND (T1.`InfraclassAuthor`    = T2.`Author`)
     SET T1.`_InfraclassID`       = T2.`TaxonID`,
         T1.`_TaxonID`            = T2.`TaxonID`,
         T1.`_SuperorderParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 80)
     AND (T1.`_TaxonRankID` >= 80)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SuperorderParentID` = `_InfraclassParentID`
   WHERE (`_SuperorderParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon80', 1.6, NOW());
END

GO

-- import procedure for superorder taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon90`;

GO

CREATE PROCEDURE `p_ImportTaxon90`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon90', 0, NOW());

  -- Superorder

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SuperorderParentID`,
                90,
                `Superorder`, 
                `SuperorderAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 90)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 90, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SuperorderParentID` = T2.`ParentID`)
                                  AND (T1.`Superorder`          = T2.`Name`)
                                  AND (T1.`SuperorderAuthor`    = T2.`Author`)
     SET T1.`_SuperorderID`  = T2.`TaxonID`,
         T1.`_TaxonID`       = T2.`TaxonID`,
         T1.`_OrderParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 90)
     AND (T1.`_TaxonRankID` >= 90)
     AND (T1.`_imported`     =  0)
     AND (T1.`_error`        =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_OrderParentID` = `_SuperorderParentID`
   WHERE (`_OrderParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon90', 1.6, NOW());
END

GO

-- import procedure for order taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon100`;

GO

CREATE PROCEDURE `p_ImportTaxon100`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon100', 0, NOW());

  -- Order

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_OrderParentID`,
                100,
                `Order`, 
                `OrderAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 100)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 100, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_OrderParentID` = T2.`ParentID`)
                                  AND (T1.`Order`          = T2.`Name`)
                                  AND (T1.`OrderAuthor`    = T2.`Author`)
     SET T1.`_OrderID`          = T2.`TaxonID`,
         T1.`_TaxonID`          = T2.`TaxonID`,
         T1.`_SuborderParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 100)
     AND (T1.`_TaxonRankID` >= 100)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SuborderParentID` = `_OrderParentID`
   WHERE (`_SuborderParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon100', 1.6, NOW());
END

GO

-- import procedure for suborder taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon110`;

GO

CREATE PROCEDURE `p_ImportTaxon110`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon110', 0, NOW());

  -- Suborder

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SuborderParentID`,
                110,
                `Suborder`, 
                `SuborderAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 110)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 110, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SuborderParentID` = T2.`ParentID`)
                                  AND (T1.`Suborder`          = T2.`Name`)
                                  AND (T1.`SuborderAuthor`    = T2.`Author`)
     SET T1.`_SuborderID`         = T2.`TaxonID`,
         T1.`_TaxonID`            = T2.`TaxonID`,
         T1.`_InfraorderParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 110)
     AND (T1.`_TaxonRankID` >= 110)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_InfraorderParentID` = `_SuborderParentID`
   WHERE (`_InfraorderParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon110', 1.6, NOW());
END

GO

-- import procedure for infraorder taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon120`;

GO

CREATE PROCEDURE `p_ImportTaxon120`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon120', 0, NOW());

  -- Infraorder

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_InfraorderParentID`,
                120,
                `Infraorder`, 
                `InfraorderAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 120)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 120, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_InfraorderParentID` = T2.`ParentID`)
                                  AND (T1.`Infraorder`          = T2.`Name`)
                                  AND (T1.`InfraorderAuthor`    = T2.`Author`)
     SET T1.`_InfraorderID`        = T2.`TaxonID`,
         T1.`_TaxonID`             = T2.`TaxonID`,
         T1.`_SuperfamilyParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 120)
     AND (T1.`_TaxonRankID` >= 120)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SuperfamilyParentID` = `_InfraorderParentID`
   WHERE (`_SuperfamilyParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon120', 1.6, NOW());
END

GO

-- import procedure for superfamily taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon130`;

GO

CREATE PROCEDURE `p_ImportTaxon130`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon130', 0, NOW());

  -- Superfamily

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SuperfamilyParentID`,
                130,
                `Superfamily`, 
                `SuperfamilyAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 130)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 130, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SuperfamilyParentID` = T2.`ParentID`)
                                  AND (T1.`Superfamily`          = T2.`Name`)
                                  AND (T1.`SuperfamilyAuthor`    = T2.`Author`)
     SET T1.`_SuperfamilyID`  = T2.`TaxonID`,
         T1.`_TaxonID`        = T2.`TaxonID`,
         T1.`_FamilyParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 130)
     AND (T1.`_TaxonRankID` >= 130)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_FamilyParentID` = `_SuperfamilyParentID`
   WHERE (`_FamilyParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon130', 1.6, NOW());
END

GO

-- import procedure for family taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon140`;

GO

CREATE PROCEDURE `p_ImportTaxon140`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon140', 0, NOW());

  -- Family

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_FamilyParentID`,
                140,
                `Family`, 
                `FamilyAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 140)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 140, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_FamilyParentID` = T2.`ParentID`)
                                  AND (T1.`Family`          = T2.`Name`)
                                  AND (T1.`FamilyAuthor`    = T2.`Author`)
     SET T1.`_FamilyID`          = T2.`TaxonID`,
         T1.`_TaxonID`           = T2.`TaxonID`,
         T1.`_SubfamilyParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 140)
     AND (T1.`_TaxonRankID` >= 140)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SubfamilyParentID` = `_FamilyParentID`
   WHERE (`_SubfamilyParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon140', 1.6, NOW());
END

GO

-- import procedure for subfamily taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon150`;

GO

CREATE PROCEDURE `p_ImportTaxon150`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon150', 0, NOW());

  -- Subfamily

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SubfamilyParentID`,
                150,
                `Subfamily`, 
                `SubfamilyAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 150)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 150, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SubfamilyParentID` = T2.`ParentID`)
                                  AND (T1.`Subfamily`          = T2.`Name`)
                                  AND (T1.`SubfamilyAuthor`    = T2.`Author`)
     SET T1.`_SubfamilyID`   = T2.`TaxonID`,
         T1.`_TaxonID`       = T2.`TaxonID`,
         T1.`_TribeParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 150)
     AND (T1.`_TaxonRankID` >= 150)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_TribeParentID` = `_SubfamilyParentID`
   WHERE (`_TribeParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon150', 1.6, NOW());
END

GO

-- import procedure for tribe taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon160`;

GO

CREATE PROCEDURE `p_ImportTaxon160`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon160', 0, NOW());

  -- Tribe

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_TribeParentID`,
                160,
                `Tribe`, 
                `TribeAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 160)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 160, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_TribeParentID` = T2.`ParentID`)
                                  AND (T1.`Tribe`          = T2.`Name`)
                                  AND (T1.`TribeAuthor`    = T2.`Author`)
     SET T1.`_TribeID`          = T2.`TaxonID`,
         T1.`_TaxonID`          = T2.`TaxonID`,
         T1.`_SubtribeParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 160)
     AND (T1.`_TaxonRankID` >= 160)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SubtribeParentID` = `_TribeParentID`
   WHERE (`_SubtribeParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon160', 1.6, NOW());
END

GO

-- import procedure for subtribe taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon170`;

GO

CREATE PROCEDURE `p_ImportTaxon170`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon170', 0, NOW());

  -- Subtribe

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SubtribeParentID`,
                170,
                `Subtribe`, 
                `SubtribeAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 170)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 170, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SubtribeParentID` = T2.`ParentID`)
                                  AND (T1.`Subtribe`          = T2.`Name`)
                                  AND (T1.`SubtribeAuthor`    = T2.`Author`)
     SET T1.`_SubtribeID`    = T2.`TaxonID`,
         T1.`_TaxonID`       = T2.`TaxonID`,
         T1.`_GenusParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 170)
     AND (T1.`_TaxonRankID` >= 170)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_GenusParentID` = `_SubtribeParentID`
   WHERE (`_GenusParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon170', 1.6, NOW());
END

GO

-- import procedure for genus taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon180`;

GO

CREATE PROCEDURE `p_ImportTaxon180`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon180', 0, NOW());

  -- Genus

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_GenusParentID`,
                180,
                `Genus`, 
                `GenusAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 180)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 180, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_GenusParentID` = T2.`ParentID`)
                                  AND (T1.`Genus`          = T2.`Name`)
                                  AND (T1.`GenusAuthor`    = T2.`Author`)
     SET T1.`_GenusID`          = T2.`TaxonID`,
         T1.`_TaxonID`          = T2.`TaxonID`,
         T1.`_SubgenusParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 180)
     AND (T1.`_TaxonRankID` >= 180)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SubgenusParentID` = `_GenusParentID`
   WHERE (`_SubgenusParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon180', 1.6, NOW());
END

GO

-- import procedure for subgenus taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon190`;

GO

CREATE PROCEDURE `p_ImportTaxon190`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon190', 0, NOW());

  -- Subgenus

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SubgenusParentID`,
                190,
                `Subgenus`, 
                `SubgenusAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 190)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 190, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SubgenusParentID` = T2.`ParentID`)
                                  AND (T1.`Subgenus`          = T2.`Name`)
                                  AND (T1.`SubgenusAuthor`    = T2.`Author`)
     SET T1.`_SubgenusID`      = T2.`TaxonID`,
         T1.`_TaxonID`         = T2.`TaxonID`,
         T1.`_SpeciesParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 190)
     AND (T1.`_TaxonRankID` >= 190)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SpeciesParentID` = `_SubgenusParentID`
   WHERE (`_SpeciesParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon190', 1.6, NOW());
END

GO

-- import procedure for species taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon220`;

GO

CREATE PROCEDURE `p_ImportTaxon220`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon220', 0, NOW());

  -- Species

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SpeciesParentID`,
                220,
                `Species`, 
                `SpeciesAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 220)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 220, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SpeciesParentID` = T2.`ParentID`)
                                  AND (T1.`Species`          = T2.`Name`)
                                  AND (T1.`SpeciesAuthor`    = T2.`Author`)
     SET T1.`_SpeciesID`          = T2.`TaxonID`,
         T1.`_TaxonID`            = T2.`TaxonID`,
         T1.`_SubspeciesParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 220)
     AND (T1.`_TaxonRankID` >= 220)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.5, NOW());


  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_SubspeciesParentID` = `_SpeciesParentID`
   WHERE (`_SubspeciesParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon220', 1.6, NOW());
END

GO

-- import procedure for subspecies taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon230`;

GO

CREATE PROCEDURE `p_ImportTaxon230`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon230', 0, NOW());

  -- Subspecies

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_SubspeciesParentID`,
                230,
                `Subspecies`, 
                `SubspeciesAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 230)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 230, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_SubspeciesParentID` = T2.`ParentID`)
                                  AND (T1.`Subspecies`          = T2.`Name`)
                                  AND (T1.`SubspeciesAuthor`    = T2.`Author`)
     SET T1.`_SubspeciesID`      = T2.`TaxonID`,
         T1.`_TaxonID`           = T2.`TaxonID`,
         T1.`_VariationParentID` = T2.`TaxonID`
   WHERE (T2.`RankID`        = 230)
     AND (T1.`_TaxonRankID` >= 230)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.5, NOW());

  -- skipped parents

  UPDATE `t_imp_taxon`
     SET `_VariationParentID` = `_SubspeciesParentID`
   WHERE (`_VariationParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon230', 1.6, NOW());
END

GO

-- import procedure for variation taxa 

DROP PROCEDURE IF EXISTS `p_ImportTaxon240`;

GO

CREATE PROCEDURE `p_ImportTaxon240`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon240', 0, NOW());

  -- Variation

  INSERT 
    INTO tmp_taxon 
         (
           `TaxonTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`,
           `Author`
         )
         SELECT DISTINCT
                `_TaxonTreeDefID`,
                `_VariationParentID`,
                240,
                `Variation`, 
                `VariationAuthor`
           FROM `t_imp_taxon`
          WHERE (`_TaxonRankID` >= 240)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('taxon240', 1.1, NOW());


  -- update existing entries

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonTreeDefID` = T2.`TaxonTreeDefID`)
                                           AND (T1.`ParentID`       = T2.`ParentID`)
                                           AND (T1.`RankID`         = T2.`RankID`)
                                           AND (T1.`Name`           = T2.`Name`)
                                           AND (T1.`Author`         = COALESCE(T2.`Author`, ''))
     SET T1.`TaxonID` = T2.`TaxonID`
   WHERE (T1.`TaxonID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('taxon240', 1.2, NOW());


  -- insert new entries

  UPDATE tmp_taxon
     SET `TaxonID` = `f_appendTaxon`(`TaxonTreeDefID`, `ParentID`, 240, `Name`, `Author`)
   WHERE (`TaxonID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon240', 1.3, NOW());


  -- delete empty taxa

  DELETE 
    FROM tmp_taxon
   WHERE (`ParentID` = `TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon240', 1.31, NOW());


  -- Specify names

  UPDATE tmp_taxon T1
         INNER JOIN svar_destdb_.`taxon` T2 ON (T1.`TaxonID` = T2.`TaxonID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`TaxonID`);

  INSERT INTO `tmp_steps` VALUES ('taxon240', 1.4, NOW());


  -- save values in t_imp_taxon

  UPDATE `t_imp_taxon` T1 
         INNER JOIN `tmp_taxon` T2 ON (T1.`_VariationParentID` = T2.`ParentID`)
                                  AND (T1.`Variation`          = T2.`Name`)
                                  AND (T1.`VariationAuthor`    = T2.`Author`)
     SET T1.`_VariationID` = T2.`TaxonID`,
         T1.`_TaxonID`     = T2.`TaxonID`
   WHERE (T2.`RankID`        = 240)
     AND (T1.`_TaxonRankID` >= 240)
     AND (T1.`_imported`     =   0)
     AND (T1.`_error`        =   0);

  INSERT INTO `tmp_steps` VALUES ('taxon240', 1.5, NOW());
END

GO

-- import procedure for taxa

DROP PROCEDURE IF EXISTS `p_ImportTaxon`;

GO

CREATE PROCEDURE `p_ImportTaxon`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('taxon',0,NOW());


  -- CollectionID, DisciplineID

  INSERT 
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_taxon`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('taxon',1.1,NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon',1.2,NOW());


  UPDATE `t_imp_taxon` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_CollectionID`     = T2.`CollectionID`,
         T1.`_DisciplineID`     = T2.`DisciplineID`,
         T1.`key`               = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`_importguid`       = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',1.3,NOW());


  UPDATE `t_imp_taxon`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid `specifycollcode` value.'
   WHERE (`_CollectionID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',1.4,NOW());


  UPDATE `tmp_collection`
     SET `TaxonTreeDefID` = `f_GetTaxonTreeDefID`(`specifycollcode`)
   WHERE (`TaxonTreeDefID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon',1.5,NOW());


  UPDATE `tmp_collection`
     SET `TaxonRootID` = `f_GetTaxonRootID`(`specifycollcode`)
   WHERE (`TaxonRootID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('taxon',1.6,NOW());


  -- Taxon rank

  UPDATE `t_imp_taxon`
     SET `_TaxonRankID` = CASE 
                            WHEN (COALESCE(TRIM(`variation`)  ,'') > '') THEN 240
                            WHEN (COALESCE(TRIM(`subspecies`) ,'') > '') THEN 230
                            WHEN (COALESCE(TRIM(`species`)    ,'') > '') THEN 220
                            WHEN (COALESCE(TRIM(`subgenus`)   ,'') > '') THEN 190
                            WHEN (COALESCE(TRIM(`genus`)      ,'') > '') THEN 180
                            WHEN (COALESCE(TRIM(`subtribe`)   ,'') > '') THEN 170
                            WHEN (COALESCE(TRIM(`tribe`)      ,'') > '') THEN 160
                            WHEN (COALESCE(TRIM(`subfamily`)  ,'') > '') THEN 150
                            WHEN (COALESCE(TRIM(`family`)     ,'') > '') THEN 140
                            WHEN (COALESCE(TRIM(`superfamily`),'') > '') THEN 130
                            WHEN (COALESCE(TRIM(`infraorder`) ,'') > '') THEN 120
                            WHEN (COALESCE(TRIM(`suborder`)   ,'') > '') THEN 110
                            WHEN (COALESCE(TRIM(`order`)      ,'') > '') THEN 100
                            WHEN (COALESCE(TRIM(`superorder`) ,'') > '') THEN 90
                            WHEN (COALESCE(TRIM(`infraclass`) ,'') > '') THEN 80
                            WHEN (COALESCE(TRIM(`subclass`)   ,'') > '') THEN 70
                            WHEN (COALESCE(TRIM(`class`)      ,'') > '') THEN 60
                            WHEN (COALESCE(TRIM(`superclass`) ,'') > '') THEN 50
                            WHEN (COALESCE(TRIM(`subphylum`)  ,'') > '') THEN 40
                            WHEN (COALESCE(TRIM(`phylum`)     ,'') > '') THEN 30
                            WHEN (COALESCE(TRIM(`division`)   ,'') > '') THEN 20
                            WHEN (COALESCE(TRIM(`kingdom`)    ,'') > '') THEN 10
                            ELSE 0
                          END
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',2.1,NOW());


  UPDATE `t_imp_taxon`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid taxon rank.'
   WHERE (`_TaxonRankID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',2.2,NOW());


  -- TaxonTreeDefID, Parent of Kingdom

  UPDATE `t_imp_taxon` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_TaxonTreeDefID`  = T2.`TaxonTreeDefID`,
         T1.`_KingdomParentID` = T2.`TaxonRootID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',3.1,NOW());


  UPDATE `t_imp_taxon`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid TaxonTreeDefID.'
   WHERE (`_TaxonTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',3.2,NOW());


  UPDATE `t_imp_taxon`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid Kingdom parent id.'
   WHERE (`_TaxonTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',3.3,NOW());


  CALL `p_ImportTaxon10`;
  CALL `p_ImportTaxon20`;
  CALL `p_ImportTaxon30`;
  CALL `p_ImportTaxon40`;
  CALL `p_ImportTaxon50`;
  CALL `p_ImportTaxon60`;
  CALL `p_ImportTaxon70`;
  CALL `p_ImportTaxon80`;
  CALL `p_ImportTaxon90`;
  CALL `p_ImportTaxon100`;
  CALL `p_ImportTaxon110`;
  CALL `p_ImportTaxon120`;
  CALL `p_ImportTaxon130`;
  CALL `p_ImportTaxon140`;
  CALL `p_ImportTaxon150`;
  CALL `p_ImportTaxon160`;
  CALL `p_ImportTaxon170`;
  CALL `p_ImportTaxon180`;
  CALL `p_ImportTaxon190`;
  CALL `p_ImportTaxon220`;
  CALL `p_ImportTaxon230`;
  CALL `p_ImportTaxon240`;


  -- set imported flag

  UPDATE `t_imp_taxon`
     SET `_imported` = 1
   WHERE (`_TaxonID` IS NOT NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('taxon',4,NOW());
END

GO

-- import procedure for determinations

DROP PROCEDURE IF EXISTS `p_ImportDetermination`;

GO

CREATE PROCEDURE `p_ImportDetermination`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('determination',0,NOW());


  -- CollecionID, CollectionObjectID, DisciplineID, TimestampCreated, TimestampModified

  UPDATE `t_imp_determination` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`_DisciplineID`       = T2.`_DisciplineID`,
         T1.`_TypeStatusName`     = NULLIF(TRIM(T1.`TypeStatusName`), ''),
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',1,NOW());


  -- checking relationships

  UPDATE `t_imp_determination` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('determination',2.1,NOW());


  UPDATE `t_imp_determination` T1
         LEFT OUTER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Collection object not found.'
   WHERE (T1.`_imported` = 0)
     AND (T2.`key` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('determination',2.2,NOW());


  -- Agents: Determiner, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`       AS `CollectionID`,
                        `DeterminerLastName`  AS `LastName`,
                        `DeterminerFirstName` AS `FirstName`
                   FROM `t_imp_determination` 
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `CreatedByLastName`,
                        `CreatedByFirstName`
                   FROM `t_imp_determination`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_determination`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID` = T2.`CollectionID`)
                                              AND (COALESCE(T1.`LastName`,  '') = COALESCE(T2.`LastName`,  ''))
                                              AND (COALESCE(T1.`FirstName`, '') = COALESCE(T2.`FirstName`, ''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');

  INSERT INTO `tmp_steps` VALUES ('determination',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('determination',3.2,NOW());

  UPDATE `t_imp_determination`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`DeterminerLastName`  = T2.`LastName`)
                                  AND (T1.`DeterminerFirstName` = T2.`FirstName`)
     SET `_DeterminerID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',3.3,NOW());


  UPDATE `t_imp_determination`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);


  INSERT INTO `tmp_steps` VALUES ('determination',3.4,NOW());

  UPDATE `t_imp_determination`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',3.5,NOW());


  -- DeterminedDate, DeterminedDatePrecision

  UPDATE `t_imp_determination`
     SET `_DeterminedDate`          = `f_getDate`(`DeterminedYear`,`DeterminedMonth`,`DeterminedDate`),
         `_DeterminedDatePrecision` = `f_getDatePrecision`(`DeterminedYear`,`DeterminedMonth`,`DeterminedDate`)
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',4,NOW());


  -- `TypeStatusName`

  INSERT
    INTO `tmp_typestatus` (`CollectionID`, `TypeStatusName`)
         SELECT DISTINCT
                T1.`_CollectionID`,
                T1.`_TypeStatusName`
           FROM `t_imp_determination` T1
                LEFT OUTER JOIN `tmp_typestatus` T2 ON (T1.`_CollectionID`   = T2.`CollectionID`)
                                                   AND (T1.`_TypeStatusName` = T2.`TypeStatusName`)
          WHERE (T1.`_TypeStatusName` IS NOT NULL)
            AND (T2.`TypeStatusValue` IS NULL)
            AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',5.1,NOW());


  UPDATE `tmp_typestatus`
     SET `TypeStatusValue` = `f_appendTypeStatus`(`TypeStatusName`, `CollectionID`)
    WHERE (`TypeStatusValue` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('determination',5.2,NOW());


  UPDATE `t_imp_determination` T1
         INNER JOIN `tmp_typestatus` T2 ON (T1.`_CollectionID`   = T2.`CollectionID`)
                                       AND (T1.`_TypeStatusName` = T2.`TypeStatusName`)
     SET T1.`_TypeStatusValue` = T2.`TypeStatusValue`
   WHERE (T1.`_TypeStatusName` IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',5.3,NOW());


  -- Taxa

  INSERT 
    INTO t_imp_taxon 
         (
           `key`,
           `specifycollcode`,

           `Kingdom`,
           `KingdomAuthor`,
           `Division`,
           `DivisionAuthor`,
           `Phylum`,
           `PhylumAuthor`,
           `Subphylum`,
           `SubphylumAuthor`,
           `Superclass`,
           `SuperclassAuthor`,
           `Class`,
           `ClassAuthor`,
           `Subclass`,
           `SubclassAuthor`,
           `Infraclass`,
           `InfraclassAuthor`,
           `Superorder`,
           `SuperorderAuthor`,
           `Order`,
           `OrderAuthor`,
           `Suborder`,
           `SuborderAuthor`,
           `Infraorder`,
           `InfraorderAuthor`,
           `Superfamily`,
           `SuperfamilyAuthor`,
           `Family`,
           `FamilyAuthor`,
           `Subfamily`,
           `SubfamilyAuthor`,
           `Tribe`,
           `TribeAuthor`,
           `Subtribe`,
           `SubtribeAuthor`,
           `Genus`,
           `GenusAuthor`,
           `Subgenus`,
           `SubgenusAuthor`,
           `Species`,
           `SpeciesAuthor`,
           `Subspecies`,
           `SubspeciesAuthor`,
           `Variation`,
           `VariationAuthor`
         )
         SELECT `_importguid`,
                `specifycollcode`,

                `Kingdom`,
                `KingdomAuthor`,
                `Division`,
                `DivisionAuthor`,
                `Phylum`,
                `PhylumAuthor`,
                `Subphylum`,
                `SubphylumAuthor`,
                `Superclass`,
                `SuperclassAuthor`,
                `Class`,
                `ClassAuthor`,
                `Subclass`,
                `SubclassAuthor`,
                `Infraclass`,
                `InfraclassAuthor`,
                `Superorder`,
                `SuperorderAuthor`,
                `Order`,
                `OrderAuthor`,
                `Suborder`,
                `SuborderAuthor`,
                `Infraorder`,
                `InfraorderAuthor`,
                `Superfamily`,
                `SuperfamilyAuthor`,
                `Family`,
                `FamilyAuthor`,
                `Subfamily`,
                `SubfamilyAuthor`,
                `Tribe`,
                `TribeAuthor`,
                `Subtribe`,
                `SubtribeAuthor`,
                `Genus`,
                `GenusAuthor`,
                `Subgenus`,
                `SubgenusAuthor`,
                `Species`,
                `SpeciesAuthor`,
                `Subspecies`,
                `SubspeciesAuthor`,
                `Variation`,
                `VariationAuthor`
           FROM `t_imp_determination`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',6,NOW());


  -- Taxa Import

  CALL `p_ImportTaxon`;


  -- TaxonID

  UPDATE `t_imp_determination` T1
         INNER JOIN `t_imp_taxon` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_TaxonID` = T2.`_TaxonID`
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',7,NOW());


  -- Specify Import
  -- `_importguid` is a temporary Identifier in column `Method`

  INSERT 
    INTO svar_destdb_.`determination` 
         (
           `CollectionMemberID`,
           `CollectionObjectID`,
           `TaxonID`,
           `Addendum`,
           `Qualifier`,
           `SubSpQualifier`,
           `VarQualifier`,
           `TypeStatusName`,
           `DeterminerID`,
           `DeterminedDate`,
           `DeterminedDatePrecision`,
           `IsCurrent`,
           `Remarks`,

           `Method`,
           `AlternateName`,
           `Confidence`,
           `FeatureOrBasis`,
           `NameUsage`,
           `Number1`,
           `Number2`,
           `Text1`,
           `Text2`,
           `YesNo1`,
           `YesNo2`,

           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,
           `Version`,
           `GUID`
         )
         SELECT `_CollectionID`,
                `_CollectionObjectID`,
                `_TaxonID`,
                `Addendum`,
                `Qualifier`,
                `SubSpQualifier`,
                `VarQualifier`,
                `_TypeStatusValue`,
                `_DeterminerID`,
                `_DeterminedDate`,
                `_DeterminedDatePrecision`,
                `IsCurrent`,
                `Remarks`,

                `Method`,
                `AlternateName`,
                `Confidence`,
                `FeatureOrBasis`,
                `NameUsage`,
                `Number1`,
                `Number2`,
                `Text1`,
                `Text2`,
                `YesNo1`,
                `YesNo2`,

                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,
                0,
                `_importguid`
           FROM `t_imp_determination`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',8,NOW());

  /*
  PreferredTaxonID int(11)
  */

  -- DeterminationID
         
  UPDATE `t_imp_determination` T1
         INNER JOIN svar_destdb_.`determination` T2 ON (T1.`_importguid` = T2.`GUID`)
     SET T1.`_DeterminationID` = T2.`DeterminationID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('determination',9,NOW());


  -- Finalisation

  UPDATE `t_imp_determination` T1
         INNER JOIN svar_destdb_.`determination` T2 ON (T1.`_DeterminationID` = T2.`DeterminationID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('determination',10,NOW());

END

GO

-- import procedure for determination citations
-- currently unused, not tested

DROP PROCEDURE IF EXISTS `p_importDeterminationCitation`;

GO

CREATE PROCEDURE `p_importDeterminationCitation`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('determinationcitation',0,NOW());


  -- CollecionID, DeterminationID, TimestampCreated, TimestampModified

  UPDATE `t_imp_determinationcitation` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_DeterminationID` = T2.`_DeterminationID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',1,NOW());


  -- checking relationships

  UPDATE `t_imp_determinationcitation` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_determination.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',2.1,NOW());


  UPDATE `t_imp_determinationcitation` T1
         LEFT OUTER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Determination object not found.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`key` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',2.2,NOW());


  -- Agents: PreparedBy, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_determinationcitation`
                  WHERE (`_imported` = 0) 
                    AND (`_error`    = 0)
                 UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_determinationcitation`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');
           
  INSERT INTO `tmp_steps` VALUES ('determinationcitation',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',3.2,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                    AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                    AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',3.3,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                    AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                    AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',3.4,NOW());


  -- ReferenceWork

  INSERT 
    INTO `t_imp_referencework`
         (
           `key`,

           `ReferenceWorkType`,
           `Title`,
           `Publisher`,
           `PlaceOfPublication`,
           `WorkDate`,
           `Volume`,
           `Pages`,
           `JournalName`,
           `JournalAbbreviation`,
           `LibraryNumber`,
           `ISBN`,
           `GUID`,
           `URL`,
           `IsPublished`,
           `Remarks`,
           `Text1`,
           `Text2`,
           `Number1`,
           `Number2`,
           `YesNo1`,
           `YesNo2`,

           `TimestampCreated`,
           `CreatedByFirstName`,
           `CreatedByLastName`,
           `TimestampModified`,
           `ModifiedByFirstName`,
           `ModifiedByLastName`
       )
       SELECT `_importguid`,

              `RefWorkType`,
              `RefWorkTitle`,
              `RefWorkPublisher`,
              `RefWorkPlaceOfPublication`,
              `RefWorkWorkDate`,
              `RefWorkVolume`,
              `RefWorkPages`,
              `RefWorkJournalName`,
              `RefWorkJournalAbbreviation`,
              `RefWorkLibraryNumber`,
              `RefWorkISBN`,
              `RefWorkGUID`,
              `RefWorkURL`,
              `RefWorkIsPublished`,
              `RefWorkRemarks`,
              `RefWorkText1`,
              `RefWorkText2`,
              `RefWorkNumber1`,
              `RefWorkNumber2`,
              `RefWorkYesNo1`,
              `RefWorkYesNo2`,

              `TimestampCreated`,
              `CreatedByFirstName`,
              `CreatedByLastName`,
              `TimestampModified`,
              `ModifiedByFirstName`,
              `ModifiedByLastName`
         FROM `t_imp_determinationcitation`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',4.1,NOW());


  CALL `p_ImportReferenceWork`;


  -- ...


  -- `ReferenceWorkID`

  UPDATE `t_imp_determinationcitation` T1
         INNER JOIN `t_imp_referencework` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_ReferenceWorkID` = T2.`_ReferenceWorkID`
   WHERE (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',5.1,NOW());


  UPDATE `t_imp_determinationcitation`
     SET `_error`    = 1,
         `_errormsg` = 'ReferenceWorkID canot be null.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_ReferenceWorkID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',5.2,NOW());


  INSERT 
    INTO svar_destdb_.`determinationcitation`
         (
           `CollectionMemberID`,
           `DeterminationID`,

           `ReferenceWorkID`,
           `IsFigured`,
           `Remarks`,

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`
       )
       SELECT `_CollectionID`,
              `_DeterminationID`,

              `_ReferenceWorkID`,
              `IsFigured`,
              `_importguid`,

              1, 
              `TimestampCreated`,
              `_CreatedByAgentID`,
              `TimestampModified`,
              `_ModifiedByAgentID`
         FROM `t_imp_determinationcitation`
        WHERE (`_imported` = 0)
          AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',6.1,NOW());


  UPDATE `t_imp_determinationcitation` T1
         INNER JOIN svar_destdb_.`determinationcitation` T2 ON (T1.`_importguid` = T2.`Remarks`)
     SET T1.`_DeterminationCitationID` = T2.`DeterminationCitationID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('determinationcitation',6.2,NOW());


  UPDATE svar_destdb_.`determinationcitation` T1
         INNER JOIN `t_imp_determinationcitation` T2 ON (T1.`DeterminationCitationID` = T2.`_DeterminationCitationID`) 
     SET T1.`Remarks` = T2.`Remarks`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',6.3,NOW());


  -- Finalisation

  UPDATE `t_imp_determinationcitation` T1
         INNER JOIN svar_destdb_.`determinationcitation` T2 ON (T1.`_DeterminationCitationID` = T2.`DeterminationCitationID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('determinationcitation',7,NOW());
END

GO

-- import procedure for building entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage100`;

GO

CREATE PROCEDURE `p_ImportStorage100`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage100',0,NOW());

 
  -- Building

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_BuildingParentID`,
                100,
                `Building`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 100)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage100', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage100', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 100, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage100', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage100', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage100', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_BuildingParentID` = T2.`ParentID`)
                                    AND (T1.`Building`          = T2.`Name`)
     SET T1.`_BuildingID`         = T2.`StorageID`,
         T1.`_StorageID`          = T2.`StorageID`,
         T1.`_CollectionParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 100)
     AND (T1.`_StorageRankID` >= 100)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage100', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_CollectionParentID` = `_BuildingParentID`
   WHERE (`_CollectionParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage100', 1.7, NOW());
END

GO

-- import procedure for collection entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage150`;

GO

CREATE PROCEDURE `p_ImportStorage150`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage150',0,NOW());

 
  -- Collection

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_CollectionParentID`,
                150,
                `Collection`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 150)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage150', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage150', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 150, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage150', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage150', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage150', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_CollectionParentID` = T2.`ParentID`)
                                    AND (T1.`Collection`          = T2.`Name`)
     SET T1.`_CollectionID` = T2.`StorageID`,
         T1.`_StorageID`    = T2.`StorageID`,
         T1.`_RoomParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 150)
     AND (T1.`_StorageRankID` >= 150)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage150', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_RoomParentID` = `_CollectionParentID`
   WHERE (`_RoomParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage150', 1.7, NOW());
END

GO

-- import procedure for room entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage200`;

GO

CREATE PROCEDURE `p_ImportStorage200`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage200',0,NOW());

 
  -- Room

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_RoomParentID`,
                200,
                `Room`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 200)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage200', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage200', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 200, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage200', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage200', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage200', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_RoomParentID` = T2.`ParentID`)
                                    AND (T1.`Room`          = T2.`Name`)
     SET T1.`_RoomID`        = T2.`StorageID`,
         T1.`_StorageID`     = T2.`StorageID`,
         T1.`_AisleParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 200)
     AND (T1.`_StorageRankID` >= 200)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage200', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_AisleParentID` = `_RoomParentID`
   WHERE (`_AisleParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage200', 1.7, NOW());
END

GO

-- import procedure for aisle entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage250`;

GO

CREATE PROCEDURE `p_ImportStorage250`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage250',0,NOW());

 
  -- Aisle

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_AisleParentID`,
                250,
                `Aisle`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 250)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage250', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage250', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 250, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage250', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage250', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage250', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_AisleParentID` = T2.`ParentID`)
                                    AND (T1.`Aisle`          = T2.`Name`)
     SET T1.`_AisleID`         = T2.`StorageID`,
         T1.`_StorageID`       = T2.`StorageID`,
         T1.`_CabinetParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 250)
     AND (T1.`_StorageRankID` >= 250)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage250', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_CabinetParentID` = `_AisleParentID`
   WHERE (`_CabinetParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage250', 1.7, NOW());
END

GO


-- import procedure for cabinet entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage300`;

GO

CREATE PROCEDURE `p_ImportStorage300`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage300',0,NOW());

 
  -- Cabinet

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_CabinetParentID`,
                300,
                `Cabinet`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 300)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage300', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage300', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 300, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage300', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage300', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage300', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_CabinetParentID` = T2.`ParentID`)
                                    AND (T1.`Cabinet`          = T2.`Name`)
     SET T1.`_CabinetID`     = T2.`StorageID`,
         T1.`_StorageID`     = T2.`StorageID`,
         T1.`_ShelfParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 300)
     AND (T1.`_StorageRankID` >= 300)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage300', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_ShelfParentID` = `_CabinetParentID`
   WHERE (`_ShelfParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage300', 1.7, NOW());
END

GO

-- import procedure for shelf entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage350`;

GO

CREATE PROCEDURE `p_ImportStorage350`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage350', 0, NOW());

 
  -- Shelf

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_ShelfParentID`,
                350,
                `Shelf`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 350)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage350', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage350', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 350, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage350', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage350', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage350', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_ShelfParentID` = T2.`ParentID`)
                                    AND (T1.`Shelf`          = T2.`Name`)
     SET T1.`_ShelfID`     = T2.`StorageID`,
         T1.`_StorageID`   = T2.`StorageID`,
         T1.`_BoxParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 350)
     AND (T1.`_StorageRankID` >= 350)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage350', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_BoxParentID` = `_ShelfParentID`
   WHERE (`_BoxParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage350', 1.7, NOW());
END

GO

-- import procedure for box entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage400`;

GO

CREATE PROCEDURE `p_ImportStorage400`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage400', 0, NOW());

 
  -- Box

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_BoxParentID`,
                400,
                `Box`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 400)
            AND (`_imported`      =  0)
            AND (`_error`         =  0);

  INSERT INTO `tmp_steps` VALUES ('storage400', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage400', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 400, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage400', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage400', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage400', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_BoxParentID` = T2.`ParentID`)
                                    AND (T1.`Box`          = T2.`Name`)
     SET T1.`_BoxID`        = T2.`StorageID`,
         T1.`_StorageID`    = T2.`StorageID`,
         T1.`_RackParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 400)
     AND (T1.`_StorageRankID` >= 400)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage400', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_RackParentID` = `_BoxParentID`
   WHERE (`_RackParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage400', 1.7, NOW());
END

GO

-- import procedure for rack entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage450`;

GO

CREATE PROCEDURE `p_ImportStorage450`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage450',0,NOW());

 
  -- Rack

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_RackParentID`,
                450,
                `Rack`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 450)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage450', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage450', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 450, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage450', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage450', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage450', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_RackParentID` = T2.`ParentID`)
                                    AND (T1.`Rack`          = T2.`Name`)
     SET T1.`_RackID`       = T2.`StorageID`,
         T1.`_StorageID`    = T2.`StorageID`,
         T1.`_VialParentID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 450)
     AND (T1.`_StorageRankID` >= 450)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage450', 1.6, NOW());


  -- skipped parents

  UPDATE `t_imp_storage`
     SET `_VialParentID` = `_RackParentID`
   WHERE (`_VialParentID` IS NULL) 
     AND (`_imported`    =  0)
     AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage450', 1.7, NOW());
END

GO

-- import procedure for vial entries in the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage500`;

GO

CREATE PROCEDURE `p_ImportStorage500`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage500',0,NOW());

 
  -- Vial

  INSERT 
    INTO `tmp_storage`
         (
           `StorageTreeDefID`,
           `ParentID`,
           `RankID`,
           `Name`
         )
         SELECT DISTINCT
                `_StorageTreeDefID`,
                `_VialParentID`,
                500,
                `Vial`
           FROM `t_imp_storage`
          WHERE (`_StorageRankID` >= 500)
            AND (`_imported`    =  0)
            AND (`_error`       =  0);

  INSERT INTO `tmp_steps` VALUES ('storage500', 1.1, NOW());


  -- update existing entries

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageTreeDefID` = T2.`StorageTreeDefID`)
                                             AND (T1.`ParentID`         = T2.`ParentID`)
                                             AND (T1.`RankID`           = T2.`RankID`)
                                             AND (T1.`Name`             = T2.`Name`)
     SET T1.`StorageID` = T2.`StorageID`
   WHERE (T1.`StorageID` IS NULL);
     
  INSERT INTO `tmp_steps` VALUES ('storage500', 1.2, NOW());


  -- insert new entries

  UPDATE `tmp_storage`
     SET `StorageID` = `f_appendStorage`(`StorageTreeDefID`, `ParentID`, 500, `Name`)
   WHERE (`StorageID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage500', 1.3, NOW());


  -- delete empty entries

  DELETE 
    FROM `tmp_storage`
   WHERE (`ParentID` = `StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage500', 1.4, NOW());


  -- Specify names

  UPDATE `tmp_storage` T1
         INNER JOIN svar_destdb_.`storage` T2 ON (T1.`StorageID` = T2.`StorageID`)
     SET T1.`SpecifyName` = T2.`Name`
   WHERE (T1.`SpecifyName` IS NULL)
     AND (T1.`ParentID` <> T1.`StorageID`);

  INSERT INTO `tmp_steps` VALUES ('storage500', 1.5, NOW());


  -- save values in t_imp_storage

  UPDATE `t_imp_storage` T1 
         INNER JOIN `tmp_storage` T2 ON (T1.`_VialParentID` = T2.`ParentID`)
                                    AND (T1.`Vial`          = T2.`Name`)
     SET T1.`_VialID`    = T2.`StorageID`,
         T1.`_StorageID` = T2.`StorageID`
   WHERE (T2.`RankID`          = 500)
     AND (T1.`_StorageRankID` >= 500)
     AND (T1.`_imported`       =  0)
     AND (T1.`_error`          =  0);

  INSERT INTO `tmp_steps` VALUES ('storage500', 1.6, NOW());


END

GO

-- import procedure for the storage tree

DROP PROCEDURE IF EXISTS `p_ImportStorage`;

GO

CREATE PROCEDURE `p_ImportStorage`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('storage', 0, NOW());

 
  -- `StorageTreeDefID`
  
  INSERT
    INTO `tmp_collection` (`specifycollcode`)
         SELECT DISTINCT
                `specifycollcode`
           FROM `t_imp_storage`
          WHERE (`specifycollcode` NOT IN (SELECT `specifycollcode`
                                             FROM `tmp_collection`))
            AND (`_imported` = 0);
           
  INSERT INTO `tmp_steps` VALUES ('storage', 1.1, NOW());


  UPDATE `tmp_collection`
     SET `CollectionID` = `f_getCollectionID`(`specifycollcode`),
         `DisciplineID` = `f_getDisciplineID`(`specifycollcode`)
   WHERE (`CollectionID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage', 1.2, NOW());


  UPDATE `tmp_collection`
     SET `StorageTreeDefID` = `f_GetStorageTreeDefID`(`specifycollcode`)
   WHERE (`StorageTreeDefID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage', 1.3, NOW());


  UPDATE `tmp_collection`
     SET `StorageRootID` = `f_GetStorageRootID`(`StorageTreeDefID`)
   WHERE (`StorageRootID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('storage', 1.4, NOW());


  UPDATE `t_imp_storage` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_StorageTreeDefID` = T2.`StorageTreeDefID`,
         T1.`key`               = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`_importguid`       = UUID()
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 1.5, NOW());


  UPDATE `t_imp_storage`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid `specifycollcode` value.'
   WHERE (`_StorageTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 1.6, NOW());


  -- Storage rank

  UPDATE `t_imp_storage`
     SET `_StorageRankID` = CASE 
                                WHEN (COALESCE(TRIM(`Vial`)       ,'') > '') THEN 500
                                WHEN (COALESCE(TRIM(`Rack`)       ,'') > '') THEN 450
                                WHEN (COALESCE(TRIM(`Box`)        ,'') > '') THEN 400
                                WHEN (COALESCE(TRIM(`Shelf`)      ,'') > '') THEN 350
                                WHEN (COALESCE(TRIM(`Cabinet`)    ,'') > '') THEN 300
                                WHEN (COALESCE(TRIM(`Aisle`)      ,'') > '') THEN 250
                                WHEN (COALESCE(TRIM(`Room`)       ,'') > '') THEN 200
                                WHEN (COALESCE(TRIM(`Collection`) ,'') > '') THEN 150
                                WHEN (COALESCE(TRIM(`Building`)   ,'') > '') THEN 100
                                ELSE 0
                              END
   WHERE (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 2.1, NOW());


  UPDATE `t_imp_storage`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid storage rank.'
   WHERE (`_StorageRankID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 2.2, NOW());


  -- StorageTreeDefID, Parent of Building

  UPDATE `t_imp_storage` T1
         INNER JOIN `tmp_collection` T2 ON (T1.`specifycollcode` = T2.`specifycollcode`)
     SET T1.`_StorageTreeDefID` = T2.`StorageTreeDefID`,
         T1.`_BuildingParentID` = T2.`StorageRootID`,
         T1.`_StorageID`        = T2.`StorageRootID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('storage',3.1,NOW());


  UPDATE `t_imp_storage`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid StorageTreeDefID.'
   WHERE (`_StorageTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 3.2, NOW());


  UPDATE `t_imp_storage`
     SET `_error`    = 1,
         `_errormsg` = 'Invalid Building parent id.'
   WHERE (`_StorageTreeDefID` IS NULL)
     AND (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 3.3, NOW());


  CALL `p_ImportStorage100`;
  CALL `p_ImportStorage150`;
  CALL `p_ImportStorage200`;
  CALL `p_ImportStorage250`;
  CALL `p_ImportStorage300`;
  CALL `p_ImportStorage350`;
  CALL `p_ImportStorage400`;
  CALL `p_ImportStorage450`;
  CALL `p_ImportStorage500`;


  -- set imported flag

  UPDATE `t_imp_storage`
     SET `_imported` = 1
   WHERE (`_StorageID` IS NOT NULL)
     AND (`_imported` = 0)
     AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('storage', 4, NOW());
END

GO

-- import procedure for preparation attributes

DROP PROCEDURE IF EXISTS `p_ImportPreparationAttribute`;

GO

CREATE PROCEDURE `p_ImportPreparationAttribute`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 0, NOW());


  IF (NOT EXISTS(SELECT *
                   FROM INFORMATION_SCHEMA.STATISTICS
                  WHERE (table_schema = 'svar_destdb_')
                    AND (table_name = 'preparationattribute')
                    AND (index_name = 'ix_importpreparationattributetempguid'))) THEN
    CREATE INDEX ix_importpreparationattributetempguid ON svar_destdb_.`preparationattribute` (`Text26`, `PreparationAttributeID`);
  END IF;

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 0.1, NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_preparationattribute` T1
         INNER JOIN `t_imp_preparation` T2 ON (T1.`preparationkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`_PreparationID`      = T2.`_PreparationID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`CreatedByFirstName`  = COALESCE(TRIM(T1.`CreatedByFirstName`), ''),
         T1.`CreatedByLastName`   = COALESCE(TRIM(T1.`CreatedByLastName`), ''),
         T1.`ModifiedByFirstName` = COALESCE(TRIM(T1.`ModifiedByFirstName`), ''),
         T1.`ModifiedByLastName`  = COALESCE(TRIM(T1.`ModifiedByLastName`), ''),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 1, NOW());


  -- checking relationships

  UPDATE `t_imp_preparationattribute` T1
         INNER JOIN `t_imp_preparation` T2 ON (T1.`preparationkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_preparation.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 2.1, NOW());


  UPDATE `t_imp_preparationattribute` T1
         LEFT OUTER JOIN `t_imp_preparation` T2 ON (T1.`preparationkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Preparation not found.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`key` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 2.2, NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, 
                T1.`LastName`,
                T1.`FirstName`
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_preparationattribute`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_preparationattribute`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID` = T2.`CollectionID`)
                                              AND (T1.`LastName`     = COALESCE(T2.`LastName`,''))
                                              AND (T1.`FirstName`    = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (T1.`LastName` <> '');

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 3.1, NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 3.2, NOW());


  UPDATE `t_imp_preparationattribute`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 3.3, NOW());


  UPDATE `t_imp_preparationattribute`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 3.4, NOW());


  -- check record has relevant data

  UPDATE `t_imp_preparationattribute`
     SET `_hasdata` = 1
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND ((NULLIF(`Remarks`,'') IS NOT NULL)
       OR (NULLIF(`Text1`,'') IS NOT NULL)
       OR (NULLIF(`Text2`,'') IS NOT NULL)
       OR (NULLIF(`Text3`,'') IS NOT NULL)
       OR (NULLIF(`Text4`,'') IS NOT NULL)
       OR (NULLIF(`Text5`,'') IS NOT NULL)
       OR (NULLIF(`Text6`,'') IS NOT NULL)
       OR (NULLIF(`Text7`,'') IS NOT NULL)
       OR (NULLIF(`Text8`,'') IS NOT NULL)
       OR (NULLIF(`Text9`,'') IS NOT NULL)
       OR (NULLIF(`Text10`,'') IS NOT NULL)
       OR (NULLIF(`Text11`,'') IS NOT NULL)
       OR (NULLIF(`Text12`,'') IS NOT NULL)
       OR (NULLIF(`Text13`,'') IS NOT NULL)
       OR (NULLIF(`Text14`,'') IS NOT NULL)
       OR (NULLIF(`Text15`,'') IS NOT NULL)
       OR (NULLIF(`Text16`,'') IS NOT NULL)
       OR (NULLIF(`Text17`,'') IS NOT NULL)
       OR (NULLIF(`Text18`,'') IS NOT NULL)
       OR (NULLIF(`Text19`,'') IS NOT NULL)
       OR (NULLIF(`Text20`,'') IS NOT NULL)
       OR (NULLIF(`Text21`,'') IS NOT NULL)
       OR (NULLIF(`Text22`,'') IS NOT NULL)
       OR (NULLIF(`Text23`,'') IS NOT NULL)
       OR (NULLIF(`Text24`,'') IS NOT NULL)
       OR (NULLIF(`Text25`,'') IS NOT NULL)
       OR (NULLIF(`Text26`,'') IS NOT NULL)
       OR (`AttrDate` IS NOT NULL)
       OR (`Number1` IS NOT NULL)
       OR (`Number2` IS NOT NULL)
       OR (`Number3` IS NOT NULL)
       OR (`Number4` IS NOT NULL)
       OR (`Number5` IS NOT NULL)
       OR (`Number6` IS NOT NULL)
       OR (`Number7` IS NOT NULL)
       OR (`Number8` IS NOT NULL)
       OR (`Number9` IS NOT NULL)
       OR (`YesNo1` IS NOT NULL)
       OR (`YesNo2` IS NOT NULL)
       OR (`YesNo3` IS NOT NULL)
       OR (`YesNo4` IS NOT NULL));

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 4.1, NOW());


  UPDATE `t_imp_preparationattribute`
     SET `_error`    = 1,
         `_errormsg` = 'Record has no data.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_hasdata`  = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 4.2, NOW());


  -- Specify Import
  -- `_importguid` is a temporary Identifier in column `Text26`

  INSERT 
    INTO svar_destdb_.`preparationattribute` 
         (
           `CollectionMemberID`,
           
           `Number1`,
           `Number2`,
           `Number3`,
           `Number4`,
           `Number5`,
           `Number6`,
           `Number7`,
           `Number8`,
           `Number9`,

           `Text1`,
           `Text2`,
           `Text3`,
           `Text4`,
           `Text5`,
           `Text6`,
           `Text7`,
           `Text8`,
           `Text9`,
           `Text10`,
           `Text11`,
           `Text12`,
           `Text13`,
           `Text15`,
           `Text16`,
           `Text17`,
           `Text18`,
           `Text19`,
           `Text20`,
           `Text21`,
           `Text22`,
           `Text23`,
           `Text24`,
           `Text25`,

           `YesNo1`,
           `YesNo2`,
           `YesNo3`,
           `YesNo4`,

           `Remarks`,
           
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,
           `Version`,

           `Text26`
         )
         SELECT `_CollectionID`,

                `Number1`,
                `Number2`,
                `Number3`,
                `Number4`,
                `Number5`,
                `Number6`,
                `Number7`,
                `Number8`,
                `Number9`,

                `Text1`,
                `Text2`,
                `Text3`,
                `Text4`,
                `Text5`,
                `Text6`,
                `Text7`,
                `Text8`,
                `Text9`,
                `Text10`,
                `Text11`,
                `Text12`,
                `Text13`,
                `Text15`,
                `Text16`,
                `Text17`,
                `Text18`,
                `Text19`,
                `Text20`,
                `Text21`,
                `Text22`,
                `Text23`,
                `Text24`,
                `Text25`,

                `YesNo1`,
                `YesNo2`,
                `YesNo3`,
                `YesNo4`,

                `Remarks`,

                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,
                1,
            
                `_importguid`
           FROM `t_imp_preparationattribute`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);
           
  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 7.1, NOW());


  UPDATE `t_imp_preparationattribute` T1
         INNER JOIN svar_destdb_.`preparationattribute` T2 ON (T1.`_importguid` = T2.`Text26`)
     SET T1.`_PreparationAttributeID` = T2.`PreparationAttributeID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 7.2, NOW());


  UPDATE svar_destdb_.`preparationattribute` T1
         INNER JOIN `t_imp_preparationattribute` T2 ON (T1.`PreparationAttributeID` = T2.`_PreparationAttributeID`) 
     SET T1.`Text26` = T2.`Text26`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 7.3, NOW());


  -- `PreparationAttributeID` in table preparation

  UPDATE svar_destdb_.`preparation` T1
         INNER JOIN `t_imp_preparationattribute` T2 ON (T1.`PreparationID` = T2.`_PreparationID`)
     SET `_error`    = 1,
         `_errormsg` = 'collectionobject has an another preparationattribute record.'
   WHERE (T2.`_imported` = 0)
     AND (T2.`_error`    = 0)
     AND (T1.`PreparationAttributeID` IS NOT NULL);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 8.1, NOW());


  UPDATE svar_destdb_.`preparation` T1
         INNER JOIN `t_imp_preparationattribute` T2 ON (T1.`PreparationID` = T2.`_PreparationID`)
     SET T1.`PreparationAttributeID` = T2.`_PreparationAttributeID`
   WHERE (T2.`_imported` = 0)
     AND (T2.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 8.2, NOW());


  -- Finalisation

  UPDATE `t_imp_preparationattribute` T1
         INNER JOIN svar_destdb_.`preparationattribute` T2 ON (T1.`_PreparationAttributeID` = T2.`PreparationAttributeID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 9, NOW());


  IF (EXISTS(SELECT *
               FROM INFORMATION_SCHEMA.STATISTICS
              WHERE (table_schema = 'svar_destdb_')
                AND (table_name = 'preparationattribute')
                AND (index_name = 'ix_importpreparationattributetempguid'))) THEN
    DROP INDEX ix_importpreparationattributetempguid ON svar_destdb_.`preparationattribute`;
  END IF;

  INSERT INTO `tmp_steps` VALUES ('preparationattribute', 255, NOW());
END

GO

-- import procedure for preparation

DROP PROCEDURE IF EXISTS `p_importPreparation`;

GO

CREATE PROCEDURE `p_importPreparation`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('preparation',0,NOW());

  DROP TABLE IF EXISTS `tmp_preptype`;
  CREATE TABLE IF NOT EXISTS `tmp_preptype`
  (
    `CollectionID` INT,
    `Name`         VARCHAR(64),
    `ID`           INT,

    PRIMARY KEY (`CollectionID`, `Name`),
    KEY (`ID`)
  ) ENGINE=MEMORY;

  INSERT INTO `tmp_steps` VALUES ('preparation',0.1,NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_preparation` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`_PrepTypeName`       = NULLIF(TRIM(T1.`PrepType`), ''),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',1,NOW());


  -- checking relationships

  UPDATE `t_imp_preparation` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('preparation',2.1,NOW());


  UPDATE `t_imp_preparation` T1
         LEFT OUTER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Collection object not found.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`key` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('preparation',2.2,NOW());


  -- Agents: PreparedBy, Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, COALESCE(T1.`LastName`,''), COALESCE(T1.`FirstName`,'')
           FROM (SELECT DISTINCT
                        `_CollectionID`       AS `CollectionID`,
                        `PreparedByLastName`  AS `LastName`,
                        `PreparedByFirstName` AS `FirstName`
                   FROM `t_imp_preparation` 
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `CreatedByLastName`,
                        `CreatedByFirstName`
                   FROM `t_imp_preparation`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                  SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_preparation`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID`     = T2.`CollectionID`)
                                              AND (BINARY T1.`LastName`  = COALESCE(T2.`LastName`,''))
                                              AND (BINARY T1.`FirstName` = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (COALESCE(TRIM(T1.`LastName`),'') <> '');
           
  INSERT INTO `tmp_steps` VALUES ('preparation',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('preparation',3.2,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`PreparedByLastName`  = T2.`LastName`)
                                  AND (T1.`PreparedByFirstName` = T2.`FirstName`)
     SET `_PreparedByID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',3.3,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                    AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                    AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',3.4,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_agent`   T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                    AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                    AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',3.5,NOW());


  -- `PrepType`

  INSERT
    INTO `tmp_preptype` (`CollectionID`, `Name`)
         SELECT DISTINCT
                T1.`_CollectionID`,
                T1.`_PrepTypeName`
           FROM `t_imp_preparation` T1
                LEFT OUTER JOIN `tmp_preptype` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                                 AND (T1.`_PrepTypeName` = T2.`Name`)
          WHERE (T1.`_PrepTypeName` IS NOT NULL)
            AND (T2.`ID`            IS NULL)
            AND (T1.`_imported`     = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',4.1,NOW());


  UPDATE `tmp_preptype`
     SET `ID` = `f_appendPrepType`(`Name`, `CollectionID`)
    WHERE (`ID` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('preparation',4.2,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN `tmp_preptype` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                     AND (T1.`_PrepTypeName` = T2.`Name`)
     SET T1.`_PrepTypeID` = T2.`ID`
   WHERE (T1.`_PrepTypeName` IS NOT NULL)
     AND (T1.`_imported`     = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',4.3,NOW());


  UPDATE `t_imp_preparation`
     SET `_error`    = 1,
         `_errormsg` = 'PrepTypeID cannot be null.'
   WHERE (`_PrepTypeID` IS NULL) 
     AND (`_imported`   = 0)
     AND (`_error`      = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',4.4,NOW());


  -- `PreparedDate`, `PreparedDatePrecision`

  UPDATE `t_imp_preparation`
     SET `_PreparedDate`          = `f_getDate`(`PreparedYear`,`PreparedMonth`,`PreparedDate`),
         `_PreparedDatePrecision` = `f_getDatePrecision`(`PreparedYear`,`PreparedMonth`,`PreparedDate`)
   WHERE (`_imported` = 0)
     AND ((`PreparedDate` IS NOT NULL) OR (`PreparedYear` IS NOT NULL));

  INSERT INTO `tmp_steps` VALUES ('preparation',5,NOW());


  -- `StorageID`

  INSERT 
    INTO `t_imp_storage` 
         (
           `key`,
           `specifycollcode`,

           `Building`,
           `Collection`,
           `Room`,
           `Aisle`,
           `Cabinet`,
           `Shelf`,
           `Box`,
           `Rack`,
           `Vial`
         )
         SELECT `_importguid`,
                `specifycollcode`,

                `StorageBuilding`,
                `StorageCollection`,
                `StorageRoom`,
                `StorageAisle`,
                `StorageCabinet`,
                `StorageShelf`,
                `StorageBox`,
                `StorageRack`,
                `StorageVial`
           FROM `t_imp_preparation`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',6.1,NOW());


  -- Storage tree import

  CALL `p_ImportStorage`;


  UPDATE `t_imp_preparation` T1
         INNER JOIN `t_imp_storage` T2 ON (T1.`_importguid` = T2.`key`)
     SET T1.`_StorageID` = T2.`_StorageID`
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_imported` = 0)
     AND (T2.`_error`    = 0);


  INSERT INTO `tmp_steps` VALUES ('preparation',6.2,NOW());


  -- check record has relevant data

  UPDATE `t_imp_preparation`
     SET `_hasdata` = 1
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND ((`_PreparedDate`                IS NOT NULL)
       OR (`_PreparedByID`                IS NOT NULL)
       OR (`_StorageID`                   IS NOT NULL)
       OR (`_PrepTypeID`                  IS NOT NULL)
       OR (`YesNo1`                       IS NOT NULL)
       OR (`YesNo2`                       IS NOT NULL)
       OR (`YesNo3`                       IS NOT NULL)
       OR (NULLIF(`Count`           ,  0) IS NOT NULL)
       OR (NULLIF(`SampleNumber`    , '') IS NOT NULL)
       OR (NULLIF(`Description`     , '') IS NOT NULL)
       OR (NULLIF(`StorageLocation` , '') IS NOT NULL)
       OR (NULLIF(`Remarks`         , '') IS NOT NULL));

  INSERT INTO `tmp_steps` VALUES ('preparation',7.1,NOW());


  UPDATE `t_imp_preparation`
     SET `_error`    = 1,
         `_errormsg` = 'Record has no data.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_hasdata`  = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',7.2,NOW());


  -- Specify Import
  -- `_importguid` is a temporary Identifier in column `StorageLocation`

  INSERT 
    INTO svar_destdb_.`preparation` 
         (
           `CollectionMemberID`,
           `CollectionObjectID`,

           `Description`,
           `CountAmt`,
           `PrepTypeID`,
           `PreparedDate`,
           `PreparedDatePrecision`,
           `PreparedByID`,
           `SampleNumber`,
           `Remarks`,

           `StorageID`,

           `YesNo1`, 
           `YesNo2`, 
           `YesNo3`, 

           `Version`,
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,

           `StorageLocation`
         )
         SELECT `_CollectionID`,
                `_CollectionObjectID`,

                `Description`,
                `Count`,
                `_PrepTypeID`,
                `_PreparedDate`,
                `_PreparedDatePrecision`,
                `_PreparedByID`,
                `SampleNumber`,
                `Remarks`,

                `_StorageID`,

                `YesNo1`, 
                `YesNo2`, 
                `YesNo3`, 

                1,
                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,

                `_importguid`
           FROM `t_imp_preparation`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0)
            AND (`_hasdata`  = 1);
  
  INSERT INTO `tmp_steps` VALUES ('preparation',8.1,NOW());


  UPDATE `t_imp_preparation` T1
         INNER JOIN svar_destdb_.`preparation` T2 ON (T1.`_importguid` = T2.`StorageLocation`)
     SET T1.`_PreparationID` = T2.`PreparationID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('preparation',8.2,NOW());


  UPDATE svar_destdb_.`preparation` T1
         INNER JOIN `t_imp_preparation` T2 ON (T1.`PreparationID` = T2.`_PreparationID`) 
     SET T1.`StorageLocation` = T2.`StorageLocation`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',8.3,NOW());


  -- Finalisation

  UPDATE `t_imp_preparation` T1
         INNER JOIN svar_destdb_.`preparation` T2 ON (T1.`_PreparationID` = T2.`PreparationID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('preparation',9,NOW());


  -- drop import helper

  DROP TABLE IF EXISTS `tmp_preptype`;

  INSERT INTO `tmp_steps` VALUES ('preparation',255,NOW());
END

GO

-- import procedure for collection object attributes

DROP PROCEDURE IF EXISTS `p_ImportCollectionobjectattribute`;

GO

CREATE PROCEDURE `p_ImportCollectionobjectattribute`()
BEGIN
  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',0,NOW());


  -- CollecionID, CollectionObjectID, TimestampCreated, TimestampModified

  UPDATE `t_imp_collectionobjectattribute` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_CollectionID`       = T2.`_CollectionID`,
         T1.`_CollectionObjectID` = T2.`_CollectionObjectID`,
         T1.`key`                 = COALESCE(NULLIF(TRIM(T1.`key`),''),UUID()),
         T1.`_Age`                = NULLIF(TRIM(T1.`Text7`), ''),
         T1.`_BiologicalSex`      = NULLIF(TRIM(T1.`Text8`), ''),
         T1.`CreatedByFirstName`  = COALESCE(TRIM(T1.`CreatedByFirstName`), ''),
         T1.`CreatedByLastName`   = COALESCE(TRIM(T1.`CreatedByLastName`), ''),
         T1.`ModifiedByFirstName` = COALESCE(TRIM(T1.`ModifiedByFirstName`), ''),
         T1.`ModifiedByLastName`  = COALESCE(TRIM(T1.`ModifiedByLastName`), ''),
         T1.`TimestampCreated`    = COALESCE(T1.`TimestampCreated`,NOW()),
         T1.`TimestampModified`   = COALESCE(T1.`TimestampModified`,T1.`TimestampCreated`,NOW()),
         T1.`_importguid`         = UUID()
   WHERE (T2.`_imported` = 1)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',1,NOW());


  -- checking relationships

  UPDATE `t_imp_collectionobjectattribute` T1
         INNER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'See error in t_imp_collectionobject.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`_error`    = 1);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',2.1,NOW());


  UPDATE `t_imp_collectionobjectattribute` T1
         LEFT OUTER JOIN `t_imp_collectionobject` T2 ON (T1.`collectionobjectkey` = T2.`key`)
     SET T1.`_error`    = 1,
         T1.`_errormsg` = 'Collection object not found.'
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0)
     AND (T2.`key` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',2.2,NOW());


  -- Agents: Created by, Modified by

  INSERT 
    INTO `tmp_agent` (`CollectionID`,`LastName`,`FirstName`)
         SELECT T1.`CollectionID`, 
                T1.`LastName`,
                T1.`FirstName`
           FROM (SELECT DISTINCT
                        `_CollectionID`      AS `CollectionID`,
                        `CreatedByLastName`  AS `LastName`,
                        `CreatedByFirstName` AS `FirstName`
                   FROM `t_imp_collectionobjectattribute`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0) 
                  UNION
                 SELECT DISTINCT
                        `_CollectionID`,
                        `ModifiedByLastName`,
                        `ModifiedByFirstName`
                   FROM `t_imp_collectionobjectattribute`
                  WHERE (`_imported` = 0)
                    AND (`_error`    = 0)) AS T1
                LEFT OUTER JOIN `tmp_agent` T2 ON (T1.`CollectionID` = T2.`CollectionID`)
                                              AND (T1.`LastName`     = COALESCE(T2.`LastName`,''))
                                              AND (T1.`FirstName`    = COALESCE(T2.`FirstName`,''))
          WHERE (T2.`AgentID` IS NULL)
            AND (T1.`LastName` <> '');

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',3.1,NOW());


  UPDATE `tmp_agent`
     SET `AgentID` = `f_appendAgent`(`LastName`,`FirstName`,`CollectionID`)
   WHERE (`AgentID` IS NULL); 

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',3.2,NOW());


  UPDATE `t_imp_collectionobjectattribute`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`      = T2.`CollectionID`)
                                  AND (T1.`CreatedByLastName`  = T2.`LastName`)
                                  AND (T1.`CreatedByFirstName` = T2.`FirstName`)
     SET `_CreatedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',3.3,NOW());


  UPDATE `t_imp_collectionobjectattribute`  T1
         INNER JOIN `tmp_agent` T2 ON (T1.`_CollectionID`       = T2.`CollectionID`)
                                  AND (T1.`ModifiedByLastName`  = T2.`LastName`)
                                  AND (T1.`ModifiedByFirstName` = T2.`FirstName`)
     SET `_ModifiedByAgentID` = `AgentID`
   WHERE (`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',3.4,NOW());


  -- check record has relevant data

  UPDATE `t_imp_collectionobjectattribute`
     SET `_hasdata` = 1
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND ((NULLIF(`Remarks`,'') IS NOT NULL)
       OR (NULLIF(`Text1`,'') IS NOT NULL)
       OR (NULLIF(`Text2`,'') IS NOT NULL)
       OR (NULLIF(`Text3`,'') IS NOT NULL)
       OR (NULLIF(`Text4`,'') IS NOT NULL)
       OR (NULLIF(`Text5`,'') IS NOT NULL)
       OR (NULLIF(`Text6`,'') IS NOT NULL)
       OR (NULLIF(`Text7`,'') IS NOT NULL)
       OR (NULLIF(`Text8`,'') IS NOT NULL)
       OR (NULLIF(`Text9`,'') IS NOT NULL)
       OR (NULLIF(`Text10`,'') IS NOT NULL)
       OR (NULLIF(`Text11`,'') IS NOT NULL)
       OR (NULLIF(`Text12`,'') IS NOT NULL)
       OR (NULLIF(`Text13`,'') IS NOT NULL)
       OR (NULLIF(`Text14`,'') IS NOT NULL)
       OR (NULLIF(`Text15`,'') IS NOT NULL)
       OR (`Number1` IS NOT NULL)
       OR (`Number2` IS NOT NULL)
       OR (`Number3` IS NOT NULL)
       OR (`Number4` IS NOT NULL)
       OR (`Number5` IS NOT NULL)
       OR (`Number6` IS NOT NULL)
       OR (`Number7` IS NOT NULL)
       OR (`Number8` IS NOT NULL)
       OR (`Number9` IS NOT NULL)
       OR (`Number10` IS NOT NULL)
       OR (`Number11` IS NOT NULL)
       OR (`Number12` IS NOT NULL)
       OR (`Number13` IS NOT NULL)
       OR (`Number14` IS NOT NULL)
       OR (`Number15` IS NOT NULL)
       OR (`Number16` IS NOT NULL)
       OR (`Number17` IS NOT NULL)
       OR (`Number18` IS NOT NULL)
       OR (`Number19` IS NOT NULL)
       OR (`Number20` IS NOT NULL)
       OR (`Number21` IS NOT NULL)
       OR (`Number22` IS NOT NULL)
       OR (`Number23` IS NOT NULL)
       OR (`Number24` IS NOT NULL)
       OR (`Number25` IS NOT NULL)
       OR (`Number26` IS NOT NULL)
       OR (`Number27` IS NOT NULL)
       OR (`Number28` IS NOT NULL)
       OR (`Number29` IS NOT NULL)
       OR (`Number30` IS NOT NULL)
       OR (`Number31` IS NOT NULL)
       OR (`Number32` IS NOT NULL)
       OR (`Number33` IS NOT NULL)
       OR (`Number34` IS NOT NULL)
       OR (`Number35` IS NOT NULL)
       OR (`Number36` IS NOT NULL)
       OR (`Number37` IS NOT NULL)
       OR (`Number38` IS NOT NULL)
       OR (`Number39` IS NOT NULL)
       OR (`Number40` IS NOT NULL)
       OR (`Number41` IS NOT NULL)
       OR (`Number42` IS NOT NULL)
       OR (`YesNo1` IS NOT NULL)
       OR (`YesNo2` IS NOT NULL)
       OR (`YesNo3` IS NOT NULL)
       OR (`YesNo4` IS NOT NULL)
       OR (`YesNo5` IS NOT NULL)
       OR (`YesNo6` IS NOT NULL)
       OR (`YesNo7` IS NOT NULL));

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',4.1,NOW());


  UPDATE `t_imp_collectionobjectattribute`
     SET `_error`    = 1,
         `_errormsg` = 'Record has no data.'
   WHERE (`_imported` = 0)
     AND (`_error`    = 0)
     AND (`_hasdata`  = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',4.2,NOW());


  -- `Age` (`Text7`)

  INSERT
    INTO `tmp_age` (`CollectionID`, `Name`)
         SELECT DISTINCT
                T1.`_CollectionID`,
                T1.`_Age`
           FROM `t_imp_collectionobjectattribute` T1
                LEFT OUTER JOIN `tmp_age` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                            AND (T1.`_Age`          = T2.`Name`)
          WHERE (T1.`_Age` IS NOT NULL)
            AND (T2.`Value` IS NULL)
            AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',5.1,NOW());


  UPDATE `tmp_age`
     SET `Value` = `f_appendAge`(`Name`, `CollectionID`)
    WHERE (`Value` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',5.2,NOW());


  UPDATE `t_imp_collectionobjectattribute` T1
         INNER JOIN `tmp_age` T2 ON (T1.`_CollectionID` = T2.`CollectionID`)
                                AND (T1.`_Age`          = T2.`Name`)
     SET T1.`_Age` = T2.`Value`
   WHERE (T1.`_Age` IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',5.3,NOW());


  -- `BiologicalSex` (`Text8`)

  INSERT
    INTO `tmp_biologicalsex` (`CollectionID`, `Name`)
         SELECT DISTINCT
                T1.`_CollectionID`,
                T1.`_BiologicalSex`
           FROM `t_imp_collectionobjectattribute` T1
                LEFT OUTER JOIN `tmp_biologicalsex` T2 ON (T1.`_CollectionID`  = T2.`CollectionID`)
                                                      AND (T1.`_BiologicalSex` = T2.`Name`)
          WHERE (T1.`_BiologicalSex` IS NOT NULL)
            AND (T2.`Value` IS NULL)
            AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',6.1,NOW());


  UPDATE `tmp_biologicalsex`
     SET `Value` = `f_appendBiologicalSex`(`Name`, `CollectionID`)
    WHERE (`Value` IS NULL);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',6.2,NOW());


  UPDATE `t_imp_collectionobjectattribute` T1
         INNER JOIN `tmp_biologicalsex` T2 ON (T1.`_CollectionID`  = T2.`CollectionID`)
                                          AND (T1.`_BiologicalSex` = T2.`Name`)
     SET T1.`_BiologicalSex` = T2.`Value`
   WHERE (T1.`_BiologicalSex` IS NOT NULL)
     AND (T1.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',6.3,NOW());


  -- Specify Import
  -- `_importguid` is a temporary Identifier in column `Text14`

  INSERT 
    INTO svar_destdb_.`collectionobjectattribute` 
         (
           `CollectionMemberID`,
           
           `Number1`,
           `Number2`,
           `Number3`,
           `Number4`,
           `Number5`,
           `Number6`,
           `Number7`,
           `Number8`,
           `Number9`,
           `Number10`,
           `Number11`,
           `Number12`,
           `Number13`,
           `Number14`,
           `Number15`,
           `Number16`,
           `Number17`,
           `Number18`,
           `Number19`,
           `Number20`,
           `Number21`,
           `Number22`,
           `Number23`,
           `Number24`,
           `Number25`,
           `Number26`,
           `Number27`,
           `Number28`,
           `Number29`,
           `Number30`,
           `Number31`,
           `Number32`,
           `Number33`,
           `Number34`,
           `Number35`,
           `Number36`,
           `Number37`,
           `Number38`,
           `Number39`,
           `Number40`,
           `Number41`,
           `Number42`,

           `Text1`,
           `Text2`,
           `Text3`,
           `Text4`,
           `Text5`,
           `Text6`,
           `Text7`,
           `Text8`,
           `Text9`,
           `Text10`,
           `Text11`,
           `Text12`,
           `Text13`,
           `Text15`,

           `YesNo1`,
           `YesNo2`,
           `YesNo3`,
           `YesNo4`,
           `YesNo5`,
           `YesNo6`,
           `YesNo7`,

           `Remarks`,
           
           `TimestampCreated`,
           `CreatedByAgentID`,
           `TimestampModified`,
           `ModifiedByAgentID`,
           `Version`,

           `Text14`
         )
         SELECT `_CollectionID`,

                `Number1`,
                `Number2`,
                `Number3`,
                `Number4`,
                `Number5`,
                `Number6`,
                `Number7`,
                `Number8`,
                `Number9`,
                `Number10`,
                `Number11`,
                `Number12`,
                `Number13`,
                `Number14`,
                `Number15`,
                `Number16`,
                `Number17`,
                `Number18`,
                `Number19`,
                `Number20`,
                `Number21`,
                `Number22`,
                `Number23`,
                `Number24`,
                `Number25`,
                `Number26`,
                `Number27`,
                `Number28`,
                `Number29`,
                `Number30`,
                `Number31`,
                `Number32`,
                `Number33`,
                `Number34`,
                `Number35`,
                `Number36`,
                `Number37`,
                `Number38`,
                `Number39`,
                `Number40`,
                `Number41`,
                `Number42`,

                `Text1`,
                `Text2`,
                `Text3`,
                `Text4`,
                `Text5`,
                `Text6`,
                `_Age`,
                `_BiologicalSex`,
                `Text9`,
                `Text10`,
                `Text11`,
                `Text12`,
                `Text13`,
                `Text15`,

                `YesNo1`,
                `YesNo2`,
                `YesNo3`,
                `YesNo4`,
                `YesNo5`,
                `YesNo6`,
                `YesNo7`,

                `Remarks`,

                `TimestampCreated`,
                `_CreatedByAgentID`,
                `TimestampModified`,
                `_ModifiedByAgentID`,
                1,
            
                `_importguid`
           FROM `t_imp_collectionobjectattribute`
          WHERE (`_imported` = 0)
            AND (`_error`    = 0);
           
  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',7.1,NOW());


  UPDATE `t_imp_collectionobjectattribute` T1
         INNER JOIN svar_destdb_.`collectionobjectattribute` T2 ON (T1.`_importguid` = T2.`Text14`)
     SET T1.`_CollectionObjectAttributeID` = T2.`CollectionObjectAttributeID`
   WHERE (T1.`_imported` = 0);
                                 
  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',7.2,NOW());


  UPDATE svar_destdb_.`collectionobjectattribute` T1
         INNER JOIN `t_imp_collectionobjectattribute` T2 ON (T1.`CollectionObjectAttributeID` = T2.`_CollectionObjectAttributeID`) 
     SET T1.`Text14` = T2.`Text14`
   WHERE (T2.`_imported` = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',7.3,NOW());


  -- `CollectionObjectAttributeID` in table collectionobject

  UPDATE svar_destdb_.`collectionobject` T1
         INNER JOIN `t_imp_collectionobjectattribute` T2 ON (T1.`CollectionObjectID` = T2.`_CollectionObjectID`)
     SET `_error`    = 1,
         `_errormsg` = 'collectionobject has an another collectionobjectattribute record.'
          WHERE (T2.`_imported`                   = 0)
            AND (T2.`_error`                      = 0)
            AND (T1.`CollectionObjectAttributeID` IS NOT NULL);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',8.1,NOW());


  UPDATE svar_destdb_.`collectionobject` T1
         INNER JOIN `t_imp_collectionobjectattribute` T2 ON (T1.`CollectionObjectID` = T2.`_CollectionObjectID`)
     SET T1.`CollectionObjectAttributeID` = T2.`_CollectionObjectAttributeID`
          WHERE (T2.`_imported` = 0)
            AND (T2.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',8.2,NOW());


  -- Finalisation

  UPDATE `t_imp_collectionobjectattribute` T1
         INNER JOIN svar_destdb_.`collectionobjectattribute` T2 ON (T1.`_CollectionObjectAttributeID` = T2.`CollectionObjectAttributeID`)
     SET T1.`_imported` = 1
   WHERE (T1.`_imported` = 0)
     AND (T1.`_error`    = 0);

  INSERT INTO `tmp_steps` VALUES ('collectionobjectattribute',9,NOW());
END

GO

-- import procedure

DROP PROCEDURE IF EXISTS `p_Import`;

GO

CREATE PROCEDURE `p_Import`()
BEGIN
  -- DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND ROLLBACK;

  -- START TRANSACTION;
  
  CALL `p_ImportInit`;
  CALL `p_ImportAccession`;
  CALL `p_ImportAccessionAgent`;
  CALL `p_ImportContainer`;
  CALL `p_ImportCollectionobject`;
  CALL `p_ImportOtherIdentifier`;
  CALL `p_ImportCollector`;
  CALL `p_ImportDetermination`;
  CALL `p_ImportPreparation`;
  CALL `p_ImportPreparationAttribute`;
--  CALL `p_ImportCollectionobjectCitation`;
  CALL `p_ImportCollectionobjectattribute`;
  CALL `p_ImportDone`;
END

GO

/******************************************************************************/
/* data                                                                       */
/******************************************************************************/

INSERT 
  INTO `t_specifycountry` 
  VALUES ('AD', 'AD', 'Andorra', 'Europe'),
         ('AD', 'Andorra', 'Andorra', 'Europe'),
         ('AD', 'Principality of Andorra', 'Andorra', 'Europe'),
         ('AE', 'AE', 'United Arab Emirates', 'Asia'),
         ('AE', 'United Arab Emirates', 'United Arab Emirates', 'Asia'),
         ('AE', 'Vereinigte Arabische Emirate', 'United Arab Emirates', 'Asia'),
         ('AF', 'AF', 'Afghanistan', 'Asia'),
         ('AF', 'Afghanistan', 'Afghanistan', 'Asia'),
         ('AF', 'Islamic Republic of Afghanistan', 'Afghanistan', 'Asia'),
         ('AG', 'AG', 'Antigua and Barbuda', 'North America'),
         ('AG', 'Antigua and Barbuda', 'Antigua and Barbuda', 'North America'),
         ('AI', 'AI', 'Anguilla', 'North America'),
         ('AI', 'Anguilla', 'Anguilla', 'North America'),
         ('AL', 'AL', 'Albania', 'Europe'),
         ('AL', 'Albania', 'Albania', 'Europe'),
         ('AL', 'Republic of Albania', 'Albania', 'Europe'),
         ('AM', 'AM', 'Armenia', 'Asia'),
         ('AM', 'Armenia', 'Armenia', 'Asia'),
         ('AM', 'Armenien', 'Armenia', 'Asia'),
         ('AM', 'Republic of Armenia', 'Armenia', 'Asia'),
         ('AN', 'AN', 'Netherlands Antilles', 'North America'),
         ('AN', 'Netherlands Antilles', 'Netherlands Antilles', 'North America'),
         ('AO', 'Angola', 'Angola', 'Africa'),
         ('AO', 'AO', 'Angola', 'Africa'),
         ('AO', 'Republic of Angola', 'Angola', 'Africa'),
         ('AQ', 'Antarctica', 'Antarctica', 'Antarctica'),
         ('AQ', 'AQ', 'Antarctica', 'Antarctica'),
         ('AR', 'AR', 'Argentina', 'South America'),
         ('AR', 'Argentina', 'Argentina', 'South America'),
         ('AR', 'Argentine Republic', 'Argentina', 'South America'),
         ('AR', 'Argentinien', 'Argentina', 'South America'),
         ('AS', 'American Samoa', 'American Samoa', 'Oceania'),
         ('AS', 'AS', 'American Samoa', 'Oceania'),
         ('AT', 'AT', 'Austria', 'Europe'),
         ('AT', 'Austria', 'Austria', 'Europe'),
         ('AT', 'Österrcih', 'Austria', 'Europe'),
         ('AT', 'Österreich', 'Austria', 'Europe'),
         ('AT', 'Republic of Austria', 'Austria', 'Europe'),
         ('AU', 'AU', 'Australia', 'Oceania'),
         ('AU', 'Australia', 'Australia', 'Oceania'),
         ('AU', 'Australien', 'Australia', 'Oceania'),
         ('AU', 'Commonwealth of Australia', 'Australia', 'Oceania'),
         ('AU', 'N. Holland', 'Australia', 'Oceania'),
         ('AU', 'N.Holl.', 'Australia', 'Oceania'),
         ('AU', 'Neuholland', 'Australia', 'Oceania'),
         ('AU', 'Nov. Holl.', 'Australia', 'Oceania'),
         ('AU', 'Nov. Holland', 'Australia', 'Oceania'),
         ('AW', 'Aruba', 'Aruba', 'North America'),
         ('AW', 'AW', 'Aruba', 'North America'),
         ('AX', 'Aland Islands', 'Aland Islands', 'Europe'),
         ('AX', 'AX', 'Aland Islands', 'Europe'),
         ('AZ', 'AZ', 'Azerbaijan', 'Asia'),
         ('AZ', 'Azerbaijan', 'Azerbaijan', 'Asia'),
         ('AZ', 'Republic of Azerbaijan', 'Azerbaijan', 'Asia'),
         ('BA', 'BA', 'Bosnia and Herzegovina', 'Europe'),
         ('BA', 'Bosnia and Herzegovina', 'Bosnia and Herzegovina', 'Europe'),
         ('BA', 'Bosnien und Herzegowina', 'Bosnia and Herzegovina', 'Europe'),
         ('BB', 'Barbados', 'Barbados', 'North America'),
         ('BB', 'BB', 'Barbados', 'North America'),
         ('BD', 'Bangladesh', 'Bangladesh', 'Asia'),
         ('BD', 'BD', 'Bangladesh', 'Asia'),
         ('BD', 'E-Bangladesh', 'Bangladesh', 'Asia'),
         ('BD', 'NW-Bangladesh', 'Bangladesh', 'Asia'),
         ('BD', 'People\'s Republic of Bangladesh', 'Bangladesh', 'Asia'),
         ('BE', 'BE', 'Belgium', 'Europe'),
         ('BE', 'Belgien', 'Belgium', 'Europe'),
         ('BE', 'Belgium', 'Belgium', 'Europe'),
         ('BE', 'Kingdom of Belgium', 'Belgium', 'Europe'),
         ('BF', 'BF', 'Burkina Faso', 'Africa'),
         ('BF', 'Burkina Faso', 'Burkina Faso', 'Africa'),
         ('BG', 'BG', 'Bulgaria', 'Europe'),
         ('BG', 'Bulgaria', 'Bulgaria', 'Europe'),
         ('BG', 'Bulgarien', 'Bulgaria', 'Europe'),
         ('BG', 'Republic of Bulgaria', 'Bulgaria', 'Europe'),
         ('BH', 'Bahrain', 'Bahrain', 'Asia'),
         ('BH', 'BH', 'Bahrain', 'Asia'),
         ('BH', 'State of Bahrain', 'Bahrain', 'Asia'),
         ('BI', 'BI', 'Burundi', 'Africa'),
         ('BI', 'Burundi', 'Burundi', 'Africa'),
         ('BI', 'Republic of Burundi', 'Burundi', 'Africa'),
         ('BJ', 'Benin', 'Benin', 'Africa'),
         ('BJ', 'BJ', 'Benin', 'Africa'),
         ('BJ', 'Republic of Benin', 'Benin', 'Africa'),
         ('BL', 'Saint Barthelemy', 'Saint Barthelemy', 'North America'),
         ('BM', 'Bermuda', 'Bermuda', 'North America'),
         ('BM', 'BM', 'Bermuda', 'North America'),
         ('BN', 'BN', 'Brunei', 'Asia'),
         ('BN', 'Brunei', 'Brunei', 'Asia'),
         ('BN', 'Negara Brunei Darussalam', 'Brunei', 'Asia'),
         ('BO', 'BO', 'Bolivia', 'South America'),
         ('BO', 'Bolivia', 'Bolivia', 'South America'),
         ('BO', 'Bolivien', 'Bolivia', 'South America'),
         ('BO', 'Republic of Bolivia', 'Bolivia', 'South America'),
         ('BQ', 'Bonaire, Saint Eustatius and Saba ', 'Bonaire, Saint Eustatius and Saba ', 'Saint Eustatius and Saba , North America'),
         ('BR', 'BR', 'Brazil', 'South America'),
         ('BR', 'Brasil', 'Brazil', 'South America'),
         ('BR', 'Brasilien', 'Brazil', 'South America'),
         ('BR', 'Brazil', 'Brazil', 'South America'),
         ('BR', 'Federative Republic of Brazil', 'Brazil', 'South America'),
         ('BS', 'Bahamas', 'Bahamas', 'North America'),
         ('BS', 'BS', 'Bahamas', 'North America'),
         ('BS', 'Commonwealth of The Bahamas', 'Bahamas', 'North America'),
         ('BT', 'Bhutan', 'Bhutan', 'Asia'),
         ('BT', 'BT', 'Bhutan', 'Asia'),
         ('BT', 'Kingdom of Bhutan', 'Bhutan', 'Asia'),
         ('BV', 'Bouvet Island', 'Bouvet Island', 'Antarctica'),
         ('BV', 'BV', 'Bouvet Island', 'Antarctica'),
         ('BW', 'Botswana', 'Botswana', 'Africa'),
         ('BW', 'BW', 'Botswana', 'Africa'),
         ('BW', 'Republic of Botswana', 'Botswana', 'Africa'),
         ('BY', 'Belarus', 'Belarus', 'Europe'),
         ('BY', 'BY', 'Belarus', 'Europe'),
         ('BY', 'Republic of Belarus', 'Belarus', 'Europe'),
         ('BY', 'Weißrußland (Belarus),', 'Belarus', 'Europe'),
         ('BZ', 'Belize', 'Belize', 'North America'),
         ('BZ', 'BZ', 'Belize', 'North America'),
         ('CA', 'CA', 'Canada', 'North America'),
         ('CA', 'Canada', 'Canada', 'North America'),
         ('CA', 'Kanada', 'Canada', 'North America'),
         ('CC', 'CC', 'Cocos Islands', 'Asia'),
         ('CC', 'Cocos Islands', 'Cocos Islands', 'Asia'),
         ('CD', 'CD', 'Democratic Republic of the Congo', 'Africa'),
         ('CD', 'Democratic Republic of the Congo', 'Democratic Republic of the Congo', 'Africa'),
         ('CF', 'Central African Republic', 'Central African Republic', 'Africa'),
         ('CF', 'CF', 'Central African Republic', 'Africa'),
         ('CG', 'CG', 'Republic of the Congo', 'Africa'),
         ('CG', 'Republic of the Congo', 'Republic of the Congo', 'Africa'),
         ('CH', 'CH', 'Switzerland', 'Europe'),
         ('CH', 'Schweiz', 'Switzerland', 'Europe'),
         ('CH', 'Swiss', 'Switzerland', 'Europe'),
         ('CH', 'Swiss Confederation', 'Switzerland', 'Europe'),
         ('CH', 'Switzerland', 'Switzerland', 'Europe'),
         ('CI', 'CI', 'Ivory Coast', 'Africa'),
         ('CI', 'Ivory Coast', 'Ivory Coast', 'Africa'),
         ('CI', 'Republic of Cote d\'Ivoire', 'Ivory Coast', 'Africa'),
         ('CK', 'CK', 'Cook Islands', 'Oceania'),
         ('CK', 'Cook Islands', 'Cook Islands', 'Oceania'),
         ('CL', 'Chile', 'Chile', 'South America'),
         ('CL', 'CL', 'Chile', 'South America'),
         ('CL', 'Republic of Chile', 'Chile', 'South America'),
         ('CM', 'Cameroon', 'Cameroon', 'Africa'),
         ('CM', 'CM', 'Cameroon', 'Africa'),
         ('CM', 'Kamerun', 'Cameroon', 'Africa'),
         ('CM', 'N.W. Kamerum', 'Cameroon', 'Africa'),
         ('CM', 'Republic of Cameroon', 'Cameroon', 'Africa'),
         ('CM', 'S.Kamerun', 'Cameroon', 'Africa'),
         ('CM', 'S.-Kamerun', 'Cameroon', 'Africa'),
         ('CN', 'China', 'China', 'Asia'),
         ('CN', 'CN', 'China', 'Asia'),
         ('CN', 'People\'s Republic of China', 'China', 'Asia'),
         ('CN', 'Westchina', 'China', 'Asia'),
         ('CO', 'CO', 'Colombia', 'South America'),
         ('CO', 'Colombia', 'Colombia', 'South America'),
         ('CO', 'Kolumbien', 'Colombia', 'South America'),
         ('CO', 'Nov. Granada', 'Colombia', 'South America'),
         ('CO', 'Republic of Colombia', 'Colombia', 'South America'),
         ('CR', 'Costa Rica', 'Costa Rica', 'North America'),
         ('CR', 'CR', 'Costa Rica', 'North America'),
         ('CR', 'Republic of Costa Rica', 'Costa Rica', 'North America'),
         ('CS', 'CS', 'Serbia and Montenegro', 'Europe'),
         ('CS', 'Jugoslawien', 'Serbia and Montenegro', 'Europe'),
         ('CS', 'Serbia and Montenegro', 'Serbia and Montenegro', 'Europe'),
         ('CU', 'CU', 'Cuba', 'North America'),
         ('CU', 'Cuba', 'Cuba', 'North America'),
         ('CU', 'E-Cuba', 'Cuba', 'North America'),
         ('CU', 'Kuba', 'Cuba', 'North America'),
         ('CU', 'Kuiba', 'Cuba', 'North America'),
         ('CU', 'Republic of Cuba', 'Cuba', 'North America'),
         ('CV', 'Cape Verde', 'Cape Verde', 'Africa'),
         ('CV', 'CV', 'Cape Verde', 'Africa'),
         ('CV', 'Kap Verde', 'Cape Verde', 'Africa'),
         ('CV', 'Republic of Cape Verde', 'Cape Verde', 'Africa'),
         ('CW', 'Curacao', 'Curacao', 'North America'),
         ('CX', 'Christmas Island', 'Christmas Island', 'Asia'),
         ('CX', 'CX', 'Christmas Island', 'Asia'),
         ('CY', 'CY', 'Cyprus', 'Europe'),
         ('CY', 'Cyprus', 'Cyprus', 'Europe'),
         ('CY', 'Kibris Cumhuriyeti', 'Cyprus', 'Europe'),
         ('CY', 'Zypern', 'Cyprus', 'Europe'),
         ('CZ', 'Ceska republika', 'Czech Republic', 'Europe'),
         ('CZ', 'CZ', 'Czech Republic', 'Europe'),
         ('CZ', 'Czech Republic', 'Czech Republic', 'Europe'),
         ('CZ', 'Tschechien', 'Czech Republic', 'Europe'),
         ('CZ', 'Tschechische Republik', 'Czech Republic', 'Europe'),
         ('DE', 'DE', 'Germany', 'Europe'),
         ('DE', 'deu', 'Germany', 'Europe'),
         ('DE', 'Deuschland', 'Germany', 'Europe'),
         ('DE', 'Deustchland', 'Germany', 'Europe'),
         ('DE', 'Deutschalnd', 'Germany', 'Europe'),
         ('DE', 'Deutschand', 'Germany', 'Europe'),
         ('DE', 'Deutschland', 'Germany', 'Europe'),
         ('DE', 'Deutschloand', 'Germany', 'Europe'),
         ('DE', 'Deutscland', 'Germany', 'Europe'),
         ('DE', 'Deutshcland', 'Germany', 'Europe'),
         ('DE', 'Federal Republic of Germany', 'Germany', 'Europe'),
         ('DE', 'Germany', 'Germany', 'Europe'),
         ('DJ', 'DJ', 'Djibouti', 'Africa'),
         ('DJ', 'Djibouti', 'Djibouti', 'Africa'),
         ('DJ', 'Republic of Djibouti', 'Djibouti', 'Africa'),
         ('DK', 'Dänemark', 'Denmark', 'Europe'),
         ('DK', 'Denmark', 'Denmark', 'Europe'),
         ('DK', 'DK', 'Denmark', 'Europe'),
         ('DK', 'Kingdom of Denmark', 'Denmark', 'Europe'),
         ('DM', 'DM', 'Dominica', 'North America'),
         ('DM', 'Dominica', 'Dominica', 'North America'),
         ('DO', 'DO', 'Dominican Republic', 'North America'),
         ('DO', 'Dominican Republic', 'Dominican Republic', 'North America'),
         ('DO', 'Dominikanische Republik', 'Dominican Republic', 'North America'),
         ('DZ', 'Algeria', 'Algeria', 'Africa'),
         ('DZ', 'Algerien', 'Algeria', 'Africa'),
         ('DZ', 'DZ', 'Algeria', 'Africa'),
         ('DZ', 'People\'s Democratic Republic of Algeria', 'Algeria', 'Africa'),
         ('EC', 'EC', 'Ecuador', 'South America'),
         ('EC', 'Ecuad.', 'Ecuador', 'South America'),
         ('EC', 'Ecuador', 'Ecuador', 'South America'),
         ('EC', 'Equador', 'Ecuador', 'South America'),
         ('EC', 'Republic of Ecuador', 'Ecuador', 'South America'),
         ('EE', 'EE', 'Estonia', 'Europe'),
         ('EE', 'Estland', 'Estonia', 'Europe'),
         ('EE', 'Estonia', 'Estonia', 'Europe'),
         ('EE', 'Republic of Estonia', 'Estonia', 'Europe'),
         ('EG', 'Ägypten', 'Egypt', 'Africa'),
         ('EG', 'Arab Republic of Egypt', 'Egypt', 'Africa'),
         ('EG', 'EG', 'Egypt', 'Africa'),
         ('EG', 'Egypt', 'Egypt', 'Africa'),
         ('EH', 'EH', 'Western Sahara', 'Africa'),
         ('EH', 'Western Sahara', 'Western Sahara', 'Africa'),
         ('ER', 'ER', 'Eritrea', 'Africa'),
         ('ER', 'Eritrea', 'Eritrea', 'Africa'),
         ('ER', 'State of Eritrea', 'Eritrea', 'Africa'),
         ('ES', 'ES', 'Spain', 'Europe'),
         ('ES', 'Kingdom of Spain', 'Spain', 'Europe'),
         ('ES', 'Spain', 'Spain', 'Europe'),
         ('ES', 'Spanien', 'Spain', 'Europe'),
         ('ES', 'Spaninen', 'Spain', 'Europe'),
         ('ET', 'Äthiopien', 'Ethiopia', 'Africa'),
         ('ET', 'ET', 'Ethiopia', 'Africa'),
         ('ET', 'Ethiopia', 'Ethiopia', 'Africa'),
         ('ET', 'Federal Democratic Republic of Ethiopia', 'Ethiopia', 'Africa'),
         ('FI', 'FI', 'Finland', 'Europe'),
         ('FI', 'Finland', 'Finland', 'Europe'),
         ('FI', 'Finnland', 'Finland', 'Europe'),
         ('FI', 'Republic of Finland', 'Finland', 'Europe'),
         ('FJ', 'Fidji Inseln', 'Fiji', 'Oceania'),
         ('FJ', 'Fidschi-Inseln', 'Fiji', 'Oceania'),
         ('FJ', 'Fiji', 'Fiji', 'Oceania'),
         ('FJ', 'Fiji-Ins.', 'Fiji', 'Oceania'),
         ('FJ', 'FJ', 'Fiji', 'Oceania'),
         ('FJ', 'Republic of the Fiji Islands', 'Fiji', 'Oceania'),
         ('FK', 'Falkland Islands', 'Falkland Islands', 'South America'),
         ('FK', 'FK', 'Falkland Islands', 'South America'),
         ('FM', 'FM', 'Micronesia', 'Oceania'),
         ('FM', 'Micronesia', 'Micronesia', 'Oceania'),
         ('FO', 'Faroe Islands', 'Faroe Islands', 'Europe'),
         ('FO', 'FO', 'Faroe Islands', 'Europe'),
         ('FR', 'FR', 'France', 'Europe'),
         ('FR', 'Framkreich', 'France', 'Europe'),
         ('FR', 'France', 'France', 'Europe'),
         ('FR', 'Frankreich', 'France', 'Europe'),
         ('FR', 'Republic of France', 'France', 'Europe'),
         ('GA', 'GA', 'Gabon', 'Africa'),
         ('GA', 'Gabon', 'Gabon', 'Africa'),
         ('GA', 'Gabonese Republic', 'Gabon', 'Africa'),
         ('GB', 'England', 'United Kingdom', 'Europe'),
         ('GB', 'GB', 'United Kingdom', 'Europe'),
         ('GB', 'Großbritanien', 'United Kingdom', 'Europe'),
         ('GB', 'Großbritannien', 'United Kingdom', 'Europe'),
         ('GB', 'Nordirland', 'United Kingdom', 'Europe'),
         ('GB', 'United Kingdom', 'United Kingdom', 'Europe'),
         ('GB', 'United Kingdom of Great Britain and Northern Ireland', 'United Kingdom', 'Europe'),
         ('GD', 'GD', 'Grenada', 'North America'),
         ('GD', 'Grenada', 'Grenada', 'North America'),
         ('GE', 'GE', 'Georgia', 'Asia'),
         ('GE', 'Georgia', 'Georgia', 'Asia'),
         ('GE', 'Georgien', 'Georgia', 'Asia'),
         ('GF', 'Französisch Guyana', 'French Guiana', 'South America'),
         ('GF', 'French Guiana', 'French Guiana', 'South America'),
         ('GF', 'GF', 'French Guiana', 'South America'),
         ('GG', 'GG', 'Guernsey', 'Europe'),
         ('GG', 'Guernsey', 'Guernsey', 'Europe'),
         ('GH', 'GH', 'Ghana', 'Africa'),
         ('GH', 'Ghana', 'Ghana', 'Africa'),
         ('GH', 'Republic of Ghana', 'Ghana', 'Africa'),
         ('GI', 'GI', 'Gibraltar', 'Europe'),
         ('GI', 'Gibraltar', 'Gibraltar', 'Europe'),
         ('GL', 'GL', 'Greenland', 'North America'),
         ('GL', 'Greenland', 'Greenland', 'North America'),
         ('GM', 'Gambia', 'Gambia', 'Africa'),
         ('GM', 'GM', 'Gambia', 'Africa'),
         ('GN', 'GN', 'Guinea', 'Africa'),
         ('GN', 'Guinea', 'Guinea', 'Africa'),
         ('GN', 'Republic of Guinea', 'Guinea', 'Africa'),
         ('GP', 'GP', 'Guadeloupe', 'North America'),
         ('GP', 'Guadeloupe', 'Guadeloupe', 'North America'),
         ('GQ', 'Äquatorial-Guinea', 'Equatorial Guinea', 'Africa'),
         ('GQ', 'Equatorial Guinea', 'Equatorial Guinea', 'Africa'),
         ('GQ', 'GQ', 'Equatorial Guinea', 'Africa'),
         ('GQ', 'Republic of Equatorial Guinea', 'Equatorial Guinea', 'Africa'),
         ('GR', 'GR', 'Greece', 'Europe'),
         ('GR', 'Greece', 'Greece', 'Europe'),
         ('GR', 'Greek', 'Greece', 'Europe'),
         ('GR', 'Griechenland', 'Greece', 'Europe'),
         ('GR', 'Hellenic Republic', 'Greece', 'Europe'),
         ('GS', 'GS', 'South Georgia and the South Sandwich Islands', 'Antarctica'),
         ('GS', 'South Georgia and the South Sandwich Islands', 'South Georgia and the South Sandwich Islands', 'Antarctica'),
         ('GT', 'GT', 'Guatemala', 'North America'),
         ('GT', 'Guatemala', 'Guatemala', 'North America'),
         ('GT', 'Republic of Guatemala', 'Guatemala', 'North America'),
         ('GU', 'GU', 'Guam', 'Oceania'),
         ('GU', 'Guam', 'Guam', 'Oceania'),
         ('GW', 'Guinea-Bissau', 'Guinea-Bissau', 'Africa'),
         ('GW', 'GW', 'Guinea-Bissau', 'Africa'),
         ('GW', 'Republic of Guinea-Bissau', 'Guinea-Bissau', 'Africa'),
         ('GY', 'Co-operative Republic of Guyana', 'Guyana', 'South America'),
         ('GY', 'Guyana', 'Guyana', 'South America'),
         ('GY', 'GY', 'Guyana', 'South America'),
         ('HK', 'HK', 'Hong Kong', 'Asia'),
         ('HK', 'Hong Kong', 'Hong Kong', 'Asia'),
         ('HM', 'Heard Island and McDonald Islands', 'Heard Island and McDonald Islands', 'Antarctica'),
         ('HM', 'HM', 'Heard Island and McDonald Islands', 'Antarctica'),
         ('HN', 'HN', 'Honduras', 'North America'),
         ('HN', 'Honduras', 'Honduras', 'North America'),
         ('HN', 'Republic of Honduras', 'Honduras', 'North America'),
         ('HR', 'Croatia', 'Croatia', 'Europe'),
         ('HR', 'Croatien', 'Croatia', 'Europe'),
         ('HR', 'HR', 'Croatia', 'Europe'),
         ('HR', 'Kroatien', 'Croatia', 'Europe'),
         ('HR', 'Republic of Croatia', 'Croatia', 'Europe'),
         ('HT', 'Haiti', 'Haiti', 'North America'),
         ('HT', 'HT', 'Haiti', 'North America'),
         ('HT', 'Republic of Haiti', 'Haiti', 'North America'),
         ('HU', 'HU', 'Hungary', 'Europe'),
         ('HU', 'Hungary', 'Hungary', 'Europe'),
         ('HU', 'Republic of Hungary', 'Hungary', 'Europe'),
         ('HU', 'Ungarn', 'Hungary', 'Europe'),
         ('ID', 'Holl. N. Guinea', 'Indonesia', 'Asia'),
         ('ID', 'Holl. N-Guinea', 'Indonesia', 'Asia'),
         ('ID', 'Holl.N.Guinea', 'Indonesia', 'Asia'),
         ('ID', 'ID', 'Indonesia', 'Asia'),
         ('ID', 'Indonesia', 'Indonesia', 'Asia'),
         ('ID', 'Indonesien', 'Indonesia', 'Asia'),
         ('ID', 'Java', 'Indonesia', 'Asia'),
         ('ID', 'Molukken', 'Indonesia', 'Asia'),
         ('ID', 'Molukken Inseln', 'Indonesia', 'Asia'),
         ('ID', 'Ost-Java', 'Indonesia', 'Asia'),
         ('ID', 'Republic of Indonesia', 'Indonesia', 'Asia'),
         ('ID', 'Sulawesi', 'Indonesia', 'Asia'),
         ('ID', 'W. Java', 'Indonesia', 'Asia'),
         ('ID', 'W.Java', 'Indonesia', 'Asia'),
         ('ID', 'West Papua', 'Indonesia', 'Asia'),
         ('ID', 'Westjava', 'Indonesia', 'Asia'),
         ('ID', 'W-Java', 'Indonesia', 'Asia'),
         ('IE', 'Eire', 'Ireland', 'Europe'),
         ('IE', 'IE', 'Ireland', 'Europe'),
         ('IE', 'Ireland', 'Ireland', 'Europe'),
         ('IL', 'IL', 'Israel', 'Asia'),
         ('IL', 'Israel', 'Israel', 'Asia'),
         ('IL', 'Palästinensische Gebiete (Israel),', 'Israel', 'Asia'),
         ('IL', 'State of Israel', 'Israel', 'Asia'),
         ('IM', 'IM', 'Isle of Man', 'Europe'),
         ('IM', 'Isle of Man', 'Isle of Man', 'Europe'),
         ('IN', 'IN', 'India', 'Asia'),
         ('IN', 'India', 'India', 'Asia'),
         ('IN', 'Indien', 'India', 'Asia'),
         ('IN', 'Republic of India', 'India', 'Asia'),
         ('IN', 'Sikkim', 'India', 'Asia'),
         ('IO', 'British Indian Ocean Territory', 'British Indian Ocean Territory', 'Asia'),
         ('IO', 'IO', 'British Indian Ocean Territory', 'Asia'),
         ('IQ', 'IQ', 'Iraq', 'Asia'),
         ('IQ', 'Irak', 'Iraq', 'Asia'),
         ('IQ', 'Iraq', 'Iraq', 'Asia'),
         ('IQ', 'Republic of Iraq', 'Iraq', 'Asia'),
         ('IR', 'IR', 'Iran', 'Asia'),
         ('IR', 'Iran', 'Iran', 'Asia'),
         ('IR', 'Islamic Republic of Iran', 'Iran', 'Asia'),
         ('IR', 'Persien', 'Iran', 'Asia'),
         ('IS', 'Iceland', 'Iceland', 'Europe'),
         ('IS', 'IS', 'Iceland', 'Europe'),
         ('IS', 'Island', 'Iceland', 'Europe'),
         ('IS', 'Republic of Iceland', 'Iceland', 'Europe'),
         ('IT', 'IT', 'Italy', 'Europe'),
         ('IT', 'Italein', 'Italy', 'Europe'),
         ('IT', 'Italian Republic', 'Italy', 'Europe'),
         ('IT', 'Italien', 'Italy', 'Europe'),
         ('IT', 'Italy', 'Italy', 'Europe'),
         ('IT', 'Itlaien', 'Italy', 'Europe'),
         ('IT', 'Sardinien', 'Italy', 'Europe'),
         ('IT', 'Sicilia', 'Italy', 'Europe'),
         ('JE', 'JE', 'Jersey', 'Europe'),
         ('JE', 'Jersey', 'Jersey', 'Europe'),
         ('JM', 'Jamaica', 'Jamaica', 'North America'),
         ('JM', 'Jamaika', 'Jamaica', 'North America'),
         ('JM', 'JM', 'Jamaica', 'North America'),
         ('JO', 'Hashemite Kingdom of Jordan', 'Jordan', 'Asia'),
         ('JO', 'JO', 'Jordan', 'Asia'),
         ('JO', 'Jordan', 'Jordan', 'Asia'),
         ('JO', 'Jordanien', 'Jordan', 'Asia'),
         ('JP', 'Japan', 'Japan', 'Asia'),
         ('JP', 'JP', 'Japan', 'Asia'),
         ('KE', 'KE', 'Kenya', 'Africa'),
         ('KE', 'Kenia', 'Kenya', 'Africa'),
         ('KE', 'Kenya', 'Kenya', 'Africa'),
         ('KE', 'Republic of Kenya', 'Kenya', 'Africa'),
         ('KG', 'KG', 'Kyrgyzstan', 'Asia'),
         ('KG', 'Kyrgyz Republic', 'Kyrgyzstan', 'Asia'),
         ('KG', 'Kyrgyzstan', 'Kyrgyzstan', 'Asia'),
         ('KH', 'Cambodia', 'Cambodia', 'Asia'),
         ('KH', 'KH', 'Cambodia', 'Asia'),
         ('KH', 'Kingdom of Cambodia', 'Cambodia', 'Asia'),
         ('KI', 'KI', 'Kiribati', 'Oceania'),
         ('KI', 'Kiribati', 'Kiribati', 'Oceania'),
         ('KI', 'Republic of Kiribati', 'Kiribati', 'Oceania'),
         ('KM', 'Comoros', 'Comoros', 'Africa'),
         ('KM', 'KM', 'Comoros', 'Africa'),
         ('KM', 'Union of the Comoros', 'Comoros', 'Africa'),
         ('KN', 'Federation of Saint Kitts and Nevis', 'Saint Kitts and Nevis', 'North America'),
         ('KN', 'KN', 'Saint Kitts and Nevis', 'North America'),
         ('KN', 'Saint Kitts and Nevis', 'Saint Kitts and Nevis', 'North America'),
         ('KP', 'Democratic People\'s Republic of Korea', 'North Korea', 'Asia'),
         ('KP', 'KP', 'North Korea', 'Asia'),
         ('KP', 'North Korea', 'North Korea', 'Asia'),
         ('KR', 'KR', 'South Korea', 'Asia'),
         ('KR', 'Republic of Korea', 'South Korea', 'Asia'),
         ('KR', 'South Korea', 'South Korea', 'Asia'),
         ('KW', 'Kuwait', 'Kuwait', 'Asia'),
         ('KW', 'KW', 'Kuwait', 'Asia'),
         ('KW', 'State of Kuwait', 'Kuwait', 'Asia'),
         ('KY', 'Cayman Islands', 'Cayman Islands', 'North America'),
         ('KY', 'KY', 'Cayman Islands', 'North America'),
         ('KZ', 'Kasachstan', 'Kazakhstan', 'Asia'),
         ('KZ', 'Kazakhstan', 'Kazakhstan', 'Asia'),
         ('KZ', 'KZ', 'Kazakhstan', 'Asia'),
         ('KZ', 'Republic of Kazakhstan', 'Kazakhstan', 'Asia'),
         ('LA', 'LA', 'Laos', 'Asia'),
         ('LA', 'Lao People\'s Democratic Republic', 'Laos', 'Asia'),
         ('LA', 'Laos', 'Laos', 'Asia'),
         ('LB', 'LB', 'Lebanon', 'Asia'),
         ('LB', 'Lebanon', 'Lebanon', 'Asia'),
         ('LB', 'Libanon', 'Lebanon', 'Asia'),
         ('LB', 'Republic of Lebanon', 'Lebanon', 'Asia'),
         ('LC', 'LC', 'Saint Lucia', 'North America'),
         ('LC', 'Saint Lucia', 'Saint Lucia', 'North America'),
         ('LI', 'LI', 'Liechtenstein', 'Europe'),
         ('LI', 'Liechtenstein', 'Liechtenstein', 'Europe'),
         ('LI', 'Principality of Liechtenstein', 'Liechtenstein', 'Europe'),
         ('LK', 'Democratic Socialist Republic of Sri Lanka', 'Sri Lanka', 'Asia'),
         ('LK', 'LK', 'Sri Lanka', 'Asia'),
         ('LK', 'Sri Lanka', 'Sri Lanka', 'Asia'),
         ('LK', 'Z-Sri Lanka', 'Sri Lanka', 'Asia'),
         ('LR', 'Liberia', 'Liberia', 'Africa'),
         ('LR', 'LR', 'Liberia', 'Africa'),
         ('LR', 'Republic of Liberia', 'Liberia', 'Africa'),
         ('LS', 'Kingdom of Lesotho', 'Lesotho', 'Africa'),
         ('LS', 'Lesotho', 'Lesotho', 'Africa'),
         ('LS', 'LS', 'Lesotho', 'Africa'),
         ('LT', 'Litauen', 'Lithuania', 'Europe'),
         ('LT', 'Lithuania', 'Lithuania', 'Europe'),
         ('LT', 'LT', 'Lithuania', 'Europe'),
         ('LT', 'Republic of Lithuania', 'Lithuania', 'Europe'),
         ('LU', 'Grand Duchy of Luxembourg', 'Luxembourg', 'Europe'),
         ('LU', 'LU', 'Luxembourg', 'Europe'),
         ('LU', 'Luxembourg', 'Luxembourg', 'Europe'),
         ('LU', 'Luxemburg', 'Luxembourg', 'Europe'),
         ('LV', 'Latvia', 'Latvia', 'Europe'),
         ('LV', 'Lettland', 'Latvia', 'Europe'),
         ('LV', 'LV', 'Latvia', 'Europe'),
         ('LV', 'Republic of Latvia', 'Latvia', 'Europe'),
         ('LY', 'Great Socialist People\'s Libyan Arab Jamahiriya', 'Libya', 'Africa'),
         ('LY', 'Libya', 'Libya', 'Africa'),
         ('LY', 'Libyen', 'Libya', 'Africa'),
         ('LY', 'LY', 'Libya', 'Africa'),
         ('MA', 'Kingdom of Morocco', 'Morocco', 'Africa'),
         ('MA', 'MA', 'Morocco', 'Africa'),
         ('MA', 'Marokko', 'Morocco', 'Africa'),
         ('MA', 'Marrokko', 'Morocco', 'Africa'),
         ('MA', 'Morocco', 'Morocco', 'Africa'),
         ('MC', 'MC', 'Monaco', 'Europe'),
         ('MC', 'Monaco', 'Monaco', 'Europe'),
         ('MC', 'Principality of Monaco', 'Monaco', 'Europe'),
         ('MD', 'MD', 'Moldova', 'Europe'),
         ('MD', 'Moldavien', 'Moldova', 'Europe'),
         ('MD', 'Moldawien', 'Moldova', 'Europe'),
         ('MD', 'Moldova', 'Moldova', 'Europe'),
         ('MD', 'Republic of Moldova', 'Moldova', 'Europe'),
         ('ME', 'ME', 'Montenegro', 'Europe'),
         ('ME', 'Montenegro', 'Montenegro', 'Europe'),
         ('ME', 'Republic of Montenegro', 'Montenegro', 'Europe'),
         ('MF', 'MF', 'Saint Martin', 'North America'),
         ('MF', 'Saint Martin', 'Saint Martin', 'North America'),
         ('MG', 'Madagascar', 'Madagascar', 'Africa'),
         ('MG', 'Madagaskar', 'Madagascar', 'Africa'),
         ('MG', 'MG', 'Madagascar', 'Africa'),
         ('MG', 'Republic of Madagascar', 'Madagascar', 'Africa'),
         ('MH', 'Marshall Islands', 'Marshall Islands', 'Oceania'),
         ('MH', 'MH', 'Marshall Islands', 'Oceania'),
         ('MK', 'Macedonia', 'Macedonia', 'Europe'),
         ('MK', 'MK', 'Macedonia', 'Europe'),
         ('MK', 'Republika Makedonija', 'Macedonia', 'Europe'),
         ('ML', 'Mali', 'Mali', 'Africa'),
         ('ML', 'ML', 'Mali', 'Africa'),
         ('ML', 'Republic of Mali', 'Mali', 'Africa'),
         ('MM', 'Burma', 'Myanmar', 'Asia'),
         ('MM', 'MM', 'Myanmar', 'Asia'),
         ('MM', 'Myanmar', 'Myanmar', 'Asia'),
         ('MM', 'Union of Burma', 'Myanmar', 'Asia'),
         ('MN', 'MN', 'Mongolia', 'Asia'),
         ('MN', 'Mongolia', 'Mongolia', 'Asia'),
         ('MO', 'Macao', 'Macao', 'Asia'),
         ('MO', 'MO', 'Macao', 'Asia'),
         ('MP', 'MP', 'Northern Mariana Islands', 'Oceania'),
         ('MP', 'Northern Mariana Islands', 'Northern Mariana Islands', 'Oceania'),
         ('MQ', 'Martinique', 'Martinique', 'North America'),
         ('MQ', 'MQ', 'Martinique', 'North America'),
         ('MR', 'Islamic Republic of Mauritania', 'Mauritania', 'Africa'),
         ('MR', 'Mauretanien', 'Mauritania', 'Africa'),
         ('MR', 'Mauritania', 'Mauritania', 'Africa'),
         ('MR', 'MR', 'Mauritania', 'Africa'),
         ('MS', 'Montserrat', 'Montserrat', 'North America'),
         ('MS', 'MS', 'Montserrat', 'North America'),
         ('MT', 'Malta', 'Malta', 'Europe'),
         ('MT', 'MT', 'Malta', 'Europe'),
         ('MU', 'Mauritius', 'Mauritius', 'Africa'),
         ('MU', 'MU', 'Mauritius', 'Africa'),
         ('MU', 'Republic of Mauritius', 'Mauritius', 'Africa'),
         ('MV', 'Maldives', 'Maldives', 'Asia'),
         ('MV', 'MV', 'Maldives', 'Asia'),
         ('MV', 'Republic of Maldives', 'Maldives', 'Asia'),
         ('MW', 'Malawi', 'Malawi', 'Africa'),
         ('MW', 'MW', 'Malawi', 'Africa'),
         ('MW', 'Republic of Malawi', 'Malawi', 'Africa'),
         ('MX', 'Mexico', 'Mexico', 'North America'),
         ('MX', 'Mexiko', 'Mexico', 'North America'),
         ('MX', 'MX', 'Mexico', 'North America'),
         ('MY', 'Malaysia', 'Malaysia', 'Asia'),
         ('MY', 'MY', 'Malaysia', 'Asia'),
         ('MY', 'Ostmalaysia', 'Malaysia', 'Asia'),
         ('MY', 'Ost-Malaysia', 'Malaysia', 'Asia'),
         ('MY', 'West Malaysia', 'Malaysia', 'Asia'),
         ('MY', 'Westmalaysia', 'Malaysia', 'Asia'),
         ('MY', 'West-Malaysia', 'Malaysia', 'Asia'),
         ('MY', 'W-Malaysia', 'Malaysia', 'Asia'),
         ('MZ', 'Mosambik', 'Mozambique', 'Africa'),
         ('MZ', 'Mozambik', 'Mozambique', 'Africa'),
         ('MZ', 'Mozambique', 'Mozambique', 'Africa'),
         ('MZ', 'MZ', 'Mozambique', 'Africa'),
         ('MZ', 'Republic of Mozambique', 'Mozambique', 'Africa'),
         ('NA', 'D. S. W. Afrika', 'Namibia', 'Africa'),
         ('NA', 'D. SW. Afrika', 'Namibia', 'Africa'),
         ('NA', 'D. SW.-Afrika', 'Namibia', 'Africa'),
         ('NA', 'D.S.W. Afrika', 'Namibia', 'Africa'),
         ('NA', 'NA', 'Namibia', 'Africa'),
         ('NA', 'Namibia', 'Namibia', 'Africa'),
         ('NA', 'Republic of Namibia', 'Namibia', 'Africa'),
         ('NC', 'NC', 'New Caledonia', 'Oceania'),
         ('NC', 'New Caledonia', 'New Caledonia', 'Oceania'),
         ('NE', 'NE', 'Niger', 'Africa'),
         ('NE', 'Niger', 'Niger', 'Africa'),
         ('NE', 'Republic of Niger', 'Niger', 'Africa'),
         ('NF', 'NF', 'Norfolk Island', 'Oceania'),
         ('NF', 'Norfolk Island', 'Norfolk Island', 'Oceania'),
         ('NG', 'Federal Republic of Nigeria', 'Nigeria', 'Africa'),
         ('NG', 'NG', 'Nigeria', 'Africa'),
         ('NG', 'Nigeria', 'Nigeria', 'Africa'),
         ('NI', 'NI', 'Nicaragua', 'North America'),
         ('NI', 'Nicaragua', 'Nicaragua', 'North America'),
         ('NI', 'Republic of Nicaragua', 'Nicaragua', 'North America'),
         ('NL', 'Kingdom of the Netherlands', 'Netherlands', 'Europe'),
         ('NL', 'Netherlands', 'Netherlands', 'Europe'),
         ('NL', 'Niederland', 'Netherlands', 'Europe'),
         ('NL', 'Niederlande', 'Netherlands', 'Europe'),
         ('NL', 'Niedrlande', 'Netherlands', 'Europe'),
         ('NL', 'NL', 'Netherlands', 'Europe'),
         ('NO', 'Kingdom of Norway', 'Norway', 'Europe'),
         ('NO', 'NO', 'Norway', 'Europe'),
         ('NO', 'Norway', 'Norway', 'Europe'),
         ('NO', 'Norwegen', 'Norway', 'Europe'),
         ('NP', 'Kingdom of Nepal', 'Nepal', 'Asia'),
         ('NP', 'Nepal', 'Nepal', 'Asia'),
         ('NP', 'NP', 'Nepal', 'Asia'),
         ('NR', 'Naoero', 'Nauru', 'Oceania'),
         ('NR', 'Nauru', 'Nauru', 'Oceania'),
         ('NR', 'NR', 'Nauru', 'Oceania'),
         ('NU', 'Niue', 'Niue', 'Oceania'),
         ('NU', 'NU', 'Niue', 'Oceania'),
         ('NZ', 'N. Seeland', 'New Zealand', 'Oceania'),
         ('NZ', 'Neu Seeland', 'New Zealand', 'Oceania'),
         ('NZ', 'Neuseeland', 'New Zealand', 'Oceania'),
         ('NZ', 'Neu-Seeland', 'New Zealand', 'Oceania'),
         ('NZ', 'New Zealand', 'New Zealand', 'Oceania'),
         ('NZ', 'Nov. Seeland', 'New Zealand', 'Oceania'),
         ('NZ', 'N-Seeland', 'New Zealand', 'Oceania'),
         ('NZ', 'NZ', 'New Zealand', 'Oceania'),
         ('OM', 'OM', 'Oman', 'Asia'),
         ('OM', 'Oman', 'Oman', 'Asia'),
         ('OM', 'Sultanate of Oman', 'Oman', 'Asia'),
         ('PA', 'PA', 'Panama', 'North America'),
         ('PA', 'Panama', 'Panama', 'North America'),
         ('PA', 'Republic of Panama', 'Panama', 'North America'),
         ('PE', 'N.-Peru', 'Peru', 'South America'),
         ('PE', 'PE', 'Peru', 'South America'),
         ('PE', 'Peru', 'Peru', 'South America'),
         ('PE', 'Republic of Peru', 'Peru', 'South America'),
         ('PE', 'W-Peru', 'Peru', 'South America'),
         ('PF', 'French Polynesia', 'French Polynesia', 'Oceania'),
         ('PF', 'PF', 'French Polynesia', 'Oceania'),
         ('PF', 'Tahiti', 'French Polynesia', 'Oceania'),
         ('PG', 'Bismarkarchipel', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Independent State of Papua New Guinea', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu Britanien', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu Mecklenburg', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu Pommern', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu-Britanien', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu-Britannien', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neuirland', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu-Mecklenburg', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neupommern', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Neu-Pommern', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Nov. Britt.', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Papua Neuguinea', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Papua New Guinea', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Papua-Neuguinea', 'Papua New Guinea', 'Oceania'),
         ('PG', 'PG', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Solomon Inseln', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Solomon Islands', 'Papua New Guinea', 'Oceania'),
         ('PG', 'Solomon-Ins.', 'Papua New Guinea', 'Oceania'),
         ('PH', 'PH', 'Philippines', 'Asia'),
         ('PH', 'Philippinen', 'Philippines', 'Asia'),
         ('PH', 'Philippines', 'Philippines', 'Asia'),
         ('PH', 'Republic of the Philippines', 'Philippines', 'Asia'),
         ('PK', 'Islamic Republic of Pakistan', 'Pakistan', 'Asia'),
         ('PK', 'Pakistan', 'Pakistan', 'Asia'),
         ('PK', 'PK', 'Pakistan', 'Asia'),
         ('PL', 'PL', 'Poland', 'Europe'),
         ('PL', 'Poland', 'Poland', 'Europe'),
         ('PL', 'Polen', 'Poland', 'Europe'),
         ('PL', 'Republic of Poland', 'Poland', 'Europe'),
         ('PM', 'PM', 'Saint Pierre and Miquelon', 'North America'),
         ('PM', 'Saint Pierre and Miquelon', 'Saint Pierre and Miquelon', 'North America'),
         ('PN', 'Pitcairn', 'Pitcairn', 'Oceania'),
         ('PN', 'PN', 'Pitcairn', 'Oceania'),
         ('PR', 'PR', 'Puerto Rico', 'North America'),
         ('PR', 'Puerto Rico', 'Puerto Rico', 'North America'),
         ('PS', 'Palestinian Territory', 'Palestinian Territory', 'Asia'),
         ('PS', 'PS', 'Palestinian Territory', 'Asia'),
         ('PT', 'Portigal', 'Portugal', 'Europe'),
         ('PT', 'Portugal', 'Portugal', 'Europe'),
         ('PT', 'Portuguese Republic', 'Portugal', 'Europe'),
         ('PT', 'Protigal', 'Portugal', 'Europe'),
         ('PT', 'PT', 'Portugal', 'Europe'),
         ('PW', 'Palau', 'Palau', 'Oceania'),
         ('PW', 'PW', 'Palau', 'Oceania'),
         ('PY', 'Paraguay', 'Paraguay', 'South America'),
         ('PY', 'PY', 'Paraguay', 'South America'),
         ('PY', 'Republic of Paraguay', 'Paraguay', 'South America'),
         ('QA', 'QA', 'Qatar', 'Asia'),
         ('QA', 'Qatar', 'Qatar', 'Asia'),
         ('QA', 'State of Qatar', 'Qatar', 'Asia'),
         ('RE', 'RE', 'Reunion', 'Africa'),
         ('RE', 'Reunion', 'Reunion', 'Africa'),
         ('RO', 'RO', 'Romania', 'Europe'),
         ('RO', 'Romania', 'Romania', 'Europe'),
         ('RO', 'Rumänien', 'Romania', 'Europe'),
         ('RS', 'RS', 'Serbia', 'Europe'),
         ('RS', 'Serbia', 'Serbia', 'Europe'),
         ('RU', 'RU', 'Russia', 'Europe'),
         ('RU', 'Russand', 'Russia', 'Europe'),
         ('RU', 'Russia', 'Russia', 'Europe'),
         ('RU', 'Russian Federation', 'Russia', 'Europe'),
         ('RU', 'Russland', 'Russia', 'Europe'),
         ('RW', 'Republic of Rwanda', 'Rwanda', 'Africa'),
         ('RW', 'RW', 'Rwanda', 'Africa'),
         ('RW', 'Rwanda', 'Rwanda', 'Africa'),
         ('SA', 'Kingdom of Saudi Arabia', 'Saudi Arabia', 'Asia'),
         ('SA', 'SA', 'Saudi Arabia', 'Asia'),
         ('SA', 'Saudi Arabia', 'Saudi Arabia', 'Asia'),
         ('SA', 'Saudi-Arabien', 'Saudi Arabia', 'Asia'),
         ('SB', 'Salomonen', 'Solomon Islands', 'Oceania'),
         ('SB', 'SB', 'Solomon Islands', 'Oceania'),
         ('SB', 'Solomon Islands', 'Solomon Islands', 'Oceania'),
         ('SC', 'Republic of Seychelles', 'Seychelles', 'Africa'),
         ('SC', 'SC', 'Seychelles', 'Africa'),
         ('SC', 'Seychellen', 'Seychelles', 'Africa'),
         ('SC', 'Seychelles', 'Seychelles', 'Africa'),
         ('SD', 'Republic of the Sudan', 'Sudan', 'Africa'),
         ('SD', 'SD', 'Sudan', 'Africa'),
         ('SD', 'Sudan', 'Sudan', 'Africa'),
         ('SE', 'Kingdom of Sweden', 'Sweden', 'Europe'),
         ('SE', 'Schweden', 'Sweden', 'Europe'),
         ('SE', 'SE', 'Sweden', 'Europe'),
         ('SE', 'Sweden', 'Sweden', 'Europe'),
         ('SG', 'Republic of Singapore', 'Singapore', 'Asia'),
         ('SG', 'SG', 'Singapore', 'Asia'),
         ('SG', 'Singapore', 'Singapore', 'Asia'),
         ('SG', 'Singapur', 'Singapore', 'Asia'),
         ('SH', 'Saint Helena', 'Saint Helena', 'Africa'),
         ('SH', 'SH', 'Saint Helena', 'Africa'),
         ('SI', 'Republic of Slovenia', 'Slovenia', 'Europe'),
         ('SI', 'SI', 'Slovenia', 'Europe'),
         ('SI', 'Slovenia', 'Slovenia', 'Europe'),
         ('SJ', 'SJ', 'Svalbard and Jan Mayen', 'Europe'),
         ('SJ', 'Svalbard and Jan Mayen', 'Svalbard and Jan Mayen', 'Europe'),
         ('SK', 'SK', 'Slovakia', 'Europe'),
         ('SK', 'Slovakia', 'Slovakia', 'Europe'),
         ('SK', 'Slovenien', 'Slovakia', 'Europe'),
         ('SK', 'Slovensko', 'Slovakia', 'Europe'),
         ('SK', 'Slowakei', 'Slovakia', 'Europe'),
         ('SK', 'Slowenien', 'Slovakia', 'Europe'),
         ('SL', 'Republic of Sierra Leone', 'Sierra Leone', 'Africa'),
         ('SL', 'Sierra Leone', 'Sierra Leone', 'Africa'),
         ('SL', 'SL', 'Sierra Leone', 'Africa'),
         ('SM', 'Republic of San Marino', 'San Marino', 'Europe'),
         ('SM', 'San Marino', 'San Marino', 'Europe'),
         ('SM', 'SM', 'San Marino', 'Europe'),
         ('SN', 'Republic of Senegal', 'Senegal', 'Africa'),
         ('SN', 'Senegal', 'Senegal', 'Africa'),
         ('SN', 'SN', 'Senegal', 'Africa'),
         ('SO', 'SO', 'Somalia', 'Africa'),
         ('SO', 'Somalia', 'Somalia', 'Africa'),
         ('SR', 'Republic of Suriname', 'Suriname', 'South America'),
         ('SR', 'SR', 'Suriname', 'South America'),
         ('SR', 'Surinam', 'Suriname', 'South America'),
         ('SR', 'Suriname', 'Suriname', 'South America'),
         ('SS', 'South Sudan', 'South Sudan', 'Africa'),
         ('ST', 'Sao Tome and Principe', 'Sao Tome and Principe', 'Africa'),
         ('ST', 'ST', 'Sao Tome and Principe', 'Africa'),
         ('SV', 'El Salvador', 'El Salvador', 'North America'),
         ('SV', 'Republic of El Salvador', 'El Salvador', 'North America'),
         ('SV', 'SV', 'El Salvador', 'North America'),
         ('SX', 'Sint Maarten', 'Sint Maarten', 'North America'),
         ('SY', 'SY', 'Syria', 'Asia'),
         ('SY', 'Syria', 'Syria', 'Asia'),
         ('SY', 'Syrian Arab Republic', 'Syria', 'Asia'),
         ('SY', 'Syrien', 'Syria', 'Asia'),
         ('SZ', 'Kingdom of Swaziland', 'Swaziland', 'Africa'),
         ('SZ', 'Swaziland', 'Swaziland', 'Africa'),
         ('SZ', 'SZ', 'Swaziland', 'Africa'),
         ('TC', 'TC', 'Turks and Caicos Islands', 'North America'),
         ('TC', 'Turks and Caicos Islands', 'Turks and Caicos Islands', 'North America'),
         ('TD', 'Chad', 'Chad', 'Africa'),
         ('TD', 'Republic of Chad', 'Chad', 'Africa'),
         ('TD', 'TD', 'Chad', 'Africa'),
         ('TF', 'French Southern Territories', 'French Southern Territories', 'Antarctica'),
         ('TF', 'TF', 'French Southern Territories', 'Antarctica'),
         ('TG', 'TG', 'Togo', 'Africa'),
         ('TG', 'Togo', 'Togo', 'Africa'),
         ('TG', 'Togolese Republic', 'Togo', 'Africa'),
         ('TH', 'Kingdom of Thailand', 'Thailand', 'Asia'),
         ('TH', 'N-Thailand', 'Thailand', 'Asia'),
         ('TH', 'S-Thailand', 'Thailand', 'Asia'),
         ('TH', 'TH', 'Thailand', 'Asia'),
         ('TH', 'Thailand', 'Thailand', 'Asia'),
         ('TJ', 'Republic of Tajikistan', 'Tajikistan', 'Asia'),
         ('TJ', 'Tadschikistan', 'Tajikistan', 'Asia'),
         ('TJ', 'Tajikistan', 'Tajikistan', 'Asia'),
         ('TJ', 'TJ', 'Tajikistan', 'Asia'),
         ('TK', 'TK', 'Tokelau', 'Oceania'),
         ('TK', 'Tokelau', 'Tokelau', 'Oceania'),
         ('TL', 'Democratic Republic of Timor-Leste', 'East Timor', 'Oceania'),
         ('TL', 'East Timor', 'East Timor', 'Oceania'),
         ('TL', 'TL', 'East Timor', 'Oceania'),
         ('TM', 'TM', 'Turkmenistan', 'Asia'),
         ('TM', 'Turkmenistan', 'Turkmenistan', 'Asia'),
         ('TN', 'TN', 'Tunisia', 'Africa'),
         ('TN', 'Tunesien', 'Tunisia', 'Africa'),
         ('TN', 'Tunisia', 'Tunisia', 'Africa'),
         ('TN', 'Tunisian Republic', 'Tunisia', 'Africa'),
         ('TO', 'Kingdom of Tonga', 'Tonga', 'Oceania'),
         ('TO', 'TO', 'Tonga', 'Oceania'),
         ('TO', 'Tonga', 'Tonga', 'Oceania'),
         ('TR', 'Republic of Turkey', 'Turkey', 'Asia'),
         ('TR', 'TR', 'Turkey', 'Asia'),
         ('TR', 'Türkei', 'Turkey', 'Asia'),
         ('TR', 'Turkey', 'Turkey', 'Asia'),
         ('TT', 'Republic of Trinidad and Tobago', 'Trinidad and Tobago', 'North America'),
         ('TT', 'Trinidad and Tobago', 'Trinidad and Tobago', 'North America'),
         ('TT', 'Trinidad und Tobago', 'Trinidad and Tobago', 'North America'),
         ('TT', 'TT', 'Trinidad and Tobago', 'North America'),
         ('TV', 'Tuvalu', 'Tuvalu', 'Oceania'),
         ('TV', 'TV', 'Tuvalu', 'Oceania'),
         ('TW', 'Taiwan', 'Taiwan', 'Asia'),
         ('TW', 'TW', 'Taiwan', 'Asia'),
         ('TZ', 'Tansaania', 'Tanzania', 'Africa'),
         ('TZ', 'tansan', 'Tanzania', 'Africa'),
         ('TZ', 'Tansanai', 'Tanzania', 'Africa'),
         ('TZ', 'tansani', 'Tanzania', 'Africa'),
         ('TZ', 'Tansania', 'Tanzania', 'Africa'),
         ('TZ', 'Tansanina', 'Tanzania', 'Africa'),
         ('TZ', 'Tansanioa', 'Tanzania', 'Africa'),
         ('TZ', 'Tansasnia', 'Tanzania', 'Africa'),
         ('TZ', 'Tansnaia', 'Tanzania', 'Africa'),
         ('TZ', 'Tanssania', 'Tanzania', 'Africa'),
         ('TZ', 'Tanzania', 'Tanzania', 'Africa'),
         ('TZ', 'Tasnsania', 'Tanzania', 'Africa'),
         ('TZ', 'TZ', 'Tanzania', 'Africa'),
         ('TZ', 'United Republic of Tanzania', 'Tanzania', 'Africa'),
         ('UA', 'UA', 'Ukraine', 'Europe'),
         ('UA', 'ukrain', 'Ukraine', 'Europe'),
         ('UA', 'Ukraine', 'Ukraine', 'Europe'),
         ('UG', 'Republic of Uganda', 'Uganda', 'Africa'),
         ('UG', 'UG', 'Uganda', 'Africa'),
         ('UG', 'Uganda', 'Uganda', 'Africa'),
         ('UM', 'UM', 'United States Minor Outlying Islands', 'Oceania'),
         ('UM', 'United States Minor Outlying Islands', 'United States Minor Outlying Islands', 'Oceania'),
         ('US', 'U.S.A.', 'United States', 'North America'),
         ('US', 'United States', 'United States', 'North America'),
         ('US', 'US', 'United States', 'North America'),
         ('US', 'USA', 'United States', 'North America'),
         ('US', 'USA / Iowa', 'United States', 'North America'),
         ('UY', 'Oriental Republic of Uruguay', 'Uruguay', 'South America'),
         ('UY', 'Uruguay', 'Uruguay', 'South America'),
         ('UY', 'UY', 'Uruguay', 'South America'),
         ('UZ', 'Republic of Uzbekistan', 'Uzbekistan', 'Asia'),
         ('UZ', 'UZ', 'Uzbekistan', 'Asia'),
         ('UZ', 'Uzbekistan', 'Uzbekistan', 'Asia'),
         ('VA', 'State of the Vatican City', 'Vatican', 'Europe'),
         ('VA', 'VA', 'Vatican', 'Europe'),
         ('VA', 'Vatican', 'Vatican', 'Europe'),
         ('VC', 'Saint Vincent and the Grenadines', 'Saint Vincent and the Grenadines', 'North America'),
         ('VC', 'VC', 'Saint Vincent and the Grenadines', 'North America'),
         ('VE', 'Bolivarian Republic of Venezuela', 'Venezuela', 'South America'),
         ('VE', 'VE', 'Venezuela', 'South America'),
         ('VE', 'Venezuela', 'Venezuela', 'South America'),
         ('VG', 'British Virgin Islands', 'British Virgin Islands', 'North America'),
         ('VG', 'VG', 'British Virgin Islands', 'North America'),
         ('VI', 'U.S. Virgin Islands', 'U.S. Virgin Islands', 'North America'),
         ('VI', 'VI', 'U.S. Virgin Islands', 'North America'),
         ('VN', 'Central Vietnam', 'Vietnam', 'Asia'),
         ('VN', 'Nord-Vietnam', 'Vietnam', 'Asia'),
         ('VN', 'N-Vietnam', 'Vietnam', 'Asia'),
         ('VN', 'Socialist Republic of Vietnam', 'Vietnam', 'Asia'),
         ('VN', 'Tonkin', 'Vietnam', 'Asia'),
         ('VN', 'Tonking', 'Vietnam', 'Asia'),
         ('VN', 'Vietnam', 'Vietnam', 'Asia'),
         ('VN', 'VN', 'Vietnam', 'Asia'),
         ('VU', 'Republic of Vanuatu', 'Vanuatu', 'Oceania'),
         ('VU', 'Vanuatu', 'Vanuatu', 'Oceania'),
         ('VU', 'VU', 'Vanuatu', 'Oceania'),
         ('WF', 'Wallis and Futuna', 'Wallis and Futuna', 'Oceania'),
         ('WF', 'WF', 'Wallis and Futuna', 'Oceania'),
         ('WS', 'Independent State of Samoa', 'Samoa', 'Oceania'),
         ('WS', 'Samoa', 'Samoa', 'Oceania'),
         ('WS', 'WS', 'Samoa', 'Oceania'),
         ('XK', 'Kosovo', 'Kosovo', 'Europe'),
         ('YE', 'Republic of Yemen', 'Yemen', 'Asia'),
         ('YE', 'YE', 'Yemen', 'Asia'),
         ('YE', 'Yemen', 'Yemen', 'Asia'),
         ('YT', 'Mayotte', 'Mayotte', 'Africa'),
         ('YT', 'YT', 'Mayotte', 'Africa'),
         ('ZA', 'South Africa', 'South Africa', 'Africa'),
         ('ZA', 'Südafrika', 'South Africa', 'Africa'),
         ('ZA', 'Transvaal', 'South Africa', 'Africa'),
         ('ZA', 'ZA', 'South Africa', 'Africa'),
         ('ZM', 'Republic of Zambia', 'Zambia', 'Africa'),
         ('ZM', 'Sambia', 'Zambia', 'Africa'),
         ('ZM', 'Zambia', 'Zambia', 'Africa'),
         ('ZM', 'ZM', 'Zambia', 'Africa'),
         ('ZW', 'Republic of Zimbabwe', 'Zimbabwe', 'Africa'),
         ('ZW', 'Simbabwe', 'Zimbabwe', 'Africa'),
         ('ZW', 'Zimbabwe', 'Zimbabwe', 'Africa'),
         ('ZW', 'ZW', 'Zimbabwe', 'Africa');

GO

DELIMITER ;
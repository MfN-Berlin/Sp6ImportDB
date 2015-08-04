-- todo list begin
--
-- gbif als project
--
-- todo list end

USE MFN_Zool_Aves

GO

DROP TABLE dbo.t_specify_publflag

GO

CREATE TABLE dbo.t_specify_publflag
(
  visibilityId INT PRIMARY KEY
)

INSERT
  INTO dbo.t_specify_publflag (visibilityId)
  VALUES (0) -- full

GO

DROP VIEW dbo.exp_aves_accession

GO

CREATE VIEW dbo.exp_aves_accession
AS
  SELECT CONVERT(NVARCHAR(36),  [guid])     COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(128), 'ZMB_Aves') COLLATE Latin1_General_CI_AI AS specifycollcode,

         AccessionNumber COLLATE Latin1_General_CI_AI AS AccessionNumber,
         DateReceived,
         AccessionVerbatimDate COLLATE Latin1_General_CI_AI AS VerbatimDate,
         AccessionText3 COLLATE Latin1_General_CI_AI AS Text3,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND AccessionNumber IS NOT NULL

GO

DROP VIEW dbo.exp_aves_collectionobject

GO

CREATE VIEW dbo.exp_aves_collectionobject
AS
  SELECT CONVERT(NVARCHAR(36),  [guid])  COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(128), 'ZMB_Aves') COLLATE Latin1_General_CI_AI AS specifycollcode,

         CatalogNumber      COLLATE Latin1_General_CI_AI AS CatalogNumber,
         CatalogerFirstname COLLATE Latin1_General_CI_AI AS CatalogerFirstname,
         CatalogerLastname  COLLATE Latin1_General_CI_AI AS CatalogerLastname,
         CatalogedDate,

         AccessionNumber,

         [availability] COLLATE Latin1_General_CI_AI AS [availability],
         [description]  COLLATE Latin1_General_CI_AI AS [description],
         remarks        COLLATE Latin1_General_CI_AI AS remarks,
         collectionObjectText3 AS Text3,
         Visibility AS Integer1,

         collectionObjectYesNo1 AS YesNo1,
         collectionObjectYesNo2 AS YesNo2,

         T1.Continent COLLATE Latin1_General_CI_AI AS CollEventContinent,
         T1.Country COLLATE Latin1_General_CI_AI AS CollEventCountry,
         CONVERT(NVARCHAR(64), NULL) COLLATE Latin1_General_CI_AI AS CollEventState,
         T1.County COLLATE Latin1_General_CI_AI AS CollEventCounty,
         LocalityName COLLATE Latin1_General_CI_AI AS CollEventLocalityName,

         CASE
           WHEN ISDATE(StartDate) = 1
           THEN CONVERT(DATE, StartDate)
           ELSE NULL
         END AS CollEventStartDate,
         CASE
           WHEN StartDate LIKE '%-00-00'
           THEN NULL
           WHEN StartDate LIKE '%-00'
           THEN CONVERT(INT, SUBSTRING(StartDate, 6, 2))
           ELSE NULL
         END AS CollEventStartMonth,
         CASE
           WHEN StartDate LIKE '%-00'
           THEN CONVERT(INT, SUBSTRING(StartDate, 1, 4))
           ELSE NULL
         END AS CollEventStartYear,
         CONVERT(DATE, NULL) AS CollEventEndDate,
         CONVERT(INT, NULL) AS CollEventEndMonth,
         CONVERT(INT, NULL) AS CollEventEndYear,
         collectingEventVerbatimDate COLLATE Latin1_General_CI_AI AS CollEventVerbatimDate,

         LatLongType COLLATE Latin1_General_CI_AI AS CollEventLatLongType,
         CONVERT(NVARCHAR(50), Latitude1) COLLATE Latin1_General_CI_AI AS CollEventDMSLatitude1, 
         CASE
           WHEN (ISNUMERIC(Latitude1) <> 0)
           THEN CONVERT(DECIMAL(12,10), Latitude1)
           ELSE NULL
         END AS CollEventDDLatitude1, 
         CONVERT(NVARCHAR(50), Longitude1) COLLATE Latin1_General_CI_AI AS CollEventDMSLongitude1, 
         CASE
           WHEN (ISNUMERIC(Longitude1) <> 0)
           THEN CONVERT(DECIMAL(13,10), Longitude1)
           ELSE NULL
         END AS CollEventDDLongitude1, 
          
         StationFieldNumber COLLATE Latin1_General_CI_AI AS CollEventStationFieldNumber,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)

GO

DROP VIEW dbo.exp_aves_collector

GO

CREATE VIEW dbo.exp_aves_collector
AS
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_1' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         1 AS OrderNumber, 
         CollectorFirstName1 COLLATE Latin1_General_CI_AI AS FirstName,
         CollectorLastName1  COLLATE Latin1_General_CI_AI AS LastName,
         1 AS IsPrimary,
         CONVERT(NVARCHAR(MAX), NULL) AS Remarks,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND CollectorLastName1 > N''
  UNION
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_2' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         2 AS OrderNumber, 
         CollectorFirstName2 COLLATE Latin1_General_CI_AI AS FirstName,
         CollectorLastName2  COLLATE Latin1_General_CI_AI AS LastName,
         1 AS IsPrimary,
         CONVERT(NVARCHAR(MAX), NULL) AS Remarks,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND CollectorLastName2 > N''

GO

DROP VIEW dbo.exp_aves_determination

GO

CREATE VIEW dbo.exp_aves_determination
AS
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_1' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(64), N'Animalia') COLLATE Latin1_General_CI_AI AS Kingdom,
         CONVERT(NVARCHAR(64), N'Chordata') COLLATE Latin1_General_CI_AI AS Phylum,
         CONVERT(NVARCHAR(64), N'Aves')     COLLATE Latin1_General_CI_AI AS Class,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS [Order],
         Family1                            COLLATE Latin1_General_CI_AI AS Family,
         Genus1                             COLLATE Latin1_General_CI_AI AS Genus,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS Subgenus,
         Species1                           COLLATE Latin1_General_CI_AI AS Species,
         Subspecies1                        COLLATE Latin1_General_CI_AI AS Subspecies,

         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SpeciesAuthor, 
         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SubspeciesAuthor, 
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Addendum,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Qualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS SubSpQualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS VarQualifier,

         TypeStatusName1                    COLLATE Latin1_General_CI_AI AS TypeStatusName,

         CONVERT(DATE, NULL)                                             AS DeterminedDate,
         DeterminerFirstName1               COLLATE Latin1_General_CI_AI AS DeterminerFirstName,
         DeterminerLastName1                COLLATE Latin1_General_CI_AI AS DeterminerLastName,
         CONVERT(BIT, 1)                                                 AS IsCurrent,
         CONVERT(NVARCHAR(MAX), NULL)       COLLATE Latin1_General_CI_AI AS Remarks,
         CONVERT(BIT, 0)                                                 AS YesNo1,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND ([Family1] > N'' OR [Genus1] > N'' OR [Species1] > N'' OR [Subspecies1] > N'')
  UNION
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_2' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(64), N'Animalia') COLLATE Latin1_General_CI_AI AS Kingdom,
         CONVERT(NVARCHAR(64), N'Chordata') COLLATE Latin1_General_CI_AI AS Phylum,
         CONVERT(NVARCHAR(64), N'Aves')     COLLATE Latin1_General_CI_AI AS Class,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS [Order],
         Family2                            COLLATE Latin1_General_CI_AI AS Family,
         Genus2                             COLLATE Latin1_General_CI_AI AS Genus,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS Subgenus,
         Species2                           COLLATE Latin1_General_CI_AI AS Species,
         Subspecies2                        COLLATE Latin1_General_CI_AI AS Subspecies,

         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SpeciesAuthor, 
         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SubspeciesAuthor, 
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Addendum,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Qualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS SubSpQualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS VarQualifier,

         TypeStatusName2                    COLLATE Latin1_General_CI_AI AS TypeStatusName,

         CONVERT(DATE, NULL)                                             AS DeterminedDate,
         DeterminerFirstName2               COLLATE Latin1_General_CI_AI AS DeterminerFirstName,
         DeterminerLastName2                COLLATE Latin1_General_CI_AI AS DeterminerLastName,
         CONVERT(BIT, 0)                                                 AS IsCurrent,
         CONVERT(NVARCHAR(MAX), NULL)       COLLATE Latin1_General_CI_AI AS Remarks,
         CONVERT(BIT, 0)                                                 AS YesNo1,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND ([Family2] > N'' OR [Genus2] > N'' OR [Species2] > N'' OR [Subspecies2] > N'')
  UNION
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_3' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(64), N'Animalia') COLLATE Latin1_General_CI_AI AS Kingdom,
         CONVERT(NVARCHAR(64), N'Chordata') COLLATE Latin1_General_CI_AI AS Phylum,
         CONVERT(NVARCHAR(64), N'Aves')     COLLATE Latin1_General_CI_AI AS Class,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS [Order],
         Family3                            COLLATE Latin1_General_CI_AI AS Family,
         Genus3                             COLLATE Latin1_General_CI_AI AS Genus,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS Subgenus,
         Species3                           COLLATE Latin1_General_CI_AI AS Species,
         Subspecies3                        COLLATE Latin1_General_CI_AI AS Subspecies,

         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SpeciesAuthor, 
         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SubspeciesAuthor, 
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Addendum,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Qualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS SubSpQualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS VarQualifier,

         TypeStatusName3                    COLLATE Latin1_General_CI_AI AS TypeStatusName,

         CONVERT(DATE, NULL)                                             AS DeterminedDate,
         DeterminerFirstName3               COLLATE Latin1_General_CI_AI AS DeterminerFirstName,
         DeterminerLastName3                COLLATE Latin1_General_CI_AI AS DeterminerLastName,
         CONVERT(BIT, 0)                                                 AS IsCurrent,
         CONVERT(NVARCHAR(MAX), NULL)       COLLATE Latin1_General_CI_AI AS Remarks,
         CONVERT(BIT, 0)                                                 AS YesNo1,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND ([Family3] > N'' OR [Genus3] > N'' OR [Species3] > N'' OR [Subspecies3] > N'')
  UNION
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_4' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(64), N'Animalia') COLLATE Latin1_General_CI_AI AS Kingdom,
         CONVERT(NVARCHAR(64), N'Chordata') COLLATE Latin1_General_CI_AI AS Phylum,
         CONVERT(NVARCHAR(64), N'Aves')     COLLATE Latin1_General_CI_AI AS Class,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS [Order],
         Family4                            COLLATE Latin1_General_CI_AI AS Family,
         Genus4                             COLLATE Latin1_General_CI_AI AS Genus,
         CONVERT(NVARCHAR(64), NULL)        COLLATE Latin1_General_CI_AI AS Subgenus,
         Species4                           COLLATE Latin1_General_CI_AI AS Species,
         Subspecies4                        COLLATE Latin1_General_CI_AI AS Subspecies,

         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SpeciesAuthor, 
         CONVERT(NVARCHAR(128), NULL)       COLLATE Latin1_General_CI_AI AS SubspeciesAuthor, 
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Addendum,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS Qualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS SubSpQualifier,
         CONVERT(NVARCHAR(16),  NULL)       COLLATE Latin1_General_CI_AI AS VarQualifier,

         TypeStatusName4                    COLLATE Latin1_General_CI_AI AS TypeStatusName,

         CONVERT(DATE, NULL)                                             AS DeterminedDate,
         DeterminerFirstName4               COLLATE Latin1_General_CI_AI AS DeterminerFirstName,
         DeterminerLastName4                COLLATE Latin1_General_CI_AI AS DeterminerLastName,
         CONVERT(BIT, 0)                                                 AS IsCurrent,
         CONVERT(NVARCHAR(MAX), NULL)       COLLATE Latin1_General_CI_AI AS Remarks,
         CONVERT(BIT, 0)                                                 AS YesNo1,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND ([Family4] > N'' OR [Genus4] > N'' OR [Species4] > N'' OR [Subspecies4] > N'')

GO

DROP VIEW dbo.exp_aves_otherIdentifier

GO

CREATE VIEW dbo.exp_aves_otherIdentifier
AS
  SELECT CONVERT(NVARCHAR(36),  [guid])     COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])     COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves') COLLATE Latin1_General_CI_AI AS specifycollcode,

         otherIdentifier1             COLLATE Latin1_General_CI_AI AS Identifier, 
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS Institution,
         CONVERT(NVARCHAR(MAX), NULL) COLLATE Latin1_General_CI_AI AS Remarks,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)

GO

DROP VIEW dbo.exp_aves_preparation

GO

CREATE VIEW dbo.exp_aves_preparation
AS
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_1' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(255), NULL) COLLATE Latin1_General_CI_AI AS [Description],
         Count1                                                    AS [Count],
         PrepType1                    COLLATE Latin1_General_CI_AI AS PrepType,
         CONVERT(DATE, NULL)                                       AS PreparedDate,
         CONVERT(INT, NULL)                                        AS PreparedMonth,
         CONVERT(INT, NULL)                                        AS PreparedYear,
         CONVERT(NVARCHAR(50), NULL)  COLLATE Latin1_General_CI_AI AS PreparedByFirstName,
         CONVERT(NVARCHAR(120), NULL) COLLATE Latin1_General_CI_AI AS PreparedByLastName,
         CONVERT(NVARCHAR(32), NULL)  COLLATE Latin1_General_CI_AI AS SampleNumber,
         CONVERT(NVARCHAR(MAX), NULL) COLLATE Latin1_General_CI_AI AS Remarks,

         Building1                    COLLATE Latin1_General_CI_AI AS StorageBuilding,
         Collection1                  COLLATE Latin1_General_CI_AI AS StorageCollection,
         Room1                        COLLATE Latin1_General_CI_AI AS StorageRoom,
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS StorageCabinet,
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS StorageShelf,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND (PrepType1 IS NOT NULL)
  UNION
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_2' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(255), NULL) COLLATE Latin1_General_CI_AI AS [Description],
         Count2                                                    AS [Count],
         PrepType2                    COLLATE Latin1_General_CI_AI AS PrepType,
         CONVERT(DATE, NULL)                                       AS PreparedDate,
         CONVERT(INT, NULL)                                        AS PreparedMonth,
         CONVERT(INT, NULL)                                        AS PreparedYear,
         CONVERT(NVARCHAR(50), NULL)  COLLATE Latin1_General_CI_AI AS PreparedByFirstName,
         CONVERT(NVARCHAR(120), NULL) COLLATE Latin1_General_CI_AI AS PreparedByLastName,
         CONVERT(NVARCHAR(32), NULL)  COLLATE Latin1_General_CI_AI AS SampleNumber,
         CONVERT(NVARCHAR(MAX), NULL) COLLATE Latin1_General_CI_AI AS Remarks,

         Building2                    COLLATE Latin1_General_CI_AI AS StorageBuilding,
         Collection2                  COLLATE Latin1_General_CI_AI AS StorageCollection,
         Room2                        COLLATE Latin1_General_CI_AI AS StorageRoom,
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS StorageCabinet,
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS StorageShelf,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND (PrepType2 IS NOT NULL)
  UNION
  SELECT CONVERT(NVARCHAR(36),  [guid]) + N'_3' COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])         COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves')     COLLATE Latin1_General_CI_AI AS specifycollcode,

         CONVERT(NVARCHAR(255), NULL) COLLATE Latin1_General_CI_AI AS [Description],
         Count3                                                    AS [Count],
         PrepType3                    COLLATE Latin1_General_CI_AI AS PrepType,
         CONVERT(DATE, NULL)                                       AS PreparedDate,
         CONVERT(INT, NULL)                                        AS PreparedMonth,
         CONVERT(INT, NULL)                                        AS PreparedYear,
         CONVERT(NVARCHAR(50), NULL)  COLLATE Latin1_General_CI_AI AS PreparedByFirstName,
         CONVERT(NVARCHAR(120), NULL) COLLATE Latin1_General_CI_AI AS PreparedByLastName,
         CONVERT(NVARCHAR(32), NULL)  COLLATE Latin1_General_CI_AI AS SampleNumber,
         CONVERT(NVARCHAR(MAX), NULL) COLLATE Latin1_General_CI_AI AS Remarks,

         Building3                    COLLATE Latin1_General_CI_AI AS StorageBuilding,
         Collection3                  COLLATE Latin1_General_CI_AI AS StorageCollection,
         Room1                        COLLATE Latin1_General_CI_AI AS StorageRoom,
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS StorageCabinet,
         CONVERT(NVARCHAR(64), NULL)  COLLATE Latin1_General_CI_AI AS StorageShelf,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND (PrepType3 IS NOT NULL)

GO

DROP VIEW dbo.exp_aves_collobjattr_birds

GO

CREATE VIEW dbo.exp_aves_collobjattr_birds
AS
  SELECT CONVERT(NVARCHAR(36),  [guid])     COLLATE Latin1_General_CI_AI AS [key], 
         CONVERT(NVARCHAR(36),  [guid])     COLLATE Latin1_General_CI_AI AS collectionobjectkey,
         CONVERT(NVARCHAR(128), 'ZMB_Aves') COLLATE Latin1_General_CI_AI AS specifycollcode,

         colObjAttributeText8 COLLATE Latin1_General_CI_AI AS Sex,
         colObjAttributeText7 COLLATE Latin1_General_CI_AI AS Age,
         CONVERT(NVARCHAR(50), NULL) COLLATE Latin1_General_CI_AI AS Molt,
         CONVERT(NVARCHAR(50), NULL) COLLATE Latin1_General_CI_AI AS ReproCondition,
         CONVERT(DECIMAL(20,10), NULL) AS Total_length_in_mm,
         CONVERT(DECIMAL(20,10), NULL) AS Wing_length_in_mm,
         CONVERT(DECIMAL(20,10), NULL) AS Tail_length_in_mm,
         CONVERT(DECIMAL(20,10), NULL) AS Bill_length_in_mm,
         CONVERT(DECIMAL(20,10), NULL) AS Tarsus_length_in_mm,
         CONVERT(DECIMAL(20,10), NULL) AS Weight_in_g,
         CONVERT(NVARCHAR(50), NULL) COLLATE Latin1_General_CI_AI AS Stomach,
         CONVERT(NVARCHAR(MAX), NULL) COLLATE Latin1_General_CI_AI AS Remarks,

         TimestampCreated,
         CreatedbyFirstname  COLLATE Latin1_General_CI_AI AS CreatedbyFirstname,
         CreatedByLastname   COLLATE Latin1_General_CI_AI AS CreatedbyLastname,
         TimestampModified,
         ModifiedByFirstname COLLATE Latin1_General_CI_AI AS ModifiedByFirstname,
         ModifiedByLastname  COLLATE Latin1_General_CI_AI AS ModifiedByLastname
    FROM MfN_Zool_Aves.dbo.v_specify T1
   WHERE Visibility IN (SELECT visibilityId
                          FROM dbo.t_specify_publflag)
     AND (colObjAttributeText8 IS NOT NULL OR colObjAttributeText7 IS NOT NULL)

GO


-- todo list begin
--
-- gbif als project
-- determination citations
--
-- todo list end


USE MFN_Zool_Aves

GO

DROP FUNCTION dbo.f_extractDateFromDMYString

GO

CREATE FUNCTION dbo.f_extractDateFromDMYString(@value VARCHAR(128))
  RETURNS VARCHAR(128)
AS
BEGIN
  SET @value = LTRIM(RTRIM(@value))

  IF SUBSTRING(@value, LEN(@value), 1) = '?'
    RETURN dbo.f_extractDateFromDMYString(SUBSTRING(@value, 1, LEN(@value) - 1));

  SET @value = REPLACE(@value, 'Sommer ', '')
  SET @value = REPLACE(@value, 'Winter ', '')
  SET @value = REPLACE(@value, 'Mitte ', '')

  SET @value = REPLACE(@value, 'Januar ', '01.')
  SET @value = REPLACE(@value, 'Jan. ', '01.')
  SET @value = REPLACE(@value, 'Jan ', '01.')

  SET @value = REPLACE(@value, 'Februar ', '02.')
  SET @value = REPLACE(@value, 'Feb. ', '02.')
  SET @value = REPLACE(@value, 'Feb ', '02.')

  SET @value = REPLACE(@value, 'März ', '03.')
  SET @value = REPLACE(@value, 'Mrz. ', '03.')
  SET @value = REPLACE(@value, 'Mrz ', '03.')

  SET @value = REPLACE(@value, 'April ', '04.')
  SET @value = REPLACE(@value, 'Apr. ', '04.')
  SET @value = REPLACE(@value, 'Apr ', '04.')

  SET @value = REPLACE(@value, 'Mai ', '05.')

  SET @value = REPLACE(@value, 'Juni ', '06.')
  SET @value = REPLACE(@value, 'Jun. ', '06.')
  SET @value = REPLACE(@value, 'Jun ', '06.')

  SET @value = REPLACE(@value, 'Juli ', '07.')
  SET @value = REPLACE(@value, 'Jul. ', '07.')
  SET @value = REPLACE(@value, 'Jul ', '07.')

  SET @value = REPLACE(@value, 'August ', '08.')
  SET @value = REPLACE(@value, 'Aug. ', '08.')
  SET @value = REPLACE(@value, 'Aug ', '08.')

  SET @value = REPLACE(@value, 'September ', '09.')
  SET @value = REPLACE(@value, 'Sept. ', '09.')
  SET @value = REPLACE(@value, 'Sep. ', '09.')
  SET @value = REPLACE(@value, 'Sept ', '09.')
  SET @value = REPLACE(@value, 'Sep ', '09.')

  SET @value = REPLACE(@value, 'Oktober ', '10.')
  SET @value = REPLACE(@value, 'Okt. ', '10.')
  SET @value = REPLACE(@value, 'Okt ', '10.')

  SET @value = REPLACE(@value, 'November ', '11.')
  SET @value = REPLACE(@value, 'Nov. ', '11.')
  SET @value = REPLACE(@value, 'Nov ', '11.')

  SET @value = REPLACE(@value, 'Dezember ', '12.')
  SET @value = REPLACE(@value, 'Dez. ', '12.')
  SET @value = REPLACE(@value, 'Dez ', '12.')

  SET @value = REPLACE(@value, 'XII.', '12.')
  SET @value = REPLACE(@value, 'XI.', '11.')
  SET @value = REPLACE(@value, 'IX.', '09.')
  SET @value = REPLACE(@value, 'X.', '10.')
  SET @value = REPLACE(@value, 'IV.', '04.')
  SET @value = REPLACE(@value, 'VIII.', '08.')
  SET @value = REPLACE(@value, 'VII.', '07.')
  SET @value = REPLACE(@value, 'VI.', '06.')
  SET @value = REPLACE(@value, 'V.', '05.')
  SET @value = REPLACE(@value, 'III.', '02.')
  SET @value = REPLACE(@value, 'II.', '02.')
  SET @value = REPLACE(@value, 'I.', '01.')

  SET @value = LTRIM(RTRIM(@value))

  RETURN CASE
           -- year only
           WHEN @value LIKE '[0-9][0-9][0-9][0-9]'
           THEN @value + '-00-00'
           WHEN @value LIKE '00.00.[0-9][0-9][0-9][0-9]'
           THEN SUBSTRING(@value, 7, 4) + '-00-00'
           -- month and year
           WHEN (@value LIKE '[0-9].[0-9][0-9][0-9][0-9]'
             OR  @value LIKE '0[1-9].[0-9][0-9][0-9][0-9]' 
             OR  @value LIKE '[1][0-2].[0-9][0-9][0-9][0-9]')
           THEN SUBSTRING(@value, CHARINDEX('.', @value) + 1, 4) 
              + '-'
              + RIGHT('0' + CAST(CAST(SUBSTRING(@value, 1, CHARINDEX('.', @value) - 1) AS INT) AS VARCHAR(2)), 2)
              + '-00'
           WHEN @value LIKE '00.0[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '00.1[0-2].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '00.0[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '00.1[0-2].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '??.0[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '??.1[0-2].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '??.0[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '??.1[0-2].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '?.0[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '?.1[0-2].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '?.0[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE '?.1[0-2].[0-9][0-9][0-9][0-9]'
           THEN dbo.f_extractDateFromDMYString(SUBSTRING(@value, CHARINDEX('.', @value) + 1, 128))
           WHEN @value LIKE N'[1-3][0-9].[0-1][0-9].[0-9][0-9][0-9][0-9]' 
             OR @value LIKE N'[1-3][0-9].[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE N'[1-9].[0-1][0-9].[0-9][0-9][0-9][0-9]' 
             OR @value LIKE N'[1-9].[1-9].[0-9][0-9][0-9][0-9]'
             OR @value LIKE N'0[1-9].[0-1][0-9].[0-9][0-9][0-9][0-9]' 
             OR @value LIKE N'0[1-9].[1-9].[0-9][0-9][0-9][0-9]'
           THEN LEFT(dbo.f_extractDateFromDMYString(SUBSTRING(@value, CHARINDEX('.', @value) + 1, 128)), 8)
              + RIGHT(N'0' + CAST(CAST(SUBSTRING(@value, 1, CHARINDEX('.', @value) - 1) AS INT) AS VARCHAR(2)), 2)
           ELSE NULL
         END
END

GO

DROP VIEW dbo.v_specify
DROP VIEW dbo.v_specify_publication

GO

CREATE VIEW dbo.v_specify
AS
  WITH duplicates AS
  (
    SELECT INVENTORYYEAR, 
           INVENTORYNO,
           COUNT(*) reccount 
      FROM dbo.TCOLLECTION
     GROUP BY INVENTORYYEAR, INVENTORYNO
    HAVING COUNT(*) > 1
  ), duplicatepartitions AS
  (
    SELECT T2.INVENTORYYEAR, 
           T2.INVENTORYNO,
           ROW_NUMBER() OVER (PARTITION BY T2.INVENTORYYEAR, T2.INVENTORYNO ORDER BY T2.ENTRYID) AS partitionrow,
           T2.ENTRYID,
           T2.TAXONID,
           T2.TYPETAXONID
      FROM duplicates T1
           INNER JOIN dbo.TCOLLECTION T2 ON COALESCE(T1.INVENTORYYEAR, 0) = COALESCE(T2.INVENTORYYEAR, 0)
                                        AND T1.INVENTORYNO = T2.INVENTORYNO
  ), duplicatenumbers AS
  (
    SELECT T2.INVENTORYYEAR, 
           T2.INVENTORYNO,
           T1.entryId As entryId1,
           T2.entryId As entryId2,
           T3.entryId As entryId3,
           T1.TAXONID AS taxon1,
           T2.TAXONID AS taxon2,
           T3.TAXONID AS taxon3,
           T1.TYPETAXONID AS typeTaxon1,
           T2.TYPETAXONID AS typeTaxon2,
           T3.TYPETAXONID AS typeTaxon3,
           CASE
             WHEN T1.TAXONID = T2.TAXONID
              AND T2.TAXONID = COALESCE(T3.TAXONID, T2.TAXONID)
             THEN 1
             ELSE 0
           END AS hasEqualTaxa,
           CASE
             WHEN T1.TYPETAXONID <> T2.TYPETAXONID
              AND T2.TYPETAXONID <> COALESCE(T3.TYPETAXONID, T1.TYPETAXONID)
             THEN 1
             ELSE 0
           END AS hasVariousTypeTaxa
      FROM duplicatepartitions T1
           LEFT JOIN duplicatepartitions T2 ON COALESCE(T1.INVENTORYYEAR, 0) = COALESCE(T2.INVENTORYYEAR, 0)
                                        AND T1.INVENTORYNO  = T2.INVENTORYNO
                                        AND T2.partitionrow = 2
           LEFT JOIN duplicatepartitions T3 ON COALESCE(T1.INVENTORYYEAR, 0) = COALESCE(T3.INVENTORYYEAR, 0)
                                        AND T1.INVENTORYNO  = T3.INVENTORYNO
                                        AND T3.partitionrow = 3
     WHERE T1.partitionrow = 1
  ), collectionobject AS
  (
    SELECT C.[GUID] AS [guid],
           C.ENTRYID AS id,
           C.CREATEDDATE AS TimestampCreated,
           MFN_Specify_Import.dbo.f_mfnaccount_firstname(C.CREATEDUSER) AS CreatedbyFirstname,
           MFN_Specify_Import.dbo.f_mfnaccount_lastname(C.CREATEDUSER) AS CreatedByLastname,
           C.CREATEDDATE AS TimestampModified,
           MFN_Specify_Import.dbo.f_mfnaccount_firstname(C.MODIFIEDUSER) AS ModifiedByFirstname,
           MFN_Specify_Import.dbo.f_mfnaccount_lastname(C.MODIFIEDUSER) AS ModifiedByLastname,
           
           CONVERT(NVARCHAR(32),CASE
                                   WHEN (COALESCE(C.INVENTORYYEAR, N'') <> N'')
                                   THEN CONVERT(NVARCHAR(32), C.INVENTORYYEAR) + N'/' + CONVERT(NVARCHAR(32), C.INVENTORYNO)
                                   ELSE CONVERT(NVARCHAR(32), C.INVENTORYNO)
                                 END) AS CatalogNumber,
           MFN_Specify_Import.dbo.f_mfnaccount_firstname(C.CREATEDUSER) AS CatalogerFirstname,
           MFN_Specify_Import.dbo.f_mfnaccount_lastname(C.CREATEDUSER) AS CatalogerLastname,
           CONVERT(NVARCHAR(10), CONVERT(DATE, C.CREATEDDATE), 126) AS CatalogedDate,
           N'Preserved specimen' AS [description],
          
           CASE C.AVAILABLEID
             WHEN 1 THEN N'missing'
             WHEN 2 THEN N'destroyed'
             WHEN 3 THEN N'exchange'
             ELSE N'available'
           END AS [Availability],
           CONVERT(NVARCHAR(MAX), remarks) AS remarks, 
           CONVERT(NVARCHAR(MAX), publicremarks) AS collectionObjectText3, 
           C.visibilityid AS Visibility,
           CONVERT(INT, 1) AS collectionObjectYesNo1,
           CONVERT(INT, 0) AS collectionObjectYesNo2,

           CONVERT(NVARCHAR(60), CASE
                                   WHEN C.REGDATE  > N''
                                     OR C.EXCOLLID > 0
                                   THEN CASE
                                          WHEN (COALESCE(C.INVENTORYYEAR, N'') <> N'')
                                          THEN N'ZMB_Aves_' + CONVERT(NVARCHAR(32), C.INVENTORYYEAR) + N'/' + CONVERT(NVARCHAR(32), C.INVENTORYNO)
                                          ELSE N'ZMB_Aves_' + CONVERT(NVARCHAR(32), C.INVENTORYNO)
                                        END
                                   ELSE NULL
                                 END) AS AccessionNumber,
           CONVERT(NVARCHAR(10), CASE
                                   WHEN dbo.f_extractDateFromDMYString(C.REGDATE) IS NOT NULL
                                    AND dbo.f_extractDateFromDMYString(C.REGDATE) NOT LIKE N'%-00'
                                    AND ISDATE(dbo.f_extractDateFromDMYString(C.REGDATE)) = 1
                                   THEN dbo.f_extractDateFromDMYString(C.REGDATE)
                                   ELSE NULL
                                 END) AS DateReceived,
           CONVERT(NVARCHAR(50), CASE 
                                   WHEN dbo.f_extractDateFromDMYString(C.REGDATE) IS NULL
                                     OR dbo.f_extractDateFromDMYString(C.REGDATE) LIKE N'%-00'
                                     OR ISDATE(dbo.f_extractDateFromDMYString(C.REGDATE)) <> 1
                                   THEN NULLIF(C.REGDATE, N'')
                                   ELSE NULL 
                                 END) AS AccessionVerbatimDate,
           NULLIF(EC.excollection, N'(nicht angegeben)') AS AccessionText3,

           CONVERT(NVARCHAR(64), BNUMBER) AS otherIdentifier1, 

           CONVERT(NVARCHAR(64), G.CONTINENTOCEAN) AS Continent,
           CONVERT(NVARCHAR(64), G.COUNTRY) AS Country, 
           CONVERT(NVARCHAR(64), G.REGION) AS County, 
           CONVERT(NVARCHAR(255), COALESCE(NULLIF(G.LOCALITY, N''), NULLIF(G.REGION, N''), NULLIF(G.COUNTRY, N''), NULLIF(G.CONTINENTOCEAN, N''))) AS LocalityName, 
          
           CONVERT(NVARCHAR(32), COALESCE(C.latitude,  G.latitude)) AS Latitude1,
           CONVERT(NVARCHAR(32), COALESCE(C.longitude, G.longitude)) AS Longitude1,
           CASE
             WHEN (NULLIF(C.latitude , N'') IS NOT NULL)
               OR (NULLIF(C.longitude, N'') IS NOT NULL)
             THEN CONVERT(NVARCHAR(50), N'Point')
             ELSE NULL
           END AS LatLongType, 

           CONVERT(NVARCHAR(10), CASE 
                                   WHEN ISDATE(dbo.f_extractDateFromDMYString(C.COLLDATE)) = 1
                                   THEN dbo.f_extractDateFromDMYString(C.COLLDATE)
                                   ELSE NULL
                                 END) AS StartDate,
           CONVERT(NVARCHAR(50), CASE 
                                   WHEN dbo.f_extractDateFromDMYString(C.COLLDATE) IS NULL
                                     OR ISDATE(dbo.f_extractDateFromDMYString(C.COLLDATE)) <> 1
                                   THEN C.COLLDATE
                                   ELSE N'' 
                                 END) AS collectingEventVerbatimDate,
           CONVERT(NVARCHAR(32), C.fieldnumber) AS StationFieldNumber,

           CONVERT(NVARCHAR(64), 
           CASE
             WHEN (C.SEXID = 0) THEN N'Unknown'
             WHEN (C.SEXID = 1) THEN N'Male'
             WHEN (C.SEXID = 2) THEN N'Female'
             ELSE S.SEX
           END) AS colObjAttributeText8,
           CONVERT(NVARCHAR(64), 
           CASE
             WHEN (C.INSTARID = 0) THEN NULL
             WHEN (C.INSTARID = 1) THEN N'adult'
             WHEN (C.INSTARID = 2) THEN N'immature'
             WHEN (C.INSTARID = 3) THEN N'juvenile'
             WHEN (C.INSTARID = 4) THEN N'pullus'
             WHEN (C.INSTARID = 5) THEN N'embryo'
             WHEN (C.INSTARID = 6) THEN N'neonat'
             WHEN (C.INSTARID = 7) THEN N'2nd calendar year'
             ELSE I.INSTAR
           END) AS colObjAttributeText7

      FROM dbo.TCOLLECTION              C
           LEFT JOIN dbo.VGEOGRAPHY     G  ON C.LOCALITYID = G.LOCALITYID --AND C.visibilityid NOT IN (1, 2)
           LEFT JOIN dbo.TINSTAR        I  ON C.instarid   = I.instarid
           LEFT JOIN dbo.TSEX           S  ON C.sexid      = S.sexid
           LEFT JOIN dbo.t_excollection EC ON C.EXCOLLID   = EC.excollectionid
  ), collectors AS
  (
    SELECT C.ENTRYID AS id,
           1 AS OrderNumber,
           CONVERT(NVARCHAR(50),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N'&', P.PERSON) > 0)
                         THEN CASE
                                WHEN (CHARINDEX(N',', SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1)) > 0)
                                THEN SUBSTRING(SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1), CHARINDEX(N',', SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1)) + 1, 255)
                                ELSE N''
                              END                     
                         WHEN (CHARINDEX(N',', P.PERSON) > 0)
                         THEN SUBSTRING(P.PERSON, CHARINDEX(N',', P.PERSON) + 1, 255)
                         ELSE N''
                       END))) AS FirstName,
           CONVERT(NVARCHAR(128),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N'&', P.PERSON) > 0)
                         THEN CASE
                                WHEN (CHARINDEX(N',', SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1)) > 0)
                                THEN SUBSTRING(SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1), 1, CHARINDEX(N',', SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1)) - 1)
                                ELSE SUBSTRING(P.PERSON, 1, CHARINDEX(N'&', P.PERSON) - 1)
                              END                     
                         WHEN (CHARINDEX(N',', P.PERSON) > 0)
                         THEN SUBSTRING(P.PERSON, 1, CHARINDEX(N',', P.PERSON) - 1)
                         ELSE P.PERSON
                       END))) AS LastName
      FROM dbo.TCOLLECTION C
           INNER JOIN dbo.TPERSON P ON C.COLLECTORID = P.PERSONID
     WHERE P.PERSON > N''
    UNION
    SELECT C.ENTRYID AS id,
           2 AS OrderNumber,
           CONVERT(NVARCHAR(50),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N',', SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255)) > 0)
                         THEN SUBSTRING(SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255), CHARINDEX(N',', SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255)) + 1, 255)
                         ELSE N''
                       END))) AS FirstName,
           CONVERT(NVARCHAR(128),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N',', SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255)) > 0)
                         THEN SUBSTRING(SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255), 1, CHARINDEX(N',', SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255)) - 1)
                         ELSE SUBSTRING(P.PERSON, CHARINDEX(N'&', P.PERSON) + 1, 255)
                       END))) AS LastName
      FROM dbo.TCOLLECTION C
           INNER JOIN dbo.TPERSON P ON C.COLLECTORID = P.PERSONID
     WHERE P.PERSON > N''
       AND P.PERSON LIKE N'%&%'
  ), determinations AS 
  (
    SELECT C.ENTRYID AS id,
           1 AS OrderNumber,
           CONVERT(NVARCHAR(64), NULLIF(T.FAMILY,  N'indet.')) AS Family,
           CONVERT(NVARCHAR(64), NULLIF(T.GENUS,   N'Gen.')) AS Genus,
           CONVERT(NVARCHAR(64), NULLIF(T.SPECIES, N'spec.')) AS Species,
           CONVERT(NVARCHAR(64), T.SUBSPECIES) Subspecies,

           CONVERT(NVARCHAR(50), NULL) AS TypeStatusName,

           CONVERT(NVARCHAR(50),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N'&', P.PERSON) > 0)
                         THEN N''
                         WHEN (CHARINDEX(N',', P.PERSON) > 0)
                         THEN SUBSTRING(P.PERSON, CHARINDEX(N',', P.PERSON) + 1, 255)
                         ELSE N''
                       END))) AS DeterminerFirstName,
           CONVERT(NVARCHAR(128),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N'&', P.PERSON) > 0)
                         THEN P.PERSON                
                         WHEN (CHARINDEX(N',', P.PERSON) > 0)
                         THEN SUBSTRING(P.PERSON, 1, CHARINDEX(N',', P.PERSON) - 1)
                         ELSE P.PERSON
                       END))) AS DeterminerLastName
      FROM dbo.TCOLLECTION C
           INNER JOIN dbo.VTAXON  T ON C.TAXONID        = T.TAXONID
           LEFT JOIN  dbo.TPERSON P ON C.DETERMINATORID = P.PERSONID
    UNION
    SELECT C.ENTRYID AS id,
           2 AS OrderNumber,
           CONVERT(NVARCHAR(64), NULLIF(T.FAMILY,  N'indet.')) AS Family,
           CONVERT(NVARCHAR(64), NULLIF(T.GENUS,   N'Gen.')) AS Genus,
           CONVERT(NVARCHAR(64), NULLIF(T.SPECIES, N'spec.')) AS Species,
           CONVERT(NVARCHAR(64), T.SUBSPECIES) Subspecies,

           CONVERT(NVARCHAR(50),CASE C.TYPESTATEID
                                  WHEN 1 THEN N'Holotype'
                                  WHEN 2 THEN N'Paratype'
                                  WHEN 3 THEN N'Lectotype'
                                  WHEN 4 THEN N'Paralectotype'
                                  WHEN 5 THEN N'Neotype'
                                  WHEN 6 THEN N'Syntype'
                                  ELSE NULL
                                END) TypeStatusName,

           CONVERT(NVARCHAR(50),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N'&', P.PERSON) > 0)
                         THEN N''
                         WHEN (CHARINDEX(N',', P.PERSON) > 0)
                         THEN SUBSTRING(P.PERSON, CHARINDEX(N',', P.PERSON) + 1, 255)
                         ELSE N''
                       END))) AS DeterminerFirstName,
           CONVERT(NVARCHAR(128),
           LTRIM(RTRIM(CASE
                         WHEN (CHARINDEX(N'&', P.PERSON) > 0)
                         THEN P.PERSON                
                         WHEN (CHARINDEX(N',', P.PERSON) > 0)
                         THEN SUBSTRING(P.PERSON, 1, CHARINDEX(N',', P.PERSON) - 1)
                         ELSE P.PERSON
                       END))) AS DeterminerLastName
      FROM dbo.TCOLLECTION C
           INNER JOIN dbo.VTAXON  T ON C.TYPETAXONID        = T.TAXONID
           LEFT JOIN  dbo.TPERSON P ON C.TYPEDETERMINATORID = P.PERSONID
     WHERE T.TAXONID > 0
  ), preparations AS
  (
    SELECT C.ENTRYID AS id,
           1 AS OrderNumber,
           CONVERT(INT, 1) AS [Count],
           CASE
             WHEN (C.COLLCODEID =  0) THEN 'n/a'
             WHEN (C.COLLCODEID =  1) THEN 'Alcohol'
             WHEN (C.COLLCODEID =  2) THEN 'Parts in alcohol'
             WHEN (C.COLLCODEID =  3) THEN 'Egg in alcohol'
             WHEN (C.COLLCODEID =  4) THEN 'Slide'
             WHEN (C.COLLCODEID =  5) THEN 'Egg'
             WHEN (C.COLLCODEID =  6) THEN 'Nest'
             WHEN (C.COLLCODEID =  7) THEN 'Skeleton'
             WHEN (C.COLLCODEID =  8) THEN 'Skull'
             WHEN (C.COLLCODEID =  9) THEN 'Skin'
             WHEN (C.COLLCODEID = 10) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 14) THEN 'Mounted'
             WHEN (C.COLLCODEID = 15) THEN 'Mounted skeleton'
             WHEN (C.COLLCODEID = 20) THEN 'Wing'
             WHEN (C.COLLCODEID = 22) THEN 'Feather'

             WHEN (C.COLLCODEID = 11) THEN 'Skin'
             WHEN (C.COLLCODEID = 12) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 13) THEN 'Skin'
             WHEN (C.COLLCODEID = 18) THEN 'Mounted'
             WHEN (C.COLLCODEID = 19) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 21) THEN 'Wing'
             WHEN (C.COLLCODEID = 24) THEN 'Skin'
             WHEN (C.COLLCODEID = 29) THEN 'Skin'
             ELSE N'######## ' + CC.COLLCODE + N' ' + CONVERT(NVARCHAR(16), C.COLLCODEID)
           END AS PrepType,

           CONVERT(NVARCHAR(64), N'MfN Hauptgebäude') COLLATE Latin1_General_CI_AI AS StorageBuilding,
           CONVERT(NVARCHAR(64), N'Vogelsammlung') COLLATE Latin1_General_CI_AI AS StorageCollection,
           CONVERT(NVARCHAR(64), S.storage) COLLATE Latin1_General_CI_AI AS StorageRoom
      FROM dbo.TCOLLECTION          C
           INNER JOIN dbo.TCOLLCODE CC ON (C.COLLCODEID = CC.COLLCODEID)
           LEFT JOIN dbo.t_storage  S  ON C.storageid = S.storageid AND S.storageid > 0
    UNION
    SELECT C.ENTRYID AS id,
           2 AS OrderNumber,

           CONVERT(INT, 1) AS [Count],
           CASE
             WHEN (C.COLLCODEID = 11) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 12) THEN 'Skull'
             WHEN (C.COLLCODEID = 13) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 18) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 19) THEN 'Alcohol'
             WHEN (C.COLLCODEID = 21) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 24) THEN 'Skeleton parts'
             WHEN (C.COLLCODEID = 29) THEN 'Parts in alcohol'
             ELSE NULL
           END AS PrepType,

           CONVERT(NVARCHAR(64), N'MfN Hauptgebäude') COLLATE Latin1_General_CI_AI AS StorageBuilding,
           CONVERT(NVARCHAR(64), N'Vogelsammlung') COLLATE Latin1_General_CI_AI AS StorageCollection,
           CONVERT(NVARCHAR(64), S.storage) COLLATE Latin1_General_CI_AI AS StorageRoom
      FROM dbo.TCOLLECTION          C
           INNER JOIN dbo.TCOLLCODE CC ON (C.COLLCODEID = CC.COLLCODEID)
           LEFT JOIN dbo.t_storage  S  ON C.storageid = S.storageid AND S.storageid > 0
     WHERE C.COLLCODEID   IN (11,12,13,18,19,21,24,29)
    UNION
    SELECT C.ENTRYID AS id,
           3 AS OrderNumber,

           CONVERT(INT, 1) AS [Count],
           CASE
             WHEN (C.COLLCODEID = 24) THEN 'Tissue sample'
             ELSE NULL
           END COLLATE Latin1_General_CI_AI AS PrepType,

           CONVERT(NVARCHAR(64), N'MfN Hauptgebäude') COLLATE Latin1_General_CI_AI AS StorageBuilding,
           CONVERT(NVARCHAR(64), N'Vogelsammlung') COLLATE Latin1_General_CI_AI AS StorageCollection,
           CONVERT(NVARCHAR(64), S.storage) COLLATE Latin1_General_CI_AI AS StorageRoom
      FROM dbo.TCOLLECTION          C
           INNER JOIN dbo.TCOLLCODE CC ON (C.COLLCODEID = CC.COLLCODEID)
           LEFT JOIN dbo.t_storage  S  ON C.storageid = S.storageid AND S.storageid > 0
     WHERE C.COLLCODEID   IN (24)
  )
  SELECT TOP 100 PERCENT
         CO.*,
         C1.FirstName AS CollectorFirstName1 ,
         C1.LastName AS CollectorLastName1, 
         C2.FirstName AS CollectorFirstName2,
         C2.LastName AS CollectorLastName2,
         D1.Family AS Family1,
         D1.Genus AS Genus1,
         D1.Species AS Species1,
         D1.Subspecies AS Subspecies1,
         D1.TypeStatusName AS TypestatusName1,
         D1.DeterminerFirstName AS DeterminerFirstName1,
         CASE
           WHEN D2.id IS NOT NULL
           THEN COALESCE(NULLIF(D1.DeterminerLastName, N''), N'-')
           ELSE NULLIF(D1.DeterminerLastName, N'')
         END AS DeterminerLastName1,
         CASE
           WHEN D1.id IS NOT NULL
           THEN 1
           ELSE NULL
         END AS isCurrent1,
         D2.Family AS Family2,
         D2.Genus AS Genus2,
         D2.Species AS Species2,
         D2.Subspecies AS Subspecies2,
         D2.TypeStatusName AS TypestatusName2,
         D2.DeterminerFirstName AS DeterminerFirstName2,
         D2.DeterminerLastName AS DeterminerLastName2,
         CASE
           WHEN D2.id IS NOT NULL
           THEN 0 
           ELSE NULL
         END AS isCurrent2,
         D3.Family AS Family3,
         D3.Genus AS Genus3,
         D3.Species AS Species3,
         D3.Subspecies AS Subspecies3,
         D3.TypeStatusName AS TypestatusName3,
         D3.DeterminerFirstName AS DeterminerFirstName3,
         D3.DeterminerLastName AS DeterminerLastName3,
         CASE
           WHEN D3.id IS NOT NULL
           THEN 0 
           ELSE NULL
         END AS isCurrent3,
         D4.Family AS Family4,
         D4.Genus AS Genus4,
         D4.Species AS Species4,
         D4.Subspecies AS Subspecies4,
         D4.TypeStatusName AS TypestatusName4,
         D4.DeterminerFirstName AS DeterminerFirstName4,
         D4.DeterminerLastName AS DeterminerLastName4,
         CASE
           WHEN D4.id IS NOT NULL
           THEN 0 
           ELSE NULL
         END AS isCurrent4,
         P1.[Count] AS Count1,
         P1.PrepType AS PrepType1,
         P1.StorageBuilding AS Building1,
         P1.StorageCollection AS Collection1,
         P1.StorageRoom AS Room1,
         P2.[Count] AS Count2,
         P2.PrepType AS PrepType2,
         P2.StorageBuilding AS Building2,
         P2.StorageCollection AS Collection2,
         P2.StorageRoom AS Room2,
         P3.[Count] AS Count3,
         P3.PrepType AS PrepType3,
         P3.StorageBuilding AS Building3,
         P3.StorageCollection AS Collection3,
         P3.StorageRoom AS Room3
    FROM collectionobject         CO
         LEFT JOIN collectors     C1 ON CO.id = C1.id AND C1.OrderNumber = 1
         LEFT JOIN collectors     C2 ON CO.id = C2.id AND C2.OrderNumber = 2
         LEFT JOIN determinations D1 ON CO.id = D1.id AND D1.OrderNumber = 1
         LEFT JOIN determinations D2 ON CO.id = D2.id AND D2.OrderNumber = 2
         LEFT JOIN determinations D3 ON CO.id = D3.id AND D3.OrderNumber = 0
         LEFT JOIN determinations D4 ON CO.id = D4.id AND D4.OrderNumber = 0
         LEFT JOIN preparations   P1 ON CO.id = P1.id AND P1.OrderNumber = 1
         LEFT JOIN preparations   P2 ON CO.id = P2.id AND P2.OrderNumber = 2
         LEFT JOIN preparations   P3 ON CO.id = P3.id AND P3.OrderNumber = 3
   WHERE CO.id NOT IN (SELECT ENTRYID
                         FROM duplicatepartitions)
  UNION ALL
  SELECT TOP 100 PERCENT
         CO.*,
         C1.FirstName AS CollectorFirstName1 ,
         C1.LastName AS CollectorLastName1, 
         C2.FirstName AS CollectorFirstName2,
         C2.LastName AS CollectorLastName2,
         D1.Family AS Family1,
         D1.Genus AS Genus1,
         D1.Species AS Species1,
         D1.Subspecies AS Subspecies1,
         D1.TypeStatusName AS TypestatusName1,
         D1.DeterminerFirstName AS DeterminerFirstName1,
         CASE
           WHEN D2.id IS NOT NULL
           THEN COALESCE(NULLIF(D1.DeterminerLastName, N''), N'-')
           ELSE NULLIF(D1.DeterminerLastName, N'')
         END AS DeterminerLastName1,
         CASE
           WHEN D1.id IS NOT NULL
           THEN 1
           ELSE NULL
         END AS isCurrent1,
         D2.Family AS Family2,
         D2.Genus AS Genus2,
         D2.Species AS Species2,
         D2.Subspecies AS Subspecies2,
         D2.TypeStatusName AS TypestatusName2,
         D2.DeterminerFirstName AS DeterminerFirstName2,
         D2.DeterminerLastName AS DeterminerLastName2,
         CASE
           WHEN D2.id IS NOT NULL
           THEN 0 
           ELSE NULL
         END AS isCurrent2,
         D3.Family AS Family3,
         D3.Genus AS Genus3,
         D3.Species AS Species3,
         D3.Subspecies AS Subspecies3,
         D3.TypeStatusName AS TypestatusName3,
         D3.DeterminerFirstName AS DeterminerFirstName3,
         D3.DeterminerLastName AS DeterminerLastName3,
         CASE
           WHEN D3.id IS NOT NULL
           THEN 0 
           ELSE NULL
         END AS isCurrent3,
         D4.Family AS Family4,
         D4.Genus AS Genus4,
         D4.Species AS Species4,
         D4.Subspecies AS Subspecies4,
         D4.TypeStatusName AS TypestatusName4,
         D4.DeterminerFirstName AS DeterminerFirstName4,
         D4.DeterminerLastName AS DeterminerLastName4,
         CASE
           WHEN D4.id IS NOT NULL
           THEN 0 
           ELSE NULL
         END AS isCurrent4,
         P1.[Count] AS Count1,
         P1.PrepType AS PrepType1,
         P1.StorageBuilding AS Building1,
         P1.StorageCollection AS Collection1,
         P1.StorageRoom AS Room1,
         P2.[Count] AS Count2,
         P2.PrepType AS PrepType2,
         P2.StorageBuilding AS Building2,
         P2.StorageCollection AS Collection2,
         P2.StorageRoom AS Room2,
         P3.[Count] AS Count3,
         P3.PrepType AS PrepType3,
         P3.StorageBuilding AS Building3,
         P3.StorageCollection AS Collection3,
         P3.StorageRoom AS Room3
    FROM collectionobject            CO
         INNER JOIN duplicatenumbers DN ON CO.id =  DN.entryId1
          LEFT JOIN collectors       C1 ON CO.id = C1.id AND C1.OrderNumber = 1
          LEFT JOIN collectors       C2 ON CO.id = C2.id AND C2.OrderNumber = 2
          LEFT JOIN determinations   D1 ON CO.id = D1.id AND D1.OrderNumber = 1
          LEFT JOIN determinations   D2 ON CO.id = D2.id AND D2.OrderNumber = 2
          LEFT JOIN determinations   D3 ON DN.entryId2 = D3.id AND D3.OrderNumber = 2
          LEFT JOIN determinations   D4 ON DN.entryId3 = D4.id AND D4.OrderNumber = 2
          LEFT JOIN preparations     P1 ON CO.id = P1.id AND P1.OrderNumber = 1
          LEFT JOIN preparations     P2 ON CO.id = P2.id AND P2.OrderNumber = 2
          LEFT JOIN preparations     P3 ON CO.id = P3.id AND P3.OrderNumber = 3
   WHERE DN.hasEqualTaxa       <> 0
     AND DN.hasVariousTypeTaxa <> 0
   ORDER BY CO.CatalogNumber

GO

CREATE VIEW dbo.v_specify_publication
AS
  SELECT *
    FROM dbo.v_specify
   WHERE Visibility = 0

GO

SELECT TOP 100 *
  FROM dbo.v_specify_publication
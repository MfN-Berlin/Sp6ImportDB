-- Accession

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_accession')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_accession')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_accession

-- AccessionAgent

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_accessionagent')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_accessionagent')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_accessionagent

-- CollectionObject

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_collectionobject

-- OtherIdentifier

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_otheridentifier')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_otheridentifier')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_otheridentifier

-- Collectors

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_collector')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_collector')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_collector

-- Determination

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_determination')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_determination')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_determination

-- Preparation

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_preparation')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_preparation')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_preparation

-- CollectionObjectAttribute

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_collobjattr_mammals')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_mammalia_collobjattr_mammals')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_mammalia_collobjattr_mammals

GO

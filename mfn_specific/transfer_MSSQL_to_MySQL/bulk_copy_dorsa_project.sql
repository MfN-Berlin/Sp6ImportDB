-- Accession

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_accession')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_accession')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_accession

-- AccessionAgent

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_accessionagent')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_accessionagent')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_accessionagent

-- CollectionObject

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_collectionobject
        
-- Collectors

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_collector')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_collector')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_collector

-- Determination

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_determination')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_determination')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_determination

GO

-- Preparation

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_preparation')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_preparation')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_preparation

GO

-- PreparationAttribute

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_preparationattribute')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_dorsa_preparationattribute')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_dorsa_preparationattribute

GO

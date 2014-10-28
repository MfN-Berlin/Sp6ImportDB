-- CollectionObject

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_aves_collectionobject
        
-- OtherIdentifier

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_otheridentifier')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_otheridentifier')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_aves_otheridentifier

-- Collectors

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_collector')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_collector')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_aves_collector

-- Determination

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_determination')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_determination')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_aves_determination

-- Preparation

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_preparation')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_preparation')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_aves_preparation

-- CollectionObjectAttribute for Birds

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_collobjattr_birds')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_aves_collobjattr_birds')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_aves_collobjattr_birds

GO

-- CollectionObject

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_embryo_collectionobject
        
-- OtherIdentifier

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_otheridentifier')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_otheridentifier')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_embryo_otheridentifier

-- Determination

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_determination')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_determination')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_embryo_determination

-- Preparation

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_preparation')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_preparation')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_embryo_preparation

-- Preparation Attributes

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_preparationattribute')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_embryo_preparationattribute')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_embryo_preparationattribute

GO
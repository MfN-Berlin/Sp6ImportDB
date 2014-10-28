-- CollectionObject

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_phasm_collectionobject


-- Collector

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_collector')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_collector')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_phasm_collector


-- Determination

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_determination')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_determination')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_phasm_determination


-- Preparation

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_preparation')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_preparation')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_phasm_preparation


-- CollectionObjectAttribute

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_collobjattr_phasmatodea')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_collobjattr_phasmatodea')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_phasm_collobjattr_phasmatodea
  
GO

-- Container Relations

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_containerrel')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_phasm_containerrel')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_phasm_containerrel
  
GO

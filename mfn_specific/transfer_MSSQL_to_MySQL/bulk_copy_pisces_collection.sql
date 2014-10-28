-- CollectionObject

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_pisces_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_pisces_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_pisces_collectionobject
  
GO
      
-- Determination

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_pisces_determination')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_pisces_determination')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_pisces_determination

GO

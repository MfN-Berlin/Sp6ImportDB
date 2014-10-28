-- Container Drawings

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergdrawings_container')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergdrawings_container')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_ehrenbergdrawings_container

-- CollectionObject Drawings

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergdrawings_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergdrawings_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_ehrenbergdrawings_collectionobject

-- CollectionObjectAttributes Drawings

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergdrawings_collectionobjectattribute')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergdrawings_collectionobjectattribute')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_ehrenbergdrawings_collectionobjectattribute

-- Container Samples

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergsamples_container')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergsamples_container')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_ehrenbergsamples_container

-- CollectionObject Samples

DELETE openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergsamples_collectionobject')
  
INSERT openquery([MYSQL_MFN-SQL-1],N'SELECT * FROM specify_import.exp_ehrenbergsamples_collectionobject')
       SELECT *
         FROM MFN_Specify_Import.dbo.exp_ehrenbergsamples_collectionobject

GO

# Import taxonomy into the Specify MySQL database

* First of all: Make sure to create a backup of your Specify database !! 

* create a database e.g. ```specify_import``` on the MySQL server that hosts your Specify data scheme
* import the SQL file ```mysql__import_catalogue_of_life_in_an_empty_collection.sql``` with your favourite MySQL client software
* fill the table ```t_coltaxonimport``` with the taxonomic data you want to import
* call the main function ```p_insertCOLTaxonomy``` with the collection code of your target collection   (e.g. ```CALL p_insertCOLTaxonomy('ZMB_Orth');```)
* open Specify 6 or 7 and choose the menu item ```System >> tree >> Update taxonomy tree``` in order to rebuild the tree based on the imported data
* if you imported lot's of taxon names, this might last some time ....

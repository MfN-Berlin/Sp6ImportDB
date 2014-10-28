USE `specify_import`;


-- run import

CALL `p_Import`;


-- show errors

SELECT *
  FROM `t_imp_accession`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_accessionagent`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_collectionobject`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_otheridentifier`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_referencework`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_geography`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_collector`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_determination`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_preparation`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_preparationattribute`
 WHERE (`_error` <> 0);
 
SELECT *
  FROM `t_imp_storage`
 WHERE (`_error` <> 0);

SELECT *
  FROM `t_imp_collectionobjectattribute`
 WHERE (`_error` <> 0);
 

-- show steps

SELECT *
  FROM `tmp_steps`;

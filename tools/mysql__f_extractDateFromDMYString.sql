DROP FUNCTION IF EXISTS `f_extractDateFromDMYString`;

DELIMITER GO


CREATE FUNCTION `f_extractDateFromDMYString`($value VARCHAR(128))
  RETURNS VARCHAR(128)
  DETERMINISTIC
BEGIN
  SET $value = REPLACE($value, 'Sommer ', '');
  SET $value = REPLACE($value, 'Winter ', '');
  SET $value = REPLACE($value, 'Mitte ', '');

  SET $value = REPLACE($value, 'Januar ', '01.');
  SET $value = REPLACE($value, 'Jan. ', '01.');
  SET $value = REPLACE($value, 'Jan ', '01.');

  SET $value = REPLACE($value, 'Februar ', '02.');
  SET $value = REPLACE($value, 'Feb. ', '02.');
  SET $value = REPLACE($value, 'Feb ', '02.');

  SET $value = REPLACE($value, 'März ', '03.');
  SET $value = REPLACE($value, 'Mrz. ', '03.');
  SET $value = REPLACE($value, 'Mrz ', '03.');

  SET $value = REPLACE($value, 'April ', '04.');
  SET $value = REPLACE($value, 'Apr. ', '04.');
  SET $value = REPLACE($value, 'Apr ', '04.');

  SET $value = REPLACE($value, 'Mai ', '05.');

  SET $value = REPLACE($value, 'Juni ', '06.');
  SET $value = REPLACE($value, 'Jun. ', '06.');
  SET $value = REPLACE($value, 'Jun ', '06.');

  SET $value = REPLACE($value, 'Juli ', '07.');
  SET $value = REPLACE($value, 'Jul. ', '07.');
  SET $value = REPLACE($value, 'Jul ', '07.');

  SET $value = REPLACE($value, 'August ', '08.');
  SET $value = REPLACE($value, 'Aug. ', '08.');
  SET $value = REPLACE($value, 'Aug ', '08.');

  SET $value = REPLACE($value, 'September ', '09.');
  SET $value = REPLACE($value, 'Sept. ', '09.');
  SET $value = REPLACE($value, 'Sep. ', '09.');
  SET $value = REPLACE($value, 'Sept ', '09.');
  SET $value = REPLACE($value, 'Sep ', '09.');

  SET $value = REPLACE($value, 'Oktober ', '10.');
  SET $value = REPLACE($value, 'Okt. ', '10.');
  SET $value = REPLACE($value, 'Okt ', '10.');

  SET $value = REPLACE($value, 'November ', '11.');
  SET $value = REPLACE($value, 'Nov. ', '11.');
  SET $value = REPLACE($value, 'Nov ', '11.');

  SET $value = REPLACE($value, 'Dezember ', '12.');
  SET $value = REPLACE($value, 'Dez. ', '12.');
  SET $value = REPLACE($value, 'Dez ', '12.');

  SET $value = REPLACE($value, 'XII.', '12.');
  SET $value = REPLACE($value, 'XI.', '11.');
  SET $value = REPLACE($value, 'IX.', '09.');
  SET $value = REPLACE($value, 'X.', '10.');
  SET $value = REPLACE($value, 'IV.', '04.');
  SET $value = REPLACE($value, 'VIII.', '08.');
  SET $value = REPLACE($value, 'VII.', '07.');
  SET $value = REPLACE($value, 'VI.', '06.');
  SET $value = REPLACE($value, 'V.', '05.');
  SET $value = REPLACE($value, 'III.', '02.');
  SET $value = REPLACE($value, 'II.', '02.');
  SET $value = REPLACE($value, 'I.', '01.');

  SET $value = LTRIM(RTRIM($value));

  IF SUBSTRING($value, LENGTH($value), 1) = '?' Then
    SET $value = RTRIM(SUBSTRING($value, 1, LENGTH($value) - 1));
  END IF;

  IF $value REGEXP '^00.0[1-9].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^00.1[0-2].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^00.0[1-9].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^00.1[0-2].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]][[.?.]].0[1-9].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]][[.?.]].1[0-2].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]][[.?.]].0[1-9].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]][[.?.]].1[0-2].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]].0[1-9].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]].1[0-2].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]].0[1-9].[0-9][0-9][0-9][0-9]$'
  OR $value REGEXP '^[[.?.]].1[0-2].[0-9][0-9][0-9][0-9]$' THEN 
    SET $value = SUBSTRING($value, LOCATE('.', $value) + 1, 128);
  END IF;

  RETURN CASE
           -- year only
           WHEN $value REGEXP '^[0-9][0-9][0-9][0-9]$'
           THEN CONCAT($value, '-00-00')
           WHEN $value REGEXP '^00.00.[0-9][0-9][0-9][0-9]$'
           THEN CONCAT(SUBSTRING($value, 7, 4), '-00-00')
           -- month and year
           WHEN ($value REGEXP '^[0-9].[0-9][0-9][0-9][0-9]$'
             OR  $value REGEXP '^0[1-9].[0-9][0-9][0-9][0-9]$'
             OR  $value REGEXP '^[1][0-2].[0-9][0-9][0-9][0-9]$')
           THEN CONCAT(SUBSTRING($value, LOCATE('.', $value) + 1, 4)
              , '-'
              , RIGHT(CONCAT('0', SUBSTRING($value, 1, LOCATE('.', $value) - 1)), 2)
              , '-00')
		   -- complete date
           WHEN $value REGEXP '^[1-3][0-9].[0-1][0-9].[0-9][0-9][0-9][0-9]$'
             OR $value REGEXP '^[1-3][0-9].[1-9].[0-9][0-9][0-9][0-9]$'
             OR $value REGEXP '^[1-9].[0-1][0-9].[0-9][0-9][0-9][0-9]$'
             OR $value REGEXP '^[1-9].[1-9].[0-9][0-9][0-9][0-9]$'
             OR $value REGEXP '^0[1-9].[0-1][0-9].[0-9][0-9][0-9][0-9]$'
             OR $value REGEXP '^0[1-9].[1-9].[0-9][0-9][0-9][0-9]$'
           THEN CONCAT(SUBSTRING($value, LOCATE('.', $value, 4) + 1, 4)
					 , '-'
                     , RIGHT(CONCAT('0', SUBSTRING($value, LOCATE('.', $value) + 1, LOCATE('.', $value, 4) - LOCATE('.', $value) - 1)), 2)
					 , '-'
                     , RIGHT(CONCAT('0', SUBSTRING($value, 1, LOCATE('.', $value) - 1)), 2))
           ELSE NULL
         END;
END;

GO

DELIMITER ;

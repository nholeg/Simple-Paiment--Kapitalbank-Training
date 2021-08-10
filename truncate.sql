TRUNCATE TABLE operation_journal;
UPDATE paiments SET is_finished = 'N';


SELECT COUNT(*)  FROM operation_journal
UNION ALL
SELECT COUNT(*)  FROM paiments WHERE is_finished = 'Y'

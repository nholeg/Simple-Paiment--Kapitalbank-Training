SELECT COUNT(*)  FROM operation_journal
UNION ALL
SELECT COUNT(*)  FROM paiments WHERE IS_finished ='N'

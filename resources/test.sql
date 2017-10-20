set echo off
SET HEAD OFF
set linesize 1000
set pagesize 0
set trimspool on
set feedback off
set colsep ''
spool out.json
SELECT '{' FROM DUAL;
SELECT '"' || hd.TABLE_NAME || '":' ||'["' ||  LISTAGG(COLUMN_NAME, '","') WITHIN GROUP (ORDER BY POSITION)  || '"]' || CASE WHEN LEAD(hd.TABLE_NAME) OVER (ORDER BY hd.TABLE_NAME) IS NOT NULL THEN ',' END FROM USER_CONS_COLUMNS dtl
INNER JOIN USER_CONSTRAINTS HD
ON hd.CONSTRAINT_NAME = dtl.CONSTRAINT_NAME
AND hd.CONSTRAINT_TYPE='P'
WHERE dtl.TABLE_NAME IN (tableName)
GROUP BY hd.TABLE_NAME
ORDER BY hd.TABLE_NAME;
SELECT '}' FROM DUAL;
spool off;
exit;

hive -e "CREATE EXTERNAL TABLE IF NOT EXISTS PROD.PATIENTINFO(
PAITIENTID bigint,
PAITIENTFULLNAME STRING,
CONTACT STRING,
UID BIGINT,
ADDRESS STRING,
CREATIONDATE TIMESTAMP,
UPDATEDATE TIMESTAMP,
SOURCEQUERYTIME TIMESTAMP
);"

hive -e "insert into table prod.patientInfo
select 
P.PID as paitientId,
CONCAT(P.F_NAME,'_',P.L_NAME) as patientFullName,
P.PHONE as contact,
P.AADHAR as uid,
CONCAT(A.AREA,'_',C.CT_NAME,'-',A.PIN) as address,
P.SYS_CRE_DATE as creationDate,
P.SYS_UPD_DATE as updateDate,
FROM_UNIXTIME( UNIX_TIMESTAMP()) as sourceQueryTime
FROM
PROD.PATIENT_HVE P LEFT OUTER JOIN
PROD.ADDRESS_HVE A ON
P.P_ADD=A.P_ADD
LEFT OUTER JOIN PROD.CITY_HVE C
ON 
A.CT_ID=C.CT_ID;"
-- renaming ofiice to office id ,sorting by office_id 

with offs as (
SELECT OFFICE as OFFICE_ID,
SALESOFFICE FROM PC_FIVETRAN_DB.SQL_SERVER_DBO.OFFICES
where _FIVETRAN_DELETED= 'FALSE' 
ORDER BY OFFICE_ID
)

select * from offs
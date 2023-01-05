with test as (
    select * from PC_FIVETRAN_DB.DBO_DBO.NEW 
    union all 
    select * from PC_FIVETRAN_DB.DBO_DBO.department
)

select * from test
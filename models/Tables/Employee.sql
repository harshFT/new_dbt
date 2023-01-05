{{ config(materialized='table') }}


-- rename the office to office id and genrate total working days of employee 

with emp as (
select 
EmployeeID,
Extension,
EmployeeName,
EmployeeGender,
HIRE_DATE,
datediff(day,HIRE_DATE,CURRENT_DATE()) as "WORKING DAYS",
Office as OFFICE_ID,
Supervisor,
JobTitle,
AnnualSalary,
Sales_Target
from PC_FIVETRAN_DB.SQL_SERVER_DBO.employees
where _FIVETRAN_DELETED= 'FALSE' 
)

select * from emp

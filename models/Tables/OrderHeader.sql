
{{ config(materialized='table') }}

-- select order header table as it is 

with cte as (
SELECT OrderDate
      ,CustomerID
      ,EmployeeID
      ,ShippingCost
      ,OrderID
      ,ShippingCompany
  FROM PC_FIVETRAN_DB.SQL_SERVER_DBO.ORDERHEADER
  where _FIVETRAN_DELETED= 'FALSE' 
  ) ,

-- get avg per shipping company for data aggregation 

 cte1 as (
    select ShippingCompany,
    AVG (ShippingCost) as "avg shipping cost of shipping company"
    from PC_FIVETRAN_DB.SQL_SERVER_DBO.ORDERHEADER
    group by ShippingCompany
  ),

-- join both common table expresions for combine result with avarage cost of shipping company 

 cte2 as (
    select a.*,b."avg shipping cost of shipping company"
    from cte as a left join cte1 as b 
    on a.ShippingCompany=b.ShippingCompany 
  ) 

-- called last combine result

 select * from cte2
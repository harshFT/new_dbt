{{ config(materialized='table') }}

--select all useful col in expression 
with cust as (
select
    CustomerID,
    Customer,
    ContactName,
    Address,
    City,	
    Country	,
    Region,
    Fax	,
    Phone,	
    PostalCode,	
    CountryCode	,
    Latitude,	
    Longitude 
from PC_FIVETRAN_DB.SQL_SERVER_DBO.CUSTOMERS
where _FIVETRAN_DELETED= 'FALSE' 
),

-- getting count of customers count
 cust1 as (
select region,count(CustomerID) as "REGION WISE CUSTOMER COUNT"
from PC_FIVETRAN_DB.SQL_SERVER_DBO.CUSTOMERS
group by region
 ),
/*
-- join the two expresion for combine result 
 cust2 as ( 
    select a.*,b."COUNTRY WISE CUSTOMER COUNT"
    from cust as a left join cust1 as b
    on a.region=b.region
 ),
*/
-- the count of products in orders places by customers 

cmr as (
    select c.customerid,count(od.productid) as "CUSTOMER WISE PRODUCT COUNT"
from  PC_FIVETRAN_DB.SQL_SERVER_DBO.CUSTOMERS as C
inner join PC_FIVETRAN_DB.SQL_SERVER_DBO.ORDERHEADER as OH
on c.CUSTOMERID=oH.customerid
inner join PC_FIVETRAN_DB.SQL_SERVER_DBO.ORDERDETAILS as OD
on OH.orderid=OD.ORDERID
group by c.customerid,c.customer
order by customerid
),

-- join the three expresion for combine result 
 cust2 as ( 
    select a.*,b."REGION WISE CUSTOMER COUNT",C."CUSTOMER WISE PRODUCT COUNT"
    from cust as a left join cust1 as b
    on a.region=b.region
    LEFT JOIN cmr as C
    on a.customerid=c.customerid
 )

 select * from cust2


{{config(materialized = 'view',schema=env_var('DBT_REPORTINGSCHEMA','reporting_dev') )}}

select product,
company,
quantity,
max(quantity) over (partition by product order by company)as max_quantity
from(
select 
c.companyname as company,
p.productname as product,
sum(o.quantity) as quantity
from {{ref('dim_customers')}} as c
inner join {{ref('fact_orders')}} as o
on c.customerid=o.customerid
inner join {{ref('dim_products')}} as p
on p.productid=o.productid
group by c.companyname,p.productname
order by p.productname)
{{config(materialized = 'table',transient = false, schema=env_var('DBT_TRANSFORMSCHEMA','transforming_dev') )}}

select 
p.productid,
p.productname,
c.categoryname,
s.companyname as suppliercompany,
s.contactname as suppliercontact,
s.city as suppliercity,
p.quantityperunit,
p.unitcost,
p.unitprice,
p.unitsinstock,
p.unitsonorder,
p.unitprice -  p.unitcost as profit,
iff (P.unitsinstock > P.unitsonorder, 'Available', 'Not Available') as productavailability
from {{ref('stg_products')}} as p inner join
{{ref('trf_suppliers')}} as s on p.SupplierID=s.SupplierID
inner join {{ref('lkp_categories')}} as c on p.categoryid = c.categoryid
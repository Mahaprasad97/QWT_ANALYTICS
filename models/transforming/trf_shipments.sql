{{config(materialized = 'table',transient = false, schema=env_var('DBT_TRANSFORMSCHEMA','transforming_dev') )}}

select 
ss.orderid,
ss.lineno,
ss.ShipmentDate,
ss.STATUS as currentstatus,
si.COMPANYNAME
from {{ref('shipments_snapshot')}} as ss
inner join {{ref('lkp_shippers')}} as si on ss.shipperid= si.shipperid
where ss.dbt_valid_to is null
{{ config(materialized="table", transient=false, schema=env_var('DBT_TRANSFORMSCHEMA','transforming_dev') ) }}

select
    cust.customerid,
    cust.companyname,
    cust.contactname,
    cust.city,
    cust.country,
    div.divisionname,
    cust.address,
    cust.fax,
    cust.phone,
    cust.postalcode,
    iff(cust.stateprovince = '', 'NA', cust.stateprovince) as stateprovince_name
from {{ ref("stg_customers") }} as cust
inner join {{ ref("lkp_divisions") }} as div on cust.divisionid = div.divisionid

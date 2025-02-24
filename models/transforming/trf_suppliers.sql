{{config(materialized = 'table',transient = false, schema=env_var('DBT_TRANSFORMSCHEMA','transforming_dev') )}}

--Convert the xml format to normal columns.

SELECT get(xmlget(suppliersinfo,'SupplierID'),'$') as SupplierID,
get(xmlget(suppliersinfo,'CompanyName'),'$')::varchar as CompanyName,
get(xmlget(suppliersinfo,'ContactName'),'$')::varchar as ContactName,
get(xmlget(suppliersinfo,'Address'),'$')::varchar as Address,
get(xmlget(suppliersinfo,'City'),'$')::varchar as City,
get(xmlget(suppliersinfo,'PostalCode'),'$')::varchar as PostalCode,
get(xmlget(suppliersinfo,'Country'),'$')::varchar as Country,
get(xmlget(suppliersinfo,'Phone'),'$')::varchar as Phone,
get(xmlget(suppliersinfo,'Fax'),'$')::varchar as Fax,
FROM {{ref('stg_suppliers')}}
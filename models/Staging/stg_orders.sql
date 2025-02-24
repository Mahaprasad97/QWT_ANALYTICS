{{config(materialized = 'incremental',transient = false, unique_key = ['orderid']) }}

--Full load/initial load
select * from {{source('raw_qwt','RAW_ORDERS')}}


--incremental load where source and target table is compared.{{this}} is the target table.
--SCD-1 Design: Upsert
{% if is_incremental() %}

where orderdate> (select max(orderdate) from {{this}})

{%endif %}
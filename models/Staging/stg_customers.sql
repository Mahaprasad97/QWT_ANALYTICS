{{config(materialized = 'table')}}


--it creates a transient table at snow. to create permanent table, use transient=false.
select * from {{source('raw_qwt','RAW_CUSTOMERS')}}
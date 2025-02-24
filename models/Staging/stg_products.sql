{{config(materialized = 'table',transient = false)}}


--it creates a transient table at snow. to create permanent table, use transient=false.
select * from {{source('raw_qwt','RAW_PRODUCTS')}}
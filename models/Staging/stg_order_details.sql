{{
    config(
        materialized="incremental", transient=false, unique_key=["OrderID", "LineNo"]
    )
}}

-- Full load/initial load
select
    od.orderid,
    od.lineno,
    od.productid,
    od.quantity,
    od.unitprice,
    od.discount,
    o.orderdate
from {{ source("raw_qwt", "RAW_ORDERS") }} o
inner join {{ source("raw_qwt", "RAW_ORDER_DETAILS") }} od on o.orderid = od.orderid

-- incremental load where source and target table is compared.{{this}} is the target
-- table.
-- SCD-1 Design: Upsert
{% if is_incremental() %}

    where o.orderdate > (select max(orderdate) from {{ this }})

{% endif %}

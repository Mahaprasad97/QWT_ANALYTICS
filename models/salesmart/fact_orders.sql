{{
    config(
        materialized="view",
        schema=env_var('DBT_SALESMARTSCHEMA','salesmart_dev'),
        post_hook="use warehouse DBT_PY_MODEL",
    )
}}

select *
from {{ ref("trf_orders") }}

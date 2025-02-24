{{ config(materialized="table", transient=false, schema=env_var('DBT_TRANSFORMSCHEMA','transforming_dev')) }}

{##dynamic min date and max date input shared from macro#}

{% set min_date = get_min_orderdate() %}
{% set max_date = get_max_orderdate() %}

{{ dbt_date.get_date_dimension(min_date, max_date) }}
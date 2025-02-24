{{config(materialized = 'view',schema=env_var('DBT_REPORTINGSCHEMA','reporting_dev') )}}

{% set v_lineno=get_order_linenos() %}

select 
orderid,

--using for loop for programming via DBT Jinja code.
{%for LINENO in v_lineno -%}

sum(case when LINENO={{LINENO}} then linesalesamount else 0 END ) AS LINENO{{LINENO}}_SALES,
--sum(case when LINENO=1 then linesalesamount else 0 END ) AS LINENO1_SALES,
--sum(case when LINENO=2 then linesalesamount else 0 END ) AS LINENO2_SALES,
--sum(case when LINENO=3 then linesalesamount else 0 END ) AS LINENO3_SALES,

{%endfor%}

SUM(LINESALESAMOUNT) AS TOTALSALES
FROM {{ref('fact_orders')}} 
GROUP BY ORDERID
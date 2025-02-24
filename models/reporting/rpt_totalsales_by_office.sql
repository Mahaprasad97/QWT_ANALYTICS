{{config(materialized = 'view',schema=env_var('DBT_REPORTINGSCHEMA','reporting_dev') )}}

SELECT E.COUNTRY, 
C.COMPANYNAME, 
C.CONTACTNAME, 
COUNT(O.ORDERID) AS TOTAL_ORDERS,
SUM(O.QUANTITY) AS TOTAL_QUANTITY, 
SUM(O.LINESALESAMOUNT) AS TOTAL_SALES,
AVG(O.MARGIN) AS AVG_MARGIN
FROM {{ref('dim_customers')}} AS C
INNER JOIN {{ref('fact_orders')}} AS O ON O.CUSTOMERID=C.CUSTOMERID
INNER JOIN {{ref('dim_employees')}} AS E ON O.EMPLOYEEID=E.EMPID
---dynamic country name pass by a variable declaration
WHERE E.COUNTRY = '{{var('v_country','Sweden')}}'
GROUP BY E.COUNTRY, C.COMPANYNAME, C.CONTACTNAME 
ORDER BY TOTAL_SALES DESC
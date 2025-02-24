select orderid,
sum(linesalesamount) as sales
from {{ref('fact_orders')}} 
group by orderid 
having sales < 0
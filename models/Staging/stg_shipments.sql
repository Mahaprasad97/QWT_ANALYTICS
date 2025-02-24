{{config(materialized = 'table',transient = false)}}


select 
OrderID ,	
LineNo ,	
ShipperID ,	
CustomerID ,	
ProductID ,	
EmployeeID ,	
TO_DATE(SPLIT_PART(ShipmentDate,' ',1),'MM/DD/YYYY') AS ShipmentDate,
STATUS 
from {{source('raw_qwt','RAW_SHIPMENTS')}}